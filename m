Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695EC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc3R-0004ul-3v; Tue, 15 Jul 2025 05:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1u-000210-I8; Tue, 15 Jul 2025 05:32:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc1n-0005tI-Er; Tue, 15 Jul 2025 05:32:51 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7PdBU017978;
 Tue, 15 Jul 2025 02:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KVVq5t4SimhILJs7qTBQ2DlEEYLA5Mdmn/rPyoXdv
 eY=; b=fPxeVgDDujdzhc6g06VerWumTikBiXSIDWNV+mgajMLZD2fbpZCJ9pIik
 lk+PxkKFQc2xd0SoJ65zs/5OL+Hovy0E5k/mzFCU4uv6P5VuxsNE3qClEJ54ANkV
 KB3/oWP5gohoWz1zLROq5B4mRZ0M0BWNZdsK1UsFTgZ5hryhZ3BXVQKJ/ur4SLlW
 Y+4sk9Jbr45YTGcvPpi5e2cTen2ldepp//qmp0PGvV8kYfZ+76b9SIrwAUIoY9SV
 V4KVGRbFs8SnCJ2xwa0droyQG8p9N03S14Kcx4e2T+PKpZ4/Lxj0Gwq3g6U0RYhU
 2Lgv2+FyBeX2uG5a5gf8/4rf7H2aQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1ddwa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPESTZLBPSPg3IvHSNd8FFY8eJTmucfLp1mo5oEXh4ENLbzkip69KDXh5zy2UfI5jvQDp+ZD10+9CgR/EetqtfkQjKg2fdezD7uM+SjTKPU30nPPPwQM0Umt2RqYuWhHFCK9jaj86eJjM4Pg7rj6UUOJ2VjPnUk3ZhL6pZuzSrGGB1Vd4/00PJjKjw0PnFS+mAmW/7b/NJcESGpLvdzaqyFPAbH6RmATHkNwx8hAugcBH3/lFVMDb65erLFzrS3qt27i2adND0vZzGDWiMvd1UNoRzZwwoTX0ncco1QxrNGwTFiANlRiANLEYCMN0+9W57tSJDMVnS2MLVGcbHqjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVVq5t4SimhILJs7qTBQ2DlEEYLA5Mdmn/rPyoXdveY=;
 b=xEqrgIykS4t0E0Hpm39on3MnUVmFkIXycbjWRMV0IW8euZ8MP+zMJSTBgh9nFEECUPHKpl0GPmRRpu7N5P2U0CiJnYRk3wAe7BSEm2dxLbLWlc45t3KBXg5QVWSmrxMXBucWRW12n6ynVnn/icZ0Bj2mIdfXW+YDTYgzw3sPj5huWKTsIJc61DgsM0yjGhgcB+ZnK+92KAMuMP9N5eYJlOV4bl2nuzAYaeEPzhXLdVSQ5dbZT6G3fgkdvUv/8A9VQaYdVQwxGkLhUaZ+eRyG6zRsGUJIgTv3BsdqIDx/gqoWghhT0R05HS9zGXzKXu2M7Qzhc1j2L6AIrJTBc/UlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVVq5t4SimhILJs7qTBQ2DlEEYLA5Mdmn/rPyoXdveY=;
 b=iUlF7DpWh7HeuPzdmlVHGslgVx9r36d/+7t1dP2sZYXkfLyJUbmiDXN0aycB/CDcr21c4fKF4fnKgC1TyH721zwXb0aw6OlHJ/Gbq5jK+3aRs9/7iT1JTCkkRgdxDYX6p6MNjXdGyf4In8p8bDr97h7uirEBK23ClbhGNIU7gpfbKrs0DEeRCYGmtM07l6j3sK+pmoZbKERMTo3fQnmFPxK9R/Ap8Dz5HXm/Dlr4q4Ntn0wJr0VAzHv/Jo3HqYMo282Ls7IxO0gR39RBmrwB7DUwMjyLMjz4S0H0rhYc7ecX/cpYcSLysvJUx2YgOMhkbvcTVzdBfNNLvQleUNFAtw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:32:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:32:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 20/22] vfio-user/pci.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:26:00 +0100
