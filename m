Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE09C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nCW-0004RO-RN; Wed, 16 Sep 2026 06:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9L-0001dj-S4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:46:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9J-00035c-E2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:59 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8K2Tx700459; Wed, 16 Sep 2026 03:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZeMvtYJ+Cvv28zu4IBYu7pIyvPvX3ma62mHZ983wF
 Q0=; b=xLAgrXQBvpMMlRIMejydplMeLlUcNQhnDk9FKs5pJgXApljCqGyBbKf3W
 mX1yXPj0Ag2xCyHMS0As0Rojf4vYPlKmkltqMQffeUE/aGmA/geW/i2GJhz18GDE
 RzPKm0Wz13RYkkcUp3ZKljho8utfYifpoMaRfMp5IAZLEXibq4k3aQRjYsctX5E+
 PnUT4hsZ6UW5Ma4TJ0FFJxsnCY5AmD40Tt82G+FOtC4ki770fa0pwwYFAMRMg86x
 Y74jLVONBscmdg+c25YXodHXcX8sZK5CDyxlbS6ZE1sfnB3ROskqctN1li4PCyUm
 Z0cS4Avn3v39zfBM2f6Upb7P336sw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021091.outbound.protection.outlook.com
 [40.93.194.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0ka9yp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9SkLQMVYi8r7PzJTGNlR0oQ+l0VIHdsVUlHqshmVWJjT17tlrrRrDBOppf8TKj12z1FqJhMht/tYqlHKEuq58z81y9OgEo5D4ObOxLC5uDvIZLctyeumtD31YgdiXfzudKKS5rMVrLqIgc9ZqSU7FHGkCos7yWvUieFh9VKkLeuyAfycAMQPU1oWkX2VUzWbbYaDnT+9GIjOpCEpOKdYsGMdQ88+29TNmvclb4iAKrDqOK+gNd4TabRYk03wgXhmXtAbjYqVFDXpkuFwJiN85K4UlTdnQBdB6jmUAVQeyAWkR+PYNtZxvaQD9mfMOO/S43aB+tozKUsKXifreFfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeMvtYJ+Cvv28zu4IBYu7pIyvPvX3ma62mHZ983wFQ0=;
 b=YO/D6yoLDm4+c+SN4oAm2UbYe4/D8P0q5BWbOfqJuJbXfzWCTnwTPLztA7HbtREQeJt6ozH5Kx1QseDLD4f7p7M//Yw01TUQKZYuE5R7HOdFj2lZ9NlFQa0zWdXhHRPUu0Y7z5QUK7K0DA4mASrtKVtBP89hNYVsdgKmRsYOJn9M4lbV7dm+v4wrJuumOprFeBAb8+92IeG95A/+/vpPWPEjUn7W+g9QbrWWUg1xkUJV0hjU9/RZ9BiSd1NvfmpChGjnXGiykAWP7xoCQmhvAGhW4AOMLNV5CfPalg6r2+AvEcgw3OpyMHNZx2qPR5BAG0VgC9PAnfik2hSnMpm/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeMvtYJ+Cvv28zu4IBYu7pIyvPvX3ma62mHZ983wFQ0=;
 b=NWLAE6ZSYivBF7qRGLCtXvTbKk1e8rgmF1dyhB6JoycJw4lbirQ8Y9BEXzDBaqFo+m+8GypEShklx7mWRTRB3LcahcHVoVc/rvfHnIW/suUxPcb6rJT5OXm4wTUQY7TIgJhyXdNb4r5/T3ogqVkSDuUa/rMBGzO+P7fCJ6yMfgKkmAnBX03qBpMnSJRl2PSqIfUdVqwryWBojbQQxEJJdYqj9eLn703cCkfI6axhgEGX/Hqj2Djik12OTCcMkuVkaezB+F7GtDLJZN5BnOqlpGN8J6V08If0vfUx8pcPswdhn1inSoCbUc2uM0UGvTXvHgtjWKXe5A5XDUblntc1fw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 20/22] i8259.c: switch isa_pic from I8259CommonState to
 I8259PICState
