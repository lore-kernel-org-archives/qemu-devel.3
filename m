Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC6DC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lI9-0006H5-J1; Mon, 07 Sep 2026 22:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lI4-0006CY-K5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:29 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lI2-0002dU-HV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788833427; x=1820369427;
 h=message-id:date:subject:to:references:from:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QHJ7RyhgCTPsnLsEOBGi6EIB3MBorbwcgiAUCwE7sxk=;
 b=k43TBKwKp/8WKTxFGoDmGPwXALKeQMhWWa2a6wUjR+GN9WrsQDYVYc6M
 6/WhTx3ZESWQyr2J83QBmr7/AkaKjOjHgbi2hA9dEL9SF1/5xauoswXMg
 oXTpsdptsZHHzxB4E6YIl1kE0f4pWliseDxDyahFAI0BiRonVblpLxOoR
 XPwh83uJAgqtAimsQMwkIoGs6+c1Xa3fodt62qVJ7VS9HArjUUucfF5Hc
 xlfGXUfYLI4sP5SxS7CGaoxSWp0OphtCBEdREr4xmLH7RxB4IQ/73blP3
 yOb1Ur9zAr/0Cu/ENtCDZpDM20d/Kk5/67LIwBT+YxaFm266cHWaDuEgP Q==;
X-CSE-ConnectionGUID: EmytQGW2RgCnE8Z0E5s+kw==
X-CSE-MsgGUID: KGe2bup8Ruq8/SwfT38JfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88162595"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88162595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:19 -0700
X-CSE-ConnectionGUID: CmE+Ps6ESJ2gWWn0S6YXUQ==
X-CSE-MsgGUID: Fnytc8Y+QPmxnys6x5P/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264651483"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 19:10:18 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj59mWAKZk8UW4k038UTOESvqcxWDCNEVNeEuxstmEcZUpbpmHJZdjl2H3fq8MfKjFJPB+9NOB/nFqzNs61pQiTNKM+L9nSjZq0VyW0wjq78MsnTwheBP86fyWFxg1/xB22LhHsyfA9vneRfNlbGepYKxnZcebbPy66RVc/Db8U1gxFUV5zzUkqmIPcLxBNC6r7JretslJmlCP2UircawZMZ0PiAzHjCxsQmTNnUXIswiFvBKgTs3UcrjNh9W2lYxDxvS0WlXmJFDHSv9QYco2Faye3xyQNfcMZHph7hwLQj38inW0CVGLAWOLUOeVqgpR6S9x7p3OOCkt4zDF7XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg5iy7mqXTn/r+q1+L8c2KyHfq+lzW+hOkwk4iL4+N4=;
 b=YXE0PAu5XqiZDilGrJduE8kKmjHQ/tNeodgUS8m8sZmkHJgs2/Vjbco3Ew2m7D6ZROkzIO83hMoJhq4uZpKj3Ykj3fz512V3fcAq82FtxPoUi/dWwt1QKwY7GTLGkXwx+4FItrNTLOeSHOYM/GR/34f9ctTl3FQCDvQBMMEi+pB/F0YvybkJL5qMr6kRY214JsA3F4Jq6pmkx1OZ4nvgkxUlTDMNAFdxmQB6CnVeiorH+n0E/DX2U30MTgFBtVVJQ9zi0dUyQlydnjtaYgUvtTmwQwY9ooOgvxf+6K3vUMZXpWab8ZwFNKOi4A45Gx3lMbhQ2hEn8jwyvpq7fWXibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:10:12 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:10:11 +0000
