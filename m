Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8320AC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhVN-00043n-9L; Wed, 24 Jul 2024 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWhVL-00042L-Iz
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:18:27 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWhVJ-00065q-3S
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721848705; x=1753384705;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A6LxjGpuZeEPRCD1WgnUBmGprr4BotEFLs6ADTYa9TI=;
 b=E4uZQLC1pZHVv8UFXydwH7OuH3+9qtoPe7ufh42fibg5I7lshm7yBSQz
 OTkmnmuwbJ6NSDBSs42j7Ge2wRUVkYukQAOG13VuP6mposQz5bKs5BAT+
 qBj3xyMaIjH0wqfIc0BJUHu7J+YPlAzrqXWtctysg6NAZ0NnOCL3THUq4
 TxTIrlyqcX066i37CxGE7fZ7mVhJIh/k4GNouEYVhjJH8wUBtMY4Gf8hn
 TBtCbpftPOPBumtBSt4pdJ0MDOLLF2NS4ekhRsnAhZlrS9/wJMFV+v8U0
 m04iUtondkGGFMo1Qc/XiLxE7pHkR0bCsRQS3tso7HRJOxkggl9xRoII/ A==;
X-CSE-ConnectionGUID: RyXvmJsuRn2bzgz6DQYvDw==
X-CSE-MsgGUID: tSTvdyVgRnKlfPOkLMdwgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30970066"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="30970066"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 12:18:22 -0700
X-CSE-ConnectionGUID: 5ulJFFR4T8GKtB8Y9bY28Q==
X-CSE-MsgGUID: fakqK0hfS9Khs6y+U2qiwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="52716340"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jul 2024 12:18:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 12:18:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 12:18:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 12:18:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 12:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JctBb4O1VbQsFa/OM5aRB5Whwj5ubBT8cuAyr8QLGPHGK53JJTjq/Xe1aNTc22eXPHYhVm5ZPpaOKymNaG/fXVRWMGN4lj3vcYbm9DM4In02BdmoStUlhmP27/4DeZp1k1yDhywSwPVnrs+ja9aUvIYa5/YjET7e9OeBxEqCIP7jic2bXJ25RWR+6f1rGoRV4HXyU5PJSSIeR6Dz49Xh2l3dP624Npa5vfHo7WHnmKqLXubXq09uUpHdsmPhWmFR2Ro/2WhCiiJz/W0LqzZeoQoq5M1D4lTty6R51JDSQD0B+FjlCMbAaJSCnlKJhNvWxnOpq62Kqthz2u0dq4CIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1MwLp75/Pd8Hm0f5ktPyLJ7dm3qzBVmDZQaB1x6pr8=;
 b=mRvp2MCurdtIBjtU9zvWfDfS9I6yipn6m5zsUHR2+lErGKhievQK8kJ7ArWBVlA4T+pgM9XvudvPwZMNOIsG2Em4NdHuFSLXfJdexMzmiKW4cBUQj332YqDZUtiYJdky54ERuvPvdS42EIht4tZM3MQXLdj/vZzuPCB3e66u1wpIVgqHrObL9STWg5pKCcaJ6dBLgh0anQyCUUhZr4BWSdYcWzILoUmyqXNFfSTRb3pyNxclPGxXGacNQv7CiiLYhtzf+XozwEXe2s+7WwisPbGLCh3iHGoDCS9y5Gqd6roOqMT4xMTylGWC3gnQdi04KhE8W9O+4Dv/FgD2qjnvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 19:18:18 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%4]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 19:18:18 +0000
