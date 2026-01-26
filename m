Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B1CF65E5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLFo-0007n0-8g; Mon, 26 Jan 2026 06:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFm-0007mN-Gg; Mon, 26 Jan 2026 06:59:34 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFj-0003Ne-Vt; Mon, 26 Jan 2026 06:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428773; x=1800964773;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nM/6WfQbEZ+uQu44v2fo+dCvL51tHAF6KtxNkkV9B64=;
 b=II7AmMVivJt0BdrT7hVDYOpT6aI3nFLVgMzOefEt9G+2HE7E3flBzYLB
 0oNjXkeyOzvile8FDGj1Lo2m8VSFZEkPZ+seimcHJpJRLgnjoTk7cXL4m
 opv4aX03U3JSdTZCSY0oTOUlf5u4g02ca0UIlqAyWNW7AW6TEeUIEUkpx
 coUqLun1BefDRbJU0OrK0hgQrcCGW+oS+oS4NI5TvN0VRv+k07+ZRBdL0
 u4jm92J90RZPPfNPghPB9cEqriNCjpaQ8L1eIrrTGTRGPHvawq9LhPlx2
 SyPnBAb6edi/CYsYepj/ZvJbcx1Ukl90j0yVASHBKMQUVrBfwRVtrEOYU g==;
X-CSE-ConnectionGUID: XSHaQbihSDyoOxtxn99VJQ==
X-CSE-MsgGUID: 64XKJXXKTD+DR8zSPAhQoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70507365"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70507365"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:28 -0800
X-CSE-ConnectionGUID: T+p3Fg4uRQKOX2IKkJZbww==
X-CSE-MsgGUID: aK56PKXfSaa5vXjqs6yklA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="230613205"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 03:59:25 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lguxgkED71KlhjY6mfjCmjw322qrPzdfawmV0MfpMGBSh0OkgOcVqTL2Sce6HoSv8VfJP5c7yfGI5oNyb5kw6KbGJ9UlPBIEUpZSLD4rjILpOk+IpYVp5iJthjrJpWzB0TdWtOCkgEJbft3A5KNuLrueHO7C8l87ZzOOGfjo4UB/8tN6W6rn0XhtYZqzQtRvTPuqzf7rzy8N9Yfcj49s6DtyYq4KwHc965eUUNnS4WcvMmY42Nl4UCE5AYHfOQ97ACKL4eM6wxIAZjwtsw+trFAJYT6zeMMJxIz5PFIWLqIpeSMFktRITby7DUSTBp5MM7ab0RLrI0RVK/neDPI4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfREJBhp05VIeI+pbZF73j4RTn9OiFAcqIZartgo6zU=;
 b=ZzntQzZrKu2bcIbVjDuDwc28VJeBXpBD7CckqV4ZPJmY5VflTBgb/XMDBZcX3ENHHBTCoknZjzsq1XRrj3s4o9X0XFLHJZMa4B6bD/WyEeVgcVBK8DGdzqSxbRTMMjXOFCRrHWch4+9w7n+kWaXLLDh28/5nGR+lmiJM3B0xxea0RqCRA15zI6uAc1kmfirNKjlNxnIjnNU5Ay1ci6BfXP8cp1DuH3tUc8HSYkhb1+vXTUcmQws6T7aFDzu32MsU9knMHGALbS+mdJWWvHMu/nDg21uo4/bPtS4+JM+nsUmBkcpOh5o6LtLplKg9NOFHwm8Xd5pglCy9pBtcoLM4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:59:22 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:59:22 +0000
