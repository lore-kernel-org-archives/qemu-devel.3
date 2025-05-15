Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A843C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamG-00082R-Qa; Thu, 15 May 2025 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFam7-0007M7-Tr
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalx-0006Rz-IN
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:45:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7nlpv026476;
 Thu, 15 May 2025 08:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlB
 X4=; b=Pm92cO8DNnTtEpbr7n9ijRTEmbtgexAnxqDkPf0iVvgGhAXKL4NAy2EjP
 MMqr0HpqX8E3wDNrOFJdCVwqCnMNKdFyC0y7up0z3okwTiL8k9gp3T5B21jNSfqX
 /kv4Hd7vOCvfiX8hcfhetNv0dvfeiuGhVrfocwCzJSywUOx4BkqiLuvfdzDR4rdO
 dAlirVAthvGqwUYeLn2MZxZ4damUMBzg1z7D+vFhlMxs9qhjaOiqU7nKFbqd1YZI
 htmo4uWDb7WYjsg0agqmaNa0wfIZ5bVTN8682IeilZiUxS03D98yDmD5p4g8b0wC
 mtvtinWLpGi5GY/cUhByILK8oGxaQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mjmtvrfa-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl65DumPqmjCeV1zts+f1RLr2MZRJ46hALaltZzmI8nEnMbnobbZ/Xt16McK+Qsh6FSVZQjoECswxYxM3zx5JATlnx8YdqJbIhRMcC6QqGnk2hsHfdb2I/vh+DxdrQw4PxTiX4U2YT+UKiSD9ZpeBp2Ohf8NDRaBEsFXz6EGoLkZ3KRdhJUCg21e3ICVc/m3pUeqEOy1NVPu7bv9bA4oqVD4rMxbXWS1rmgN0yNjeB6R0LnGRWg2KfLPWC09zTrlV0klg7Z8UiQHJzRJjZ1zKFT3n7JQymLgPyvRrRTcMUqQJGGnSW+InqcWQAgy3it9bqJGTitQIAJ7IhLSgMR08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=x4Blp9aMb+UlCheTm0HMbbfax9cFE3uY2v5WmH8n1RSAEViqBhl4rJf1hpGxlVijmUpOlBiT5Ak+taKbIM5kX4jHxfPX15TkovJXA8BnNZoRTmEiN29vWDx23OtoQ/p7nabwjgUFpGOcuF2wS1o0d9DmqA41HFCFgNu1pT1iJTpD//3ebY0f9wMkc4Xu+jxHw54OYijIaFWvdSdhWSl32hd7Z2YzU3mPVB5oc6vHqkTpjZvHcMCKgNqLUBDS5vTLKjw4QIt05v+dk4n+1luerCKsAVqXvgwdMfTc273QM1kuKmA7k4/iBG4bFFKDJU7FqP8oOaM7ipEEpo6Wjjz5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=ih6ki/cS7KlKtVq2mimIfgkroT7F6OC6VZpmk+hO6L4W1zhBq4aVHI6vh/YJTx1nNy+7s0DWnHGf7qW49gJHWu9QJd/aXti+QtKel0g4R0hzHF2B8lUmF5sPMsNlhlGH4NLabS7TA/bYBtnP4pmaDdHTQft9S1vrHElaHJT8Vhj6DwsAUik+oGwnwNZyO0uLbXIEmT3xKhHaZXwpoS1VUtfIVxUKGH17ujnHk5yx03dB7bqXSkx0J+FtQapXIlU3YLyG2Xw1ABGW9LCiOvmOD16GuqtiG9hpPkkBFEAxbjx6yKrOFlwGBzhyIlnHbH5tx1hHPO6aEL0cdw5LbFWNDA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:45:15 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:45:15 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH 22/27] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Thu, 15 May 2025 16:44:07 +0100
