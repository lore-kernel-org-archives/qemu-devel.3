Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8E6CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPbi-0006Kd-Op; Wed, 24 Jun 2026 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbg-0006K8-Rv; Wed, 24 Jun 2026 11:33:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbf-0005yP-10; Wed, 24 Jun 2026 11:33:40 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEgpVV2494771; Wed, 24 Jun 2026 08:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=H6LGWe1wYYnyC
 o23XIqqxKeC5SwYSq2p2N4IALZ0bOo=; b=BGo6KlG19+kXDAd4P3JDTzZuwTdQ5
 +AvnMFOBwmoTGfLkgK8mhirLM8YTy0MvotfP0EZvHSW7jzK5g5Cx0rJqQ61Vs6kj
 pimiPUmcc3yxbtuTBMMHoblznDhmPe554jikOXnys2y558CMUHKKtPBsts9qomDM
 okQeFCMWokPbMDd6P7aFv2QxYtrOE6uEFU7LhLvnFpJ0vfFxi3YgyW8cDsalHyI/
 4MsKsoTkrtn7mMYDpKrIcH3LTww7cavAOpjx07aAHz53pSA7hFjCz1QEsVS911hx
 cBonvF03L9Ue1+ui4DTSLJueVSZeG35z4ShLqTqUOfcJy+CGh1i0FO09g==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f006t2cec-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlgUR36f2MwwiMqMnexnm8RC9lnL//wh9WFzgnVrEY5vuLfVDgV95Diqd1+UdYqzU72bEopl3V70FYbT9flk9Kusuotbf5N7oSDieJk4dB2ecVR2ihp4adEe10IRAC7ofURlDhUvEdAQVCApqbQKoi1pZ6Ke7dGPAZbIf9LR0x0we7IjrC5DeCA76I6T5sCNRwag6g6ZvcCmpijhJLdBACEg0NhV3T2YpLXgVSF5ERi6SejPBeMkiZpSKj4yn/M6U3gh7EN7LK48cn7T2dq9arvtL/xSSgQRxjPYJ2oghRojA8RzVJugOnBEt3TvnD71f00s+rHMWC1+D1toa3E+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6LGWe1wYYnyCo23XIqqxKeC5SwYSq2p2N4IALZ0bOo=;
 b=EbRR5kYGqJNZ+I/NgoxZVfb2yRXNP9VTx51k5SWydqeO5U9LojtC43+awLsGjWDM+d2ViJS6TQXRqtTUaraYADmsq6oW1yAJeshjT44sVX/vPVKsswX3kH9VtfOr6C1ntA9jAHi1WcdnOjavk1MufpQFS6nGb47UTHN2X03N1NZa0o/muDZM/tz7/aWBYFVLBtPX+WbahV7wjqoQgk/u4Vf8oMvfmFgUQBaCE9p7oEqaqr5+Ag35hYf4sANsKcWoOGF/94MUy/Wf6AMva5PvX1p88iTGSTIN2ddw4nW5lap2fwDKFtrqzZEf0rgLl1gmiZUSa7fZ35nhErD23eps7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6LGWe1wYYnyCo23XIqqxKeC5SwYSq2p2N4IALZ0bOo=;
 b=sG/Imv8TrdmFKA59C8hYbrNAfyam/u70KMf6I7bM2nYh2JXAqVZIFqkSZlezO8845OKyeR4N0uqeTZKHoCrhY4VN1+v2kT6XrFNSEs3dcZ//cGSdLoqQJK3EIYcFF1M1w1X7DBZmVKqEWo0xq772sQegg74IOD4nS8UFUA9hB4TTO+PAcfZuAG727HUioEviPz+rS6o4glq0reZwbg+K41ICq7J6icwxXvRvnwpUk1Dn6l5ykK5avuYgVCXPbNMER8lWoAUFW7vft8tKqjL40DTmIftzqtS+NKnTLrlhOUpI+QYi9tOX08mwCkOZmacYWAlP20y88yvVCK9iY0SMHw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN6PR02MB10656.namprd02.prod.outlook.com (2603:10b6:208:4f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:33:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 15:33:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: alistair@alistair23.me, peter.maydell@linaro.org, kfting@nuvoton.com,
 wuhaotsh@google.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/adc: convert object props to class props
