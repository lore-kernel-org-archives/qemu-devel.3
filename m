Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D814BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 19:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7JsE-0002HM-SH; Wed, 15 May 2024 15:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s7Jrn-0002C6-11; Wed, 15 May 2024 15:00:45 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s7Jrj-0007lb-7V; Wed, 15 May 2024 15:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715799639; x=1747335639;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fSToX0m4Qf4xxrQaf1F06lkE/r9I35M7hBrIhb+jp0w=;
 b=lNVCpVi/CNaU7CSwFP1hfyY2eXsShJZVL85h28hTYTd5gNOJYJ3xE1r1
 ZEC+lwZH04yFs2aWMN3qM9UioLO6Kg3wiBl9I4DEPkXmd+X43s0oFHx6R
 CrEWzeMx+oVbHkkN0BEZwq9z/vLksvrvUdTa3ua+ocavhJFKLtX56cJ9d
 4PfPVO6hDyZCXMeOD/i5Zkn0szhZqgBfsTfy0qOu0iS9aYdRnWmY8U5Uk
 c8bvUhuzHu6dUr7jZ4cFTTG5lvnXvIPjNFCmzKaG682B6EO3wmozuinvo
 Bi4X6+vP3+vE9jdEp7lZlU7pi4uYl4F/sPENB5khReVcUCsXe/MmhPLRp w==;
X-CSE-ConnectionGUID: n6ub6Mp4RlCxtawnDYIddQ==
X-CSE-MsgGUID: XWK5z/n6QFil9MUJpEWiWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14824739"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; d="scan'208";a="14824739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 12:00:33 -0700
X-CSE-ConnectionGUID: ZJ+jxsUkSQap6CJQsP1JSA==
X-CSE-MsgGUID: mmMtPzR+Rc2nmbWxiAadjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; d="scan'208";a="31283818"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 May 2024 12:00:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 12:00:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 May 2024 12:00:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 12:00:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 12:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emZ6FacKEetX1qtz0Axv9biZOXq3Umr1B1eGTik1lpdwY8gQULpmeUBErDfUR7zCGpKngJ3/YdVGPaT0V33LMZcJMESyuLj4IITujSrawiRwFgILx7YBvV7WgVO4SB9Um967/YIsOu1DbyGRAATsu3EhbiXMvbtunZ1KWy8CYtTBnG7wZU0UkWZLObqlZE4Ra9/waHWEfsQUGfGseaYz4lG+2akfcEiPAJWUHM9dDGCGxGCK0W72aLNU00+nvbbjxL1xYH3FJaQZveyNU6UIHUBh0xcUXGZSFn+1sk8yL1/LQ9hvGGy9Rkb25f6f3CIzPFu1ejxtOEXiQRlp8AamUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSToX0m4Qf4xxrQaf1F06lkE/r9I35M7hBrIhb+jp0w=;
 b=frchRBYu1eYrElvUhzjnD6ysjWWqMHiSf5eL6oHw+VPcwUuAJ47OHC3q3no9nAKJSlCdwd0VuyVaZ32hI/eTYc7S7n/8PqH3Fm/VQbxqWQVMok0FgYA1iyGZoI4TqIthqaVebtUHEQSv2wyTJjBeZ/SpOCCpL50p74RlY4CTf6CGagUeymR2fqElg0c6DvuUQyToOxv7Iq0TZjF4UyL00OrThhH7Zkhgh07aNU5Ui6ydTVyq8BbPnIPlcVVBo7buj94Fs4I3u6iA5I0jp/2exeuhWgbadAFoO4DV68RYm02rhh8I1+FgqAqA2pR3DgmAwp2x858qRGQdwi9iC503xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 19:00:22 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 19:00:22 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-stable
 <qemu-stable@nongnu.org>, hikalium <hikalium@hikalium.com>
Subject: RE: [PULL 00/11] Ui patches
Thread-Topic: [PULL 00/11] Ui patches
Thread-Index: AQHapgf6nex1G+XvxUyX1JxJc+Uw87GYGPIAgAAEkACAAIdjQA==
Date: Wed, 15 May 2024 19:00:22 +0000
Message-ID: <PH8PR11MB68794F26D8C677C1C8FE6A4CFAEC2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
 <5d004901-f1f4-43bb-81ee-d78ec0a83fbb@tls.msk.ru>
 <CAJ+F1C+MFkbTGmzLujc7=Q74uGz3fUxkZtp3Yi5eUOLQYco6ow@mail.gmail.com>
