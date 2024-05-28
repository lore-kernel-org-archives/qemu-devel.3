Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05EDC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBx0W-0007AE-Mb; Tue, 28 May 2024 09:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sBx0S-00076v-Vb
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:36:49 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sBx0Q-0001bT-8L
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716903406; x=1748439406;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ERX40Bu5vcwG6t8jdG2Qk/RB9HW6PTgBaumEFNHe5gA=;
 b=F5QuT3X1yu+Dzc0LMVmwDG4xz/afthO77czaxowcEEe3h5gPDLTXeGyD
 rI5QlW3ACu1pG2JCRVtHJj5sCuH6WGpmVUz7u/Lrwr/un5XTS+Wvnmrfx
 fdXL2Mj5UgYoPh8eveg3sEXd6SS2HIW9U3AGFEZWNh0MCYCA3IG0+MIYr
 nOpJB9oOAfj+drXsekBtn90wjKh+VQDO8c/cVk2rzQ+5VonvBQ9sgpHg3
 CdRPGUh0PWi43yeqWHXiVrYE/3RDpMaafskYVuscsIj+0sazIMbs0G3P6
 28yvsSVc2u/vAyczNagn1dcV15/35yNSUnFvUVyDnSfrsKbHiSJTg3ISz g==;
X-CSE-ConnectionGUID: vEM9GeZEQb6Wn36EfwXXcA==
X-CSE-MsgGUID: FEOjVuyOSNODIhka4QAJ0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="35762448"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; d="scan'208";a="35762448"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 06:36:42 -0700
X-CSE-ConnectionGUID: BnOeqXnJTkykfla9tHeQ8g==
X-CSE-MsgGUID: jfOE/f5QQvmugEcKl+a+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; d="scan'208";a="35155995"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 May 2024 06:36:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 06:36:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 06:36:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 06:36:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 06:36:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7uHQ2fbIPTe7SfOCfD+qYLf7xIs0sHiZf0jNn8+y19TGYzsPwjuk2YKVsz064Y0HuBEWI1NFJd/iRdwFfvHqh4OWlUF9sSKoGjy3xAUdDqIBvjHd/7HKhYsGFSWZ/tIZdBApbDv3d3arQig8ytYs+S72yHAZb3NPHUu0iKwIlNMd/my7//dU6Xi2EEoEBDicTb2FzI6PppJuuDQdsjWoXgoM9RZenRzKjp39Y2mDEHC5dZJVNuV8aq/NWWHWb8DHLKVnKIyI7Rh4vH7ezEu+fDCfbhhr/6wj+F1FjC81e+7A7VW+CyFDtzBGJU08ejZ3sjLVVslDt96c7CnxelBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERX40Bu5vcwG6t8jdG2Qk/RB9HW6PTgBaumEFNHe5gA=;
 b=hOX29okpW5jR49GwHorSrmmnqqvHABLkWeCqe7SxttVBlinBDTgGd9euIHTzsaFPvzdNkApsA0111cSDzrLe7MtGXdpVGOrNCLo7S8WA2G+qgeV9us4IOEDSMC/8xlwx8RybBXREA/hY3QI1+mBCMufZhcMvng/m9+ux5prvv/vMgu0er8Bv6VO9d5mqeqsXyyDNtcaHUXgo3P8utEIrbZ50OkeBiQ2QZ5VJaJoLZYWrjmpEsRphqWupsy+G+FLRmSzxks4pFD6ymeXyvFKkkMZYk4btS7Fldkk7H0K74e0VzzctaRBopdaESFbwTMPEm7U3sOCgEJameTlo3BlyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 13:36:38 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 13:36:38 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 2/7] migration/multifd: put IOV initialization into
 compression method
Thread-Topic: [PATCH v6 2/7] migration/multifd: put IOV initialization into
 compression method
