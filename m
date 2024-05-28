Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40395C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 03:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBn4v-0007xw-Ej; Mon, 27 May 2024 23:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBn4r-0007xS-Lv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:00:41 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBn4p-0006Z8-Hi
 for qemu-devel@nongnu.org; Mon, 27 May 2024 23:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716865239; x=1748401239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T6wa4V8k4HsEArbqMntBaA0Ae23r14pa7sQheBSLiCE=;
 b=emcA65vBgnYad9CLKBFRtIAWZJDU0+MuXA7cNG93VgLdSciAglfr1zz8
 6GnKm7egt2c1n2PdKX2kKwCzll1KdX91CaTF/2EJtEqYhf0RMWw3F0bT7
 eioca/5gRpHKgcyj98ExIVvZPqqk0f8e0EgBp61LPcxWjpQnsCg3ZdvBV
 JOpf75SagFf3uBxCIzxhNYURRA+OImR12lf0L4iGgSxy7+fsd0BwKuAnC
 jAp30jpVWsunAm43RzG2A+PShd23ZLzwHjRymMzObTGWbJhyDq3Zfc2w4
 pTRXjs2EmJ7ZTfG1tXjkk9gNZVW4F2yaNo2UOVOgQQHsKf0Y7Z83hJg3X w==;
X-CSE-ConnectionGUID: lAOBlaMtTTKNxgPBobJFYg==
X-CSE-MsgGUID: 0OKGsyFdRhuO+e7t9i9vyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16978599"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="16978599"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 20:00:36 -0700
X-CSE-ConnectionGUID: oOBUNsuoRquq/2rmnCRS2Q==
X-CSE-MsgGUID: KxLb6KKoRRanxT4lgVO80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="34835570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 May 2024 20:00:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 20:00:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 20:00:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 20:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKFiazXa4sZDpZsAtiIebyjhAg0Mz8lfvQH3AZff40KR2j71A7hxqBJBEOzQ4fhrCkvMsRUi2jmei3O9QpVkL4480UKZM3+ZG/+C1nRuo+uP+evN7/ol2Hi86BbjoJv+JCpC7VOOI7WKqX3sYHYBr3HkBFfv7pSnEARYgcx6bPgdipa1rXGLTfiRvXOVONdLjqyER1qqYvPS4FQwyvVQ8z/cgsUtKDhfKxhwY6nby5EIS7jCy/jrn/ccDdB6h3A02UqmQgEhRnJGJbqlcUygpvbIwoUrWpQQEpM91frH01waEBx3EX4X2qkfKRTdsmASTlpfEc9NSclf1Mr66ta5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6wa4V8k4HsEArbqMntBaA0Ae23r14pa7sQheBSLiCE=;
 b=hjfgw6eVFoVcyFjZN9DgkhpMYPnQ0+FGU7cqjWKaIW/DVPNK0Y8akhuTSse/QqDFoXlF7s3EPi5sGG3PT1txBjSoGk7l1PLhrExBA9JnzH6ImctdelQf9ws1dMMlvbabYngFIOBgXaveg9YLRTvzj6yDN9+YzZjJnfqDHmQ5hFwLJPyfll5QlPXU6Vsg9ydqz3JE26wAFkz7L8OjTSwEutSccifToYV9ujcPTLx6h3K8NYqQRnAybHWLlsrX7hW2Hd/rPEPmoLcHUvuln/zPoGawBrXSTYNW8D1HA8cE7205rN0XAgvt4Ck5g6ELR8WmAPfKoYOeD9ALEMYgOcCSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 03:00:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 03:00:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v5 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Thread-Topic: [PATCH v5 19/19] intel_iommu: Check compatibility with host
 IOMMU capabilities
Thread-Index: AQHaoSdMDXMFcRwp4ESmzL2SXV9lBLGrLnCAgADjqkA=
Date: Tue, 28 May 2024 03:00:32 +0000
Message-ID: <SJ0PR11MB674418B3FDD3B3EC2BE8967B92F12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
 <20240508090354.1815561-20-zhenzhong.duan@intel.com>
 <ba1476d7-624a-41bf-bd73-8463c7460239@redhat.com>
