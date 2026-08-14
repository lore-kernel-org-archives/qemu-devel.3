Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF4FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8K-0002EC-Uk; Fri, 14 Aug 2026 07:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8J-0002Ct-8F
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8F-0006hb-KK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:30 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdTAB1547207; Fri, 14 Aug 2026 04:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OuWhIPCmGz2Q8KazxFpR6FnzcqEU3UwI7YJvUGgri
 oQ=; b=QBeAELH8k7m5wuTBJi2HMchWa7pdS91vS3Bzp+tbPJIxHQx7g8cVwhOiL
 +E/0tHQedei4/ocjRQ/XqxWZ98bFeRPFUiIzZhPqol1Aa71AqElSqhibyXcjYpa6
 tLHOFKfsr1AFyi/RUEXOw9L1sxElHZzx5FKwV67jtiRn9qG9AJjpSucxxmzNB/qx
 jpFwnvsPwJfcc2UA/DwWqI1R7QDiHp8oKtbY+ZS5XFWPbKy8/SrjYS8YK5npgELD
 b/3PHHxVvrnN4wdCVUNm6EaOkPx8yDLmdcz9kqO+zQqK4xlENKph7sAXp5FXEUxr
 RXhb33AVKfuAic+H7MjX+eaRgi43Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p1d1dx1-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoKQBHEWhX+HNmkaGkVvAyPncyOxJC2jWmMBXpvZB5NhX3ouY4GEEXorTmHgEDKPt+yjwUFD1UzlQVsNecRRW0fbXXQpwMJn5aILY4Jm583GKqjzpm6sMFxCJodxAeN81YUwlogakAuiYaJCJfQ7ZpOurCeYeH8Ce20WqXQZIOQ5CHQjNuA7m4OESOiiejxIxwr6c67wHNBizO9N6tu+6RrQiLFqGiZrER/KiM4REv/SA200GdOE8sioCHMka0N0moOb8PDXb4VjKYQICxAOXswogGg2HkUbsmbRpFvM5TMiJBmT7KBNnpgjplnsaHGi0FzIDP2NjPM9C0WXQFBicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuWhIPCmGz2Q8KazxFpR6FnzcqEU3UwI7YJvUGgrioQ=;
 b=dz4Px2BD21RO5a37FTfcnDJm7A1+vz+Py4WT4SMLre8lfZ0ZGA1eiPvAXxaICegq+4IliSbtwjvo7hBLhil7DNckAL0NeAfguVEap8mRnP/Sx9Hyq7RuiNbapLq0of2khQEcd/nMVYFVz1MEYPt0jKIzLdL2skN3Lpzg7tB6OLD8I7pLwPIrnLDdKiQTAUHM8+UA3NS8ZKeNG7pjfcuvr8pb22tRdhmuDyE/TejLwT95OY38Eq9+n/211IhCQvUk8cXU3uDJhVpLOhbUDBfjrqpP5Fo6zrfcUJs5M8Z7g/LakNhCw/JD7OS/Yr4jLCkscXBZKTOkxfk2Vte7q0Hg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuWhIPCmGz2Q8KazxFpR6FnzcqEU3UwI7YJvUGgrioQ=;
 b=V0NC8pANxdcLgMDii5BHJOHJLiO0HYpDNuECwre4lukN2q9/a8egG02B83YZeOXcEK+v6eXL+iS/6UnQkYjJnyczsDSqM+vL1nd6NRxRCmdxEnBoxBvJiegCnQPUo8ctNE7Ic4xzaebg3UQqzhuw23D7q/aTnCIpQKS4WudEiteRktiwTVy3zpk3UZ9zH9CGq6XfceBSTCRRphF88fQTW6FO+a9itySepgN9vNHMZ4D4r1YjjgofFjQxS9taYz+9co806ehpUPTrI0Xn01EA6tOuskwXfqtns/adbtNkh7cUHYDRevPDkYk2RoX7krvo8R8RRpS45grC55LeG63Yow==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/6] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_GETTER(type) macro
