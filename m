Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E6BD1CA15
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89Ut-0007CQ-Ex; Mon, 04 Nov 2024 21:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t89Un-0007C0-7R
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:40:41 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t89Uk-0003Tb-3C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730774439; x=1762310439;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3tXwO+PzAmvpsy7icPg9QSR7thhnqfu9vs76OZGY51k=;
 b=kY0Wz6TH6aLcEgECoT74IZ+A3pAcio1CsZtXw7FHArfCoPT5J3YYkCaF
 ECGZ1nqbRF8NDnDx9vsfQkN1oQ5vO5gwqYo1/YAQzYIlQn3puVlsq8YHv
 0erNTY8j5343h9jP8Ts+QeZwOUqMptckWkObN5HUcWgGML4e3cUtarVTi
 691Bn984cIUUvv+x5ld/b8y1WBBFm810uILPahp2AWNVcxpCyVq/MW7r+
 Hi8SchPkB6Fi12jae0fSyBnbOcyq+IceumglEtTvL9wd3lya0F4d6epZu
 RIDFt0zJrepd82NNumm7cmioZ9RWbrOwI0FMrhOIxUjjt15iPQ931qrT2 w==;
X-CSE-ConnectionGUID: wC7RpEF2TCuuiAL9qqb7dg==
X-CSE-MsgGUID: tpW9EtR2SyqQpnJYTR1wnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41607296"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41607296"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 18:40:36 -0800
X-CSE-ConnectionGUID: FGEyc2qWShqOAtI5GCBPvw==
X-CSE-MsgGUID: wJc1iQQZRguOxUGO+eKyjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; d="scan'208";a="83731977"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 18:40:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 18:40:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 18:40:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 18:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlaKdo0U77kt/YRVVpJPOllceVUUnkPVjHa2ft3Kpk3z3YFOfHkJ0Vmm0daukK0WaOK5OEUm11GpfYlW1pBQzDAq4yVky58VrKvECsyJvBJTmh7XpTkK5RENXSMo+W63nFt0bCLOIuJczUG8anQcrF3gEyLpifLSc2J2jZhTeIfpkVhd6FYkEryOze0mM+2ySir63Egv1pG/uHBbiENxvlCJocBz6b1Np+k3QqM5l9Uiqeo/T117beqpGF9CcsXB1RTcR+Q1/Xwcdqe8iG3zZG0FbO/6yhVPgwZAIYV8HEgTx5pvgadILv52mO96dI7HhOjovjOJSgYPzhq64bwrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=008kP6aB31GlK+hAiARYZ9kBK89d49CygoN2gvpt3JU=;
 b=n0IJt3ibG+xlgEpkgbNK93E4KxnROuGwHAja6oZAIACWq5ZOl2oHzq7UcfyspjKGGXIVcOw1pSoMEDRKQSyRgUsFnUHz37s0Ls+rmtCrhAkV/VBOT63Fkq7H9RfTf80Hx0a/P8uV8deoKy8QvZ412B+nfNfH4wCMUnWu/uDQwMLRikCs3oj6gXRCmS2a6yVOIFwBxZdKZqZR9yX4sWpoVhwT39QLRhZRDpBai6quXGGUJyquhG90UNYyuT129kSAWX1qjEDLTDrypGdYFJr276iBTBdoKLy+Q4Bpm7yrZrxZVhE6blzw/RLU66obEtMEESLZ/nGIRPtjGJaaS2DHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:40:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:40:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Topic: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Index: AQHbLrllsz/Poj6ktkWylIhCzxfopbKnMz6AgADFZ1A=
