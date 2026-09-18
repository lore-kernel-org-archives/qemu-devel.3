Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F2BC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7TWv-0003NM-Hz; Fri, 18 Sep 2026 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x7TWs-0003N4-H6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:01:06 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x7TWq-0001GQ-HA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789718464; x=1821254464;
 h=message-id:date:subject:references:from:to:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AQIC4AqB9aRDGPR9qtv6sFq19v4JNi4srfCp3fVQ64g=;
 b=QswRsIEA0tDG+XF0Af8eD83zdO4wT+/z+tEbG1LPlGNxabA0s6Nkyr3l
 yM71h7hyFhrrak9c7+Fa4KclvbTIVnBayIBRzViKNprbEz3eaVe+/TxmL
 radfzBALjUIEqloA7ypiDLLVKRf3p/MelkkEbCgi7moqRoFMIHlz4Ey3R
 I5MEONdzRmuVppUJHYXwhH17mGvnviZLQPQN9NM42gheof8iCGdwrgFV8
 Qv3VMxR43gbizkvZ7Hmb8sLjcpsa4CyukCcFmWod9167QodOWcDszaPuX
 bN4q8FHUW8ER5FgM5wqEMSAJx3v6s8+PZLe5vqQO8sakHY/tZaEJN9pR4 w==;
X-CSE-ConnectionGUID: IRlFu2rVR2eZjD33trJROg==
X-CSE-MsgGUID: ZCvRl4LxTPSFXl4oFg5d4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89342760"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89342760"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:00:58 -0700
X-CSE-ConnectionGUID: 2GQLb9aYS+2LU8Vy3QzXQw==
X-CSE-MsgGUID: OxNU2zsySe+xeCSrEUWmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297741729"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 01:00:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:00:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 01:00:58 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 01:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM20kCS7HzyhKlI6bhpDSXQDyZe/kPPqiC+srj5E60PhHhZvvDkuXG7WXA508DNtzDodDD0y0INA7FRiZ/ePr0PPPPuH2bi8xmoknA1CGGORf//bBRlEL7rVzR0ZocDFUvRTEnsJ/UlTQ6QmsWHX0o5tzaIZ8YlkvnsAvAgCnZdRz+xCRHmpxPNJFBGKpyZy+QjvJ6zmPxx29c/RdZl236Kx8RRMUhfyBD3b/MEIgQcjI2VyWWINzM5iCkb+xHStwF2ZhrtV51eaT4oySAJRIsNNOZPRabaIskXUIpqXb3RrPd6pu10sByTwd6l6QPGgWUVXfvQqV+7hyp0TendHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CPPVZj62YBh/vBKd1I0CF6r52fZlD5X0Oun77javMo=;
 b=QHjRWe+0zi/Y5t4VoOe+I/U72yWCs9hK1ZXF2qgBC7u94ltb/OdqnSV1Z1rvr75xs3jx78Y3Q5wQcRq/JiWXedKL/OHsOJziwhEQCMVodX+r+Phq0gLWn9NtZdPo3qDS9nAWpDROVA52wk04YtaTsXAGgyR2Q4zuCLMjfVrRMl0hCpCtVqsgWqFObAWfJxRr7xzRf1w4NSPgB4V6U9KzJC/K6pqjl+8Qo66jy9QUP712s59PFx3b1JFZhKoau7sArljT5SDp9CC8w3rnF/70QaTNau4/9I5pmhkioLgxTqDKUh+hz1x20FkeBT1pGQrarB/xSLNyrF3K1KnSZa70Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852) by BY1PR11MB8029.namprd11.prod.outlook.com
 (2603:10b6:a03:526::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:00:47 +0000
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d]) by SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:00:47 +0000
Message-ID: <57ff9cf6-412b-4cbb-844e-d9d1b0efbe95@intel.com>
Date: Fri, 18 Sep 2026 16:00:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
References: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
 <20260915013037.648161-1-junjie.cao@intel.com>
 <948e2399-1c85-4b51-9964-892750f7ce68@gmail.com>
