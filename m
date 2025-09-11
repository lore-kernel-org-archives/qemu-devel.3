Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F88CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwoXi-00072m-UH; Thu, 11 Sep 2025 17:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwoXg-000727-L2
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:09:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uwoXe-0006Eo-3b
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:09:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58BEDU971564096; Thu, 11 Sep 2025 14:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=uZVpVCybkmqnx
 iX2iDiO7+VIJtt6cc2U9S0xPJdIfVU=; b=jcyrEH6MAVSMAtZA++zcBTKx6h4O3
 VjAUT9+WarnroaDml+l77aUbrOzwBbD9LvrboMQzrG9lNdclP37SzJ0MAnmOxJxm
 b+kEIW9XmS0BYP1IZtMflZOO8CQZz/HVTp3fRtAz1QSaM3Lk9H2XzL+mVw6T0o6R
 Yk0VbXmrIeklHWtOzCzNdBw+4/VhKqtgoFNjFgjBpb1m3Z9asGtiFklZcBU7VyQ3
 0IAG0fbvLykcnL0Ndz5jZ0ugx0uqFIwOsPy/6ljk7md7981pBzwVjtnfNOUZVS+l
 VA/jhJcDrQ9n4x6M/BwequcWwN2XJYr2eTbO6B+Bdi8jET93H3KNPVjpA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022140.outbound.protection.outlook.com [52.101.43.140])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 493qtjj4kh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 14:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP8lmn4ZzSt7/s71FaIM4FtVT0Ws6ns+7v7beGQLPxB9p43BdHsNPVpI0c0JXgRSmCZ33mYnrdNKH+Yi9lXwDu07BOrBrXUI0oLeG2fpPfjXAUrPBZOLIDAhAG57bJn3lV1EawTDJR96wpJskQfce9WriDOReslFCEp4X1gsF+1VEY2I6+brhtdDb8P5wveANsZ6em2ELHw6MFb6dS2khdzAhramnThYmLeAQhX1UrDKAbvCur+zsd//H/WqtPSskXSvisKkqtcXjKDrDLxsC/zwm2GI9aNTn4kTHUF1F6DNX6l4oWTjD0ic7gqeXh8VSFAVVQJ/Aepk9YxHWjattA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZVpVCybkmqnxiX2iDiO7+VIJtt6cc2U9S0xPJdIfVU=;
 b=HhOf3P87NkYgkZJqk08X4DX/b09PJi0xbk9fJB/i7PMtcw0lkHATPPLUXPpEJ0VbKsD5KuEpzUrLW5MI6sWndPiurWSuZ683G25WeAKsD3e2aqRSbZ2EHbwUz/9EJIKM3RU8Wya8Xzdmdd6/xT9wH70Uj/K0Hf3ikpsor/VVraUpzXaK4D2urIaW98oVBawWFsnu70lvsRL4oWSfWvVoG7A7gF83d7VjEWY+izgQJ4fwU08IIMTysKzEkTVuCj7kmmSteh89LgbGyIRVM0FHpnk5llAEnywY3PLmROEcIj0oWqRbwwTCe9pDlYzklcThDnGXaqFxiZ/jrppmUF0fIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVpVCybkmqnxiX2iDiO7+VIJtt6cc2U9S0xPJdIfVU=;
 b=oBt2aHfmG8mGBmxBE1b3bYOluRibeEOY7520nHe6jqdcs6EiHg+Z02ciEESnvlP0AsI1fcHOhAIqpjw04zyHT+83BB3WJZ57DQvN6ikxLQITthNI74jCgRjNklAI/mTXXAVFI3+REX0piu1smkGBNeoaFFEy0rwmQYobW6LOaltbpDN1OOT/fqranJAaMnGr4rbOWwhNC+k9hYEZrQvwQeFaTsFYHG6wBb8Spn7hiTiOkkAKq2A5yGBgRnF/x3F7UFJvQgJXinAf63uLafL0S1lHpqEWJE3r01CRaTzOqk5okV+Uo0TwaNInUZiba1MJpM6DiO3WAt9QAC4QiMK9Xg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM6PR02MB6713.namprd02.prod.outlook.com (2603:10b6:5:21b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:09:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:09:09 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v6] tests/functional: add a vfio-user smoke test