Date: Tue, 5 Nov 2024 02:40:26 +0000
Message-ID: <SJ0PR11MB6744AF15E085F4D17DC1B85A92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <20241104094606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241104094606-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: 5a29bd30-4d67-4362-7760-08dcfd4334a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mO9FSvp6/SEx+7WeK8uq8xcaMTMATEbyY8Ha0c+xYzdMb+xyDAsn6G/QOUI9?=
 =?us-ascii?Q?jwDZf5EN8+dKPKlhwTkdcQNH4BmuRKAe8lGGsO5ul2kbIlruLd7p5U+/+dKs?=
 =?us-ascii?Q?5Y5kWre9EnqVG89muRh8icgHQevD8nu/EO1mNoos8fDNYjXnzKkQ7iDw54Hm?=
 =?us-ascii?Q?ALsEiW5nhgJ+iW1iokMTLvE3c/mUcAfLUbTacMtIV9KJ0JjQgDD3iA2WMq/7?=
 =?us-ascii?Q?J4WwPIKWLaOLnVkmELbYLQ17WvKIntcs2wgbIvX/ZYGc9GYdOUvdV6Jq2zha?=
 =?us-ascii?Q?xuENifNEfhLvNAmxUopXCMhkpg52lFpvnZyAI6Vn3E3F1vlfFEGQzSpxxy7q?=
 =?us-ascii?Q?Dwz7FC05HcJRJjwB2quNrdAmSSZtW5Q8y2nbrHELF5rdubUGWd6QNY4/WHGl?=
 =?us-ascii?Q?F6qp8Eo1wqNaohHK69bnEjrOI/lPKEdpbvIUJMKDOwQEIosUxi2BiHpuT6+l?=
 =?us-ascii?Q?1YVn9ZssoYyqYxT0PLFxy2dzCofzTkwmTEGdZ+vYLDfTwH+M/k5VZQ/ABWfT?=
 =?us-ascii?Q?YfmYGLeZ1CZBgRl3WwPFkyM9Zrk9tz4dsQgtjHZ8lNcQcRELBet+9/wgNJST?=
 =?us-ascii?Q?JqO6Ib4Y+/Q4csEFN4963I6PfcNDj1QpvYeLbveVzpKE39Y97TqB2oH7q5qo?=
 =?us-ascii?Q?3RbO4HqYIYspG5reEOfe+JJV7H8JWOy7mSmjzgFA3CJYWoc9C3PMRWUZxu+A?=
 =?us-ascii?Q?r+nybE7dHqXlrgbrzQo6FKUjHN9B1Al1zzMUwtd7fZv6/f2OLXeuFoSBcD7B?=
 =?us-ascii?Q?eXng53mcYgIMfd3/x93thHqLCTeZyytM7b/x/MPo80fE1CMxp1m0kZmCTTTw?=
 =?us-ascii?Q?vTfTuu+mezDKZ9VukwqgRW4ScKwcb9FKheymDk8Yv6gfF/kHMEapjvUa0ZOr?=
 =?us-ascii?Q?Y7xEWfmYEMaQRvnEMEthOGMvoXakdO3N1BLuc9AvrSTtAiDEgLNKlBJNa37c?=
 =?us-ascii?Q?p4sp0nxh84F4VsL73OcIFfE083SWgMkdmoGi/axkQr3tR5kUmcTicw5NNHDc?=
 =?us-ascii?Q?CqFqAQLwbbwPScUHRhTcnO5EWPa8Jp/M6tdOtTYtCs8UGP1E9lS8fL9Jc9VH?=
 =?us-ascii?Q?fuXcDUn8IaVGUWutIgATlHVCXfpE+Qp5tCZcohbBmoLelK/tGrpviOKRtUJF?=
 =?us-ascii?Q?FwrlOtZNPkNkDOy/rXDgYh2LnuiGrjYrWcpG6LTPuNPLQuUoYrNSwqafasug?=
 =?us-ascii?Q?gv10ea2XLy9Qf4+8ttA54753Zn5RHuyZzQcN15mCROP73gXKobZ9TfbaI6jQ?=
 =?us-ascii?Q?BXC/qMHrwhex8M8f4YskvSdTEPmqxuvJvOZ1IQL91Jc7mNn33vWNgOn9XZXY?=
 =?us-ascii?Q?8iaSaFomUwxCaKgppuqG2nFg0dosOSTHHQQhV/3bpeAEQZN68b8AF7HxMPFk?=
 =?us-ascii?Q?9ySGzKE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9piwmO2lAnmvM+j1puNupMprokBzkaUZzLxuVdY/Ke/UrgVZADMlZhl+Xu4?=
 =?us-ascii?Q?FeLR9iZaanneCa4v1rTlOVAx0XXO4jqv4v+eyJupYAhUlpU1OxxdDrx61Yzp?=
 =?us-ascii?Q?pWnNUKtBEnHlDg5xhLFU9pIWa52PmXDq2MWUL/VXNKiynLwhgEIBVc9Dg519?=
 =?us-ascii?Q?S40SoVsKpW5Y3B9a0ACgAvBdfljm/vnvTkUv51oflm/iO29FaKzTvqtspl7m?=
 =?us-ascii?Q?UD90mgcYH4gYApsSugjcq3kEOkc9bUscAXA3gIZ8ktqhy4AX6laldKkkm3mO?=
 =?us-ascii?Q?RnG6tlurOoApF5oipAi1M9xRg4KzUmXoU98r+8Y6uF3Iyt4wQFoS1bD47Mju?=
 =?us-ascii?Q?XMOB1PwJTjMP/dF3c6FjTr/iihYC8OKPWgyVVfS6VobW6wvrLnevOiVJkXQk?=
 =?us-ascii?Q?9e36wllltZ8SoxtEdma3EEQD8f4wRcIXNUMrDRg5f3gx1lLUDYiDvWgPRQuX?=
 =?us-ascii?Q?mgtxCHsExPRO3tiVIWzhuyLsDWwULfri6KVHc3ceFtqQZAKVr8G1tufU+gXI?=
 =?us-ascii?Q?P90XnYk7qfWfdS67V24xdytah4dAum+SenWu0+b4QsrShY1roEwTPj1vorps?=
 =?us-ascii?Q?BqlSySP6zleHWATXFSsdWCoewxfMhtlIpD6i3Vj9aEW/PX5pOwflbNZrvJ/i?=
 =?us-ascii?Q?F5es4M7jDb7GBlKBEi/pfbWi1sVzxHTQ1nEp7kNWxw2jok7nZlMx9UpKh2/z?=
 =?us-ascii?Q?8ViUvqFZH3p1a1nkdZQN9/npXD50+Pd52ZZijBpSDEv7Ku+xgrHq1PzofLDB?=
 =?us-ascii?Q?kQUlr4IJlxMUgA/9VLxnpmcWb5Aw/l/dU0QEd7n+ynyRsnkxnwzBSlWaQteB?=
 =?us-ascii?Q?Gncis+8065HqY9YX883NbUD7iUVvwt/JsWjXxSZQnh1JAabojy7UjMDh/VI5?=
 =?us-ascii?Q?UNNXqtgniL7jpk2GjByErZ7ToGkxRBGANCToXaYzdNe5vbc0zpAP0RQVT5BM?=
 =?us-ascii?Q?Z4qgACRPCYEgALUzYRrcADPRY4iwBYvnqbFSHHoybWyx9SF5nishuHztsRN0?=
 =?us-ascii?Q?JYMFZlErMJZaNKIxfBttlRlyxpwHazBh35l+CyJnTOtKxJJYZVv2OTD4c5zD?=
 =?us-ascii?Q?JQoVh/fjjaVuv8vqfrbvg6e/NIqyqhdxLgjdppCj8ztlGMgGKFr73gDixZgQ?=
 =?us-ascii?Q?DSyolQf1+t7X+ybR1eBULMOJQcIAnyACZfVhF7LoMiJNwpYF9apTpdzkR4i3?=
 =?us-ascii?Q?L/juV8hM43JGBCTA4AFpCgDf8X/MhoIC4m+EEtSTZpmTFt3DN2/n0Nkw9LEM?=
 =?us-ascii?Q?J3vKrFuUDWcbGlPGhxrQoXMAnr3i/BjE8ECY8e0Cb0/3f+2DNJEWsYXZKlH+?=
 =?us-ascii?Q?9ciHUgZFSFAy7vZSUi3VkGqO77y0Xlf3c9nQzrGWM74pnOpjcB6lRKs9+r7u?=
 =?us-ascii?Q?3xzrmcrgUMEhp+HWZfl8h7jyq8TOm1/0oEvtuFBteFyNBuw/NTWga/IbIVsF?=
 =?us-ascii?Q?CWp9BnOGtWFyTAE2fQJxh7tOIPEBGmpo90Eo1KAGCUN2G1OLjGhpqQx7/gbB?=
 =?us-ascii?Q?OPjlXTB5hkWVbbew4uV3IE1WyjJQZU7B08GMcAGSZbMCgmA9bNU553H8onCE?=
 =?us-ascii?Q?BThUxPwewaoZU2Ui6rWedWzx+UIphJH5mHYX7mVY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a29bd30-4d67-4362-7760-08dcfd4334a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 02:40:26.7389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAPLzfCtA6pgLMCHhYNYUC2L5RkDHuwLrPVDMS3W5OLOSd6NIkAHXDSeL9HiT00C/zFu94tOMG22Nv7VHyIDOkyzT9Sbg+L4iePRVE9o/d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Michael S. Tsirkin <mst@redhat.com>
>Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
>invalidation queue
>
>On Mon, Nov 04, 2024 at 08:55:35PM +0800, Zhenzhong Duan wrote:
>> According to VTD spec, a 256-bit descriptor will result in an invalid
>> descriptor error if submitted in an IQ that is setup to provide hardware
>> with 128-bit descriptors (IQA_REG.DW=3D0). Meanwhile, there are old inv =
desc
>> types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
>> 128-bit version of this descriptor is submitted into an IQ that is setup
>> to provide hardware with 256-bit descriptors will also result in an inva=
lid
>> descriptor error.
>>
>> The 2nd will be captured by the tail register update. So we only need to
>> focus on the 1st.
>>
>> Because the reserved bit check between different types of invalidation d=
esc
>> are common, so introduce a common function vtd_inv_desc_reserved_check()
>> to do all the checks and pass the differences as parameters.
>>
>> With this change, need to replace error_report_once() call with error_re=
port()
>> to catch different call sites. This isn't an issue as error_report_once(=
)
>> here is mainly used to help debug guest error, but it only dumps once in
>> qemu life cycle and doesn't help much, we need error_report() instead.
>>
>> Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |  1 +
>>  hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
>>  2 files changed, 59 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 2f9bc0147d..75ccd501b0 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -356,6 +356,7 @@ union VTDInvDesc {
>>  typedef union VTDInvDesc VTDInvDesc;
>>
>>  /* Masks for struct VTDInvDesc */
>> +#define VTD_INV_DESC_ALL_ONE            -1ULL
>>  #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
>>                                           ((val) & 0xfULL))
>>  #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate=
 Desc */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 1ecfe47963..2fc3866433 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
>>      return true;
>>  }
>>
>> +static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
>> +                                        VTDInvDesc *inv_desc,
>> +                                        uint64_t mask[4], bool dw,
>> +                                        const char *func_name,
>> +                                        const char *desc_type)
>> +{
>> +    if (s->iq_dw) {
>> +        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
>> +            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
>> +            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
>> +                         " val[2]: 0x%"PRIx64" val[1]=3D0x%"PRIx64
>> +                         " val[0]=3D0x%"PRIx64" (reserved nonzero)",
>> +                         func_name, desc_type, inv_desc->val[3],
>> +                         inv_desc->val[2], inv_desc->val[1],
>> +                         inv_desc->val[0]);
>
>Hmm.
>But these are guest errors.
>should all these actually be
>
>qemu_log_mask(LOG_GUEST_ERROR, ...)
>
>
>?
Yes, make sense. I see you have sent pull request, not clear
if error_report() is reluctantly ok for you or I should send a fix.

Thanks
Zhenzhong