Content-Language: en-US
From: "Wang, Yuan1" <yuan1.wang@intel.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <bosheng.xue@intel.com>, <junjie.cao@intel.com>
In-Reply-To: <948e2399-1c85-4b51-9964-892750f7ce68@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFC295640A5:EE_|BY1PR11MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c6799c-2c3c-4748-c65f-08df155af25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: gVQd7mlf8eCdnHs69JES3dcx5JUC8ER1PybZnfvAiwgLab6hiPuuryD+bGhnnjBOe7hH3Hwwf82JZF8ivQlKE80+PwLQAxow/sVYo4TvnFPoUfwNBNcZnSZzw6mPEse23s/JCXiDz85i43L2y5elnFu48l8KV/N4KpedGfrxaw13Ew4N+DuGA0OaMXIbs9YgkJsVZpkuJesFcd82Imc/+OJHHoGdg4nmbJYilkrRV2Ak+zXlfOwmR8qzlW2jaIM8RDQyzNWWhefIV4n3/OvkKdIQnsaieESYF5jVM16Pb6AXhgGnINtf2LU2L+gOyKXF6sCIA5uHebwxnwNXOcwztbPFg26ZSKbBmdGjmn/QCoHeUfTMdr5viznyCI/aTBlSycxyS66dvJZdS+hzTr1eTr3vSmpkA84Zm/O4AWwWLiA1ZUgcUTYV4u4T++C7Rn8AtbGiHJ1N+dcy+lk7ka9q80khFFGCorM0G2w9i27Ygm/1B9olR3FA7zL8vMyRbls8vgOwqXp44ZWmMxUAO5Bs+9AmInp9hd5hDyn7/7VAW+tjVOMG5gJUNiu5fpcm2W7Al852pAR6Wa/wgMEh0i8A211hn5KlfC0JRrg7zYZbw9KsKhCZZ4peTcb7OF/808lkT680jIwDodT+5fbX/2nkJkAq5P2Y0FC9nltqfGeOuMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFC295640A5.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFp0a3E0Rkl6S1NMbkt0TWNrSVloVE9ZcTg0MTdqZm9qMHl2QUxaQ25KZkRn?=
 =?utf-8?B?TWszd0lDMTBvSllMeUVqNHk1aWRMcVJ6TVVOTVhsbU55aHh1dFlLV09MaGZV?=
 =?utf-8?B?dWEybndwVysrRUN6alVTQ3k3L1BBMm5ZYjdmVlpQbEdJMkt6dWJXTlRoZVg4?=
 =?utf-8?B?ZiswNDJxTmJ5K1VsRUZaYjVMK216dE9FNHpmVXVJK1dTS2M3NVI5OGxBbFJn?=
 =?utf-8?B?ODdiOG9CMUI3bkx5VzVaYzlnYzFiYzNHTktNbkJOUW5UeWpyOGZiakVlemdw?=
 =?utf-8?B?RmRuQ0JBOElHa3BrQ0M0ci9mMGdZd2syMEFBZEh1NzI2Uk1UeWhRZDByZzQ0?=
 =?utf-8?B?RGRCWHBQdm1SMXRWYzFNTnc0U3haLy9YMXBDd1dabGM5UmtrZW4vcVR0dEVt?=
 =?utf-8?B?dU5FVUZZV2ZuQzJ1eGcxT3h6WHFMZGVpU21ET2h6a1padGhURVJkU09EaDcy?=
 =?utf-8?B?b3dzem1iSjVsRzBSdjZtT21mQlVObG9IOVJXdUdCVjlDZEtqRGR4amxpWkJU?=
 =?utf-8?B?VnhUcnF3VTBZQW9EcFpsbEFIZ21WVG5qQTZJbHJyUXQzajNLbkVOTGlja2s1?=
 =?utf-8?B?MDNDN3VUYUwwT3pjUHlOazhYREwxamZ4UitqUG1PMFcrRy85TzNycHJxeGdx?=
 =?utf-8?B?YnZ3Qnd0WFAzdDI0Q2ZaUGQ2cklCQVJ0bEZLZERVNkt1d1dRaFB1eWE1TWR2?=
 =?utf-8?B?eWdKWnR0b25xNmRiQ2VBeFJRZ29BNjJ1ek10bHFpbE16VWxFOUxBNXFtb0hk?=
 =?utf-8?B?MzUvSTFtRFNpa2dGV3plQ0VXZkJVUlR2SlpsZzZsR1MzcFBlSGtmT3dZclM4?=
 =?utf-8?B?cHNHYTlYc3lNZkw4T3RHN01rQkRodGkzdkFEcldvdjNtWTRlekRNZ1d5ZnJH?=
 =?utf-8?B?TTlJbVVvekI3RHpHQU5FNlRDdTU2MzVEQitqMkpzZW1xV2lxRXZDRStYK0NF?=
 =?utf-8?B?QUlDdnVEUVZhZ2F1OW82bkd6aWhLQmdLMVc3Szh5UCtyeG1GUkdza2FyYTYw?=
 =?utf-8?B?ZE41WEt3a3R3RGJnRGdoN2N2aC83WmZHeE1qcHZYRDFmSy9UaExmQnZOS3hU?=
 =?utf-8?B?NkpOd1BIOXJHRW5JK2hDRXVhdjlxTFExdVE5d1ZiUnVUWi85RzlKK0pDczRz?=
 =?utf-8?B?NTY1RlBwR3JsMjJDeDR4Mm02R2ZxMnBFM1RNRktoM2hIMlM0SlNtYjZ4OUw0?=
 =?utf-8?B?Y1N2em5CcGFhNFczYko5QThqUk0xWWI5RjlLRDgwVjU3T09tZU4xd05zY21r?=
 =?utf-8?B?OHhYaTYwR1l2WEh1azFYOUZhSEZsK3VoT2MxTzg2d1JaeWdZSEI3VWRPUE9I?=
 =?utf-8?B?VlF3WXdPK2FHSytyVTZmVUxXY2pmYzFPZ0I0ZUNCcmwxcEZxSElFbFJIU0NF?=
 =?utf-8?B?cUsxUy9WNENYUndRd1p3U3Z3cVM1QXpwRWdzWWd6Wm5OMklWNm5GY09Kb0xQ?=
 =?utf-8?B?UkNBQ1l5Tk1HbldjQkJKcGlIOXlLNXZZeVdEcUZSTWNaZ0xnL2wzR3BNYjFB?=
 =?utf-8?B?TFlmZjBmRzh0cm51YTNxdHJZekVBZllJQmc2bzBXSk1yc1hjYmFBMEFSeHNp?=
 =?utf-8?B?aXpaa0xBYkl0RWF3ZWxlWUVNbEY4TzNjVHM0YVNtMHF4MXd2TlFPZWlBaDJH?=
 =?utf-8?B?MnlRL1prLzhYMXNLY2gvT0plUFJnVTdQYkJWdytEekFFcTRKSVY5N2h5OStN?=
 =?utf-8?B?K1N6Yjd3cmVoclZ4ZGpkWkJkc0ZXTDVLZjEwQ0FpT1h6QVpPeFpNb2JZMTRa?=
 =?utf-8?B?TW9mcWlqQmtGT0hyMEJzSFZkRGVSS3B6NnJxbEFCaWlJVTZaM1FqUjZ2TUpJ?=
 =?utf-8?B?VFdNWnRraEVNc1JiZ3lEWitaVVRvYXB0WFV0aU9pZWhBSkVQMTNoR2Rha2J0?=
 =?utf-8?B?MlRkcEw3djREeGFiS3BqVU5rQWpneUVIT1htZ2dnRjVoYU9zTTRPa1lER3hO?=
 =?utf-8?B?VnY1bVg5RUFmWkpBYXdUcVBrUXFYZVk1cWV0S3p0QUdyYXFFb1IrdStHc29W?=
 =?utf-8?B?VFVxVTVsSzN3RndNZWExNWo0K3B5dVkraUNuSFNCbTdhbWhtWHhJd1A0bFdu?=
 =?utf-8?B?NlB6UWpkTU9KWGdmV1N4YytwT3NTT0tLenpOL3pBUXlzNjFpUUVGVS9rcWNG?=
 =?utf-8?B?N3VKMmtDSmhza21LMUkyQWFvVmltRnFVT2czR21HejNYVHpObktOUHRxWTl3?=
 =?utf-8?B?YlljeXRkbGtHbTQxdjRtVy95dklUMWV5UDl6amV4eU8yYW5XTHZMZTVWamd5?=
 =?utf-8?B?THJPK1c5Ry9HS1daWHU4ZmY0QkxHQitXRzlZcVlnSjJ2R2FydWlRUzdraVVG?=
 =?utf-8?B?U1pMQmlVWHRUZXlwNWM4RWZFZ1AycVVRckNkaHhEdjFaaDVweHdEUT09?=