Thread-Index: AQHan5HPW04fKO9LEEKzfw8DnoEMs7Grr/4AgADCoUA=
Date: Tue, 28 May 2024 13:36:38 +0000
Message-ID: <PH7PR11MB5941D090A40858C20DF9AED2A3F12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-3-yuan1.liu@intel.com> <ZlTyLrRrSYkHjutG@x1n>
In-Reply-To: <ZlTyLrRrSYkHjutG@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA3PR11MB8047:EE_
x-ms-office365-filtering-correlation-id: 34f539fa-11b7-454d-6ade-08dc7f1b33bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ODFodTd6bEE0QzVMUmdZNURMcDg5USsxQUk3WWxFQTRCdEd5dUlpT0E1K1dR?=
 =?utf-8?B?VDQwUjJCVHFrUjUxZnVWQnJHdlJ5bUpUYmlhNlQzeitsajcwNi9XdUxPY1RW?=
 =?utf-8?B?Q0NRNnZ6b1pPYVJOZDRBa1ZTY0ZJR3BtTnlQSTdrZ2FPanlEdmU2ZTJIOU83?=
 =?utf-8?B?K283M3JpTkVOUGJkQkN4YnZEZ1NaUE1Gc0JlUTkzTlpQVjFldnZsYmVScnBL?=
 =?utf-8?B?NXFzVVdoU3BMSFNmZHZKMnVOaTI5MHNLUEZwUllyQ3JsbDJ4TEZGZUxVdjNF?=
 =?utf-8?B?d0xFbWVmeEVTbTV4UzNJdFNyeEhRdXNBOXFHVVJnREhZV3F2ZHVhZG00L1R2?=
 =?utf-8?B?YzhleE5jUWFPWW91aG16N2lyUi8wZ3g3cEpXQXFCaVBRYUM1bzB5YlgreW5a?=
 =?utf-8?B?VDBhOWdCaEFvQ1hvOHY4b3lUSmJja2U2VVBscSs5SVVaVEY0VW5ORmJNUTBN?=
 =?utf-8?B?clRNN0MrYm9PdGhLK2tBTFNYMzkwYnhXaXhhbzBOSnZvU21TaWUxUWx4MjlD?=
 =?utf-8?B?enVQd1h4SmJsVGFtYStCOS93VGtBOTYxY3QwMUR6S1VpSi9uMGVKcElNc3Ew?=
 =?utf-8?B?ZWxuSFlmZjgwYzFDRjYyayt2V0VETVRDVTIvWHhZNmswYUVtSHhVSU11NGFs?=
 =?utf-8?B?bDhON0RLMExmc0NvRUhRdnpRWTg5TnJoYXRpb1RidGw0dFZQYWtsNEdkRkxv?=
 =?utf-8?B?VktQOG1BQzFMUytidXZKRERXTnFVekRHd0lTRjk5WWhWazI3UEpURkZIUVQz?=
 =?utf-8?B?L0lFdEo2cFl4bHRVV2Q0eHo2ejZUNTUzTWFYa0QvaVArYktDdXZRdElmcVp1?=
 =?utf-8?B?VlVyTUdMY2xFQWVtVjNlNEMyUkEyU1lTZ3FNQ3U5Y0dFaEZVMndxTzROaDRu?=
 =?utf-8?B?Wk42RFVlNVpLVXU1WWcyK2FLblRwU01wb0Y5bzJPcUpIWXJUU3FKZ3dlazJF?=
 =?utf-8?B?NWxuTHZ4WG1WYUpoa1UyTHNGUFBRaWFnSXY3c1g4Wmd5bGdxYlk3Sk1YaDUv?=
 =?utf-8?B?WGFadmRTOTB4K28ycFIzYTBxZkNHN01aWWNod0lWVTdKMXEzTmtyQ2h4RGRM?=
 =?utf-8?B?UElabzRpbHBReGE5VHErMEphNk1MeTN5QVpvVElFVEVRK2drTS9BTmcrTWdG?=
 =?utf-8?B?cVBFZndnSFFMZDlJVXlRN1E0ck14b1pjSmh4WUt6YzZrZ0tqWnVrdFdwNkoz?=
 =?utf-8?B?QWxlWUN2YUVNZlFoYVBMd1doeTd5eVpVRXdHQXNzOW9kRmJmYWZJbVo0L0xT?=
 =?utf-8?B?OENBcUZYVEkrOXNLRlZoY3VrTDVlYU9PWExKejg2VVF0eW5FM3kzNVdXOG9r?=
 =?utf-8?B?VjFvM3ZBcTFqcVZKR0pxd2ZSUWlXWTcyL2NpcEM4MUlFYXVtYytVUmRkUUh4?=
 =?utf-8?B?SnY0eUdacHlVWnRrdGFJdXkwcjVWNmhTMjhQbUNhbjl5c3NPQUdDK0FMOHM2?=
 =?utf-8?B?cjNCRFBiN2NJTnhCUmxZSUwxYUlhVHNkZC84aXVZb2lwK1VKcGhNQXk4SHpJ?=
 =?utf-8?B?Njk0d0ZtZzQ1WktzeHVYNFZ5dE5hd3ZmbjVaenNFcE5udTlPKzdWbThUSjNy?=
 =?utf-8?B?Rnpqc1RpVUpuSU5HUnNmOW9vQndReDFtaU5yNnVleFlVMGRmRTNXMlJBUUx2?=
 =?utf-8?B?ZklJZ29IMCs2TXlscHVwaWFpSGFIWmd4YU1tMFJVV1dWY2dYazIxTUVsSnlX?=
 =?utf-8?B?V085QmVJbGF3ZmhGOGs4OVY0MXV1R0Zrdk9CRnZwSGhqdVFIWFRhTVZRL3kw?=
 =?utf-8?B?Skh3eS9wTVYrUWtqQU15NEJzcVJZVzhTdHREVER6MEdDallZZUdndW0vTzhK?=
 =?utf-8?B?MXoxbHRzandYQ0lLZUJCZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDA0aGZsSkN1Z0VnaE9nM3d2eERoTFYyUUFoU0FiTjBwZGFSaFNRdENuRUV1?=
 =?utf-8?B?aktMK2RKcHg4bzROWDFaV1JyZGI5ZTkwT2xySGJCZ21tM1VpYlB6VDlscTRv?=
 =?utf-8?B?cjRVMlkzcGg1VXdsYldPRG91MXBrV0xiZXdQbjlFREJ3OWl4aGpESG1lRVhm?=
 =?utf-8?B?cU5oZnA3blRvOXhRNUNwcGlqZ0F6M3Qwd00rdU5HVUtUMTZmUDJ3Z2MvY1pD?=
 =?utf-8?B?a2lINFNteGpIbnlwNUFWWGlDdGw0b1lyQkgzNXdkMFVxaTlzOTFyQ3orWHhw?=
 =?utf-8?B?YmluTHJFVENSbkdGUm1EdlV3d1poWnlLS1k2UFFvM0szeWhVT2x2a2YxT3BC?=
 =?utf-8?B?b2dIRCt4ZFVxOTJzajhCUGFqNzBTSlVRand6NjFkRXFnMkpkWjhoMFM1RFZa?=
 =?utf-8?B?eXVjR0JOT0RQamxPVXdtd0NQTWpUWU42WlFzZWJFTFk4ajdyY2V3bm5aVkp3?=
 =?utf-8?B?Q3BzaEFwU21TQ2xib010UWw5MzU4TkxrK3B1cW53VHVqUlU2Vndzb0RpSXlM?=
 =?utf-8?B?ZzJlaCtKYWFPUTdFaHhnSkN0SjJFbVhPTVJZQTV3S0xHMHA3TUlsbDFNTFBB?=
 =?utf-8?B?Z0swZmNBSEl3RUlXMnhCQmRteVBaRnI3cFpDMncrekd5SXpXNXJ1eTFEdmov?=
 =?utf-8?B?c3d1TFJxOE9BQUVIc09Ca2lsd3kxWnR1Y2paVk9takNZMk9IRzV2cGR2Zjd5?=
 =?utf-8?B?OGhpcFlIR3hjYWxtakwxMVB4VnFPRVZHR2VIWWVKYmU5K2E0L0k1Mm1xbXd0?=
 =?utf-8?B?Zkp5WnZlNFA5czBpaHZ1UlJRNm1UanpsY2pkVzJOL0RoYktTMUlRMGVIZjhw?=
 =?utf-8?B?VHlUTFl4V05TRzVvTnpGMG56QW1RaVVPaGg0Y2t1bjNRcHpibG1Pc21IVFhr?=
 =?utf-8?B?dDZoa1FFNmxBUFFsVWpOMGhPVUxsaThSenQzUks5Mnh2RVdKeWQrV0N3OERi?=
 =?utf-8?B?R09lWGhnMUdVbXdJZWY5ak5IdWx5SS9YM0Q3UDhjU08ydnV1eWV4VXNwK3pQ?=
 =?utf-8?B?dFBNRnJ3WEhjWk9NNTZnZmlHRGMwRDJNMTBlRmFSWXNyditwM1RKNENyWDFq?=
 =?utf-8?B?WTByVEFtZFE1dUhUSzBxMEtWQmpHYWUwR04vdDlLS1BaR1JBNHFIQ25RU3FT?=
 =?utf-8?B?UXcvUEk4NHNnZHRaaFEvTFBZenVaMTgrWFFjWHlDUHJqQjVVdTd2RnQ2UGg5?=
 =?utf-8?B?TXBCVG1qZFo0dFRNWWhiZkJEQ1h5Yjd2aHlkSzh4Ujcxcnd3OGVyRDFYTFlD?=
 =?utf-8?B?OEVIeE1LMERpT2x5QzBxSkhhYWVrd2pqb3N4UnJqSkIxZWtjR05WbWpCZ0NQ?=
 =?utf-8?B?REMySlNQblkxWlNBeFhtNHh0MzFKSDlHM0Noc2lId2JKREpybDQxNW5VM3Ra?=
 =?utf-8?B?SDhsV05JV25Zcys5T1J3N3pBSTFyVk5yRks1VWJQczBvTlQ2QjRuUyswb01S?=
 =?utf-8?B?cVFJVzdZZ0hpbnFCT3RXQ24zQUptZDFNRUd4OW80T1ZTUW9VbXJKbjIvdjB4?=
 =?utf-8?B?bzFtREk5QjNicHJCcFFSSzhycTRFcTVSS3Qrdkk5RTZhU1hvSzJxRm1NU1JT?=
 =?utf-8?B?T2hsNjhuUGpldHNvSVp4VmNhUVZMMnN2alR4NThQNkJCckMreWQ0Q0FFQ0RJ?=
 =?utf-8?B?NVZUQTl5TThtV2UrdWxYdklzOUZxRjRqUTVyWjQ5dUUyQXRuV0VoMHdNcGJE?=
 =?utf-8?B?L09Td2RsSUNtdDBGcXdaaS9Ha2Y2ZENVYjg0bzFhY2NObWFVSHRhOUJUUWc1?=
 =?utf-8?B?QUFGSDV5VmdJQVBxcHUrSk4vY0c5TFFSbkJhRU9BMkNvQ1ZDeS9SUmZJRVRG?=
 =?utf-8?B?b3lkSTB5TS9SUXBVcWtYTDFxVHdlMThOR0dNYm1aUndJVngwRS9zaVlrY05L?=
 =?utf-8?B?dW1uYmVsKzRhV2VXNnhwNkZyUkp4WWxLQmExdUVRdlQwY1ovTkQrTm45UHYx?=
 =?utf-8?B?UWJIRmVUUy9RQ1pCT2VGT2hoanYrQXVIU1UzV3ZQNjBZZW5iRHNtc0xtbWI4?=
 =?utf-8?B?anQyZVN6dmdoejk4RVpSUDdFdWRtL0F1QXRyeHB1WHFJbGdwbmtQeUFrYTFx?=
 =?utf-8?B?TnVucDFCbTQyOGlFbGdpdU1UdFJBMjMzQkNJMHl6R0lhbEljSmVOejhPVHZv?=
 =?utf-8?Q?Ys4I8fXUFzdDIDJdZbxmEA8mO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f539fa-11b7-454d-6ade-08dc7f1b33bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 13:36:38.8257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fCAEupDTjVxxvbPv9y3QnwVDtRHmtv0LfBOK/kbzPW0SIc0yl1kam+WNfbxLGVOr1G45AM6vtEDL7koWeHKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAyNCA0OjUxIEFNDQo+IFRvOiBM
aXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogZmFyb3Nhc0BzdXNlLmRlOyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IFpvdSwgTmFuaGFpDQo+IDxuYW5oYWkuem91QGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzddIG1pZ3JhdGlvbi9tdWx0aWZkOiBwdXQg
SU9WIGluaXRpYWxpemF0aW9uIGludG8NCj4gY29tcHJlc3Npb24gbWV0aG9kDQo+IA0KPiBPbiBN
b24sIE1heSAwNiwgMjAyNCBhdCAxMjo1Nzo0NkFNICswODAwLCBZdWFuIExpdSB3cm90ZToNCj4g
PiBEaWZmZXJlbnQgY29tcHJlc3Npb24gbWV0aG9kcyBtYXkgcmVxdWlyZSBkaWZmZXJlbnQgbnVt
YmVycyBvZiBJT1ZzLg0KPiA+IEJhc2VkIG9uIHN0cmVhbWluZyBjb21wcmVzc2lvbiBvZiB6bGli
IGFuZCB6c3RkLCBhbGwgcGFnZXMgd2lsbCBiZQ0KPiA+IGNvbXByZXNzZWQgdG8gYSBkYXRhIGJs
b2NrLCBzbyB0d28gSU9WcyBhcmUgbmVlZGVkIGZvciBwYWNrZXQgaGVhZGVyDQo+ID4gYW5kIGNv
bXByZXNzZWQgZGF0YSBibG9jay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1YW4gTGl1IDx5
dWFuMS5saXVAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBOYW5oYWkgWm91IDxuYW5oYWku
em91QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbWlncmF0aW9uL211bHRpZmQtemxpYi5jIHwg
IDcgKysrKysrKw0KPiA+ICBtaWdyYXRpb24vbXVsdGlmZC16c3RkLmMgfCAgOCArKysrKysrLQ0K
PiA+ICBtaWdyYXRpb24vbXVsdGlmZC5jICAgICAgfCAyMiArKysrKysrKysrKystLS0tLS0tLS0t
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL211bHRpZmQtemxpYi5jIGIvbWlncmF0
aW9uL211bHRpZmQtemxpYi5jDQo+ID4gaW5kZXggNzM3YTk2NDVkMi4uMmNlZDY5NDg3ZSAxMDA2
NDQNCj4gPiAtLS0gYS9taWdyYXRpb24vbXVsdGlmZC16bGliLmMNCj4gPiArKysgYi9taWdyYXRp
b24vbXVsdGlmZC16bGliLmMNCj4gPiBAQCAtNzAsNiArNzAsMTAgQEAgc3RhdGljIGludCB6bGli
X3NlbmRfc2V0dXAoTXVsdGlGRFNlbmRQYXJhbXMgKnAsDQo+IEVycm9yICoqZXJycCkNCj4gPiAg
ICAgICAgICBnb3RvIGVycl9mcmVlX3pidWZmOw0KPiA+ICAgICAgfQ0KPiA+ICAgICAgcC0+Y29t
cHJlc3NfZGF0YSA9IHo7DQo+ID4gKw0KPiA+ICsgICAgLyogTmVlZHMgMiBJT1ZzLCBvbmUgZm9y
IHBhY2tldCBoZWFkZXIgYW5kIG9uZSBmb3IgY29tcHJlc3NlZCBkYXRhDQo+ICovDQo+ID4gKyAg
ICBwLT5pb3YgPSBnX25ldzAoc3RydWN0IGlvdmVjLCAyKTsNCj4gPiArDQo+ID4gICAgICByZXR1
cm4gMDsNCj4gPg0KPiA+ICBlcnJfZnJlZV96YnVmZjoNCj4gPiBAQCAtMTAxLDYgKzEwNSw5IEBA
IHN0YXRpYyB2b2lkIHpsaWJfc2VuZF9jbGVhbnVwKE11bHRpRkRTZW5kUGFyYW1zICpwLA0KPiBF
cnJvciAqKmVycnApDQo+ID4gICAgICB6LT5idWYgPSBOVUxMOw0KPiA+ICAgICAgZ19mcmVlKHAt
PmNvbXByZXNzX2RhdGEpOw0KPiA+ICAgICAgcC0+Y29tcHJlc3NfZGF0YSA9IE5VTEw7DQo+ID4g
Kw0KPiA+ICsgICAgZ19mcmVlKHAtPmlvdik7DQo+ID4gKyAgICBwLT5pb3YgPSBOVUxMOw0KPiA+
ICB9DQo+ID4NCj4gPiAgLyoqDQo+ID4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9tdWx0aWZkLXpz
dGQuYyBiL21pZ3JhdGlvbi9tdWx0aWZkLXpzdGQuYw0KPiA+IGluZGV4IDI1Njg1OGRmMGEuLmNh
MTdiN2UzMTAgMTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL211bHRpZmQtenN0ZC5jDQo+ID4g
KysrIGIvbWlncmF0aW9uL211bHRpZmQtenN0ZC5jDQo+ID4gQEAgLTUyLDcgKzUyLDYgQEAgc3Rh
dGljIGludCB6c3RkX3NlbmRfc2V0dXAoTXVsdGlGRFNlbmRQYXJhbXMgKnAsIEVycm9yDQo+ICoq
ZXJycCkNCj4gPiAgICAgIHN0cnVjdCB6c3RkX2RhdGEgKnogPSBnX25ldzAoc3RydWN0IHpzdGRf
ZGF0YSwgMSk7DQo+ID4gICAgICBpbnQgcmVzOw0KPiA+DQo+ID4gLSAgICBwLT5jb21wcmVzc19k
YXRhID0gejsNCj4gPiAgICAgIHotPnpjcyA9IFpTVERfY3JlYXRlQ1N0cmVhbSgpOw0KPiA+ICAg
ICAgaWYgKCF6LT56Y3MpIHsNCj4gPiAgICAgICAgICBnX2ZyZWUoeik7DQo+ID4gQEAgLTc3LDYg
Kzc2LDEwIEBAIHN0YXRpYyBpbnQgenN0ZF9zZW5kX3NldHVwKE11bHRpRkRTZW5kUGFyYW1zICpw
LA0KPiBFcnJvciAqKmVycnApDQo+ID4gICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAibXVsdGlm
ZCAldTogb3V0IG9mIG1lbW9yeSBmb3IgemJ1ZmYiLCBwLT5pZCk7DQo+ID4gICAgICAgICAgcmV0
dXJuIC0xOw0KPiA+ICAgICAgfQ0KPiA+ICsgICAgcC0+Y29tcHJlc3NfZGF0YSA9IHo7DQo+ID4g
Kw0KPiA+ICsgICAgLyogTmVlZHMgMiBJT1ZzLCBvbmUgZm9yIHBhY2tldCBoZWFkZXIgYW5kIG9u
ZSBmb3IgY29tcHJlc3NlZCBkYXRhDQo+ICovDQo+ID4gKyAgICBwLT5pb3YgPSBnX25ldzAoc3Ry
dWN0IGlvdmVjLCAyKTsNCj4gPiAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAt
OTgsNiArMTAxLDkgQEAgc3RhdGljIHZvaWQgenN0ZF9zZW5kX2NsZWFudXAoTXVsdGlGRFNlbmRQ
YXJhbXMgKnAsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgIHotPnpidWZmID0gTlVMTDsNCj4g
PiAgICAgIGdfZnJlZShwLT5jb21wcmVzc19kYXRhKTsNCj4gPiAgICAgIHAtPmNvbXByZXNzX2Rh
dGEgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgIGdfZnJlZShwLT5pb3YpOw0KPiA+ICsgICAgcC0+
aW92ID0gTlVMTDsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+IGRpZmYgLS1naXQgYS9taWdy
YXRpb24vbXVsdGlmZC5jIGIvbWlncmF0aW9uL211bHRpZmQuYw0KPiA+IGluZGV4IGYzMTdiZmYw
NzcuLmQ4Mjg4NWZkYmIgMTAwNjQ0DQo+ID4gLS0tIGEvbWlncmF0aW9uL211bHRpZmQuYw0KPiA+
ICsrKyBiL21pZ3JhdGlvbi9tdWx0aWZkLmMNCj4gPiBAQCAtMTM3LDYgKzEzNywxMyBAQCBzdGF0
aWMgaW50IG5vY29tcF9zZW5kX3NldHVwKE11bHRpRkRTZW5kUGFyYW1zICpwLA0KPiBFcnJvciAq
KmVycnApDQo+ID4gICAgICAgICAgcC0+d3JpdGVfZmxhZ3MgfD0gUUlPX0NIQU5ORUxfV1JJVEVf
RkxBR19aRVJPX0NPUFk7DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIGlmIChtdWx0aWZkX3Vz
ZV9wYWNrZXRzKCkpIHsNCj4gPiArICAgICAgICAvKiBXZSBuZWVkIG9uZSBleHRyYSBwbGFjZSBm
b3IgdGhlIHBhY2tldCBoZWFkZXIgKi8NCj4gPiArICAgICAgICBwLT5pb3YgPSBnX25ldzAoc3Ry
dWN0IGlvdmVjLCBwLT5wYWdlX2NvdW50ICsgMSk7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsg
ICAgICAgIHAtPmlvdiA9IGdfbmV3MChzdHJ1Y3QgaW92ZWMsIHAtPnBhZ2VfY291bnQpOw0KPiA+
ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAt
MTUwLDYgKzE1Nyw4IEBAIHN0YXRpYyBpbnQgbm9jb21wX3NlbmRfc2V0dXAoTXVsdGlGRFNlbmRQ
YXJhbXMgKnAsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICovDQo+ID4gIHN0YXRpYyB2b2lkIG5v
Y29tcF9zZW5kX2NsZWFudXAoTXVsdGlGRFNlbmRQYXJhbXMgKnAsIEVycm9yICoqZXJycCkNCj4g
PiAgew0KPiA+ICsgICAgZ19mcmVlKHAtPmlvdik7DQo+ID4gKyAgICBwLT5pb3YgPSBOVUxMOw0K
PiA+ICAgICAgcmV0dXJuOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMjI4LDYgKzIzNyw3IEBAIHN0
YXRpYyBpbnQgbm9jb21wX3NlbmRfcHJlcGFyZShNdWx0aUZEU2VuZFBhcmFtcyAqcCwNCj4gRXJy
b3IgKiplcnJwKQ0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIGludCBub2NvbXBfcmVjdl9zZXR1cChN
dWx0aUZEUmVjdlBhcmFtcyAqcCwgRXJyb3IgKiplcnJwKQ0KPiA+ICB7DQo+ID4gKyAgICBwLT5p
b3YgPSBnX25ldzAoc3RydWN0IGlvdmVjLCBwLT5wYWdlX2NvdW50KTsNCj4gPiAgICAgIHJldHVy
biAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMjQwLDYgKzI1MCw4IEBAIHN0YXRpYyBpbnQgbm9j
b21wX3JlY3Zfc2V0dXAoTXVsdGlGRFJlY3ZQYXJhbXMgKnAsDQo+IEVycm9yICoqZXJycCkNCj4g
PiAgICovDQo+ID4gIHN0YXRpYyB2b2lkIG5vY29tcF9yZWN2X2NsZWFudXAoTXVsdGlGRFJlY3ZQ
YXJhbXMgKnApDQo+ID4gIHsNCj4gPiArICAgIGdfZnJlZShwLT5pb3YpOw0KPiA+ICsgICAgcC0+
aW92ID0gTlVMTDsNCj4gPiAgfQ0KPiANCj4gQXJlIHJlY3Zfc2V0dXAoKS9yZWN2X2NsZWFudXAo
KSBmb3IgenN0ZC96bGliIG1pc3Npbmc/DQoNClpzdGQvemxpYiBkb2VzIG5vdCByZXF1ZXN0IHRo
ZSBJT1ZzIG9uIHRoZSByZWNlaXZpbmcgc2lkZS4NClRoZSB6c3RkL3psaWIgcmVhZHMgdGhlIGNv
bXByZXNzZWQgZGF0YSBpbnRvIHRoZSBidWZmZXIgZGlyZWN0bHkNCg0KcWlvX2NoYW5uZWxfcmVh
ZF9hbGwocC0+YywgKHZvaWQgKil6LT56YnVmZiwgaW5fc2l6ZSwgZXJycCk7DQoNCj4gSWYgdGhl
IGlvdiB3aWxsIGJlIG1hbmFnZWQgYnkgdGhlIGNvbXByZXNzb3JzLCBJJ20gd29uZGVyaW5nIHdo
ZXRoZXIgd2UNCj4gc2hvdWxkIHN0YXJ0IGFzc2VydChwLT5pb3YpIGFmdGVyIHNlbmR8cmVjdl9z
ZXR1cCgpLCBhbmQgYXNzZXJ0KCFwLT5pb3YpDQo+IGFmdGVyIHNlbmR8cmVjdl9jbGVhbnVwKCku
ICBUaGF0J2xsIGd1YXJkIGFsbCB0aGVzZS4NCg0KWWVzLCBJIGFncmVlIHdpdGggYWRkaW5nIGEg
Y2hlY2sgb2YgSU9WIGluIG11bHRpZmQuYyBzaW5jZSBkaWZmZXJlbnQgY29tcHJlc3NvcnMgDQpt
YXkgaGF2ZSBkaWZmZXJlbnQgcmVxdWlyZW1lbnRzIGZvciBJT1YuDQoNCldlIGNhbiBhZGQgYXNz
ZXJ0KHAtPmlvdikgYWZ0ZXIgc2VuZF9zZXR1cCwgbm90IHJlY3Zfc2V0dXAuIFRoZSBzZW5kaW5n
IHNpZGUgYWx3YXlzDQp1c2VzIElPViB0byBzZW5kIHBhZ2VzIGJ5IHFpb19jaGFubmVsX3dyaXRl
dl9mdWxsX2FsbCBpbiBtdWx0aWZkLmMsIGJ1dCB0aGUgcmVjZWl2aW5nDQpzaWRlIG1heSBub3Qg
cmVxdWlyZSB0aGUgSU9WIGZvciByZWFkaW5nIHBhZ2VzLg0KDQpJdCBpcyBiZXR0ZXIgdG8gYWRk
IGFzc2VydCghcC0+aW92KSBhZnRlciBzZW5kfHJlY3ZfY2xlYW51cCgpDQoNCj4gPg0KPiA+ICAv
KioNCj4gPiBAQCAtNzgzLDggKzc5NSw2IEBAIHN0YXRpYyBib29sDQo+IG11bHRpZmRfc2VuZF9j
bGVhbnVwX2NoYW5uZWwoTXVsdGlGRFNlbmRQYXJhbXMgKnAsIEVycm9yICoqZXJycCkNCj4gPiAg
ICAgIHAtPnBhY2tldF9sZW4gPSAwOw0KPiA+ICAgICAgZ19mcmVlKHAtPnBhY2tldCk7DQo+ID4g
ICAgICBwLT5wYWNrZXQgPSBOVUxMOw0KPiA+IC0gICAgZ19mcmVlKHAtPmlvdik7DQo+ID4gLSAg
ICBwLT5pb3YgPSBOVUxMOw0KPiA+ICAgICAgbXVsdGlmZF9zZW5kX3N0YXRlLT5vcHMtPnNlbmRf
Y2xlYW51cChwLCBlcnJwKTsNCj4gPg0KPiA+ICAgICAgcmV0dXJuICplcnJwID09IE5VTEw7DQo+
ID4gQEAgLTExNzksMTEgKzExODksNiBAQCBib29sIG11bHRpZmRfc2VuZF9zZXR1cCh2b2lkKQ0K
PiA+ICAgICAgICAgICAgICBwLT5wYWNrZXQgPSBnX21hbGxvYzAocC0+cGFja2V0X2xlbik7DQo+
ID4gICAgICAgICAgICAgIHAtPnBhY2tldC0+bWFnaWMgPSBjcHVfdG9fYmUzMihNVUxUSUZEX01B
R0lDKTsNCj4gPiAgICAgICAgICAgICAgcC0+cGFja2V0LT52ZXJzaW9uID0gY3B1X3RvX2JlMzIo
TVVMVElGRF9WRVJTSU9OKTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgIC8qIFdlIG5lZWQgb25l
IGV4dHJhIHBsYWNlIGZvciB0aGUgcGFja2V0IGhlYWRlciAqLw0KPiA+IC0gICAgICAgICAgICBw
LT5pb3YgPSBnX25ldzAoc3RydWN0IGlvdmVjLCBwYWdlX2NvdW50ICsgMSk7DQo+ID4gLSAgICAg
ICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICAgICAgcC0+aW92ID0gZ19uZXcwKHN0cnVjdCBpb3Zl
YywgcGFnZV9jb3VudCk7DQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAgICAgIHAtPm5hbWUgPSBn
X3N0cmR1cF9wcmludGYoIm11bHRpZmRzZW5kXyVkIiwgaSk7DQo+ID4gICAgICAgICAgcC0+cGFn
ZV9zaXplID0gcWVtdV90YXJnZXRfcGFnZV9zaXplKCk7DQo+ID4gQEAgLTEzNTMsOCArMTM1OCw2
IEBAIHN0YXRpYyB2b2lkDQo+IG11bHRpZmRfcmVjdl9jbGVhbnVwX2NoYW5uZWwoTXVsdGlGRFJl
Y3ZQYXJhbXMgKnApDQo+ID4gICAgICBwLT5wYWNrZXRfbGVuID0gMDsNCj4gPiAgICAgIGdfZnJl
ZShwLT5wYWNrZXQpOw0KPiA+ICAgICAgcC0+cGFja2V0ID0gTlVMTDsNCj4gPiAtICAgIGdfZnJl
ZShwLT5pb3YpOw0KPiA+IC0gICAgcC0+aW92ID0gTlVMTDsNCj4gPiAgICAgIGdfZnJlZShwLT5u
b3JtYWwpOw0KPiA+ICAgICAgcC0+bm9ybWFsID0gTlVMTDsNCj4gPiAgICAgIGdfZnJlZShwLT56
ZXJvKTsNCj4gPiBAQCAtMTYwMiw3ICsxNjA1LDYgQEAgaW50IG11bHRpZmRfcmVjdl9zZXR1cChF
cnJvciAqKmVycnApDQo+ID4gICAgICAgICAgICAgIHAtPnBhY2tldCA9IGdfbWFsbG9jMChwLT5w
YWNrZXRfbGVuKTsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAgICAgcC0+bmFtZSA9IGdfc3Ry
ZHVwX3ByaW50ZigibXVsdGlmZHJlY3ZfJWQiLCBpKTsNCj4gPiAtICAgICAgICBwLT5pb3YgPSBn
X25ldzAoc3RydWN0IGlvdmVjLCBwYWdlX2NvdW50KTsNCj4gPiAgICAgICAgICBwLT5ub3JtYWwg
PSBnX25ldzAocmFtX2FkZHJfdCwgcGFnZV9jb3VudCk7DQo+ID4gICAgICAgICAgcC0+emVybyA9
IGdfbmV3MChyYW1fYWRkcl90LCBwYWdlX2NvdW50KTsNCj4gPiAgICAgICAgICBwLT5wYWdlX2Nv
dW50ID0gcGFnZV9jb3VudDsNCj4gPiAtLQ0KPiA+IDIuMzkuMw0KPiA+DQo+IA0KPiAtLQ0KPiBQ
ZXRlciBYdQ0KDQo=

