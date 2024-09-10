Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BD3ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snz4A-0003BO-T6; Tue, 10 Sep 2024 07:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1snz42-0002gd-WD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:29:43 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1snz40-0003UJ-Fs
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1725967780; x=1757503780;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rDzg3jUXucS5DIoirwrNuxr+JWtn7Tdgfj+FH85A5ec=;
 b=R7BWIXgop8kyTEqQTp6mXX6Oh0+5K+9w6vQx5te2ViLDQ9oxnPkX6U9l
 03pu7/zKEYhZ4vLuIUcKb5vuiu6GYriyd3tpMvL6CRwEW28qdQ1e6cn2Y
 Pn+OAIasDSJdus6kZaqOjeLtIBauvunyZtijGBqTY4eWULvSJZHccjmJe
 /VgWYjxUN3Q0rJu6Wdz/Rx8Atb+l6n27QW8/DkHfxehUwrOSNn+dZpB04
 8YSi8X3EgnT+LsusUCl5FQUyRQAc1r6n0N226MPURM6gFVMht2/+2E0E2
 95WHZ+bLSEIDT4lW4kjNR1i+gzfn3prTYHU8SK9YxDZesNzyoViyJnAkn g==;
X-IronPort-AV: E=Sophos;i="6.10,217,1719871200"; d="scan'208";a="19998642"
X-MGA-submission: =?us-ascii?q?MDHaf+yEvq7FVnn+Qka1m2RNZtZmX/2xiK7BLA?=
 =?us-ascii?q?p4Fhlyt9OtKtuG2GN3NKry0zHGSAFfYUoM366yBne+rTipjl9BxAnFuS?=
 =?us-ascii?q?fIX9PCBTBkdd8Qka/njANMUuNva4I0bCfjpSyX/8GQEYB6f6Ohg8v7NR?=
 =?us-ascii?q?+ZhS6ZdUCPDzOy2XgnDEClzw=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 13:29:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgEmvLTTXXFN4hogwhKnhEavHJOvhKamHllWZlPwmKW4mT0MWzclzawWzDeHXLEfs8a+i0Nh9amMjvHO2NQxXtOu1yfdkur4R+9md0GWTv5b1vwVRA1/wlNLExaKcpYa4n5zWu1kqvCxMTCTK24Q9nl5rwdiDdOD312ymNWH12rNaxaTi1rMzy9/N8MSidn0HwauqDGjiDL3CbrFgkFrvQ0TRy7f1w/n/t+DT2yO/kIVKaYpoVYUoTXUNOh+jdonF6+UjpIujF9L3WpyoUq7sic/8d8pGR6+2dOMSOuiftBisU2VjWLR9dVd/csNXV1rap96/D3tYhLXAWZ0NzugOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDzg3jUXucS5DIoirwrNuxr+JWtn7Tdgfj+FH85A5ec=;
 b=ezPnZ0M6ENGmWBlsFeImoQy+1Ggzzc1mcMkYGrSh7R1NLBW4r2VfHkzBqyNHs2iGtXtx2XA+VBY4kJdqXsFeyqjfjf3FEZ9TICKP0lG/q7ytJDkyFNgbjoXIPVvDX5kXXW2QwHQRFS2RHOVq+V94s3EIix/5pK04yIt8DmVzTe3xFtD4CzKo7Hrrhdz5bQ5IgHssJKhW1Qa/PWuAMllNn8PxwwiIUyueH7yokakvQqkxMqnLCI6Vj2wkTC5UyrFrSYlYDwvMTZFuxXVDxsg7D1LOAKs3h1M6xPkgCUG3TcpQJoXTZRSqMtlgvknL3PawNposbMxORgI9nDUZPKD6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDzg3jUXucS5DIoirwrNuxr+JWtn7Tdgfj+FH85A5ec=;
 b=sjq4VcPWfQDvK2Dfismisul+6pCganO/uK1ZpKgzhcd23HAkOy3BageIhYoEH4xJhcJ5iv/a5rXy2MPsagDMQrn0QphyS+JhnG2FgcnIfWJs77L2hQevpGE3o/85sa4BmdmdmQDOEOvthirzqGOZwxfDXT6Ir7WuopLhCVnBfUPC9r1b31clp3U2np/vxwI2yuXvBNI8346pmWiGeoRtl9bbfgCRotklnf8N455liR8GgJkB3+ihn+LF4Lj6LINpbB1L8+tUjO4hgQBY8qo92dexIzDTXqOOUKwoSgKewN8D78WnR+Rvq0xG65pkl6wMRrDgO4Cb9W3nHGz51Mi9Vg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Tue, 10 Sep
 2024 11:29:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 11:29:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHa5wDtEcfO7BXpnUKTeADC4BVNOLJRG06A