Date: Thu, 11 Sep 2025 23:09:05 +0200
Message-ID: <20250911210905.2070474-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM6PR02MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b89fd1-9978-410d-7a30-08ddf177733e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4cSN14e3UchlnGSDipzDxiRg1GAkKZydFa/HiAZjiDIeCRoQ+xkcVwH4G89y?=
 =?us-ascii?Q?yMr7NBN7KVu/+P2oZrKUzpR3OIFE4Cr1I4dvu98Ev8fbji+FPBQ99SmMRHk1?=
 =?us-ascii?Q?SSFUqTMFHRY+lO2sFtZvKB/MHtVZNhwPmHRiRxTQIE4sCURdW48ggocQvhDr?=
 =?us-ascii?Q?e7aL7XSkjcgjWlWiF7F1Q1fuRuwk0F7x/rCeBpcz8FhS989oPYmchbmxF4Hr?=
 =?us-ascii?Q?CFCzbNdzapyAYfpk17lAezNGvj7Br0x2+ZXcHZzJcsq7ztz+w6XIxWZNYlX1?=
 =?us-ascii?Q?Aaf0GZi99DIVpaKj14PVtYjW3riPbj+5ehjBLjXIQjPMOGKEhK736iA0FY9O?=
 =?us-ascii?Q?PVsyXyr6oLIvX+8PCisIftmzwk2ruKriQ3gho/L8/j9OXiQ8ag6RLjlLpYWg?=
 =?us-ascii?Q?dje8NFo8oypeSYqts0cIKj/JPwwJj0L2/Nc4MlIi0vI9+wUz+OqjflMU4am+?=
 =?us-ascii?Q?sbYL91sbdLZB0jOhm/Yap90/mt+OOmMnj8uu20kSoBO+qi78JyqrOy4WspCL?=
 =?us-ascii?Q?iI9ApEwNlCdIhQqq/I1BU97Ajd+OQHiCIucB0VV0H4zQqEsQ/KTwirHA01tT?=
 =?us-ascii?Q?7bm2MmWfhbmdsbuaKW060a10fnsLmVcI2AsinBHuF/BvPtY7gibMCdqe6gMd?=
 =?us-ascii?Q?TBIHUKdjtn5KlNiF5lFLQYoKZ8jo+Ve1LgzdGS3MHjrE1lBs0tk1L2Qx8ICu?=
 =?us-ascii?Q?z4JoRRxSgTAxM6CZPgJMGpLAq6voPAG6Zq7DQoIlEArOfRu57AXQdTvcaPYG?=
 =?us-ascii?Q?nxppRrSTlPJJ+JHu1fKtc8u2DrvGJDjoVAw0ZhqAFIbQmg/vXGFt+6Lwx620?=
 =?us-ascii?Q?rI/Up/Pr75zxjlLdy6AgFIIAxfkhT21+MBtUxCxFOkUPjo8o1uPNZo1HFWb2?=
 =?us-ascii?Q?vgBkt4JvRnY5FbLKFB9B8zTgHFuvbdSHmqGtDkVph1AD+s2oMCMnvqAD8AIB?=
 =?us-ascii?Q?AoPFyNWWrDz0Am0/twlGENjxoINids+pgMJ3tOMHQjwd+irrB6xnNGqO6J5P?=
 =?us-ascii?Q?FpoB8ctjuKSZlLE3i+3yN0D5UoQbgomtmYt2HUEtpHwrF4ft2YbiXEOpxBGK?=
 =?us-ascii?Q?Ro9jVrTQugYophM5AnmDrl55P5cmwP42g69JLeeQtFN8ytvoS55Pqq4u3yuI?=
 =?us-ascii?Q?QunqDJOddF+87UIHsiO1Bh8ueE5PvFX+ZmPTQjX5HrUUGCAK8ztS0cdSqMMD?=
 =?us-ascii?Q?F9yY4P2lTzAcDu9/pbEH3N2c6OY4VhaCJKmwmnKBPb8fSisI2ErI8HShxqX9?=
 =?us-ascii?Q?NZC0l2RbXt+hzb0k49+t+7OJiqW5MbnF0Hp5wmfraMwCzlbSaBhBkEh6ZKDh?=
 =?us-ascii?Q?wmyHI45AcbdqQJLmQQRqytGW3sMidoLnLsXSLk+TgEv50kbmMUd4hcEYnh7M?=
 =?us-ascii?Q?jbaQwJ9JlmL/5r21f7qN6PP7p2+7F3jtVBJ5vCCKiLFpwAe+wmG41dfXKTN0?=
 =?us-ascii?Q?06PAHkC8Vyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOjPfvkV7FkA7LEir65Ngnk5cztTmHRclfjGk5POI1ERO/ckWBAEC6ZJZH4K?=
 =?us-ascii?Q?y/mwyyj2XoL3ugBtUnQHgz24MHR3mCqT2yPa2EU8Yf8JiDKwOO6tx1WQfTJu?=
 =?us-ascii?Q?yXH5xJcVDB3iErgqVAm6skfBLE42GMuYIH77Qz12eDjNizeYe4UWzIoNDMeU?=
 =?us-ascii?Q?nJmLkNA7KYN1AdbMwCrbDzOhp0hjzzi/rpf+uPc1MvNdKFfvw7leszErMCjK?=
 =?us-ascii?Q?EUcuX05QNu3JH6OiNUQL6ASWQBTjVi3TT+eQSGUTczAmy5iKKd05YpJwyBq9?=
 =?us-ascii?Q?j6cb/Jn7U6PCS6qsCrGf+k5z/2vxdlSMmaA3tJ32HFMucG8VDbMf/lhGs5Qd?=
 =?us-ascii?Q?E3SlY6kq0fBWY9RfvSUkXggPReLcaOKXzKVDuB1yNkElteBPd8iuSFTrpTzP?=
 =?us-ascii?Q?BTdWeapo0Ib69mVH5hlL3LARXDcN2y0VH36imUCsLzszwCxXpoqks0HrUngE?=
 =?us-ascii?Q?qcH47/MsHT27lZDZp0gVl6pYQy3YMfpgO4wI606bMi4+HX+4YPVG4A8dzW/6?=
 =?us-ascii?Q?lBk4/QqqV/aU8egnJfcGjqOtwdvGcHzng/ET/v/I18wX1uwtKFBBOuJ5kD59?=
 =?us-ascii?Q?CNxyNW5PSTiQXkCaGij+zvhmhA9E42kJGbhtFd/AT1m/ZyXTjkJHmRA+HTsF?=
 =?us-ascii?Q?FPI/M7EiSIDyomVKrLA895ZJE688Ye0MIEEkIudzNsbrD7KuWbemrP+cznOu?=
 =?us-ascii?Q?PJPwx7uIaplNRl3Cx9n9hCSFhL5JHAgeofa2hjlOyyUoXU14V1ARp2O3V57r?=
 =?us-ascii?Q?FOpxy/Yp71Fz04Rgh/eTXub4RODuxDfZM3wYYBXXnRBt08Y0JNLc51vOqzbx?=
 =?us-ascii?Q?LPD5C1kp0m44lx4aNL87AD0Amq6/c6tjiWUTXIlhniEwwbK7X79/zHExBCY6?=
 =?us-ascii?Q?ABKLcOnk4DSIcgsbdqNxFovQleU+GwNfgmMEQFTHbxMz+UE8oGNkIKlbk4Q2?=
 =?us-ascii?Q?ltzeCpSlwnVBe6Hg0tA8k0TYLXV+F2yD/ivvRhYghUOuBMbmYAMAvAdNrQuF?=
 =?us-ascii?Q?tnVBlXhQH2C2TJJ4vpQIa5YQDlCeXdXXXhpw7lK38sFDhZTBl7oZxRZnPlnh?=
 =?us-ascii?Q?LyAEgioI8ENmu4vXC08S6a6euxxC0ktbt+PKVJavKhCjZq7Y0fq1PLe5z2Pu?=
 =?us-ascii?Q?Wu+0CKS8ljyiMz5loyAWd6Hz4vu9rNpFxlCXcQiVrcm3x74LpHWa5kRDVMHw?=
 =?us-ascii?Q?Dg8APoI62uxF/L+n+NsNS6h7khCA1biN5h2kxE+KVK0USfImNl8l0RXZ/6Dk?=
 =?us-ascii?Q?2saEyp8Df3EOucU++GbAmQ63PAhP2svZL1RWNEbeGzqRpMs1RmdmprZYnMkH?=
 =?us-ascii?Q?7Npq/+BAUJQiQ8bzA62gl5JRHOPt5YbvZuNSELjr0biukswdjG47YTNxMohw?=
 =?us-ascii?Q?2rEAtY92tYi9ShHh0gQXQZv2tV+a0ND3Jf9Z6/d/akIcxedT30ZOkcv1rIfS?=
 =?us-ascii?Q?K/IYQuaK09FzSwIsjfqNNbJzQZmrXxzV249v/VHN9E06GKBaKA3VwgL8XoZw?=
 =?us-ascii?Q?68IlgXs74tmT+gvzuDqLW0fMpCSbeWoadWjpVTc1E/YMtAH1XT9Ue06eMjS8?=
 =?us-ascii?Q?NopcNFs0nTkNI8TcxQ4lpPHya4S0NejJOyrqd44i?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b89fd1-9978-410d-7a30-08ddf177733e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:09:09.5854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoO0JPvLBPLCvE9UdHnW0d+W0iix0V7yOlkb8wkAlw57FAE+YTdIc43teAH+DV7Hq3m87egLBz8OdecRlFF6/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6713
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDE4OCBTYWx0ZWRfXxLGHXWmKng3P
 YvMArZG9BqcbA3/iB6LWDLUi+nAIRpRrmslEpuWMrhRMQSASVMDHMAkiVJaHEUH3ZRB2FRpb/g9
 4wSA+oatAjsfmxCacvGrtdQll+UQNLWvIhkwoUycLxMpN9lIvEBpv7jaiqoFjYYOO7nEjlTOC5m
 YiN7Us0C4eS3iRM5Laup29pNralg3lCKVwH/JtdVHryvVZaijmcscxz2EP9UqrFpW2h8sTlo5iE
 tA38yBl2OEaqvr0IgyJ5HLtzF1bSwJa4SFwTrRK7MAbunx+BWkp+eAim+q1mNJXoEq/h/laqQ5v
 34G6yS49LOw+m8h6Fx4bytLVEd6xqenA0ClTBngAC/TNVT7OWu1gbgkxu/oLe8=
