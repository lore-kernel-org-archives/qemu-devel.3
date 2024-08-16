Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425C2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesIi-0002dm-Dy; Fri, 16 Aug 2024 04:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sesIf-0002Tf-Ay; Fri, 16 Aug 2024 04:27:09 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sesId-0004o2-8j; Fri, 16 Aug 2024 04:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723796828; x=1755332828;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yBZ9cIGKvBJMFli2QQ/S5h9pyKYTs+9fnh4Yc4L4rPI=;
 b=b04NtnztNARMs/FG/afK6W4uhjuLKsyooIW5sgLYTPioQDL8NwlcTSRb
 j79EWoWIMBdCXo77bgIpqpwDmEU3+nAsN1PHIqKzeCQEGoeWN9g/uBpso
 2E5KOiavMLe7tr0NYWLbubj6+QJfW110+mLUZ+HvzJdW8avV6LgorwcYT
 FhNSkEEtuSyBmITNpxNtEMhzCL+VvK5jbyPelOac2O+nGYJ+ffLH4VDNK
 iJoBJW2Ogb+qFNCauSwXT1YjHDbuPVq0XrBXWcoZbh8U3SM3x+J6yCaf3
 y+yuQ5yrpAQC7gCRLumIKAvW+S6C997qZzZMHShK95WF58Pnljv/lacN6 A==;
X-CSE-ConnectionGUID: 3x5LYBqWQiSZDDl/xBXDiQ==
X-CSE-MsgGUID: yoCRKxCdQ4yPQ9R+08ysiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="44605398"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; d="scan'208";a="44605398"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2024 01:27:02 -0700
X-CSE-ConnectionGUID: WSGBkXR9TSqDv6rJpKHnLw==
X-CSE-MsgGUID: Bu1bdPIIR5+L2eg2Dw0xvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; d="scan'208";a="90329384"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Aug 2024 01:27:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:27:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:27:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 01:27:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 01:27:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJy4mhDxlI+PWtjJ6+abk+/QfkPXuGunj/geKvprt2YcXTGOxaBoUryFOkHC7hlh5P3OKkMueqEmVanVUelLJqK6R388k2+bHiiHOBLTS8bvQnz2O4/9D72P9z2Y2tl4HtIX1zFrV0FnZfaMYwaK/X7aCpj7V+zI02zLGqL5eH1L9kd19ssSVsOpq7wHMq23r96CyDNV0Gutv2l1HrqODv1DVTOffYf0cSLRu1ZuKDTHY9B5Z5H77rPIOH1byxFjd8yjy9tPlPa2f/Hy8bsJIAPQYJs7fz/k0BWVkqOfM48CrQImq15lki/oK9yI4cuh14LTnzeYhYX4OG+kZbIfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9H2CpHVbcGFyKIr6hF1wncBJbWFB1xO1MD9dr87PZc=;
 b=vu63IgznJqAUTpNWgKYZU/C/hP9SCFIgve3sJJooNb90AuYfXIo3kyzMIb7F09jbzmdYOfHi+ZAXAXSXcHHMewm9RKlXB8qm0eZOQn9bBd5Ad72EFytZ/PICx9aiFEG/J7E0MWde+eClZFT7By0rrmWFqRi7b9Cc17ErRTy4VsWi35D244Y63KfBTsueMqiOU17RDIMu7IiTP6LSUQfnOvRanB2ULpPwXmwvEdOOm/xhTpvrx6Fm5ByLnGFfzXtq1zrmhKgXxpCcwumjs0w1zYxFLXIZ2780XOjlPX36D8TLX6m8GqCrb0nURFHub6KzgMpTlUfLsz7oc28n1lWEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 08:26:58 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 08:26:57 +0000
