Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D878ACA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 06:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl05j-0004aQ-GL; Mon, 02 Sep 2024 01:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sl05h-0004Wr-4c
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:05 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sl05f-0004hx-2l
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725256743; x=1756792743;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y9KBHSlKb9BWT8lNex+8k+D/CT0W/d13T/y6dCt85us=;
 b=btLQLNVprgNRMpx13KxZ66aZdDO+jnwJy6GoN2HwnQA+JeVprijfltCJ
 C6qdNAS1ud8z2LNS3chDOFlKUIGxz8ByifJWpHd8A0sOMLeHeBsKROz/b
 /uX1GeC6RHMZU8weRuYZ2lyN3p00XbDrL05yDrwkM1SZw+cHELLvkOLb6
 1yljznpmZicMTowPoQW9xRa+BTud1cTA1vRUWBGk6tgf7scgpRzlo8Aro
 aNHYEIif2I5un/YX7sUVrWAihCTjSHGs+CZrxyApsakIaAlL5If0T4CTf
 X3whP02V3McCKRwRg7BhtkbHZ9nGBHVknlCYyH7zqKOQVAKsMxzEN/X+i A==;
X-CSE-ConnectionGUID: uOFyuQ7TTP2+898NiDVIKA==
X-CSE-MsgGUID: U7MCISgGQY+64puo/GGyEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41323311"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; d="scan'208";a="41323311"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2024 22:58:59 -0700
X-CSE-ConnectionGUID: nJp2odVWQ7eQeAAafv0KuQ==
X-CSE-MsgGUID: wliaxR6TQri6MMhYnLe1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; d="scan'208";a="69314772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Sep 2024 22:58:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 22:58:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 22:58:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 22:58:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 22:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE8RIfYj33wTHPuObZr7PhRVM3YI62T6QIvWp/mUiarl+APLJwRB3ssKVlsEamcHd8dz1GMYCUIs6+COtHG4oXruuHeXM2ZptgRQ8aSqWRo3hdl5yKS1+XC7tZa4ilT0DUsllqWLfgdsupzuIsxIdmLgj6DGoIegDe3WKMAZrCn/0F5iR2SQklE3aTwn4835gpN6ZU5sl2YWFNR9EMYg5Om9lAh+Zl62vav0nXTiI1mEc6T2Iq/u+mmCJ32oA1wYowOXzSs4lWia/6VrC805YWQ0FTMDXy7maFRLwFOvDZdR0xazibCqMeg/gpeqsVt8scrDPGKsciou9KrDiTM8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uohhzt0wTHzT308XvFx/PSTzOV9YV0CfTE7D7ILqnWs=;
 b=oB/4U59hlera7nGj4vLu+zyQz9OYQuYmWgLVIMTfRqvT5/AChRF4vXfQmEHvbg8nMWif/Wdm+WPP7lLab29a6HmBlC69+8oDqg6JEArJwAcZKgQhO0ko573MS07mzDZpzvVjsoL14pNUkE55JYE5BhOc0ZXtZBreEERbDdRI2b+c5ar9v+WySMK3d5oS89myyQ9jdqJlMeOG7TJPwsaVxpuDLMHEB5dpLQLAr+X17b2TFKekxlAqstOpoVaH+0YdWsJnGucNU+2YSE3neCAoJNZm1MnMMGmXMrRFi+hhkuvl1Wwt27YtcGc2rM0HTv/ITTi5HPaIi0DDHJPBW8QeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 05:58:55 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 05:58:55 +0000