Date: Wed, 16 Sep 2026 11:43:48 +0100
Message-ID: <20260916104435.600211-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5431d887-b5c3-4e13-eaee-08df13dfab79
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: P+/w8UnkVOtGcFmBzS8Lh/apBY2tOSsqHthSUSr6kF3CrzQc0fslLKjI9UQPgINztRzpIpl4LDgBosczA4+Rlpk+9jEK/r2tdO9xknD/LZhsN4laIAFyWGg3kXzH+f+gm8pkWQjdSRQvA4i1mll4dVqi1WUKeXCbW/dakCmo7G1IkNt144R+alLFpVpHahgx3MdigstjD6PCurMIsXixw1iVC5F2G5yNVYinHvOzOcqSuPxdSy0tfs38QyJ4IocPjLfGRxPKXpfe0kbZco4iWFNIOqJnE/ChNQfQo4B0QsjA2SE+WYed04CwNN5luVoHCEwypXdkqqWZjSWRFyztPHHXRpA7LurDnl9eQHtmnB4mSYr8tETgO7KsB42+2vY/gf0fyQ09D0Lg55N4oD40vH9MUM1Hnr3aVAOeEXbJiQ06yeUIrUTFbeL+BR3jXAB85OgGCneVAhyq8k+oWLpXpC97i1FYUPliRSuEBJeEEY3lLtees9TIDwCz9BwGu+aJCbDG6c5hEi9wW1wkFTh/ChvdidODMwAgruTXdgEdE/g/lRl6wlYniAzQrkNLVYJYYdWdd9c07ZfGNRcChnAyMbMczb0COF5AaH8/7Fv87wTzj+8NrY8PwP/q7B3cNuNrbbDqWUy7DMpyXffmY5Y7mqKh/NbfGpHDcLa5ZKrj7+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEc/l7hHqXouIcnypTjVIgkkPL0uAUHMM3dBa/nmLKuhLfIqBOLvV2STaeaR?=
 =?us-ascii?Q?BgUiyMhPlhbg9Onj07uANQjewvjyxb0h4txMLIZ3n1y5WhT1agj4T1hbh7G2?=
 =?us-ascii?Q?cBvaU66v3u25u8aUxQzXidxwAU7zbr88HZm/EXfTQjZ3yD3hkqgCVVD75/gx?=
 =?us-ascii?Q?ZgHnhDJ9PpmMKAei7B0b930aSn5tnVKhyE7U2MwJklnsTBFZRSDFq1yet/3s?=
 =?us-ascii?Q?VebB34oJXE1mfQgGt7uuH4+Tvro2gF+AFarVyPNhyeEGVXFXOfDYAtD+3Kl2?=
 =?us-ascii?Q?WyCHct3r5USfsnja0nBuvG1y2nH84wFuiJfptRYikemoBr6/Vxtl1ft1T97F?=
 =?us-ascii?Q?BgsAbI8T3e/Bqix69WoIm62H9shCYTNN8VJoCVAXYQEMRydlYbr42D9Qscxi?=
 =?us-ascii?Q?xZMu0kWac59kUsKefN3wjH0RdOhE5wDH01XB4xKcf9oyI30rRwkpt7PmRgDW?=
 =?us-ascii?Q?DnW+NkyOhrOlRFrd+HdSWpqKkTsoLuc5WYhBgdd/rIbXLdwqhJ4aO9llG9dh?=
 =?us-ascii?Q?xm0rqq/rkWWqCpv20iiddz2yzk6hdFbDeh0H1rJUBJ2QEiQcqMd79DHtOiFK?=
 =?us-ascii?Q?LKk55dEQaoJtNND/fA08l70jbD8+yMACP+wPXrNrgVfGMmCBhcJaYWGB4L8m?=
 =?us-ascii?Q?ea9dSrBtGy0K36eUze5sx4BSpeoFqldgaMsIMPcqBw1/aa8swQWEoN+JtERF?=
 =?us-ascii?Q?4uWQZJm3/9C2dMRTBOw88qPibMN5BW9410D19c8QzO23ps5R3+6ZjU4G8ceD?=
 =?us-ascii?Q?FQrdzsfwRBR8j7I7aj2VbPwFbSZDBrI0y2q5CuMI2c3u2o95cso8f4XKPXr5?=
 =?us-ascii?Q?vgTGyM6r6Z8QvKZVJZ3WaYZI3ZuoIyFmAl2UzHANfDvNkXuaAtl10ip6dUy3?=
 =?us-ascii?Q?knFAt2EJd2vuaSujy8Tq1Ydb162oxA7qdH+baPvZrWqAJFNxye3xE4zUBqfW?=
 =?us-ascii?Q?CbYgdRBLOzmlGWRgvR+qNPPBOmHEFa2TbrlcpuP6Y8a839/CCQYQsewiIz/e?=
 =?us-ascii?Q?m+yIjHguru/EKh1hdYqO/cxfpE/2mpSwRrVj+oqL/1rQ6tnkFBg3GQaZziX7?=
 =?us-ascii?Q?dGPcuc0lisUX70ohM5oLNPi8MW1mcpfrfZ+/uu6nvY1jLiOyqPN9fYMazWGH?=
 =?us-ascii?Q?TuMoTUmKyfBm2DH/b5kyvWfFHUiNRClrgSqBfu4dLAQdO3UPXEGladiWDOn9?=
 =?us-ascii?Q?Mg3AWCGXGSLLQZLKVsoYSu32WKV1fYd0ccDTE7fah/OzyCrqLx+vV96WIJ+l?=
 =?us-ascii?Q?xnLMTev22VQiFv2SbBbn1PqAD8aLcN6V6SnBjR0R60UTICbHMT1JMXmLPBBl?=
 =?us-ascii?Q?m+iSoSzeodRizAHBbFF9JfxekJ7b3ZC13j8A3OngmV79QU/fcZgg++AsqdnF?=
 =?us-ascii?Q?y3iSsP6jhNEPVx1/LvYHFF2PfVHLpIf8Bo/1qCCgpFjdG4DdGvnshrFBV0eK?=
 =?us-ascii?Q?MiGfTTX1cyk4yKrkLr5djoBhN/KH38Yuo2B1vykxD2q9Aq1p+V177XL2km1g?=
 =?us-ascii?Q?YO0JWDyb9kvD3q1i5jVqMqWjEcxZw0OSOW8qbFqEbpwMZqjewrzPMI/jiE97?=
 =?us-ascii?Q?qAYrJLSC5b9TmmAqoFbxk6U1wOuL4bfrTPms6fM1LRBEbAdH7fDmQdsIv4dI?=
 =?us-ascii?Q?nscHcjDhq6w7sm3r5aGTT08JI+fgg47gXZs35LWn08oKeD4Yen1Q0rX+Fvl1?=
 =?us-ascii?Q?EvKIUhYMLtDuSRDcALn+W4nmm4bRZQfymRLF4JlkEu9PxOLOXOb1qBL610h/?=
 =?us-ascii?Q?OCgRXu3l//TGs3mnR6yMUqOJfkL5Bvo=3D?=
