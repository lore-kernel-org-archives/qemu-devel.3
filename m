Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799EEC04FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx1Yc-0007TD-3v; Wed, 17 Apr 2024 05:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rx1YX-0007Sc-4y
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:26:17 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rx1YU-0002E4-Fv
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713345974; x=1744881974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E6vjds0QPa5jWyO1R13UEU5t7ApkdyMT0kk5MwaV6Yo=;
 b=fRAjiX7XZEkCLv/DzZ3il9E1Ps/rGrioUgNoanhC38gpOpnJdzt9RdzP
 fPWlMtsCLN/6RgTOuVGl/ZW7Wnc0I24GMA+mhwezTxr+ZNrFMRw7u5pGJ
 YnahPQkbk1Z05E4PvsrvJelaMo1Ls+MPO5JVu3nbMOP2M8soIFIy4bTvP
 tr7f9rHjLYXA2sVhD0Z5pzXe0ZZisROxD+fDfORh+iQUkN6oThrfy9bpv
 Xo6tv487xBbbn98RUEaAE6G3KP4I7BHlkZnUwFdr7kjyuuKUuL8fH6MeI
 xBq4IYB85wvIsuU76x1CNwem3XRXp/vR1+pROAHLgolNU30G+IbzvOJZM A==;
X-CSE-ConnectionGUID: ec0ghICNTR+8u9dD+ew26A==
X-CSE-MsgGUID: x2OkVYp+R6atK5QR7/Rm5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8689012"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8689012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 02:24:47 -0700
X-CSE-ConnectionGUID: B1cKbl+wSl+eXB2wAPh5sg==
X-CSE-MsgGUID: rdwSWKp9RIe40EqxVNekWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="22569704"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Apr 2024 02:24:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 02:24:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 02:24:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 02:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXU1zz76t5pspSulfh7+BOvhKHCbrDLmgbv0zlRiK5h6EDTZuhZ1EZH+TCfdSpImsga8cjPRfsQlukdgrTU6n36xmOQrkhoWCTdt0qClBy3OdUvry06Sj9AY3kRNWRSFkVirgPDCk88C1EnuY76vjbaEsT/aUEI4cagIacLILe07vC1sk58dRKg019frCIDI29GE4NKrO3HyBBPux4Zc6NT/gySRaK2AMHRkLSplxdX8xDIweXZfz/4ptnOasImLNHJyH4dm65pxmwNtUUjxDtE3TDait3maf+rHXP8P9Pik9gxQazZZxBgVXjh8kBUbKaCiVRTxnGpXjEfniG1X2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6vjds0QPa5jWyO1R13UEU5t7ApkdyMT0kk5MwaV6Yo=;
 b=ZM3j9RyKenatk2p4yQL8AMjMu+j5ve5A+PeZ4yY9e2dxUzutM3veyp3clqtzP4sMbkCNrPdZ9D56c3SrCfuYrBODLC2QeKisGCoQxL9vn1nirp8MfFyZGbdBucKMzAgPEuPsUaGJfGFQqQoR/U5JuSLwz1lcCjv12IvW4iJ79GBybxtNVyDfFvKenIThEukGs+WAiD1caXiJOB8jmy7MPfuzOfMr719cnwJ4AuPRW1aMoT5Qg90exSOrh8M0J3QtjxPfCn8L7MwDa1p35yPHwD9GRbLckmV/kKh1juuWb5kI//g62OLgOFzrGT448q6+t1HEwgZskV3krd5wI6SEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Wed, 17 Apr
 2024 09:24:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 09:24:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Topic: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Index: AQHaiZFH29IOEDl1dk20/jsEyJLG5bFpgLMAgAD2WaCAAIdgAIAA3yKQgABSSQCAAAwBsA==
Date: Wed, 17 Apr 2024 09:24:43 +0000
Message-ID: <SJ0PR11MB67442AA733CF06B144D33934920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
 <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