Date: Fri, 14 Aug 2026 12:30:19 +0100
Message-ID: <20260814113044.2416794-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0544.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: 451bdade-2c4a-459e-b4b0-08def9f78dbe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oAGtzVlVcPcIFOTEGdSmoYk9ggIZcvvrFUkpA4fa0t4LbIuIUBH+oAiGHDqgUhLjwdmIbs3rKH7nz03V/ZfjOArx5ytIxjkA+3hlwgAK3Dq9k67/2zJSS0k+NY7ND5kSwLLy3lrgYG6MYyeasWY5Gp0j0C3DgWPD5cFGdsKjFoCNqNSKYMUcz8ABydTujRoM8qkosE5pamXdFfIz/FRrcdh02WjaviHGp0H7FBXsyoUAfcCBzC6QZdBqHeYQ+5elgyoRmWat0WqCSAMAcf1jlwtgae+sLKkaBioxgDfPHjEX2Ld4ZgLqIKtsRRoRlDlmzJuW7WLRZbgBt3zbRdLgf62pMQwanDX6Gegsx8imEmfBooiVrmxHUAR1dty+fJD/NZiInPkN4LCEBv8/IlkJp10JVIKkITWE2ELZxznSOLdgt9i/QN3BdZwrCQC0DEj7ohxs5VGibc7H3Vy1hhOga5Gl6NcCW0GQp7zGnE1xNd/7dODmxtVqhbA0dAYoOV2RuuIeJPEy72Up8GFmOLr5JcnIUWWHJ2DYYlki8RugrvjHns+KMOgMaHLa6bVeEx1GjeeQgATHwnJWmIolajUbORDemCiO7pjcxCzlvp4wyPXxMa8zKCNB9aYeYIVod+rlQ1p7ItDgGtfYOVOsKvFuqBgBpb4R8neyJ9Luqp9klQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M29abCtmTkk2VCtudEpVSU4xajVFNHkrbE9Say9RS3lYWHJaYjJCMkxCWDR3?=
 =?utf-8?B?Z1NrWTkvcTRIYy9YeDJDM29uU0wrVUp3alRvZ1k0MXFkTkpRNDNZaXdYZXV6?=
 =?utf-8?B?TmRpNCtBaUozMGxHcGJQS1hPaFpQUnhDeWRVK3EySjRkOHd6aDBUdVRPMC9U?=
 =?utf-8?B?c240Sy80S2RHMGpOVjZRN2RrRHdxWkUyeGNGSUtBcG5xTXR6SkNKY0g2Rmhv?=
 =?utf-8?B?OXlHSnJDQ0hMaTJJUllibnlQNkZvVGFMUkxSWEVVVW5wcW5paUlVbS8rTFhs?=
 =?utf-8?B?bU82YlMxUDdLZTB3emd6Wk5FRW4xcXRQOHNnUStEYU9BWVlvN05qc09sZmpT?=
 =?utf-8?B?ZXpBclorQzJkek9mcUFkS2IwL1ZqTkxtWkxIQURsSVNnWE16K3FjcG5kUlIw?=
 =?utf-8?B?QnNRNHV5L3h3SjQyTkd5djEyMFlneEhOeVNkRTE3SGNUT1ZKQ2JZUXFyRW9n?=
 =?utf-8?B?UUdjK0w2TWxxdEV4aHpSblFkd21vT3Zvd2FTNXJJQTZHWTcvYnhjOFl2aW9j?=
 =?utf-8?B?TGVVTlBiS3dZOGcyMkpGRWJ5MXVJQVo4eDJhbFgwU0NHSEdrdEJZakIvNWN0?=
 =?utf-8?B?NktNRXJBeW5zdHlNK2ZPbXY1ODRBQjZiNkkvRmpuV3JEaFd6L29PUVlvR1Fs?=
 =?utf-8?B?NGwvb25pbytNRTBXMCtXdHZHTm5ZMFdGQlBjNjdPZk9zeXgvQWNiVURZOUlz?=
 =?utf-8?B?TXpPV3ZvMUNsQk1vL0ltNzlCWkhVayt3dGh3Q25wMjNFZTNkUlV5cTlZK1Vo?=
 =?utf-8?B?VzZ0WUZOQjNtdEp5Q2w0UUNkMFBrK2liZXprMFNFWTRSV0IvTUpZWDkva2NT?=
 =?utf-8?B?V2NKellKSXowa0FUMGtzME5ob0dmN2g4elAwaWV2cGw5bDRNNGVwMkNVeXZX?=
 =?utf-8?B?L2RyeWpuait4UHRXWHZncy9IaTRUVk14ZGNzamRVbkdHTEdrQlY3L25hWDls?=
 =?utf-8?B?YlE3YmJhekppSjFiUmJNcFYxaFFhQjlnRStSbCtXVDlnbHBrWjQ0ZDRzU2hQ?=
 =?utf-8?B?Q0YwT3VwVkNkbGcrVHpWeWxXNXJGemhxc1FhMWJFeG9Gd2ppcTVxaTNWSmhJ?=
 =?utf-8?B?K0tWUGh2V0lURC9rMWhmbndCK3VGRkdVRVdzNm1yelhhNTBvSUJ2TkVlTnMv?=
 =?utf-8?B?czRtK2hDL2g3blBBWGt5b3ZYVi9pL1YyTVpoaEQrVitlaXpUamQrQjkwYTZk?=
 =?utf-8?B?Qzh4Q2pmak0vK3lWb1pJRGFjcFF1RnZjN2hVNlNsY2lUcEdFSk5WS0hFSE5v?=
 =?utf-8?B?Q0hqMDYxblFNS0trQlBCSGIzRSt2RW1oRTMrTmVlSWNFaXJ0ZWVhV2hJY2N0?=
 =?utf-8?B?bXltZFo3ZVpnVmdZT3dBQUlhYzR6ZThaVmlDb21WOG84QU9NOW1SeEJYN0Uz?=
 =?utf-8?B?WW9HTWdUT1l1UTJzRzZKdjMrK3FlNWRuK1ZaRGdtN0N6MTFDWEl3amZmU3Js?=
 =?utf-8?B?QzhHd3EwdmxMT1NOY2oxdlVVcGN5czcwZDlQNzRtdjROdVp1QklsVEpranVs?=
 =?utf-8?B?NWo0WjQ2QmdmNC84SFRFY2JSVXNJODdzMEt1YjVyaGQ3RVY5d2FXOUtZZ2VN?=
 =?utf-8?B?Y0NlWmtMTzZmNEw1TTdNVE1FOWpZNVg2NU5YVzc1K0EvU1lBYW5YMGtRV1JD?=
 =?utf-8?B?dnVqWlZwc0ZaQXB1RStoZjY2TkV3VXZ0cFRXUFZZQXFtRjNWeE5nU2dTVXRl?=
 =?utf-8?B?ekxpb3VjcUNrRWxTNzN6SnJJSGJPNUhNd1Z2MThoc0hKUDVKSk5YS3BhbnZv?=
 =?utf-8?B?YTdNczBlYkxRRUNweFM5MUFTTDZ4STdYT29QUGNzREZiWVdZSS9lL2JxZEJD?=
 =?utf-8?B?RlUyREFrV2ZPVVJrU053OUxkY2duRlBmd2szcmlPbDloUmtGTG1EZVNpekx3?=
 =?utf-8?B?Q3hoMlRxZXdEcElQc0Z0OWpheEFBOWpvUW1xNloyeXRySjBlcVNBeitjbTRH?=
 =?utf-8?B?WG5nMmdySUEwQW1RWEJrN3FnV0pNUkkveld6Yk1KQWZJVkhuV0FNeGlEZEhM?=
 =?utf-8?B?T2lsRUxHUE9PRWJrOE1yZkJNVEFrYjB3aU56TFpKODM2RnJOL0pvSVdWMWps?=
 =?utf-8?B?Zi9HMzVJbWZYOTBRMHM1ZFFYc1ZEWmlMbktscXhCNFZ4dlFadGw0b0oxZERp?=
 =?utf-8?B?ZFRMODhoUnd2SzNkWW9La0xieDQrMEM4N0drYzdJUEEvU3pFVUMzTnlvNEg2?=
 =?utf-8?B?UUJEMm9Fdzl0UWlFNHQ1WlBZNEk1bVEyek42QzBlMGovYUhDRURtOGhvYnZD?=
 =?utf-8?B?VkszTGhxSHFJalhiaFQwY3hJV0hGVTlKOWlIbjhNMC82NmlBSENidjNSajIx?=
 =?utf-8?B?YTRZc3FrcDYxYjVJSHdvTEJzMVB2V2o5UmhTS1BYeXVnWFpaRTBlUGpKbmt4?=
 =?utf-8?Q?8gTnX/bkHYjfaKPI=3D?=