Message-ID: <20250515154413.210315-23-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1e952e-be04-4ca8-ea55-08dd93c77c28
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shbC0WYSetAKL9PqWj7gSxRd8jdftr9E+b+n9Mk5s5BihX1cxzZwiLKYLE9i?=
 =?us-ascii?Q?yU/WJtJKTH4LmXHiTmA7ESSRZwmDimsZrVgny1M6UiMOUW9DZLJiRAW5X2vY?=
 =?us-ascii?Q?4BS2cZcIwctny1HGdfwWWhgoboHfAKYrszuEfLoHLFeNP/wXG6f6rq//myWt?=
 =?us-ascii?Q?WBbwzRJPtU4Ah1aIWlh13BtdV3gUeUtydy/2lwC7rXadxwQBtajVLw5fDOnD?=
 =?us-ascii?Q?Z4uMhLCmyukdM9VBx9FXLVR0KxWiNpU8mD3geW5EgQ/+xw8siEMrhELkM/Ag?=
 =?us-ascii?Q?c639vfJ5TRs7GZ3b7ti78TF2mHRiT69CE3ZdBEG3O95YSFWRF9PDbmtcezgQ?=
 =?us-ascii?Q?EhuJJXFe5qMmenqYfTv1E+Ynm7Xj0Ej6S0WOCRY2Z7LCrjJ8bCMmgfqi/5ue?=
 =?us-ascii?Q?OiTMJCeceeDT6rgsVsKnWUzKdqA+01cvb32H614ckfzw7Dj/NDvDzx6rWomx?=
 =?us-ascii?Q?e0Qr55l19XlunQLmg42VcXU12lZbUiRFmDeWoL+Wcf2bJkudsicMQ3q3i6/j?=
 =?us-ascii?Q?jmvHFpqKNHoVugC+tyqmhiHna7P0W5piV8gLGBXSgglKhDFiYhM08cgLtfPL?=
 =?us-ascii?Q?qf5lIQ7zpqrtuY7xhoP4V1dLLAmuOEdfOtzy6J34otg3ekwTICQFkRu0VZL9?=
 =?us-ascii?Q?v1n+TPiNRwpCeK37M7mH5yGpywSvM41JZgjCT6+R/lJ1jxS3VwDWRnWaxwn8?=
 =?us-ascii?Q?wYlHahbl3njtlH7LdDoJl1bBfGDicmGywUnpDTJdhUqEVnoSThp+FC4LEwSa?=
 =?us-ascii?Q?PV4fg65NEEIkmLsztu9nDFRq/0lZfNpiSGZoinUl1k4lRw3h7WETMsI8+wEu?=
 =?us-ascii?Q?OYrcsaT29JdeT5mb3GNRkXYSlNRM7MoKbtZhCvuciFRIl9taNC3MIl2k/tcg?=
 =?us-ascii?Q?R//1Ogj3zumqlCf4FScEZTFChOkvhG3I9NbxV8DufZ15he/29ddZ32iGYA6N?=
 =?us-ascii?Q?icxixdem1JeNIKwqDrB7Z/6iUXMlqHFIYFkAeOPEDandX8VnWf66ZDmBlNgm?=
 =?us-ascii?Q?cHq4ouNWGJezO9XZE6/JotAsyrcY4Kf69ql/zW7sBxLBkT6XfJWJNLkhlIo+?=
 =?us-ascii?Q?VFrTKsTPXMOLFt7VeIkkTh9eC8mqisNhRwm+eelkpFSOzfqubBZXzIUXHQSl?=
 =?us-ascii?Q?UveSInuvC23ID7TVb3v4MDqyGWNYDuwUauQPlAym1LN2sDNceMwy6UIpof3m?=
 =?us-ascii?Q?t6bu4jQQCqJTvrEpadAHe1IMfjDMeIxHdTCLWhX/Y4sN7vLWh7Xe3FEFpKGP?=
 =?us-ascii?Q?dhTPS+CER6jtujcS4PegVGbOfd5NC803W0HuLOLkS1fILX+B7p92xK/b94nj?=
 =?us-ascii?Q?xycuayky3IhdwP+GBXtk4INfydB3qk8HFNFxQjYKYCm4dQ5mj2VvNkrfZBp6?=
 =?us-ascii?Q?qSsw1zhn2SbY1047GU2hw+ACoRvHrohqkDRkqqvcipn/0R4loqOOQ9/Rw+xd?=
 =?us-ascii?Q?+cj9k70qq/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5dg1tIJSfh+zph4UzsKb0MKAusd+w8VoqAo82v1GUUHgd0T0DXDd1Yw3ORj?=
 =?us-ascii?Q?/LB85gr/sGjsN+cEEnWi9K5mmunEOaamgFdynmqPj54rPSQBpVdRBrwIPxzY?=
 =?us-ascii?Q?iXP5l6V1ezi3JYnZGBo/QENJGwrMGwnhghgkn/QR0W4/P+NYY+YEJN9pcDqN?=
 =?us-ascii?Q?WQT9lzMPLtUYUxHIQJgn6QfJ7W1xzm9BD81xxlivWeGWB067mp+UUhGeT/rq?=
 =?us-ascii?Q?nyDKBujf/STFIQJFRRzPRrHHHF6w8Hn6fcJSqg1Bgwr+VJyrV0Fsomu9Q+A+?=
 =?us-ascii?Q?5pPBYChzSmp/1YDh+NqJ8pG8d3iZixK83yF4RNNqzAzzsqNzIaatfg+LHRSY?=
 =?us-ascii?Q?tVa4gd2YAtrI2JiI+O3zz5ThS8Z4TaZbk1t8GbHhlORPBBakNfs0eQECK1n1?=
 =?us-ascii?Q?gDlHA4myWL605sy6SNTngaOjzgaSKc8+jHGqGi8zy+TEsPuov6LDVWQN5BLD?=
 =?us-ascii?Q?uGIiGH8PeVw5joTVIoYR3GOTB7B5pllOo5fWgWugq9YbPKxe67/h2kne9MJf?=
 =?us-ascii?Q?T0LbGLp4Fce5g9/o6wX+P6Ls+FEnGyfjJwHHVoCw9SNSJ1mSqGQzcFkS9h+J?=
 =?us-ascii?Q?EeAY1xHkUdvZgbHNNr2WClZaeevae8PBht6d7FDMCuKKmNVdfssyBSHZJcn/?=
 =?us-ascii?Q?MNzMk3axXZ6jSKIG4kVEUYxSb2LxZofpcXZIpbnK2VkZ0xaD9CQwu+27vZKc?=
 =?us-ascii?Q?8E2nAsrE4ivfKFqDK8wYGMO1iLkMODLX8LQYOyUNONQ+mtVqajW47BsU49hy?=
 =?us-ascii?Q?QHLGg1gDiA6EyBivRuyZouSMiOo4ztPSWWWFp1eExSNrujkrCEPtovDsAS4y?=
 =?us-ascii?Q?xax15cyrLYwHjzVMiVIukn6Gl3m44vXIPVDyeTy88qtCRtMN4dezAHYAKeec?=
 =?us-ascii?Q?1+X0+MmnW5l7+RIuhLXTPupuuRTjq8luO6JeqiivG0zr5YMg3VHlwEi2XwfD?=
 =?us-ascii?Q?f4iZceQOUjHeby6lWjSVgWpu25LUoKD783zGZj8tPZqr2sByx3aTKVOJNUw6?=
 =?us-ascii?Q?SrzxzWnorGjEdJCFI5omI+rwOItQJlRZMOxG6nqTo1rcbJxepM58K/pAOCGz?=
 =?us-ascii?Q?z9fNQFdHscm0DYpijr/UqRexFylGz7KhMZ5tuxh3JSrqTlhIVcHUv67qXISK?=
 =?us-ascii?Q?85UbIbA0/z3Z8fE9PMfaHDfBIUxbbNovX1h9jDEcNEur3/AFtLfJLv2PvP5G?=
 =?us-ascii?Q?Py8qd+XyL68bNOm/qNb0gm/+0nV4lgyoikeNZN0WIPxkOfdrHUpl0PpFJrLp?=
 =?us-ascii?Q?apAd8eSsfef6xMDG3Bizw2OB8CesZM+I5Xl6foeadyos3AOUaNq8eA7B2qpc?=
 =?us-ascii?Q?Ud/n7EKvA0ehdNHbEySIf4WmeW1W+vtjbo1NgF99Ht50R8DMh+MlOxOD7ncd?=
 =?us-ascii?Q?aEE3CR3pQ/3R8XluLj8qrCltFvx7B8KQ8Lj9Mqnn+0MRyLT27sd6pOGT9MBC?=
 =?us-ascii?Q?9SqWZ1hiXkRLg1JHbssoLa4jQJvs9wi5q6FOy2jJNedwrJVe1zUB5y1B6pL4?=
 =?us-ascii?Q?RDf4vkLzFFZ4AfB3XQUPvdgHiO7luG9xluvYog/J/Zscmd/jK2RcWdxvrNDr?=
 =?us-ascii?Q?zbggnCUr10J9oE0tYuOM7y/KqaMSzUf8ST+HFF2/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1e952e-be04-4ca8-ea55-08dd93c77c28
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:45:14.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZKaUEDmAvBxc7zs1DDLgrILevYzh0Tql/pll6AOYKJPGlC+6ca62eMCMzYcdG1I25ROstahErnXkJOONqb56Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=TauWtQQh c=1 sm=1 tr=0 ts=68260c0c cx=c_pps
 a=kylQlKNaLH8A8Uw3zR316Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=RQZ_2NmkAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=QltQKaWwH6ua0DdkohUA:9 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-ORIG-GUID: liKTQ5hGsyPa1R-04eB33BQ_K6_E8yNS
