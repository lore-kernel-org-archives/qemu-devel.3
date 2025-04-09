Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7647C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QnA-0004fn-Ky; Wed, 09 Apr 2025 04:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u2Qn1-0004e2-1e
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:28:08 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u2Qmy-0003Pp-QO
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744187284; x=1775723284;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bufom8Ch8VmeqvvLWpRwpUxxUTTw/kC0YCOdjh1ibmI=;
 b=HJ2WzREaIjJ86xCJ7U+pGpeFpbAvcUteE8HfQs38819yEtmLa1wdut+b
 ++aV4dgE/uRmwBaejWJdoV/JwObzwhTt/tViuEYFWAlMiR8ot9ftx6Iw6
 m4Vqpwqi/kItdQlsT9JLyrjMC8gjHnqvaE8D7RVUxYOt+0gr4FBUnO67M
 9WvcXF8gIAhz3zqcm5ry/8S+24MhFzMM/wjd3wYFR57aIHiS+dLLGz/SB
 +oHP5B25VvIpwrIa8oABpic7Itvkz6cyy2NdsYDmSfQejgWlFimrL834Y
 mHZyK/NAfy8a9O6JDKMS8573JVGav0RxYo+vtmmWx4+erxMo++p4V3MBI A==;
X-CSE-ConnectionGUID: Huf1gczXQay1XNac/izEwQ==
X-CSE-MsgGUID: MFQe8duSS1iW5wIJ2sFXXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45771821"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="45771821"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 01:27:59 -0700
X-CSE-ConnectionGUID: OLFdHb69SNCf21yn0DDUDw==
X-CSE-MsgGUID: /w8k5M4bRH67XpZXWv92SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="159496693"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 01:27:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 01:27:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 01:27:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 01:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7gIxCya2WcIjN4bL3CTl7Lre8b+VdDTJtgHpN7PLTKs3exCHTpNdzVPwAKt+aSCRMU0nrtvTcsGXm7EmScsan1wuw4VXzrzn+B5+KztnLHKrCDSEAtKrKg35lLHkcKVFf9KJnK0kduZJTItZ1AsX/En9cOft7h4ZgJKnJ4/k2WH96vwOUQS+Z70uoQS5lanBvjj3l+OqAm/NCUKs8jAGS/BDPQkj/GskJLeUZ32TVuz/TpFAH39zLFQGw6r6ohp6ouxzUonX6FeyluZyihJ5U6gLH3nuMVOUFDvrC1/mmc/zTCQXE5EnAJgM4h2twULAFpOAJhWrmqYHUW5Apkw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bufom8Ch8VmeqvvLWpRwpUxxUTTw/kC0YCOdjh1ibmI=;
 b=m8Vs7s/DV6DXBwbl3cie8B6bSriz3OLNrA0ceRL6FmaoKI53pS+qW6t/U71KOcZZdCu4ro9X5rvZCCmr4h5vDdSyjoOl7X2Fm/5Ed3H3Tqy9j+xdBPfjboK/Mqa+91G8B0+Zb0sCZGp5k5jnhKej02wFdGEpCE9VeRjAaQ162N5Q0EpqMN66A5b/FefUBGt89IfagyfkvCXqp+gorsRkMKAj+t9t0PI0K0ksl5oJ0j4YVDeIHw7CUV72HZOA3RtbWR+ClucVnaaUCDIRvQWOod/f7zogx5H0HSilWNiWvoI3vvCvasnX8XmrIiGqc5XFrYBVIp/movZjNZwZ66FgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 08:27:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 08:27:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Thread-Topic: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Thread-Index: AQHbgqf4kW3myVfhUUy5lTRf0uUHeLOYWG0AgAFa9ACAAZWNsA==
Date: Wed, 9 Apr 2025 08:27:28 +0000
Message-ID: <SJ0PR11MB674476F80FEFA6A5AD1DAA0A92B42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
 <084cbb65-f3c3-4f18-ae3a-88f20480d2ff@redhat.com>
 <16fc9fa0-2b88-4029-ad0b-cedc279c956c@redhat.com>
