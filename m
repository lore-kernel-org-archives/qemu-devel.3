Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E82EA3C23
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmvq-00067n-I5; Thu, 09 Apr 2026 06:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvg-00061b-78
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvd-0006RP-M5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:07 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397VA3c3825230; Thu, 9 Apr 2026 03:48:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=2VHC3P/bXaYsE
 01I3LT0ljOedB4gA6bh/mWWEzNuVbM=; b=FvFF9GzF2YYDqRlMoNYRbuQsGEUzN
 fpxuF+DNmst6HCqleNBwKyCFVI2NOPylSSaS8RlUQjtdYOl7nmz2AYIUyCsnvaLs
 vZWu6i6kYGAsO0uGRaVpmb/8ABjyEsCJeXBXH+vX/rgM9ofiHjbQjKYyY9p7MUnI
 sQitEpaJH+C9EmZWzr8SLGp0UBIvRVg2nca+Q0C03lJ5Fs6G+s9lPkklKYjrlkOO
 soroTUBOJ4bpf3tE1cQQPlCLvNzEHVSVtVw4NE0mm2ZBw1a4E4Kf/xrS5nTm6mtZ
 QJI42lqgXD7h2ael2ZhCnXWWo+dYt7oEjFplctSBAzoin+ErKYUXYbgrw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021085.outbound.protection.outlook.com [40.107.208.85])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ddutasxq3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLTWvM6Dgp0j4V1sR3Kfura34VCVm226LKTgpGBumwCXVLjOkdNhXEXHmeHGk1akFnnyjeQaNbPLWaMAIlvMAxlP7JN/K/u6qOdhennJtGre9xF8qumkYkENjc9OAsAAsrhUb03oY+ATqrSZNK7Lr2yw3Fo7xANe4gI35QT0ABJH0BENe6+o955NurarQ8yERecKpjY/h8Di+1VtSPsftWgJtvJ4BQIKGQQanDrRorPU+KGMqB1gtVWQ2Zbyv3JLqclI7CZeyuWQ+iYzNgV0LgE9pX5UCK7ZhNi9v82hfANLZYNB7gm5yTA4a5le9KGSvA4XDDGk3N8PXi4hyx8D/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VHC3P/bXaYsE01I3LT0ljOedB4gA6bh/mWWEzNuVbM=;
 b=jlFMpxaLd1DpL/Qk0Vj7cUTfXXLocHnj3nZ2Tu1ArMTI6rO0/6/iwJNSNfy7fTwZqh9oIlLchCEfHYQ5PoOi1hDXfgFtWIfaWyNpYNWJakMkZ63u47kAGJVxZWbi+FzHj5/hD3xxgPFO03vdB71PMPpAaGFehkSWc0+471P6DP+a3HRMdVF6OfSPLG0m+9+kQViR5ZqPeAx8fwbV+DyXdiXGEx+0QPYZsND8/gtOhwubqZV3wVuRMxFC02rZ6+EYzgT2G85D41V6MwUAO++9ya4jvHULyu2ZH7/raX0rIlLh5mdPgmTK0xRliON6TMopJs+J0nDlKhgw1fI78vovUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VHC3P/bXaYsE01I3LT0ljOedB4gA6bh/mWWEzNuVbM=;
 b=ww52eYg1JpYFFPWQnGa4d7dvFo9aBqDuaSfkmk2FCiNvG/aE8xoXqr6TVT7g1hk5nZ2zteuLPiQcBGjx4hTwD3/bPsVPcAe5AYP4LYUYRS2xCcxBcqHqP8bbpAKNTrzgxeMUXvd4h6pepdYaJcRCSmmHtkO3Dl4j0MNzstxitSkwc1FRLOROOo6oOe6PNYEIgAjZ+eFTIjDe+74pH76UjtZHGwXLr7bFYGpB+1c6nPHpbJ38zJKZN0gJzcejpCwrJXz73vQ10Vf9q6YA+vMkcAur2ELJTPjxf2VORpSZa4Sj6NQCpAgS2dl78SeVY+75Qqw4jWMDPwpBSmdPLIuM4A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7597.namprd02.prod.outlook.com (2603:10b6:a03:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:48:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:48:00 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 0/3] vfio-user fixes
