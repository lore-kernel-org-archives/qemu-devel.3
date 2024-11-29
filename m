Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3A3D6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvff-000802-IH; Fri, 29 Nov 2024 02:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfU-0007y7-6C
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfR-0002e4-St
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866238; x=1764402238;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=j7ZhHAc3M7mChDH3124zBWgd3jo5et1QNZwivcfTjKs=;
 b=mXMbeHenmze8uT3vbIUzR5vKe42a/5ZX5+Yks73kc0tMxN8t1UloStYn
 rtzeqHT71ZTHVQr6UmCoFjsyTWSYgKC87WmSxSImFe5jQs55yhWqDfhso
 Mo4Z5vW6cWb0+X9l7KAsaSpo82EChNyWnf38rc4SyasR9qtQM/Y5lNXWw
 Eg1ty1GYlEoSZHddMgStrL3ZDTodB+bFVNLRr8I8VcgmvIHZa86mJnPY4
 bMN5k8KQFh0XriXnc0ZTi6qx9Fvzf8MElD6+MW0WH6Wvt3eFjbTLc/kKt
 Mn/Goef5lHxGIYnbgc+aG3cVLOrEwFonHSwBiUiRZG1L2DzGGqBuelv/J Q==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25664396"
X-MGA-submission: =?us-ascii?q?MDHfmMeb/1qzVUA+P//DOF0EIzToYCvs9+YJJq?=
 =?us-ascii?q?67RVZvclHk6lBbayvLv37sgQQd1u4tlMLa4sIxO2NCRNZR5O6Nb/jNpe?=
 =?us-ascii?q?S1z+R7+xzfXkZpdf9eCS9BtZ0TAWlmP4eAlokWp6lKYzD8z/s4zzbfVx?=
 =?us-ascii?q?5zdtyhVkHivnyHGsf9lCMX6g=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+VPZnsfwBsDjmDYsLhX2eh6bd4Tst0YMrueFwaqtHjktDyT5pc7dcf7tF+iAAoo4+Oqn50AvCnOO7WiVYwV5bDZ0t+MhyByLo4noqMRmrNVfyHYMxSOjp8c7vCBjC0ygUxJ5sJ67imHplfTvlTeoP0kwX4v+Ij+XUIGoDgEkuTSZs69AKzn8R34qFqdxi/Y09MUxBXXX0prubpqiIloxw5G/E5BLEhUP9quFIP9ZKMV9cgNoj0V2vMuEWbbMBnJr5qPlWQkkr77o5yyvXtGKoEiLzF9W6m8D9vsftVBa5B9fGdPQ/tBqRKIwizTuvwqLaKIdx/rmI7YCz0En2D38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7ZhHAc3M7mChDH3124zBWgd3jo5et1QNZwivcfTjKs=;
 b=KulmbskJyRGtyWNckqlTRvLgjhTUo1ofN9ejLK9NGe0xZniE5oeEQ7v19tGlihvg257xLfkVprBawZUs6pbIb0kAiiBxxX+73vLsCx66D5r7LidIBBg9QpnhbG7G0kuMIo6VA8hmk7ubOjgqgCyS9LxIVAjc9EwBVW2AGCAVFDHQ87sTx6NkzKkn8tcKzgzd/GKSe0QkgG1fCMZL9OTA0/RzYtEFNMuA+Axfpc/0jymsvOxF/uCe8j+Ig3LF5te8DeB3OBNvYD2paHUUfJ+XCUJwFiH5HcFi/7mVKISHncsQoJ2wD5DKXRBU099AqxCgZpoq5V0qaMePZ7ci41WIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7ZhHAc3M7mChDH3124zBWgd3jo5et1QNZwivcfTjKs=;
 b=LfLtD0K4gFBQIFAqdBT4HnOaYf69/GcgPOd3EV1RqpIPxWtdGhuTIVIcDKHS+8YHmnQTWMa0ds/U05EK2xIByniG0uR0uYB9C8kYmCRj1RCOaA4rPSDpMg426cBEFJShJfzfgqgf86O+dVaqMn1RXyf9VqplQmsFh9aA7xAckQL42nk2xac+HZxtVVH1ykjH7/sftUFI3+ogCjJrhq1kQ7yBRm9cLv5SUKWjYEfsSOuAYSky5nxD7Q2E+UCEBJGfWlz2t7vD5sGHPb6Hjrf1icbScMEoTDw5hhsqPcAbR8gOyVIJaRn2sz+qwNcOIUCyOvX7YxdwRgbHziqW3ESg6w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH v1 01/19] memory: Add permissions in IOMMUAccessFlags
