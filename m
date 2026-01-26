Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B94CF65E5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLGS-0007qN-Pe; Mon, 26 Jan 2026 07:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFr-0007oO-79; Mon, 26 Jan 2026 06:59:41 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFo-0003OO-Ei; Mon, 26 Jan 2026 06:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428776; x=1800964776;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TRlO9H40A5/EDc7aCC6goptWvb01ogE0Fv2FmrL8ZWo=;
 b=YM6eHzZcFWsTe7s5InKxMGi2+QMgXgjaLPDclKCxl4SZyy3giUwrj7J4
 e4qhuYXIm2T3B1BcgBa+MwgRItVFIL8smDHnyhZWrVD61S4bFB8Xv18iP
 qM8LYwUYHrvJvzVAfWsMtFES+4w43TIuWqOw5akPIpx5AKUzd1uKpJUyB
 MeGJNuiyGabZ59Kymp8p6WxNXu3VkF3gbCn0Q2sc8TiiV1ZghKL2C4wL0
 IcrQtJP9JmKEp+2kmawW9MqO+tp16GPCes1HIFyTRWebCz4Pf7gIa7lC8
 uRUdJFVhefEn/6nOrI/Pesb9NpchlWJMFQnutJqBgAVUD66ckqn98WfbV Q==;
X-CSE-ConnectionGUID: +vPAjb7HS9GA4PBRWlqn4Q==
X-CSE-MsgGUID: B/wT/DpIQVWbrKSYXkpqeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81237782"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="81237782"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:34 -0800
X-CSE-ConnectionGUID: dqACJso6RmGG0D3e3oGJ5w==
X-CSE-MsgGUID: q1CK128rSVa4WDkUxsQcdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212648780"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 03:59:33 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgIfzCUH1MUq/CG0Nehvp2UtiazGy6uEJ3MgmP/1/jhSTmIt0Ht1oDfQJ3F/iDgN8yQbW9t8uiO6Ge9HBcmLY5ZROXhjZ5DMdYK/9YINq1OYanv1ERMaICXPO0E9dfyb7jnEZwesYNZucLK4j6HTRfB09GjAM7QTdEQLSpWTt9wcav/quGR6zIERSn+cPATcQr1JypaeOeyu07DLg6Rq4pcpdI5EdKjQKY12zoMIaCj3np9YTrJng/idFzhGnSvIbdasu+wp/VvKNBpe3788Ryb+8c4GAY/7kZRD5/Oonzrjteg2Xm7BhO+SCrsRFRM1aawXHKRlXmZYkyZMcyWHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=godUuKMWEORUECuFoYMj7K0QL9Y7AOsW7URroOzU9Vg=;
 b=SduYNrrir0QgXHHhAGFry4/ZVLcqd5TvUvFyvO+AecoOboud7VSlG0RDaXc7Iexa9tMpoltCwNLxLrSw93qHyKx5g4DYDLqJJnFVUVFamXNe1iVMb6Pd4VM/Z+Jy8aJBAxDbkPbn139wUwcpjzw/dPn9SSQYnvQhe9JzPB0Bt2p2LnRFv9JzTe/KIdkUgj6yi+gdJq0fu40M9BpmQxn1B0XfXwESdlwOqMova82WhE/xPUbDS8dg1N1KoVbfWQO1YNdDbQngkVr7I7v/bK711bd/p5ICs7zCHB+vmJcUgh5BcNTkQOxbkw3jYkZA/KMjJxHaYZzbmwbLNTEylWHlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:59:30 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:59:30 +0000