Date: Thu,  9 Apr 2026 11:47:53 +0100
Message-ID: <20260409104756.465294-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fc93d7-d99e-4a3a-c09d-08de96257791
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VKqF1YUtlt42NDGOasrCbQoB8vvLreMPn/IBz2VUrUwo6OVFMcbCLX2MrCq8iwxpMWkVZO6qSWmQr4cxInYdEQEiNzgO97KONgZ4xEVgDMAOHHrtDg6NmM6EbLEoVQZXCN51VpbY2zjPw5VjYm8hiohjZH3n3yfDsoB4J3cplgcaEimqflT2Shh/cdDlAQ967CEC9PxIjpM5OQk9u8vtcNNbzrHG3fYmVQuZ0HF8I+/UIionIWjH2weTawaq1X0pR5Co37n+FyaU6cmgjnSP2jQJfBXd8LcXyAvDahdcZssC7Uvj3gFs/2JdPpPJpyClVLCgguW+P8pKNU70xkIRWWWukN9823ipBdLFG3l/bWnTPlFEWxwbL9xYWOkTb1b2tLDS8QnkjS8cpmDNLhM+LEa8KqnIqPW9kcMeYbZYFRFr5JyAKrBdu509Gt/tWE5kKWoykZ7kbOIbTDPBnD7HeFKUHMbTpt1imUP8W05W0NGeZrfRGR4Cqt3Atsg5iwm3bZlOqCtWQg5gpSs/RNg6qIU9YBboBTpOsEDrT3ulLiBk58TQhZr+cRymHkjHPDvKD0C1I1LjoZCz9CJ2NnCYkBspCiE7TAvujUYVaaSH9SIqIpTJsiTWfX23OdoIjhYXtuHD6hML4jG5DAfb5kofr0Dn0okLkyNEE+u0nLwZ7JxNz3mbtleOxqab+R2Kx+aUgSveysxNXKKG9D0NkG46fxe4XzD2JE45rCOEejZqF+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJUU0F6Lzl1UlBNV3U1OGViRnM5NzBLQlZ1aUM0TnZ6Z3NUR2M3NmRwa1ls?=
 =?utf-8?B?cGNuQStqNnBDeGU4R2xzN2JhRUxnczhMeWNLb2Zydk5WbVhqcW9GaUJ6czV6?=
 =?utf-8?B?MmFvdUhlckxPUWthQml2L0JrRzFWWnlCRVIzOW43MTYzcWgvTWh5WUYyMWdU?=
 =?utf-8?B?SzBZV0FVMUZ1aTgyU2R6Y1NMLzJpQlczMDF6ZG5XUEVVWGs5NGRWZmdYWDlk?=
 =?utf-8?B?d0JqRDUxMTlXS01rN3ZDbDlzd2Y2Y3NOWVZ6R1EwN2pqZ2d2cHNsdUVLUXFE?=
 =?utf-8?B?RkJUdlk2VFA2ZGJBTFFZNWhKTW41UitDRjZPRHdvNitDdGJ2ZllxUDlUaXBN?=
 =?utf-8?B?UWhyQ3BFSW9MSkZucnB0aHZDV1BscTljR0xKdStpNmozWlNla2hPQzNVazJR?=
 =?utf-8?B?US9DSVV0VVk4M2FyMW4wOVNhaVlQaW9pZ21GL3JnKzQxQ3dmQjZzcEY2T2Yw?=
 =?utf-8?B?WWl3R0dtQjFGcytsT2R0bnNaZk5MRklaaUQ1UDB6R3pFR1lJTXBsTlNZekgy?=
 =?utf-8?B?WG9MdkIzZkQwVkdqK0s1a0F0SGJEWUZja1dJR2c3TWpHb3htWWFOMnVhQnJX?=
 =?utf-8?B?MENjREZzWGJualdGV2NGc1ZFVGpaNXhteFVKbVE3WWJVUWlFUFMvZWg0djBu?=
 =?utf-8?B?R0djNEsyMk9vc1hQUWYrZXBCbHFKZi9PbzZhVzQzSDFRR0s4QklGbmUwdXRl?=
 =?utf-8?B?V2MrSVZSRkFPYUE0ajNwUDVNYzY1K2FGTm5sUWpzWlF1MXlaMFlGbU5sZkxp?=
 =?utf-8?B?MHlvRDM5U2NNWURkUmZ2ZldIUFpjZ0U0T1hzbWtjWFdNVytORnI3S2tsblhL?=
 =?utf-8?B?NkIvTS9zc2N0TEY1MCs1RHZtVCtpN0R6RG9FZ3dHcUl1aUppT3JaSmtEM1Js?=
 =?utf-8?B?bXlTdmRoWlVCUjJ0K0o3S04rUDhmRkNoWnZtaGlnTWoxb3pKTjdwNGJqTk9L?=
 =?utf-8?B?Z2I3cm1lVURWWG5NM0ZtK0xCaFFNallBMGM3SHo4eklnTmRJNThCRFVwN0cy?=
 =?utf-8?B?SDY4MTFEdnBIWTJNTGg0T2Rpci9Va3U2OWMvZ09xeXlvVlpOT0pNS2FOMTFU?=
 =?utf-8?B?NnNzRGhKczlQeGtxMUJQZDE5U2M3WWVtakRmanNha294c3RYeFhmSjM2dkF2?=
 =?utf-8?B?YUlCazVkcGRBdFlabTgxRG85RXoyZWVzNjNzckp0NE9EMmJXbVhiZEovRE5l?=
 =?utf-8?B?S2ZTNWY5U0R3Q3MyYTlER2pDeXRBeGNremE5TENhRlV1aVpFdUx2Wkpkc2NC?=
 =?utf-8?B?K2pNR1dOd3E3TXlld1hrMXh6NjBBQzZJYU5KYW0wRkNzSHZIYW9JWFNaZThX?=
 =?utf-8?B?Y2l4UnY3N3d5UUNTRGc3ZTBCUXhQMDVURGt1dEgydjFqREQ2NXdZY0FkaHB5?=
 =?utf-8?B?UmNZSTk2akxOUXdwNitaVnQxMjM3bmpRWUQ4Yzkzd3VKUkpZM0VMbkRZRlJ3?=
 =?utf-8?B?UDhjOVRhSklrQXNiNGNrdWg4eEUrMHNVYnVvdHpuRTJ2WVRjMG5PWDk5RUk3?=
 =?utf-8?B?bzV1Ui9SUFVtMnNveXNqN3g5aHh5ZG5MblV4YUw1eGljRzNJZUdYaFptb1BI?=
 =?utf-8?B?dSsvYy9TUFF0MnR2THFvbHBtWDlaR3pNZUhtbmpvNVVxZG5WRTBJL08zNzdU?=
 =?utf-8?B?ZnpZSEhLbVQ0VHVPVFYzOWJlQkVPTStXYWdzdGxhKzFTOVE3NGl0WTVwaDRJ?=
 =?utf-8?B?YUE1RDNNemxJMVBITHNGNWF1cGRDQ3Q0dUVPMHorM24xT0Fkc1ZISmowWnNH?=
 =?utf-8?B?NnRZaVFYdUZVclJYNjJ5Yi9FcDhNa2FXdlY0LytYUVlFQUNnMDVEVG51Y21Q?=
 =?utf-8?B?RWQrT3RWMWo4M2RvMEo3ejJyVGNrSHI2TEtoeVVVd01OVkhYZlhPRDlTUWF2?=
 =?utf-8?B?MVYzWTFmOUxqOXAxc0lqb2hnK093OGpiZDdHMk1vMjhxajJia3ZzZTZiRmVx?=
 =?utf-8?B?Z09SSjhEalpPeDVyZ3ZOVnRXRDNKMHNNU3FBeUFEN3lxcm9uelNmL1NpREdK?=
 =?utf-8?B?cmllVi9uMVZNSWM2aDhrMHI4amVuS0Iwczc2T1J2cGJkb3RmTlJUb2JpRGVG?=
 =?utf-8?B?ZkZBQUZpcnpQNWNZN0daZDNHd3Z2dUsxS0xxRnU0QXFGdzY3OGR0a0tuWjY5?=
 =?utf-8?B?ZXJYZDNOY3JMaVF3MHBrYjljTTk4cnBaNEdDZTVKWkFscE1Hc2JjRWZjSHZZ?=
 =?utf-8?B?VlhJbWkwK2ZpUXRaNjFnUGhRU3g2MEhnSmI3S1RraUdzdTJrNnNLclRqVmZu?=
 =?utf-8?B?bE5iWVlXQ0R3N3JaUFFFUlk2N21NQUlnUWZMQU9taUF3NVhDV1V3YWlGU1hU?=
 =?utf-8?B?U2cyU1RaUGNuVmFrWnA5NWZpSEtGOFREdjBzUlVac2JJV2xpQTcwQT09?=
