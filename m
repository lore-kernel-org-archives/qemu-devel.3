Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F84CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnC9-00070Z-FW; Mon, 20 Oct 2025 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vAnC0-000704-N4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:32:51 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vAnBx-0008Ad-LO
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760956362; x=1792492362;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J2JCKoJWdqUOELhrnhMXyU0GI+f7xQsK2A0NhpB7Bpw=;
 b=DEdkCuPNpAPD2B10Bk21rsVFBOhnTFD/MN0fOiIY/F2agtgX45ulCSMp
 2uxGKuiugJRZgt8hL9FNXTAxVWNkduNRIRpU1m/qVSL2fPPvxFWSynR3s
 kxE/Va8El4YV9z+LXrwUnyUqLK37J9eOAjq9UPgTzLAIMNtnwzdwagtNt
 8GXe39Uh/WVTAOrJ10tR4Mir6GL2zZf6KpCWN2keQsz3jQGhj22+lxwnl
 vI7Q4eLBgKa6sgYFY57JaWuXmV5G6KOph7J4ucYzNCgWzRjarLcOuZYGm
 OIHFVbELmDse6nizbJgs6xkta1BCbd6r+LdTWrs7TuFmBUEmLUsspSkxd g==;
X-CSE-ConnectionGUID: JzlI76YXQdGem6gZINY90g==
X-CSE-MsgGUID: aZxz/IXkQNijVb89iwa7Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66707714"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66707714"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:32:35 -0700
X-CSE-ConnectionGUID: 5EvdsaJSSx2T7F4oN0rLkA==
X-CSE-MsgGUID: oSmWbORdR9KXBAQd8n1zlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183314102"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:32:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:32:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 03:32:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZONDebRLLw/r7fOLUR+yoFEWpuzdmKRu3JBnua9gMAw+IfCRLe+wgPiluKs6qO4IlZ1fmc7XQ078GQwtFx4OG4BGGHPp1g6RttZp57/U/2WxspLE/fbxegLQUQ04h/BfrRlr9+P7oumNIeVVvyWWS9c7+z3m151hkXtfh22Pji7d9mSF42C5XoI/uJJfACZKnvDSe/W9k7H9bjNEl/c3oNB5skjb+PTo32P/U5yAxcBk3ZpmWy6YwW/MxjAYDO6VTiaagzRfMX+6ABe6vH2Y9HbkFRzNCFHOmukiM7LPIA6YqVjcwHsg/eklxzyh3Q99CIQevu4phSTOB1sRc3rZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrLhsss634OWb9XRTEnt3yX+RaNtWftvqQn3J4Mc0g0=;
 b=VNrJZTMjQcR2idksdirOYQhzY3H9zUsTcF3wPHI7J2vc4AtjP8oqxxa7ntPsryE3Q3qxx5kSUTNgAqvRphWOPERjEi6ZZNmFB3z/oCmhCPLODzEz8pzXV0+h3N9Y47hYJGwLBCXyHaO1emCE6moXsYi/YnE3BO4VyFDnjV/1UFusOYN4XadeLIoky48p3NRuts204wHobN3Serw6QLDI5OKI0umRZX6qXl0tJTGacnNFQJdgtvm3+cEbP03GZIKfQhVozb1SNOVQ3zEOTJAI4oToqGmo0/MUiFekDEIkbc98Fucgkk8ul1YgZ/rrjTY3U2sF9Gtni9K/jO2Mn9MvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 10:32:32 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:32:32 +0000
