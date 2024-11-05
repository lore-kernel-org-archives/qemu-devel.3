Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2A4D12660
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 08:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8EXh-0003jr-6y; Tue, 05 Nov 2024 03:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8EXd-0003je-Pv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:03:58 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8EXa-0002sY-Qx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730793835; x=1762329835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aiG+KTJwabgc0i7XJPbxWkcqDHU6aCAc3V7aKTyg1BY=;
 b=jbs3fBYcpQUWmOUtLYb5p1g4GHgjrQrAJFsRau5CttO49I5/tjzX4Bf1
 ulMYbr5enf8R5gVJnxZMjdoDC9zAmIHcwVhSpAaxMobHRP9cWNZYbc0E2
 MmJC58w7o2Xhpdepq69pd9/3/wMVqm8y1nolWGRdxJD46Ad+kBy748qKO
 64Z5yZb7hDlAb/WYtXyzwRyfWk5hCKYiJb5XiPQnz6bj4lFIaQUCXl5QH
 RwRQPH0sPPgI+XZ8CsM4z9eTYje3aTtHpooG+O5aqMh/zx/EmicReUaoS
 zVKQHXDxSeB2WZxI1MdqXdjmb3FapLUzfY6CH1f/xxToug0WH3AHNx6OV Q==;
X-IronPort-AV: E=Sophos;i="6.11,259,1725314400"; d="scan'208";a="23843342"
X-MGA-submission: =?us-ascii?q?MDFq/yx4iFf7gjW3hT1gAkP1Ad5AS4UhiXzn8K?=
 =?us-ascii?q?wADLDiujhSYY7Rh9JDcYJjudWJKqyY9XkAyvE2ccdTpezxSgkuiY6lf3?=
 =?us-ascii?q?7dxrALnyvq61VCuUAIhu4AGkBZ95hhxdKTKsMYGdnlDjqsPFAqh+GMiX?=
 =?us-ascii?q?FW5t9++r/ddaqcHB7oYU3xKw=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 09:03:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laV45VI3lbKwIWdYgBeHhphbKTzyN+tRS9c582wDDPXb0lF8CivyI8DcPgEg51ssaUeGKdF1IRTmRJ1RVdZ8zyv90FzihJwSdhBZO/gaRm5RXG+PzeigNPpUdKk48WjvfQicNK8T24UbBzlV5poMGOK14U7+bWfk3lc6MJPotcJ0oggLUqnRA1o7doOXQ8nsh7s4d/SccdXU1eux4S2VMnPI/8yXEnkEXhEXEokYDedbMSkrDyCTIS5RQrOMRy67dJfmcU0EZnvPadZdrfFpKUVEGbJTP8BLoEVGeCLaA5iuoXL/OMcssasrLwS37uWo3lTp8sQXUvP25VSOW2Gpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiG+KTJwabgc0i7XJPbxWkcqDHU6aCAc3V7aKTyg1BY=;
 b=sOb0sPcyP6bQHeK+nBg5MEgS7jaF8BbzCuKA81DhyhrRRT8enrDuP7wc9sVkXCNaiI7g/s4qAjMZpp3quRMePeyhv4eS4JYy/YZtZCxzKztXRlSdNybPDTqQkgt8ss6zKumkii0UEBbI+BOR3h/OlRBEZPL5/WP2i6cpHRPba7oimuj7ZPpcbsBpY27dXRd5YgnPC2Xq976SZZvNSS+0zM6sj6U0OED1C79kUYEFDrTjjOh4uUXfHEgkjlVBADpF5mjpjj21cKrXwFJ0NQ1rvMrhvo3+oRf8/BNeaPaOYTZi67cONKK+qkjh7yiHXXpStZ3+/x6pH4pfdlnrs183DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiG+KTJwabgc0i7XJPbxWkcqDHU6aCAc3V7aKTyg1BY=;
 b=MLVUwAwRva7GzUxhJ/skZmU7MfGUCg+7qsxmq2pcmwkQLFWdWcwYljT6yfyvogG/nWvvmf7sWPD8YA18lfV/5vsBcNQnN2k0mdbB6KPVy/vIhA8Aslc10ky5+0QqR3ZQ1z1aQgBRaYl3BOSvaWKcuFj4iTqlTNccdbVJQ1MqQL0bkM4BE+DZwWQSdgnm93M5HZHjLSDByYeouZy9XchtZbrIsxPkxLmYLnmbCk7h5wptrJre/OuAICeNFVK3uZCEQsIneWGDsoFAj+h1LP6yMuw6F/t3cEolmpibkL5LQsNqm/a6MuUrPxsL6g3vTcX4zORP4QFv6QhZpxYOTxP2Zw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB8670.eurprd07.prod.outlook.com (2603:10a6:102:260::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 08:03:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 08:03:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Topic: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Index: AQHbLrlh9PDFsDzYt0a45BWwl/7frbKoPIQAgAARioCAAAb4gA==
Date: Tue, 5 Nov 2024 08:03:47 +0000
Message-ID: <b7e418ad-0fca-49ae-befd-aa9f697958d8@eviden.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <f92098c3-32a2-4493-993b-e15284d1211c@eviden.com>
 <SJ0PR11MB6744A9DA583E376307C5E3B492522@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744A9DA583E376307C5E3B492522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB8670:EE_
x-ms-office365-filtering-correlation-id: 335c79aa-1087-4370-cc04-08dcfd70604d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?REUyYm5odzdYcjNXSXJob3BnM05rS3RLbWJyTytMdlM0Z2lBSVRxZFZLdm81?=
 =?utf-8?B?VDRVczVnVlpZN3l3cENld0t1Ylp3dDRiVnJnNWVOOHVReXFEdFplUWYyMlVR?=
 =?utf-8?B?QVl2MmpiNktIVzUzMEVyVnFSdjdMcWhHc0d6Undwb2NCMEh2TG1Fd2IrbDlZ?=
 =?utf-8?B?amNTWk1ZUXNxT3Ztd2pmYXpZNVh0a1ptc2ZzeXZIaXRXRlRjd2t3VEF1SDQ2?=
 =?utf-8?B?Z2tteVd0TWw1b202VTlzaTFvMnZvWis2SFJIVE10bVAxUE1FQ0twcFR2alB6?=
 =?utf-8?B?eFhrMk9LUzdGc0I0QjFPN3FwV1NSTXZSTzZ4bTM3cnljcHdoaTBXWGpYSTNH?=
 =?utf-8?B?RnQ2V3Q1aUFQVzZ4Ky9Zc1kyYWRaQWd2cTV0dmYzQnZETnljODhuZnR0NEZF?=
 =?utf-8?B?dFR0elMrSWhaRDVOZENJUnlhTEZNak42UmkrTy9mMXovL282MnFDS1RpcEdw?=
 =?utf-8?B?RjR5REd3TFU1bGN3aUU2VDhiMlQyM2RnWGJBalFMOVozQ08vbGwxVmdCMTZM?=
 =?utf-8?B?VmcyUytBT3BhMml3QWg0c0hkSHJoaWUwbzJ4SUxwVVRrcDZzekVWd3lpTXJN?=
 =?utf-8?B?K0RFanhNcDVFUG8yaGFUMUZkbTd3UEdnSE96NnRleHpUbk84OFlRZkpwelJ2?=
 =?utf-8?B?RUdueE8xN2ZwQTdCNTc0NmJkRnQ1TDV0M2hKckJab1VsMUdaZzlqeGllR281?=
 =?utf-8?B?ZUVZOCtlV1V6UjJZejVCRVBac2lIemhWL2RoRllKU3Jqa2tnRVJXMFgyMWN0?=
 =?utf-8?B?QjVDRkREekpXZUNFQ29reERDeG8zWmMrb3BiZVNTUFZnVjh2WXV0SXhFL2Uz?=
 =?utf-8?B?bDFBdFhic3BObU1pTC9yOVNSbTRLd0VLd0dQckNmWHlMWEpubERrdFBad3Ft?=
 =?utf-8?B?eXFwaTFyMis3R05OQ0VmS2hMWGJhRDhFYTI3WmkyLzVsYkl4Y09vS0NvUElo?=
 =?utf-8?B?TWFlS2tNbUdVcWF1MkE3NTBqZ1pzSVZ3NEdOdERIOHR5RTFJT0F0aHZGdDRO?=
 =?utf-8?B?b0NiUzk3RlhUejAxeW5uMEJ6T1E5d0tydm5TWXE4VHIwWU9uQ2F3Rkl2R1cx?=
 =?utf-8?B?ZkJWMEM5VHJoSmNhWUdhUGVMckt3bGgrV1FUTzNzd00vRUpFc0hFSGorU3ZS?=
 =?utf-8?B?UkFoMnNEVGN6SmFqZEVOMElpM1NZY3RhenpBZk50VGc3RFBoKzFsTENaV05l?=
 =?utf-8?B?ZGNuYWNyTG5IM1ZrUmNTZTBHNncvTWNQeWE4VDdUK1NJdFNQRFE3NzhkUlRO?=
 =?utf-8?B?K2hlc001d2xhM1VBQVBabjd4eUxkQUZFL3dzZmNIOWNGRUord3NpTVNMSjMr?=
 =?utf-8?B?RW1JWkVUWXhIb25zSWFteUt4REE0am5CaTVuUUkzcEdER2JqTFFoL0E4bHg2?=
 =?utf-8?B?QTVodFFOMkhjamlUWlUvVU9JYlJuUlBYMDJhZTYxWmJ2UUprMmx4YUs5TGJo?=
 =?utf-8?B?VlNiK2NLc3FoQ2RwRFhIV3hkYTllTzV4SWVkYXhMZzVRdUhmc1hEZnNtS3Bw?=
 =?utf-8?B?OU9RNE1CYUE2RjJPZmtYTE5iYmI1KzBzYlJIb2JsSGpqNnZ6emRsWmlDU3Ju?=
 =?utf-8?B?TVQ2a1ZVd1hCazVxSGZoWFhIcldyQ1dkWFhHMGt3NWJYMFVBSVdYdVphMWx3?=
 =?utf-8?B?cVBHdXphUDZuQ3ZDS1V0SDJUSjRSZWY2N05zWFA2Y0Qzcmovc3d4ZVh6QVkz?=
 =?utf-8?B?UEhZWnNHbnowcFE5RlBDNzZLSk5IVFBkeHNLSGY5eG42d2dXNzhUTVZ2NE5x?=
 =?utf-8?B?SThkdXF6RnNUdTI5Ym5HVUdYc0ZaVnlmc244cUZLZ2JWbGpZUFU4U0p0YmZV?=
 =?utf-8?Q?aOJj6/lgY/53ruou18A2FyL4vBw8EQ+UQva7k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDVNMjFKM2VCVmhoaUxKSGMyYXJXU1U1R1R0bktjbWJpM090cjkvUzBRUWxo?=
 =?utf-8?B?c1hhRFE3TEZwUEVRanRUOExzN0IvZllMRHRLdTd5YUlxUVRyOFdHRzc3aFA2?=
 =?utf-8?B?dWlDTnlsVlp0MmpraXFHRmt4SmpLNEEyUjF1SEVLWGdPYWYwQk9FaEduQWZC?=
 =?utf-8?B?QS81c1JMUHZwMWVjQVlxSTQ4WUROelRQSVhyOTBsdHl1UVQ3Z1BaTEFySHRr?=
 =?utf-8?B?U09zSkZEWHQyaDhhNkx4VFAzQW1OdG11MzMwZFJGSCtBOXQ5aUpMQXRQcGJU?=
 =?utf-8?B?emdaWnJUanZhWmpRZytJQlg2UllJeUFNQmhKeWJaekl3blMyY2VWeGE4NWdJ?=
 =?utf-8?B?WXMwcFp1a2pSOEo1NmZZRStyZ01KV1VxZ2dvZTdMYmhKRXk2Q1VOQ1J6TWN2?=
 =?utf-8?B?NlJRUjVWajVMdlpna0w1UHBNVjdwaTB5U1c1b2lGZTBHS1VDWlpGdE5FUVZh?=
 =?utf-8?B?Y1B3TEhZTS90enQ5b3pEa25oRWZ1dEVTNGVKOEYxMCttOHRHYkZrd05EcUxi?=
 =?utf-8?B?N0pSMGNPbkt0eEpZRWxwby93b0Z1WXByV1duL3o3eTNqazRRT1ByTDNUNTYv?=
 =?utf-8?B?aVlZUWpxWGVieEpoekNLNktaTkVSdFJmS3ZYSlJlVU5oQk04MERvYWFRalhH?=
 =?utf-8?B?ZS9HNzlTWGFxejFHWlVOc1JnV0dBS1JqVmlxcGQzWmNzbFV0Y2gxWGJTUEkx?=
 =?utf-8?B?ZHlLdkRkZGV5SnpJM2xETmlYcGpQampQRVJWTW9ZaTkrVlNqTSt1WlpSam5p?=
 =?utf-8?B?cllUbEJjbXlaMWVEMFFHb1F0dHdKdTN6czB5eEhtV1Jha043bUJRRmhIbXFI?=
 =?utf-8?B?eXFmV2dFTnhiTDhpUnJ2RWJYbXBXUllIVnNMVUhFdGhLMGRGalFBMnJIM3E0?=
 =?utf-8?B?RnRjN083T29CWTI3blc5VE5lRkh0dzA0WFZJUUI3TnJrelErTFZoekhzYUtz?=
 =?utf-8?B?WWJ5ZWVJZTJxUHd1ZnpyaDZmNzVWMFJsZHpGek44TEtSZ1hKNU5EcTVYRGlN?=
 =?utf-8?B?Q0lMMEhhZmtybkhkbU5FejY2MFh3b0E3VEhYQkZvckx2WUJxNityYldJQ0pD?=
 =?utf-8?B?MnlINmRSdHJScjlmcG9xQ1hNaDQvOERJNzJ5RUJ0VS9TTlZMamxRempCQlhh?=
 =?utf-8?B?aUJ0bERTVm1RUUZuUTE4NStBRzhvU3lWTm9PQ3ZvYk9mMFFibmpDT21ubElK?=
 =?utf-8?B?eGQrY24yNk80c1F2RnNNN21aMWoxVG9lcXg5VE9WSVVOWEJCOVd1S0RCcVNq?=
 =?utf-8?B?QkxNWUV2V0NJNWU4enJMYUlmN2dyMllmOWMvYlRoMklNbDN1dXZlQmRNK0hZ?=
 =?utf-8?B?WEdsSjZsMDIzVC8zTFRMb0VkVmNyUmR2amxKMlVSNE9WWkxEaWluSUhMWDcw?=
 =?utf-8?B?Q29zYXBHQStqQlUzdnRoZ2pFeHlmSkFWbVJKWUg2VFU0ZStIanBZdGx4NnN4?=
 =?utf-8?B?YUxEbEZKS0JGc3RjdnlqbDZJa3NuY2U0OWI5RkJVU1BpYUc3V2dpWW01QmVI?=
 =?utf-8?B?MWF3ZERta0hTVThXWjZ3R05QMGJXWjlvQ2NBREkzZnNpYkErQlo2UUZPall4?=
 =?utf-8?B?YVo1SXgvZjBJbWtvQVFrWlZ1RVZSN2xUYS91a29UWHJvZXpPSWNkZkZrc1ZH?=
 =?utf-8?B?YnJja2NaQzQ2NS93WmtKbStaQTdzVmQyNDdQcmI1RHI5VkZzRk8zWWlvU2g2?=
 =?utf-8?B?MVBXVEpGNmtUQmRWSitWbUZURm4yQVdEekF0L3JKeDlmN3d1ZTJCcExBZHlG?=
 =?utf-8?B?ejZsc2MySWRlTzFQSkRITTJQSFEwbjcvTmNLb2F6Z0J4MHN4azZBTnhLaVUx?=
 =?utf-8?B?K0VGejZ2dEIyaEZST0tXLzJES0J3Vlc4UGpFVEhDUy81Y0JvOUZlTFQ5YXlK?=
 =?utf-8?B?UTlnU2NsRFgxYjNkWmY1eXllNityZWdjK0FVMGtraGU3VmtNSjA5K2wzVEJp?=
 =?utf-8?B?K0JxUk41dU9NcnFiTmlNWkcrSFl1S1puaWNDLzcxOGQrYUFmOEpvUnJFdG1p?=
 =?utf-8?B?QzZ6aEx0a3BKZWJOT0s0dGpiM2J4SkNOZ0JZU2JwazdmUVdXTjRHdWxWNmRi?=
 =?utf-8?B?Z3BuV0NpM1V1bmZCOGlPQkNVc1p0YXpGN1dnd2tIc0JtbXkzZ1Z0WDdpUnZs?=
 =?utf-8?B?NC9CSHMzdmErTDZBVEVYR2VXQVlRbWtWemg3MU9WVnFzejJOeXZyeHp1ZWVm?=
 =?utf-8?Q?Cj6jWQKRA1AqnFCMNADb4yY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0CC81DC7E34D440937FC3CEC9536604@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c79aa-1087-4370-cc04-08dcfd70604d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 08:03:47.3150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XZIASUZRJ611TFDkrIEYQRfkDuW00hucenqcHPj+dekZ2lNsLe29p1FICeYyooN0bJfzZP9KvNqnr+rheNH1AvfRnnxOFZTMc+RWUqayzRy6EIyUpFrsIrn+vXh1M6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8670
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCg0KT24gMDUvMTEvMjAyNCAwODozOCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCj4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgMjozNiBQ
TQ0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGludGVsX2lvbW11OiBBZGQgbWlzc2VkIHNh
bml0eSBjaGVjayBmb3IgMjU2LWJpdA0KPj4gaW52YWxpZGF0aW9uIHF1ZXVlDQo+Pg0KPj4gSSBz
YXcgdGhlIHB1bGwgcmVxdWVzdCwganVzdCBhIGZldyBxdWVzdGlvbnMvY29tbWVudHMgaW4gY2Fz
ZSB0aGVyZSBpcyBhDQo+PiBuZXcgc3Bpbi4NCj4+IFRoZXNlIGFyZSBub3QgaGFyZCByZXF1aXJl
bWVudHMsIHRoZSBjdXJyZW50IHZlcnNpb24gbG9va3MgZ29vZCBhcyB3ZWxsLg0KPj4NCj4+IE9u
IDA0LzExLzIwMjQgMTM6NTUsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMNCj4+IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+PiBBY2NvcmRpbmcgdG8gVlREIHNwZWMsIGEg
MjU2LWJpdCBkZXNjcmlwdG9yIHdpbGwgcmVzdWx0IGluIGFuIGludmFsaWQNCj4+PiBkZXNjcmlw
dG9yIGVycm9yIGlmIHN1Ym1pdHRlZCBpbiBhbiBJUSB0aGF0IGlzIHNldHVwIHRvIHByb3ZpZGUg
aGFyZHdhcmUNCj4+PiB3aXRoIDEyOC1iaXQgZGVzY3JpcHRvcnMgKElRQV9SRUcuRFc9MCkuIE1l
YW53aGlsZSwgdGhlcmUgYXJlIG9sZCBpbnYgZGVzYw0KPj4+IHR5cGVzIChlLmcuIGlvdGxiX2lu
dl9kZXNjKSB0aGF0IGNhbiBiZSBlaXRoZXIgMTI4Yml0cyBvciAyNTZiaXRzLiBJZiBhDQo+Pj4g
MTI4LWJpdCB2ZXJzaW9uIG9mIHRoaXMgZGVzY3JpcHRvciBpcyBzdWJtaXR0ZWQgaW50byBhbiBJ
USB0aGF0IGlzIHNldHVwDQo+Pj4gdG8gcHJvdmlkZSBoYXJkd2FyZSB3aXRoIDI1Ni1iaXQgZGVz
Y3JpcHRvcnMgd2lsbCBhbHNvIHJlc3VsdCBpbiBhbiBpbnZhbGlkDQo+Pj4gZGVzY3JpcHRvciBl
cnJvci4NCj4+Pg0KPj4+IFRoZSAybmQgd2lsbCBiZSBjYXB0dXJlZCBieSB0aGUgdGFpbCByZWdp
c3RlciB1cGRhdGUuIFNvIHdlIG9ubHkgbmVlZCB0bw0KPj4+IGZvY3VzIG9uIHRoZSAxc3QuDQo+
Pj4NCj4+PiBCZWNhdXNlIHRoZSByZXNlcnZlZCBiaXQgY2hlY2sgYmV0d2VlbiBkaWZmZXJlbnQg
dHlwZXMgb2YgaW52YWxpZGF0aW9uIGRlc2MNCj4+PiBhcmUgY29tbW9uLCBzbyBpbnRyb2R1Y2Ug
YSBjb21tb24gZnVuY3Rpb24gdnRkX2ludl9kZXNjX3Jlc2VydmVkX2NoZWNrKCkNCj4+PiB0byBk
byBhbGwgdGhlIGNoZWNrcyBhbmQgcGFzcyB0aGUgZGlmZmVyZW5jZXMgYXMgcGFyYW1ldGVycy4N
Cj4+Pg0KPj4+IFdpdGggdGhpcyBjaGFuZ2UsIG5lZWQgdG8gcmVwbGFjZSBlcnJvcl9yZXBvcnRf
b25jZSgpIGNhbGwgd2l0aCBlcnJvcl9yZXBvcnQoKQ0KPj4+IHRvIGNhdGNoIGRpZmZlcmVudCBj
YWxsIHNpdGVzLiBUaGlzIGlzbid0IGFuIGlzc3VlIGFzIGVycm9yX3JlcG9ydF9vbmNlKCkNCj4+
PiBoZXJlIGlzIG1haW5seSB1c2VkIHRvIGhlbHAgZGVidWcgZ3Vlc3QgZXJyb3IsIGJ1dCBpdCBv
bmx5IGR1bXBzIG9uY2UgaW4NCj4+PiBxZW11IGxpZmUgY3ljbGUgYW5kIGRvZXNuJ3QgaGVscCBt
dWNoLCB3ZSBuZWVkIGVycm9yX3JlcG9ydCgpIGluc3RlYWQuDQo+Pj4NCj4+PiBGaXhlczogYzBj
MWQzNTE4NDliICgiaW50ZWxfaW9tbXU6IGFkZCAyNTYgYml0cyBxaV9kZXNjIHN1cHBvcnQiKQ0K
Pj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+PiAt
LS0NCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMSArDQo+Pj4gICAg
aHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgODAgKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLQ0KPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwg
MjIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gaW5kZXgg
MmY5YmMwMTQ3ZC4uNzVjY2Q1MDFiMCAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+PiBAQCAtMzU2LDYgKzM1Niw3IEBAIHVuaW9uIFZUREludkRlc2Mgew0KPj4+ICAgIHR5cGVk
ZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4+DQo+Pj4gICAgLyogTWFza3MgZm9y
IHN0cnVjdCBWVERJbnZEZXNjICovDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0FMTF9PTkUg
ICAgICAgICAgICAtMVVMTA0KPj4gcy9vbmUvb25lcw0KPj4gQW5kIG1heWJlIH4wdWxsIGlzIGJl
dHRlci4gSXQncyB1cCB0byB5b3UNCj4gT0ssIHdpbGwgZG8gaWYgcmVzcGluLg0KPg0KPj4+ICAg
ICNkZWZpbmUgVlREX0lOVl9ERVNDX1RZUEUodmFsKSAgICAgICAgICAoKCgodmFsKSA+PiA1KSAm
IDB4NzBVTEwpIHwgXA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKCh2YWwpICYgMHhmVUxMKSkNCj4+PiAgICAjZGVmaW5lIFZURF9JTlZfREVTQ19DQyAg
ICAgICAgICAgICAgICAgMHgxIC8qIENvbnRleHQtY2FjaGUgSW52YWxpZGF0ZSBEZXNjICovDQo+
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4+IGluZGV4IDFlY2ZlNDc5NjMuLjJmYzM4NjY0MzMgMTAwNjQ0DQo+Pj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
Pj4gQEAgLTI1MzIsMTUgKzI1MzIsNTEgQEAgc3RhdGljIGJvb2wgdnRkX2dldF9pbnZfZGVzYyhJ
bnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4gICAgICAgIHJldHVybiB0cnVlOw0KPj4+ICAgIH0NCj4+
Pg0KPj4+ICtzdGF0aWMgYm9vbCB2dGRfaW52X2Rlc2NfcmVzZXJ2ZWRfY2hlY2soSW50ZWxJT01N
VVN0YXRlICpzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VlRESW52RGVzYyAqaW52X2Rlc2MsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50NjRfdCBtYXNrWzRdLCBib29sIGR3LA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZnVuY19uYW1lLA0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZGVzY190
eXBlKQ0KPj4+ICt7DQo+Pj4gKyAgICBpZiAocy0+aXFfZHcpIHsNCj4+PiArICAgICAgICBpZiAo
aW52X2Rlc2MtPnZhbFswXSAmIG1hc2tbMF0gfHwgaW52X2Rlc2MtPnZhbFsxXSAmIG1hc2tbMV0g
fHwNCj4+PiArICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFsyXSAmIG1hc2tbMl0gfHwgaW52X2Rl
c2MtPnZhbFszXSAmIG1hc2tbM10pIHsNCj4+PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCIl
czogaW52YWxpZCAlcyBkZXNjIHZhbFszXTogMHglIlBSSXg2NA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgIiB2YWxbMl06IDB4JSJQUkl4NjQiIHZhbFsxXT0weCUiUFJJeDY0DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAiIHZhbFswXT0weCUiUFJJeDY0IiAocmVzZXJ2ZWQg
bm9uemVybykiLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgZnVuY19uYW1lLCBkZXNj
X3R5cGUsIGludl9kZXNjLT52YWxbM10sDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBp
bnZfZGVzYy0+dmFsWzJdLCBpbnZfZGVzYy0+dmFsWzFdLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgaW52X2Rlc2MtPnZhbFswXSk7DQo+Pj4gKyAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9IGVsc2Ugew0KPj4+ICsgICAgICAgIGlmIChk
dykgew0KPj4+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIiVzOiAyNTYtYml0ICVzIGRlc2Mg
aW4gMTI4LWJpdCBpbnZhbGlkYXRpb24gcXVldWUiLA0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgZnVuY19uYW1lLCBkZXNjX3R5cGUpOw0KPj4+ICsgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsNCj4+PiArICAgICAgICBpZiAoaW52X2Rlc2MtPmxv
ICYgbWFza1swXSB8fCBpbnZfZGVzYy0+aGkgJiBtYXNrWzFdKSB7DQo+Pj4gKyAgICAgICAgICAg
IGVycm9yX3JlcG9ydCgiJXM6IGludmFsaWQgJXMgZGVzYzogaGk9JSJQUkl4NjQiLCBsbz0lIlBS
SXg2NA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIiAocmVzZXJ2ZWQgbm9uemVybyki
LCBmdW5jX25hbWUsIGRlc2NfdHlwZSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dl9kZXNjLT5oaSwgaW52X2Rlc2MtPmxvKTsNCj4+PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4+ICsgICAgICAgIH0NCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICByZXR1cm4gdHJ1
ZTsNCj4+PiArfQ0KPj4+ICsNCj4+PiAgICBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc193YWl0X2Rl
c2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjDQo+PiAqaW52X2Rlc2MpDQo+Pj4gICAg
ew0KPj4+IC0gICAgaWYgKChpbnZfZGVzYy0+aGkgJiBWVERfSU5WX0RFU0NfV0FJVF9SU1ZEX0hJ
KSB8fA0KPj4+IC0gICAgICAgIChpbnZfZGVzYy0+bG8gJiBWVERfSU5WX0RFU0NfV0FJVF9SU1ZE
X0xPKSkgew0KPj4+IC0gICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCB3YWl0
IGRlc2M6IGhpPSUiUFJJeDY0IiwgbG89JSJQUkl4NjQNCj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAiIChyZXNlcnZlZCBub256ZXJvKSIsIF9fZnVuY19fLCBpbnZfZGVzYy0+aGksDQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPmxvKTsNCj4+PiArICAgIHVp
bnQ2NF90IG1hc2tbNF0gPSB7VlREX0lOVl9ERVNDX1dBSVRfUlNWRF9MTywNCj4+IFZURF9JTlZf
REVTQ19XQUlUX1JTVkRfSEksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIFZURF9JTlZf
REVTQ19BTExfT05FLCBWVERfSU5WX0RFU0NfQUxMX09ORX07DQo+PiBXaHkgZG9uJ3Qgd2UgZGVj
bGFyZSB0aGUgZnVsbCBtYXNrcyBvdXRzaWRlIG9mIHRoZSBmdW5jdGlvbnMgKGNhbGxlZA0KPj4g
c29tZXRoaW5nIGxpa2UgLi4uX0RXX01BU0spPw0KPiBEbyB5b3UgbWVhbiBtb3ZpbmcgbWFza1s0
XSBvdXQgYXMgYSBzdGF0aWMgYXJyYXk/DQpleGFjdGx5DQo+IElzIC4uLl9EV19NQVNLIHRoZSBh
cnJheSBuYW1lPw0KDQp5ZXMsIGZvciBpbnN0YW5jZQ0KDQo+DQo+Pj4gKw0KPj4+ICsgICAgaWYg
KCF2dGRfaW52X2Rlc2NfcmVzZXJ2ZWRfY2hlY2socywgaW52X2Rlc2MsIG1hc2ssIGZhbHNlLA0K
Pj4gTWF5YmUgdGhlIGR3IGFyZ3VtZW50IHNob3VsZCBiZSBkZWNsYXJlZCB1c2luZyAjZGVmaW5l
IGluIHRoZSBpbnRlcm5hbA0KPj4gaGVhZGVyLg0KPiBJIHNlZSwgbWF5YmUgZGVmaW5lIC4uLl8y
NTZfQklUIGFuZCAuLi5fMTI4X0JJVC4NCj4gQnV0IGEgYm9vbCBpcyBlbm91Z2ggZm9yIHRoZSBw
dXJwb3NlLCB3ZSBqdXN0IHdhbnQgdG8ga25vdyBpZiBpdCdzIDI1NiBiaXQgZGVzYy4NCg0KWWVz
LCB0aGUgcHVycG9zZSBpcyB0byBtYWtlIHRoZSBjYWxsc2l0ZSBtb3JlIHJlYWRhYmxlIGJ5IGFk
ZGluZyANCnNlbWFudGljIHRvIHRoZSBhcmd1bWVudHMNCg0KPg0KPiBUaGFua3MNCj4gWmhlbnpo
b25nDQo=