Message-ID: <5676887b-9e54-4ee3-a29a-4735c3c21350@intel.com>
Date: Mon, 2 Sep 2024 13:58:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang_=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Gustavo Romero
 <gustavo.romero@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Zhao
 Liu" <zhao1.liu@intel.com>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
 <87y14e1de4.fsf@draig.linaro.org> <j2qtr.bznhnwg3r4rn@linaro.org>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <j2qtr.bznhnwg3r4rn@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3fae98-c128-4f8d-bec0-08dccb14547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFoSG9VZUtYWk5iWkZvOGdOWmhCNWZITWZ6cXdvMXVpZDNsdVMwVkE1aU9G?=
 =?utf-8?B?NlVDd1hGc0dhUXQ4TXM5UlJwMGovZ1VtaWw2T29XK2h6WVVjY1VYclZqd1Ew?=
 =?utf-8?B?L1RwcWNYZG9iUzFlQ1ZaTS9HVUlyMC9SelhHZ0pzeEUyWEtRbGJMTWVUUnlk?=
 =?utf-8?B?QVJnTnVvNnZwQ2djMFhibjVucEFhMUUzcDRVWkZXZmVUKzRjQXlqZmRNckcr?=
 =?utf-8?B?by82NU1Db0J1Sk1IemtSOFR0bzZQbEoxOHlJaVFCQWMxdkFFa3dKQlZJRkUz?=
 =?utf-8?B?enFMenA1KzhDUlJIWFByOXN1a2NLbHRzN25FNkxMT04xdEpCTGgveDM4UkNV?=
 =?utf-8?B?Z253ME1GLzBCMFpENC9QbEtEbTFMdWlPZ2lMY3M1ZVVyNDdwZm9tNVFRenpt?=
 =?utf-8?B?Y0JoWGE5ZE9LMnNsdmo1Y3JVbHVhQUJzT2RKcUUzQTBZYS9rcTdkL2JHK1ZR?=
 =?utf-8?B?Z0VzS0pRbEdOK2ZzZEdMWnh4L1BNb25ROVdvV3B3bVBYSW1WUVBYZ1lRUHFk?=
 =?utf-8?B?RnVVS3ViODJFQkppZ1YwVzZMUEZjVlJsU1lqbG41QWtPZTlOY2JSbmtWY0NC?=
 =?utf-8?B?NGkwRG41QnlsejQxekptQ1JpSVBjR1ZVQy9QT2R4bmhOK1JnYUpjQmRLdzdj?=
 =?utf-8?B?RmZRdCtLa3dhRHU2MU5IMVdYbmxNSUVqdTJKMDhGSm1KWGFUU1dBVVgwM0kr?=
 =?utf-8?B?cGRCb1lsbzU3M08zUjIreW1xYTdLdFpWV1Vub1poWWFQNU0za3BaTEhnYUYw?=
 =?utf-8?B?QUN2UXdsTXdrdFNDbG9PVmdyUGQxZDhhRFRodXJzYWExRUdrREExVHQ5Ymlo?=
 =?utf-8?B?OGRzVkUycVh2Vkk2QlFXenJiQ2l0OHdtWFJLWWNxa09kU1RkK01tNDRwazNw?=
 =?utf-8?B?L1QrMHA2K1Z5V09tT0Q2K2JxREV1K29tQkNqM1F0STFKVk5PL25VTWhEWkRX?=
 =?utf-8?B?citKUWg2bW9BODladkFNWUROQ1FNWHp6VENrZjYrZDFEd0JpcEo0b1pkMklB?=
 =?utf-8?B?KzlOSW91TEw3b295WUtuRjhJTXpmZzdGUTNkTFhPRzVCU3NOTWFPOWtVeEs5?=
 =?utf-8?B?OW5lcU55ZGs4dCs1Rk9LQXpiTEFwTlFrK2ZyZHY4amNwMUMwYlFHOXNrbU15?=
 =?utf-8?B?OVFoaHMxOVlySkFJMGpSc09GS1FrNGtyRU9ZaUQvNVF0YU8wN0k2alNtTUFn?=
 =?utf-8?B?SjNycjlKYm5ZUjkvUVJYYlBwMjdJSHFsNGxTa0NjR3pQY2x3NTZZNUVuaG90?=
 =?utf-8?B?MWRCaytoRlgwQnJWRy9yZmh3M0dKTG1UMEJmTE80a2lwYktScnRCNDRVSitC?=
 =?utf-8?B?RytydkJYVlJpdHljVUs2b0gvOHdKWlBIay9reUlZN2ZUTHd4MVovMGJqVDh2?=
 =?utf-8?B?QjEyTHlxblRzSm9HS2xRRzNRSVRXdW4xd093RjJJWEtwYzB0ZGJWaGluMkZ5?=
 =?utf-8?B?Ym9PM0ZTNDBUWWdvR0laOWRvb3JuUFNyS09XSnBJVFl1Y0pGREIxeW42ZUkw?=
 =?utf-8?B?M3BEVi9TallpY0pJNW9rY1loMXg1WC9vR3JWUHd3am9MU1J4ci9kNHdEZWFi?=
 =?utf-8?B?dGhCWjhCZTdTck9Jak4zb013dE9KSXptdzFlQ2Q1b2VuTVJOUmpEbUI1VzFq?=
 =?utf-8?B?a1VsWkl3UTBXdnBRNm9UZkxvWlBIZEcvRVVwSVo1bXRrSW5JdHRueTBCOTdK?=
 =?utf-8?B?VCtVZ0gvcU9nRFFjei9ialNBbkZsQXZIUkowZi8xMllubUZnZXFkU0RsQUNP?=
 =?utf-8?B?aGlObVowNitWTXBkTlNFaXV1bS9lck5vbHVqOXpyaUoyajA1VXJ2OTV5THVw?=
 =?utf-8?Q?y/cLkyLSphEYjt9lpGZYUvoUAV7XeUzRWVqgQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhHZnRORW1YUzBndTRUdEl5RDJoWW94ZDVUekI1S2hQMzhIMnY4eFc0RWJN?=
 =?utf-8?B?amNYOW9qUVgxR3NsdStCTjZrOVpneklRa2wvWVU1MEJIQlcxd0oxbWhxSUFl?=
 =?utf-8?B?VzA3VFp0T1J1QXZiSEpUK1Q3c2tla3ZocGNiZ0xvczRqSWx0NlB4bTM1MGlo?=
 =?utf-8?B?d3NyeERQT3l4QUxmRjZyQXg5Nkl0eHBCak5aeUFWMUdMUm1FclFOTWtjSmtC?=
 =?utf-8?B?V2l0QkVWODVrZlpOSGgxaG1yRnJSdy9mTzd1RHkvN1Qrd2VGRUNTZ2JBQkJE?=
 =?utf-8?B?UVVycDM5K1o2NHhNQ1lXbHNrdUIzOGpidStUS2tJSnEzUEVnNUw1TkIvVUpt?=
 =?utf-8?B?dUp5NjlObVl6UXVDTGNqU2pHSDFETnhxaHArdUhybUtuTUNnNzZrcy9xeHNh?=
 =?utf-8?B?R3RIUnpPdmhFQ1BVSlpDQWU2QnNmeGFGeFo5RlhCaENVdDRMN3pZMHRqd3E0?=
 =?utf-8?B?TDZ1K25Jd25QeTc1bkxoTTczcVU3elRjb3hxOWQ5Z2ZZUVZwVElOV1pJVHk3?=
 =?utf-8?B?alF6dDVYbWdSWFp0U2xiQzVxZ3lobkNDWHl0d2FQNHJWQW85ZXdrQzAyVDJS?=
 =?utf-8?B?UG1icnJ2UGREV0lkbmE0eENmQ2pJcEJEdUdUV1pDemRpQjV5aG9Ta2djdWVW?=
 =?utf-8?B?VFFuU05vcGZHR0FiQUNOVTZNZ3J3S3VLUXJJcVhiSUlBbDdXYk5ER2hlQ1hk?=
 =?utf-8?B?R0o1U2RaUXdVbjhnVTFSMUlCSTRMR2s1YzVkaldxTXFhWWdiUkx6cWlrL2Q5?=
 =?utf-8?B?OW5qY3puODV1TW1yUFgxSkYxNHZOT1hkQ2xtOUsyZjBWNmcxSWJqdC8xVTRz?=
 =?utf-8?B?OEJWaG43Nk05SEU4ZEcxN2hmbWJ5VXo1ZFRKUjc1YjBiTWJlMEwvd0ViS2Nu?=
 =?utf-8?B?SVZLMWJVc1NadU02VmJST0wxNTB2dEFvL25EMUVHNlJzMURlazlPKzk5VVJT?=
 =?utf-8?B?OEg1dUxBMHVZa3JJNTRXQ3oxSmxJUG41NkVRK1EwVmZkenNXS3dNMHNRWW1X?=
 =?utf-8?B?QjI4OFZ5b0toaHp1MUI2emtSQjNUTFVma09iT280T0J0Nm5QSGg1OWd4SEdB?=
 =?utf-8?B?Sk5tZzkrSzNuL0pMdHExcTVvaWp2T1Z3RnByOCtvNkl4K1VUQnliZ3RVcEQr?=
 =?utf-8?B?cGZCd3JoN28vWE1JNkhpeHVabFFhUFNjaUFzOExwTGVIM0VnL01HdVFld1d3?=
 =?utf-8?B?VHpVZW9pOFlzdUZlSTJ1cHVwcG1lS2wwNnBwSlJoY2pMRDFCRWJiVW1WTHcw?=
 =?utf-8?B?bm40YXl4MEpNQkRZakwrcDJ3WTV2MVl6MC9uTHk1ZlJlL05PdGlpNDU3RTZ4?=
 =?utf-8?B?NndxWFREdG1UQjBqNjhxbXdLclUrZVUxY1VTWkdFTzM2V2UyMDdZZzVSNVNJ?=
 =?utf-8?B?blZrWVVxdW5TZ3BGL2ZodEJMVXYzMWVPbXZYM2V1OFhwWWMxaTJldTNXQS9P?=
 =?utf-8?B?ZStCNWtNTTFENmo1WURIRUd5M2RQZkd2MGw4ejBYVVB6RUZycnM4YWJJbEtO?=
 =?utf-8?B?ZFZnUjhBczZtbFNUVTYxcjl1YzdUYy9kWm1pcTBVS1QyaUpqNkJRYUdjUEs0?=
 =?utf-8?B?cForV0d0UHhsYkxFQnF2bExyc3c4Y093a3h1c1h0RzlweUliRnpuWHJmTG1z?=
 =?utf-8?B?dEhGVHI0MUYydEpmZnNBSWc3bXM0YlFOMXBpL3RnRENSVGFmV1pMeHVLQU5J?=
 =?utf-8?B?QUkzbTZLb0JUeXEvaVpoVUhXUDhleWhqTXUvVTBpdWQ1QXYxR2xXcjdwVEpC?=
 =?utf-8?B?bkthZXEwbngxdWtnb3FPYWs2RTdoWnpiTWc4T3FqMzBSOWhqZVlkaWxzOGkr?=
 =?utf-8?B?bHRXbEwvWEY2UHIwNThLcDBEQW1aZ1ptMlhFZC9HRUJvTmF6UDllU2JIWEQ5?=
 =?utf-8?B?aFJKTk5hUHJTTmMvUHkwYll2bXp2dXRxVUppM0M2Qldtb0JhQjF2YjJHd2xB?=
 =?utf-8?B?RncxVmlVMGxYYzhLTEVsczBaSmNrYUFFYWN2NXIrRlExakZLU3hxaEY5RjJP?=
 =?utf-8?B?WXYySlN3cVdHQTRCZjZZeksyNTlwWjcvdUt0dmhmK005UHZxZDRNekRCWmdh?=
 =?utf-8?B?dU9BRExuSTY0cGoxR01iL29sdFNxNU1ob21Xb1VtZzZUMXBER3BvZ2NJUmJE?=
 =?utf-8?Q?7QtpnnDqi2UePNVQq9kv/+nPV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3fae98-c128-4f8d-bec0-08dccb14547a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:58:55.7644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gEZik4/A9/GEvHrGmK5OiFLWxSAEYPfNVgu5BYR6LPPpqM5kmYR+I95q8c40ZJGczgo++7XJJ8t2dLOh4ToLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On 8/31/2024 4:25 PM, Manos Pitsidianakis wrote:
