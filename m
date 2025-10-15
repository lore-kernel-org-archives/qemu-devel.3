Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C971CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tYz-0000Gf-Iu; Wed, 15 Oct 2025 00:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tYy-0000GI-BC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:56:36 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tYu-0006Ni-9x
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760504193; x=1792040193;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HKAx3qvaNGZgpB4EL3KFBKSC09WoV5bzsvnLEqXcRnI=;
 b=KVsVT/PvCdfbJpc4UOay3WvTkuKRvNkfsoL/g6qMo8NWtiQ3bk9OjG+3
 EIsU+G5Q4D/cgCa6tB55+dM8a8KO22ozBK9XCAm27aZWCoeHbf6lOVMpo
 eGTf926ayfOsoW8ohpxfgHG6/20yhvpGr3tsyRDLTkychxIieTBhDaftX
 KIHHEKk7vty65wCf/5U2ELpTE+5AxED1Bos31AdbYwvk7wZAnXkYfzs3U
 EsWRF4GGKm6j1uTdhwPO2MLfzMocuZeOKau9NBcXubfhkmND73jE1kZFz
 x/eMI1a1lH/SKfcLqF1DcU4W/OQs6oa9gxVNQVW2EDQFr5j7yiLcT2yB5 Q==;
X-CSE-ConnectionGUID: aTHZLzWCTWiGuTdcnbG9tw==
X-CSE-MsgGUID: JiB8dnlbTCiPD/pn3I4HNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66321234"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="66321234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:56:28 -0700
X-CSE-ConnectionGUID: g5MyXq7cSB+ht4F2x7ufig==
X-CSE-MsgGUID: TDFdurbhSM2os4ad1lXf+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="186321364"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:56:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:56:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 21:56:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5PAKN44/1ARWJfg6U4uesOzfcxnRpXzPAkIVEqQsqYi37pmSkUlxWo7r/BszrUIT3qkesb+S7YfOgFbPbgi4Po/Jxyz8ipeiyZG80dW6H605B8mXK6XSpBY6RQTIIpkqE6APRFy7ivSHWxCipW1ztPtk9DFOGWppjZJ42cGTEHO4N/hYwSmGbj8DraO9lHK+oqJXxs6s2rsFZA3uKYpenZ+jAXARhRTz+B/UM0cMW4Zu2ykWNAFJL6yt/qiY8YXJ3z+NlhaahX0wBT0ZFeT+WCOzHrlR2U4hMxtWkwgym0VsiuXPkkS2Ftz4s0q/cFpYKrOz+aYOszVBcR8wP8wXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/pAKMsD31Y2D2S0anf6OG2R+79FpBRtDm05OkwDuWI=;
 b=lQHK1EZ3fCgtrnfyhwkHab5ps1PN6++Sq5WeEJqfk6VPjsv84QmpKvTmI+362rf/KJV58cdKaE4gF2HTW5tkWXU3Tj8EnT5g21MBzUDD/4Zb7b7TzhrktDa8cnlG1ZEgWwlExm+hyLKsAEcR4HgAY0ibkVNFkdw3ICmDRqSVpFRpXAY7wtgbi2q7xLMg5t/s8I5zDqM5ATjJJ8Lh9nnezDW9O3WVAz330mkPL/P1mr1W/Lgqj3oKy3EgylRhQOc9t4Wc+jvz9VewB+kuUqWDkMZHyJ9kmLClXhbRek9e+uXG7fD++YI9C3hKj4Hiu/8t7BLt4ankBZoQERGh1JQY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 04:56:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:56:19 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 1/7] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Thread-Topic: [PATCH v1 1/7] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Thread-Index: AQHcNL+QHgJFlns5YUOIqUF6JDbuzbTBHqyAgAFtqKA=
Date: Wed, 15 Oct 2025 04:56:19 +0000
Message-ID: <IA0PR11MB71859435C7610FD403EED34CF8E8A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-2-vivek.kasireddy@intel.com>
 <2d72c77c-6ea1-45e5-b23e-e1d64cb716fa@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2d72c77c-6ea1-45e5-b23e-e1d64cb716fa@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB5957:EE_
