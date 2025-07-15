Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F08C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfLC-0006xD-Gp; Tue, 15 Jul 2025 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uben8-0007mV-1B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:29:55 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uben4-00007i-46
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752582586; x=1784118586;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N6rkC9yZBMf25yhPw2JX1pPEaKxyjmF8Am7h1phqPiw=;
 b=G5xf+X7Etj9VUA3sIUJXs4/MIhn7/nr4lMiBSHzfjn36E6qdum8YF218
 TooLRe9930aRfYHVxmuR3MBmOuw1xayg1cXnAs9MGib99mLYfzI+cYBQg
 zTRoO4ZhdM0wo4PVvPiEp6443ONtYnt9C0wOCE8dN8C996U7w0NQy/gdg
 T54w2AH+h11J7OvG7A73fA3uNmU4mVKBaMJVfBIp0+7iq1eyoocEDpkWT
 0woyyNlY3SLYkoApaWG2WnSdvOTCdM9zzabjZGdwk/PgOvWvxLz2GyboJ
 ELovXOsCJwFG8sajE3rwgGawDBx+wt+eLq5F6BoQKOJqXoqt2ahEKLRlN g==;
X-CSE-ConnectionGUID: TBdNT/4PRIOyp7BH2Xs0rA==
X-CSE-MsgGUID: EOKr60jYSaiy0lVIqe4Flw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72251407"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="72251407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 05:29:41 -0700
X-CSE-ConnectionGUID: KKIHseYkQ+W1knvGJ6Rzbg==
X-CSE-MsgGUID: u9wGYE/bToGm5184fbAjVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="157305011"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 05:29:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 05:29:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 05:29:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 05:29:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAevNu7D8gADcK83EKenHk/3zSePkXb+qHLSJgR0xut8MQdpbbynP22pBsFKFdpG26Ez4QDIXK0t0QeSnK15EuAdGUAOxxHErIiBFTBZUUupkR5XZXaAlGaUW5Bud+ncMJM+18Yu5TcVl8ChKtPjs58CcYOdzzdWZNmcWR1oeyqujZrw7owEEgaBVPtCQ0Wge4dAbWfn/h2Sy0B8Qj+yA8fo/Cj4wxpOQnF7lJtKuC1+o9CccOIvlxaCl6hx+P1zG6iExJKhwVSGM2Eh4cVhz+5qaf7gieCxgFAE80Ke8tk2KM1C72wlrIb7nMZGFkGPU8Tbj96vVIDDpaQPus+Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmmqdm3DChgf58Q72XzvF6QrNutamk39aHt4BrEyiNM=;
 b=gyIQHqYnHdTtSoV9fQlLvjQR190HbL3JbppW+lOUvMogIUG3ZljBW2YVO5pjKhSCaJYucWx1XTk4J6yvwO5bKYXmW7idRX0XDSLvHO8sBvVHKyE8QaHAd6y2kos8IzIprKW205GoBA8Iu7V+GNIjf4MuE+g7g5lmn0bRhXG4yf6y9elGbwlSoTf4g9QkzvKiL8jwh+3rpI4ax4hFTFyE28ekKbeCql7GUVirtFvyiqNFidfGakcursIenei6hoOWKbJ2+iV52t8oxJsR6sARxVEVaV8EoZh27DWd3Tsgzc5sIqG8QfNpTMsa0Fe+Rte61klfDFiQP0ngy0pbfuxDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 15 Jul
 2025 12:29:36 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 12:29:36 +0000