X-Exchange-RoutingPolicyChecked: FvLzo0YWO8a8gW30b/F8pvVHbxMcdLKi9vv/hbPEIuYqAmAaIf7OLCMASBKUTDOtwjxtdojA2anI7Xpu2TRfTufffgin2CK0oLnG4uyZnvDZhQdsXxmuGo0+h+yyX3mo7263AjeepJSbYQ+gw6EL3BfojFdKpISClHhLBv4kXd6sHvKfiBvTRDCiO/U1aZlt044s4FIex1aUsBpCp28scT3LipuQX2hGt8EpAQKWAuqJ4yETQwMTHNF5YS78ap02Vxgp3vokmHsJ8ATgTwe9/EuDrpEu1zCpj7zK3bEu4ZPdbsd1OjX+FAiP7oFtaZNwGg9Y9IWCfm+x0AqkM12BIQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fc93d7-d99e-4a3a-c09d-08de96257791
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:48:00.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLgdyJl5PIqLBd772k8dQTAScGy+qRVErvzRjmveQlOwF6hBkDly34WR1W8CDLq1iadsui88jdFetTOeic2FGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7597
X-Authority-Analysis: v=2.4 cv=StugLvO0 c=1 sm=1 tr=0 ts=69d783e2 cx=c_pps
 a=XA5JAPkejx3wACcd+9zdpQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=yKlUySf5qK-JiufbxiwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I4TWSdp6_8MnHfo99F5g_zH425bfamGc