x-ms-office365-filtering-correlation-id: 66036f0f-62a9-43cb-ae97-08de0ba72de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4KbUN4sKaoDnpz4VTDzLT0WIRHADtbAGlDPV1a9NsxhfwmpkxVCs6NfFMk?=
 =?iso-8859-1?Q?tpD7lsprOKQp/G0cHGYYhJDsKiYFlwTe3RDp0h6k4jQK2Yta+bET0tdJPF?=
 =?iso-8859-1?Q?bXI4bUnsW6n2IUyGV5al72uh362SKcmqiZrSJnDAMd7S9CsEDamn0SOYED?=
 =?iso-8859-1?Q?8t8vVDjOu/hoISgb2NAv03H2yItkF+SM9x60aD4wSIUA3AnPEzgnHZT9Kv?=
 =?iso-8859-1?Q?WBbAkfbh98ZlTMLrXKq6irAT19+yZEOi4pm7eIpp5POZEOUI3mgiXJlIfw?=
 =?iso-8859-1?Q?1XmR1Yx7MLCSlnDH0MzS5ZkBr/O/+fKtFGOrq/CqnJJutTs1YEUcOGHQO+?=
 =?iso-8859-1?Q?dNcDCOr/z+XNL1bKNhqGzDACkTe09++6RCqGL+vgAhnEGtflrGMa35e96T?=
 =?iso-8859-1?Q?OFJhhFX4FiiImUxAxqYgu97buRWLJS5jbxoGglxpHU5dTj+4/Bc9sBHZ6H?=
 =?iso-8859-1?Q?2MKoYz8bhQQxB/Z9EeVpfgda8M72IY7nJ5FWz7BJrVH02eQtPREfBzYqsj?=
 =?iso-8859-1?Q?TSTkO8UbH6vJy3yB6WXESPu901Xmok6/uCjUOgVmZbZn/HpIIQ/zjU0stI?=
 =?iso-8859-1?Q?crkeZ/pc7FaGkadFeevqkd4lTeonOxZAXjeCeOSN2ZlwWMEsQWncWmCCb7?=
 =?iso-8859-1?Q?XfUp//qX0yoTe0dWMCAUSdae+uvh4E1shr0uLe1+p5wwSf41Ee1b47igi1?=
 =?iso-8859-1?Q?WPfNeunJ+PrGjMyTpmlKgx0elRJHiQFuKv6ox3F9372RlYUB3+bCalm6B4?=
 =?iso-8859-1?Q?mSIoje1Qi+W2S7wnVAQfU+Wqpb0A05BNHvBr6kEad6qPE8bbpY6rAS0TC5?=
 =?iso-8859-1?Q?jp5Qg1K5Z7PN8K3Fxw8EPTjAUy3lSZp9QZGU8lHsy6G5Im3pckL1SeqXJW?=
 =?iso-8859-1?Q?IjCWxVv1POayTgOavCpY2v+VQbjp0vBorNF02vswTWTu3b7cvpqNzab5rZ?=
 =?iso-8859-1?Q?Zwp9zhTUsSpVLmpht/gd0FiIEy+ZWm63yFUKDRAZ1Q9fYrw7shxhnpkW56?=
 =?iso-8859-1?Q?J2tY0ilD5pso5rnE+PhAtNRrQTc3Tts8woeJg1aaLIyI60cBfwHoyZ8TJA?=
 =?iso-8859-1?Q?1w12ijEPe4LeY6Iel8lD8t0zWGbxxgmzOyRVubpgtIZ4QpxtwPy6v2rX7u?=
 =?iso-8859-1?Q?ksLrjmXfZ8oqKNU3balu4C0qo5HXI8H1X8IS9fD3iivINBVwcFwhjvcnFE?=
 =?iso-8859-1?Q?xEVZha34/tY/mRw062wt1SO1rJ08tEBNTSLyPUn6JmzD1jdvEZULune2Zd?=
 =?iso-8859-1?Q?GrIZS8oJ+4gQo2VadOCyqigFRQGPsE/4uoUvisQdXmgK8CiVUEqgPHxCxR?=
 =?iso-8859-1?Q?4X8vRFTIj4c1TXxr+4jYWeydBf7W2zmM0Ux7sY3i2jIRpTUDQjmrdtqFYj?=
 =?iso-8859-1?Q?saiOxyeZcDS4K3ILGEArk4dSxFx/u2uRMdPvpMiMGAB/ImLQt15Ah3ep3B?=
 =?iso-8859-1?Q?Dszqh+PSCBoqLVCwb5W5fD+FGjIrlBd6CiBVVX4sqpC+vMxiorHHjsQeN5?=
 =?iso-8859-1?Q?Nkyc9ezdIu2IfHOVhEbrHny9ayBTKkivxg/aF4o8QhseTx3VO2DJqJ/s3H?=
 =?iso-8859-1?Q?0g+DCKRlix7hY3Y8YjcbEoMms7RG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kLYbkUbc4pgdwK/t/ma2ChPKvRkktdZvCwjUqF1RbwdNq79x+Wv+ydp4Ic?=
 =?iso-8859-1?Q?PJXQIU8w4Il0qPW7heiOy3JAGOIxvrwxyRQ2e0oOAtlaExaVqq3jDemxVH?=
 =?iso-8859-1?Q?qBVzznjv6gnvryovQW9+2sDCA8NN91YLt0+y3wbTDP5YO+DXfeBIMiFL+G?=
 =?iso-8859-1?Q?4sYqRl/5BAKamwpJKI+ZuHipX3q4Snr/KG3L0O7ckgIiOs3r3qwGNV2t86?=
 =?iso-8859-1?Q?ZFFJCdSM0DkBNb+iZxz16l1hXK9Pe4E2mH8urQKe6XZeOEll23YchUsgDA?=
 =?iso-8859-1?Q?1HbwEeRdR8wTgq+Zt30nl4TRVlPGT3DG1SCqBuR3ufto9HytO0ud/nVfJ7?=
 =?iso-8859-1?Q?92Ocjj5CNR628qHVYdXTfwYyc9mA4brptVx2kdL+Ve9gLeWdQaImEox2eV?=
 =?iso-8859-1?Q?U36cPGrZmjzpjsKnuSH0g2OUxCD+ashI5+uqwFzs59dUUgxZpx8aRVq9Zs?=
 =?iso-8859-1?Q?qv8Y1WnEjRGQ09Y/H04jKLLKkMYpAwcAeu249TKY/CXLqXD61Xc3seCiJF?=
 =?iso-8859-1?Q?npcJJBf5ymBEt4KZP4CzhUPDIXvcUzBbqT9TGTd8LCsulmxTsP2z8Udgjj?=
 =?iso-8859-1?Q?RPtTvFOClDJIqfDvi/10qmN4B+h9j4xaksrZy+zgjoeYbHzChcqtz2K0RX?=
 =?iso-8859-1?Q?ZYWdlJPElkGC2AF48/g3lF2YLXjEKhIn+oW3qKQqovDhOuoGHYuQMqiViS?=
 =?iso-8859-1?Q?VM9GKaRuMHLovTUkC79cumj4PCdbb7+qJUeyEByZs/O8cFasPpCq3tqEKp?=
 =?iso-8859-1?Q?R9BwBen/4VaEgL7Tecr5+BuTbviRZB4Eo8kYIw8mGD+l9z2hU82xPBjTN2?=
 =?iso-8859-1?Q?+DWKd0KHEmF2wDCJ+tTjDeEq7H6NwtrGnT8xvvZFcAFYPixXa7jG+1PRq8?=
 =?iso-8859-1?Q?As8Q5G+zqoRC8Yjibsr+iABNtlRhrt6nobyXlLQETq619s+SK0WTKcw9M2?=
 =?iso-8859-1?Q?5YQoR3cqB84LiAk4MNnODPmkFV7wZXsPDORjwzQMKkiH82ANB9VZGGoOOM?=
 =?iso-8859-1?Q?1DvsfnsP2XGhgvcQJBQZzNyzFLHBSrzUQWNY8WvY1ADBmYXIchxKgYejI6?=
 =?iso-8859-1?Q?QqW0mqmkI291Jc0A3AL26B++GEnz1rqHJdlUH1S8Jz6qVIr9F1AP8mTEjX?=
 =?iso-8859-1?Q?Omzna6OyCXZmEul4AhivfhW0bCdf2BvWjMu0XjN4IT8rDAH/m6m5VtICQo?=
 =?iso-8859-1?Q?zKXUN5kbvH1rgY7TXN8wWVuLtth/rEW9TAWu3OiZ9WEJJ9qtrl8/bue7s/?=
 =?iso-8859-1?Q?fI14qgOGEA1EAaBr2F59IjetXY4bjLvRyOhDrI7omhRvsWr8WETxmu61VS?=
 =?iso-8859-1?Q?RwS8eV9+tKqr7/YFM7fZePHqU47zKucPXg4dq6n+PDCOLG0HrsunFhAjDb?=
 =?iso-8859-1?Q?6NAwxIn6KGWJVBPowXYfxXiWguBYVBT3pAfe1447IV2HEs1ZMDXRF0WiE1?=
 =?iso-8859-1?Q?qOTwHZyCiIx7i/PZWuPEdNJkwTI9RRK/69hY1u/lviQA+xrAOjYl1j8Ss5?=
 =?iso-8859-1?Q?AKbH9diuDedIbhLEnoUf17TzV8Ek7+uOAGJM+K0rHAN/oIpbWHoUtdgH32?=
 =?iso-8859-1?Q?0JXVhIqflX9VLYjnmYgw7kw6c2+EvmbfILxKzSDALekQ5lVPjvR3mOjwSJ?=
 =?iso-8859-1?Q?1npTePxbBpznzsLMNK5xnKXZnWMeqLc2Hd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66036f0f-62a9-43cb-ae97-08de0ba72de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 04:56:19.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4ojun8yS68GkbMutkgcxUhumQVCt/xxqX/FGeUHAJ0E55N2cKyqSc9LYJLF0AqOMn8bF+WdjYs2jSWzpHRI0SNKFTJCdBKGrsIZjbfwdYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

>=20
> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> > There are cases when a blob resource's backing might get detached
> > and re-attached again such as when the underlying object is getting
> > migrated in the Guest. In these situations, we need to obtain a new
> > dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().
>  > > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index de35902213..70e8757128 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -937,6 +937,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
> >           cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> >           return;
> >       }
> > +
> > +    if (res->blob_size && res->dmabuf_fd < 0) {
>=20
> Checking res->dmabuf_fd should be unnecessary because it is always < 0
> when !res->iov && res->blob_size.
I agree, it is unnecessary. I'll remove it.

Thanks,
Vivek

>=20
> virtio_gpu_cleanup_mapping() is the function that sets res->iov to NULL,
> and it ensures res->dmabuf_fd < 0 by calling virtio_gpu_fini_udmabuf()
> when res->blob_size !=3D 0.