In-Reply-To: <CAJ+F1C+MFkbTGmzLujc7=Q74uGz3fUxkZtp3Yi5eUOLQYco6ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DS0PR11MB7482:EE_
x-ms-office365-filtering-correlation-id: 4338c267-3bba-4735-f40b-08dc75114596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZVVvOUpjMDlrb0FCM2daeUJLUDlNZjRHSXBJamphbG9kMlBIMFNxaU1FaHhH?=
 =?utf-8?B?R01MU1FMSnQwSFJ1OFVwQ2lkRCthMHV2cEJVMXlxUFBpbDBPdnVKSC9ZaFkv?=
 =?utf-8?B?ZlRCdWI1WGEvcHQ1dEJyNXRjeFlzbzNXV2lKSSsyRE5vSzJEcmlPWUUyWENV?=
 =?utf-8?B?TEt2eVJ0QkQ1a3pSZC9seG5FT0Nta1dMSWYvQjJSMkhTY2U3WkM3cEM4TGNV?=
 =?utf-8?B?TTFTSm5kd2lreTFVaDdXVU5WTGh0MTdNUkwydjZsZDlOSEc5V0JYSjlzeDFn?=
 =?utf-8?B?TStoM0lROUdDRExSeGxCYWFaQUdQM1RjWnEva1MrTFZEK0diRDhKY2VJU0hs?=
 =?utf-8?B?RkUxZE1jclFpcFA3M1AxUFl5VHdTMFc3SXlkZVFzSkJ0OHhQSHVwaUdxM0N3?=
 =?utf-8?B?UGRoclZMUTE2dkpUcHVnbmt6L1ZzSmF5WnBuNE0yNUhUbjJyWldTaTc0TlBZ?=
 =?utf-8?B?Rk4wQ3JSQVJaYUF3dkpuMWQ2dmJqUzZaR2NRVXkvVkt2NzF1Mk91SXFFdTUv?=
 =?utf-8?B?cVN3QVZINExCTjJjYW10bzdUd2VOUUh6NUlWZjdBS2F2WEtHTHdUMm5pbE5M?=
 =?utf-8?B?Vkc0MmltTlV1ZVhtNE1lb1lUQS83VUVpSjJKN0JreU9aYWdjNUVPNysxeHpB?=
 =?utf-8?B?NFROWmdZTzVTeGRxbkFvUGl0RFQ3RVI4UGhhNTc0dGdiM2VVMFV3L25HaDRB?=
 =?utf-8?B?aGdXczk1T0x0dzJXS1Y5ZmNUQStDT21tUlBHd0tlamp2UkkvaTVQWDNMRjRF?=
 =?utf-8?B?bjJscHk4L3hwQjZ5VFNEN3l2azZibHpNTVNyWnRqZjk1a2tBQVFYMHg1S0Ex?=
 =?utf-8?B?a2hXaDVMNzg2THNPSU9nYVk1U1pyL1EwVm42WDJPdE4yalN6RVVoalduOTFJ?=
 =?utf-8?B?Qzk2ZnZ4WFZsSnl5Wnh1OUZpTHdEUjdpUnYxRXRzeGlhVU9wTkZXV3QvcXVk?=
 =?utf-8?B?YUdaR0VqOWdDNGZjNFQyVmZzT05PVDFHcHZCU0VhalhtYW81em0vV0ZLYk94?=
 =?utf-8?B?VktJZ2tTdVNoQjluMGNSbVB1ZFBaYlcwRmEveWFwczFTZmozYjRrK1hXV0NZ?=
 =?utf-8?B?akY0c0ZnRXZGdk95WWg3bWtpeXoxWkNtRERXSUtFL3VqNUMwTEJ6dno2TDFv?=
 =?utf-8?B?dGJFZmwwOW8yRVBEV3NJTlFpSHo0UGNBWGxQTDZNK1BTNTZSU0MxRjZoVDNG?=
 =?utf-8?B?eGcySTFrQmpDT3A3UmN2SkNpOTFNZXdhRWpaWHlvUDR3elcxSTh4MVlSTkdB?=
 =?utf-8?B?LzB6dzYvUGg0d1J1UGpPRzdwVHpBS2R0c05LbHVsbkNVQVFCeVZVVVFUcFJx?=
 =?utf-8?B?Y0dGVXFmcmRPa1FBeFFxdDduSHo4Z2E5WUZwNkRxK0ZYVlhnVFpIVWdYa0sr?=
 =?utf-8?B?TzZLbTFUTVdOQ2xsU09qNXlvUHp4cGpEWWkwdVRpcmxZWnZsVWh5KzZVWWl3?=
 =?utf-8?B?Z2Y3ZWhINGpFYXZUVEtwV3U3d29MUU1HUjBGSWxxT1NPWFk1MTBhTjBJOWRN?=
 =?utf-8?B?M21MZXVxaXNEOEg2U21PNVNUWnRwVTdyaHJEUHN6QVBVQklub3FBZ0I5VnZ1?=
 =?utf-8?B?Mk1NSG9YTlY3Y3U0a2Qzcm8yZU1xR2ZkeldwdFdWZEJVNDh5dWl1aXU1aTZo?=
 =?utf-8?B?cjh0TW9UTnpiK3Y2eGFhNjR1dCtIVDNlcjdsSk5yM1kwVGtiRXJ2YW4xb2hO?=
 =?utf-8?B?VmtGOFJJZHR3MTdERjU3bEc5aUdQM3kxL3g3UXBBcHN1OVpRYWxsOUpFUGZz?=
 =?utf-8?B?OXpHRG5NUEtML1gzUm1OWExETUxISUhONXE5eGVMVkNpTjZYTFdEYktNb29m?=
 =?utf-8?B?OUgyeDU5cjRONjllQlJvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWRuYjVDRmpJeE9TN25QeHlZV3M3TzZGalhwUVRaUXRxMnRQZ2FxZjJnQU9n?=
 =?utf-8?B?Q2VtYzJRUGFFdUdOajZDcmFUR2Y0dmtRem15RGRyeGxxQVZWT0JFSkZRRXZ3?=
 =?utf-8?B?ZklCVFMwNFdraWh3eWo0eDFEMkFCVFdTZGxMUmZOTURUT3BVc1FnUi9lZXd4?=
 =?utf-8?B?WVBxb3pEeSs0VW5sNjFHNW94MmgxRE5aYklOT1g3enhDZm94Z3RpK0Izc2hu?=
 =?utf-8?B?VFQzQk92TERsV3JURHdWa3pyWjB2Y2tuYUhKeURYS2dSaGNQK3dEOTdFTXR3?=
 =?utf-8?B?SzdST0w4QTlJQU5KSWtiUFhpM3VoRDd4N3JLdlc5TE1raHFUdGxDVWFXNGhv?=
 =?utf-8?B?L21MckRrVWJmemVzQjZtaHprM2pzWUc2bXNFQ0V5ejU4UmUzbE9oVGVhZWda?=
 =?utf-8?B?Rm9aeVVjVkV4SDNmNHlteFF4M29LZkZRekVBbVFacGlua1ROcytxZTdsN1RH?=
 =?utf-8?B?clFmVHJ3Z1RqMW1xKy9rbmNCN0ZZWVgvS1Y5OXJGYjdoeTJrZktYVmhhMHgx?=
 =?utf-8?B?TlFyVE9rbFludTU0N1Q4SWtwakU4dlZSRHgrTzJrZitYd0hCZTd2TEVtRWFh?=
 =?utf-8?B?WnNUTFUwZmV5Q25vSWMzZ2J5cUVPMzhxaFE0TXVZQ0pyZVE0aFJWRTFTY3JF?=
 =?utf-8?B?ekp4NVdTbTZady95aVJBZWRpUzNQNzRYYVlXWGd6dFQwN0Z3elZ3UHlHR0Fa?=
 =?utf-8?B?Zms2RENqT3cvR3RJKzhoMEJZVmlHSDNxeEQ4NGZEUlFDcFV5a09hV3RnbVls?=
 =?utf-8?B?SmE3bWV1QU1iS3RaUDFxdXgwTUk4WkN4K3hLRkxvd01JWEErb2dkaDRZNWhI?=
 =?utf-8?B?ankrcWY3T3ZRZHVXb2YzcDR5YkpxNEpxeDN0K2c0ejdJSWU3M2FQRE9vSmdG?=
 =?utf-8?B?UCt2TkRMWVpZZGlMaHdTdU9CYVNDVlA5NittZFpLV0VzVVpycW5TTkt6VDJ6?=
 =?utf-8?B?Z2xWUUFrN2pnbVNtNDBQTUlzRlBYaVU1R29kNXgwcGFmTjJaNmM4WlQ3RzZK?=
 =?utf-8?B?VFdRcnl2R1VQNlNaZXh6ZlpIZjdSaXhCZW5yMHdVOGZNS05URThGK1gvUktm?=
 =?utf-8?B?SHhEeTEyajN3MlhxQmZBaXg1RGFOak1WTVVZMWozQ3dJYzNZNHVSVTUxT3VP?=
 =?utf-8?B?T3lGQmpOdy8xYjI5OHp1YWlBSWV4VTNzbCtiaWpVSlNXczVRSTYzQzFIWUhp?=
 =?utf-8?B?aTZXSUFHbEROYnRPNjJkWnlUTGU1M1kwVVU3R2xtZjE2VWpIVjM4WkJtVFFW?=
 =?utf-8?B?QXBwMWFxVXVDdXFMcTFFZEtKZHA3eUE2ckE5QTBaVm8rclBnL0V5eGlzUmlK?=
 =?utf-8?B?T2RPczdtL2gvNUkwTllRMzgzNzNhUEJoYW1tOUxDSHZXcXNpNzF0Nmw3UmxY?=
 =?utf-8?B?NjcwNStESjU3TWkyRXhaUHcyUGMreE85YncvQ2ZtTjlxeTRwdnRzcTNJU2to?=
 =?utf-8?B?WlpjYkF3TkxjSk8wVEIxc2hyaTA0UU9ieVZKSDduS01lYlZuV2VVemFtWDVx?=
 =?utf-8?B?QUNMc2NnT2NNOE96QUp6WTY3YjlVZXJIekRFWGxHS0dLTG1jajNMMzVJQUJO?=
 =?utf-8?B?cVMzOWxDS1RLeXo0d3NwN2lKL1V0UE8yRlBFT3B6WFRBQm9DRC82bDBnRVFk?=
 =?utf-8?B?VW1TOHk3MFlud0pEblcrTHYvZElOaDBMTE5Ma0ZEUDJFV2ZGYTA1TEtuWnZr?=
 =?utf-8?B?bzFFRStWTXA0ejdZVWE0U05xVldxaERWT3FnT1hrWkF6TUJUVkhxOWJ2SFdX?=
 =?utf-8?B?NzNZRlArWDdXdWVVWUM0UHRzV2NBbjdESjZCc2MwTFpvck1CTXd5SXU4c0ZC?=
 =?utf-8?B?YlBOUVZMRE1PTmxrUDF0dTVVQnJlSTM4eDJ6em5HbEZOSmEzazJlZFlQZnZU?=
 =?utf-8?B?cTJoQWxvOVdQeVRWdnNpWFNrSnB3V2FPcEhWSWpQZHppaWJYNTREZk83b1ZP?=
 =?utf-8?B?eEhjL3hINlVnUGtZWlIvbFplUVRtbFF0cSs3NytkT3RSR0lPYlFPbTBOOU9k?=
 =?utf-8?B?WVZsbWNvOG1Xdm9vTi9qMmg0OGduTm5qNTFPRmNZUW5OSGliZGZIaXFVNWF0?=
 =?utf-8?B?dWUwcWVNTnV5TFZGd2hXUjJ0V2dLZHdqcW1PcWczNWhid3NvRVZYQkVaTTUv?=
 =?utf-8?Q?W+SwNcZVCSUPSLj/IHGrCh1Ix?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4338c267-3bba-4735-f40b-08dc75114596
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 19:00:22.1952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIiK4rTLy5JnrNDnmoh1FkFxUlLTccZxMGyg4PFWaOLmvysvBtTnSzAMsVr0l/b+CO9opsS83ch21hgacWOsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7482
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMTUsIDIwMjQgMzo0NCBBTQ0KPiBUbzogTWljaGFlbCBUb2thcmV2IDxt
anRAdGxzLm1zay5ydT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1zdGFibGUg
PHFlbXUtc3RhYmxlQG5vbmdudS5vcmc+Ow0KPiBoaWthbGl1bSA8aGlrYWxpdW1AaGlrYWxpdW0u
Y29tPjsgS2ltLCBEb25nd29uIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUFVMTCAwMC8xMV0gVWkgcGF0Y2hlcw0KPiANCj4gSGkNCj4gDQo+IE9uIFdlZCwgTWF5IDE1
LCAyMDI0IGF0IDI6MjnigK9QTSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PiB3cm90
ZToNCj4gPg0KPiA+IDE0LjA1LjIwMjQgMTY6MTcsIG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNv
bSB3cm90ZToNCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IFVJOiBzbWFsbCBmaXhlcyBhbmQgaW1wcm92
ZW1lbnRzDQo+ID4gPg0KPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4NCj4gPiA+IEJlcm5oYXJkIEJlc2No
b3cgKDEpOg0KPiA+ID4gICAgdWkvc2RsMjogQWxsb3cgaG9zdCB0byBwb3dlciBkb3duIHNjcmVl
bg0KPiA+ID4NCj4gPiA+IERvbmd3b24gS2ltICg3KToNCj4gPiA+ICAgIHVpL2d0azogRHJhdyBn
dWVzdCBmcmFtZSBhdCByZWZyZXNoIGN5Y2xlDQo+ID4gPiAgICB1aS9ndGs6IENoZWNrIGlmIGZl
bmNlX2ZkIGlzIGVxdWFsIHRvIG9yIGdyZWF0ZXIgdGhhbiAwDQo+ID4gPiAgICB1aS9jb25zb2xl
OiBuZXcgZG1hYnVmLmggYW5kIGRtYWJ1Zi5jIGZvciBRZW11RG1hQnVmIHN0cnVjdCBhbmQNCj4g
PiA+ICAgICAgaGVscGVycw0KPiA+ID4gICAgdWkvY29uc29sZTogVXNlIHFlbXVfZG1hYnVmX2dl
dF8uLigpIGhlbHBlcnMgaW5zdGVhZA0KPiA+ID4gICAgdWkvY29uc29sZTogVXNlIHFlbXVfZG1h
YnVmX3NldF8uLigpIGhlbHBlcnMgaW5zdGVhZA0KPiA+ID4gICAgdWkvY29uc29sZTogVXNlIHFl
bXVfZG1hYnVmX25ldygpIGFuZCBmcmVlKCkgaGVscGVycyBpbnN0ZWFkDQo+ID4gPiAgICB1aS9j
b25zb2xlOiBtb3ZlIFFlbXVEbWFCdWYgc3RydWN0IGRlZiB0byBkbWFidWYuYw0KPiA+ID4NCj4g
PiA+IFNlcmdpaSBaYXNlbmtvICgxKToNCj4gPiA+ICAgIEFsbG93IFVOSVggc29ja2V0IG9wdGlv
biBmb3IgVk5DIHdlYnNvY2tldA0KPiA+ID4NCj4gPiA+IGhpa2FsaXVtICgyKToNCj4gPiA+ICAg
IHVpL2d0azogQWRkIGdkX21vdGlvbl9ldmVudCB0cmFjZSBldmVudA0KPiA+ID4gICAgdWkvZ3Rr
OiBGaXggbW91c2UvbW90aW9uIGV2ZW50IHNjYWxpbmcgaXNzdWUgd2l0aCBHVEsgZGlzcGxheQ0K
PiA+ID4gYmFja2VuZA0KPiA+DQo+ID4gIEZyb20gdGhpcyBsaXN0LCBpdCBsb29rcyBsaWtlDQo+
ID4NCj4gPiAgICB1aS9ndGs6IERyYXcgZ3Vlc3QgZnJhbWUgYXQgcmVmcmVzaCBjeWNsZQ0KPiAN
Cj4gSSB3b3VsZCBhbGxvdyBhIGJpdCBtb3JlIHRpbWUgZm9yIHRoaXMgdG8gYmUgYWN0dWFsbHkg
bW9yZSB3aWRlbHkgdGVzdGVkLg0KPiANCj4gRG9uZ3dvbiwgd2R5dD8NCltLaW0sIERvbmd3b25d
IE9rLCB0aGF0IHNvdW5kcyBnb29kIHRvIG1lLg0KDQo+IA0KPiA+ICAgIHVpL2d0azogQ2hlY2sg
aWYgZmVuY2VfZmQgaXMgZXF1YWwgdG8gb3IgZ3JlYXRlciB0aGFuIDANCj4gPiAocXVlc3Rpb25h
YmxlLCBtaW5vciBpc3N1ZSkNCj4gDQo+IG1pbm9yLCBidXQgZmluZSBpbiBzdGFibGUgdG9vLg0K
PiANCj4gPiAgICB1aS9ndGs6IEZpeCBtb3VzZS9tb3Rpb24gZXZlbnQgc2NhbGluZyBpc3N1ZSB3
aXRoIEdUSyBkaXNwbGF5DQo+ID4gYmFja2VuZA0KPiANCj4gb2sgZm9yIHN0YWJsZSBpbWhvIChl
dmVuIHRob3VnaCBJIGRvbid0IGxpa2UgdGhhdCB3ZSBkb24ndCBzdXBwb3J0IGhpZHBpDQo+IGNv
cnJlY3RseSwgYXMgSSBkZXNjcmliZWQgaW4gdGhlIHBhdGNoIHJldmlldykNCg==