Message-ID: <9354658d-6970-4b7c-bdd3-e74b0a27e568@intel.com>
Date: Mon, 26 Jan 2026 20:06:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/37] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-2-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ccec67-2f83-418b-d34c-08de5cd257a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmZoUGpkVDZ6Q1V4L0ZIVzNzZGVEcTlmZ3Vudm9WOFpwM3EzUW9sbzFBNWpa?=
 =?utf-8?B?MmJBeTBnVFlVU2REbE1tOGZFVkcwajBYQjNMbGFwL3lDVVZUSlB1VGF4cUpQ?=
 =?utf-8?B?akFzRFJCSFRMTlJjbWd5cEpjNHJlZWhRdUgrUG5DK21IOW5QZFl1VTBkU3NX?=
 =?utf-8?B?ai9LY01QNk9IMU1xZGNqSTNZSHFHU2ZIaTVKak5BMmJIU1pDUEtiWkkxbndx?=
 =?utf-8?B?RVFSaHhNdTAyTnVBSXBibjF0T3NVY0FzeG1RaEhoUnlsNnVGVm54NzlGazRh?=
 =?utf-8?B?TDdzY1BHamJTZ1dSVGRPdjlXUHprWFRLN2ltQTlycFh5dElwcXhsMjhabGlP?=
 =?utf-8?B?a2t0YVZtenV5WjdzcUdFemhVenlHbnQ5Y1JDbk43UnpiUDNTWm9jRTdTSEh1?=
 =?utf-8?B?VzhMd1YvMXdHNnEyY2pzZTE4Z2hiWFZWc3Byc0QzcU9WNHh2MFkzTXpsTGNs?=
 =?utf-8?B?UTYwdzlOZ3hTdnhtQndNNVdnSWs0eU5lU0FOTTlVMFJZbFl0enRpUDBRTW5n?=
 =?utf-8?B?MVA4TjVMV0hoWTRUQkcxWTdSRlhzK05La2RFbkhJTmNGOWM4RW9NRlBtWE5a?=
 =?utf-8?B?NHdubC9CVWltMkNoZ28wYnRLSkNia2ZnOFVUdUM4UklDM1NLVlZGayttV0Jw?=
 =?utf-8?B?NHdTZ1ZvUkRvb1IvWTJTTzlhZFhXdDNzeEhReDlEMGRMeGoxbTRkcFZsVnIz?=
 =?utf-8?B?WmNXNzlBTklGTWM5Y1hmaDRyeUVacmRISDV5ZzhZT0RWRWhMU2w1UVI5dWhV?=
 =?utf-8?B?aVlzTit3ZkJid2lLK1hRSmJkOVNrdUg0QXZEbnVUaEUwUnB6Um1ZN1RxOUYv?=
 =?utf-8?B?QUZvZXdtZDhaRldSSGJ6VWFpR1N6Z3hmZXV2WWw4VGIyRVNhT2J5Wm1QV3E5?=
 =?utf-8?B?TGZMazAxejIvbE55OGxjeXdUQUl1VTZuTGpLbUFlUjFEOXVja2lyZ2VzejRW?=
 =?utf-8?B?cGN6TnltaDJJVGp6UGxEeTg5RTBDakl0VGxqU1NyZkpKZWNqbzMvZmhkZnZD?=
 =?utf-8?B?Q2ZWbE5rODM5Q2o0c090V01XWTFlRUtob0FSMXdReExybkF2M3FkRG1NK21t?=
 =?utf-8?B?WWtRckl3eXBlc014bGtFd3FMVUQ0Qk9rOHFJeFNla3R6Y0hxdEtuN2N0T0xo?=
 =?utf-8?B?Y2tYRE9jR3UwRGZ2K1FpRkN3QkJSbU1Zb0FzUk5ORzBaSlA4RTI4V0x4L0ZU?=
 =?utf-8?B?M2VPSmVyQlg0TkpLdGlzc0EydStZWGZ0SElhUEV4b2RPczZoRUQ5dkx5RCtK?=
 =?utf-8?B?S2kxMHFXdzMyd2t6alJ3WTZjMWs5VXViZWdwT01PcFJRY3E2VCtyUGtDZDVs?=
 =?utf-8?B?Q01JdGdEc0Z3MWZjRFVsdnUzVEZVSjROMnFDWE5PM1hKQUw5Q2E4Mk9paXNO?=
 =?utf-8?B?QWFWWHNRN1VHQU1LT3BWcTRDcjJ0L2ZTZVAyY1llb3ltOGQ0S3gyNEprMHJE?=
 =?utf-8?B?SWZkY0NHMEREQzJjeGF5THZLdHIvM09ZOG5MZXRidUNrTUFIV3VFdU1zTVE0?=
 =?utf-8?B?M0VWUFBqMzRGVVdoNUpoS3JNeHF2Wmx5NGxwaVNEcml6UlE2NzIzQ3pRRE1S?=
 =?utf-8?B?a29ISDkrNmNJYjA3cjJwcnF5OVZpdWJld2I4SDRjWDd3am5rZytGU1IrVXlu?=
 =?utf-8?B?RTlQNGhlWitxTGxYdUZYNmorUHZUNkpHaUlQNVJzd0RSMjNTTjNjWW5GOEgy?=
 =?utf-8?B?WU1rYlFYdkFmckYzdGltY1VJNWZYVUkzSzRJVlJFMnZXd21XQS82NE4rNStx?=
 =?utf-8?B?cnZmUE9aOUhiLytWekdDTzZOT2duNTZWUmg2bllSSGdQS3Y3dlkxMUJ3dHMw?=
 =?utf-8?B?Q2dTdno3Q1B5dEU2M3hFQVRoaDhWYmRGYTNtV2ViZjU1ejl6MnN2a1pUQWdL?=
 =?utf-8?B?bFZEcFZBMElTTUxEOUtwWTZMRVE2YU9BS29lMytLQVJlUUdCak1qRS9PRTU5?=
 =?utf-8?B?Wkx3alA0Q25uWW4rY1lMZTNIMW4ybUIvWHRXSW04bkx6c284K0YzemNKTGR3?=
 =?utf-8?B?d1BSbnJIVzdHbDFOMFIrbnNyZTNiVmtWelJZcSt0TjIwU3docTNQeXh2MDV0?=
 =?utf-8?B?OElkUE5jL0x2UmJMSFNETWVjd3NPRXlvYlVCQ1VJemJOS1BDQjQ4MW12bnhz?=
 =?utf-8?Q?0qVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUo2d20weWRReHNhWGd2Y1hYbXZ2WmFvcXZCRFk1MnRDMUtOUHBnb1pWam1F?=
 =?utf-8?B?WWh6cU9YY3ZBQkJiQnUvNjloU0xXc3BpcHFFRUxvT3BoSVYySll0b3J3WDdr?=
 =?utf-8?B?QjBBdW02VHRmdFFNR09NazVENENVWFRCbFN4TElVRDJTOE1aYUx2TmQ2ZXJV?=
 =?utf-8?B?RlFVdm5EMkpUTk9UMmgvd2RlNGdYSlZwQ0FjcDlmZXhaNXFHUjA1am9ndnJk?=
 =?utf-8?B?czdqb0lLUGN6RHZvblNaK3NtZWI1MFZHMGU5QTArYytGWEo1L2h1T3hXcHhG?=
 =?utf-8?B?M0ppeWJlQ0Y2RG5oNGxoS0QzMERaZGZLUHlJd0pTNmZ4WkFwbFJZYXN3cEZo?=
 =?utf-8?B?QUkvMVIwNGtlemVtRVdpNlUwLzhBdHVrbXN1TWZ6VFRrUzkxQm83QXdNRGRy?=
 =?utf-8?B?a3VaamJrSzgwYnJ5V3YyMWNKK0ZLbmE5NEhaaWNzbEhhaUpFTGxaVVZ2cW9k?=
 =?utf-8?B?TjZvaXdic1RLcVVyeW9PbDJkdmF2KzM1c05hdUptV2ozRm9LRWFWVGFoY1pS?=
 =?utf-8?B?c3kreUhneGMzTVkyQVcxWG1CYW1TMytqOGJUbkRkUzdzN1ZJVHZCLzB3TVRN?=
 =?utf-8?B?aXFxR1FuWGh1UVZhU0dxb1hNWXQrS2NCR0N0TFlQZFlEZGdmMmgyMjBrREJH?=
 =?utf-8?B?WTRwRzcwVXRqbjRlNXlsVjkrc1krYVFSZThzZXJxajNkTko4ZUk1aCtxY0hS?=
 =?utf-8?B?ZzNxdWhtWVJvcHNTUU1ERFRRT3laSjBleXlEWVpvOWhNTHJhMGxScWpieVRU?=
 =?utf-8?B?aStWOUlOcGZ4a3hQRFI4Z1JhN0VEVUN6OUZGOWhsL0htY2hmYnJaUkJoNlly?=
 =?utf-8?B?c2ZxZXBLWDVndTZ6OEZROThtUEFJV3VsTmszMjRoTDhSWUJqc0JGNVJseXNt?=
 =?utf-8?B?K0NVcHUycnhhN2Uvb0xndHIrWjlMZGx2T2xYTGJORmp0a1RqTkRsSks4bTRU?=
 =?utf-8?B?Y0ZZaDZwMnNqNjA4T0NKN0ovOFhESFlsMmRlcEY3ZytpdjBFcjkvZVZpaUZX?=
 =?utf-8?B?MTZBWEJPZ1ZMWEpXTFY5dnJGL01NM2tNUGJXRUs0WWcveDBQRWpZb3ZNQ094?=
 =?utf-8?B?ODlqbmxxRU1hSFdYZXVnY1dTZTdteEJsYzdheXF5RmtSUnBpeUo1Zy9WY2pH?=
 =?utf-8?B?emRkcXdQQUtrQVRXejUrQnFUaWdEVmI3MUlrZTJzVDdWQWE0UnQ3Tk9tZEd0?=
 =?utf-8?B?aGNIaEV2SDBjN1l6T2FFVXEzVzNZY2hBVWFVUWVQQXBKRGxDYnY2dnB4U3Vv?=
 =?utf-8?B?TW9xOGRSSm5aOEQ5WERDbmlPY1FiN2hSUjl6RWQ0Rkpidy9jM0RPdHNPa1FX?=
 =?utf-8?B?OXVFempScDdrZjFNcG52RFJMRGtxd0p1VTEyaWdEWHZsRWY4NXRWMkR2QWVP?=
 =?utf-8?B?RkUzUW01QUIrYWd4VXRGeHpxeXFtNHlySUFzb1RHTmxoVmIzQXkrNDJrd2lj?=
 =?utf-8?B?TFBaYXZsUHUxdkdsT0g2ai90RS9sSG00eFVsS2M5RlI2T1VaTkNMNzZVRmth?=
 =?utf-8?B?Z3RIWWpLbHFDVXR3b1BIZnZQZ2RJT3REaWswdzBQSUQ0d09jMmJRSE9obmFt?=
 =?utf-8?B?RGEyaEZPVllkazNKalZLYkRsOFZaK2grZUJ5ZjYwRVBRM3E3RDU1bXZvZFBM?=
 =?utf-8?B?emlWbEZLV0pQSTlTcUMyNkdodkVwUG1aNFhETWROSFRWc2ZJQnhpbzdwOHJo?=
 =?utf-8?B?NWQvQytYMUFQMWxIajFyR2VEbFRMTzhERVlySWJLQU1UMlFwT3FzamRIaGFw?=
 =?utf-8?B?TW9qc3RHSWdDTjhuTHhnRGc3VjAzYzZ3K01HSG5WbllnZlRyN0hRamFwQjNk?=
 =?utf-8?B?NG10Ylp4bFJPcjFnM3VJcGJXcnFiaWRCY3pqUWt2NU5MSGNUeXluVkFmL3NC?=
 =?utf-8?B?YUlQVFN0c21XR0lvdldwZ1hNbG5aWGhxUllxbnZGQlM5ZHlOL1FvdkVvUCt3?=
 =?utf-8?B?VDF6WndNZTU2K29yMGp2MVpmTmd0SmVtTERmWEZ3QXZqa3d2OGgyNHUxYkgz?=
 =?utf-8?B?OGs0YmpwWjljOEhBc3I0SURjUGpwL0tYOEd4VDgrQ3JLOHpZRVZZRE4wWGxO?=
 =?utf-8?B?b0M2amNXTnUrSGlSaFpFLytaWmswRmI1Vzc3OTk5RnFvQ0d1MGVrRGVtWmh4?=
 =?utf-8?B?dEtiNU9zenhYRk5LUE80ZmdXZGpZV3RwSHBVTlBTM3hNQzBESWJudmtFMHow?=
 =?utf-8?B?VGMxeGx2MXhNV2VnWmFyN3VGZnY4UDV1aUd4WFNVcG92K3U5R3NVUUVMdkFW?=
 =?utf-8?B?RVp0UWJPbkVSU1cvYmtYejVpWlQ2K1REcVd0M1paS1d6U2FaSzdUT2UyMFUw?=
 =?utf-8?B?YkxFWHdSWkQwQ3ExUmZUV3c2ejhGNnE0RVUzMGQyMktWZlhyTmxydz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ccec67-2f83-418b-d34c-08de5cd257a7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:59:22.0129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEhnK7sQakKM0ZKWi2IZWMXoPhAwsYcw4uysVbrAjLwxmpyTi9kR6oitVxnNOI/l8zrVIxutdRWXqrADHOvEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
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
> Add a helper to allocate a viommu object.
> 
> Also introduce a struct IOMMUFDViommu that can be used later by vendor
> IOMMU implementations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c       | 26 ++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   include/system/iommufd.h | 14 ++++++++++++++
>   3 files changed, 41 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 086bd67aea..c65dc41d71 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -447,6 +447,32 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>       return !ret;
>   }
>   
> +bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
> +                                  uint32_t viommu_type, uint32_t hwpt_id,
> +                                  uint32_t *out_viommu_id, Error **errp)
> +{
> +    int ret;
> +    struct iommu_viommu_alloc alloc_viommu = {
> +        .size = sizeof(alloc_viommu),
> +        .type = viommu_type,
> +        .dev_id = dev_id,
> +        .hwpt_id = hwpt_id,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
> +
> +    trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
> +                                       alloc_viommu.out_viommu_id, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
> +        return false;
> +    }
> +
> +    g_assert(out_viommu_id);
> +    *out_viommu_id = alloc_viommu.out_viommu_id;
> +    return true;
> +}
> +
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                              uint32_t hwpt_id, Error **errp)
>   {
> diff --git a/backends/trace-events b/backends/trace-events
> index e1992ba12f..1ae94c4290 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -21,3 +21,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>   iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
> +iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 1392706b83..bc4acd1e8b 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -38,6 +38,16 @@ struct IOMMUFDBackend {
>       /*< public >*/
>   };
>   
> +/*
> + * Virtual IOMMU object that represents physical IOMMU's virtualization
> + * support
> + */
> +typedef struct IOMMUFDViommu {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t s2_hwpt_id; /* ID of stage 2 HWPT */
> +    uint32_t viommu_id;  /* virtual IOMMU ID of allocated object */
> +} IOMMUFDViommu;
> +
>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>   void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   
> @@ -59,6 +69,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t data_type, uint32_t data_len,
>                                   void *data_ptr, uint32_t *out_hwpt,
>                                   Error **errp);
> +bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
> +                                  uint32_t viommu_type, uint32_t hwpt_id,
> +                                  uint32_t *out_hwpt, Error **errp);
> +
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                           bool start, Error **errp);
>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,