Message-ID: <cc8bbebd-5f86-47ed-9c11-fdaa792518b6@intel.com>
Date: Wed, 24 Jul 2024 12:18:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Consolidate create-sync and create-fence
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240723220258.3170957-1-dongwon.kim@intel.com>
 <CAJ+F1C+kk4ZBjf8bq2haA4WgzEoSrN2GBYoC5Lc-r17VmRNA6g@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+kk4ZBjf8bq2haA4WgzEoSrN2GBYoC5Lc-r17VmRNA6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|PH7PR11MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bfbda6-2d31-49d9-bcd8-08dcac155fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aktuSWd0S2J0VERrV3M4ZmRMOEJ2V1J5NklXRklqM0pac1UyL2pIRXVOa0pQ?=
 =?utf-8?B?dW80bGtuU016UjA4bndBUFVOd1FIZTZ2SEpkQ2prNDdsZjd0OXlOd2QyVW5z?=
 =?utf-8?B?TzY2eENxYVhPNW1yMTZCaUpkNlFPTHk3Z092aXEzVHF6MHVvS204KzdFQ3pM?=
 =?utf-8?B?R0s3dVlpem11bDFQdXZXa3IwTG9XcmprSUxxUVpUTjdRY1J6NTB3RFNsNnVY?=
 =?utf-8?B?VW9zMkVBZnNVRlIrRW1MRHVmV2pwejROSFJtMEk5ajRmUjVWOUgzczk1OThq?=
 =?utf-8?B?eUJCdWh3Y3h4NjFuUnlTazhvM1Q5V0Jvb1dTUnlLWnRBaE5xem1Lc0JGbXIy?=
 =?utf-8?B?WnNMYnR5K1A4MThzVFEyelhLUUlkN2JteTJDMWR6QkQyY0ZxQWhVSThCdE9F?=
 =?utf-8?B?OVRuMHozQkpsY0ZtZm1MdkkxOUpPL2RGZmxqR3ZwQ2xyc2ZoYzBLNjFDcFFa?=
 =?utf-8?B?WXdranl3bmdRcVVQNHhUUjFFRlluRXJ4dWtkbGd0Snd0NkczY0xxdklmVlNT?=
 =?utf-8?B?eDhERzNRYXdFblRtQTk5Ni9FVnhGVnZsZ0hmTTh6dmM2ZU5XTjFCTXNGSFRL?=
 =?utf-8?B?QlR2WXlrNDZaQURZdDNqMkxER3JERTZTeThRNi9kalMvWmlhVmh4SU96RUdY?=
 =?utf-8?B?dytUeTJnVndKUTlRODRobS8yM3FjWnJYUWc5WHNxb3JHMkxsYXoyUDFoZm5n?=
 =?utf-8?B?STFlNGxpaUovVHlLaWlmRHM1MDFmZWlPNDFUWUplNEJzTkl1WWQ2OXc5RE1z?=
 =?utf-8?B?Y2xjd1BzOGRFcGpUajc3RjB4RkJNS2pKWWJEeW1zVHpjNEpraVc3QVpSL0Vn?=
 =?utf-8?B?WkdpazhYRk1IcjJ3YTVXeHpKaG8vZDVFUDc5ZVhMYVF4Zmo2WldLL2xkcm94?=
 =?utf-8?B?S04yMThzNGhxM0JuSHVoZjlZbXZZalRuNUpiQmFBOUFFSVBBWHM1RGJIOUZV?=
 =?utf-8?B?NHNwZUZyTE5aNWZuVDlBZWRpcVlLS0xPL0ZPRCs5cjNZRE40ZWhQTXl1RjdL?=
 =?utf-8?B?OXBBbVozVkZaSDJubDh1U2tqOUZKdmE4SGYwWm55b0REKzRXNEpVNVNLMDBH?=
 =?utf-8?B?TitRSVpjK0pqOUFRaWpkdmRVVGNZOUpuRTNFb2xBYURSZEE5TXZKM3EydE4w?=
 =?utf-8?B?eFF4ckhCMm1Ud2VLM1NhQUpOUXNaQWlpSlZPZThsT2VWWHl0czY1UkJSQ3Jw?=
 =?utf-8?B?ODRYNmp2VXdHekNMdUF1OEl1Q3FEQS9pclJtTnRiT2dmMUV1WmVJVVdLbDlw?=
 =?utf-8?B?Qkx3cFhnWW5ZRDBHZWhub1BYeDlWNzl1UGlqYXZNWU5NMndIYStTc2tUTHRi?=
 =?utf-8?B?aGtkZlBVdmQxS053bmhrQkt0QUxFamxNZ09nOWJGdk9ETHlMMjRUazRGcFFC?=
 =?utf-8?B?VHYyVmlUY2diRW9RYkZRZFBCT3dYczhtajhjaWgxekRTRGxsTkx6MWlKZ3E5?=
 =?utf-8?B?bG5KQ09tSmg2MWV1YkR4R0VCTXRHdW1EdDhYais2Zm1EYVZZV2JRR29WNGZi?=
 =?utf-8?B?YjhraXpZaS9rNHJ3YkZwQk9pOU9YWk8yTXJMREhWbDZQRkdwYlV2ODBGMWd1?=
 =?utf-8?B?Qm5TTDlzTmErVFpTRGlhTHJ2RmIrZVN1b2NsUHhtRWV0bzd5Y3B2NndTanc2?=
 =?utf-8?B?NjNHbGRLWTRhRWc0N0VBbmhYTk1mN0oydkJKb0VpbWgvbC8vV2djdFVLeGVD?=
 =?utf-8?B?ZzAyd0V0eXRyb1lva09Gdm55RHErSWtqUzhic1ExdHV2cG1ZM2lZSU44MlZN?=
 =?utf-8?B?ZXlVN2FhMHEyUzl5bnYxWnFBTWZnMWpMVHhZVkg0WkJscDQwLzJ4NGxtaDZo?=
 =?utf-8?B?QW10Ni93OTBNNVhUSG1UQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xHb2lGWmZLTHNWRWNjc1gxREU1MTBBcTBQTmR1WDJNMWVtcTE5TlovMDc5?=
 =?utf-8?B?akZIL3RBcE8xMG9SUWFCWFZPTVZhVXlxWTBBVU8wZ2ZzTEpLMjhHMnhaUjhP?=
 =?utf-8?B?RndWSlYyVTVjOTdGVmFQL1VVaFg4ODRwUUZhVzZQdnErbkNiMmZ4aTNzSlY2?=
 =?utf-8?B?ME5tcTRXdGs4RlRyUGkxNVNCRVdjakZOWHlwMG9GWDJrOGw4RTgxSGd6Rm9H?=
 =?utf-8?B?em8yRVVOazN0VjI4dThLNWFzSmdpQmFFS3oxdExCclhjOWZHZFVNVUZLSmxY?=
 =?utf-8?B?MEZ3aWlFbXovTkdhTkh5dzFiQVVlV0Q5Q28yYTBpRWQrZ0oyMEorOHlBUEVH?=
 =?utf-8?B?M25URzJNL0VWOENxVXdZaVlqZFdjbzREdFJzL1pLbEVYSjBzMk42WHlBV2Nk?=
 =?utf-8?B?emlnWFlVQS9ER2t0UWE3eTAyT2xpU3FFSUdwYWIwcTE2YU5USGJCc0lhVlds?=
 =?utf-8?B?WnFnMmRVOCtVVXJnMjhXam1kZEMwMUR1RmxXZi9OM2FQa3VTeFA2TE9oNGVv?=
 =?utf-8?B?SVRFN3NKTHU1cC95TENKZXY3ZXY5bVFNUmljdnYxZElKL3BLY2ZNMmQ4SWp3?=
 =?utf-8?B?RTN0S0ZJNTNCeDRoVmNseHYzQUMwNlREbkl4SE1rS001ZTJPWkx1M0Z4RUl3?=
 =?utf-8?B?TFhLUFk4UFR4bGlKN2VlM1VzZ2k1YnV5THVQQ1JzN0oyL2krYnpoRjlWdXRv?=
 =?utf-8?B?SDlDbGU2NGJnTjdGdVoybWw3cFA1Mm4wTDVPRlZmcmdQLzBTdFNBUFFBZXNR?=
 =?utf-8?B?STRWekhNdk9Xa0ZvNENyQ3BOdGRUd1pHNGdXNXlacGIxRVJHZHFpOEVKVEtl?=
 =?utf-8?B?bjAweUhZV0RlbVhEM1JKbEgvbHZ3S0tJWGhIempoVTdnL1E2TndVZVFTOWFI?=
 =?utf-8?B?TnI0VnZOeDVpQ3JpaHZDUFc1KzNpbllxbmlkZ09TZU9ESTc4TzZSSXlBWFB2?=
 =?utf-8?B?aDJwdlkwQThpbTR1bDcxbVhNcTh1WnpJUlhKNVJHeUhkTHNnU2dTRlNid0lR?=
 =?utf-8?B?NzY0ZU1iVVhMR00zQ1IvT2NXd3Bxc0VqcVZnaEpSSkNzZm1zMnJkc2pITkY4?=
 =?utf-8?B?Tk5BZzcweUpPTXJKUjU5Q0RhYmx2bE84MEpuUjJrcTd4R05hV2dKMGFDVWdp?=
 =?utf-8?B?TklOaElNcUZ0ZFkrbmM3dkhxbmxIVk0yeGU3b1BiUklRa3FGN1N3WDd3UU9M?=
 =?utf-8?B?VGVHTklIbnlvOVFZcWxPZUdxcVJlRVJPUUtudWlHekN4Z3ZLZytreEZDcXFK?=
 =?utf-8?B?N211d1BUSnQ4ZjNhcHFJMVc4OXdOVVpuRmd5TWc3anRLVDAybU94MU9qWjhY?=
 =?utf-8?B?cytqNkp4Mk5nVll6aU1nOEM2dEZENzVQRm1kQnR2Q2tVMTB6MkVyU2QzMVlF?=
 =?utf-8?B?NHNhTUNBRlBSRzFMN1RLM3hSZlpOM2JnN2d3VDJ6SzBkdnphWTMvYXR3c25W?=
 =?utf-8?B?bGd2VkVJY2dRNlZHWFJheWsvVUlNSnlmRTcrNXdTa0t3ejFjNy9TL29VbHRD?=
 =?utf-8?B?c0tDR1lSY0hyVHg2dnkvYXd2SXIyaEFFNHc2L1l1ZjM4alBManMwYVdRVDlU?=
 =?utf-8?B?Q2xhZnZ3Z0RYZWkvWmhsaHFkaGtVMlhRZXdLNXhjSnFOaURsc1JqbnZqR3Vn?=
 =?utf-8?B?a0lSL3YzemNaZTlTOXFpbk5sLzcvbnNCMTlsdHZiaXBPN2dmdUFzTFo0dm5K?=
 =?utf-8?B?ZkRkZnpuVzFYMVRpR0FZZUVueHJEdlRzNk5jbityTmYwQUt4Tlp5UTdTMFhp?=
 =?utf-8?B?Smc4blk4d3hRWE9talVPSHRZNFgybWxjM1lUeU9rc08wRlZ6bTNLdndCZFI0?=
 =?utf-8?B?K0hpVUF6M1dUMmtIWldxQXZFY2hUUGVUOHZGcHBVVmV6Uk9qbjh4ZkMvOUZW?=
 =?utf-8?B?N2lDTWhhWHp5UExubUlPczRNTFR4MXZ0dG82cG5mY3FxNWpEcUJRWUNZR0FV?=
 =?utf-8?B?TFBtOW1qM3l2cU8yNThRdUt5WW1zNC9HZlA4M2IxRTVOcmZ0VS9uNjJVUlVy?=
 =?utf-8?B?Z2JCOFRiR2xYWGhNVFZES1hwejk0d1JhMldaME5qdkV6VTBBdnA1ekVrMmtB?=
 =?utf-8?B?T3hBRTZuaHArbm56QUMyY2NtbjNDdEF3MGluY2RmQm0rSWx6a0Z1ZjEvZWxP?=
 =?utf-8?Q?0Lt6pAeypHht3cL7RSXGqzCL1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bfbda6-2d31-49d9-bcd8-08dcac155fc8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 19:18:18.1831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE+N7dtYluLtjsdwC6AETyOMXNRIP7PzPyKrbQGEJtNRYWerU6TH40fMuuSWcnD57XZkCzrfATlqfFlSVORXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