In-Reply-To: <16fc9fa0-2b88-4029-ad0b-cedc279c956c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8414:EE_
x-ms-office365-filtering-correlation-id: 85836456-6cec-4a4b-e4c1-08dd77405d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U29uZ0daemZJajgyUTg1M1lheU5RYW9mSm1JcGZnem4zMXhvQjgraTFNRnRI?=
 =?utf-8?B?N0s2V0FUOVYwWVdjWGZLK0w3bmxKZi9XT3lHSmU5WmtuTVh6SU1GcEJKY1N0?=
 =?utf-8?B?eFBsaGVlWWFBT1U5a2VhN1c5bzRGb0F0eThWSkEvektNeDdJU0N2RGkrTGtH?=
 =?utf-8?B?S09OL3JEU04rZ0pGZHlJR3IrMklvSGFQSE02VEIzc0FERXZpbEJTdllYMUlo?=
 =?utf-8?B?dTJjenFPbGpnVngvQ3RGL0tMSFFZZ2ozKzJ2cTRRU01SQlBWOFhxL1JnVFhq?=
 =?utf-8?B?YWVqM3Z5Q0ppSDQ3Qmhqalg4bzVoY0VUR2VxWkJTc2NyNGh5RmVLYll5VmJq?=
 =?utf-8?B?NjFhMnNGaFR0MUpwNzVnL2dJNUtPRDZhTkJtamdGN0hleHVkWTE0ZHZPUUdy?=
 =?utf-8?B?cXVRaDdPWmxDdVBmbXUzeGtLb0NhV1hjbGl3UHdXcExPdm9mU2lNYmxxVWdj?=
 =?utf-8?B?cVd3RTlPckFicGJ6dUI0d2k5ZWlHbXRwYnNNeDlMK2YyM0tpRUtJbVlJenNQ?=
 =?utf-8?B?U1VQTUdGK0VWZVZOTzlSMzNmRVRzamxkbzFxVlBtSVNtRFJXSHpTVDJ0eXRy?=
 =?utf-8?B?V3kwQlo1eXdFZE93emIyRUZWY3BBdGVqSWdCUVl5VGVjVjdSdGIyL3duNkhP?=
 =?utf-8?B?aThlREFiQ0RZMGtRb3RtYThsaTJ1bDNNQXpTVlk5c3FBeHAyZ3pqVVB2c1Qv?=
 =?utf-8?B?cGtubDJmaWoxZ1VqdktFbVM3WUJiRDBRYzYxWlZxUnF6UlBOV3hiRlMrY0ZJ?=
 =?utf-8?B?SjhONXhOemlyQTduT1RCZmhHYlJ6Vk54OVB1ZEJFbGJhN2pvSWR0VC83OEVh?=
 =?utf-8?B?cW9tOUw5UnMrT3Nqd1o0aEdPWFdJblhWSFM5elNhRVIrWEZWcFFQSk1MQWYy?=
 =?utf-8?B?NTZSRStXWVk2Zk9RUkQ2VFhMZnRmdVlUNFFTSWZuTHZGTDhLWDFMOEdTUmxX?=
 =?utf-8?B?Y0hHblBpc0tOT0VJaFVNMHZwdnRuYUNwUHI5WFJPS20wRmtMU1htR2JHZ2N5?=
 =?utf-8?B?V2lHaUp4UC93K1pKTUpvNGZZa0xPNTJjK1hGYWZQaHRDMVFraFJOTUdxbU1s?=
 =?utf-8?B?N0EwbkVxZ1pIVXlKaDNxdEQxbGtLNDl3SWZsQndabmFvSWwyNVppSWR3SVNm?=
 =?utf-8?B?cnIvdWdXd0VVRWdzQjc3OC9FMlFOcmNVUHVodzFmc2VBd1cyYk1oOWY4VENF?=
 =?utf-8?B?NmZtSUtBM09JWlZHTkQ5MjBQMnFERm5XSXpwcGJaekNqUjZyWnM2S3JQR3kx?=
 =?utf-8?B?a2ljS3Y4ajAzR3NLTWthRmJnUjRSbFhmTlZEd2s4cTdXQUFtVk1ocWJ4dEVB?=
 =?utf-8?B?aDBNUlV0TXlsdWYwRGV2TitXN0RMcHZkYktyV0FtYXVoeUtLc1ZjbGFQK2tX?=
 =?utf-8?B?MElVa3JtTVN1NXhkMzlJb3NscUpJL2poRmFDdHkzTFNqMFU4Tmw4L3lYZWdK?=
 =?utf-8?B?NEg5aldRTXZ0MDRGSW5TUlVJWGdnS21WeXozTVBwUmlzd0IweVI0ZFBpSlpa?=
 =?utf-8?B?elhLb3dmZFl3MXY1cStWZUdxYkE4OFViQjFNODlnb1U2eUxaQUhyMFJRczJq?=
 =?utf-8?B?RndjMnRLc1pzQVNKYmhCUEYxWmViU0FUYU5GOExqRFkwb1YxTGU4V0hCdXdF?=
 =?utf-8?B?WHJkVkhjR1dDZG1NdmJ3aUlTNzlyY0VkRDNnUmsrb1FKazJIS0pxa3hpVjFv?=
 =?utf-8?B?Z09Gemx5OWp0RGkxcExSMkV5emNSQmJQOEtqdGhLcVJzRVREK3krWDBTVEI5?=
 =?utf-8?B?QkhaL3JLZUxxUXAzamtLZVMyR1JtODF1WXNtZmdrUDFwR0NuQjhOdGtKbVk2?=
 =?utf-8?B?WElxZ3hrZ1FtOE44Y001dVh5RnY2NncrRUJGNHBHeGlwYlhFVDhYcGcrZkRm?=
 =?utf-8?B?T1F3WnhEYXZ5R1pWajFZMDFSbnBweWh6REplTXllaVdjeFB1ZnptTy9CekNS?=
 =?utf-8?Q?N6/5QZGXlZ8QAs1iw69GEVsZJmtbXt0i?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGVGZlpocWZQeC9wYnVMTUZ4bnNoRzBSL3RqUithTmZ2RlkwMHFkT0JCb1Jm?=
 =?utf-8?B?OTV1NS9HdFM4MCtoTm9RK1dESHJNb3hsa2pvVEppOTJoZWtieTBjbzdxdnVU?=
 =?utf-8?B?VjIrekE3b3l2WVZZRlZYK2QxWi9ORG9XYWNVSzRXdU1YOWVMYmlhQnd6UFJQ?=
 =?utf-8?B?ZllmT0xKdXNGNm5wMHkxSmI3aXVUQ0NuaURBcGRCRGFXZUZ5UGFHZnJwOFl1?=
 =?utf-8?B?Z1BsNFR6VWRVcFNNZE1LUzdidkY2MDJSYW5mR3RLbUM0N3JWdVo4TmgyZkgy?=
 =?utf-8?B?cFV6QTJzUW0wK1hPVjlTQVJUaEVseGNJRVQ0SmVIaG5UdkNGdm11aHFwQ1lo?=
 =?utf-8?B?REM5NlJ1RnZUdUVBTk94S3UwY1NTTGJDSm1XazYvbXhaZHQvcTRhSktPUXBX?=
 =?utf-8?B?RVEwS2FNeUo1SUxZK1F6T0VuakJoVHBuMlh5N1Q1a3NUdDJSL3BjMHlpdHNq?=
 =?utf-8?B?Q2NXaTRkemtKUHlqTWVUa3hVOWdCREFhRjhiNjFzOUdIUXZjeHJGVkpuV0xT?=
 =?utf-8?B?N0JXVitVM1FIM09vcU1icVc5eGVGVjhaVFJMQytPREd1NjFtNXZ6ZjRuamFl?=
 =?utf-8?B?UjhFaDVPUS9aSmZvVlh0OTN2d2lEaVlTSVNjNkZRa0EveWF2T1JTZzhTSG5s?=
 =?utf-8?B?WWFMWEVSSlpKTzRJb1Q0KzJhK0VOaENHYUZBSFpXVENMVkNUTEJiVXdrMi9q?=
 =?utf-8?B?dkRRYVRTSk5oTHRtU0FiK2ZMbFNZbGZFY0pJYXcyZEFaZm1Kc0htWkFWR0cx?=
 =?utf-8?B?N2ZTcnc1YmxiK1ZId3g0dUtheStiZjlBcmwrd2I4cS9GRkpIbG8yY0hLZkFt?=
 =?utf-8?B?emtQd0tIT1BPMU5kRVlPbHBxa0NhdEY0ZHd0S0xMdldWTEkyS0hiYzNSVHk0?=
 =?utf-8?B?ODE4ZmJWZll3VFp2U2dSVktUeVd5Qm5LMkpLaXlnVkVlOTVTRkkxdENOK1NZ?=
 =?utf-8?B?NndqNzAyRkczS3VDTTE1dXp6OWVkd3NJZkJkVEZ6ZU8vMWhvSGtQZlY3Q0Q5?=
 =?utf-8?B?czE5R3U3NEloNVhoTU5KUDRjZVhXR3YrcXJiandJRFVTcyt4UVBOalZubk5K?=
 =?utf-8?B?bHU1TnA0OThpUEFjcXpZR1hBTDhTUkx0dzFMNy9jVVIyM3ZPVExxWEx6ZXlX?=
 =?utf-8?B?MzJBdjFiSS9sTG5TRnNwNm5xblBweXBJZ2plQzRmRVVoZGxIcVNLRHlCZW9a?=
 =?utf-8?B?TjA0VmRJd2IwVHRDaGkySUNnYjZiWUsrNFBKWE5uOEV0M1lmS2lMNnE1bDJq?=
 =?utf-8?B?T1BXS3VySzFJMjVWZkxDaW9NMHh2RmQxNUs5djB6cFcvSzRqbHZQY21TNzVF?=
 =?utf-8?B?anVlOHViVS84QU43VVUrUlpWZEo2QzI5N013ekhhVjYyOXhCN1JsM1pvbm84?=
 =?utf-8?B?a09MZGtNai83dlM0ZDlOc3VGemNrQWV1Q0JuYjRjVzFVcjZzZ0tjY2YySXhv?=
 =?utf-8?B?VVlHdWZSNWxVcmZvbmt2Z1Nib3p0SnhOYmJNQ2FPbmhIY0V1cjRVZkdrMjdF?=
 =?utf-8?B?YUd5dGR4TDV6dFUrbkFDeVNwSkd0KytmRDFYZ3F4eWxQWHlScWl2aE1nSmVx?=
 =?utf-8?B?Tm90VDE4ZFRXZm5qaFFXK0xHUG4wWTcyZDNlRExENU1HcW1iSUErL0M4UEpN?=
 =?utf-8?B?SmpmUkZTSERSWU1qai9LYkRRdk5LUHcvanVrVmpzTE42d3RsdnNqcmM1dmNF?=
 =?utf-8?B?UWFlSnk2TUpld3Yra3FudDRaSEVtblpkYVlhY1h2QTBaUWhhbTRPa0VwbE5i?=
 =?utf-8?B?bEhMK2NGR3ZGampOWHBCdzdKeGU1MzJxN09FRUtPeGhMcGlXR042bERreEww?=
 =?utf-8?B?blM3VjV2NnZnNjJNbkdZcnBRbi9Zb2w2eWZxcGQySkkzdTFZUkpyb2dCbkx1?=
 =?utf-8?B?blRKYmJDdEhkRTZ6bWhmdHlpUUMwdjE0MXplN3FsZ3p3SmdnNTNZNnlUb1Vr?=
 =?utf-8?B?eEtqazIxcmNYekFrblRJUDRaMDR2R09CeTBCeGJVQjRvT244U1BqbXBPNUQy?=
 =?utf-8?B?Uk5pK3JoazlZL1FML3gzWG9NRHJsTTJZT2hqaTVocVY1UmJSNEgrYVJJRkV2?=
 =?utf-8?B?dW9ZdWJNNE95RXB2eWRhWnBidWxFemtMbGxBTHk1czdpcWM2WVJydzRJd1RB?=
 =?utf-8?Q?4flKGVuYFvnb45vsKIcXGSqep?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85836456-6cec-4a4b-e4c1-08dd77405d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 08:27:28.5702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGg09WDHvjrE3NuEXqqhUQJM+pFI+SE9GxYcJ3B5H8uXDKjukFuH6HBxi2D2rJ2+H35g44lJCN4qeJDavK0QOB2SK7YvEKwRtI4a9PId5xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDAzLzIwXSBIb3N0