Message-ID: <20250715093110.107317-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0050.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: f646d5d9-7fd5-4b4f-6dd7-08ddc3828450
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKjBqCTKgooomi47aHfF48XE1S3wWHvZdOY9i08ox73Buk16a/bUw9QGKLzY?=
 =?us-ascii?Q?JeNerR95ZZz4Zaio/ZohxL9wi/HVS3wQuA5CdNkRZgW9Y5itWJs8V/yw8WBG?=
 =?us-ascii?Q?MjMHRF7Baj2bHPhxX7NqIXBykzBjS+6lLN+Ota3mbjTi596j0iPfMoq00RFH?=
 =?us-ascii?Q?2/JYdnWJfTQvoc+LyUTkY2RWZT+iSMrQ0JeMM8XiPXlhW+GsJ6l9qIf9Rv+l?=
 =?us-ascii?Q?2i/LPsiEMzJddpOEkdZL1oeWHFsaKRHG5urfJqrA3VqgpZWhHR4hLJ+g00Fa?=
 =?us-ascii?Q?vLdw20Ox6I63I0C7uOBH/g9/QQ2s6nJ8bz3tn0ThyfDtn8b50DtwvzhHcDJ7?=
 =?us-ascii?Q?UHOdo2pesqQToTqGCNttg0LaVjvGZev/RAEWRRbUYulEPy9LtwvQRa2OmyE+?=
 =?us-ascii?Q?irAool7PjZ3HdlJUADl+ktnzXBxZZTmziDd3EDjArYlyVIhQWJjxpl6U3DqR?=
 =?us-ascii?Q?GBCgC+3gcQ3kwISfGNMNmK6V5Ss5bDLUHZsWrv+ZdmqQfoQvrWyPDuNw4A5K?=
 =?us-ascii?Q?Z5rxOtUrVqG9NNbyqlzJPEOctGPxlS+Auu/7ghiUJECoZ+g86Xk6O1k0iSwO?=
 =?us-ascii?Q?7G/fFGPL4WWnmk/6yXcYV5OZP349rj4YVYA8RWnUjeJ6G+E7Q+rEaPMHq0k6?=
 =?us-ascii?Q?WZu9GI+KY03C3Xy/aXZAssWsA4SteIdxViw8Ca5sWoozlvOyCQBa17hOp5YE?=
 =?us-ascii?Q?idYwMsS6sCMC0+5G2QLLEqW3w+MD9KFPfopc4RZHQDZ7ky3QeKmuZ74J7DCp?=
 =?us-ascii?Q?2UZGVTEhYF1grp5qsOqju8BD3JLoVB21r/HPpI1Os3+xYQfJhwR2cHWZm/FO?=
 =?us-ascii?Q?sKeiQrT8g8iivDbX6jcFWjrj/S9ANuLAyXyyG2bMjA9B4Hr5AdyY/z+R/eQr?=
 =?us-ascii?Q?i+vxkDpNX72cVK1TdvUIh5LbxLD5UNEphFFmHc20cNDcQCZHhakZ+BncvqJi?=
 =?us-ascii?Q?j69TMH8o8RQAoA+Xvcp3sZJlL7Y5oBjI8mtdMDTeAJekpfgYq2xX91Obw1K1?=
 =?us-ascii?Q?tKOAV8R/G+fIJh9hlnyCUCfqeaCXve14QWWgUwGHlzpFpEPtaHLhm551o5vI?=
 =?us-ascii?Q?1zHyoSGAQwU54gjIFY5AyAQOj16u0QzmrPqhxSwvheS7QiFJCdb8xbqznsKF?=
 =?us-ascii?Q?QdSBfhfBRVoJsn9jsZ8S6g7AbQe2KAuVFcQLHtvr9B5e8EFqxbztugNcx37+?=
 =?us-ascii?Q?2WF56vmGUSSRxB5iRywEx9XFdhVt9yEFP1LZ5ZnYFtVwSQ97dYqfxVf2QYYf?=
 =?us-ascii?Q?p77YbnuV2TTVQD5jeOEAbBo/0hJlPuwwGC8NDoaZrzU90xQi+V3wYw4m6nS1?=
 =?us-ascii?Q?rYcNZVtV2qaOTmQUCBSwDs6UhfmElbeHyUZadtOT7YDGoyGswO60hmbPZOJ3?=
 =?us-ascii?Q?LM11ugJbwiofGkiX/nBw2LuZn5eeaad2IMECOgNs7y6Pu0P46ftLmNVHlKUu?=
 =?us-ascii?Q?KkGdq9E24yFL5r2S08dhfrnCj88ANZi5YV5rOnxX+RABev4sxMHZNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUM1yfCx7tgWTam/Vgpksm8BSF5sqb6eJ6GQvOnJH1xl3gc2OqSBVoq0GBGO?=
 =?us-ascii?Q?gFtTos1wQjhl9g3VkPj6sC3K/1YaUdjWguyIzB4pH/SB/NQMiVRk3xjrxj+S?=
 =?us-ascii?Q?1Au2Fh8X7+2pxgKWrbngSlm5p8F/F2P+cmKGPbMCKC7+uXMs+WS0UCZsoQB2?=
 =?us-ascii?Q?E53/Bqh2Yh3qFK2LfK51WdNwRE3sOBaXaiXjJr26+TGTdZlx8Jf4OCrM0ckW?=
 =?us-ascii?Q?isdc+0EIhV9fl/W9+y65WYW9AF00OJkA5VuCAdMQu69Yu8Ma2LJ6iQg+SWlq?=
 =?us-ascii?Q?V+TsB51/YAKQrQbmBATpG8lHOxpZMR6hUSuqUPyIGVFS1a7vPDmHvfflJLpe?=
 =?us-ascii?Q?VXNmm185jzIMvbxEnzsALW9uRtwcr912+HCrru5LVAt+rFF9f0EIoyou4EoY?=
 =?us-ascii?Q?GCfjeoIm5cd3SAiSg+W3Lxz6QnraLXO5MzEGIbsHk7wbkDu79KGXT761r0C+?=
 =?us-ascii?Q?Yc6Q7fI4M9+WsszLrde7jypFxcFuydx8Q7wAUOfxnKLb/G348DCie3qSnMbP?=
 =?us-ascii?Q?2not+HMDhY6y/wKzVy028jGRsQmwiseFNMswTSuwicvTBJ7yo2ly4TGccwCf?=
 =?us-ascii?Q?821amS7TknOo8PouaX8S55TeuBDpQ3gS9NRBx0+Wslu0MVDMbZSsbcsne62C?=
 =?us-ascii?Q?0ILo0UZPxik6aCXsDZhW2aKi6cubS5KxJz6TiXb8Ry93jzrS/0rOn/4BC/PU?=
 =?us-ascii?Q?fZaXa17Xt+Wo/81R9amAfxpcHqnu3LK5/F8YBJQ5QO6N5bGHPaS36bPh2AHq?=
 =?us-ascii?Q?X3752TPcKwKBn6hPpU3zq0TZrKCHa7lj8rTQBtgaf6OzHp5PJiAVQg7AcVj7?=
 =?us-ascii?Q?+eDi0cmf73Rv24VGO3skFJPE/JeEoUrLcJhhol2JPQy42xdStXux8kLuZJQw?=
 =?us-ascii?Q?KgLXdwmhgfewUCcnLP4Af3nkxrqYRKQ3+9idT+WvNiHDPYm8WiWSlhsRe8Ii?=
 =?us-ascii?Q?ma/yZs7xidJMbwzx8e6ndScHlvYWCE7IzUR6npMqxRGO5p8A+lbMDCSAQXyN?=
 =?us-ascii?Q?i/lpET7kHriCNYuDtvZIIDWxZu/nmJS4fH0eVmF9mKZGHtJj6HujH+f2E/IZ?=
 =?us-ascii?Q?kbuRxYa/gLGw9rHQFNuI5Z9dg6G9/0/tJPQ/lmLK4ZQJBCyia3mrqaH6i8Ae?=
 =?us-ascii?Q?jgrnUgHZqXquf5IR7Stt23yKu0nWxpljm8GTe/oSgK/grVMPD0URFXrk9iIz?=
 =?us-ascii?Q?D9tS+zTeU6tYEHBhCo6+oY5urPHFLtlGFjI0uv3FQElfqM1qsqt0SXF0oGox?=
 =?us-ascii?Q?fmxsgRpVBsFR145CO+A1zDT24DEdn+cS0qe5utz9Peww/kCTikwJasHTLSz0?=
 =?us-ascii?Q?Okd36WY3rnmXBzlHDc3ucvpaq7pu8I7Yk0+qxaZStIj16hhtkec4o+5juxP3?=
 =?us-ascii?Q?lwpgyDoynmNbbT+/YwajuLQVxe5DmUHBF1ZJ4yz35XXDy2JPgnSVflg0wPtS?=
 =?us-ascii?Q?7i2+gz0OEdYk9sw+38I1K1hvC7pCPjMzDJHmYdQSmV3qlQ6ZrotPzChhTil/?=
 =?us-ascii?Q?pJGylgeeFOlefEvyGyJXflZO2x0w8uFXFtFymbzndPmcX52buNZWMISjbotv?=
 =?us-ascii?Q?ydrzRtS2jVSpC/jGCg1WYN1TzK2pTsqSZsauj596D++AvcdlS87JeZOatlh4?=
 =?us-ascii?Q?5KsI5xWlbN6rPS8CJTQvt9fjq4sOL5gSB0eEUmEy40lGeeqjtz7M/Q0BfTtL?=
 =?us-ascii?Q?hlSx9g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f646d5d9-7fd5-4b4f-6dd7-08ddc3828450
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:32:29.0279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHTcYZpvmDGfmk90Il7lduDClrobQ216sKL+L2/lqRuk0tZXfvxQz0gKjIIaP2ShEi4svfIkAEpot0x4+4Dk6PisQUs6KMi+fFvEk+IK+a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: OxvHgr8wK6HvOk27nQbP9Ozm4jKUHvXq
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=6876202e cx=c_pps
 a=MJlwP/pY7jdh0k4YB6prAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Kc9TmPF6FbSwc0xhZi0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX/9ZwwwTge7uk
 wUP5HIxeovdCvJPXgoiN2X1YIhZOvtl8xympOb2ADRsqtwiLoQrkrIP10vVENSPFQQ93XZ8TCZS
 A2xI0DgiHyfO21nzXDZsY3Zx39JgT0WldG5i9u4pz9qTjU/raPqDyqf8wlCrRGBDvFQ/X1TFrbj
 gVIIs2v4EiHq24dS6zfWuuo01XLLLgffgZLvDrD5gElJsHFm44F7NIFY/GeAG3ziO8iiZFhLz0/
 fnEJRZfNE8iXo5/trCD8wqRvoBE+VXQuZqm4TLqdM3YdCIFKQk/WiphD60zQ7E4XK3vXLgl1x6B
 kK0srV4jHxYCNO9MHkzvNyLVRp5NOQEZkdptsyvE7O3tWFwTA3YgP3UDlR0DGoTcjaFyRH4zXEt
 Oc/PAdYZx/2WGwFeZK4O6eGKBRDyOlzZOAlNYWO6gMU7ehsRKr1EMUbZs5emEm49yNbk3YIP
X-Proofpoint-ORIG-GUID: OxvHgr8wK6HvOk27nQbP9Ozm4jKUHvXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 9380766548..25a1dc0529 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -65,7 +65,7 @@ static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = pba_reg;
 
     vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
-    msix_reg = &vdev->pdev.msix_pba_mmio;
+    msix_reg = &PCI_DEVICE(vdev)->msix_pba_mmio;
     memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
                           "VFIO MSIX PBA", int128_get64(msix_reg->size));
     memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
@@ -86,7 +86,7 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
 
 static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
     VFIOUserDMARW *res;
     MemTxResult r;
@@ -134,7 +134,7 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
 static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
     MemTxResult r;
 
-- 
2.43.0