X-Proofpoint-GUID: TwECGk0H8uLXLlzfT55yiZg-kIlu5bSW
X-Authority-Analysis: v=2.4 cv=C+TpyRP+ c=1 sm=1 tr=0 ts=68c33a77 cx=c_pps
 a=Qna4ymSQF555k3G5Ibg6fg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Qao5vpg7bkeMYIVlSYQA:9
X-Proofpoint-ORIG-GUID: TwECGk0H8uLXLlzfT55yiZg-kIlu5bSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 201 ++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index fb045388b9..738db4f83b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4307,6 +4307,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8..eed1936976 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -31,6 +31,7 @@ tests_x86_64_system_thorough = [
   'replay',
   'reverse_debug',
   'tuxrun',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vfio_user_client.py b/tests/functional/x86_64/test_vfio_user_client.py
new file mode 100755
index 0000000000..8bc16e5e31
--- /dev/null
+++ b/tests/functional/x86_64/test_vfio_user_client.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import os
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+# Exact output can vary, so we just sample for some expected lines.
+EXPECTED_SERVER_LINES = [
+    "gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3",
+    "gpio: devinfo flags 0x3, num_regions 9, num_irqs 5",
+    "gpio: region_info[0] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[1] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region_info[3] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[4] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[5] offset 0 flags 0 size 0 argsz 32",
+    "gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32",
+    "gpio: region7: read 256 bytes at 0",
+    "gpio: region7: read 0 from (0x30:4)",
+    "gpio: cleared EROM",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+    "gpio: SERR# enabled",
+    "gpio: region7: wrote 0x103 to (0x4:2)",
+    "gpio: I/O space enabled",
+    "gpio: memory space enabled",
+]
+
+class VfioUserClient(QemuSystemTest):
+    """vfio-user testing class."""
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+
+        self.kernel_path = None
+        self.rootfs_path = None
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-snapshot')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+
+        # wait for libvfio-user socket to appear
+        while True:
+            out = exec_command_and_wait_for_pattern(self,
+                 'ls --color=no /tmp/vfio-user.sock', '#', None, server_vm)
+            ls_out = out.decode().splitlines()[1].strip()
+            if ls_out == "/tmp/vfio-user.sock":
+                break
+
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        """Run basic sanity test."""
+
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        sock_dir = self.socket_dir()
+        socket_path = os.path.join(sock_dir.name, 'vfio-user.sock')
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if s.startswith("gpio:")]
+
+        for line in EXPECTED_SERVER_LINES:
+            if line not in gpio_server_out:
+                self.log.error(f'Missing server debug line: {line}')
+                self.fail(False)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