X-Exchange-RoutingPolicyChecked: 4LoSZwGOSopRjvuk9BtqVMPeptbaQCknnfCOz8NVlWqmmPs7GIFmALvgo+SEfguZP23cuIotiLX8vKYjJzOaYDrm/N4gsO+j2A4ilSFGF2/90ZQ0jjQQ14dpc/OCnFba3SEWfkwo3EiaqcZvtTNEbKU6povSxX87Vaqyz4shpIWWHIBV0tK7/3orO3iWmYKp/Vx94jdyLwVdo2IJnhcYV/jQ8ME9INx2Zg3RqF7LvG7I+mnWuob0u/QGDDc6oRsSsiGJgv6OlHyJFbY8FoIH0TvWIbB+kKenotmM3ys4JbP726vfAZnmG3v/iWAGE3s7QRQZjhtJ20LCqxPjW3vPqw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5431d887-b5c3-4e13-eaee-08df13dfab79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:48.8774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhxUdFXErCUb3KfsE/TFBklALqiK9b6XxLos0JG4ZrksHFjcBeqRRLbxgfezCifT/IL61IYBCjG0Q5h0ps0tXT6ekfQH/OpOXRoPF5zkVzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: tu4xethUYLRFAEBvP2RqVEcjIzydIsZy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX+p5bhSY0JrJc
 6WtzhaImHAGmjJVp78XM7+XLKedYJVGbeKtN8XzgHvnmlZqw7DvcUcowcspkGIabDWso0JuGjeu
 zzngcpLJG1KhGMDtDUqsbWFA6WP5oEQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX3Z9ESevNqs9W
 E85FFYt2pPe5Q3rObMJayw4OZYhFOjD87Re3zUH6bjiSMMFCCZeYioK13vvfDkAvYmI5boy04Lv
 4Pvvt6fQrAQJa+AubKygMSiUqOMNQJRhEnxFq+ItL4BkZjq+nljK/CuyoHrzsOL/8CtI19Mx1Sz
 H0mNylMQLwDLgonc6f3PvkpxjiKfsrEO0ao/9sAmm3HgOpJ4lhpzwAGoYQUq4WzYsfCtF8fXx90
 FAIy4oyWCIOl6UYx0c6BKb+XPOXTUi2dOzdhStQTCimxKM1F1IvFpIyWOi7g4nJVOdOgPg440qM
 NFMKv7qlLnWVLf6mD/FW/Ef1hOUd9DTHdAt47/fdMjsgExXm8d6uWZLJlsdH65gFcT4/u1YoWwp
 nxfp8gSOlG5j6EgZyF95clsPV2MiPWytXo7tQHMtoxvdZe7055uFSefQ/Edq5ZcyDlnWauSkfoo
 4Cz0DltuMuR0uobUmzg==
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6aaa735e cx=c_pps
 a=ijlDDoB9/djO8DkT6Rc3Rw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=SFRUhxsDDi52rhXrSC8A:9