X-Proofpoint-GUID: liKTQ5hGsyPa1R-04eB33BQ_K6_E8yNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX96531ehAAff6
 sd4DzCC0aRSdUygWOmr0s2WUJLA50r0M6Aj5aDbauB0mOxdhAK1zgEia3+NzoT0yHxqlKzeES7f
 76+lmAuUMVoW+AZUDk0FbyZ4mJCWXUG/5oGV+0q235bsaeodqWaDLbi/lbxqJcQHgVyPcSHeigz
 xn1EV8J3B2fadrGgbo2+y4FCa4v1kfbm9g7r0GnJah9Bo3JydIVuDpVOaLB+uGhPZO30SuDxJ//
 vjENM7zhzAIFoYN/sX1MQBJM50kf74BmlsrJ741ZVowvn44ZFth5yUm52uB1Paz6bPRam9BsNBE
 OYkrpjsHoEyJITfl+sTslZBmx+nu7GAHH4/14S2rmRfNiVR55JY5c/Smu7B2BYpHdJ9fQzbvJbU
 mGC3xpVZixLksp0AAwxDmOcNece4jaMgvcYoiI1l+7l6JuPQlFiSDaS/hAaVSF7JEKsWJNgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  32 ++++++++++++
 hw/vfio-user/proxy.h      |   6 +++
 hw/vfio-user/container.c  | 107 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  77 ++++++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 920b9c44ec..4fa6d03b3f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,6 +115,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -178,4 +203,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index e2cfaeead8..01fed3f17d 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -73,6 +73,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -102,9 +103,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 38e9cf8d8a..5a109c591e 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -21,18 +21,119 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -224,6 +325,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 34df9bba7b..6d1446c38b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -31,7 +31,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -133,7 +132,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -609,6 +608,36 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize)
 {
@@ -647,6 +676,50 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 053f5932eb..7ef98813b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


