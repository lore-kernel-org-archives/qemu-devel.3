Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A619109E557
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5deX-0001tt-PC; Thu, 26 Mar 2026 01:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5deV-0001tk-Gy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 01:53:07 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5deS-00055Q-Sc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 01:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774504385; x=1806040385;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ymhCHELsiaAlYAaQwQW3yskqf4A/sEOHdG7YiIytTmY=;
 b=Z0Iip++X+66gqEqEtrQbAAwoDoX+kEumutoMS3BYHcsefRk9sIqtGiic
 a0Y7TwtefqSz2QxhHr6KcyEt/UEvIT61Nc20pHpUJ+JlTvE4o0L2uHwzc
 tDxKnNO90slzHDINn0WN6ZAEEOjSkaySHccg/XHmWPcZ3IiiqGUeU+Y2W
 Gm0BINEz6Ee8Rk9nLOfLCZmbPIoKtfqjsgM/L6gNl498tMLypMDn6SGQh
 biSj3Wb3M/8SGeXwlk1B5IDTScsN3OiyyFowwR638niimRCC3BtpN9iMQ
 bb228LmXGlmVnXNZUgna/RHbjv3ssYRNgwY9UUydqd3iatS3xnIsdonhO A==;
X-CSE-ConnectionGUID: KDYXUuNGReGsWQKHUhtVgw==
X-CSE-MsgGUID: 8MYaGlkISsiEsDxqo7OeCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74735040"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="74735040"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:53:00 -0700
X-CSE-ConnectionGUID: jV7jPohlRPSpVVarEeztyg==
X-CSE-MsgGUID: nqxSUxmORUq9WauD1tVCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="228973522"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 22:53:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:52:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 22:52:59 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 22:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOyq0n1gHsqN2i5aijTnCYNIQm4KhxEiSC5XOXmcsWW3nAV+sFC38OEOdFcwuAYKAAV7aWxPq38gqGXDv87u4gvLrM3euMqxOd2rgwM5kmgJpeFvkUTFq17R/QuAx8j2opIygsRf2rC+IRuOXtm9xDBK7uFwx7rhuP+LB/zC0G9yqbiYrrlG2miDFQ+wDPtV4I3+g94BS9Jhgy7L8gNdftcjiNCEPKro+TZg8qq/yBzlY6ct6nj03L/q4VkBX/sF5WIeErYG2dbjxVJ523cVRZ2pRhdUKyfVV1SEgLR7IvCHJMSQPbPF8pnf9WeAy2lVbQUCdjorubMzac0SEZKJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5oDlvYmRM7xaS03GMAQ4304aVyfMt0uwBJPafrBsAk=;
 b=NA6/AnjqcsXRk38ntMNDeIAjs6wipokfC1QABrU58qxjDLX/iizHfzNkP//KXbyAU93LtSo2BZAlMutNQek+18FOTsrxSGESu8mgAMOYyKqgnhsfEEJmD7zIhioSh4tG7sxcg+HI30fDmvMIiQlQHYCjOH5oMqcaEaN5YcgkrNLVxB4SfGQPKEmbPbnQBQx2mqtmwz6seFy3BXXE+g0/bXA/eIqZxaJmtOQ0YwfoWnXCmPpWkeOxyn/Op76NY95aC3DZVQFBfSVtcoNOpfTTOUs9Mr4dnndtEFmjGnWBLqFgGlqHEqzyCv++Cj5szvizhmSBdE/PVvComqwzXj8n4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 05:52:50 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 05:52:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHct2CA3PoU5m7UCkOD5oPtmDIfc7W9baeAgACyxqCAAMxKgIAArgFw
Date: Thu, 26 Mar 2026 05:52:49 +0000
Message-ID: <CH3PR11MB7177A36C95F8700D66402086F856A@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-11-vivek.kasireddy@intel.com>
 <6af4e73c-4ad5-4684-9982-04276b6b7daa@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851291496AF53CF79309DAF849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c7ced616-2d9e-4180-ad40-c1f0d13fdc05@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c7ced616-2d9e-4180-ad40-c1f0d13fdc05@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|BL1PR11MB6050:EE_