Message-ID: <75387068-5b6e-4bb9-bd6a-9bbe4b379997@intel.com>
Date: Mon, 26 Jan 2026 20:06:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/37] backends/iommufd: Introduce
 iommufd_backend_alloc_vdev
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-3-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d46243-43db-4790-5bdc-08de5cd25cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0tzditzN1NaM0N5UmJLaGRBL3FOTWZuY0ZVR3k4Z2pwaHAvd3VTUXJkekNK?=
 =?utf-8?B?MlpveDV4eFJ6VDdPK01tV0NHNENaRGxvcnRYSUd6RE9BWnpuM2ltT1lvOEp5?=
 =?utf-8?B?VExTWEJOT1VBdVlkYU1mUm9JU01FN2U3QWVTcXJHQ1VPTUE3NWNqSTVCR3Vp?=
 =?utf-8?B?Rlg3bVNCM0ZiZDRZcXI1alk2MlpkcXB6ZWRlU1Z1TG1aOVFFcCtJTmF5Rmpk?=
 =?utf-8?B?YU5WR2lIMWoxUWxyTFdyclVyWVMzRmlHOTZDenNPL0ttWjBwVkJHeVZrbi91?=
 =?utf-8?B?VzNSL3IwbnRURC91dmtFcjRaTlpVeUZMM2c5enA1YVVwRXI1VWUwdlY0eE9E?=
 =?utf-8?B?R0JUUjZxK3lSNUVuUTR4MUtYSHlEbmFFRlAzaDRFZEdSaU1Qa3BCNFEwbElU?=
 =?utf-8?B?THR5TGtOZ0dMK1RpMllnenlBVFdESDlBOVFidy8wSWNhU0NjU0ZSbHRBa1hS?=
 =?utf-8?B?K1AvMnRVc1N4TUhOSUh2TDNYWm5PVnkzSEt5VkZYNERVYkRLYWlHZGxDb3VX?=
 =?utf-8?B?azVGMWRXN0JzcHdXQlV6dFh0ODBMZjkxeGI5THR5Q3Z4UCtPeGx6b1VpQlJP?=
 =?utf-8?B?S2ZOZ0p5UUpkOFZrZW0xUDVHM2dFL0FuSTExN3NVNFdGMHlwVCtNajhFU1pZ?=
 =?utf-8?B?WTdDeGVjMXM1djRucTJhdWNrS051UXlINkdxdjBCNXNTWXdvSjEydk1YZ25k?=
 =?utf-8?B?UjExSHJlbkNnbHF6dDZUWEJWTEdUUkJsS0VNeWRocnprTlVtZWdOTVhYZkQ3?=
 =?utf-8?B?TkRBeDk2N2w1OE9WR3gzQi8rWUl4SzJXL2hleUlka2dVS29JRllHeGU4L2Zi?=
 =?utf-8?B?akhtNHlWSGJZVEo0VGllMmdhcU1LdEVrM2xEWFNzSm5RZjJPdXUrZ1ZEdVkr?=
 =?utf-8?B?eFh4MFBzRlU1R1czcTM5ZldlTW85cHRXbG5URXdodEJ2dzMxK21GVUpEczJQ?=
 =?utf-8?B?bElXYmduQTgxeUFPQ0gveXoxMFJzODl6Q3FKK3QvcThHdW1UK1NFQWNTb0NE?=
 =?utf-8?B?d2pjMEd2bU9qZG8wOTA5Y3dIZVV6OFplSWZEQ2JPR1o3Z0VDMlNmMFNiWk5O?=
 =?utf-8?B?c3RqWC93K3RlVHIvSklRZVQrN1RGUGNUay8wZHZLb1dBdjdlZzBBN0MwZUF1?=
 =?utf-8?B?VFY0RjdzS21WdkoxV3ROanpWaVZjSkxzYXYvYnJwRE5aS0p2M01RdFZmdm0x?=
 =?utf-8?B?RTFmQ21jVFNERWYvUXJsV0hzQ0x0VG1NM0hvRnRXUXhSdU92aFRXTlJnRmJ0?=
 =?utf-8?B?TkpsUDI2M3Zud3FtOTA4bXJVQ2JnZk5lcSttU2N6V0s2M1BCQW90cndIOStu?=
 =?utf-8?B?OUpLaTJqUVp1MFh0U1kzdENUQm5TS09Sa3JuS0g0VG9qaTh4bkJ5TFA1TGg2?=
 =?utf-8?B?WC9aeTV6Q284WXJSeTZnYW1VVnplZ1Y3UnZLb1Q2TGFpaGpvR1NjenVzY0p5?=
 =?utf-8?B?NEwvQTFoTnhQTzZCSldESHZBNVk5ck9UTTRUTUlzYnVXbWhPVlFoSTRXR0U1?=
 =?utf-8?B?RUgraW5uVTdUSmxsREUvZmFCQU83RGcxd3RLdStGblJyRElhSFl3Y2hsazdp?=
 =?utf-8?B?UWJ1QlVrM1Z5NWNERHdrc2RsTkNNVkpoQTdMclBKT0dwd2tycG9JbjlWZmRQ?=
 =?utf-8?B?eTJMVEY5OTdhZUhIeWVEL1UvLy9EYUhnelJkckdONTFEWHdtWDFnaDYxNng3?=
 =?utf-8?B?U1ZJUWpOVDB0dUtLVnBZZWV5TzBBQVpXaEFuQm5GRWVDeFFDR2crSTlMeWJS?=
 =?utf-8?B?c0ZHejRsSklQd0RYZVRsVnhNSTRHOGVxeFFYT2FxS0Yzd0VIQ3hzanlwd0Vs?=
 =?utf-8?B?T05qNUtYQmJ2NG5OaytOU0FTUXZoMnlxWVlYOVpRc1l4UUEvL1Flc2JJSVBX?=
 =?utf-8?B?Rmk5YW1DL0xUeEIzZ3JvcVh6U1FJZ3dCclA3b2Z0NTBkbmozd2h6MXRMdnlk?=
 =?utf-8?B?OEttZzBhK3RvS3lxQVZJMmxWMTZuOUlFS0s4SmRoanF0SUFZeHlNbzhETmtn?=
 =?utf-8?B?blllclVacFAvaWNTWHhGcEZaYmNIMkM2OXpMNXd4ZlFlZHpERzRRWUMyN2ky?=
 =?utf-8?B?NE1OZW91VlhMT3NyNFJ0NEF2ejlaelFKd1JBRnQ1QlhaYVdqd0E0a1JBeWVP?=
 =?utf-8?Q?+JFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRxTm9VUUdkYkpvaHFGVFhsMGFTK0VmWmJPT0RWMkZ3OTFCai9BSCt1bDJy?=
 =?utf-8?B?VFI1OW9ZRFdOSi9xZ1VKU29sNmF4VHMwZGVZZzNZZlI0M08wbUFaTXZhRWJI?=
 =?utf-8?B?dkprYkkxWnRHV2h1dEhmVUVwR0VoVlB6ZUsvN2ptV3VNd1NhN2Jobnh3NHJT?=
 =?utf-8?B?SGdiUU9scXFpdHpDOFRtdko4eTNTMVFJMEEzTEFyK3NMRHNsYU04eC9uUzgr?=
 =?utf-8?B?bnRNdTRUNFBNY2ZJVzJzZHp5VUtWaG9mQ2ZrNE1hTk92YnRXNDlTRGhVeFZR?=
 =?utf-8?B?bHlIZnc0TFpIZHpRNWpxQ3h1SFBlTnNYSnZpWElkRlVaZ1JpcXJnVDFGTVRY?=
 =?utf-8?B?cGdjOUFWajB3Y1lLTmJlZmFQZys5b1NLbjhpbWNxallIVTFmVkFUTmJEamg1?=
 =?utf-8?B?eGYwaXpiTTVFN1FPb083dWVEMWNpcWx3dWR3V3Iwb01oRzdxK0xFQzRxQkp0?=
 =?utf-8?B?Z29CeHhDRFBPVVR3ZHpYVkxPT2R4ZHA4VUFRVk1razlqd2lIVjhUNG5yR1k5?=
 =?utf-8?B?aXR0KzYrWTVQWTJaMk42R1JUMXd5MzJGbXFpbHo1K1dDd2tVZUZoN3pCVUFx?=
 =?utf-8?B?dHZsNVdFV2lob281SGI0Q1FJeDEwazczQWNrM2N3ZXlJUEdSZ2h2YWwxVGJU?=
 =?utf-8?B?WVA0VklHVUplVEFaRHdXWDhjSXZnZmFHQVhybE5JWEh4ejJFMnRmUFdHY1Ex?=
 =?utf-8?B?U3hWRm1kVlpUUHovOHVYM3ErZFkwd0Z0eklYWmJIR21LTUlBNERRZDZ2T0lu?=
 =?utf-8?B?ZkVYL1M4NTJZREdLRFQwa3g5L3lGdFlBd0o1MCtZbnpteDR2U3VWMzhCSW1O?=
 =?utf-8?B?SzhDZ2VVdWJVclJXemhvcnR2VjF5dFJRNXF3V2U4bEI5a3BNK2V0UUJWMkUr?=
 =?utf-8?B?ZFJoYzVYN2N4b1JnSnVjaXRISlJGZkIvR0d3ZUpxWXc4RHU2YUJYWnBTYkFO?=
 =?utf-8?B?THNad1Q2amZaSW9SSkRvNm0relhRUjdjSzVXLy96aDRDSXExUFk2NmgwZ1B3?=
 =?utf-8?B?NjJjU0JkZ0VKR2tXWXRja2VkZTB1aDB3MHVESy85MDZUUllOKzdScmgyUmpM?=
 =?utf-8?B?YXBwSCsrcjhYWG9KNG1taXhkRW1YU0trSTgva1hBcDFsL3Y3WkxQUitNVUZs?=
 =?utf-8?B?TSs3b0dwQzgvZERWMzljNkFHR0xTbjJwZ2lmb252RFRJYyt6RlFHb09SK1Qy?=
 =?utf-8?B?cm1CQXJmbWFpZDBZYkZ3aENYektLRmRUMTFCanp6aC9oMEhHSGRTZGNybmJW?=
 =?utf-8?B?eURPdlhIVWdVc1d1V2dMOUl4UXVtNnRBNWhmdHlCUWRyKys1amtZRi9BVXNh?=
 =?utf-8?B?cDZRaml1d2JtVytNeUh4R21DejJ4TzdSSkpabW5mczFyR0R0QlM2b080RkVz?=
 =?utf-8?B?b3FWUW5QS21lc04wSG82a2F2YzhKS2ZVcGE4ZWJPeG5xTkZDUUMrc0JjbmMw?=
 =?utf-8?B?cEIxTVBpcCtwdFhIeUV0M2NBSGtLRUJmZ1ovM3VCODlFR3d5ZzM5Y1FmRDFN?=
 =?utf-8?B?MFJtR2FWUjFpL0pNeTdVK1NFeWpPRERuREFXUHk3ZWU3QU1sNEYvKzFqaGVM?=
 =?utf-8?B?N3NmZ3JDZlo0MFVSTGRjVExQbm00Mk56dE16bnNodEliU0dYak1oTmtoenZx?=
 =?utf-8?B?ckF6S2RkS0plLzZaMVlmY3pFRitBUTJrVzNPWUJXK1RpOVl1VDhEbzBpTUh1?=
 =?utf-8?B?UnR3Qk1obGZVaFlnbXNqZWwzOFBYdmFRV2h5SXY3SlVQS3V4RmpncndrR2h3?=
 =?utf-8?B?Wk1kKzVOcHh3MVVFNkZWa1ZhMmRZSVNuQzlqNzJUc1loNFdXYXlsYUNpZnFH?=
 =?utf-8?B?TE1nMnNLSHEwdDV4MnFTL1RDaXAxT0RSSzFOcFlzNnFaODJYUFREKzZGeFRH?=
 =?utf-8?B?NnNFc1hGVHVxdk03U3dqQUNwSTF5MHZCMDlGRk0xSjVRaXdHZzJRK21za3lq?=
 =?utf-8?B?Si91S0dhQWdOcDltNFlxRkZOS0JqNTZ4YUNUMTRWMXB5bHhvMHl1bUg1aC8v?=
 =?utf-8?B?OS95TXVaSGZ5Y09xK1c5dTA1YlEwQ1pqVy8yc2RONlVJTkJ2b3B5bjMzdU1v?=
 =?utf-8?B?QUFVVnBVYSs1NHZmcEdiVWY5bjJjd3Z6SEVNMHRZdURtK2JNRmlvTFpYcEM3?=
 =?utf-8?B?NXBkOUVpTVJUU3krcHFNbGJxbzdvVHNsYXkvdG0rRy9RWnZEaGFzeEMxWjRs?=
 =?utf-8?B?bC8wNDlrYnVGSTFZMzBQbWVIcVpJdkREcGpOMDB1UDFhM0RnaHNqbTRYUVdh?=
 =?utf-8?B?NFFlSFRhckdxYTBKeTFUa0ZjdEpPakZ3RTFiNEVuTXY4MGxJYnZGcFJ4RWFU?=
 =?utf-8?B?QTZJMnRJcEFxZ2ZRWi8yRGNVbUo3UUh5TlpSVER4YUIrbnVPK0xWUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d46243-43db-4790-5bdc-08de5cd25cd1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:59:30.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gQa4UnvH0HaqIy4qcIQg5BQCv0hc/6zGVyWymNiX/An9Te7WeYVwca09PJsnmn6evnf1UQnM+pRbEqM14JEvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 2026/1/26 18:42, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Add a helper to allocate an iommufd device's virtual device (in the user