> On Fri, 30 Aug 2024 14:03, Alex Bennée <alex.bennee@linaro.org> wrote:
> [.snip.]
>>
>> It is there:
>>
>>  /usr/lib/llvm-14/lib/clang/14.0.6/include/stdatomic.h
>>
>> in the search path:
>>
>>  clang -E -Wp,-v -
>>  clang -cc1 version 14.0.6 based upon LLVM 14.0.6 default target 
>> x86_64-pc-linux-gnu
>>  ignoring nonexistent directory 
>> "/usr/bin/../lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include"
>>  ignoring nonexistent directory "/include"
>>  #include "..." search starts here:
>>  #include <...> search starts here:
>>   /usr/lib/llvm-14/lib/clang/14.0.6/include
>>   /usr/local/include
>>   /usr/include/x86_64-linux-gnu
>>   /usr/include
>>  End of search list.
>>
>> but not in the list above. Have we told clang not to include system
>> search paths in the bindgen invocation?
> 
> stdatomic.h was first included in c11, and compilers already shipped the header 
> on their own (since they use builtin operations). The compiler header paths are 
> considered special system header paths by compilers, and what's happening here 
> is a bug in the manual searching logic in libclang like explained in the other 

Do you mean the manual searching logic in the *clang-sys* crate?

There is also a related issue [1] on GitHub.

