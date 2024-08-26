Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D95C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 05:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siS5Q-0004r5-1L; Mon, 26 Aug 2024 01:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siS5N-0004qR-GJ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:16:13 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siS5J-0008J2-Kl
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 01:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724649369; x=1756185369;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yKm0qMDwX8bGY6XY7PaWL3RQiCnKFmZz1P+YdvU9k2s=;
 b=UaNGG3VABvkMyPZzerBTAIMAlAS+Ew53n681YpIFJPuQ5T82u4Y1BDhF
 nVbBs7y4ahUG8HyPSTtdj3f9VmY31U1cBieS3G3nHyIMKU9Du0J5mzvId
 4If9cInUZiVBudMh2fNHXZpGS0ePr0d5TPhbSV2KDe/xinGKlPK1s5et7
 wFfiioQ16BpYApHFRmoOkEZr+/8FK15ENI2hsMgInuaOeiuv42E2dLLZb
 TGxySlw2AN7SkkMM+rnAJrK5U62kit6rcq8SJdAG2Y2DY/9wGD4JfWlNi
 /n6cRwA2FUn1XsfJWC2KihOroKu22OcG1Wt/BUsgM6QBK0VQUp6vq6vXP g==;
X-CSE-ConnectionGUID: JuHYXUpYSP6IEzCPWSa/qg==
X-CSE-MsgGUID: 4kCbdhODTYGcizQdm2EkUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26817304"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="26817304"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2024 22:16:05 -0700
X-CSE-ConnectionGUID: s6FrRTLNQteJFDT/SJ5eiQ==
X-CSE-MsgGUID: 1iu1sTMeSxSAeD7xcGrACA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="63115826"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Aug 2024 22:16:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 22:16:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 22:16:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 22:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw3xDISdDazxh5S1O4fMxh68DFlCBve6k5sEt1Cb+xzIjt92sUpe/U5fuJj9/YZ34Vt8+Gp86wkiWaqOVqiuIW+hStvgmjFx/eGAIg4BHOUjjRMeJw6fXvnQo246pWXv1J8PRc7TbRwHgszZNEBrwrdnH93WAP9wMKrUZHufoKtu6yx9o82kP22U0A2VY/YVRlAZdyGl/Pdo4my5j2xjZfJRs83BkJuEuHzPs6WMylpmMCmz2W7misWyuW5c1qSufopbuKWnt4DBpMLJKxg7dkkxma8yQHgBH5E7YHe+jICqxq+LizbzuTV8WXJdDMS5Yr4vJWXoP3T+tb9oq19mXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG0rQlaoCWEB1mhrxEPFWrKv4XqJhHHJ5/QptFMrFt4=;
 b=jUljBo/Hu5HVIh99ERm50A6IAmbaQbJvS9nJyoAZIkLv81gqLLMlOKv11yAR1uh1wYF81VkKpXetRh3WBYhRpuprVan6Hq9/kQqWa81EI3zFeV84bcq7i/Ub7hUDNawyzwvEeT3mgc5bhx7XhF3JRIRNU3MbhRAuec6pz9tV+F63fxbFOq75yu8P032HHzam8YawvsfRwbOFgkUMNgcGlfsyzGfXTR/BCmhb+KZpMmV9pIMcTETSWKN7Xu//N277xGRCoL+9ldYgOp75QUo/XxINDT3Rg+9tYWJB0G98Devr2Wfj7ES8iGHh/bYHfNI7V2pf1JGvxFah64x5qYoPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:16:02 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:16:02 +0000