In-Reply-To: <ba1476d7-624a-41bf-bd73-8463c7460239@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7925:EE_
x-ms-office365-filtering-correlation-id: c3510f59-54a7-450f-514d-08dc7ec256a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|366007|376005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?TU5OWVpjNUd1YlFGUWxZQTBibm1BSGZYdncrT0l3TG13MWRxS2thREdwN3pn?=
 =?utf-8?B?eXZ5VHZNZ1hQRDNrNVcyYmpiSFAvTDZsWUY4QkpIdG9HSEZJVW5MWWNzTjU4?=
 =?utf-8?B?dHdXWVdoaWV0dTV2dmM2N3JmUXVxNzVmSUZkaVJCSi9iMkt0MFFaL1B3NlM5?=
 =?utf-8?B?MVlXTVlIQWpvVkIxRE9hamVFQXdxRmE0SFBWVG9BT3hnUXI5NFBiNVovRDc3?=
 =?utf-8?B?QnVNMS9oaVdEam1JSzd0cnhxZFBqUGZPRjFaQUtlb1J4ZGFxbDczK2ZoSzcw?=
 =?utf-8?B?cVM1SXE5amM1WElmU3hQVVRMc3g1S1paUkU3UzNGNmcvTmdtSTJVV2R1Z1ht?=
 =?utf-8?B?THp6cE12OGVYZStGT3ptOEZzTHYxNWFLNUhpOWRIelRBS0NPTWxpQ1VXS3FF?=
 =?utf-8?B?UGV6b0ZTSXh6M3ZvYVRuWkcrQVJjTEVoQ0NlQ3o1Mmw3MnVncTFpellxUjN1?=
 =?utf-8?B?eFhTa252RllIMnZYeURZK2U5VGF3ZTlUVFJSQW5LTUppM1NabElUbjBJT1My?=
 =?utf-8?B?Sm04MU5QODdmdllYRW1Xd0tXT1FBQW5OT3ZzZWhRZVRPdGs0QXUvTk14aVR1?=
 =?utf-8?B?UjMrTmV3VjQ3S0pYZml5VnFyaFYyUmd4VkU5NmhyYm9lZWhkck85NStydWNC?=
 =?utf-8?B?YkZRZytXRjU1cklIQkwzdlIzQ0R5RWtqNVhxWWdKZlNlMzUycFdwNWtsTXor?=
 =?utf-8?B?NGgrU0NYSVFtTUYwMlBBRCtmVFl6bnpQM1h5YVdWUTQ1eEpQdmZjMXV4Wnd2?=
 =?utf-8?B?NzJvY1lVNC92TDFHWUxCUEhFM1N3UkRucUtlYWlWU0ozSGR4ZzlTbDdydUxx?=
 =?utf-8?B?Qnp0REVuajk2enR2aU0xNlBOb082NFhXaHZObFIwbE5hWFFwcnJHZ2xWem5a?=
 =?utf-8?B?SWw5Rm5QQTh4Y21YRzIyaS91UVpJZGg0VnhwaEJlQzhFandWaEYrT3l4RTZs?=
 =?utf-8?B?dHJZZzlFQy9FQktoSGkybWZGN1RZM3REMHZ0Rys2dDBValdaNFljQ1pvVk8x?=
 =?utf-8?B?d1REQVg3MG5zMG1GMk9yOUNuRmZPV3dXSlZNYVQ4Sk4xbzdwMkFWSzNMaWE2?=
 =?utf-8?B?ZEZvd0JvamRkNm5XSlV3YndRSlBoUm1yZVBPaGozTjJCV01vcTE0d1djNVJz?=
 =?utf-8?B?YXYyalhSeTVidmtqV0wvY0ZhOWlWS0pRc0dIMkM2dUxSTmRocFhFREQraDMv?=
 =?utf-8?B?UDA0WFBaeFhOUEN5b2dJbS8xWCs1cDFaVzBCSWlyYXFmNEhYQkdzZ3B4eXBY?=
 =?utf-8?B?emNMeUxHS3E4NkczbE5SallsenZzWlZ1ZkpuRmYzM24xdXJ3bEE0aGlUYnpr?=
 =?utf-8?B?T0RTWWtWanUwS1c2VDNqd1gyNnNzQkdXakhSR2FBUlJVRmFxTkxPQzJ5RHZQ?=
 =?utf-8?B?WnVueGJITTFyd1J6Wk00NXEwNEQ2eFFIa0VsSS9ZOFBtMjBrTzV2bVVaOVFC?=
 =?utf-8?B?SE5EQjBpdkFPQVdlVnc4UDgwcmZzcmlONDc1NTYxZ2kwZGltZVV2SWNIblAw?=
 =?utf-8?B?RlhSTHNaSkprblRmYytaN3dsQTFnTnpJaWt2bC9MdWwzVzNSWUpUbzF6eGpJ?=
 =?utf-8?B?TkE1UUNtWWZHYzk0YlZQb1RPTmQzOHVMR01JcjFZRkJjVWRGbjF2dkw5TzZ5?=
 =?utf-8?B?cVhQSFNKbW1iYlhhcDdVdTJrWHhXcTdKck9tYTVpZzlPdDRBSE95THFEN2hi?=
 =?utf-8?B?a2lBSzZxa3pYbm5OajRyYW50NzZ5WkhTOUdzaUxlWGNZSHFQc0NTT0hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1gyVFE0czRjWU1Bdk1OVTJBNlpWMWlUQlF5OGN1ZHhxbUpPYkxXK3l0aU1X?=
 =?utf-8?B?MGNGRWlzVXNNaVlHT1RsSzk2a2ZZSXdpMCtrVTVjcFVuSHJ2N3pDbFQ3TUht?=
 =?utf-8?B?ZXdSSHMrU2RrcnNLWWlFNGxmRWY1WGp5dW4rNjBOdW9QM3pRQmpWT3hGOHpC?=
 =?utf-8?B?Q0ZOL2d5SE9OT2VhSnBZMHN4S0tMeVFhOEp4bS83dWtlQmF0c0YwWVN0SlEv?=
 =?utf-8?B?RzJrMXZ3OFhnZXIwTXdqUEphbGp0ZjFTUmk1Mjd0SFExS2NmOVdrTXExamQ4?=
 =?utf-8?B?MWtRWmp3eXFKck1yeW14SGlqMGVyeWNqUlpvRm5OY3JyUFBYREtUcmQwNnhq?=
 =?utf-8?B?bmJJUVM5U2R0U0JKbWRYVFloWUxHQkFBSGlZVUR0VVBQaHJhTUcxSXdYUUFr?=
 =?utf-8?B?MFJJSEc2cGZ1Z1dEV3ZidkR1WXJnWW4xbVZXSXRqaFY2YlpzeEttYVJJYVVW?=
 =?utf-8?B?RzJYWjVlNVk3R3M1QlE3UXc2eVRCNHlEYTF0UStXbHB0K3dEa29PeERoLzYy?=
 =?utf-8?B?WFZDanpqaURWYzlVUXV4OTVqRGZRRFRIanR2Lzg1MHpwaEprOWx0b3VtcFU2?=
 =?utf-8?B?b3FjajBiWVV5RE1jeGJWekUvTEM0VmFlYVpJWDMyRXV6WDhSNldIYStIL252?=
 =?utf-8?B?cjBUNTRBZGluRTgvOTZUR0QxWWZDMkRJalJYUlRZTWZxWUlubzdsT2pZTzh6?=
 =?utf-8?B?QlE0ZVk1Z2Z4QjR0Mk1LYlhndWZXZ2FrYU5yS2lJaHhManVxQjFEMHdTRVhW?=
 =?utf-8?B?cCtrU1RscEJIVVd1TUZLSU43WkdjdUxLTllDRW5FMmozR3Rxbi9YSElmK01o?=
 =?utf-8?B?S082bzVnTjJkSkJTUGpGNmlSRDluc2U5akJXbDFaQW05Mk1ZR0xQRFl4SXJF?=
 =?utf-8?B?VFRUM2NHVGdCTW16cndtZlArU0xlbEZsQWtka2kzdjdiR0JYT0t5VlpxNlpZ?=
 =?utf-8?B?MnNaZ1lBcXExKzB2NmhxUWx6dU5lMWtYQXZPTW5nSHR2bkY5ZURCQmUzOGFh?=
 =?utf-8?B?eFZvcCtFRVZLc2FWSnh0OEVxeUxXenRsTjNiaGw2eWdUaFgwNUhvcW4rZlRX?=
 =?utf-8?B?WXhDOVhmaklabnJuK1NERTBBc2hWMTV2dE5CQ3pZUFBQcEdHL01nT2V2ZVhx?=
 =?utf-8?B?cmJwRlR0S0NMYjJiQjgreVZNSlpHeUlCKzJHcEtFamkwQzIvbzNwODd4SWhX?=
 =?utf-8?B?d0dxZ08wTDNjK2FacjdEMG11d2NENGQ5M1FjOFdQUkVSSi9aMU5CU2RHVVFk?=
 =?utf-8?B?aVIvMCt5cFlNOVBzMi9jVlNnbnJrNEUxRW9NM1puSlhmdkgzMGFHc3ZzTzFU?=
 =?utf-8?B?TWlsWjE1TTlET3dZcXpwTkJ1bGhzOE5zNjlnOHUxRkJqMVhXUWRENXNDb0RP?=
 =?utf-8?B?WDhrb2ZpNXFUcFZSdlVYaHc0aUhWTExsRlJMempnUVU0elYweXhIUHRUSTcv?=
 =?utf-8?B?RXVIR240V1g3aGoxVEI1QVdIZDVVNjV4YTBvanBwUVltMVN5KzhYZzFRSGY4?=
 =?utf-8?B?RU9IdnRRMUF4NlZtb1puRzM2TExqa3dER0NGU214ckszNWVmM0h5SGNnL0xT?=
 =?utf-8?B?VXU0aUFJQjNybC9GdVJlaEgvMXI3ejNmbXprbFRoZHpXMHIxS01rbDIzWXFw?=
 =?utf-8?B?aXFkQWpJQnI1L3Mvc3lUVDQzNnJuNmpHbHl1K3VaR0Z0VFhKMWFPem9RUlkx?=
 =?utf-8?B?b09ybnEyVEZQMWRjVDdjTDZ5RXRkT2txRWgrelEra3VxZkRMNmhNampBcFZx?=
 =?utf-8?B?SFRuZFlrTWtPb01wTUYrMWdkYUEvRzdqMEJJWjFLU0hvcTkweVM2UFRFMDdx?=
 =?utf-8?B?czUxVi9wbjZ0Ym1OQnlPakFQd1o3V1N5ZGVUTmZmQ3BESloxUTdlWEpQQ1Fo?=
 =?utf-8?B?NTk4anlVNFlGcm1vRGMrS09JS0F3MkE1OEUzVFo5S1l2YVJSR2xNSWlQYklj?=
 =?utf-8?B?RU53YjZvUTVnMFhwY1NoaDNMWms5TEVzOGQ4NWdCdXpxRTNTNXA2RkFvVzRY?=
 =?utf-8?B?czFzNEZSRVU0T25jKy9ZQm00OUdJMi9PR044NzZ5SjhpME83d1FFZzBNc1pB?=
 =?utf-8?B?TXFFRGN1ekVEU0NlbE5mbEtmcFEzSHh3K0NYYVoxWHRlZE9nNFlCbWNZRVpG?=
 =?utf-8?Q?GeSckg1vhbMtRA5EXsIkYEBZE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3510f59-54a7-450f-514d-08dc7ec256a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 03:00:32.2358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYcGn+yVs7r+uE6tKvCKmbUcMiYb6szUcnkoGMa6tXZgtomsKSGbLQE8n2P4OT4caNn/A5TnBvCQSlbyK4ghTVzNeDxBRrsAyek2YbpCW5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDE5LzE5XSBpbnRlbF9p