Thread-Index: AQHbQjJt58lDGQrBW0y9U9llBbaxQA==
Date: Fri, 29 Nov 2024 07:43:49 +0000
Message-ID: <20241129074332.87535-2-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: ae535b29-b2d1-4b48-29ca-08dd10499063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OTZ6WkthYTgweTI5T1hILzd4VncvWVJQWmlFazNkVTYrQnh4amxvVDRkaXZh?=
 =?utf-8?B?R0JpQzdVcFMzTVZSbDB1R0hCcXA1TzNuK0FTS0JSeHAxSkYrTitGUUZiUmNS?=
 =?utf-8?B?TUJUUVk2M2pLRkdhcWkxK3BNU1ZxYnVGWGVveEczb3hTeGlmSGMrN3p2dkNm?=
 =?utf-8?B?TEszazVpMXF3MTA4RGZLVlVkcjlCam9xN3BzOUp3V0ZDMTJ1TzBFMXo1eWNu?=
 =?utf-8?B?QXZRdnR6MDNTQlNaRXo5ZHE1UHRQeCswckE1cmNGYmJya3BsODVITHVYUlll?=
 =?utf-8?B?WnFwUzZkWnV3b2pyeUxzZWNUOWxWSUlzNVJCempkWHphNit1bkk1cTNrSUMx?=
 =?utf-8?B?blVEdzU3bjZURUJuSEJGRENodEZuMlBIdFRaWHg4YUN2YWI5aS9tSUxuYmkx?=
 =?utf-8?B?ZGs0aURZcVZpdm90R1c1VGhEeFlneXFqVm8xRGxRVklhYU8rS3E2UDRZUlo0?=
 =?utf-8?B?RGQraEV0NkRnelFnS0lab0FsdnBBdTVORGpUb3UwRUFvcXhNdkxGWElPb1cr?=
 =?utf-8?B?eFNaWmRUVG40bkZycElhQ1BOREFMNkhVT2RFdE43bWdwcE42V251VzExM3BQ?=
 =?utf-8?B?Skh0V21sMnAxMzZ6NnJaejR6c0R6U1ZIUU03RW5QR1ZZMDdCS1JzYUJnY0I1?=
 =?utf-8?B?Qm45bUx1QlB5ZHJxZjlpSnhkemsybGRHUy8rSTFyR1VEajRmM0Frb2d4cnh2?=
 =?utf-8?B?bTEyMTg4WkJXZlJ5MWpBcndBV1V3Z3N4WWFpUkZMMlVLK0JxNnhEUVg2cXdS?=
 =?utf-8?B?aDNLZVA3cEpmak5CLzZST0ZZVWxuNHBUVTNzREpqZDJtUldoaG5yYjVnc0Z4?=
 =?utf-8?B?bkludjdJOFdjK2lvM2ExdkNsc2Rad21DY2JrV2ZMbWRYb3ZUY2V1MXgzMVhl?=
 =?utf-8?B?cUNUWlIvc1JCT1ErUG9KSEJvZUdLRHJzY1pGeWdCa3ptRVZJRXN0QnExYWVl?=
 =?utf-8?B?MmNWWGNZU0h1M0U4MXZkVTh6RGFtSFlEcitJNkpJcTFWNWZuUlNndVZGMFov?=
 =?utf-8?B?TnZPTTNOVU5nbkVPR1ZZOVlwZzBSMmlOanRhKzRwQVk1RkJTWUhNaUVIMkJw?=
 =?utf-8?B?dGNibWZmTVRnRnQ0dWpwTk80RjZUVFoweWRaa1dzdEYxdjVNODhFYnh1VlBT?=
 =?utf-8?B?REZjQkQrNnU4TmRTU1VmVUVkOHdiREh3dXB2NXVXZEJrNXJyNW9NQkpYNFdt?=
 =?utf-8?B?TUY5eXdEY1I1VlZHT1VBTTFKVXFIamhRWVpCcnZyL1Jjc25FY0pIdzVFL0Zn?=
 =?utf-8?B?VWUyT09uMG9RYVBISFk5eEkrTlhadFNza3RMM0s2RTRGK1BmMWtBVkZzbGU3?=
 =?utf-8?B?WlRYaEVYcHhqbTBMNnNaMnJKN1gvZFh5OFhPVkVqMUZUYitONVBpUlI3bS9B?=
 =?utf-8?B?UUEzY1hKYzhNU3BsZlA4Y3dKbnVMUi9hSXdZamIrckVMZEgvdUxDVlhtVytu?=
 =?utf-8?B?aTJZTHVXTzdQaFdJS0pzcG5QSTQ1QVkzVkFaYlVkSXpNNFZiV2s2TVl1aVIv?=
 =?utf-8?B?T1pzMVBJNUlKOXFtNFhkUEtsWm50a0ZDdm51SldST1lTcmZrNllDK3lYWmUz?=
 =?utf-8?B?VjZGMGllcUIvMUZXS24vM0dlTGkrZUJkWlBCb2E5aHEvbU95OVBVTS9YdzNB?=
 =?utf-8?B?Y29zc1Jtc2M5QVRhb2VBUEZRK3N4eS9FRklESHJ5NEVBYnA3TWhMMnB5QlB3?=
 =?utf-8?B?R054RDRXM3ZnZWpvRW12WmZTYis0aDArYmdVL2FIY1JLRVhLL0wzS0JzcXV3?=
 =?utf-8?B?TTU0RUFQV2VScXRLV05lcWc2ZUVLdTd4aUN0bzRoM25iRTdTakx3a1VKd1pN?=
 =?utf-8?B?RW5mT0NCZS82ZzkzcDR1MDJ2dUNtaVIvUzRtMW5kYUZrRXNTNitzSytuWTBV?=
 =?utf-8?B?SXJKNGFSZ2pCakZUUjdEM2FTd1VPVDE1SGRQaldvSXdEL2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlBUcVFLOStpTEluMU5RUFhPV1V6ZTJkK2c3Q0NveHVwOHhBb05OWjdNYmlv?=
 =?utf-8?B?WVo2enR1cnJsanNPNjl6cWpMUXM4WGpjTzJvM2loQlJvWnRmM2Y5RFQzUVB1?=
 =?utf-8?B?dGRMNk1MZ055QkltKzljUmdMUW4vaG0wV0tjcXpIMVFyTUhQK1BZcldlVlYx?=
 =?utf-8?B?aU9WUGlSN2ZRb2d6YThLY2FHNTB0a3E5UXgzYWV4RVhvVDdWeis4SFp1cFVE?=
 =?utf-8?B?Y05GSDY5NWZiOU9QbmU4L28xWE1FVXlEdVVJT1NaSWxnd2VrcXcwQjc3M2V2?=
 =?utf-8?B?N2dRWDlYbGw0R3ZGZGkxYVFkYytpaytmTjNITGFZVFUrallkcExNVEVxaFdu?=
 =?utf-8?B?RTdlTUtYR2ZNbWJSRU10K3lhS3FQU0RBbExLUTRmaS9IVTJMK3lxa1F0NHh1?=
 =?utf-8?B?RjlVdUlSL003SkRZdmVobUFtemJBN0d0cU1jWXQrNWtwZlNna0ZDUUJnOE1i?=
 =?utf-8?B?Z0Y2UFR3LytQc2E3RnJXMG1QTm80eHBlWTMyV1ZEUnV6UlQxRUhUdktnODZS?=
 =?utf-8?B?c0I3aVh1Y1dycVRraEtsNUxFZk16T3VYU0NLbmwwN0oxYXdOYWY5OGx3ZmZn?=
 =?utf-8?B?QzMrNHM2dEtiNllZYm1OOW5pRkZmTE1JR01WanNnSENrUHJ5aXBSVXJkV3Fo?=
 =?utf-8?B?YlNoTC9kdmJaNTVQRmNjbVdsODNRYmtDV0VzK25mdHNSWksyTjVmNUFmRGNv?=
 =?utf-8?B?blQ5VlZneVF3ZXFVNjU4am5lNDk4WDZteENMTllOQjc1K3NZdDZRWDlyb1g1?=
 =?utf-8?B?VXZubkErMm1OUVZRSG1OV09IK0lEeGlOeTdGMDc2UXhJMTY3ZktrTFA5elZs?=
 =?utf-8?B?cWF6dGpVNHZrZW5ScUZLSUsvdUpFbXBKUVB6TklzcEc5NUxQVTBaNFhJWFhl?=
 =?utf-8?B?SkNBbkNXc1dCdlBHQ2ZCdkUvQ2hrcXNrYmREMkZEaTg0d3VDSzFQa3B1OHhw?=
 =?utf-8?B?N3VUK2w1ZEQzc3phbE1LUjJ6eXgrN2VQTmxYaHgvUzlDcXUzaTJ1ZUljZVg1?=
 =?utf-8?B?ckJUdDlrcFJ4VE5PTFlYK05UbnkrOUlSMCtuU3BrZEFmM0REVUdaMldES1NG?=
 =?utf-8?B?K05HYlNkdERRTFlwcjhybDVRSDI0Z1RiUGlyZHF0TnRTRWMyOTBHdlU1anNa?=
 =?utf-8?B?eExaVmNBMytYM1FjdXlsKzJMK3UrOHFXNk5XZlpSVTl5QzBDWmxZeGNtQzR1?=
 =?utf-8?B?TmRpaUY2SkYzWFRoMTNpTjd1UkhZWllCK25aYXNrMXJLM0dhdGZTTG9yMERq?=
 =?utf-8?B?WVJXQkVaZ3lBTk5qMkpUU0VFVUtqMW9UbDJIYlRBQTVmZ3pHMkJINzhSOWh2?=
 =?utf-8?B?Y0p4SHZCaWtTRFVCYjh4UVo5RHpLWU56R0FVNk9WRFNjSXJ6M0paV2ltVWpr?=
 =?utf-8?B?Q1BLZ1VhRU82bTVxK2tQSlNYK3Q4Yk9QSkxobm5VT25ieDZJdjFEZnFqVFdi?=
 =?utf-8?B?SEZRY0YvZTdod3NZa0dmb2hiek1XTmVObmR3VlZsNHVVSG8rcit3ZEl2STJN?=
 =?utf-8?B?bUhIN2ZMZEFEY0I1OVpPNG9aZ0svQUR5K3lUTlhkTUs1aEZSOGVVR3p5c1pN?=
 =?utf-8?B?M0JhOWdjcmc5Y3IybHBtaUdEVnFpMWtCNVplWmRCdndieTdyOUFqVXJ5S0xC?=
 =?utf-8?B?NXE4K3VYRHkrVVZiM2h3aTJIVDhBOFlDa05RN2s0MThXY3pVRnFtRExCcHFz?=
 =?utf-8?B?QVBEOVc3Y3FyUlRobFdjYzZzNzg0Q0lMQkg2ZWQ2cHFPaVJuZm9lRDJhZStR?=
 =?utf-8?B?MmhJUjVQVFVXUFNqemZ0V09Jdkl6bGhXWkpvQUlsclZzc1hPNzE0SzdsZUNx?=
 =?utf-8?B?Vk9BV3Z0QndyQ0ZyZEJidlNJdUFSRFlDWXc3dEoyRXplaFNONnlTL3ljZ1BM?=
 =?utf-8?B?bFZJcDd3VmF2VzVJM3RDUTZWemR1Q0JDTXkyVTB2dmRsM1FIcitBWmpvbkZG?=
 =?utf-8?B?UTJ5djMxckRRZHZMQXBLV0dBVWlsUWd6ZkNMeGtjOFJ3Y1cySjUxeW41Nmxa?=
 =?utf-8?B?bmovZFMrYURjQ0Z3Z0lsaXBvbDJSNVo5UVFYTmc2dDRycEhRZnMxUGlpcEdi?=
 =?utf-8?B?RDdpZ2VVQVlqZVZremNUVnhZQTQxMlJDRXZRbTg1bnRDQVZVbUVUZTc5MFE4?=
 =?utf-8?B?RlVSZkhXN1lBSVhua0FLSjliZzdLbkxHQ3d0bFlrVm9odnI5UkZuTUZDUDdh?=
 =?utf-8?Q?4k9hAYTeniXw7VLUVTz/JyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB6CA8109A36444FBDEADD65C82DDF30@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae535b29-b2d1-4b48-29ca-08dd10499063
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:49.7194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3xJXIPf8Vum8nyOxaX9+rs4CohzDFOradIvmQwckAQikSJea7o+G1WHDOVSdEn81SCwFbz5hrQX39PN4loO1xc87bF8oQRbmDtXXeZYzwMtrUm2VfSWu4xaGwaVnsg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBiZSBuZWNlc3NhcnkgZm9yIGRldmljZXMgaW1wbGVtZW50aW5n
IEFUUy4NCldlIGFsc28gZGVmaW5lIGEgbmV3IG1hY3JvIElPTU1VX0FDQ0VTU19GTEFHX0ZVTEwg
aW4gYWRkaXRpb24gdG8NCklPTU1VX0FDQ0VTU19GTEFHIHRvIHN1cHBvcnQgbW9yZSBhY2Nlc3Mg
ZmxhZ3MuDQpJT01NVV9BQ0NFU1NfRkxBRyBpcyBrZXB0IGZvciBjb252ZW5pZW5jZSBhbmQgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eS4NCg0KSGVyZSBhcmUgdGhlIGZsYWdzIGFkZGVkIChkZWZpbmVk
IGJ5IHRoZSBQQ0llIDUgc3BlY2lmaWNhdGlvbikgOg0KICAgIC0gRXhlY3V0ZSBSZXF1ZXN0ZWQN
CiAgICAtIFByaXZpbGVnZWQgTW9kZSBSZXF1ZXN0ZWQNCiAgICAtIEdsb2JhbA0KICAgIC0gVW50
cmFuc2xhdGVkIE9ubHkNCg0KSU9NTVVfQUNDRVNTX0ZMQUcgc2V0cyB0aGUgYWRkaXRpb25hbCBm
bGFncyB0byAwDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5o
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggOTQ1OGUyODAxZC4uMTVmZmY2OTQz
MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQpAQCAtMTEwLDE1ICsxMTAsMzQgQEAgc3RydWN0IE1lbW9yeVJlZ2lvblNlY3Rp
b24gew0KIA0KIHR5cGVkZWYgc3RydWN0IElPTU1VVExCRW50cnkgSU9NTVVUTEJFbnRyeTsNCiAN
Ci0vKiBTZWUgYWRkcmVzc19zcGFjZV90cmFuc2xhdGU6IGJpdCAwIGlzIHJlYWQsIGJpdCAxIGlz
IHdyaXRlLiAgKi8NCisvKg0KKyAqIFNlZSBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZToNCisgKiAg
ICAgIC0gYml0IDAgOiByZWFkDQorICogICAgICAtIGJpdCAxIDogd3JpdGUNCisgKiAgICAgIC0g
Yml0IDIgOiBleGVjDQorICogICAgICAtIGJpdCAzIDogcHJpdg0KKyAqICAgICAgLSBiaXQgNCA6
IGdsb2JhbA0KKyAqICAgICAgLSBiaXQgNSA6IHVudHJhbnNsYXRlZCBvbmx5DQorICovDQogdHlw
ZWRlZiBlbnVtIHsNCiAgICAgSU9NTVVfTk9ORSA9IDAsDQogICAgIElPTU1VX1JPICAgPSAxLA0K
ICAgICBJT01NVV9XTyAgID0gMiwNCiAgICAgSU9NTVVfUlcgICA9IDMsDQorICAgIElPTU1VX0VY
RUMgPSA0LA0KKyAgICBJT01NVV9QUklWID0gOCwNCisgICAgSU9NTVVfR0xPQkFMID0gMTYsDQor
ICAgIElPTU1VX1VOVFJBTlNMQVRFRF9PTkxZID0gMzIsDQogfSBJT01NVUFjY2Vzc0ZsYWdzOw0K
IA0KLSNkZWZpbmUgSU9NTVVfQUNDRVNTX0ZMQUcociwgdykgKCgocikgPyBJT01NVV9STyA6IDAp
IHwgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3
KSAgICAgKCgocikgPyBJT01NVV9STyA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgodykgPyBJT01NVV9XTyA6IDApKQ0KKyNkZWZpbmUgSU9NTVVfQUNDRVNT
X0ZMQUdfRlVMTChyLCB3LCB4LCBwLCBnLCB1bykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSB8IFwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoKHgpID8gSU9NTVVfRVhFQyA6IDApIHwgXA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgocCkgPyBJT01NVV9QUklWIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChnKSA/IElPTU1VX0dMT0JB
TCA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodW8pID8g
SU9NTVVfVU5UUkFOU0xBVEVEX09OTFkgOiAwKSkNCiANCiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7
DQogICAgIEFkZHJlc3NTcGFjZSAgICAqdGFyZ2V0X2FzOw0KLS0gDQoyLjQ3LjANCg==