X-Exchange-RoutingPolicyChecked: oSe6N8rg+Mnx1RVQj7c5PsUtvYWP35pcgevVSX4oehxZyPGvgP4V4dGi5MT7bhSs5yKWKh2h1wq5dbVLxAGbXBb0GbftLV6RZnWSwFl4BHIK1DfKPFgjFqQLvMBEL5QTkTn4liTvgXAuFVMQdxIxdKqWOME5KoFUUHa0J9+Z/HilJAyKJG9Ri5g/1O/T8/wLXlvGAhFyUdJDTqenUESO/o6oR2YgZoyCugQRRrKpcrP1k1oJnvEkHN1DdhcUNxr/01Fx0EH8o0zLsGrs3KCkymxmjhasr/bT6TeAcZDZbPCBiKWfRb/x5x80ntvt7XJu2uw2yP1a6kjB640tqdhe2A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451bdade-2c4a-459e-b4b0-08def9f78dbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:16.5995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAjfDWs7Yhz/AoFC7tynb8LS1i/4cTZq8ae46ZBwc3KDoR1HB5d5dMX1zTBEvvqnh+v4WyYjlFiS4BsUWEc6+L02GJTF2upj1DKWE62bjyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX37QuHK97r/ds
 44j4ZfW5nXNha0NgMk84P5Sr2mVnpLt6XsO3NpKzRBySIYmfl5EBoCqqdxi30OTmDgrwG6WmYFs
 oHp646nIFOvdOK1l8i4869yr/kq/iYs8VxVt7PF4gljtAzoXAGkLbGzptFmpUbRKRzkXVaQCXkG
 /GpDSIxwgLcTznMrH9eGbTOKcK3SVIuUzJIL6Rkww7wN2/WuRfhw6XhGXmB8B4Mf/+IfLHeNsSP
 ih0c6Na0Pj17mBjNkV67YKnvzb/iobkAjAmaATZ6LIRROJg8ybnT6jyn/0Hu+ug7y36zUWmccC7
 6T4ecu9C69Ss7nOmYZZMrkP12L4LyjJF8oapNGSSGww714K4MheJerjdk3DJkSxOKwjTa1yUczW
 y/zxXpdpctLqs7JAuza/JgrUXwnCP3g2oACYbjYRhWcKLbKwchFJMv2+zCsuP4G7Fs0zSf+I1az
 yCyK3VgmVtd8o2z43yg==