Message-ID: <b715130d-2673-4f3d-8189-4f2bda528fbf@intel.com>
Date: Mon, 26 Aug 2024 13:15:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] rust: add utility procedural macro crate
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-7-b9f5746bdaf3@linaro.org>
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <20240823-rust-pl011-v8-7-b9f5746bdaf3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 538a640f-585a-43f0-ccb2-08dcc58e2dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXIrYlJ5MU5CaXJxejFPcWxoSWFQVTIveEE3SmlqUzVLanc2ekltZTlCVlFr?=
 =?utf-8?B?Nnp2dE1MTW16QjFtNVQ4dkd1VUdtaHpuZzBsNVZNZnQrNFg0TEk2WTBrWVVn?=
 =?utf-8?B?SWNMeSt2RTcveHRCb0xCSHFjUW5TZDMzYzAwcHl4LzVvT29wWGd0aXIzd3d2?=
 =?utf-8?B?TXFjUnVUNTNhNmtyUldwYm52NjV0TjIxUURqcStZQlpiVjI0ejdvVzIyWm9k?=
 =?utf-8?B?cW1lZTJqZE1hYjQ0RWVRUG5QQU5Sa0lRa1ZxWTU2ZWlTMDFLbHpCZFJ2SkRZ?=
 =?utf-8?B?Mjk3MFNlVVlMOE9hY2lKeGh2eHI4T2NRdE9qTmVEQ0poL3EzYnVFVlBIUk04?=
 =?utf-8?B?Sno5bkVXSjVUeEUza0NqYkRqd1JNOFRaeUJzT2Y5L29rS3pTclVhRzlLNHZp?=
 =?utf-8?B?OUs4NThxUERuK3lmckJPKzlMdG5YU0w5ODRLM0VOMGhza2ZLelNCQ1Y2bEVI?=
 =?utf-8?B?eXVHbnBybXB6M0VPWDljMGRGSHBnUmQvVFVDc2pTaitMd3h3L3lJMFVLQ3NX?=
 =?utf-8?B?U0RSRklSY2cwRElDTkVBUXBhVmNKRS9yM0wxR3B5TjNOMjdjRVB4alE3SGJt?=
 =?utf-8?B?bmYxUVBTM3RCU24yQ0VGTXFka21DQzV3YTVDYUV0QmNTMC9Lc3FXclloLzhW?=
 =?utf-8?B?Tk1XbXdOYnVwcFUzalhHem10ZGhxSDBWUGZjcCtxMExuZWlUYTlERGtjemtU?=
 =?utf-8?B?V2tHQUdhQTN1VEhiNytGZDFpb2lEZkt4U0pzZWVrclZ5bGlIdlZRdnVybCtB?=
 =?utf-8?B?YlU0L05KeFI2NWdqY05VcFowSnEwQkM3clRJYlE0a0I1QWNtNVprSDdXOEVK?=
 =?utf-8?B?UDNJcjdtZDJLNTh6OUhzOUJtd0p2MVlEaDVtam1LZGphbFgxcU1TSUJoZWdW?=
 =?utf-8?B?MlRkekI2Z3grTmRwTlRoVzJNTnBmQ2VvdW1oV2FzRFdYQ2k0aHp2bU51MGRT?=
 =?utf-8?B?cnBQRmtRelZQU1Z2a3ZYdVpaRVZEZFdSMHdCbFNXQ1BYa0JxWTV5OEV4d2pw?=
 =?utf-8?B?TGU2RUw4alRKQXkyMVpaa25tN0toeFlCellVZ1FQU21yWlduTFN3TG8vODZo?=
 =?utf-8?B?U01TdHM0REF5V0R6aWZPYnV3aU9lSzZBVU82UTF6bHI1eGFHWmttWFJYRVpI?=
 =?utf-8?B?YVdSU1B2ZE1ER0lPSEE1R1p5NTRoOUN1WmZxTnBaMmh1a2J4VW5hMlU2VG9j?=
 =?utf-8?B?WEsrb1ZXY2RTaTA4aDVxeVdhN2ovcER5ZTgzVUptckwydDRZZXBTcnJVLzZW?=
 =?utf-8?B?ZjRzMnI5QjFTZnNiUldRYXVLbldoWWRPR3NnV3dSWkVxb3VCcWU1Z1NKTmVy?=
 =?utf-8?B?aTdIT1pIWFFZNG1RWmJPNFVROWI5VlQyN0hIdGtmRmNVRXhRbGxJckEyU0FL?=
 =?utf-8?B?em4rdWVvaDl4M0w2QWF4OXBkQ0UzQlJuTGtKTUYybUdqUSt0QmVOVlVKZUJh?=
 =?utf-8?B?dkpHTndWcFBZbzVabTEvSGtmOVdlekZ6cHViV2M0OEVoNW1lYXNObjZWSFhC?=
 =?utf-8?B?djB5L1ErZUpaREdUM0Nja0FuRVM0L2JUQ1VoQjdZZHZRNlNVN04wMC9vSWlr?=
 =?utf-8?B?OURSRDlZdDR1VnRVSGtYZFpwTHQ3UVpGUjNlNThDN0dxWTBJeWRKVGxmQzRy?=
 =?utf-8?B?UERmU2dqYktGNG5FWkxOUms3OEVrdEF0cTQrbHdoNmFMVXhHalk2TnF1bGJS?=
 =?utf-8?B?dXNmdTlSMFV3N2N6b3lhdW9HMnBaUE42LzJoc0FDclhNeGQ2bEptU0ZmQmpq?=
 =?utf-8?Q?MvN08ZNhua4MDih434=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlSUzFua0ZOWXBaZXJGV050MFRSZ1ZUZ3JyTnJSa29zTmlCZG10SEN3c2dB?=
 =?utf-8?B?aWJ1ZStaTzcyQnl4RitqMk93TEdnQWpsdFMvZlVqdTZ2RDI3L015ZzhYcGVB?=
 =?utf-8?B?T2hyVFJaNWhGcXMrU2xHN3VmN3JIZ29zd1BYVkw2Q1FNNmplOWVRa08xYnd4?=
 =?utf-8?B?RVZCbmlqUlR6cHRWWXgxQnRJMytzcEdyWWVYeW5wZmQyR3NzMW5jak9jZkVR?=
 =?utf-8?B?czE2eW5BT2JERGQrNkhlVFQ4TUhkUmZuRmxqK2RjbUV2S2FSQlhXUVBtMTFz?=
 =?utf-8?B?QXlIU0ZqK3NYYi9zR3pTeTZXQ0FGNFRaQmdqbHFadXplRWRWTDJoYnRpc0Jp?=
 =?utf-8?B?UkVsNkpzcnUwczJnc1MyQ3ZyVWpSUUxUbzVVN0oyaEJlZU9vL0tvOGk1STcw?=
 =?utf-8?B?SjlxT0plV3Q1UDlBU0lxdDlob0N6c2FiNGpaM21WN0NGTklQYndHNnFHSENx?=
 =?utf-8?B?SEljZGhvTmNrcHRxZmxiQm00UGZZRGpJMmJaNHljeDJFMWlKM2MzK1FHS2tJ?=
 =?utf-8?B?ZnRFT0JOei8yYitNWEFsc05NUWdLR3hrdzdsdENxZW1HTnpxZmdMdzVqREww?=
 =?utf-8?B?cE0veG9TVkFRVmMwMUN3K0Z3Y3Z4TDZFQWlhVWx5M25qKytBREg2aTVqQWEz?=
 =?utf-8?B?UG45RmFQNHdtcE5XbzN3ckplVG5nSkNhSXRVZFVnR0NaazB1OUIrL0NKb01O?=
 =?utf-8?B?Qm16S2xvUXhWS3FLUGE5MTczaEVSc0tNTU9BRloyc2xtUkZKRlRXWEZNSllR?=
 =?utf-8?B?M3RqL3ZCM1htNG9KWFhOT1FrTXdMZ3E2eW9PVktPYXFPa3ZyQ0RZVmxxeEJF?=
 =?utf-8?B?Y3MwTUt6WjdDQS96TkdPSnRBNnJvQmtqMVlDWlFWSTVFSEdGbEVYSXBDeG5a?=
 =?utf-8?B?Q2lYN3hQRmhiTHllZ2tKYzZkTFdXN1B1MERQUGhkTTZqckZvcWFQU0l6RXJL?=
 =?utf-8?B?VlhIUkpmQW5lK3V6UlRoY1VPVmZLM0MzdmdXQkk4LzZQRTZlWGFsZThYVHd3?=
 =?utf-8?B?TVJnYXhTWnBsakFCQUVLZTJEelVwSHovMTJsZTlTL29RQWFvM1FXMkhWN1do?=
 =?utf-8?B?NkxUNTV0ajQwVTgyZDV5d01QeFJ0K25iWWxiSlhpUTlGa0FkVjQ2dXdpdzZl?=
 =?utf-8?B?d09GaHhqVTBCblFKUHNsYW9vWHFFZWw4N1NlcWJRMyt5NWxyV2hBbk5ST1R2?=
 =?utf-8?B?MTFzemROeWJNbVRmUUVuSGZQVFdleFV2cGVnOTVpZ29pTC9iL29qZllRSUls?=
 =?utf-8?B?VUJoNFdlMjB1WUl6SzlXYXZDaEZmd2N4bDhNWW82RjNBOGpSNjVnbkd5NXZ4?=
 =?utf-8?B?M3NTelRiOVUwY3BJQ3lXRm1VS2NUNWlNd1pROFVMWVJQbzJIQ25ua1NjNmk3?=
 =?utf-8?B?dnJ3TlNjUGoxYWZMZVZuWGZkMkZjT3JXWmptV0JZRmZzb2haMlFVVDB4M21w?=
 =?utf-8?B?TWd2RWlaRjRwZ3pZWms5RUVGZEhiZXJDY1ZhUlgrLzh0QnlNdWR5VUR1Z3FC?=
 =?utf-8?B?TW4xQ0lnZjRCSFJPTXdOUUtQQ29SUHpCMWVrMEp3aTQ0UW1kTTk0RTZjd3dF?=
 =?utf-8?B?cFlGOHZOTGEzNThuYjdOa2V2U3N0Vm5SNVpDRWtHaGxEci81RzB3ZTdKNGEx?=
 =?utf-8?B?RVFJRzFIUThuLzJDZ1lYMlRZWlJEY0RYb3FVMHNsVnBCVGk0MFRQVWR4SEd3?=
 =?utf-8?B?RU5VKzdyaktObDFpZ0M3QTIzSE9FRW93RUFiQWFXWkJJWnZQSEx3QkI3N1J4?=
 =?utf-8?B?eVMrU2toQ011SjFvWExpbk5rR3c5MFNsZXFudXhWWTlmdUlPeGJGVDlScHlC?=
 =?utf-8?B?aHFrOGV4T0I4TGdrUi9BNXQrM2dZK2psUTJnVGJxNjFIbjFCeEg1eCtLZkZy?=
 =?utf-8?B?R1JaVVpkZVpVVXovMWRBY3dPamJJTllvS3RZNWRLQitzd0YvZDhnUThBK1V6?=
 =?utf-8?B?NllSNEFmR2V0U2p2SnAxeVRrS2pzazVZUjduRnplTUJZb0pSb2o2NGk1MFZx?=
 =?utf-8?B?dTl4SVFVb2JDQ3dwTDhvM3lYQkJqa1N1RkNtdGFrcnh6cTNxRThxRHkzSjBx?=
 =?utf-8?B?Tk55SEtMeGtNQktVdVZteHJYVDhzRWF6aXJFZ1NDaEdmRWU4WldPdG1GRjgy?=
 =?utf-8?Q?iXivWiwP7k54OV0iTjyKqzCTM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 538a640f-585a-43f0-ccb2-08dcc58e2dd3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:16:02.5801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQkrCNt2BXCzyRz08uPrkmlOCVied+YfpVTxyccfVYTduwySHKA4sywtk882ED3RZYN1gnEI1GxiJRf3aIwBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS_A=0.1 autolearn=ham autolearn_force=no
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