Message-ID: <8fe80210-7cf0-4fec-94d4-79b41216a620@intel.com>
Date: Tue, 15 Jul 2025 20:35:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "Konstantin
 Belousov" <kib@kib.kiev.ua>, David Woodhouse <dwmw2@infradead.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Le Tan <tamlokveer@gmail.com>, "jhb@freebsd.org" <jhb@freebsd.org>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ff2957-dade-475f-436c-08ddc39b427c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTMrUTRWb3pqMVZaR21tdHZyZTRoWmJobUVCQjMyQUNqSDY4dnNKd2R2YVk4?=
 =?utf-8?B?MHlTRER3OHRoRVozTTRYNFBQakU5YVJWeW8reHVuTFFQV25ncnErcWtzakRU?=
 =?utf-8?B?ckZoVWxvQjhnZ0E0SWpuVzJtL0JVTjgyOVJQRWg3UGJnZWoxWUp1UENmV2k5?=
 =?utf-8?B?aDZLcXJqUzBxS0JIRGRZdVFaWERJUStDdHJFWU9ZVnY0Yzk3TWxGclRoTXo3?=
 =?utf-8?B?TDJaaXFibHZ2dGE1OWNMbFh3UnJCWmRlS3NLcXF6WThZSFV3eXpoTTYwWWk3?=
 =?utf-8?B?bG1Kdi9Hd2tHYVhnWVZOL05CVm1POUhFSW9VaUo0Umk0bmUzbmdEWlZleEgw?=
 =?utf-8?B?R1pKdEliSzZpK0xQU0VzdWdUZzZ5Rmk1aWdQRkFHUitUaW5SY2V1VzF2QnFn?=
 =?utf-8?B?d3FxZ2VnK1J6d0Z5MEhneW5SZDcxNjl4VFRuQ1laUXRGV1lxb0MrV2JKMlJr?=
 =?utf-8?B?ZDRuRXJUb3Bka3dDZ0ZrNlBJcVhDRVlKOHBMcjZoVlVDOGQzMUVyUTRpVjRi?=
 =?utf-8?B?YnhTWC96K1QyekJoU1J3N01SUkpNTkkyK2VnMXJ2Wkc2QXZwa2NzOVlPaHQw?=
 =?utf-8?B?L24xTjVPL3JDUGNiaS84QzhMbE5NYUxCcWo0b0gzUThieGd5VndqVWRiVXFQ?=
 =?utf-8?B?WnlNeEx3YllCcVI1S29hUjhnT2ZFemRsakd4TjdXdGNjMVBhRk1RcUVqYTBl?=
 =?utf-8?B?VERTTm92T1lTK3JDQTBLdHZPMksrdnppMU5kKzg1bHlKOVQ1MUdpQkRPWmd3?=
 =?utf-8?B?YXQ1Z3lpMkRWMkZvWjNDbDNkblVhSGorbmI1ZjdxckVJOFZoMStFZkM5dTZB?=
 =?utf-8?B?Znd1T2xFL1ZoRjhETGxQUTIveE1hNUQ3TWo4VnhEWXhka0UvN01zSGlaS0tQ?=
 =?utf-8?B?Wm5jMHkrLzhnaWJmRitoOFA5VlV0ZU9tV051Um9sQzkxcGFhS3FmMy9yTEFG?=
 =?utf-8?B?dDdramJoSHNob25UcXY0azl5dGs0MnphdTRISk9oYjlXTiticEFibEI3MklX?=
 =?utf-8?B?L1F0UEU5VVAzQmVINDFRUFhiclJ3cVo5bFlKUFVTUVpmTnBpWnBuS2t1TVg2?=
 =?utf-8?B?Z1VqR1pETUJlWjZmTW9XMUJtaXlKRytlR2NXbnZXV29qMVF1dHRQY0JHNWtU?=
 =?utf-8?B?UzE3V2dFRURnUXRNci9DOXFqeHFTUkRRaGVUbUIxaGNJMUpCSzl3Y1RYeDV0?=
 =?utf-8?B?ekxmeFV1aFhieG5paXR0QTdiSGhSTjZsTUo2QUhuM3RrTy9iTXNGV095RnR5?=
 =?utf-8?B?Y2s3c1RicnF3ZzdScGFWQWovVDVDYUJsekl0WUZjTTVJbjM1L2htR0dTS0V0?=
 =?utf-8?B?YWsxeUJ6MTZ3cmhuNThLRHNTL0xRY3dGQWVCZ25Ed1dqSnIvWTJZM01zSytP?=
 =?utf-8?B?cVEwK3RrNlMyZGZnb3k2YW5rWEhoSFV6VlU0TVd6MVc0T25NV3hTVmdhdmc2?=
 =?utf-8?B?NGx1c0ZjY0kzVXBLMWdOc0lEK1ExRDltS29kK1V4SElFTlo0ZHhVL0UwMFI5?=
 =?utf-8?B?cG9MNE4xd0xMcDBlVDBoYVhxT0FrRzMrZHNTWFJCbEJaVTVUVkVFN0VSVHB5?=
 =?utf-8?B?L3lJOGFDYnYzaDZVZVJXYVdWQ2dxNUdKa3NPNXJ6R2RrQUUxdklkQ3ZvUDBV?=
 =?utf-8?B?ZDlRWFNYaFVXMGF4K3NWdzVXMWpSd01RWnNWSWNVc3JJb3BwM0pmZGtxUUk2?=
 =?utf-8?B?L095eXlVZjJKMG9hc0xWbmlKaEQ2eGgveUpwK1pKQTVOMCt2bWRGQU4wWi9Q?=
 =?utf-8?B?aC90bzIvUjNBOE5pd2pwWFpjRjhEWE1XRGV4U3k1WGxFOXIwYktFcVdIUk1L?=
 =?utf-8?B?TUVJZjN1WlZjUkJRTmFUQjRsbEludVJrS0ZoZHRKQ3ZDNUZ3QkZJYi9FS3U4?=
 =?utf-8?B?M2tZRHllM0gvdDRZdjVTNkNTYWptUms2Y1phOW9PdXZzczBST3cwSkdBZ3k5?=
 =?utf-8?Q?N6U/lCcdlQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG4rb3BoVm1YelRiM3RVRWRqYXB0QVdDTGt0OHBZaXV5eUNCSlBtMmd6a0Y0?=
 =?utf-8?B?T1prWldYOFNWWjlpUEo0M1pNL0lzS0pQMzJ0Y1VwNHVaVmpyTm1NYzZobmJj?=
 =?utf-8?B?VkZ4ZGw0YzRMVEF3d1lTT3Fpdi9oQUIyZytFWDJKemRBcTlDN05XWlNySFBm?=
 =?utf-8?B?MGRuUGVWOXMveVZZVC91NkMxZDd1Y0pnM01pZEdDRHpYMlhxMGVyOHk0c3Rt?=
 =?utf-8?B?bHA0V0R5MHQyQ1JPRS9zWVJNODd1RmsvL0NHNHhrWWtJY1M4YjM0dTZWRmM0?=
 =?utf-8?B?VmxrNDlkNFMzUlpoK2dVS1BwQWw1azFHV2NTUk9WdEpVN0g4QUhSUnZMcVlu?=
 =?utf-8?B?bFlUZ1JmOEJJUzhZeVpINjNXYnFUYlhRSzVxTkxKR1V4ejE4WVp6SmZDcGpz?=
 =?utf-8?B?QXpyTHBHN0N5ZlZLU2NaVzdnZ0RBa09SelZzMUhqVUVWOTByeXZNUDJzQjhN?=
 =?utf-8?B?V1pVTzY5cjNaU2RhV0poYlBSSzltM2p4dHBEWFZUOTEwTW9jV1pUcHhBQUxJ?=
 =?utf-8?B?OXJWcG9HeXA0Z2RuaVkrOS9vWDloakt0dzNrL2dmejBNZ042VzBlQ2hRWWti?=
 =?utf-8?B?NTNpblFYNnM0ZVZSRyt6T1RSbE1Rb1JEVVlvaURvVWdaMVhzQ0IvUGtac0p6?=
 =?utf-8?B?SmZ1ckZlajRxeWQranVTMjRhSlllazZwQnFYS3BvQStjY3loUnF3RUJkdnBV?=
 =?utf-8?B?YXMyTTBTSGFMcGRQbmlWR2xMUGRHdXkwZ2JsWEpZbXRuMTRoQlRudVFTMVJY?=
 =?utf-8?B?bXg4Z3NaNkUyUkhnV2ZmbjJDd3QyYTliTU5nMWRIVHk1akRQQUNtU3ZYZ1JR?=
 =?utf-8?B?ZktGamRRZjN5NEk3Z1kyY2VBNVROaXEwczhjNUVSYU53M0UvRmZ4ZFBQdFVm?=
 =?utf-8?B?ckZYL0F1RWRxNGdzdGlvajBTM0ppNFlaK1N2T3p0SHJlQ1dyQjA2OGFCOVFF?=
 =?utf-8?B?bWxEdVZuTnZ5N2NpVU9ZZDJBUmI1OEhRU1VLSFY2QlR5dVFmUFZ6RU9QbjBV?=
 =?utf-8?B?bEozMUtmVHM3YitsajN4ektYWTE0TmdXSmNSNmJIcTlscE9scEFtVlZxZzhy?=
 =?utf-8?B?RGtqZTA5Q3AxeG95dDBiU1hmazVjZEtNeUJ1ak44UGliSVkzYjBYVHBUSnBH?=
 =?utf-8?B?ZFFyK1FMbTI4SUFaREdiTFkxMFFzcWl5bnRTTFN1L0phY3RVWjNPQlJaT21C?=
 =?utf-8?B?REtXdEtCckRDN3RQenREMk9PaFRRZWlqV0VZbS94TmYwVzJmeE52SFhLeTha?=
 =?utf-8?B?em1hVTRqTkFkdzhjL3REejV0WjRKaS9xTE9VVnJ5UFFkSFBWN1lUMUF4cWdN?=
 =?utf-8?B?TW43MFFtQkRpVDZ2Mnd2Um8zeXJjSzZkWmxFOHRublNNR1NEV0psNHp2Vk5L?=
 =?utf-8?B?MUIrMDd1d0xuMW1yN0lwb05XNVhmb1QrQXpJRTFIWmtSU2FsS0FkczdUcUZ3?=
 =?utf-8?B?K3dxaHFjQ3dQYWJiQlFuRHlZNmM5WElyamorcE93byszNU5hVG5LVndveEZQ?=
 =?utf-8?B?c1hzZ01PbmUwUzJjMkR4dnhHSVRhMnQ5ZGtyY0dyQ003cjFvR1B0V0JkVXZr?=
 =?utf-8?B?VlRqZDBFTkZzN0RFTlE1U3ZPU2JmYWo4S0ZwQXNrNm5CdTJaZG9ocUV4QzA5?=
 =?utf-8?B?ZTVtL3pSREJOQk5hTEdQaWEyelNMOGlmTFk5dEllOVB6a1Q2QW9qT1NuMWJ5?=
 =?utf-8?B?aUJ0aVkwNXhCVncyR1NsTlNQTm93SlZqMVIxcWpZT3NqSzhhYWY4eC9lT081?=
 =?utf-8?B?WnFOMEw5WU9NRG4xNHNhZGZwTi90eW50SWc5WGpUV1g4Z2l0eThqVjhsVk9H?=
 =?utf-8?B?Um91MWRoaUFmQXdhR0NSWCtIVUd6RHo5cnZ3SjlXTG5NdGl2eS9hQ0sxKzJD?=
 =?utf-8?B?MmxtUU1mMU9FbkNYZjRPMElqUmFVd3Y0MStUaEpWc1hkUDFReSszZUR2cHhv?=
 =?utf-8?B?SU1FSVcyVEhVY09BRVRSV21yeHhLN0NZMGdieVY3ckxTTm9jdUx5aEFxM1ln?=
 =?utf-8?B?Z1Q1K0pNYWNMdjI2OWdyNnY1cUswM2F2a2R4UHZxVFVFSWxZNFBYMXlIV3BN?=
 =?utf-8?B?SnNZU29nL2hvTUlpZmpRSFdXUUVKdkc4MldXR1dRdmRwdGpMT2dXL3JtN3U2?=
 =?utf-8?Q?DmsclqYj+igQg4MSufuJdJi1W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ff2957-dade-475f-436c-08ddc39b427c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:29:36.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtcBJ2uUBMM2hfg02BU0nGAffiS7Pvwiz1zIGzrXZOgo9C3wg4leD2ts5221o0RuiWqQFqo8+TD/8MVF84QHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
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

On 2025/7/15 14:11, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 14/07/2025 11:22 pm, Konstantin Belousov wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> On Mon, Jul 14, 2025 at 05:41:22PM +0100, David Woodhouse wrote:
>>> On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi.l.liu@intel.com> wrote:
>>>> Hi David,
>>>>
>>>> On 2025/7/14 16:00, David Woodhouse wrote:
>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>
>>>>> FreeBSD does both, and this appears to be perfectly valid. The VT-d
>>>>> spec even talks about the ordering (the status write should be done
>>>>> first, unsurprisingly).
> 
> Are you talking about the ordering constraint mentioned in bullet
> "Page-request Drain (PD)"?

David is talking about the IF and SW flags. And he is correct. Spec has 
below sentence. It means a wait descriptor can have both IF and SW set
and indeed completion interrupt happens later than status write.  Let's
go on refine the patch. :)

"The invalidation completion event interrupt must push any in-flight 
invalidation completion status
writes, including status writes that may have originated from the same 
inv_wait_dsc for which the interrupt was generated."


Regards,
Yi Liu