Message-ID: <0ab7eca4-1bb8-4cfe-9e12-a3054709ac38@intel.com>
Date: Mon, 7 Sep 2026 19:10:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] target/i386/tcg: implement APX
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260825122921.431739-1-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: Zhao Liu <zhao1.liu@intel.com>
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: 39723d62-8684-4f22-6b54-08df0d4e4efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|3023799007|18002099003|18092099006|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: uEaq9JAaU46xB5SupzAcE/ofb7jE9ctpWi9HIW+uaPYg3CFE5SUmltjd813XphWuLK+IbmHxTCYcjlrys4EKJGTGlrO47qAE7B1rZGHmynSzrUIH9OWi4XDdzsJ+m4QIT9URBIMgY+cqo2Q4PxH+cK+oFNln3bxtQmI1GFcUuB9ya0rF91zAduTYlgsWZ86EmjHOKjeSVz0iQIKaaF9ZI7KwyLSS782OchRhyve0zTbwScuIo4faRvQPP4lswL3xKp8Qt+yYPXIkBLTff9vt6eeQ2oMl585F20H7ephnMScUI80wVLI1pBRuWYhHqrUiTCcTzBFHJ9Q26FVEGu+NsAl4EUDNvReHGAmSNNnpu60r0sobxDhSTZxAgynz740aAifcAvVdSzJPRfAEBrWc4eCwOhGCPycOEhezEkTRMO1sWpTXXqLH953oS2musEfkXaWtxl5vQO9QETXrM2nyK5CxWruvyQ0Kv2XXAlozdXfwc//CHiYIaqI8iRCxFH/lk+XiWiNRGkA7lxxK7iQqrqAwA5RUICODNKSbnFE9pG2JEloOasWLrlB/fmNlXrrVv44FQPuFfUMQiy/mzSMhcz5rZ2Ay01VaXTzXLYbKB0C2ByZsbiIXNmvdcLfLm3sWscEP+IXk5ZUIFZ+t9c3RG5yGWgaYEmZUaN0O/WOme8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(18092099006)(22082099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajU3azdZREJRUmNaWHdYbGl1RUNVRDNCcERiUHRPS0doeERvblpsN0xWY0NT?=
 =?utf-8?B?NXdNcTJxeEhpTWpFMnBPY3dMODFBa244cHFTbDJGUlBkNDB2azROK3k4WThi?=
 =?utf-8?B?dlFCbzJoNk41RmVHbDFuaVhkQVdodFZ2RkZUTHhrM0NKbmxubTREWVVJRnJx?=
 =?utf-8?B?c0FJMW9Fci9IRUR5bnpZWkptaW8vdWpOdDdTRThmK3BPWHhVMEYwcGZEMUhN?=
 =?utf-8?B?YXB5ZGNzZUFydTFiTzN0YmRJK0JNR2U1Y1cxU1dKZzFuM3FIMDJNTEF0RWl6?=
 =?utf-8?B?d1dNSVhjaVR5N3A1ZUgrUkVxNDBDUmhpKysrYjlEZTJVRWpScXphWUovRWYr?=
 =?utf-8?B?dHA3K1dMY3BtNkEzV2J6M053dmNHWDE3S2Y5d3ZXb2lraUNxdm5BZnFmUXVQ?=
 =?utf-8?B?L0U5eXBTWVhoYkpkWjFiN0xWYkRmVUlGQURidmROMVJtT2EvU1pSSUtvMDNx?=
 =?utf-8?B?VUllaWZ3TEhZZFQ2eDRsemJ4K2IzWU95RG5iSlRDeHFUYmhkR0d3cGt1eEty?=
 =?utf-8?B?WFhxeE1ocHp4RkcxZWE2YTRpcVBsZjVpbWhXaWN6NTE1eUFFdEgwbzlGbjB5?=
 =?utf-8?B?KzVENzFNakc2RVYrZUxFQWJ1MTJPdG41c0hpR1pNczlEWjdTenZzaUIxZlFw?=
 =?utf-8?B?ak1HYk81b216aXFKR3VobWVFQnVWZUVkTEw3Mkx4UEQzS3UySlJLNjZuMzJB?=
 =?utf-8?B?Y1ZKS2syeW1yOGRJc1kxK2NXNUdoWmxFZ0M3UmNvVC9IbkF3THBvZzZpbXFD?=
 =?utf-8?B?R0lZQlZncXo1Nmg2MDFOVTJpTEtFMWZaQTF2dm03QVdvQW1mNWdDZnFBdThy?=
 =?utf-8?B?VHR3cy9vbzM3cEE1V3FNWHBBY25oUFB1RWNSejNUcXBRNE5GU0dXdDdYUUUw?=
 =?utf-8?B?NTdHN0JXT2dHRDk2QWc4dEVHZEJYbEoyRjl1WmpiSE5XS3cxbFFweVBkSm1a?=
 =?utf-8?B?dlBjb2Yya3FFa1JIbjJFREt1dkU3dVhwZTNUM0plNWVIa2NWc0xmQy8zSU51?=
 =?utf-8?B?ZEdKenhlSk5rNXNKbnlSRndaYVI5VzQrYkgvRWxJMWxEaEE2d2dpaUdWcmxM?=
 =?utf-8?B?akpwYVV5UmszZjRHQjBCN0U0WHhOT2VYZkVTNFRtQ0FKMTdiMkRWd01TbGVE?=
 =?utf-8?B?NW9MR0U4aWt6eFR3Ny9GZmZ2RnRFWTI5bTFZMlZiNXVJVnRnWDVDQjc0YU0z?=
 =?utf-8?B?RTBDY0hiV2xEaFA0anI4RHRtbWdiQWRvVk9FLytwdklXNWUxaVdHd2V2aDRu?=
 =?utf-8?B?LzlPMUMrZTR1eWd6bkxnVkZFU3ZsM29sQmp1dlM0bDZHb1QwUnAxSWlvWEVQ?=
 =?utf-8?B?SDQzcjE5RXRmb2duaDErdDA2UVBhTEc5WWtmdXYzQkhicVRmNHJzemxtS2Mz?=
 =?utf-8?B?Q0xac3hiR0poQ1ZNYUNXVmp3emU2blZCbk5oUWlEeUFDeFdYWnB6NmNqYzB6?=
 =?utf-8?B?cGIxQlpFa0pXSlFFQ0lPQ3FJWE5mbGhQdlVHOGpQNlljZ1VndkdIZFA5WDZo?=
 =?utf-8?B?YU5kYjQycmRvV2tZMmtTRkZCQnJQeXU3YzFnbUV5TUNpWGZLaUVOMXlEQk1h?=
 =?utf-8?B?SHVwUXZJdHhUc3c5M1hjY3JsMGphbUh2ay9UR2pQRGNVcnVkQ2ttZGM1ek5N?=
 =?utf-8?B?SkJtMS85WGxLMjZNWnNrRHlzdExaMnNIcWw0cjhPMjVJVXdWWTNvOEtkeE1C?=
 =?utf-8?B?U3NFWDdiSTFPa2tmbXlvekFUU2ZaYlhnd1NSak5Vdk44aXNrOW5GYjJYMW1R?=
 =?utf-8?B?bE82S0o2aTF3bmVlOGthNjA5RGhtRGlaMzIrVWRSOHVGb25EbytUZHVRWmdk?=
 =?utf-8?B?cUxTbGlkWnhoTXNXUlp2RDJYZEhibXJhRFp3aGpvVjZNZUJwODR1Y0hlZ2VH?=
 =?utf-8?B?d3VDekV2MmN5TCthSlNlN2hFOG5zTUNIM2JYTk5SRjlDSyt4T3Qrbi91YldE?=
 =?utf-8?B?S0t5ZTBFb0FGM3ZlWlhrVDNXZnB1VjBqNTRObWNiaG53dUttQzRGVnN1YTMr?=
 =?utf-8?B?YjZrTmcrSlE2L0toT2IvYlpzMzNDU1dnUWwvWTJ3RXRpT1B0bngyVDFscjBY?=
 =?utf-8?B?anVOWUFVVVZibTREUVZONkNzRjNNYjNxTDZHWk5Ec0dYbWZwOGxzOXlyOTV3?=
 =?utf-8?B?Yk1CYXpjd1BxM2ppaGdEeFI2MDd6RGRFckprZzh3Z3ozVmJzbmZ4RVZqb214?=
 =?utf-8?B?bHQ2VElndnphWUZrY2pqVUZ4b0NsdXpER1BkL283SFJSZVNpQU5nRkhtMVBC?=
 =?utf-8?B?QmVRTEprN2RzWkxUOVc3blhqWk1EdnJRR3RBZ0xodkNoL29ZbE8wMkRZOWRp?=
 =?utf-8?B?dzZpemh6TGhWN3ROMzk1MXRhOEJ3NXVUUzdSYngwWTNaZ3hYaDNkdz09?=