[1] https://github.com/rust-lang/rust-bindgen/issues/2682

> replies. The bindgen invocation looks at system search paths otherwise, or it'd 
> fail to find headers used in QEMU.

Another approach to work around that issue is to define BOTH CLANG_PATH and 
LIBCLANG_PATH env vars, e.g., CLANG_PATH=/usr/bin/clang-13 
LIBCLANG_PATH=/lib/x86_64-linux-gnu/libclang-13.so. That works in my environment.

The following is a draft to do it in meson.build. It does NOT work yet as 
bindgen() does not allow customizing environment variables. I'm checking how to 
make it in meson.

diff --git a/meson.build b/meson.build
index 68d5b53684..1f6fc21f8d 100644
--- a/meson.build
+++ b/meson.build
@@ -3879,6 +3879,30 @@ if have_rust and have_system
      capture : true,
      check: true).stdout().strip().split()

+  host_clang = find_program(
+    'clang', version: '>=5.0.0',
+    required: true, native: true)
+  host_libclang = run_command(
+    host_clang,
+    '-print-file-name=libclang.so',
+    capture: true,
+    check: true).stdout().strip()
+  # Clang prints an absolute path when the library is found
+  if not host_libclang.startswith('/')
+    host_clang_major = host_clang.version().split('.')[0]
+    host_libclang = run_command(
+      host_clang,
+      '-print-file-name=libclang-' + host_clang_major + '.so',
+      capture: true,
+      check: true).stdout().strip()
+  endif
+  if not host_libclang.startswith('/')
+    error('Cannot find libclang.so for ' + host_clang.full_path())
+  endif
+  message('Found libclang: ' + host_libclang)
+
+  # TODO: set CLANG_PATH to host_clang.full_path() and LIBCLANG_PATH to
+  # host_libclang when invoking bindgen
    bindings_rs = import('rust').bindgen(
      input: 'rust/wrapper.h',
      dependencies: common_ss.all_dependencies(),