SU9NTVVEZXZpY2U6IEludHJvZHVjZSByZWFsaXplX2xhdGUNCj5jYWxsYmFjaw0KPg0KPk9uIDQv
Ny8yNSAxMzoxOSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+PiBPbiAyLzE5LzI1IDA5OjIy
LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBDdXJyZW50bHkgd2UgaGF2ZSByZWFsaXplKCkg
Y2FsbGJhY2sgd2hpY2ggaXMgY2FsbGVkIGJlZm9yZSBhdHRhY2htZW50Lg0KPj4+IEJ1dCB0aGVy
ZSBhcmUgc3RpbGwgc29tZSBlbGVtZW50cyBlLmcuLCBod3B0X2lkIGlzIG5vdCByZWFkeSBiZWZv
cmUNCj4+PiBhdHRhY2htZW50LiBTbyB3ZSBuZWVkIGEgcmVhbGl6ZV9sYXRlKCkgY2FsbGJhY2sg
dG8gZnVydGhlciBpbml0aWFsaXplDQo+Pj4gdGhlbS4NCj4+DQo+PiBUaGUgcmVsYXRpb24gYmV0
d2VlbiBvYmplY3RzIEhvc3RJT01NVURldmljZSBhbmQgVkZJT0lPTU1VIGlzIHN0YXJ0aW5nDQo+
PiB0byBsb29rIHRvbyBjb21wbGV4IGZvciBtZS4NCg0KQWdyZWUuDQoNCj4+DQo+PiBJIHRoaW5r
IGl0IG1ha2VzIHNlbnNlIHRvIHJlYWxpemUgSG9zdElPTU1VRGV2aWNlIGFmdGVyIHRoZSBkZXZp
Y2UNCj4+IGlzIGF0dGFjaGVkLiBDYW4ndCB3ZSBtb3ZlIDoNCj4+DQo+PiAgwqDCoMKgwqDCoMKg
wqAgaGlvZCA9IEhPU1RfSU9NTVVfREVWSUNFKG9iamVjdF9uZXcob3BzLT5oaW9kX3R5cGVuYW1l
KSk7DQo+PiAgwqDCoMKgwqDCoMKgwqAgdmJhc2VkZXYtPmhpb2QgPSBoaW9kOw0KPj4NCj4+IHVu
ZGVyIC0+YXR0YWNoX2RldmljZSgpIGFuZCBhbHNvIHRoZSBjYWxsIDoNCj4+DQo+PiAgwqDCoMKg
IGlmICghdmZpb19kZXZpY2VfaGlvZF9yZWFsaXplKHZiYXNlZGV2LCBlcnJwKSkgew0KPj4NCj4+
IGxhdGVyIGluIHRoZSAtPmF0dGFjaF9kZXZpY2UoKSBwYXRjaCA/DQo+Pg0KPj4gaGlvZF9sZWdh
Y3lfdmZpb19yZWFsaXplKCkgZG9lc24ndCBkbyBtdWNoLiBXZSBtaWdodCBuZWVkIHRvIHJld29y
aw0KPj4gaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZSgpIHdoaWNoIHF1ZXJpZXMgdGhlIGlvbW11
ZmQgaHcgY2FwcywgbGF0ZXINCj4+IHVzZWQgYnkgaW50ZWwtaW9tbXUuDQo+DQo+VGhlIG9ubHkg
ZGVwZW5kZW5jeSBJIHNlZSBvbiB0aGUgSU9NTVVGRCBIb3N0SU9NTVVEZXZpY2Ugd2hlbiBhdHRh
Y2hpbmcNCj50aGUgZGV2aWNlIHRvIHRoZSBjb250YWluZXIgaXMgaW4gaW9tbXVmZF9jZGV2X2F1
dG9kb21haW5zX2dldCgpLiBUaGUNCj5mbGFncyBmb3IgSU9NTVVfSFdQVF9BTExPQyBkZXBlbmRz
IG9uIHRoZSBIVyBjYXBhYmlsaXR5IG9mIHRoZSBJT01NRkQNCj5iYWNrZW5kIGFuZCB3ZSByZWx5
IG9uIGhpb2RfaW9tbXVmZF92ZmlvX3JlYWxpemUoKSB0byBoYXZlIGRvbmUgdGhlDQo+cXVlcnkg
b24gdGhlIGlvbW11ZmQga2VybmVsIGRldmljZSBiZWZvcmUuDQo+DQo+U2luY2UgdGhpcyBpcyBu
b3QgYSBob3QgcGF0aCwgSSBkb24ndCB0aGluayBpdCBpcyBhIHByb2JsZW0gdG8gYWRkDQo+YSBy
ZWR1bmRhbnQgY2FsbCB0byBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKCkgaW4NCj5p
b21tdWZkX2NkZXZfYXV0b2RvbWFpbnNfZ2V0KCkgYW5kIGF2b2lkIHRoZSBJT01NVUZEIEhvc3RJ
T01NVURldmljZQ0KPmRlcGVuZGVuY3kuIFdpdGggdGhhdCB3ZSBjYW4gbW92ZSB0aGUgSG9zdElP
TU1VRGV2aWNlIGNyZWF0aW9uIGFuZA0KPnJlYWxpemUgc2VxdWVuY2UgYXQgdGhlIGVuZCBvZiB0
aGUgZGV2aWNlIGF0dGFjaCBzZXF1ZW5jZS4NCg0KWWVzLg0KDQo+DQo+SSB0aGluayB0aGlzIG1h
a2VzIHRoZSBjb2RlIGNsZWFuZXIgd2hlbiBpdCBjb21lcyB0byB1c2luZyB0aGUNCj52YmFzZWRl
di0+aGlvZCBwb2ludGVyIHRvby4NCj4NCj4+IEFueXdheSwgaXQgaXMgZ29vZCB0aW1lIHRvIGNs
ZWFudXAgb3VyIGludGVyZmFjZXMgYmVmb3JlIGFkZGluZyBtb3JlLg0KDQpPSywgbGV0IG1lIHRo
aW5rIGFib3V0IHRoaXMgZnVydGhlciBhbmQgd3JpdGUgc29tZSBwYXRjaGVzIHRvIG1vdmUgLnJl
YWxpemUoKSBhZnRlciAuYXR0YWNoX2RldmljZSgpLg0Kd2lsbCBiZSBiYXNlZCBvbiB2ZmlvLW5l
eHQuDQoNCj4NCj5PbiB0aGF0IHRvcGljLCBJIHRoaW5rDQo+DQo+ICAgIGlvbW11ZmRfY2Rldl9h
dHRhY2hfaW9hc19od3B0DQo+ICAgIGlvbW11ZmRfY2Rldl9kZXRhY2hfaW9hc19od3B0DQo+DQo+
YmVsb25nIHRvIElPTU1VRkQgYmFja2VuZC4NCg0KVGhleSBhcmUgb3BlcmF0aW9uIG9uIFZGSU9E
ZXZpY2UsIGJhY2tlbmRzL2lvbW11ZmQuYyBhcmUgZm9yIG9wZXJhdGlvbiBvbiBJT01NVUZEQmFj
a2VuZCwNCkRvIHdlIG5lZWQgdG8gbW92ZSBpb21tdWZkX2NkZXZfYXR0YWNoL2RldGFjaF9pb2Fz
X2h3cHQgdG8gYmFja2VuZHMvaW9tbXVmZC5jIHdoaWNoIGlzIFZGSU9EZXZpY2UgYWdub3N0aWM/
DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