X-Exchange-RoutingPolicyChecked: tbuqMYFX2n6ScIUqJlVjbrYeAke53NuGGIgrja3U1igCx+KCo0YF1Qqf5As2zn48aWRU1LugUSiTK3cdiNJV3rerWCa7UnPluHdmrV46eHGhw6xl3e3/3HRh+XQTpEurgh07TRbBZQ0hhWZ0q8b9a4PrGImbu3r4Jnt3yRbeDuicv8BEivqyDqViJzVPSBp2Eik3am5MzhOKUgapDtUDsR+dl/dZ8az1hoFPVBTlT5piODU54o6fbWUq/kbGUulp8YCO2pUxMXTMqJSmvxDs2qu6mm5wcN/sYhJIvz+5Q8k3w4BdlP6yH7T7awFMI/+jSyyOW9/3D/K+1Usgz8AfJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6799c-2c3c-4748-c65f-08df155af25b
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFC295640A5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:00:46.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZFsKhXkxXsiWwK4xfdW1wKTeF0z5skXnar8WWa7IOIavOBLJda74z3KL+jQ5zDYPeFvav8pQBz0b09XNZbJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 9/16/2026 1:33 PM, Tomita Moeko wrote:
> So on MTL+ BAR2 is mapped to the physical memory at GSMBASE, with first 8M
> for GTT. PTE addresses are relative addresses so that accessing indirectly
> from BAR or directly works. That makes sense. 
>
> Meteor and later IGDs are supposed to access DSM from BAR2 instead of directly
> from DSMBASE, but there is some hardware issues in Meteor Lake and Arrow Lake's
> BAR2, software workarounds it to by falling back to DSMBASE. i915 won't read
> DSMBASE register if the WA is not enabled (and it's always disabled when
> virtualization enabled), while it's possible for GOP driver (and maybe windows
> driver) to read it. Is my understanding correct?
>
Yes, your understanding is correct. In virtualization, we still go to BAR2.