> space) per a viommu instance.
> 
> While at it, introduce a struct IOMMUFDVdev for later use by vendor
> IOMMU implementations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c       | 27 +++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   include/system/iommufd.h | 12 ++++++++++++
>   3 files changed, 40 insertions(+)
>

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index c65dc41d71..e3a3c1480e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -473,6 +473,33 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>       return true;
>   }
>   
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp)
> +{
> +    int ret;
> +    struct iommu_vdevice_alloc alloc_vdev = {
> +        .size = sizeof(alloc_vdev),
> +        .viommu_id = viommu_id,
> +        .dev_id = dev_id,
> +        .virt_id = virt_id,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev);
> +
> +    trace_iommufd_backend_alloc_vdev(be->fd, dev_id, viommu_id, virt_id,
> +                                     alloc_vdev.out_vdevice_id, ret);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VDEVICE_ALLOC failed");
> +        return false;
> +    }
> +
> +    g_assert(out_vdev_id);
> +    *out_vdev_id = alloc_vdev.out_vdevice_id;
> +    return true;
> +}
> +
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                              uint32_t hwpt_id, Error **errp)
>   {
> diff --git a/backends/trace-events b/backends/trace-events
> index 1ae94c4290..14a7ecf5aa 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -22,3 +22,4 @@ iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) "
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>   iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> +iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index bc4acd1e8b..567dfb7b1d 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -48,6 +48,14 @@ typedef struct IOMMUFDViommu {
>       uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
>   } IOMMUFDViommu;
>   
> +/*
> + * Virtual device object for a physical device bind to a vIOMMU.
> + */
> +typedef struct IOMMUFDVdev {
> +    uint32_t vdevice_id; /* object handle for vDevice */
> +    uint32_t virt_id;  /* virtual device ID */
> +} IOMMUFDVdev;
> +
>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>   void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   
> @@ -73,6 +81,10 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                     uint32_t viommu_type, uint32_t hwpt_id,
>                                     uint32_t *out_hwpt, Error **errp);
>   
> +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
> +                                uint32_t viommu_id, uint64_t virt_id,
> +                                uint32_t *out_vdev_id, Error **errp);
> +
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                           bool start, Error **errp);
>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,