Message-ID: <22016995-d94a-4767-9357-feb150e67620@intel.com>
Date: Fri, 16 Aug 2024 16:26:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, ARM TCG CPUs
 <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 "Hart, Rowan" <rowan.hart@intel.com>, Mads Ynddal <mads@ynddal.dk>, "Markus
 Armbruster" <armbru@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba166a9-f7cf-44b1-9ad8-08dcbdcd3192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXJQanN1aWFJZUhUNGtLV1lpU2QyZkFjWWw3QTRZYU9INFEzRjNRYWIyQXJz?=
 =?utf-8?B?b3VlY09DWXpvbGN6OWJLWlhYbWlOWElvQldocVhFUUZOcUpPM2J5ZjlmS1hZ?=
 =?utf-8?B?ODhvcDFkank1V2tobWoxNVhpbmdWdytSaW8ydER0WjlPT3Q1V0w4WkFFcC9y?=
 =?utf-8?B?OWdzRXc1amtKVGdYcms4NWtWUXlGM1VxRkRTdHRZQnVZY2xYYlUyeERhb1B2?=
 =?utf-8?B?b1VKdnNkK01pK0MwaVBEZmdUZDdVVUlKNWNWYTlQRGtoWkFoQkVSM1RvNnlx?=
 =?utf-8?B?MXl3N0NkQWxSNzhvNkpBaGRFUzA1bzFEaHZoUlp0d092dVV6V2didlpqRkdV?=
 =?utf-8?B?RHpxU2VXSGU0KzVNdzdPc1Voa3dQbzFTdGJvN3ZwcExsTTdZRTdrRmIydUFF?=
 =?utf-8?B?VkhLZ1VaNDdnSUFGVmUzYkt4Uk96LzVzcGJFaE1sQVlMWkliUytIQlN2eGtu?=
 =?utf-8?B?eTJGZ2ViR0VpenFVdTFhUTdxanhwTVIxNHJnTTl6WXZhblBWNzc5R3lmTFo0?=
 =?utf-8?B?NGNqazVQVEZEZ1MyMG1zNm1ucTl6S2RCUEpJeCszY2V3NkpJSFkyNFMxQnlp?=
 =?utf-8?B?Rkx4RFFVVFJqZnlDdUQraHZqbkF3ZTI2VmJGSWJnb2w1NGo2YThjRy9TZnRJ?=
 =?utf-8?B?ZmxUKzFIdmNIZ2xOd2tjT0pkS2lENGVWTEtQdzMxNkVaQjIzOWtGdG5kM0tV?=
 =?utf-8?B?Y2haZjdiZ0hwNWRodVNGZWovczJXaUxQUDhYKzhPMXBoQlBBOS9xOE42NENp?=
 =?utf-8?B?MSt0QXlFTHRobEhONmNBTjh1cTk3cHMzVCtKN0xxNFpjSkVHME01SkZvSjRZ?=
 =?utf-8?B?ZWdTTjNmZDl1TStpK3VNSVlvNGdlcHAvTUtFcjN4aS9lYmlYSTVLczRGN0wy?=
 =?utf-8?B?TURCYkU3NEdwVTUwekdjYkhYeElVUXFrZDNLTStYMlVEeHFOOUw4ZEhZSEls?=
 =?utf-8?B?c3plZjZ4MC9KMGhDNnN2aENyOTJJa0FnZTFEbkMvTzVhSGt3MFgvSXBEOVBr?=
 =?utf-8?B?amxTd0l2WnozL3dWY205cmpyZEJYNEVaMUoyM2xBbnkvQUpLRDJUYjRyWGxC?=
 =?utf-8?B?YzlZeC8yVm81MDBnY3dmT1hZb29RVkdrc2orVWNsUTB6cUhtdVoySk9wcHdu?=
 =?utf-8?B?R3VvTHFMcU5oVUFwKy9weGZ5a1VLRTdaWTVPRVlMRGVYMFZETTdoSjJKaXhU?=
 =?utf-8?B?Zm5zWS9GWTN4dDdETW9rc3pUdXNucHo1NXFaUjRXZ3JQYnczR2xOUVdKSmQx?=
 =?utf-8?B?MCtoOUYyell6WURudTFvSnJtV0ViRmRKRDlMS2N4dHhtOVhVc3lKTEIwa2w0?=
 =?utf-8?B?SGhTV2tjYUljZE55WUwrc2x1d08rZHpTWEZJRExtTlZGWEFDK2p5amNYcmY2?=
 =?utf-8?B?NVNWUkZPdGNySmd0Sko0Qm8xQWpreVN2ZFUvdFFyb1VSenhxOFZpbDJQTC9w?=
 =?utf-8?B?ZFNxaUlCRWcrcnp6RTY1djBoY01HUjcrY0tDbk9SUjVzdE1rMkxWQmxuQU9S?=
 =?utf-8?B?a09uTndQdTdNK3oxOGxQRmx4b29WMVFsMEltb1VjcWFOam16TlZSbGpGdWkr?=
 =?utf-8?B?NEtGZ0RaSVdpSmo2N0V6K3BNUlYwWS93T2V3dy92TUNTTS84Zys0bnQyekZu?=
 =?utf-8?B?dUt4d3g2cml4VmN3KzdFZ1U0MW04cWtuaW9ZOUZqaDhHM2dDalgvQnUzcm5j?=
 =?utf-8?B?SHgrMlR0MkNwTjRmRVNpeGlmWnp4QTFySCt6QlJiNGlDREs0cjRQREluaytZ?=
 =?utf-8?B?Q2Evd1YycERLZ1hkb2t5NDJ6V2Y3Q3RXdnRCRDVLRnR2SkxJMjVJWkd0Smxr?=
 =?utf-8?B?U0VZazg1YkNGQXBrU2M3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZrZ3g0K3ZmcGxLL3R1UUJBb1V6NXJUanZjbDdGS0U1OTkvM2xjd0UrMXNC?=
 =?utf-8?B?QWhQWEZ5c2dPMmE5N05HTjdobHg3LytRZEhiY3RKUzhWQlZmeVlNeldEQjQw?=
 =?utf-8?B?Ui9PL2xjYWZuYnFzcnYvVitSTFNyNDdwV25HSzVHWUQxZFNEeGprTGVqd1BF?=
 =?utf-8?B?cXYxa3FMUEhxaW9ycDBZbVBSWkFSOXlUb1FlSHVaVTNRU1VIM3NGcHEySStq?=
 =?utf-8?B?N3l5b1E4YlVyT2I4eDViL0FDSGg3dHJDYmIzTDU3VS8rbFFhSW9XekYzRENq?=
 =?utf-8?B?VWxsTi9GZ2k0UVVkSm4rQ2NIZGN5L21nUEhPY0plZTV4bmJJMWhiSHZMTS9h?=
 =?utf-8?B?Z0ZSUnFEM1lXcDcwZGpCNzNnOXpoK1c2ajk0aFgrNGJtcDkzMVNMQXhqNUcv?=
 =?utf-8?B?WnBkaHU2RGhoNXNpMEd5UVRRYllKdWpYdHVNcS85UTlhMXQ5YzRWN2hsNldk?=
 =?utf-8?B?NnZzeXUrenFSZmRhMEl6QVlGK2t0YUNzL2l6Qmt4SHMwVWs2MHRKSXFKUHpZ?=
 =?utf-8?B?cnBsSWFGN2RveVRabVMxbmlQL09NeVhEdkh5ZCt4L2ZIUzdHazVXU0JudVFQ?=
 =?utf-8?B?cUN2bkpNa1ZNbFk1cGJFbmF0bExCMlRNU3kxQXVCMXJYYzhwUTF3RmhVV2la?=
 =?utf-8?B?aG9uTytWdWRtY29xcUVUNnUyMjRuakl3YjJoU3A1bk9Qbk1zSmZXUFlUYjdU?=
 =?utf-8?B?aDRFUHJ2YzY5MUIxdHdVYnJDdmR5UCtEVHdPWUFYTFJyYlRHTEJ5Z2UxUHpa?=
 =?utf-8?B?dE9UUFlSNEJrRTJaelRxcEhOTzdtTXd2MlIyeFZ3azI2bEN4SVphQ2x0NHM0?=
 =?utf-8?B?YWFxZDRSeGRUVWw2ZFZKNTlEbnd0eTFnUXE4dEdBNlMzOUdFQ2tXVnFQUm0x?=
 =?utf-8?B?Yk9NZ1hVdnZoWk1CaGdCUVdZbk9qVkhlNG4zM0t1ZXRtTThoQ1ZPQVZyY2lk?=
 =?utf-8?B?TzFnUkE1WjBHSFZDeDVldDZtUHNNUlRVQzgxVlJlSERlaStDOVZ0OGEzd29u?=
 =?utf-8?B?UzRRYjJCVFpBa0ZZZ0F1TFdRN2c1bUxPVjZDR2duTWVWcTNTTmk5dDNqQ1Vm?=
 =?utf-8?B?Mm9JRjRxdGxqMUJ6dzBiZjR4dk9xdkdZQzVhZmE3a2VwR2Z3Y1JPTUVlbnpo?=
 =?utf-8?B?WmRab2N3MDdCZHRNdmhjMkpRbmlGL2MyaCt0a09zUkNaVEI4YXhDdUFJb292?=
 =?utf-8?B?cHY5bkVRdWNaNUc5akpWY3p4eCtlQ1dpQnJPNnVKNGh6L3ZLSTRCUUtFdnFI?=
 =?utf-8?B?K2I0V2IzemJPOS83aGR5MUNkMFpBbnFHQWsybzVFOXlqY0dkYzRyWjk2Y3hO?=
 =?utf-8?B?TXpuSWtxNTcxSVFUVWtLSTBnSVpCdXNucHpzRUtCOCt2cXQ1L1piU0lOTmgx?=
 =?utf-8?B?WTlVb2orV1pYOTUyV3d6eTRDdXMySW5Ya2hwaExhQkdLa3ZvMEFCUDI4S0ZD?=
 =?utf-8?B?UHdjZFowbGhhV284b0xTSGZpcWZVQTFvdW1wQVJJZlp0U3dtMDY0RTlYQ2Jx?=
 =?utf-8?B?SVN2b0QyZUlOekhheXFMSFBkMW5uT0JHNS9YbysyL1A0b2g3M2ZpS05Remxs?=
 =?utf-8?B?VU1UWTk3QklYa2R0K1J3bkxqZXVqdTM2a0NaU2NhU1lkTFo3a0E0NVN5REtC?=
 =?utf-8?B?NVRFdDlia01vT3Rmc2YwTjQwRnlLZXpoSkRnSmg0RE00d1ArUDFDYmRRaEl6?=
 =?utf-8?B?UkFLM0dIRS9Ua3pLbUNOK3lJT3VJTlBnbTg4WHI1cVJKNkVMckVPVy9IRk9H?=
 =?utf-8?B?VmdRS3VHNlE0dVpCajRMMFJBdnlRbkZrZ01JdXR1Q3h0aEUzUmo2OVUrUTlu?=
 =?utf-8?B?Z2dnbWlpaFI3TnB3ZHN5TEtnYWZycll2ZzY2TEFuV2FTUjRNTUZBN2EvZlda?=
 =?utf-8?B?ZXJybkREMlIvRFVBa0c0Yi8yNnRLaFFIb3p4T05PRitSU0c5a1R1enA1d3Mx?=
 =?utf-8?B?YVFlTFd3bmtTTUkyWFpiZFpMcTQ2MTdLdm1iUWlpVWx0SmJPOEN4aG5hYjE4?=
 =?utf-8?B?LzJlSFlVT0xxUUZKM0cwSXNSYzd5NlU2TVBxNjFMdGVrVmd4MU03TTg1eGpF?=
 =?utf-8?B?VEpCYXdlaFRxN01yekZiVFNPNnRmdHdoRG50QmRIejcxUU5ad3JlZTRFWm9P?=
 =?utf-8?Q?qI/X1T0rNEaHkJ2HLFCAaol5z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba166a9-f7cf-44b1-9ad8-08dcbdcd3192
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 08:26:57.8277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSqEi5V01ZM6fN4epeDr3XhN+OYr8KUAI/fS1P1jKHOqGa5Z4BkW2T2ojto7DcCK+igNsPy6gwlKdo+ACGSYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/2024 7:42 PM, Manos Pitsidianakis wrote:
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
> 
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
[snip]
> +
> +#[macro_export]
> +macro_rules! declare_properties {
> +    ($ident:ident, $($prop:expr),*$(,)*) => {
> +
> +        const fn _calc_prop_len() -> usize {
> +            let mut len = 1;
> +            $({
> +                _ = stringify!($prop);
> +                len += 1;
> +            })*
> +            len
> +        }
> +        const PROP_LEN: usize = _calc_prop_len();
> +
> +        #[no_mangle]
> +        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {

#[no_mangle] also makes _make_properties externally visible and thus will cause 
duplicate-symbol-definition errors at link time when multiple devices are enabled.

Since it is only used in the definition of $ident below, shall we just remove 
#[no_mangle] for _make_properties?

---
Best Regards
Junjie Mao

> +            [
> +                $($prop),*,
> +                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
> +            ]
> +        }
> +
> +        #[no_mangle]
> +        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
> +    };
> +}
> +
> +#[macro_export]
> +macro_rules! vm_state_description {
> +    ($(#[$outer:meta])*
> +     $name:ident,
> +     $(name: $vname:expr,)*
> +     $(unmigratable: $um_val:expr,)*
> +    ) => {
> +        #[used]
> +        $(#[$outer])*
> +        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
> +            $(name: {
> +                #[used]
> +                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
> +                $vname.as_ptr()
> +            },)*
> +            unmigratable: true,
> +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
> +        };
> +    }
> +}