x-ms-office365-filtering-correlation-id: 99d87cdf-30be-4970-b4af-08de8afbe9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: T7HtSqgbpQQwIvQGvC0NLDndxwamQx4QMkBhy/YbZS8lomEebjkFBjSJgC6nMhthZ/f5aloapMKEuO/i/tWnYThZqw+Si0i97V4cbbOpPxYEFNqKLJsjl/tx8e/0ja4crk62CJ8ghHsquM2W5r+PLLLQTazcV0cPRSwxL9QwRuK4VWjMDKx9ZS7qhM9t4Bh3HZgIw29pHURRUl9Uz6wbK7XqB0B231W/7i48rlKjCRHN6OAoh0rLZkHwfwkyNuJR7T6DHwPt59Z1Ibzx6jRGBP71UDW3UiQMEwjl1+ZeQsg+yk9ZqyVxclJwUV0AZvjoyfEYNCtDLt+76qChj8enMCrIfum+83KinETXpqh/BkIz9TpFZheAlSXxMikBdoW8eKgKOak+AwTxAQkWV6FhAmp8ahEYaWoiHSDaRAkZ0GKW3ATBnQrx/aijPwfG0+Jx0MeQMLYforcrVfh2+FIjNkGyavvjk3iTotk+JbmxIfLqr6FB4gqodPqBh1QXM2xXqflqrWt7Mv7rraRVyV8KuMtCqxda1c6ngrzrO4nwMoh11ZJTygacPPsUAlTx7ZUrEl5O1VXOxKV357c+V8lOgHNDnlZeVnZ64OnetvrrouYVjEMOO4ZZto/FZscdCOf0pK27NOH7BE8zwoGm4OLUiEeHkZOSeuPthDKyZSHsxx9t3+EpA8+weO9XIz0N6Lo2qJJ3Fy7PsQQtiD7yiu4JUVIbZR32gBPywI+2UdIOLij4GqaixF+AO8MBn7pPxDEHjrB6vXOmBEhBBmI+fZyzVZMa3jz1hWfnu3ItIWHxGx8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u2S2cCWakJnqKVj3kqvV+lTGyEyoLy0T1DhbuEN9K8ujS4bt2LL4dU/W7P?=
 =?iso-8859-1?Q?I/UfIrdT1L/VkXC3Bg5fqKYWgC0s4ZSf2hOfBjVt1nsVh49EmCNdc33h90?=
 =?iso-8859-1?Q?noM0E58pu3wuaDkDfzvNcNr1GTQC8wJVtRWLYLv8KBdzew34t9PzDnxWGz?=
 =?iso-8859-1?Q?6s0w0JaVLrg8q27J5jta3HSrvcDb3sYJgiHFwf6W6HyA9Dc62gV4RA/1mk?=
 =?iso-8859-1?Q?cVaBfKjMXunVJ3MIpk3m3jjE62naXzAhIrVwR9meZkPa+KjPhwg7WFyUZo?=
 =?iso-8859-1?Q?VO6TfARttfpXEfU3fJ0U15hsdjnKvslRwTxBaB3bdpvfCqQyfVAudG0o+O?=
 =?iso-8859-1?Q?yE8sMlbIVX6/DeTeJPz+ltFyVbXfitEmZCmvK7LGogKoH8F7LnhOww4mdG?=
 =?iso-8859-1?Q?WtLng9wSMJFqXIGSp2F3h2rqE2W+bq9ixrs1p4sSqk6lGX5LwU8TOmHgVZ?=
 =?iso-8859-1?Q?l6hhcdskPVz25EnvnqVvOUgYYCNzJc5VX/daOto2Mq18ATOEJDYpQP57ow?=
 =?iso-8859-1?Q?Pl9YpAH3sLhel3LQzSNPWs4f0OPLfAzjEOqZDSTWeZQSn5klx6hFFClq+K?=
 =?iso-8859-1?Q?+sE2We3UOPEVVTiVmYkxVzb+Y3fTxf3kWDY0cNYj9ylkgapJScIIMWjzy2?=
 =?iso-8859-1?Q?uekk9jxa14XiUw+WDfjvRr7TySDUuLG+GMmztrysblQG7UACPsrx8bHGOa?=
 =?iso-8859-1?Q?6ijXufMNhGkKCEcAY8CbD96H7jdYyhAYt0ZQPPc307PrUkmg+A/N11We5L?=
 =?iso-8859-1?Q?YXd/OtOw29TXs0CtmTPkR7ozERX4bBW3Xm0x0C5WcMc7iWR3CZOb6v5g0O?=
 =?iso-8859-1?Q?wNjpLrFX0TBsZFcQYLVx0kxNBTdIQ88PD26Z6zX1NfGnaHQfcpwQ1kVOli?=
 =?iso-8859-1?Q?QtB9ktDTv2aMfJEH5l3ywW4N9ZZbGyTHJrAGsyE1zNrDIBm6p85ArIUyfP?=
 =?iso-8859-1?Q?IvxfVoJeGZ2+mGclxh3+KYXXXHmEfY0pEmM+BnC+p00yPyiIf88hxhPIrW?=
 =?iso-8859-1?Q?5BN75eh1di7/WHNclkshHv7RWhk2JI951Y/Sl9ty9Wp/8Xwgpp5HYhOPOw?=
 =?iso-8859-1?Q?+PZeQ4iY5YDRCZ7coYMS2tYxGlfAjqBWf5G9cMQHIBEuhuA0r36oHG4Ch3?=
 =?iso-8859-1?Q?5E93DPbSVmSMbXJQSLFVZiC7Y9LlLkydn20kenzmUngMIBoi+O6qpAxp1b?=
 =?iso-8859-1?Q?Mgu/Dv+OJMY7mrIgMJZ3u0nJeUEuTTdJplIii5LUqth34bBPhQvx16w75V?=
 =?iso-8859-1?Q?ot0uTKNoKCBLr5mI81d9OO23twTa8QoBhh3dLYvxMxMd8vzwItoZgqb270?=
 =?iso-8859-1?Q?rXR4nfgkfe1Kdbnh43toRkl1mozrekJmVYuxClfU5yj15quO/cFEa39ozO?=
 =?iso-8859-1?Q?NsvNe+TMV7kB8LUtfFBvDN+ird+bFAFHU2o8tOtU6EX/7qe+JW8j71aQUU?=
 =?iso-8859-1?Q?1eGHGbV2sEH9ybpttE92Z1KSdj/5P/EHtAEmgxITUcorguPz3DWtNSKC9e?=
 =?iso-8859-1?Q?gIrLu7XxHRj/zQrpOrvOaNotp+pQo2dL+Wib8CsZS9mVk3p2+wsXAuPYPI?=
 =?iso-8859-1?Q?v12VSTNiNTFKl7DADPnhO93qv1izhO1wqyWSDaLYQ4ypyLCYAlvGVDCral?=
 =?iso-8859-1?Q?DkPszVhWje0Jn+J4iXBKItPGIU8Z+x+f/CYwqr1CThOBSz33g4TjZQ7xQK?=
 =?iso-8859-1?Q?E/G4BxaBbykEh9B8xkyiClRGOCFlHAYEezPSTw/Tw1qfvLWZtm47pjiZ+5?=
 =?iso-8859-1?Q?BJOrYz8LOgJS3jb9XP/FRwONmBoDFJk1qyM4VnWy4xKxBLv6u1hxMqwUHo?=
 =?iso-8859-1?Q?v9oh5HIOQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ftC86u6E2bydr+WQ8QxC2pLndSMXIm/6wTpBxOdiy+o3SYBah8+dLqeUqqjvUKs5MLxAdyGZzWzApsDQ0Cooa5+bo04B0U0eCJ0KEnDrlrE4lUUNjVDhJjKeu+pch2d0t9nwpIlE89Gc+HDPmh+vT1p5kb/jemGeLTeFmMm/pr1cfqIFwG9k4zh93r6xFyCj6dgCt5sIrgx2iFVWlxYE5NHxWT1DlilNEUJtNV22k6rD1McNo8wOcPDbhQyoMvPnl4hHhCqJGfZm68lPOSuyiXTdtx7JiFSrx8Tv3B+zfKtGhwOoulQFgVt5OdcGfIGX/iS31jGmBGi9Dg+WycL3hA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d87cdf-30be-4970-b4af-08de8afbe9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 05:52:49.9245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVNDKpqb6SHrH3uIhdTq0+9wAFpXyKr7OKRV4qUaz/+KXvcunwD2PVPdMctS5vkqHWcn5GDtzmgr86gaFT5I90kseGrApS95D+JWV7wog6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