Date: Wed, 24 Jun 2026 16:32:28 +0100
Message-ID: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN6PR02MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7715a9f8-b573-4150-9190-08ded205ef10
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006; 
X-Microsoft-Antispam-Message-Info: FsMERo6+uQexi+IDD6oMLphc4C74+erOrt/vKuB6S8ZjkBcBFu+SFC5SbfleC4oRNbvWQytyWL/GZ/8elIN1RXOFFxzpyDNWW74bj52cCIapmS6cXZvP3rFu+OJemHxIrVOyXL0khDkWizUWIWK3e7suIFz1DWMAZwHPepdsUeGRR0Bvcf9xEXT48oEPaGShB0MSkcTstpUnAlSr2hmnFdlE79WPhC0wSiOwRmjBT2+F13Cph9TIffqOC5UxtUZffvvQKNEyT9n+2p2rTbKNzmxcstRkxPXTl2rJgH11ZwYuU3CfhmeJ6+LDfxm7NuisnU3Rxmg5WbOqZh1VAvrMWb9wto1zy0cpV/MBy7kvw0uArv9MVsbiQBx2JM7eY2hm4LpoTrydXvuk131yA327xUkRiQbqzmmCBLwLgl4BNk/Qb9Mw75gXveGUgxytjICbNfvbq7cp0ItGl4OyQrx6R92LN/x05D28yAQPJ9l7Q+qcSEuatPOHeZp4/BF1E7iTOI7E351/h8N3irhSQAhy0fRXT+ImIvMXDHB2fPSqashvsZcfL2NeYWc8j3cN4B8mX0OLWJ+bkPyDjpY2QpKqXABYYjgA/DnTHgMvkkmrRAwMxCQctRllpaTyis85yBXeVpqt6N5G0ve1tl08HmE8CnG5v1hZjM0F5Yc3ENCTdMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jts3eveVYCvyS+dBFQ361k0zBRfFWi/aLkOTDS8iZeFukzTK4nn0xFjodsiM?=
 =?us-ascii?Q?icfUMSUk9EGlZ/dYQ0Hm5M5jbWZQVo5Se8DufviOwn+R2xkPJr3pW/tchVnx?=
 =?us-ascii?Q?3kv/ZJkap3Z4bbIt5rWwYT1j+Pk0iyLAlIP8X3ayGiiwS6LB8gPV2P+7RrcQ?=
 =?us-ascii?Q?l3y2sV5OGkKPQ5RejaQhk0juZQO529xwSnSN6fvi72no4f6EC56OeHjYYGlY?=
 =?us-ascii?Q?Dyz9dMAWWEX8RevJPn2UYXE8w2/fz0dYn2UwlI//qjSbXbWSBJYOOtmoscG/?=
 =?us-ascii?Q?/3+CaXmtO8Hi4YzhftysO2T2CrX1AN0L5WTy9eDVvk1L9zLp7PgpFzfkkmYo?=
 =?us-ascii?Q?25qgj3T7o4t7moL88U7FV5fEsh53R+m27bPIaDT5gGyhsFSyPeDdqK6tYsNu?=
 =?us-ascii?Q?UQDSlwFpsDn8LZ74X6XA3CB7rzs3G+eGa3z3HgCDTx+2eMM+F+q/1Za9TWTf?=
 =?us-ascii?Q?vF4NcRMdfMxeXPmt6ugUAyuNXHL23O+J/EvVPHXpOtKIniZreZMl3aGtUOtP?=
 =?us-ascii?Q?LBm4uxaDP89FAX7pOi7XmoTa4MgUWStolcpcW0PDVYEWqVLTrc4L7Kp6A22T?=
 =?us-ascii?Q?GkXZbIitEsyCTmfUKirsrjV/VPkYbmLYUWH95UzPHuj0NYc9qtiVHcbObWP8?=
 =?us-ascii?Q?9gHkSPTYJCrT7JoLF4jGLD44ob8ciHUmFxVBLDHKflEhlau6xPNpgPLNmdaz?=
 =?us-ascii?Q?C/aLGHEy1LHIqIGceOZCM/Rb2rdO6aBgC7KC0+bD1meMf0zBfL/P5JwINAeh?=
 =?us-ascii?Q?rXxLGw1pRwtM2TpD6EjNUQS9MatjKyLcqHvkqGoqPQ93R/xFvYNPflC1m7T4?=
 =?us-ascii?Q?Dl60UgH6NSb9jenOnuIrvwRsv1d8oDEeTDAjy4smM26DikXqn2/KrBWxVW+d?=
 =?us-ascii?Q?1VNLWP8uO16PoxpmdyuDbvc5ETW2Lkj7pBEy2RW+5EpCWvidYp7tsYV4V4FB?=
 =?us-ascii?Q?JqWL1jrNuUkrrHr00A7BpzCdJ8GK48QGlbiBU2Y84E/fXdjz1VvQ4VsJy8T5?=
 =?us-ascii?Q?RFMFd5swGuqgbB/GFtlrygcxFgmj2Q8WWgogTJTdqcHsEsk2gh3t98YU2MP5?=
 =?us-ascii?Q?GdHBR7c01SvZ7/0ZMJDxwB+7bbMPqmrAJaR17okOad43ZZDVlcYlq2nLeYqF?=
 =?us-ascii?Q?2BoP9KJ+F/fNc538xgbwEoB/tP8tysLnDHpPkJXYpKByGMjqQdyF+h2t138J?=
 =?us-ascii?Q?O1vHmLW8cR4Gdj+hOcn2dKhjzrRWQ8PbTG7X3TnqlfguGrNQR9l2rPkGbmOf?=
 =?us-ascii?Q?FC/igP+4DjF8y+4w3HTrFip68PJ/9zxqZQHdKe60ZzM+qooSPWTDWacQL/as?=
 =?us-ascii?Q?3ESDvoIL3W89QVea9xgSKdeqGwhG1mRddA7P0nvVKzuSUGOf4hstCZx9GeVd?=
 =?us-ascii?Q?0TjiREeNf06NIuBpSXOCQHbMVOMGGqz22J1+mnxeS/yaoCJCCbK92lDzXqUI?=
 =?us-ascii?Q?b8HDLAmlD2aN1XDBI+XEJSI1ENskZzIIUJuI3tWcLr99LcEhNC64jC/In2em?=
 =?us-ascii?Q?RnBW/PGPLTo6XnTEgmoVBWH0yDNasWYiBK3Igg9vLmPfRrOVyb3UKDUVpPso?=
 =?us-ascii?Q?NzsKhogAEuQeMgZyDoSNfQ7mWEcBaFd0vqwLFNAOy93XTzIM9+WUaPVpfKBW?=
 =?us-ascii?Q?4EhfsjiIHrMJ8suaQ4gQCibYwcV0d/fNwKMOrFg0O7SfX+iL2V5pA6isfAn3?=
 =?us-ascii?Q?MFOlaoI1UB+osVN06NDK+6gpMxOtO4VAdq6zd6O64bcZZiWkxB/GgCzO0f3S?=
 =?us-ascii?Q?NSzwM77if9JeA3jc9E+gUQuFUAVLvGg=3D?=