On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
> This commit adds a helper crate library, qemu-api-macros for derive (and
> other procedural) macros to be used along qemu-api.
> 
> It needs to be a separate library because in Rust, procedural macros, or
> macros that can generate arbitrary code, need to be special separate
> compilation units.
> 
> Only one macro is introduced in this patch, #[derive(Object)]. It
> generates a constructor to register a QOM TypeInfo on init and it must
> be used on types that implement qemu_api::definitions::ObjectImpl trait.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                            |   1 +
>   rust/meson.build                       |   1 +
>   rust/qemu-api-macros/Cargo.lock        |  47 +++++++
>   rust/qemu-api-macros/Cargo.toml        |  25 ++++
>   rust/qemu-api-macros/README.md         |   1 +
>   rust/qemu-api-macros/meson.build       |  25 ++++
>   rust/qemu-api-macros/src/cstr/mod.rs   |  55 ++++++++
>   rust/qemu-api-macros/src/cstr/parse.rs | 225 +++++++++++++++++++++++++++++++++

Since Rust 1.77.0 C-string literals are stabilized [1]. I don't think we need to 
include this cstr crate as we require Rust >= 1.80.0.

[1] https://crates.io/crates/cstr

>   rust/qemu-api-macros/src/lib.rs        |  43 +++++++
>   rust/qemu-api/meson.build              |   3 +
>   10 files changed, 426 insertions(+)
> 
[snip]
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 85838d31b4..a0802ad858 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -13,6 +13,9 @@ _qemu_api_rs = static_library(
>     rust_args: [
>       '--cfg', 'MESON',
>     ],
> +  dependencies: [
> +    qemu_api_macros,
> +  ],
>   )
>   
>   qemu_api = declare_dependency(
> 

qemu-api does not use macros provided by qemu-api-macros, but the later 
generates code that uses types defined by the former. So to me qemu-api-macros 
should depend on qemu-api, not vice versa.

---
Best Regards
Junjie Mao

