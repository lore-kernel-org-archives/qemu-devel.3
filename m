Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F850C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE7d-0000Jx-7M; Thu, 06 Jun 2024 10:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sFE7b-0000JV-LB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:29:43 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sFE7X-0000N9-8d
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717684179; x=1749220179;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DQF7l+3m+gUX/rwu054vM5Vyr5hyp7qvFH1jaY1fQQ8=;
 b=UuJwY4dq3QSdK5+rfVEATi75pKUReVoGseWsp0c3NfPiww8EQUzwdJvV
 izidEmSUM+cYWpvR0El28mWWnPSTek4nTaP8zVyUH7yOqGtCxuG684LWi
 4DkOE5ultBmr14RUgh7KGAv7gkckFla2sgEhfonc9GFI8eA9pj3hxD7om
 xhCtb5Yijgm9mZs19qedZH4DZMLYfS0tUsK7QCt8Py5CDdyXPp+h0g+js
 xgSIfy0ZsoL9wH31V5vIAAYxREcZDaXYG9vNgX4VliUfbhcr4xtN0RxPF
 6u4S9dziecLq8yFZYvQDqewv4VjV4geyb2xsUQOLiWzGQZ8Pl4mJZfQjV g==;
X-CSE-ConnectionGUID: VPKHiHH2TUqeMqeMONsO4w==
X-CSE-MsgGUID: teLRXjdqS+SJF/xFi3U5ZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18146920"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="18146920"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 07:29:36 -0700
X-CSE-ConnectionGUID: ZQa59q8jTFmUFohyziHNLA==
X-CSE-MsgGUID: 90Ni5cXCTMiF7/e1v3w1Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="38056215"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Jun 2024 07:29:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 07:29:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 07:29:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 07:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpzotH4bvv2llVpxX1f4WyI6Uf6L2uKQeecyJVj2fZjIjoEanqnio2OyALj0EeWLE6oqxzYmvXjhpFJwOfZbAvCyuRpmt5N+IQtXGslf1u0yCNl0KjPtwgtTvtiXpx+RBiwPD/762ZjwWE4mXXdRPjY8YdcbE7XowXDGj7/ZYcvZLoXBEod1VXKd7EV9aJ/sp9oSzTI1kixGClHiF2qLBXMolY5/+vz/ouhg9IplEvUo5TsC+qwMpbZYukHyw2kpZIvZHmNtOjlLiA0D6U5XnrK5NhjTov2cnVQtDrMeppit8HPYCDUF1kUFTgUYhUoLMt8BdvHfH2ne8/XSLlkdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rf1M33QLJRowO4vaZfXe54t2l1qyk/CM+JF6M1N1fk=;
 b=FhQi2xFk/Az8uJ0AgQFZH5ifE/92V/jQqMQqmZBShDZ/C49Xc5RiizMr7bo0KnC8xXmmaUmAfTnPGPtFXUoRDoqvGTfgSfcsWgJ2GDzsENtnSlF6ZASaR/EIUsaY/qsUAHyxWikmBtmM55vbfnUaSsrRuL7sPURA4HZ48wKrxllw3aQt+2CZBvK2/OubiEJbYkO82ozlXnHwAx0v7pTuVzR2OfKoevMNu5KACvlytLB/6biSvYzGUOt6Xwwd2eeY7CeMCRFMWc3eAdFyImAD3n6OhX89/L5F0InJXALFheKqQQWLDqFivL1/VDQcVLS9No49HDZ4+ep3RCrwgtma3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:29:29 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:29:29 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Topic: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Index: AQHatoIOkzCC5BZJ1kmOKxeDB7vItrG5waWAgAAvfGCAANMoAIAABD1w
Date: Thu, 6 Jun 2024 14:29:29 +0000
Message-ID: <PH7PR11MB594111BC3D259DBC87ED1612A3FA2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-7-yuan1.liu@intel.com> <87plsvni18.fsf@suse.de>
 <MW4PR11MB59366D87600EA832A8248F2FA3FA2@MW4PR11MB5936.namprd11.prod.outlook.com>
 <87frtqnpqt.fsf@suse.de>