Message-ID: <08e0ea1a-34dd-4700-917c-157996586c73@intel.com>
Date: Mon, 20 Oct 2025 18:32:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram-block-attributes: Avoid the overkill of shared memory
 with hugetlbfs backend
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Alexey Kardashevskiy" <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Gao Chao <chao.gao@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20251017081445.175342-1-chenyi.qiang@intel.com>
 <bc7c734d-28c4-4abf-8049-a93e2e5e0b1f@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <bc7c734d-28c4-4abf-8049-a93e2e5e0b1f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:d10:33::14) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cd125b-5fcb-4c3e-5139-08de0fc3fa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STA0Y0pFYmlJbXJZOThhUUthdTJFMW5jQ1J1YisrdTNsNjBacWVJSEh6cFBM?=
 =?utf-8?B?Rldiazgxdjg1VDlCTGFBSHUrREtpU0NkVWNvZ3dFbDZVb2NKR2huY0ljQkVh?=
 =?utf-8?B?KytjWUxxTjFXWnZoZWR6R2pibUplcXJWT1JldWJBdFdJTk4wK2xGc2ZOYkVP?=
 =?utf-8?B?dDRib3hZVU9ZQjlNaG82bTI1b2RyUlNUcGQrSGFwSUxRNWtvVGgzYTVyRVlW?=
 =?utf-8?B?VkVJeFpHbWRmQmhQUncvcitWTG1vVThkOWZYT2tSKzgwcTEydXVXOUEwSkJt?=
 =?utf-8?B?Z2FiWmZWdkZKNmQvVHJ0emNTa1owVzhadGRyZm80Wnh4UkIzQjd3RzdPd0pN?=
 =?utf-8?B?MFc3VHdRQ2R2ZTFubndwdUlidnRiTll1dEV4Rm9Sa1FjakxMUGo0OXBRSHlq?=
 =?utf-8?B?cnE0eGtvME9xeUsrNk1od0lNWUxzemt2TXcyZFpTUnozZWgwZy8rWlhGUHlu?=
 =?utf-8?B?bzQ5TW1jYVA1WmRyRTZjUE9tbUpLTXh6aXB1ZFVCYXlhRGtJNG50S2hoVkdY?=
 =?utf-8?B?alRLbDRsQnBUVFhUU2hjTUhPNHBZZEFpWmlnWTYrd3JjWE1EOUpBTmQ2Tmw5?=
 =?utf-8?B?TmRrZWdZcFYxSFljMmxkanJEbHNxMXQ1dXlnWGJ4TUhKWFlqdVV6Ui9ENzNH?=
 =?utf-8?B?bHppMkh3YVQwNVpmdTdaVjJZQm5nUWduYlhIa0xYbW44S1I5ekxhOXdxVnRk?=
 =?utf-8?B?QXk1MXltOFErZHk4TlRtNGZQYmJlQUZXWld2MVpYcjFlL0JEZ0ZxRk9oUmNz?=
 =?utf-8?B?L05LanFrWXRITUJ0ZnpQZzlOTkJ0OW5XTTVDNkw2cHp5RnhyQUZYREpHb050?=
 =?utf-8?B?TTZham1HVENDODlpdzVKeTZKK1Y4QlpSazYyS0tuTU5zOGNJeWloRG5hOFEr?=
 =?utf-8?B?N05Kcm00eEV2eWlTUFU5MnRVT2NQZ3VJenlkNkRXT2F6MW1xT1ZIeWF6TTFk?=
 =?utf-8?B?UXdmZTYxUnRiL2Q3UkVHditCVVcreXpoNWFLS0hYRXA4cGZHVCtJS09SRmZP?=
 =?utf-8?B?bnA2N3NrMHNkODBJNVpvNnNlSzhXc256VVZoZ3pZWDFEWEQzRlhHdlc3cVZL?=
 =?utf-8?B?TmxYWFZGRVRJSEtoM1hrMzYyeWRrSnlrVGtsSzFVdlZ4UUZMNzM2YmtMU3BB?=
 =?utf-8?B?OWsxSEl2SS9yd3F0Tk90TnZ0aWVqdTZqZzd4bE51ejV3d296b3pLKzVxTFdE?=
 =?utf-8?B?Z29OT1o1aXdCaVpWby9CWVpIQkVkWTN6T0lTdFZhOXJZVFNoUjkxVjk3amVr?=
 =?utf-8?B?eXpXVDVzdzRUZE04T3YwM2ZuVXVDalRYQlV0NmF0S1lFK2RHNHZGQXhzT2dL?=
 =?utf-8?B?ZSsyeTJTVEJTb240aDJIVy93aW1xTk0ydnJwOVZzdmlGMGQrRXBxZ3VpbHpX?=
 =?utf-8?B?RXpaaS82ZzhzT0VJNTVIWXVSUEFjYTQ4c2JwNGdIbTdxaERRdnNKa2hqN1FZ?=
 =?utf-8?B?eWYxcGF4eTB2TTNCNkxkUzFjM2daSklCczl1RFdpMnlRZ1huM3Z0ekVUaHJv?=
 =?utf-8?B?ZmZYMDhCKzZsSnpUZGYxeEFZeVBJam1KUGFxOHo4cnlCb3d2a2lvSzFIbHlX?=
 =?utf-8?B?TjAyMnE2ZHdWSDNGYVRkVUZqbjNoaFZ3M3NOVzhyQk5PRkpFbmkxYURVb3JD?=
 =?utf-8?B?aGhWcGJsRUVKOXBRK2VsSG5MUVpObndyVUl6L2ZZSmdMbUs1RDFZMVFQMWtH?=
 =?utf-8?B?WUlwd3NtSEVyU3FseWtsbnM3czduWFVOTlpYSEtqYjlVZkc3S1RJU2lZblRu?=
 =?utf-8?B?Wk9kNlBQMWxnQkwrOERmakVRajBkY3FXQUxJODJQYVcxTDl5d2dQNktCZ1cx?=
 =?utf-8?B?ZndQa3hVMmhZaXNVZFdpeWtMN2E4UWl4Q2ZQRHRvOTQyZnM0QkFLK1FrYll6?=
 =?utf-8?B?K2RrNXI1MFYyODZyNFU4S1B4eUpkQXErSEw4eUF4WXh0eDRnV053Zk9WRVQ2?=
 =?utf-8?B?dXlDOVZCajhUODh1ZmFuNUlobEc2Y21sUFZaTGhXRjMyN2lYSkU5NmIzTDBw?=
 =?utf-8?B?RXJCWFdLcVd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJLeDd1TzJIVFFxZFlNWWdZcUVhVTNzTlhjdGVIY0gyQ0pNTmZoT0FjYVUw?=
 =?utf-8?B?ZkxFSGVrZVRoOW5Qeml2Z0kwWm1HK0pHQ3grbXdudGFaeVdPU29haTV4QXpN?=
 =?utf-8?B?cUdoNjZjZEJ3RDBEVlM2ZmxqOE5SNkFYaEFIRnBYQ2JwR2s1MUtNQXpQang5?=
 =?utf-8?B?WENhZ0VBYmN5TUIrQ3JsM3ZGQnBncUU1Yy9pL3JrMGdBZ3UwN01zY2Rtc1BM?=
 =?utf-8?B?QkxzdFYyaTNrS1FGY1pvZ0svVFR4dHVkaVpKN2dNZDRoRzVtcmU1TVY1aW9Y?=
 =?utf-8?B?c0tDWm9TVjNJUVFFUzhzb3FnekVvNUN2RmpYdVpCdzJlZEVjQjdYWnlULzVF?=
 =?utf-8?B?dmpvdjZPSEFJbS9wTmpmYnV2ZXo1cVhUcFdqOFJSNzJETjRvVnJtcTVCZU13?=
 =?utf-8?B?bFQ0UkJlQXB5OFJVWUJPRVk1NGI3Rjlob1FPekpIZWZFd0diTUNlUXNtK3VJ?=
 =?utf-8?B?ekY2QVk5dEU4NjBZSzNZa2xkcmc5K2VJRSttaDJYWDdnUWxGYk9MRGVqcW9q?=
 =?utf-8?B?dnVTcFZ1RVdLNWErZ0hKbExXRnNjcDNhWkVVV2hJRHZIRnFqWExRVUhXWm5J?=
 =?utf-8?B?RVg2ZmdLMFVyYXFlS3FKeCs1MzZIcVVCdHpZVVRFdzJ0Q216UUJPclMzRXhx?=
 =?utf-8?B?VUFiQ043TnhzdG5NSVp1MFBHUmFlNzdwM3pHZEx1SHFHeTVNcEFQUVhDQ1BZ?=
 =?utf-8?B?UGwzK0p5M0hvaXE4eVp4dkRSNU1vWW5kVG1MVFgyZHZDcjJscWJwVEY5YnhJ?=
 =?utf-8?B?WGJhVHFkZndlWW9WV05uMEFTVGRJMXV6NHVnQjFFZFR0Z1Fhd3pXYW5QNHJT?=
 =?utf-8?B?UTVWV0Vac28xWHNOS0FnYVZad1JYdUJIQUF4TXBDVjZPTUREV0x2SEhkZDln?=
 =?utf-8?B?NWo2WXRVc2VJUzhHTHY5SlZzTmowSXo4UnN2ZVNMTkVKYW1GeDlVcHdONDJ2?=
 =?utf-8?B?UTh5a3Q5RkRzOEFtdVpKUEwvQWZSQ2piazNuZktkbGk2V2lPOWZpbFgxUm9h?=
 =?utf-8?B?YkR2b01Ba3VFZHNMcXBoRVNWM2pOU0JkUVk1UG9ESFZNck5PS25DbEVwNFhS?=
 =?utf-8?B?NUJNTEJGWG5zVjdoYVhlVU9KZ0prTDZ1SkVKU1d2V0hzTmliS3BCSjl2MWt6?=
 =?utf-8?B?R1NaQzlsaDJYMC9LREdncU5qWU5PK3lxSWRLbTByVjJ3UjdodlJueW1uaThE?=
 =?utf-8?B?cFdVZHJUcTlIWEJZWHNiZEx5cjNvNmdCYmU2bk9MZGZhQ3doUHB2M0hpOGcr?=
 =?utf-8?B?dTJ0ZnY5c2tUeEtUVllvaEptTEJ4dkU4d0JEZkU0Q1BZZTRrZTN3eE5rT1JN?=
 =?utf-8?B?RTdFTzZpRjM0dlpoLzBqR0NiVEU3ckx0VDE3dW9UMlF1SGFwNUdvYTY3c1B0?=
 =?utf-8?B?dmRXS3ZpdC9lSXBZL1JLQzVDRi96RHo4aVBjTUwrZ25EVGJyd0l3RkxLbzdR?=
 =?utf-8?B?NWpkU09zL3RxTTV3aXkzVEkzY3hTckxGWlFOc2VRY2pzSUY4NVBENnVaWmxW?=
 =?utf-8?B?bkVIVWpSMHd2dlBrSUNna3NhTm1TT3ZGeE1WWFdKZnNwV0Z3ZFF1aGdZS3U2?=
 =?utf-8?B?WTVzZlRkY2I4QjdTMnNGTlVXOU9LWCtCSndMdzRSVXRaQ2MyVnJsS2pPenY1?=
 =?utf-8?B?eXE2RHpmYm9XZE92VE01WnBIZHpmb3VLUUltcURXK3pFMFNUTFA4bUNPTDZv?=
 =?utf-8?B?VVJwYkx5a21QZUFNbFlGZVpyTDFuMGU5blBvanJDVzZlUERHc1ViQzh1dDhK?=
 =?utf-8?B?MVl1WUpaVkE0cVoxMS9tUTJWbDR1MUxYa2U3aEgyNU82UUFHelhpK0ZFcFNm?=
 =?utf-8?B?YU9qQTRwWGpMcGxnY1V1aXExOG4ycGkyZ2x1RkdLUWwyRUVnUFhJdVd0Ynh0?=
 =?utf-8?B?NUxYOVVEUkFYR09WTUxWMkhDQWx6bUlTd1NmVUZDM3B6eG5EZFZoWDYrOGtN?=
 =?utf-8?B?czMvOEZ5aWcwaDZsVGNFcGpySnVPdUNOemFOS1k3NUZxdFFDbW5naVNScWlY?=
 =?utf-8?B?aDFnVmphZndQNWszNTYxNmJVSlcxUzFvUVh0YXRZa0V6NVRXOFk0RDdtcFFm?=
 =?utf-8?B?cEVKSWFCM3o2YTFIRnRrRGJIL2hYS3d0WVJ5MGhZL0U0TUpHejdRWXhTbEx3?=
 =?utf-8?B?OHFFWTJoOU15YVM4MzJ4STk0c1p5Tys3cE1zQ3UxenBVZHJMUkZtVkUzdzY1?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd125b-5fcb-4c3e-5139-08de0fc3fa19
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:32:32.6382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PryJ0N4Jza94xvMPfzuHndVmq04mgn1fJMH10I7ojBTG4mzNTauc/mF9LfsrlRLJIbj3o8T/dTx38UxOysmDzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 10/17/2025 11:13 PM, David Hildenbrand wrote:
> On 17.10.25 10:14, Chenyi Qiang wrote:
>> Currently, private memory and shared memory have different backend in
>> CoCo VMs. It is possible for users to specify the shared memory with
>> hugetlbfs backend while private memory with guest_memfd backend only
>> supports 4K page size. In this case, ram_block->page_size is different
>> from the host page size which will trigger the assertion when getting
>> block size. Relax the restriction to allow shared memory to use
>> hugetlbfs backend.
>>
>> Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>>   system/ram-block-attributes.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
>> index 68e8a027032..0f39ccf9090 100644
>> --- a/system/ram-block-attributes.c
>> +++ b/system/ram-block-attributes.c
>> @@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
>>        * Because page conversion could be manipulated in the size of at least 4K
>>        * or 4K aligned, Use the host page size as the granularity to track the
>>        * memory attribute.
>> +     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
>> +     * is different from host page size. So it is not appropriate to use
>> +     * ram_block->page_size here.
> 
> But are we sure everything else is working as expected and that this is not a check that prevents other code from doing the wrong thing?

I think so. The block size must be 4K due to the page conversion could be in the size of 4K and we use "bitmap" to track the status.
I originally missed the case of hugetlb so added an assert() here. But it is allowed to use hugetlb as shared memory backend
before shared device assignment patches were introduced.

> 
> I recall that punching holes was problematic as the VM shares/unshared 4k chunks.

I can see the kvm_convert_memory() will skip ram_block_discard_range() if using hugetlb backend.
It will cause the double-memory consumption (*). Any other problem?

[*] https://lore.kernel.org/qemu-devel/5f65ec5d-7079-4b32-8e40-b9ece3bdd47c@redhat.com/

> 