X-Exchange-RoutingPolicyChecked: 0mR3wV4vEXHFdyQxBMgNz52u8WqwcR07/u1sR8SeUP9dXbzcAoQcPyzjBI1BAc2MHUdUiLxCxWoQ2fDzmdbtrgzUyS4NT6bJmsF5Q8woVqblo8JNGCBkdp6rb3r+63bkc37kt9s1JC5tpXS00ORfOPFppm3Hpjsdjjz/XYO2KLLMPE380CxvxitaBhbmrSwTkJE0O5thRa1B+fCG/CRbgkJIBghkt6YOVpBw8lyKItle7L3t92Lp8UlX6pgY1otoLS4Wa8s/1lN1K9DR00a0o4Wf7fi84p0lFgPrFwTaE6e4uM9NTxmSAzQ/ENxQckCDczIjEM3aOcEP9pYH7ZYpnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39723d62-8684-4f22-6b54-08df0d4e4efb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:10:10.9861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DeHyrtLm0LnDC1Cvb9f75THjhOh60eFC2NCjX5oe7E2ZmrzisIrN2fpzgOV4lRGdgWjOPH3a/bGyg1khTCkRbddWeoRm8F//Bqhve2l2bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
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

On 8/25/2026 5:29 AM, Paolo Bonzini wrote:
> 
> Other than the first three patches, and other than not reusing decode_root,
> this is mostly the same as the RFC[1] since I didn't have much more
> time to work on it.  System mode emulation was tested very little,
> basically nothing more than a simple initrd that runs a few instructions
> and does xsave/xrstor.
I really respect your taking this on while being busy with so many other 
things! Otherwise, this could have been in hindsight. Indeed, we Intel 
folks should help testing effort here at least. I'm sure Zhao did some 
test as he continues commenting.

I just tried to look through what I could digest (if that's helpful), 
although I'm not familiar with the Qemu side of things.

Thanks,
Chang