Date: Tue, 10 Sep 2024 11:29:34 +0000
Message-ID: <edba8c59-86b5-42ca-ba69-d3160609aaed@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9688:EE_
x-ms-office365-filtering-correlation-id: c047f1a5-f9c0-4265-58ac-08dcd18bd864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OGV2YXNYSmpaSUZjVytuUExoeGJGTGo2VUhnQUVxM2lKUzNuZTRzN1oyL0Yr?=
 =?utf-8?B?cVd6dzliNE5LcitwQm5ZUzN5SjM3WjhOM1BKT3NBNG4wSENIamFZejczWjgw?=
 =?utf-8?B?SFpCUGQyaTBaQUoydFFIYi83MDF6QVV3RDdiTnVUMEdpS2taYzdrc2FYMWtJ?=
 =?utf-8?B?M2U3dVhKd3U2cjdVNWFTbFc4RWYzVzhPRlF4L1ZjZWR4NUFBNVBhNDFWZy91?=
 =?utf-8?B?SUF6TW1ZUGVUZzkzc2hLaUJaczJ6clhpMGNrUXk2Qm85UzlCc1ppV0tyMDNn?=
 =?utf-8?B?Mm81LzFXcitkdHBmWHRVL0VKMjBZNlQrWWVydUtiWWliK2R0QWdreEJpSDAw?=
 =?utf-8?B?MWFlQ1QrYnNlK1M0dFlDaFJsNTF3NHdlTUdDN016cWZPYW9NVUpzTmtTQnBm?=
 =?utf-8?B?bjdZLzRDL1ZjRnVXNnFtY2tHMldYQkwzQUVvSzJEZ2swejBRWlNlNnRqOGlX?=
 =?utf-8?B?UDFUZEdickZzQ2taL3Nud04rTUFGNWZIWXlhRStaNC9LUENlRHBjaTdRTlAw?=
 =?utf-8?B?bTdybWt6SFpDS1JwTzk1cHp6d0p1UzgxcGpXb2grY1FTdTl2MjJhL1c2b2c0?=
 =?utf-8?B?SHplaVZjR2dOSkUvOUZIaGN1ajl6NTJWY3NQYUVvY2o2eng1VThwZ2JyMXds?=
 =?utf-8?B?bmhzbVlzSWpnSXliM1JHU1laWmU4OEJVN1BRVVRPem43VWc4akpmTWdmSC9l?=
 =?utf-8?B?WjN3c2Z0eCt0RFhySi8wTGVka2x2cTE4Y3BjK2RBTkt0TFhrTGhtdEUzdVQw?=
 =?utf-8?B?Tm04TDJHcGcrWmJWYWxQMXdnMkF5RmdwOThacXkyMEwzU2haclA1dEF0TTVj?=
 =?utf-8?B?cEcxNVluMDNlcnpHQjQrRGxNajJFYnpLdmIxZWZwVFVmMFl0clpKQldPUURL?=
 =?utf-8?B?SnA1Nm9VRTBwL0tKaUFxMWtlMkx3TG9PYnhGRGZxUkpIdUtNNll5RzBEQXll?=
 =?utf-8?B?OEZ2UUxsV1prdVdwbjh5bFd5dE52b3ZQaHJDVUF4Lzkxa09paDRydVZsN2lR?=
 =?utf-8?B?YVgyQTdwek9IYm8xaTY1NDJLVW5DMTNRL0pOcXQxeGFNNGo1NklOdTl5L1Zq?=
 =?utf-8?B?N1VFY0lTSkxFRTg2Y1FocjJoNE04KzZyT3FsTktHMGNoaUZmR1ZlcUtyNUtP?=
 =?utf-8?B?MjVIMjVlYk1CSG8wcEk5a0hCVlYyWjR4ZkMrMnlyaFNOU0NnRGFjNXpHOEUz?=
 =?utf-8?B?MUxwOFVhOUJmRDAxQ1FGWHVMbjZqUlJOR3pnZzkyVHBJK1VhL1hrelVlVUFo?=
 =?utf-8?B?eW5MTkdTR0QvRVI3aDR2QlVwaEVnV2wrMWRSZCtqM1hObHFhSEV6TlNoVDVi?=
 =?utf-8?B?MEpHNWQ0VXp2cmkzczFZRnVpb1RRZFM4SjZEcG5McldUUlZqc0ZMNHc5NkM5?=
 =?utf-8?B?dmFmcEZ5eW11MTRhOUNJSDZrRVdsUEY0SGkwTFFZQ1lYbVdjVDNSa3d1R0Rt?=
 =?utf-8?B?bDU0THFkQlhlekkrR2FoMG41dFNRRXlCdzUxTFVuZXJrbktJSktIdGNId0FP?=
 =?utf-8?B?b0tjcys2cWNQSHBRYzlnend3L05PZnR5NE5ITjQrVXF4cyt2SDJ6VXpnblhm?=
 =?utf-8?B?ZS9MVWIrc2NoZjRGeHAzREdRS2g3U05lZy90RW9lR3pDWXF1ckt4TGJUM0R6?=
 =?utf-8?B?ZnZNbmY2Uk1YemR4Y3BYMHNNVGZHek5DVXlMRnhzOFU1THdleU1ETTJkUGU2?=
 =?utf-8?B?NitUQ1Iwd0tvZDFTRFRIVW56a2V3Ykxma2lIcFU0MlZ3S2ZiN3dsZDJpNHlC?=
 =?utf-8?B?MWdwVndoUWszMWhDVUkvRGMyZVFEcFR5WEZFUlgzcTV3M2dISUdEMTB3UEc2?=
 =?utf-8?B?WHphR0ZYdzl6d0NXZU9ERXRucUdMc3ZpcDlsV0Y2RmNOZFNaS3gvTm5Wano5?=
 =?utf-8?B?VGxxcld1RzdnYjAvT0s3WnVzQ2huUDdnak1RQzFYVGxab01Nck5hUUFhb1Rt?=
 =?utf-8?Q?dC/FETN85dY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0czMmxVMHNpOTk2QWlLdFhjTWZMQ0xIOU5IMnpveUFsL00vRFg3cmw4VTM0?=
 =?utf-8?B?SzNPeUFmOTNza0hoQmM2VVZrZ2lWRjRndjBTL3VNOUdUTXZrcjJ2OTBndHdW?=
 =?utf-8?B?RkhxZkZFLytpS1hkS2J3UllrMUo0QnNIaDNIc2dUcHVOZlgwS3MrbmJYcG9T?=
 =?utf-8?B?MDdFNWlnS1duaWIvRnlmQlZvTjZ5QjYxN2UvUTJQWlVlazZ6SDZjTXRRT0Rx?=
 =?utf-8?B?QS9yc01XZmVFajhsVlJZQU1pOU9wRXd0MkZmMHNMNzEvNmRHZ1A5T09oa0lE?=
 =?utf-8?B?Q3NtTWh5RURNbW5yRklWcWZpQ0FtaWd1UG9YT3ZGS1JOVHNFUmRwZk50K0ps?=
 =?utf-8?B?Y01sYXp0QTBZaEYyb0hDbkZnOEZaNkY4WFFjTThBSDk1emZyc1VFMEt5RCtn?=
 =?utf-8?B?RGFKaXVRelpsdXVLcXZhYjc3VlpKcEpsWHhIVGlpTWU2d1ZMdnFKaGcxbGNz?=
 =?utf-8?B?bTY2eDZXb2kyY1d0R2ovUnJBL1RnZXN4UmVoME4zVlJyaVRvVnVETEk4K0Jv?=
 =?utf-8?B?NEUwWVlBUHdKR0FQV2NrcXYxV3ZOekd4N2lxSm81WFEvaFUzMGRpRS9SRWhM?=
 =?utf-8?B?NWVxclhiOHd6L0Z1a0IxNGI1VXg2RDVSNGFZMDdZRnBWZjJ0Rm1tQlZhWFJ1?=
 =?utf-8?B?VzlmQ0grcG8vZXExU0NSUW1JVG8vbEp5ZXpZaGtUMmhnM2Q3R2lmSFgwMU9B?=
 =?utf-8?B?YzIrVUFMRmxHZkg4QlJMdE9ydjRFdXRLZmlWOHpXNkZNdWNWbkhmWHZuWThB?=
 =?utf-8?B?NXgyTUpGcXBnMkNqcVdmc0puZm5tdS8rT1NzQXptZEF2N2hiL1FoWXVPRkRj?=
 =?utf-8?B?clRCM04veUtpcU44M0RMVlJYRkI0NFJkdlZ5SlpIQmRiYVFIQ0t5R1NnTGZ6?=
 =?utf-8?B?Vjg5WjVhM3NVd0FFYXFwN2E2N0NUMitMMVAxdHFUd3A4L21jdXVuL3VSVmpl?=
 =?utf-8?B?ODZuKzdSbCtFZUNVa2pDTFdjV3JzTFZzSmpBQlFiNzNqRTEzWmF5a0tRWC84?=
 =?utf-8?B?d1BCV0pyNDluMWlHOTk5L1RMbjhrbWY2OWVRNy8zR0RtV1FNbThER0FrM3VR?=
 =?utf-8?B?OXRKejhqeHM0U05KZHBYcnlKZXNiZDBmVGVnelhVVkNsUnJaQWZXNSs1UEFY?=
 =?utf-8?B?VXl1Wk9CbXR2RjFHWTN3b1BkU2JUNnBXd0R1Z0FPRU9YZGdObW1DOHkwOG5m?=
 =?utf-8?B?NklkL3A5bnRKclA5aWNidG5UN25heDdmNUxncVJmZE5GY3NKQkJya1dzbWo0?=
 =?utf-8?B?eURSWlRaTHM0dnhUOHUxdzdNbGZIWHUrMWlwY1l6bUpFM0VXVllWRHVNaVZS?=
 =?utf-8?B?c1RremlQRmg1bnhYS1AzSEVxcHE4MHJsa0JmS1RhUHExVkgwT3hpRUhCakdE?=
 =?utf-8?B?MXBOdHRCbGlTYituVUpjUGJ5UTBEYWhrN0Z3T1dIM3VGdWZwQ2ZveStkNy9D?=
 =?utf-8?B?cVRFVksvMjRkZ3g5Z3p3Rlg0WTNXaWJDMXE2UTA2Q1IvOU5OckpsNmNsWWVj?=
 =?utf-8?B?WGFzMDR2Z3NYd2hxOTBwWXE3cFcwQTRhU0xMT3QrQmFMS08zVEhBdkV5NjlL?=
 =?utf-8?B?Ui9wUERpdGZEdlJwbEhZL1dWeDNvUWIyUUxYWVJNNFdiZDNlZHU3S2VLd1ln?=
 =?utf-8?B?SG9Id041Tit0K0MwQXNXOTY1ZlBKREx2M2orWEFJSGxzRGxLS3RYNitWUENJ?=
 =?utf-8?B?VENyOXRQMGUwTWd3dG0ra25IVHV6N25oQnRDVjR0QSt2alhmdmVvTGZvN1hX?=
 =?utf-8?B?dUhPWUE1K2dSQm9MU0h1djloZk9nOHpmRXowclZscnRqTmdZMHBadHQzU0FS?=
 =?utf-8?B?bUVpcGZSNlRxL0V2MzVyZVpkY05aSVBINGYwUkJtL0RtSk94Y2txd3lIcVRk?=
 =?utf-8?B?aHAvZE8vS1FrMllQZ0VteXpSQ2hVOHNmdGZvU0JqU3RzNzRLL0hQVmdYWkhv?=
 =?utf-8?B?Mi9XVWlIOGt1VE94cndWWE02WWFmbkhuekQwOTg1aG5ablVNb0U4TURTeFUw?=
 =?utf-8?B?UGxVRk5OUlZTcFVWSEV5ZUhvOG4zRWcrS3BOZTVYeVMvckFTUDR6L1I0QW83?=
 =?utf-8?B?QWpHM3JaeVJwRFNER1lWSEdCSXpYQXJKMlVOem1JYXY0VkFlNktSeGJYeHRh?=
 =?utf-8?B?dHlqMkFoVVI5c0I0cWwraFpNSElId2NGaU1pbld4aDVVRFZsN2VGZTU2YWdz?=
 =?utf-8?Q?1zwwuh+CG3ZiyLdF2dl5ugU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <482D99B15AC429448BA51A6A1580169D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c047f1a5-f9c0-4265-58ac-08dcd18bd864
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 11:29:34.0717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGNeLP6MZtAer5EAWswlPbQlRwoVz189LkDCXQ4I0jumLJm53ffxEnt4IRbA1KXtfGTtSxfP6PaGSj8FunsaK9FzQ3jX9ADgEqkdjDLP9MKG6O6RaJqUslereks7co3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9688
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgWmhlbnpob25nLA0KDQpEbyB5b3UgcGxhbiB0byBwb3N0IGEgdjMgZm9yIHRoaXMgc2VyaWVz
Pw0KDQpUaGFua3MNCiA+Y21kDQoNCk9uIDA1LzA4LzIwMjQgMDg6MjcsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBz
ZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEhpLA0KPg0K
PiBQZXIgSmFzb24gV2FuZydzIHN1Z2dlc3Rpb24sIGlvbW11ZmQgbmVzdGluZyBzZXJpZXNbMV0g
aXMgc3BsaXQgaW50bw0KPiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIGVtdWxhdGVk
IGRldmljZSIgc2VyaWVzIGFuZA0KPiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIHBh
c3N0aHJvdWdoIGRldmljZSIgc2VyaWVzLg0KPg0KPiBUaGlzIHNlcmllcyBlbmFibGVzIHN0YWdl
LTEgdHJhbnNsYXRpb24gc3VwcG9ydCBmb3IgZW11bGF0ZWQgZGV2aWNlDQo+IGluIGludGVsIGlv
bW11IHdoaWNoIHdlIGNhbGxlZCAibW9kZXJuIiBtb2RlLg0KPg0KPiBQQVRDSDEtNTogIFNvbWUg
cHJlcGFyaW5nIHdvcmsgYmVmb3JlIHN1cHBvcnQgc3RhZ2UtMSB0cmFuc2xhdGlvbg0KPiBQQVRD
SDYtODogIEltcGxlbWVudCBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBlbXVsYXRlZCBkZXZpY2UN
Cj4gUEFUQ0g5LTEzOiBFbXVsYXRlIGlvdGxiIGludmFsaWRhdGlvbiBvZiBzdGFnZS0xIG1hcHBp
bmcNCj4gUEFUQ0gxNDogICBTZXQgZGVmYXVsdCBhd19iaXRzIHRvIDQ4IGluIHNjYWxhYmxlIG1v
ZHJlbiBtb2RlDQo+IFBBVENIMTUtMTY6RXhwb3NlIHNjYWxhYmxlICJtb2Rlcm4iIG1vZGUgYW5k
ICJ4LWNhcC1mczFncCIgdG8gY21kbGluZQ0KPiBQQVRDSDE3OiAgIEFkZCBxdGVzdA0KPg0KPiBO
b3RlIGluIHNwZWMgcmV2aXNpb24gMy40LCBpdCByZW5hbWVkICJGaXJzdC1sZXZlbCIgdG8gIkZp
cnN0LXN0YWdlIiwNCj4gIlNlY29uZC1sZXZlbCIgdG8gIlNlY29uZC1zdGFnZSIuIEJ1dCB0aGUg
c2NhbGFibGUgbW9kZSB3YXMgYWRkZWQNCj4gYmVmb3JlIHRoYXQgY2hhbmdlLiBTbyB3ZSBrZWVw
IG9sZCBmYXZvciB1c2luZyBGaXJzdC1sZXZlbC9mbC9TZWNvbmQtbGV2ZWwvc2wNCj4gaW4gY29k
ZSBidXQgY2hhbmdlIHRvIHVzZSBzdGFnZS0xL3N0YWdlLTIgaW4gY29tbWl0IGxvZy4NCj4gQnV0
IGtlZXAgaW4gbWluZCBGaXJzdC1sZXZlbC9mbC9zdGFnZS0xIGFsbCBoYXZlIHNhbWUgbWVhbmlu
ZywNCj4gc2FtZSBmb3IgU2Vjb25kLWxldmVsL3NsL3N0YWdlLTIuDQo+DQo+IFFlbXUgY29kZSBj
YW4gYmUgZm91bmQgYXQgWzJdDQo+IFRoZSB3aG9sZSBuZXN0aW5nIHNlcmllcyBjYW4gYmUgZm91
bmQgYXQgWzNdDQo+DQo+IFsxXSBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3Fl
bXUtZGV2ZWwvMjAyNC0wMS9tc2cwMjc0MC5odG1sDQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20v
eWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9zdGFnZTFfZW11X3YyDQo+IFsz
XSBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVm
ZF9uZXN0aW5nX3JmY3YyDQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4NCj4gQ2hhbmdlbG9n
Og0KPiB2MjoNCj4gLSBjaGVjayBlY2FwL2NhcCBiaXRzIGluc3RlYWQgb2Ygcy0+c2NhbGFibGVf
bW9kZXJuIGluIHZ0ZF9wZV90eXBlX2NoZWNrKCkgKENsZW1lbnQpDQo+IC0gZGVjbGFyZSBWVERf
RUNBUF9GTFRTL0ZTMUdQIGFmdGVyIHRoZSBmZWF0dXJlIGlzIGltcGxlbWVudGVkIChDbGVtZW50
KQ0KPiAtIGRlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0cgKENsZW1lbnQpDQo+IC0gbWFrZSBl
cnJvciBtc2cgY29uc2lzdGVudCBpbiB2dGRfcHJvY2Vzc19waW90bGJfZGVzYygpIChDbGVtZW50
KQ0KPiAtIHJlZmluZSBjb21taXQgbG9nIGluIHBhdGNoMTYgKENsZW1lbnQpDQo+IC0gYWRkIFZU
RF9FQ0FQX0lSIHRvIEVDQVBfTU9ERVJOX0ZJWEVEMSAoQ2xlbWVudCkNCj4gLSBhZGQgYSBrbm9i
IHgtY2FwLWZzMWdwIHRvIGNvbnRyb2wgc3RhZ2UtMSAxRyBwYWdpbmcgY2FwYWJpbGl0eQ0KPiAt
IGNvbGxlY3QgQ2xlbWVudCdzIFItQg0KPg0KPiB2MToNCj4gLSBkZWZpbmUgVlREX0hPU1RfQVdf
QVVUTyAoQ2xlbWVudCkNCj4gLSBwYXNzaW5nIHBndHQgYXMgYSBwYXJhbWV0ZXIgdG8gdnRkX3Vw
ZGF0ZV9pb3RsYiAoQ2xlbWVudCkNCj4gLSBwcmVmaXggc2xfL2ZsXyB0byBzZWNvbmQvZmlyc3Qg
bGV2ZWwgc3BlY2lmaWMgZnVuY3Rpb25zIChDbGVtZW50KQ0KPiAtIHBpY2sgcmVzZXJ2ZWQgYml0
IGNoZWNrIGZyb20gQ2xlbWVudCwgYWRkIGhpcyBDby1kZXZlbG9wZWQtYnkNCj4gLSBVcGRhdGUg
dGVzdCB3aXRob3V0IHVzaW5nIGxpYnF0ZXN0LXNpbmdsZS5oIChUaG9tYXMpDQo+DQo+IHJmY3Yy
Og0KPiAtIHNwbGl0IGZyb20gbmVzdGluZyBzZXJpZXMgKEphc29uKQ0KPiAtIG1lcmdlZCBzb21l
IGNvbW1pdHMgZnJvbSBDbGVtZW50DQo+IC0gYWRkIHF0ZXN0IChqYXNvbikNCj4NCj4gQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiAoNCk6DQo+ICAgIGludGVsX2lvbW11OiBDaGVjayBpZiB0aGUgaW5w
dXQgYWRkcmVzcyBpcyBjYW5vbmljYWwNCj4gICAgaW50ZWxfaW9tbXU6IFNldCBhY2Nlc3NlZCBh
bmQgZGlydHkgYml0cyBkdXJpbmcgZmlyc3Qgc3RhZ2UNCj4gICAgICB0cmFuc2xhdGlvbg0KPiAg
ICBpbnRlbF9pb21tdTogQWRkIGFuIGludGVybmFsIEFQSSB0byBmaW5kIGFuIGFkZHJlc3Mgc3Bh
Y2Ugd2l0aCBQQVNJRA0KPiAgICBpbnRlbF9pb21tdTogQWRkIHN1cHBvcnQgZm9yIFBBU0lELWJh
c2VkIGRldmljZSBJT1RMQiBpbnZhbGlkYXRpb24NCj4NCj4gWWkgTGl1ICgzKToNCj4gICAgaW50
ZWxfaW9tbXU6IFJlbmFtZSBzbHB0ZSB0byBwdGUNCj4gICAgaW50ZWxfaW9tbXU6IEltcGxlbWVu
dCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+ICAgIGludGVsX2lvbW11OiBNb2RpZnkgeC1zY2FsYWJs
ZS1tb2RlIHRvIGJlIHN0cmluZyBvcHRpb24gdG8gZXhwb3NlDQo+ICAgICAgc2NhbGFibGUgbW9k
ZXJuIG1vZGUNCj4NCj4gWXUgWmhhbmcgKDEpOg0KPiAgICBpbnRlbF9pb21tdTogVXNlIHRoZSBs
YXRlc3QgZmF1bHQgcmVhc29ucyBkZWZpbmVkIGJ5IHNwZWMNCj4NCj4gWmhlbnpob25nIER1YW4g
KDkpOg0KPiAgICBpbnRlbF9pb21tdTogTWFrZSBwYXNpZCBlbnRyeSB0eXBlIGNoZWNrIGFjY3Vy
YXRlDQo+ICAgIGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3Igc2Nh
bGFibGUgbW9kZXJuIG1vZGUNCj4gICAgaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTIgY2FjaGUg
aW4gUEFTSUQtc2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiDQo+ICAgICAgaW52YWxpZGF0aW9u
DQo+ICAgIGludGVsX2lvbW11OiBGbHVzaCBzdGFnZS0xIGNhY2hlIGluIGlvdGxiIGludmFsaWRh
dGlvbg0KPiAgICBpbnRlbF9pb21tdTogUHJvY2VzcyBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlk
YXRpb24NCj4gICAgaW50ZWxfaW9tbXU6IHBpb3RsYiBpbnZhbGlkYXRpb24gc2hvdWxkIG5vdGlm
eSB1bm1hcA0KPiAgICBpbnRlbF9pb21tdTogU2V0IGRlZmF1bHQgYXdfYml0cyB0byA0OCBpbiBz
Y2FsYWJsZSBtb2RyZW4gbW9kZQ0KPiAgICBpbnRlbF9pb21tdTogSW50cm9kdWNlIGEgcHJvcGVy
dHkgdG8gY29udHJvbCBGUzFHUCBjYXAgYml0IHNldHRpbmcNCj4gICAgdGVzdHMvcXRlc3Q6IEFk
ZCBpbnRlbC1pb21tdSB0ZXN0DQo+DQo+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
IHwgICAxICsNCj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgOTEgKysrKy0N
Cj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgIDkgKy0NCj4gICBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA2ODkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tDQo+ICAgdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jIHwgIDcwICsrKysNCj4g
ICB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAgIDEgKw0KPiAgIDYgZmlsZXMgY2hh
bmdlZCwgNzMxIGluc2VydGlvbnMoKyksIDEzMCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+DQo+IC0tDQo+IDIuMzQu
MQ0KPg0K

