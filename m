Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F4CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 04:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF2LH-0001Sm-Uu; Fri, 09 Oct 2026 00:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2HV-0000gq-6J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:32:38 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2HQ-0000iS-UE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791520346; x=1823056346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HJcyqF+jsr2VwBc7bdzt0e3PDTUlcqAgOSzC7iACftQ=;
 b=UlKproxL75xzf9JyA/j0nzbQrVQm0DDHhTChF6/XOKXQofp4DvAFHnrk
 uAFEdspzC97bDnC7LSQKECRSzcb6MT2/gkUAn0XRlYcah1WCfc+9eis7F
 HlHhWH8lEGX68xERKnO5eu6X58v6ZHJy9GIu+XGhs76LA5hHbMb+XnkF7
 H2ymuv4Y6U+cW6jCF0WX7C+8wQlc87FrlqzjVOtLwMl4vr+wMv08OpUTw
 hhrQtBRaXmi4MS+Br+k1URdQ/YpBxaHjjAjiAVNbyotUj/k68J2C7irOA
 jO4t+y4A4yA/BP87WzTt/+9jk8C4Oxa+KpbkSWRL36jQlkvRkqrpbMxAS A==;
X-CSE-ConnectionGUID: k9Xydg/cTJeqg6pXJbsfrw==
X-CSE-MsgGUID: XEQMg/4iQwK/5ZG8aEzcEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="208401"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="208401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:32:19 -0700
X-CSE-ConnectionGUID: OnMjJaMxTxiKs2WAqIDyjw==
X-CSE-MsgGUID: NqkyOHhWRo2bqcG0xkxX1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="296552"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:32:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:32:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 21:32:04 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu8fOer3XZxPh/0yNDfyganztwKCwpCWyS09c9qia2+PlokWN+c3GpAW9mZdBY52FJh+oMPVixRM0g+tLOa9+D0jn2RoXMKQQkWj85qS3xFPabcFEexMOLB+EZIDilWicQX2MmfeBFWahiTPNvzNL+WdIPvUS27me7haEPLRxc0PM49/MF4MhM9qrRE5R8imSm9etUXOvV760apxIYG7TsyPVO/xcS7n4vX7pLo0gyIDnzvZx9nSiKUL/2q38d4HFNX6WyXrJpR13+9U+ofrq/NXI7CDe0ksz5OGDnqBeSe7qZzKgcugB1vLV5cr+movkG3c2dMbQNziXQWdN0S+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOMuuRWCT35LEGZV9Sm0FkGWt8k0xVYp8+QvOghmlhQ=;
 b=oZZc/KGovsNvJEBQdKZfXM55cNLDcAel0zBCydVB+pcIAPQrRsPjjNZvapztX8M4LOBzDq0HJc8MufjJekP1B2c6BegZh9r6ANXHUd2YYwQums1yvvPgWFOXK+pi16mkuPwFuQ3dZjQOKOFkFixBlcOtC1LsW1EUJU73Ll+JnpJzVzurRMayDzs6g/dKMazTcsSX6URnVf3s+djK4q0VEjNRa+j0Ir/BF1bGO6J/lOT6tvRa83y7BpHctYu3bxSFTg+E2XJQX3g1GFwZWjVKcmgNj+gcRHclxQL8Q9e23nBwgJeC3x/4MG786C9AVzgCLDb5wLf6EaXJQpvp632PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA3PR11MB490611.namprd11.prod.outlook.com (2603:10b6:208:61f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:32:02 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 04:32:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHdVphmDwVGKGE8Yk6FSLwoadjfhbbzWl4AgACY8oA=
Date: Fri, 9 Oct 2026 04:32:00 +0000
Message-ID: <IA0PR11MB718508A4AD2A92CEB7A56B97F8922@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-2-vivek.kasireddy@intel.com>
 <7ee490fc-7311-48a5-aa6a-434935ca0a84@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7ee490fc-7311-48a5-aa6a-434935ca0a84@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA3PR11MB490611:EE_
x-ms-office365-filtering-correlation-id: ed4466ef-4b68-454a-f823-08df25be4301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|11063799006|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: DfOwWYDjROVpy+zzoCzZv/WkFiOHTqQo8RSYFbMS/nO9oPZpF60a/AKUfkaPbMh2PiFF5nOTs57bkuLr2T4hkdwoiCeoqgWqSaIJOwTxDhrBKAjfobpByV6wWzfv9Hzc2yCbj2YawrVzDIM4UU+ljlI/Bb4IxkTLTlWSquNxhGHclvp1Li2ORdL+vq82G7YDn2a62fmv+r6eRwtNZV1lMdT8jDVOvGtpti38eAYhy2Bg1wA31I7/0nlUHg0gmLDqXKQPW9nqt0Sc40VwzxZd/WtT9pWjT+PQLD62wAUmIWruKj984Xdv9F6W6gYPRlDPEOdbAz1qO0DxDuIbIZbcLDxazTTqgh/rk8qv9BJ0LcxTyDed8ski71i9oy0hxirmbPDqKvVJL9yRXOYpg5ocX2VSkDe5wGmFzXttWgHvppJn8PG3zE49jnlINK+10Hsnl4A91ALFOX4+O9fnG0aJ4iVrgMmmAFHizQGx60WEOrK9FuqMZdJ8ty2F1RXG17nvmQaJtfzzM4hJGZE1cgn0a5ijBamqotoYDAiKjhC+VBDpzBD8c2zGINUcGdO2sJRLmBK34Uko7FsKdbSx/DizCgr5PeSJDP9dUCa22k9z7gadUXtCJOLLEkBQNwliMKb5hE54DRJ+EcGiofuNhzsoZC3qbyuZeMm8Dp88IgYKuarAIw9LvNUtFCh1Qe1o35flQIT6FP6j70pJ2LhtgJXJW6wEx67fX/wm5uHSTNifFQ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(11063799006)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0lflPZ2xOZMVYUVkrhS2UPd7OFfQoQewF+Pz/LO38rwLjoagDeBI11dFz6?=
 =?iso-8859-1?Q?re4119RqQQ+VV8UYjODNEpiDLXbZyHI1ziQOKa2+zVYAmeGqcpXd/son/5?=
 =?iso-8859-1?Q?0ONaS0yLqO26KVJPQKAkTkOXVphhQB8rcexFA1mt9Sci8wn3RbdCE5qFh2?=
 =?iso-8859-1?Q?PMC+w3X6MoIqdckLV3TmUAOF3S4DWOOSZXWk2ZK7sC8XDjwAgGuM4sXvSa?=
 =?iso-8859-1?Q?s+Ci5igofMQEeXF4A2aG0eS+/rWsH+CDb+dlHdmYzBPeULCuy7Jlu4x06Q?=
 =?iso-8859-1?Q?qosALKAaOFpPySFgO3LlAbl6TIoRHyZz2Mq2O2G/7ObVi5QWDwiYjdIrHa?=
 =?iso-8859-1?Q?Cl1MZ/L/8EoootM1MddrOOkZaEp2wTm5WHUWlvID+tN2o5x94RKP5slnDl?=
 =?iso-8859-1?Q?8mq7ZyKgdIobBusd9xKK+Ci9YwLY2aRKjWCnJpTtZ3iPaqP2DE2PQLXgas?=
 =?iso-8859-1?Q?mLFKQ/AmMuVFp6tcS/ue7K/vFO420TtbBD5KpfOEjLPn6+Sy91OfKSsZBc?=
 =?iso-8859-1?Q?fojvbCz1AInqpPdJiVzRYOtdDg5nkpON0yVHVw34UfW/uUqFwSDJ6x70TT?=
 =?iso-8859-1?Q?vEcUpdtndGcJupI/QmYcom0nQdBtd2qLzTeIpfHCfkjOTVvn/FZfNZqv69?=
 =?iso-8859-1?Q?gyZ4otYMrn8anrVkO8S8i43a1lQ0VWHN8R2BqlMeG80eXm7k/XHhj5qFKe?=
 =?iso-8859-1?Q?O2fkMDuK3rqnmXvpYPaUEFVIRUFw6of3JrjmbqDHSXpP6JKZzXB0CfTlU9?=
 =?iso-8859-1?Q?cwExq2wirsLezxdAAPmYvvfWb0R1mkOEJwlyDuQgNBsSFH3CVwFAWm8eCp?=
 =?iso-8859-1?Q?1jmW/nE5P4OLidB6NMElzvfJcfxatBx5yd5nFe05CQIB9ZkOEmRAqavcmA?=
 =?iso-8859-1?Q?xKE6430ILkZuEXRX9+OLhAsC2pkqlsUedHNJvxZxDuQ720L9090WCv6+oq?=
 =?iso-8859-1?Q?biE5E49VUpV0QqxqnllFcC/bqAnXn2bTtGKiHkbalmIffXc64yze3S3tZd?=
 =?iso-8859-1?Q?Kq0Ifd6ZIY06w5YwhvtYR9u/rJ7ct7sDfaQg/fv0yywpoQVMO4yZVZuy5a?=
 =?iso-8859-1?Q?T7FzHsbEtXYx65LDBfOCJCvnOX/J9BAVg9McXy3Awi7ZraR46kya0x5tLp?=
 =?iso-8859-1?Q?EdCZbGIqVE9mlXq2zuIp9VOTfC5bIv9bBRKVzx1KCpiHxA0iq4KuMX41uU?=
 =?iso-8859-1?Q?1RqBBadjllPoEKTIghbWMNUj3fd+pX5D2F1AHsbUemz6wLaof9iyryx5QV?=
 =?iso-8859-1?Q?H6xoYhEJs7GboY+DYXyHXqsBXjUB+R4471JEFHkJcwk4wtidsAFb0cyh35?=
 =?iso-8859-1?Q?Pf6Pjsi/Ehpb2cbxCqQn4ykle4Bw3e355bDLEjrJVwvF9dn1/UVke+NTpB?=
 =?iso-8859-1?Q?VQLwgzMC6fnGblQvhqzAkVfbACHhqRrp7hOo+5mQ9oz2ZrAMgTR84sJzNZ?=
 =?iso-8859-1?Q?S7VEhXssQh+g5hNwXY59h3QCdgdMkfGjpBwTL9DluCPw/3zB0gEUDpAG32?=
 =?iso-8859-1?Q?sxfUxWeVtIxC4lz1ll2F5U/jj1+a8DNbaDc63v9/7s/OLJZAnUuQxUlbeB?=
 =?iso-8859-1?Q?FlSYm/dtIyMeyGAZrxquW8YR6wiezCtcJ9pQTsVTmCB4vkcG4thdZwd/7b?=
 =?iso-8859-1?Q?6USDaNFDjt2G6wTqIaatmkvUe1goUInIZCUZlgsOYB7DjfLEG2+n6xwdWe?=
 =?iso-8859-1?Q?7nLo57985ECjGu/0dJhN5YArt7IC1Ue398hEbB2JSFMRXINcLTAFVT3gFr?=
 =?iso-8859-1?Q?Nh2MwUJunPadv8STwGVYtZ4aoERagPXUB3+WWZpceCH3g/cfyIR+Y3Xnaw?=
 =?iso-8859-1?Q?vIpVP434dA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hrU80Us0fr6iZs0A3yvu9ADLSL8PHxejMWTrBVtV0aiftEIB21ZdCsxWbRWHbH+HAxua4V/6SGh8dgomeFPd4oENLP1qa18ZnbMAGLqgjZ0UUrAS0QJlEOZ6DgmUO3oP9wbb5ZrELHOm3sD/BhPrE4JVw/O0eyKBximXWpm828+0NPIGSI21TRSqTrQrZHcfWIskcy6x352ObD29Zb+ISPw0c+go8c4OH6sPaCx5Q4YK2vtAUIHUxdC/Sro+77f+24XJsV49VLvl6/cF/PDNorrc+JqYbDZAL1wzvk1KyGJkAOMqi9idKwSfow8ruKT5EyuST3n43kn95+mfck0reA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4466ef-4b68-454a-f823-08df25be4301
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 04:32:00.7690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlN5i+obildcL0ePXj9B4sXUWoDHrKiwPbSNOptb98ceQPPdUeMv5Uj8wjPG+V1mx2tUnnlKVyfEoFe6goTBbDltXtMIJJ+9EbRqR67MsKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB490611
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Hi Akihiko,

> Subject: Re: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> On 2026/10/08 5:09, Vivek Kasireddy wrote:
> > If the Guest provides a DMA address that is associated with a ram
> > device (such as a VFIO PCI device region and not its system memory),
> > then we can obtain the hva (host virtual address) by invoking
> > address_space_translate() followed by memory_region_get_ram_ptr().
> >
> > We cannot use dma_memory_map() because for memory regions that
> do
> > not support direct access, it would create bounce buffers instead
> > of returning the actual hva, which is not desirable here. And, since
> > VFIO device regions are not considered directly accessible (because
> > they are mostly MMIO based), virtio-gpu cannot invoke
> dma_memory_map()
> > to obtain the hva in this case.
> >
> > Therefore, in order to handle addresses associated with VFIO devices,
> > we need to use the address_space_translate() API to first identify
> > the right memory region and the appropriate offset within that
> > region and then use memory_region_get_ram_ptr() to get the hva.
> > This approach also works for addresses associated with the system
> > memory region.
> >
> > Note that, although we take an explicit reference on the memory
> > region, we would still rely on dma_memory_unmap() to drop that
> > reference when the dma mapping is eventually unmapped.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index bb0f41bb1e..386db05e5b 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -948,6 +948,23 @@ static void
> virtio_gpu_set_scanout_blob(VirtIOGPU *g,
> >                                 &fb, res, &ss.r, &cmd->error);
> >   }
> >
> > +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> > +                                       struct virtio_gpu_ctrl_command =
*cmd,
> > +                                       uint64_t a, hwaddr *len)
> > +{
> > +    MemoryRegion *mr;
> > +    hwaddr xlat;
> > +
> > +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
> &xlat, len,
> > +                                 DMA_DIRECTION_TO_DEVICE,
> > +                                 MEMTXATTRS_UNSPECIFIED);
> > +    if (memory_region_is_ram(mr)) {
> > +        memory_region_ref(mr);
> > +        return memory_region_get_ram_ptr(mr) + xlat;
>=20
> On rechecking this, I don't think it is safe with Xen.
>=20
> memory_region_get_ram_ptr(mr) + xlat assumes a contiguous host
> mapping
> of the entire region. Xen maps guest RAM on demand through its
> mapcache.
> Here, memory_region_get_ram_ptr() obtains a mapping at offset zero
> without pinning the cache entry, and adding xlat afterward does not
> ensure that the requested range is mapped.
>=20
> The MemoryRegion reference keeps the region alive, but does not
> prevent
> the mapcache entry from being reused. Resource backing can therefore
> receive an invalid or unpinned pointer.
>=20
> I think we need to extend dma_memory_map() for this use case instead
> of
> replacing it, preserving its mapping and unmapping semantics.
I am not sure if extending dma_memory_map() might be a better/cleaner
solution for this use-case. If obtaining the hva/host ptr via
memory_region_get_ram_ptr(mr) + xlat for guest RAM is not safe with
Xen, then would it not make more sense to go back to using dma_memory_map()
for Guest RAM and memory_region_get_ram_ptr(mr) + xlat for VFIO
backed regions? That is, doing the following:=20

static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd,
                                       uint64_t a, hwaddr *len)
{
    MemoryRegion *mr =3D NULL;
    hwaddr xlat;

    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat, len,
                                 DMA_DIRECTION_TO_DEVICE,
                                 MEMTXATTRS_UNSPECIFIED);
    if (memory_region_is_ram_device(mr)) {
        memory_region_ref(mr);
        return memory_region_get_ram_ptr(mr) + xlat;
    }

    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
                          DMA_DIRECTION_TO_DEVICE,
                          MEMTXATTRS_UNSPECIFIED);
}

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +    }
> > +    return NULL;
> > +}
> > +
> >   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >                                     uint32_t nr_entries, uint32_t offse=
t,
> >                                     struct virtio_gpu_ctrl_command *cmd=
,
> > @@ -993,9 +1010,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU
> *g,
> >           /* TODO: a common DMA map SG helper */
> >           do {
> >               len =3D l;
> > -            map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a,
> &len,
> > -                                 DMA_DIRECTION_TO_DEVICE,
> > -                                 MEMTXATTRS_UNSPECIFIED);
> > +            map =3D virtio_gpu_dma_memory_map(g, cmd, a, &len);
> >               if (!map) {
> >                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map
> MMIO memory for"
> >                                 " element %d\n", __func__, e);