> Subject: Re: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> >>
> >> On 2026/03/19 14:15, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we invoke
> >>> the vfio_device_create_dmabuf_fd() API which identifies the right
> >>> VFIO device and eventually creates a dmabuf fd.
> >>>
> >>> Note that, for mmapping the dmabuf, we directly call mmap() if the
> >>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> >> know
> >>> that the udmabuf driver supports mmap(). However, if the dmabuf
> >> was
> >>> created via vfio_device_create_dmabuf_fd(), we use the
> >>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 23 ++++++++++++++++++++---
> >>>    1 file changed, 20 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index 89aa487654..f953db0fbe 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -147,9 +147,26 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            if (res->dmabuf_fd =3D=3D
> >> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>                error_free_or_abort(&local_err);
> >>>
> >>> -            qemu_log_mask(LOG_GUEST_ERROR,
> >>> -                          "Cannot create dmabuf: incompatible memory=
\n");
> >>> -            return;
> >>> +            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov=
,
> >>> +                                                          res->iov_c=
nt,
> >>> +                                                          res->blob_=
size,
> >>
> >> The correspondence between (iov, iov_cnt) and blob_size is more of a
> >> internal concern of virtio-gpu, not of VFIO. This parameter is better
> >> removed from vfio_device_create_dmabuf_fd() and
> >> vfio_device_mmap_dmabuf().
> > I don't disagree. So, should we add the following check in
> > virtio_gpu_init_dmabuf() or somewhere?
> > if (iov_size(iov, iov_cnt) !=3D blob_size)
>=20
> I suggest to have a check in virtio_gpu_create_mapping_iov() since it's
> not even specific to DMA-BUF.
I think virtio_gpu_resource_create_blob() might be a better place to put
this check in as blob_size is relevant (or valid) only for Guest based Blob
resources. Otherwise, we would have to pass blob_size as a new parameter
to virtio_gpu_create_mapping_iov() and modify all the call sites.

>=20
> And instead let's ensure iov_size(iov, iov_cnt) >=3D blob_size and reject
> otherwise instead. I cited Codex's reasoning for this, which I totally
> agree. (I applied the Codex for Open Source program for access to Codex.
> And just in case: we are currently not allowed to use LLMs for writing
> patches and its use is restricted for the other purposes.)
>=20
> It will be also more of a bug fix, so I think it is better to be sent as
> an independent patch instead of including it into this series.
Ok, will send this fix as a separate patch.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> Below is the Codex's output based on commit 8e711856d763 ("Merge tag
> 'hppa-fixes-for-v11-pull-request' of
> https://github.com/hdeller/qemu-hppa into staging"):
>=20
> In current QEMU, omitting the check leaves inconsistent state possible,
> and the effect depends on the direction of the mismatch.
>=20
> If iov_size < blob_size, this is the bad case. The dmabuf/export backing
> is built from the iov lengths in virtio-gpu-udmabuf.c (line 45) and
> virtio-gpu-udmabuf.c (line 63), but remap and scanout bounds use
> blob_size in virtio-gpu-udmabuf.c (line 73) and virtio-gpu.c (line 761).
> There is also a fast path that directly exposes iov_base as res->blob
> for small single-iov blobs in virtio-gpu-udmabuf.c (line 136), and
> scanout later uses that pointer as image data in virtio-gpu.c (line 662)
> and virtio-gpu.c (line 674). So a too-small backing is not a clean or
> obviously safe case.
> If iov_size > blob_size, it is mostly a semantics issue. QEMU still
> bounds scanout using blob_size in virtio-gpu.c (line 761), so the extra
> backing is usually just unused. But the resource state is still
> inconsistent.
> QEMU does not currently enforce the relationship elsewhere. blob_size
> and the iov are populated independently at blob creation in virtio-gpu.c
> (line 362) and virtio-gpu.c (line 366), and later backing attach also
> does not compare them in virtio-gpu.c (line 946).
> So if the question is "can we omit the check entirely?", the answer is:
> yes, but then you are knowingly accepting malformed guest state and
> relying on later backend behavior. If you want a defensive check,
> iov_size < blob_size is the one with a concrete justification. iov_size
> !=3D blob_size is harder to defend from the spec.
>=20
> >
> > Thanks,
> > Vivek
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +                                                          &local_err=
);
> >>> +            if (res->dmabuf_fd =3D=3D
> >> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>> +                error_free_or_abort(&local_err);
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "Cannot create dmabuf: incompatible me=
mory\n");
> >>> +                return;
> >>> +            }
> >>> +
> >>> +            if (res->dmabuf_fd >=3D 0) {
> >>> +                pdata =3D vfio_device_mmap_dmabuf(res->iov, res->iov=
_cnt,
> >>> +                                                res->blob_size, &loc=
al_err);
> >>> +                if (!pdata) {
> >>> +                    virtio_gpu_destroy_dmabuf(res);
> >>> +                }
> >>> +            } else {
> >>> +                res->dmabuf_fd =3D -1;
> >>> +            }
> >>>            } else if (res->dmabuf_fd >=3D 0) {
> >>>                pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>>                if (!pdata) {
> >