X-Exchange-RoutingPolicyChecked: biWBL1ywTTqxGVfni0J7ZJKjFNgPl9ZsCnRT17hvjFdvgIHLaeVmqfKLjIL3s3W+YP04zZtJsP+xUc6bRLfvFu20SkrgOwrGawQGT50hrz8bPOHEF+W64JlzL/sEvTbGJWZInAm2uX65udR25GCHJ3xGtbGqvcXJR7lwvrcw7f4iWDcHgH8xEK6aJBXPutNEMt1q7aCD+W5xtldaOlrDI1AEBlszYN3/R0odgfkb9s9KvT8eVvvLcCcm0OCacAq/aBiKdQVGFmaI6Ex2PWJm+PjIvCOY2RZgutxmCZi4IWDhnlmKMOCYgIv9r0bpdjpAy6PTYbjZaLG7DRjXeHIIpA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7715a9f8-b573-4150-9190-08ded205ef10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:33:26.1485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7M6c4lNs9TpIcdNk7KNzfF3vnDGbmbqrrtlm9seVy07t4QBAZFx1CC1h+gaMiExATDECRPNeWADXrEOuFqvwL+plg/semPsGVMv2jwe1h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10656
X-Proofpoint-GUID: PDXgZKjPST53ZSTUeDqoJLY6SliJAZUU
X-Proofpoint-ORIG-GUID: PDXgZKjPST53ZSTUeDqoJLY6SliJAZUU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX1AmaKzH0HqSJ
 HaBpClyljz4njU8yn4LZj3ypaNmcypCcVDeUKLxuz+X7Yoezq1atMPdXwGRYJP0A/R5JCq7JMqF
 FE9fhpOBAAeAuU14+Y3UsHVwMVVnK/E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX5DQRIv2NZhVD
 9qYY0f3XHJmvGodDH1k/Ob2RMlVycgywJ40aeaf7rs7QjKTCeF/o7hh5qZnHzjXsx/+Q0HYFLIB
 kmpCezOP99RtziTAzq9ICLvodmC8iRmt9pIztPR072nOq+tybTnypXBak/2pT7axo7cV2cTxoRP
 9rN1/4EdgWK8Q52pz5hHbYmuSfoZKYlhpYAjhS5O8SFyI8stWSq445kEYtXFYcHBAOGJ5zpdIyQ
 Y0k7c/bHItdmsfFDaMp5ENfsOq4ZedPLXD7qBopdXLcJEFIpmjPK00dvMnv+Hsk+/Y94NH4/rkg
 GvgeDdOzGArpLVOU2B5PCH6sXwuzF803156xo2VvkDmzGx6Bl8HZaslKt4Rk/UZrrUno2tWGw3N
 PRgEEQyWf2vB/deUeMjJRvT1fSVPxElHmL8uKknxUFKTst6sz/DWJ+KkgNZtkC1Va9Yx+uk/7w2
 o0GEtHCMcXU58srQ3oA==
X-Authority-Analysis: v=2.4 cv=Xfi5Co55 c=1 sm=1 tr=0 ts=6a3bf8c8 cx=c_pps
 a=Oahh2kgEN5ymB8sO0SiNEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=Oov7GBWg82k6lRvLM3MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/adc to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (2):
  qom: add support for array class properties
  hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props to class props

 hw/adc/npcm7xx_adc.c | 75 +++++++++++++++++++++++++++++++++++++++-----
 qom/object.c         | 27 ++++++++++++++++
 2 files changed, 95 insertions(+), 7 deletions(-)

-- 
2.43.0