X-Proofpoint-ORIG-GUID: 9gbtH6k5OhtkfO_LrIG-f7Q5-V_EI0ng
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX7Yq5sHDCo+qv
 nNq1cxbnjxVweq4klLj0aYI9Zfj9Fc5xYl6BzKWr2JzldwehzHFLkU95t+n5dD8gN70RWxStYV2
 RMEen8hAj3DWTZwv8eYjz8u+NgDfZYE=
X-Authority-Analysis: v=2.4 cv=ApbeGu9P c=1 sm=1 tr=0 ts=6a7efc8b cx=c_pps
 a=Sq/50nUKxlEOOe6u8VXKPA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=DsYRqU8QP4ptd1Us8l4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9gbtH6k5OhtkfO_LrIG-f7Q5-V_EI0ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

This macro can be used to generate the boilerplate property_get_type_ptr()
QOM get function for the specified scalar type. Replace the existing scaler get
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260717135254.508701-2-mark.caveayland@nutanix.com>
---
 qom/object.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..34aef7ca9f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2661,12 +2661,20 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t value = *(uint8_t *)opaque;
-    visit_type_uint8(v, name, &value, errp);
-}
+
+#define OBJECT_PROPERTY_SCALAR_GETTER(type) \
+    static void property_get_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)opaque; \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_GETTER(uint64)
 
 static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -2681,13 +2689,6 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t value = *(uint16_t *)opaque;
-    visit_type_uint16(v, name, &value, errp);
-}
-
 static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2701,13 +2702,6 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t value = *(uint32_t *)opaque;
-    visit_type_uint32(v, name, &value, errp);
-}
-
 static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
@@ -2721,13 +2715,6 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t value = *(uint64_t *)opaque;
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-- 
2.43.0