In-Reply-To: <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: 555169d3-5255-48ae-69cc-08dc5ec03765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wpc9xA4iq99QTAVM+9Fr8gM5OINAOH2Nx2MyLhBlm/ij449Qp6iVelMlt4zQCUTf+SFQ+d3uHGPLsdhDYMXbj5oIXA66VUuPcrYoX62b5ucUTR34rX5RJL8AiuixW0eGHpC3I2uJKSIQdasA+Ri/9h6G7FcIX9tlprQkRlGAMqGtBQgsj4qJnCyDcV6dkFmz5YQmBkvR4fLc369vREfJ3FPoSc0njk7RL0frtvQpc2/5SF9pPTh6w9FoOUE5RyOzQrtUUJdrBh3256eX2zaSmfIHatQ9iowC60JJIv7EIprIjLpbNKbZBEuwI6KwR7GLWMio7jmexDPY4R+JJwBlCvntyahEOyLuYfjqMSkhZc568lTfLWBXV/Jq0bu6X4hDJJtSOW/Kbca+8wZLf9RcOa3aEF+SEoEmw8ssbw7sGjCfwLuKEow91v33ijgwYiXBHKbZoHMRi81pCK6KWnLzN0D2Heapm4enxbZXZJedkW5Q5iqFLRPuo+RL8GBf+eI2S6SIDvQIqZKl1OxWBFY3+2L0IUGWgXyDpFbtM1wdWmmg2p23ccF7VBJdFdVKEg3qlaHQ5Zq9TEJRkMR3YAJTN6KQf0Od44/sf2LT62euDnGS6/e4ls+MFJwcwwDUiblk0aC1EnIEh4DTmUnr2SNOC1MoXMwPnRGrFiOWKWsuecXXzu2SMWuUA53GTgp8inoYyauysGfJNq9TZ2tiE4pkoGYihAWNzzd4IaYxBLvWbk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzBHY2pWalhKSzJvcVhhNlFBaGtiWGtNV3ErUmFJc3o2QmM4RUJGSklLN3Z4?=
 =?utf-8?B?Q1JGNDJKWjJYSW1QRzAwNnB5eVB5NFBRdmxOY1NUcEUzb2FjemRIU0JLS2NU?=
 =?utf-8?B?OE5UeFo3ZG1qS1VIQ2V4cmZ0cTZFVHNpRVNER3JlM3BPMXdZYUFXaWt0ay9O?=
 =?utf-8?B?VUtmL3l3QitsZmgraEEyZ0ZMamVxZjVaRklhMUdvcG4vbkJGYVhRaTk3WHFC?=
 =?utf-8?B?dE9WZkcwU3BGeGVGSHVRVmRxUTdncVBQR3g1NEkzMDMyWUdVRjhUNk1lbk5x?=
 =?utf-8?B?Z1RkOW5zZ25BVkE5VElPNFpCRkpUUWpjY2p3aC83Ym5LOE5zRCtzRFh2OEZT?=
 =?utf-8?B?dnZkWTY4RHB2TXNXRWsvNVJOc3dkbTl4aFNWdW9XSUUydCtuUFRpNEtzRDFn?=
 =?utf-8?B?bFBaUlhSMUs1UjFwT2VSYldERWVoS010cytIejBiY0RIeHNQWllBTXlWZFVI?=
 =?utf-8?B?a2dMNlM1RmRIbTF1U2lqekFwT3FPTndxbEdFRVdsRXJ0U3lEVWgzR08rY1VE?=
 =?utf-8?B?WmpOSkxvaDVlamw5OWF3dEYxRkQ2RnBjbzVQKzRERUdzRmxqSndhVUxDSzhE?=
 =?utf-8?B?TlFmbjlsbytGeGtlWHNuZmF4VXhaWmgxWVl3M2lUY1BLejJnZ1NOaytZVjAz?=
 =?utf-8?B?UHFjUlQ0ZSsxaDVmSkxCUklGM29jamY3eXFPamUybDFUTnNjNGptdnVVZ21G?=
 =?utf-8?B?M2gvYVBqdS9hQlVoTndlamZGNU9zd1ZYZVY3aSsxSmkrMWJrdVkza0duZVBl?=
 =?utf-8?B?azFJelcwWERvc29JcDRRaG1RalFHZlJUNCtySFZWZ1dFMFoxYWJUdlBmUEZw?=
 =?utf-8?B?T2Jxb0lReHZ5a3hWMjF6QWhpRmZ1Z3hzNmtVcElabnBNVVZ6RHF6NXBVK3Zo?=
 =?utf-8?B?QXZJUHc1cGlmR2Vua0RWdmZoaVdWQ1I1WXRLN1g2ZW9YRkhUU08wenpGdXlO?=
 =?utf-8?B?MUN0b2FIOWVYRDJRZDJOZlJRTXFyMjE1Z1haeGE5SHlnM1VBVkdFZkZzamx5?=
 =?utf-8?B?ZEVNNUhrVDc0ZUdWQUVzcGZzSDkxZlJrWEZVaHlqNmpTWHc5cm5qSEZvWmto?=
 =?utf-8?B?V2JqUW9UNkZ2eVRNMUtqOG1iaHZqTWdJVU1GRiszNTZVRWZZSHJtMjNCNTVp?=
 =?utf-8?B?bmp4TVV6NHNlVHYzV0NzeUhjMUhVZXBjdmU3dzhacEFpUVpVcVl3ODV3TmpM?=
 =?utf-8?B?TW1iUnQ5dUFvLzlUWnpsN2FKc2w4a2JqMTQ5TFdFSTVJWmoyY3lQQ0lUOUF5?=
 =?utf-8?B?UG9va1VQcWVqUmRFT2ZuQ1JneVl6TGxXN0I1c2hqYWpNb0pxbi81V2Nsc1hS?=
 =?utf-8?B?VUZKZWV2R3ZhMXhBa0M2UytFem5mcHFtUTd3K0psOWVpM0NhZ2M3Z3RJV3U5?=
 =?utf-8?B?QktyQSszZ1NRcFdvRlZBam5yOHZmeUVUOU95Q0RzaUswakZDTExKdzM5R2lw?=
 =?utf-8?B?a2VaVWZzZDB1MDRGOC9UL0RQaisxbTNXVEx6NVZUck14dEtRaDQ3VTZVblhC?=
 =?utf-8?B?VnE1WlBnZUViUWtjTE4zVHlSZzQwLzlxdDUxZm54TG9yeVl6RWJvVVNjQlhz?=
 =?utf-8?B?eG9TRGtDbktBRnFRQzVmQTdMeDhxajdMOWdsUnlvZkdvQVBNeGtHOWNLeUdM?=
 =?utf-8?B?UGdLeEpaMWM2QXVHeTVyNVRpdDdtTndLK3BmL3kzL3JGRnhDMG5HVVdza2VL?=
 =?utf-8?B?Kyt0R2FzL2VJNnc2N0lKWG9pdXNNa1hWZFQzSGFidVBMdndkaXJGWWlBTkxo?=
 =?utf-8?B?L1BkWkowNHcvRjlVaDczZmJUc3BMM2FuL1kvSXFkY0tqNXpaZXAvRnNEZlFI?=
 =?utf-8?B?SXJVRk85Nlh3TS9zMVdqbXVDOElpSTQ3eU9TQlVUZFAyUTRBS0l3TDNDK0hZ?=
 =?utf-8?B?MWpoQlhMalEvcGZQeVJ4VzUveDVCWWt5WlorSHYyQkVQZEZlMDIyaFdQMW5j?=
 =?utf-8?B?QW9YQzc0d2tDSFVVWlNpbEdobWloT0Zzb2RFWkJVNmdNazNQQk84SmFmZ3ZL?=
 =?utf-8?B?cjJxenhiOVBqWUl5L3JtR3FBZVhqSHd0VU9tY0FiTFRhWnBNWkkycWVndElh?=
 =?utf-8?B?c1JhV2owUE9xbytYUTV1Vi9RL2laNmwrMERkdXpPSHR4STRiZS9JVlVxR3Ux?=
 =?utf-8?Q?f27NWRo/OIKnZrbbbGWU5Kb+y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555169d3-5255-48ae-69cc-08dc5ec03765
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:24:43.5843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+3nOR6JHy4I96TPq5LTwQEVZAt+Fi/6wvfe7d5WCPr2/5Da+2bdCQD9/oDYhM/cGSkJOcajb4NGB+hfHG9ECXbQPST/oYacAMhmuWgQTew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNV0gaW50ZWxfaW9t
bXU6IEFkZCBhIGZyYW1ld29yayB0byBkbw0KPmNvbXBhdGliaWxpdHkgY2hlY2sgd2l0aCBob3N0
IElPTU1VIGNhcC9lY2FwDQo+DQo+T24gNC8xNy8yNCAwNjoyMSwgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAzLzVdIGludGVsX2lvbW11OiBBZGQgYSBmcmFtZXdvcmsgdG8gZG8NCj4+PiBjb21wYXRp
YmlsaXR5IGNoZWNrIHdpdGggaG9zdCBJT01NVSBjYXAvZWNhcA0KPj4+DQo+Pj4gSGVsbG8sDQo+
Pj4NCj4+PiBPbiA0LzE2LzI0IDA5OjA5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+IEhp
IEPDqWRyaWMsDQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4g
RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAzLzVdIGludGVsX2lvbW11OiBBZGQgYSBmcmFtZXdvcmsgdG8gZG8NCj4+
Pj4+IGNvbXBhdGliaWxpdHkgY2hlY2sgd2l0aCBob3N0IElPTU1VIGNhcC9lY2FwDQo+Pj4+Pg0K
Pj4+Pj4gT24gNC84LzI0IDEwOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+PiBGcm9t
OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IElmIGNoZWNrIGZh
aWxzLCB0aGUgaG9zdCBzaWRlIGRldmljZShlaXRoZXIgdmZpbyBvciB2ZHBhIGRldmljZSkgc2hv
dWxkDQo+bm90DQo+Pj4+Pj4gYmUgcGFzc2VkIHRvIGd1ZXN0Lg0KPj4+Pj4+DQo+Pj4+Pj4gSW1w
bGVtZW50YXRpb24gZGV0YWlscyBmb3IgZGlmZmVyZW50IGJhY2tlbmRzIHdpbGwgYmUgaW4gZm9s
bG93aW5nDQo+Pj4gcGF0Y2hlcy4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWku
eS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyB8IDM1DQo+Pj4+PiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0K
Pj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+IGluZGV4IDRmODRlMmU4MDEuLmE0OWI1ODdjNzMgMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4gQEAgLTM1LDYgKzM1LDcgQEANCj4+Pj4+PiAgICAg
I2luY2x1ZGUgInN5c2VtdS9rdm0uaCINCj4+Pj4+PiAgICAgI2luY2x1ZGUgInN5c2VtdS9kbWEu
aCINCj4+Pj4+PiAgICAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+Pj4+PiArI2luY2x1
ZGUgInN5c2VtdS9pb21tdWZkLmgiDQo+Pj4+Pj4gICAgICNpbmNsdWRlICJody9pMzg2L2FwaWNf
aW50ZXJuYWwuaCINCj4+Pj4+PiAgICAgI2luY2x1ZGUgImt2bS9rdm1faTM4Ni5oIg0KPj4+Pj4+
ICAgICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+Pj4+PiBAQCAtMzgxOSw2ICsz
ODIwLDMyIEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4+Pj4gKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElP
TU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4+Pj4+ICAgICAgICAgcmV0dXJuIHZ0ZF9kZXZf
YXM7DQo+Pj4+Pj4gICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19s
ZWdhY3lfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4g
KyAgICByZXR1cm4gMDsNCj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIGludCB2
dGRfY2hlY2tfaW9tbXVmZF9oZGV2KEludGVsSU9NTVVTdGF0ZSAqcywNCj4+Pj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+Pj4+
PiArew0KPj4+Pj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4g
K3N0YXRpYyBpbnQgdnRkX2NoZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+IFZUREhv
c3RJT01NVURldmljZQ0KPj4+Pj4gKnZ0ZF9oZGV2LA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+Pj4+PiArew0KPj4+Pj4+ICsgICAgSG9zdElPTU1V
RGV2aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBpZiAo
b2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoaGlvZCksIFRZUEVfSElPRF9JT01NVUZEKSkgew0K
Pj4+Pj4+ICsgICAgICAgIHJldHVybiB2dGRfY2hlY2tfaW9tbXVmZF9oZGV2KHMsIGhpb2QsIGVy
cnApOw0KPj4+Pj4+ICsgICAgfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIHJldHVybiB2dGRfY2hl
Y2tfbGVnYWN5X2hkZXYocywgaGlvZCwgZXJycCk7DQo+Pj4+Pj4gK30NCj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gSSB0aGluayB3ZSBzaG91bGQgYmUgdXNpbmcgdGhlIC5nZXRfaG9zdF9pb21tdV9pbmZv
KCkgY2xhc3MgaGFuZGxlcg0KPj4+Pj4gaW5zdGVhZC4gQ2FuIHdlIHJlZmFjdG9yIHRoZSBjb2Rl
IHNsaWdodGx5IHRvIGF2b2lkIHRoaXMgY2hlY2sgb24NCj4+Pj4+IHRoZSB0eXBlID8NCj4+Pj4N
Cj4+Pj4gVGhlcmUgaXMgc29tZSBkaWZmaWN1bHR5IGluaSBhdm9pZGluZyB0aGlzIGNoZWNrLCB0
aGUgYmVoYXZpb3Igb2YNCj4+PiB2dGRfY2hlY2tfbGVnYWN5X2hkZXYNCj4+Pj4gYW5kIHZ0ZF9j
aGVja19pb21tdWZkX2hkZXYgYXJlIGRpZmZlcmVudCBlc3BlY2lhbGx5IGFmdGVyIG5lc3RpbmcN
Cj4+PiBzdXBwb3J0IGludHJvZHVjZWQuDQo+Pj4+IHZ0ZF9jaGVja19pb21tdWZkX2hkZXYoKSBo
YXMgbXVjaCB3aWRlciBjaGVjayBvdmVyIGNhcC9lY2FwIGJpdHMNCj4+PiBiZXNpZGVzIGF3X2Jp
dHMuDQo+Pj4NCj4+PiBJIHRoaW5rIGl0IGlzIGltcG9ydGFudCB0byBmdWxseSBzZXBhcmF0ZSB0
aGUgdklPTU1VIG1vZGVsIGZyb20gdGhlDQo+Pj4gaG9zdCBJT01NVSBiYWNraW5nIGRldmljZS4g
Q291bGQgd2UgaW50cm9kdWNlIGEgbmV3DQo+Pj4gSG9zdElPTU1VRGV2aWNlQ2xhc3MNCj4+PiBo
YW5kbGVyIC5jaGVja19oZGV2KCkgaGFuZGxlciwgd2hpY2ggd291bGQgY2FsbCAuZ2V0X2hvc3Rf
aW9tbXVfaW5mbygpID8NCj4+DQo+PiBVbmRlcnN0b29kLCBiZXNpZGVzIHRoZSBuZXcgLmNoZWNr
X2hkZXYoKSBoYW5kbGVyLCBJIHRoaW5rIHdlIGFsc28gbmVlZCBhDQo+bmV3IGludGVyZmFjZQ0K
Pj4gY2xhc3MgVFlQRV9JT01NVV9DSEVDS19IREVWIHdoaWNoIGhhcyB0d28gaGFuZGxlcnMNCj5j
aGVja19bbGVnYWN5fGlvbW11ZmRdX2hkZXYoKSwNCj4+IGFuZCBkaWZmZXJlbnQgdklPTU1VcyBo
YXZlIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbi4NCj4NCj5JIGFtIG5vdCBzdXJlIHRvIHVuZGVy
c3RhbmQuIFdoaWNoIGNsYXNzIGhpZXJhcmNoeSB3b3VsZCBpbXBsZW1lbnQgdGhpcw0KPm5ldyAi
VFlQRV9JT01NVV9DSEVDS19IREVWIiBpbnRlcmZhY2UgPyB2SU9NTVUgb3IgaG9zdCBpb21tdSAg
Pw0KPg0KPkNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aXRoIGFuIHVwZGF0ZSBvZiB5b3VyIGRp
YWdyYW0gOg0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLmdldF9ob3N0X2lvbW11X2luZm8oKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLg0KPiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgfA0KPiAgICAgICBISU9ETGVnYWN5VkZJTyAgICBbSElPRExlZ2FjeVZEUEFdICAgIEhJ
T0RJT01NVUZEDQo+ICAgICAgICAgICAgIHwgLnZkZXYgICAgICAgICAgICB8IFsudmRldl0gICAg
ICAgICB8IC5pb21tdWZkDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IC5kZXZpZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCBbLmlvYXNfaWRdDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IFsuYXR0YWNoX2h3cHQoKV0NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgWy5kZXRhY2hfaHdwdCgpXQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhJT0RJT01NVUZEVkZJTyAg
ICAgICAgIFtISU9ESU9NTVVGRFZEUEFdDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgLnZkZXYgICAgICAgICAgICAgICAgfCBbLnZkZXZdDQo+DQoNClN1cmUuDQoNCiAg
ICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAuZ2V0X2hvc3RfaW9tbXVfaW5mbygpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgLmNoZWNrX2hkZXYoKQ0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQogICAgICAgICAgICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS4NCiAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KICAgICAgICAgICAgICAgSElPRExlZ2FjeSAgICAgICAgICAgICAgICAgICAgSElPRElPTU1V
RkQNCiAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAu
aW9tbXVmZA0KICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLS4gICAgICAgICAgICAgICAgICAg
ICB8IC5kZXZpZA0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICB8IFsuaW9hc19pZF0NCiAgICAgICBISU9ETGVnYWN5VkZJTyAgICBbSElPRExlZ2FjeVZE
UEFdICAgICAgICAgfCBbLmF0dGFjaF9od3B0KCldDQogICAgICAgICAgICAgfCAudmRldiAgICAg
ICAgICAgIHwgWy52ZGV2XSAgICAgICAgIHwgWy5kZXRhY2hfaHdwdCgpXQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICB8DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSElPRElPTU1VRkRWRklPICAgICAgICAgW0hJT0RJT01N
VUZEVkRQQV0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IC52ZGV2ICAg
ICAgICAgICAgICAgIHwgWy52ZGV2XQ0KDQoNCkhvc3RJT01NVURldmljZSBvbmx5IGRlY2xhcmUg
LmNoZWNrX2hkZXYoKSwgYnV0DQpISU9ETGVnYWN5IGFuZCBISU9ESU9NTVVGRCB3aWxsIGltcGxl
bWVudCAuY2hlY2tfaGRldigpLg0KRS5nLiwgaGlvZF9sZWdhY3lfY2hlY2tfaGRldigpIGFuZCBo
aW9kX2lvbW11ZmRfY2hlY2tfaGRldigpLg0KDQppbnQgaGlvZF9sZWdhY3lfY2hlY2tfaGRldihI
b3N0SU9NTVVEZXZpY2UgKmhpb2QsIElPTU1VQ2hlY2tIRGV2ICp2aW9tbXUsIEVycm9yICoqZXJy
cCkNCnsNCiAgICBJT01NVUNoZWNrSERldkNsYXNzICpjaGRjID0gSU9NTVVfQ0hFQ0tfSERFVl9H
RVRfQ0xBU1ModmlvbW11KTsNCg0KICAgIHJldHVybiBjaGRjLT5jaGVja19sZWdhY3lfaGRldih2
aW9tbXUsIGhpb2QsIGVycnApOw0KfQ0KDQppbnQgaGlvZF9pb21tdWZkX2NoZWNrX2hkZXYoSG9z
dElPTU1VRGV2aWNlICpoaW9kLCBJT01NVUNoZWNrSERldiAqdmlvbW11LCBFcnJvciAqKmVycnAp
DQp7DQogICAgSU9NTVVDaGVja0hEZXZDbGFzcyAqY2hkYyA9IElPTU1VX0NIRUNLX0hERVZfR0VU
X0NMQVNTKHZpb21tdSk7DQoNCiAgICByZXR1cm4gY2hkYy0+Y2hlY2tfaW9tbXVmZF9oZGV2KHZp
b21tdSwgaGlvZCwgZXJycCk7DQp9DQoNCkFuZCB3ZSBpbXBsZW1lbnQgaW50ZXJmYWNlIFRZUEVf
SU9NTVVfQ0hFQ0tfSERFViBpbiBpbnRlbC1pb21tdSBtb2R1bGUuDQpDZXJ0YWlubHksIHdlIGNh
biBhbHNvIGltcGxlbWVudCB0aGUgc2FtZSBpbiBvdGhlciB2SU9NTVVzIHdlIHdhbnQuDQpTZWUg
YmVsb3cgcHNldWRvIGNoYW5nZToNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
YyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNjgzODBkNTBjYS4uMTczYzcwMmI5ZiAx
MDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQpAQCAtNTUyMSwxMiArNTUyMSw5IEBAIHN0YXRpYyBpbnQgdnRkX2NoZWNrX2hkZXYo
SW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oZGV2LA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KIHsNCiAgICAgSG9zdElPTU1VRGV2
aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCisgICAgSG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhp
b2RjID0gSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpOw0KDQotICAgIGlmIChvYmpl
Y3RfZHluYW1pY19jYXN0KE9CSkVDVChoaW9kKSwgVFlQRV9ISU9EX0lPTU1VRkQpKSB7DQotICAg
ICAgICByZXR1cm4gdnRkX2NoZWNrX2lvbW11ZmRfaGRldihzLCB2dGRfaGRldiwgZXJycCk7DQot
ICAgIH0NCi0NCi0gICAgcmV0dXJuIHZ0ZF9jaGVja19sZWdhY3lfaGRldihzLCBoaW9kLCBlcnJw
KTsNCisgICAgcmV0dXJuIGhpb2RjLT5jaGVja19oZGV2KElPTU1VX0NIRUNLX0hERVYocyksIGhp
b2QsIGVycnApOw0KIH0NCg0KIHN0YXRpYyBpbnQgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBD
SUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCkBAIC02MDc2LDYgKzYwNzMsNyBA
QCBzdGF0aWMgdm9pZCB2dGRfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZvaWQgKmRh
dGEpDQogew0KICAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KICAg
ICBYODZJT01NVUNsYXNzICp4ODZfY2xhc3MgPSBYODZfSU9NTVVfREVWSUNFX0NMQVNTKGtsYXNz
KTsNCisgICAgSU9NTVVDaGVja0hEZXZDbGFzcyAqY2hkYyA9IElPTU1VX0NIRUNLX0hERVZfQ0xB
U1Moa2xhc3MpOw0KDQogICAgIGRjLT5yZXNldCA9IHZ0ZF9yZXNldDsNCiAgICAgZGMtPnZtc2Qg
PSAmdnRkX3Ztc3RhdGU7DQpAQCAtNjA4Nyw2ICs2MDg1LDggQEAgc3RhdGljIHZvaWQgdnRkX2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KICAgICBkYy0+dXNlcl9j
cmVhdGFibGUgPSB0cnVlOw0KICAgICBzZXRfYml0KERFVklDRV9DQVRFR09SWV9NSVNDLCBkYy0+
Y2F0ZWdvcmllcyk7DQogICAgIGRjLT5kZXNjID0gIkludGVsIElPTU1VIChWVC1kKSBETUEgUmVt
YXBwaW5nIGRldmljZSI7DQorICAgIGNoZGMtPmNoZWNrX2xlZ2FjeV9oZGV2ID0gdnRkX2NoZWNr
X2xlZ2FjeV9oZGV2Ow0KKyAgICBjaGRjLT5jaGVja19pb21tdWZkX2hkZXYgPSB2dGRfY2hlY2tf
aW9tbXVmZF9oZGV2Ow0KIH0NCg0KIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB2dGRfaW5mbyA9IHsN
CkBAIC02MDk0LDYgKzYwOTQsMTAgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHZ0ZF9pbmZvID0g
ew0KICAgICAucGFyZW50ICAgICAgICA9IFRZUEVfWDg2X0lPTU1VX0RFVklDRSwNCiAgICAgLmlu
c3RhbmNlX3NpemUgPSBzaXplb2YoSW50ZWxJT01NVVN0YXRlKSwNCiAgICAgLmNsYXNzX2luaXQg
ICAgPSB2dGRfY2xhc3NfaW5pdCwNCisgICAgLmludGVyZmFjZXMgPSAoSW50ZXJmYWNlSW5mb1td
KSB7DQorICAgICAgICB7IFRZUEVfSU9NTVVfQ0hFQ0tfSERFViB9LA0KKyAgICAgICAgeyB9DQor
ICAgIH0NCiB9Ow0KDQpUaGFua3MNClpoZW56aG9uZw0K