b21tdTogQ2hlY2sgY29tcGF0aWJpbGl0eSB3aXRoIGhvc3QNCj5JT01NVSBjYXBhYmlsaXRpZXMN
Cj4NCj5PbiA1LzgvMjQgMTE6MDMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSWYgY2hlY2sg
ZmFpbHMsIGhvc3QgZGV2aWNlIChlaXRoZXIgVkZJTyBvciBWRFBBIGRldmljZSkgaXMgbm90DQo+
PiBjb21wYXRpYmxlIHdpdGggY3VycmVudCB2SU9NTVUgY29uZmlnIGFuZCBzaG91bGQgbm90IGJl
IHBhc3NlZCB0bw0KPj4gZ3Vlc3QuDQo+Pg0KPj4gT25seSBhd19iaXRzIGlzIGNoZWNrZWQgZm9y
IG5vdywgd2UgZG9uJ3QgY2FyZSBvdGhlciBjYXBhYmlsaXRpZXMNCj4+IGJlZm9yZSBzY2FsYWJs
ZSBtb2Rlcm4gbW9kZSBpcyBpbnRyb2R1Y2VkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lv
bW11LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA3NDdjOTg4YmM0Li4wN2Jm
ZDRmOTllIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yMCw2ICsyMCw3IEBADQo+PiAgICAqLw0KPj4N
Cj4+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVkZSBDT05GSUdfREVWSUNF
UyAvKiBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UgKi8NCj4+ICAgI2luY2x1ZGUgInFlbXUvZXJy
b3ItcmVwb3J0LmgiDQo+PiAgICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KPj4gICAjaW5j
bHVkZSAicWFwaS9lcnJvci5oIg0KPj4gQEAgLTM4MTksNiArMzgyMCwyNiBAQCBWVERBZGRyZXNz
U3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMs
DQo+PiAgICAgICByZXR1cm4gdnRkX2Rldl9hczsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgYm9v
bCB2dGRfY2hlY2tfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZQ0K
Pip2dGRfaGRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnAp
DQo+PiArew0KPj4gKyNpZmRlZiBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UNCj4+ICsgICAgSG9z
dElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCj4+ICsgICAgaW50IHJldDsNCj4+
ICsNCj4+ICsgICAgLyogQ29tbW9uIGNoZWNrcyAqLw0KPj4gKyAgICByZXQgPSBob3N0X2lvbW11
X2RldmljZV9nZXRfY2FwKGhpb2QsDQo+SE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FXX0JJVFMsIGVy
cnApOw0KPg0KPlRvIGF2b2lkIENPTkZJR19IT1NUX0lPTU1VX0RFVklDRSwgaG9zdF9pb21tdV9k
ZXZpY2VfZ2V0X2NhcCgpDQo+Y291bGQgYmUNCj5vcGVuIGNvZGVkLg0KDQpUaGFua3MgZm9yIHN1
Z2dlc3RpbmcsIGl0IHdvcmtzIGZvciBidWlsZCBvbiBib3RoIHdpbmRvd3MgYW5kIGxpbnV4Lg0K
DQo+DQo+PiArICAgIGlmIChyZXQgPCAwKSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+
PiArICAgIH0NCj4+ICsgICAgaWYgKHMtPmF3X2JpdHMgPiByZXQpIHsNCj4+ICsgICAgICAgIGVy
cm9yX3NldGcoZXJycCwgImF3LWJpdHMgJWQgPiBob3N0IGF3LWJpdHMgJWQiLCBzLT5hd19iaXRz
LCByZXQpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArI2VuZGlm
DQo+PiArICAgIHJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIGJvb2wgdnRk
X2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludA0KPmRl
dmZuLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1V
RGV2aWNlICpoaW9kLCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+IEBAIC0zODQ4LDYgKzM4Njks
MTIgQEAgc3RhdGljIGJvb2wNCj52dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMs
IHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gICAgICAgdnRkX2hkZXYtPmlvbW11X3N0YXRl
ID0gczsNCj4+ICAgICAgIHZ0ZF9oZGV2LT5kZXYgPSBoaW9kOw0KPj4NCj4+ICsgICAgaWYgKCF2
dGRfY2hlY2tfaGRldihzLCB2dGRfaGRldiwgZXJycCkpIHsNCj4+ICsgICAgICAgIGdfZnJlZSh2
dGRfaGRldik7DQo+PiArICAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4gKyAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+DQo+VGhpcyBjaGVjayBjb3VsZCBiZSBmaXJzdCBk
b25lIGJlZm9yZSBhbGxvY2F0aW5nIHZ0ZF9oZGV2Lg0KDQpPSywgd2lsbCBkby4NCkkgbWFkZSBp
dCB0aGF0IHdheSB0byBmYWNpbGl0YXRlIHRoaXMgcGF0Y2g6DQpodHRwczovL2dpdGh1Yi5jb20v
eWlsaXUxNzY1L3FlbXUvY29tbWl0L2Q1ODlhNDcwMDAyY2NmNjA3YjU3NDNiMjk1MTYxMmY3YjQ3
OTA4MzMNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