In-Reply-To: <87frtqnpqt.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH8PR11MB7143:EE_
x-ms-office365-filtering-correlation-id: 0a56bbe1-d4fe-46c1-ad79-08dc8635136f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YUzmPrqk8CD+kdcYNyor7piMpRZHqpLrjy2XDy7Rmc1b0jpJO7CYx2c5Xc1h?=
 =?us-ascii?Q?K0LxWEjpK0dOSWkF/XsB8CE+B2V4qrlVjbzkH5VzBqZZN94paLtPgJ9/S3SS?=
 =?us-ascii?Q?IeGrnsJwqvdMdcJtLCkC83+uapIfWIAJ9Xk705K8y5evqgOwEyeilBeZYC4S?=
 =?us-ascii?Q?qOPZ9hOfzbMDaShGB3B9szpuHkwXFrlRrNuoRuMtVWHFjYzerwImLogJwWpT?=
 =?us-ascii?Q?sly28Vpmwtbz9Q0VfKjaovk2dNE+h8hC8tzSZvvqyY8svq4khu9b+d074woV?=
 =?us-ascii?Q?bQqk/6LeTBoUdaNExiOmv6CGAB9PuEOu2QKlJEE4+2tiFnCLq0zfAf3+tt7/?=
 =?us-ascii?Q?atURR1sUtC10fdmI32qqa4TexoBOhqc+bnKXwDt7BbYbN6YKbC99LCWHMw0I?=
 =?us-ascii?Q?m9OZWDHcpbHa+YrLKLn5nieJoVOQccF7j+jJIqKy5Ji5fMMGEtOfWCck4EKy?=
 =?us-ascii?Q?B+uJmWRgUYDw54oAG+qBSbOb7YlEQPhASwH6a2oaRL4I/S+2qRayS0KTXbgu?=
 =?us-ascii?Q?TzfJ8ysW0QKsHwu3LJMAliHnGARcUPsySsKQn7h4qlRwJ4GxseFuNu8J/Z3B?=
 =?us-ascii?Q?QETsXmj9Jaj3eBkbPtHwSWYpudAZlXyM13t4+8NxF6CYAAHdiqSj+ALIE5YO?=
 =?us-ascii?Q?UJQzVZB1k7Pv4gQ5XpTEUrpvU+MQxsDDkFPj0I9XHATJgEH/JfPJsOd4nNf/?=
 =?us-ascii?Q?dJnaV6/C+MMaSJnWEnvrtSgPNz+x/WktzuzRFL1VtdxhY2oY8slyuOaMxDUT?=
 =?us-ascii?Q?ShhA2VPD85klEGRIJ/Cl5SqJKSFna51OzR0/2b+Mx4W1zBJ9VXvlXj7x4aCB?=
 =?us-ascii?Q?2PC2YhZYh70bI/EzLnINTYvw1yeh4ze9YBHxX/IiEk95m7VsifhQhfbPhnsq?=
 =?us-ascii?Q?WyM+2or6WpBFM6mh2FRMFhJn3PKb1CbEN1uuqa4oSq0rkZwAncVvQuiFMFjv?=
 =?us-ascii?Q?DvCc63ecHbGPf26JLIWQLebphCRRzBxAePjT96/tj8egt/7DRmflkoIWWwtY?=
 =?us-ascii?Q?6EstPqYwvxAqZYjNw/vTKrYDCDtfCJ2epu6nzxvZeoxM8mB8CRdXppBFUKMy?=
 =?us-ascii?Q?TGgvJQoQnqT2STw9EGKVBpPJSpAqU7F4EFZA0i4NgGoSAf9Q8ysTEiS1900E?=
 =?us-ascii?Q?v4j/l0zuur/5uzVqh2CWf1NYeK/AiBxMKX/iHNV65VAf9EAVdwqgFz4zOOjI?=
 =?us-ascii?Q?eAtFULg8+IjSvLjx4mgrxLNagEu7A1D3Y6x2Khyw50dx8AGpaJTGEGol99ps?=
 =?us-ascii?Q?8OPoDpFw+KJapPADQCLwHUw/0VXJGxqTfb6ixIa8f9MRAvLZYyrVXEpx6o5C?=
 =?us-ascii?Q?psUk8VA3h767nhKc5XMqRxVBQdHKeuoZUZ4NknbV2DI641NKKsoR7E3BWQLW?=
 =?us-ascii?Q?ciQK64A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xp0Ika/M6IAyygBIXWwMuhbP5KpneLQYOggBnyzE0Hlx9Mgeq7ifl2ehC1Jc?=
 =?us-ascii?Q?Qak5brdbNI/eKbcDgwsDJpsmbTCiY8WLmZBRKbTCNztIsofH9pbgr3UuQXYz?=
 =?us-ascii?Q?BwtqYTeC1jleYDWDEGphBFqxmXRtVp0n/KR9h7HMarY9+uCYvenKyDbzHprP?=
 =?us-ascii?Q?m1gf2OHGdF2nMFNl5P8YnhpdumbBWOkj7RUlInXTOeIKaWAbOSNiwtluXtF5?=
 =?us-ascii?Q?TM/y1p4sSAPVovfO6ENJrlPiv4Tl1/4LqDcCuQbAPHfj75/EEp+4dW0BRnq7?=
 =?us-ascii?Q?4nnezcnUI70QlTYozpk5nDlp9A7WqrUiLjKwUh8eJqLdYvKEbQs8Vhhp7yKP?=
 =?us-ascii?Q?fwj3o0lAGIhknXJZrQ22A8K5ggYpNYifXwgP+kXn/Ts9VneYMArESYSSW4Mm?=
 =?us-ascii?Q?jhYce3kp1JaTK8edxBHzx+3++5tlEECGhNf9c5Zl4gS2y4P7DjMMPXHxlwm+?=
 =?us-ascii?Q?d1k1PQm5MvPzsNuuX+s6CObZtAWnc1Z5AfQSVI/ByTVoN0zQ+WwZDCq1UB+X?=
 =?us-ascii?Q?tTp/eiSvCT1wfgdTbIj3pg+7MoxnfsUi6gl8B5OlWiS+YH2kQi7RSqaYceqp?=
 =?us-ascii?Q?HxVWaTWWxXnd3ZcP3KsK+L6p8gd2+mgwvUBM07LE+MUoGWWDC4jxohaFJycx?=
 =?us-ascii?Q?JzRCSZKg0b4JhULrrufZ+4jDPqlLVAcykfZ/lteUT9QBGP92pfZbd8ewn/X0?=
 =?us-ascii?Q?1WIRvDoBdtz9kA5/It4eVUI1dNKelSqvtI4KhB001aajv6cX/hPrMLIBNSa0?=
 =?us-ascii?Q?2kEPqe3ag5zgmkMgvIabINsd1mjNXUPjFMkafZSm2/aVFsmF2fZzsbB+h0O2?=
 =?us-ascii?Q?Awl2/SQD3uuRecVs5yqQ6gtcnRLajzL1YoM95EfRFu3DpBZj7ZH0o9CmQE1T?=
 =?us-ascii?Q?LR1Fxks6C8sAH1PgkUJo6C1ZDH/yTMdtUxaR7UDB1TuBW+FlVA1Sdrkwhz2h?=
 =?us-ascii?Q?akiuSeYz5lXIQOkXoZ4eNFUvR/Ec1wpFzlXw5oOfScOClmVxKyURkFDce6ia?=
 =?us-ascii?Q?dOFL999+WGtW8gS1mP0rmAVmPhCfAZ42icTBul6LkDF5Ygbw90Wg6a4iVP0R?=
 =?us-ascii?Q?GQ6TZOwUZBFyzGlRhtEIbzbGXqGDeSwkmW8EQE6f4HuxzZoWtvY4RrvqPZN/?=
 =?us-ascii?Q?5ew8MEwgHY2+h0/Gs6ms6AaIUw4vlbnpR0wqI+N/VtxGY2SSR6iYIx/YwP06?=
 =?us-ascii?Q?3wXm/bwQ/41S81GpC0JaEXJW3D9JJCK03NvVYALyPirJxQQ6fSLiglBDq8aA?=
 =?us-ascii?Q?Qi9LszKAx1H2HHN6kq/VNBswHw12C5IiHlHBn8I4NF/tF6aavl/aCjV2D4mO?=
 =?us-ascii?Q?presL5Di9uNpVCkkPDQsArSXobh9c4ig5DMpOwpJZMlX7QvTJjKfNluZzMRa?=
 =?us-ascii?Q?94/LjHLk+6V89c5t2hf8SDPsK1aFCpA+JSZr49j9z+rOJnxHiefZDGPxlNBd?=
 =?us-ascii?Q?71hQ2pfddCyK/RCECKBrX2goES/ymkWMzsjreBUX6rM2kGZ0VMZCLcEsc4pW?=
 =?us-ascii?Q?RV9zu634WU4/KAKn9CjBMTGJrHNtZvcBOFru6WmGIRNQCOp5P47bHcaXbILL?=
 =?us-ascii?Q?GJ+N60nyL1ny7b4mSDFpRoQLqZh4hhVizsTkBNWr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a56bbe1-d4fe-46c1-ad79-08dc8635136f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 14:29:29.7218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9YGo3mYmfmGQRVl4vjjgOD8Gu4rZo10EiEd4FAWCEETYt37ZO9MfjpQOyqQb+QmU4fC9WjhwnbGOTiHAFroeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Thursday, June 6, 2024 9:52 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> thuth@redhat.com; philmd@linaro.org