X-Proofpoint-ORIG-GUID: tu4xethUYLRFAEBvP2RqVEcjIzydIsZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The isa_pic variable exists to allow the output to be fetched or read (fetched
and acknowledged) from the x86 PIC. Since this can also contain a cascaded
interrupt from a slave i8259, switch isa_pic from I8259CommonState to
I8259PICState and update both pic_get_output() and pic_read_irq() accordingly.

This has the advantage that a i8259-based PIC device contains its own internal
reference to both the primary and secondary i8259s, and therefore it becomes
possible to completely remove the slave_pic variable.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h |  7 ++++---
 hw/intc/i8259.c         | 33 +++++++++++++++------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 24237a4ed5..72be7c3de2 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -6,8 +6,9 @@
 /* i8259.c */
 
 typedef struct I8259CommonState I8259CommonState;
+typedef struct I8259PICState I8259PICState;
 
-extern I8259CommonState *isa_pic;
+extern I8259PICState *isa_pic;
 
 /*
  * i8259_init()
@@ -18,8 +19,8 @@ extern I8259CommonState *isa_pic;
  */
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_get_output(I8259CommonState *s);
-int pic_read_irq(I8259CommonState *s);
+int pic_get_output(I8259PICState *s);
+int pic_read_irq(I8259PICState *s);
 bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
                               uint64_t **irq_counts,
                               unsigned int *nb_irqs);
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index ffd09f6c61..3f10777036 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -57,8 +57,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(I8259PICState, I8259_PIC)
 #ifdef DEBUG_IRQ_LATENCY
 static int64_t irq_time[16];
 #endif
-I8259CommonState *isa_pic;
-static I8259CommonState *slave_pic;
+I8259PICState *isa_pic;
 
 /* return the highest priority found in mask (highest = smallest
    number). Return 8 if no irq */
@@ -175,33 +174,35 @@ static void i8259_intack(I8259CommonState *s, int irq)
     i8259_update_irq(s);
 }
 
-int pic_read_irq(I8259CommonState *s)
+int pic_read_irq(I8259PICState *s)
 {
+    I8259CommonState *pri = &s->i8259[0];
+    I8259CommonState *sec = &s->i8259[1];
     int irq, intno;
 
-    irq = i8259_get_irq(s);
+    irq = i8259_get_irq(pri);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = i8259_get_irq(slave_pic);
+            irq2 = i8259_get_irq(sec);
             if (irq2 >= 0) {
-                i8259_intack(slave_pic, irq2);
+                i8259_intack(sec, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
-            intno = slave_pic->irq_base + irq2;
-            i8259_intack(s, irq);
+            intno = sec->irq_base + irq2;
+            i8259_intack(pri, irq);
             irq = irq2 + 8;
         } else {
-            intno = s->irq_base + irq;
-            i8259_intack(s, irq);
+            intno = pri->irq_base + irq;
+            i8259_intack(pri, irq);
         }
     } else {
         /* spurious IRQ on host controller */
         irq = 7;
-        intno = s->irq_base + irq;
+        intno = pri->irq_base + irq;
     }
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -353,9 +354,9 @@ static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-int pic_get_output(I8259CommonState *s)
+int pic_get_output(I8259PICState *s)
 {
-    return (i8259_get_irq(s) >= 0);
+    return (i8259_get_irq(&s->i8259[0]) >= 0);
 }
 
 static void i8259_elcr_ioport_write(void *opaque, hwaddr addr,
@@ -410,7 +411,6 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 {
     qemu_irq *irq_set;
     DeviceState *dev;
-    Object *pic_obj;
     int i;
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
@@ -424,10 +424,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    pic_obj = object_resolve_path_component(OBJECT(dev), "primary");
-    isa_pic = I8259_COMMON(pic_obj);
-    pic_obj = object_resolve_path_component(OBJECT(dev), "secondary");
-    slave_pic = I8259_COMMON(pic_obj);
+    isa_pic = I8259_PIC(dev);
 
     return irq_set;
 }
-- 
2.43.0