Hey Marc-André,

On 7/24/2024 3:37 AM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jul 24, 2024 at 2:05 AM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon Kim <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     Sync object itself is never used as is so can be removed
>     from QemuDmaBuf struct. So now sync is only temporarily needed
>     when creating fence for the object which means what was done in
>     egl_dmabuf_create_sync can now be a part of egl_dmabuf_create_fence
>     function. And egl_dmabuf_create_fence returns fence_fd so the
>     better function name will be egl_dmabuf_create_fence_fd.
> 
>     v3: create fence only if current QemuDmaBuf->fence_fd = -1
>          to make sure there is no fence currently bound to the
>          QemuDmaBuf
> 
> 
> Why not check it from egl_dmabuf_create_fence_fd() ? calling the 
> function twice can still potentially leak.

It is called from only two locations in gtk-egl.c and gtk-gl-draw.c
and dmabuf->fence_fd == -1 is checked beforehand so I thought it's
not needed but I think your point is the completeness of the function
itself. Do you think we can do assert 'dmabuf->fence_fd >= 0'?

> 
> Also, please gather the v1/v2/v3/... summary on the cover letter.

Sure

> 
> thanks
> 
> 
>     Dongwon Kim (2):
>        ui/egl-helpers: Consolidates create-sync and create-fence
>        ui/dmabuf: Remove 'sync' from QemuDmaBuf struct
> 
>       include/ui/dmabuf.h      |  2 --
>       include/ui/egl-helpers.h |  3 +--
>       ui/dmabuf.c              | 14 --------------
>       ui/egl-helpers.c         | 24 +++++++++---------------
>       ui/gtk-egl.c             | 17 ++++-------------
>       ui/gtk-gl-area.c         | 12 +++---------
>       6 files changed, 17 insertions(+), 55 deletions(-)
> 
>     -- 
>     2.43.0
> 
> 
> 
> 
> -- 
> Marc-André Lureau