X-Proofpoint-ORIG-GUID: I4TWSdp6_8MnHfo99F5g_zH425bfamGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NyBTYWx0ZWRfX98AaISpkiCFJ
 v/vq1byw2/5+LoS8sUN01C3tS+xMQ2vcdqAgFouO2YhhqTMATFj/noHEder7tcaKHuWF67Rx/oD
 pbK28bayU362Qv360Vpjb+GZMpabpPzCEJoLpL8V0ldjlY1LYv8GgNNMu/8VS6Lz/jBtTyNEXfM
 2o/u+lTTCIY/0EW7jb0K5Nba8QOQggrtVs6QHJf/EoC/Mb8diG7ArVlM0mkogqeIRKbs8Xn7pEE
 hBPxW5eYouHZv5xRLCRGeaLBDm2udCJHiPGrYUJXnLTkCmSomrwyAdV+MnDkm/Bykg2WqcDX02T
 RTFngHLtaROsYB/LnlT2fOMMzLEbVu+E2QwN2l1QY7Wu1HcUZlmwJcIuRMgvkYTw2/1bo4GFMEa
 Rj2WwSTXzBA6ZEChIGQR+UzehICS8kcYQpqr+0AelsOmxq0iEgEvtYbJ869p58Ra+3FuymYQ6KG
 a+ZxChLtHdqvBvM/zKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



John Levon (3):
  vfio-user: support VFIO_USER_DEVICE_FEATURE
  vfio-user: correct protocol for DMA reads/writes
  vfio-user: fix DMA write reply

 docs/interop/vfio-user.rst |  8 +++++++-
 hw/vfio-user/protocol.h    | 14 ++++++++++++-
 hw/vfio-user/device.c      | 42 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c         | 30 +++++++++++++++++++--------
 hw/vfio-user/trace-events  | 23 ++++++++++++---------
 5 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.43.0