> Cc: qemu-devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>;
> shameerali.kolothum.thodi@huawei.com
> Subject: RE: [PATCH v7 6/7] migration/multifd: implement qpl compression
> and decompression
>=20
> "Liu, Yuan1" <yuan1.liu@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Sent: Thursday, June 6, 2024 6:26 AM
> >> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> >> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> >> thuth@redhat.com; philmd@linaro.org
> >> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou,
> Nanhai
> >> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
> >> Subject: Re: [PATCH v7 6/7] migration/multifd: implement qpl
> compression
> >> and decompression
> >>
> >> Yuan Liu <yuan1.liu@intel.com> writes:
> >>
> >> > QPL compression and decompression will use IAA hardware first.
> >> > If IAA hardware is not available, it will automatically fall
> >> > back to QPL software path, if the software job also fails,
> >> > the uncompressed page is sent directly.
> >> >
> >> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> >> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> >> > ---
> >> >  migration/multifd-qpl.c | 412
> +++++++++++++++++++++++++++++++++++++++-
> >> >  1 file changed, 408 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> >> > index 6791a204d5..18b3384bd5 100644
> >> > --- a/migration/multifd-qpl.c
> >> > +++ b/migration/multifd-qpl.c
> >> > @@ -13,9 +13,14 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "qemu/module.h"
> >> >  #include "qapi/error.h"
> >> > +#include "qapi/qapi-types-migration.h"
> >> > +#include "exec/ramblock.h"
> >> >  #include "multifd.h"
> >> >  #include "qpl/qpl.h"
> >> >
> >> > +/* Maximum number of retries to resubmit a job if IAA work queues
> are
> >> full */
> >> > +#define MAX_SUBMIT_RETRY_NUM (3)
> >> > +
> >> >  typedef struct {
> >> >      /* the QPL hardware path job */
> >> >      qpl_job *job;
> >> > @@ -260,6 +265,219 @@ static void
> >> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >> >      p->iov =3D NULL;
> >> >  }
> >> >
> >> > +/**
> >> > + * multifd_qpl_prepare_job: prepare the job
> >> > + *
> >> > + * Set the QPL job parameters and properties.
> >> > + *
> >> > + * @job: pointer to the qpl_job structure
> >> > + * @is_compression: indicates compression and decompression
> >> > + * @input: pointer to the input data buffer
> >> > + * @input_len: the length of the input data
> >> > + * @output: pointer to the output data buffer
> >> > + * @output_len: the length of the output data
> >> > + */
> >> > +static void multifd_qpl_prepare_job(qpl_job *job, bool
> is_compression,
> >> > +                                    uint8_t *input, uint32_t
> input_len,
> >> > +                                    uint8_t *output, uint32_t
> >> output_len)
> >> > +{
> >> > +    job->op =3D is_compression ? qpl_op_compress : qpl_op_decompres=
s;
> >> > +    job->next_in_ptr =3D input;
> >> > +    job->next_out_ptr =3D output;
> >> > +    job->available_in =3D input_len;
> >> > +    job->available_out =3D output_len;
> >> > +    job->flags =3D QPL_FLAG_FIRST | QPL_FLAG_LAST |
> QPL_FLAG_OMIT_VERIFY;
> >> > +    /* only supports compression level 1 */
> >> > +    job->level =3D 1;
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_prepare_job: prepare the compression job
> >>
> >> function name is wrong
> >
> > Thanks, I will fix this next version.
> >
> >> > + *
> >> > + * Set the compression job parameters and properties.
> >> > + *
> >> > + * @job: pointer to the qpl_job structure
> >> > + * @input: pointer to the input data buffer
> >> > + * @input_len: the length of the input data
> >> > + * @output: pointer to the output data buffer
> >> > + * @output_len: the length of the output data
> >> > + */
> >> > +static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t
> *input,
> >> > +                                         uint32_t input_len, uint8_=
t
> >> *output,
> >> > +                                         uint32_t output_len)
> >> > +{
> >> > +    multifd_qpl_prepare_job(job, true, input, input_len, output,
> >> output_len);
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_prepare_job: prepare the decompression job
> >
> > Thanks, I will fix this next version.
> >
> >> > + *
> >> > + * Set the decompression job parameters and properties.
> >> > + *
> >> > + * @job: pointer to the qpl_job structure
> >> > + * @input: pointer to the input data buffer
> >> > + * @input_len: the length of the input data
> >> > + * @output: pointer to the output data buffer
> >> > + * @output_len: the length of the output data
> >> > + */
> >> > +static void multifd_qpl_prepare_decomp_job(qpl_job *job, uint8_t
> >> *input,
> >> > +                                           uint32_t input_len,
> uint8_t
> >> *output,
> >> > +                                           uint32_t output_len)
> >> > +{
> >> > +    multifd_qpl_prepare_job(job, false, input, input_len, output,
> >> output_len);
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_fill_iov: fill in the IOV
> >> > + *
> >> > + * Fill in the QPL packet IOV
> >> > + *
> >> > + * @p: Params for the channel being used
> >> > + * @data: pointer to the IOV data
> >> > + * @len: The length of the IOV data
> >> > + */
> >> > +static void multifd_qpl_fill_iov(MultiFDSendParams *p, uint8_t
> *data,
> >> > +                                 uint32_t len)
> >> > +{
> >> > +    p->iov[p->iovs_num].iov_base =3D data;
> >> > +    p->iov[p->iovs_num].iov_len =3D len;
> >> > +    p->iovs_num++;
> >> > +    p->next_packet_size +=3D len;
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_fill_packet: fill the compressed page into the QPL
> >> packet
> >> > + *
> >> > + * Fill the compressed page length and IOV into the QPL packet
> >> > + *
> >> > + * @idx: The index of the compressed length array
> >> > + * @p: Params for the channel being used
> >> > + * @data: pointer to the compressed page buffer
> >> > + * @len: The length of the compressed page
> >> > + */
> >> > +static void multifd_qpl_fill_packet(uint32_t idx, MultiFDSendParams
> *p,
> >> > +                                    uint8_t *data, uint32_t len)
> >> > +{
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +
> >> > +    qpl->zlen[idx] =3D cpu_to_be32(len);
> >> > +    multifd_qpl_fill_iov(p, data, len);
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_submit_job: submit a job to the hardware
> >> > + *
> >> > + * Submit a QPL hardware job to the IAA device
> >> > + *
> >> > + * Returns true if the job is submitted successfully, otherwise
> false.
> >> > + *
> >> > + * @job: pointer to the qpl_job structure
> >> > + */
> >> > +static bool multifd_qpl_submit_job(qpl_job *job)
> >> > +{
> >> > +    qpl_status status;
> >> > +    uint32_t num =3D 0;
> >> > +
> >> > +retry:
> >> > +    status =3D qpl_submit_job(job);
> >> > +    if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> >> > +        if (num < MAX_SUBMIT_RETRY_NUM) {
> >> > +            num++;
> >> > +            goto retry;
> >> > +        }
> >> > +    }
> >> > +    return (status =3D=3D QPL_STS_OK);
> >>
> >> How often do we expect this to fail? Will the queues be busy frequentl=
y
> >> or is this an unlikely event? I'm thinking whether we really need to
> >> allow a fallback for the hw path. Sorry if this has been discussed
> >> already, I don't remember.
> >
> > In some scenarios, this may happen frequently, such as configuring 4
> channels
> > but only one IAA device is available. In the case of insufficient IAA
> hardware
> > resources, retry and fallback can help optimize performance.
> > I have a comparison test below
> >
> > 1. Retry + SW fallback:
> >    total time: 14649 ms
> >    downtime: 25 ms
> >    throughput: 17666.57 mbps
> >    pages-per-second: 1509647
> >
> > 2. No fallback, always wait for work queues to become available
> >    total time: 18381 ms
> >    downtime: 25 ms
> >    throughput: 13698.65 mbps
> >    pages-per-second: 859607
>=20
> Thanks for the data, this is helpful. Let's include it in the commit
> message, it's important to let people know you actually did that
> analysis. I put a suggestion below:
>=20
> ---
> QPL compression and decompression will use IAA hardware path if the IAA
> hardware is available. Otherwise the QPL library software path is used.
>=20
> The hardware path will automatically fall back to QPL software path if
> the IAA queues are busy. In some scenarios, this may happen frequently,
> such as configuring 4 channels but only one IAA device is available. In
> the case of insufficient IAA hardware resources, retry and fallback can
> help optimize performance:
>=20
>  1. Retry + SW fallback:
>     total time: 14649 ms
>     downtime: 25 ms
>     throughput: 17666.57 mbps
>     pages-per-second: 1509647
>=20
>  2. No fallback, always wait for work queues to become available
>     total time: 18381 ms
>     downtime: 25 ms
>     throughput: 13698.65 mbps
>     pages-per-second: 859607
>=20
> If both the hardware and software paths fail, the uncompressed page is
> sent directly.

Very thanks for your comments, I will add these to the commit message.

> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_compress_pages_slow_path: compress pages using slow
> path
> >> > + *
> >> > + * Compress the pages using software. If compression fails, the pag=
e
> >> will
> >> > + * be sent directly.
> >> > + *
> >> > + * @p: Params for the channel being used
> >> > + */
> >> > +static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams
> *p)
> >> > +{
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    uint32_t size =3D p->page_size;
> >> > +    qpl_job *job =3D qpl->sw_job;
> >> > +    uint8_t *zbuf =3D qpl->zbuf;
> >> > +    uint8_t *buf;
> >> > +
> >> > +    for (int i =3D 0; i < p->pages->normal_num; i++) {
> >> > +        buf =3D p->pages->block->host + p->pages->offset[i];
> >> > +        /* Set output length to less than the page to reduce
> >> decompression */
> >> > +        multifd_qpl_prepare_comp_job(job, buf, size, zbuf, size -
> 1);
> >> > +        if (qpl_execute_job(job) =3D=3D QPL_STS_OK) {
> >> > +            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
> >> > +        } else {
> >> > +            /* send the page directly */
> >>
> >> s/directly/uncompressed/
> >>
> >> a bit clearer.
> >
> > Sure, I will fix it next version.
> >
> >> > +            multifd_qpl_fill_packet(i, p, buf, size);
> >> > +        }
> >> > +        zbuf +=3D size;
> >> > +    }
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_compress_pages: compress pages
> >> > + *
> >> > + * Submit the pages to the IAA hardware for compression. If hardwar=
e
> >> > + * compression fails, it falls back to software compression. If
> >> software
> >> > + * compression also fails, the page is sent directly
> >> > + *
> >> > + * @p: Params for the channel being used
> >> > + */
> >> > +static void multifd_qpl_compress_pages(MultiFDSendParams *p)
> >> > +{
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    MultiFDPages_t *pages =3D p->pages;
> >> > +    uint32_t size =3D p->page_size;
> >> > +    QplHwJob *hw_job;
> >> > +    uint8_t *buf;
> >> > +    uint8_t *zbuf;
> >> > +
> >>
> >> Let's document the output size choice more explicitly:
> >>
> >>     /*
> >>      * Set output length to less than the page size to force the job t=
o
> >>      * fail in case it compresses to a larger size. We'll send that
> page
> >>      * without compression and skip the decompression operation on the
> >>      * destination.
> >>      */
> >>      out_size =3D size - 1;
> >>
> >> you can then omit the other comments.
> >
> > Thanks for the comments, I will refine this next version.
> >
> >> > +    for (int i =3D 0; i < pages->normal_num; i++) {
> >> > +        buf =3D pages->block->host + pages->offset[i];
> >> > +        zbuf =3D qpl->zbuf + (size * i);
> >> > +        hw_job =3D &qpl->hw_jobs[i];
> >> > +        /* Set output length to less than the page to reduce
> >> decompression */
> >> > +        multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf,
> size
> >> - 1);
> >> > +        if (multifd_qpl_submit_job(hw_job->job)) {
> >> > +            hw_job->fallback_sw_path =3D false;
> >> > +        } else {
> >> > +            hw_job->fallback_sw_path =3D true;
> >> > +            /* Set output length less than page size to reduce
> >> decompression */
> >> > +            multifd_qpl_prepare_comp_job(qpl->sw_job, buf, size,
> zbuf,
> >> > +                                         size - 1);
> >> > +            if (qpl_execute_job(qpl->sw_job) =3D=3D QPL_STS_OK) {
> >> > +                hw_job->sw_output =3D zbuf;
> >> > +                hw_job->sw_output_len =3D qpl->sw_job->total_out;
> >> > +            } else {
> >> > +                hw_job->sw_output =3D buf;
> >> > +                hw_job->sw_output_len =3D size;
> >> > +            }
> >>
> >> Hmm, these look a bit cumbersome, would it work if we moved the
> fallback
> >> qpl_execute_job() down into the other loop? We could then avoid the
> >> extra fields. Something like:
> >>
> >> static void multifd_qpl_compress_pages(MultiFDSendParams *p)
> >> {
> >>     QplData *qpl =3D p->compress_data;
> >>     MultiFDPages_t *pages =3D p->pages;
> >>     uint32_t out_size, size =3D p->page_size;
> >>     uint8_t *buf, *zbuf;
> >>
> >>     /*
> >>      * Set output length to less than the page size to force the job t=
o
> >>      * fail in case it compresses to a larger size. We'll send that
> page
> >>      * without compression to skip the decompression operation on the
> >>      * destination.
> >>      */
> >>     out_size =3D size - 1;
> >>
> >>     for (int i =3D 0; i < pages->normal_num; i++) {
> >>         QplHwJob *hw_job =3D &qpl->hw_jobs[i];
> >>
> >>         hw_job->fallback_sw_path =3D false;
> >>         buf =3D pages->block->host + pages->offset[i];
> >>         zbuf =3D qpl->zbuf + (size * i);
> >>
> >>         multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf,
> >> out_size);
> >>
> >>         if (!multifd_qpl_submit_job(hw_job->job)) {
> >>             hw_job->fallback_sw_path =3D true;
> >>         }
> >>     }
> >>
> >>     for (int i =3D 0; i < pages->normal_num; i++) {
> >>         QplHwJob *hw_job =3D &qpl->hw_jobs[i];
> >>         qpl_job *job;
> >>
> >>         buf =3D pages->block->host + pages->offset[i];
> >>         zbuf =3D qpl->zbuf + (size * i);
> >>
> >>         if (hw_job->fallback_sw_path) {
> >>             job =3D qpl->sw_job;
> >>             multifd_qpl_prepare_comp_job(job, buf, size, zbuf,
> out_size);
> >>             ret =3D qpl_execute_job(job);
> >>         } else {
> >>             job =3D hw_job->job;
> >>             ret =3D qpl_wait_job(job);
> >>         }
> >>
> >>         if (ret =3D=3D QPL_STS_OK) {
> >>             multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
> >>         } else {
> >>             multifd_qpl_fill_packet(i, p, buf, size);
> >>         }
> >>     }
> >> }
> >
> > Very thanks for the reference code, I have test the code and the
> performance is not good.
> > When the work queue is full, after a hardware job fails to be submitted=
,
> the subsequent
> > job submission will most likely fail as well. so my idea is to use
> software job execution
> > instead immediately, but all subsequent jobs will still give priority t=
o
> hardware path.
>=20
> So let me see if I get this, you're saying that going with the sw path
> immediately after a hw path failure is beneficial because the time it
> takes to call the sw path serves as a backoff time for the hw path?

Exactly, I want to use the sw path as the backoff time for the hardware pat=
h.

> Do you have an idea on the time difference of waiting for sw path
> vs. introducing a delay to multifd_qpl_submit_job()? Aren't we leaving
> performance on the table by going with a much slower sw path instead of
> waiting for the queues to open up? Or some other strategy, such as going
> once again over the not-submitted pages.

Using a specific delay time to guarantee performance may be difficult now,
because the solution only supports shared working queue mode and when the l=
ive
migration starts waiting for a specified time, other workloads may still fi=
ll=20
the device work queue, causing the live migration job submission to fail af=
ter
a while.

I agree with your point. Currently, using the software path to solve the ba=
ckoff
time may also cause the performance drop due to software path overhead. I w=
ill=20
consider how to solve it in the future.

> I understand there's a tradeoff here between your effort to investigate
> these things and the amount of performance to be had, so feel free to
> leave this question unanswered. We could choose to simply document this
> with a comment:

Sure, I'll leave the comments on this so I can improve it in the future

>     if (multifd_qpl_submit_job(hw_job->job)) {
>         hw_job->fallback_sw_path =3D false;
>         continue;
>     }
>=20
>     /*
>      * The IAA work queue is full, any immediate subsequent job
>      * submission is likely to fail, sending the page via the QPL
>      * software path at this point gives us a better chance of
>      * finding the queue open for the next pages.
>      */
>     hw_job->fallback_sw_path =3D true;
>     ...
>=20
> > There is almost no overhead in job submission because Intel uses the ne=
w
> "enqcmd" instruction,
> > which allows the user program to submit the job directly to the
> hardware.
> >
> > According to the implementation of the reference code, when a job fails
> to be submitted, there
> > is a high probability that "ALL" subsequent jobs will fail to be
> submitted and then use software
> > compression, resulting in the IAA hardware not being fully utilized.
> >
> > For 4 Channel, 1 IAA device test case, using the reference code will
> reduce IAA throughput
> > from 3.4GBps to 2.2GBps, thus affecting live migration
> performance.(total time from 14s to 18s)
> >