>> Agree with the direction, and it is cheaper than that: a read-only BAR0
>> quirk can take pci_get_bar_addr(pdev, 2) at read time, returning BAR2 at
>> 0x108100 and BAR2 + 8M at 0x1080C0.  Then the CPU-side address resolves
>> to real stolen memory through the aperture instead of guest RAM,
>> bdsm-size stays 0 as documented, and nothing in config space is
>> invented.
> Yes hooking on 0x1080C0 register read is easier and more straightforward.
>
>>> Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914) to
>>> disallowed in QEMU, if the GOP driver code checks it, to enforce the access
>>> via BAR2 in guest.
>> 0x138914 reads 1 on the host and is not quirked, so a guest sees 1 too.
>> Returning 0 there is a small addition and covers a GOP that checks it;
>> the DSMBASE quirk covers one that does not.  On the Wa itself: i915
>> already takes the BAR path in guests (i915_run_as_guest() short-circuits
>> i915_direct_stolen_access()), so that path has upstream precedent; we
>> have not measured whether the hang reproduces there.
>>
> Quirking 0x138914 prevents driver applying that WA, but we are not sure
> if driver checks it before WA. While hooking read to 0x1080C0 fakes the
> DSMBASE to (BAR2 + 8M) in guest address space. Both tries to enforce
> guest accesses to DSM via BAR2. I personally prefers hooking 0x1080C0
> as it's driver-independent.
By some internal sync with Junjie and Bosheng, we plan to quirk 0x138914 as you point

before. We have checked the GOP code, it always checks the 0x138914 first to determine

the address it used.  If you think it is ok, we will raise a V3 patch based on it.

> Btw, this quirk seems only necessary for Meteor and Arrow lake. That WA
> is not applied in Xe driver. I'm not sure if it still presents in GOP or
> windows driver for later generations.

The WA is only needed for MTL/ARL. The later ones don't need this WA.

>> The firmware still has to program ASLS.  The IgdAssignmentDxe build the
>> v2 commit message describes aborts on bdsm-size=0 before doing so;
>> VfioIgdPkg has no such check and programs ASLS for MTL+ as is.
>>
>> I'll write the quirk.  It can go into Yuan's v3 or on top of it as a
>> separate patch -- Yuan, your call.  Either way it needs a run with the
>> stock GOP build on your setup.
>>
>> Junjie
> Yes OpRegion is needed for display to work. In the "hooking 0x1080C0 read"
> approach above, allocating DSM in guest is not needed. It sounds better to
> make your IgdAssignmentDxe not aborting if bdsm-size=0.
>
> Best Regards,
> Moeko

Yes,  that's a good idea. If we can make IgdAssignmentDxe not aborting, it looks better. 

And this function is in the offline patch of OVMF and is maintained in ECI's website.

We are discussing this with the ECI team to update the offline patch. The gen_id() may not

need to be changed now if they accepted. And the V3 patch should only include the

quirk for 0x138914 for MTL/ARL.


Thanks

Yuan


