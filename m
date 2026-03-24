Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1756F532D4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ucQ-0002iO-F5; Tue, 24 Mar 2026 01:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4ucO-0002gL-HN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:47:56 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w4ucM-0003Al-3Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774331274; x=1805867274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nzrbsBhX6WkCPBL7y45xHB/l6xUAAk2zGwQ7jy7btvM=;
 b=ASlDzZ8ps1k4Y3C9bB7cMNDZqdhUjpaHpOCNWindphxdVbVclm/htlgc
 los5R4BrzSKdsdstCiRk9fvpVVz+wBeJ7GpbUoYqUtXjUwSV4gh+BM8A0
 QHLEsXraD6nvOZFF/I1thtV2dGWBaV9I5wNJualV2Hohh4JRIZ3+kHP7N
 t5AnCYAUl+TDgecnb8OVdG0E0i1+BD5KrRPW6Jt7k84f/cWZcK1Fg8/tm
 W/6qK1+Dfur+wWHV6BMqjsz0thA3hT30/7VhlkA5+SWRR8+jrdRkFI6vu
 tY3oKinJsWAEPQmQi87RFflJhOIMUdYQIVV6R4RTLRTSewGit6D7Shems Q==;
X-CSE-ConnectionGUID: BWDatCpEQu2mYyhiuJ9mIA==
X-CSE-MsgGUID: TZOrt+lxSaCDI93E+KAlzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75246805"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75246805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:47:53 -0700
X-CSE-ConnectionGUID: rCtRtmWvTvmOaAs5iSsCnA==
X-CSE-MsgGUID: BtsOa2FiRLixVZNxcLPXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219364674"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 22:47:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:47:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 22:47:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 22:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjziRYnC7rMKn3OBrfyUjFj2KSqBE0bMyDaLAgE/p5b29KhwYUwxTGzjodMNCioqdjO83sDCpOcnHIV0A7xu+1rZjZWcm9D5QbeAKX4AK7o2OvTn2gCFPfIrEZ47dggMBX4uTktGn9e+WcMe2hm2/cRurELUyUbD9bftiFrc8ITfRVLr1CmpEN6cEwjfaBzncKw7kmGmUkLoCKrkj3ihemG8/kfcXKHUrJQA0U3Gytcjh/f0bHfktGUGfi4VN3w0kxapWH1LkzRRDrwyoOddBRHBzGa02XiOCkzu19ndtCElc4Fy1NPERSYR9iZ75dVGmY2XyH4Rrk+xwSKCcDU4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmXw8bt1NJGoTQDpvi3pdEJAW8fsyO6tsUav6wzqIS8=;
 b=b+rCpbDGsimIiGI/e1UoW9MvYqLDmUMP3B/WUuwYC8ZtexjIRgC9P51dGGf7z9BBe2m89iUsB7ZJqkkAkJUp06HlK7SuAYxC0WvaiGJIDLO5oviU+q2kQQ9yZcxbwd/Dx5OCcwDdeyvm7AojD4Bn+MN5vsckqoW+VsuBLY/mnTsPSprJNwxhTOdofkvBcMqhHBjVaxHNnqO4mstsNqUGVUywNN5l6LrWaCLrDZLQW8UfL+XKGGbl2tP/LawSdeg5HWM4al4JTh4TGSPjYtscucZQcoC66ZfxvPSZQv35hFQvBPFEb69hhO2pb8uFAYH8hV0m8oy1RGPs9E1+Kxs0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPF25B1C4D24.namprd11.prod.outlook.com (2603:10b6:f:fc02::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 05:47:49 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 05:47:49 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 06/10] vfio/region: Add a helper to get VFIO region
 from memory region
Thread-Topic: [PATCH v12 06/10] vfio/region: Add a helper to get VFIO region
 from memory region
Thread-Index: AQHct2B91u9wkJBABUShmql52JuJDbW8aPWAgAAZMxA=
Date: Tue, 24 Mar 2026 05:47:49 +0000
Message-ID: <IA0PR11MB7185B25C65D09D10D18F0915F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-7-vivek.kasireddy@intel.com>
 <ab984d46-3b70-4f6e-b035-3895187164e7@redhat.com>
In-Reply-To: <ab984d46-3b70-4f6e-b035-3895187164e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPF25B1C4D24:EE_
x-ms-office365-filtering-correlation-id: de8df030-c5db-4140-9803-08de8968e21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Ed9o3BtRdcZQluaWY191LEaBxAH/WXx4Atg0k7RLRBTjw0gFWAyYQKxVBzwTk5K90pgWDg/8jVeBz31pmNFcP1DsBr4OPBuZwGx70p59wg592aPeyuSFj9FQw5UinAYts0J38MbQ8rFUFnnwBoqMO9HTnDO19uFGgc3vTkSnzaHpsxu6JhL7lz0qdDZE3KuO8kPr28W0Q4aaDpBwNJ4vh+CcpGzbZT2fcds++wGlFar+P3OTb9DLzb8jFpY9+W6PwFhodfaVUs+6qFXxc53ouwqwheaRGXHypAjJZwygYu9h3sBvtmPiKlJ64GE001m4f8+fB3CTiM4VzcZ4awVwpQb03mMKdpgof5/Hne4R20P3nFWyFiydFx+LqhOJ7E5NLijFD7tmB91LL8aqbOzNmIWU+2pLCZK/Ebz/MQxT5+eor7aCpNAdVMqVaHqOZPkUejCQZBinZTjvKP47XFS8eoe5jP0klTvoe+Cud5ZbrwhPbq7YamI7AF2fhxV+mqgmbOmXuPEQG5piNrlSXhv0TTv8wUADEbJV11k0pEC2oLXpcY5xogjzAeoqcinROKOB6cZbDGK9+TS8wreh25b7YG/Agg1XZ5ctLSewnEbx4H3Bgr3TYKP0UGTptG018HqjoBqddBtyWW42yYACz8WirA+haYGC2/sVUc4nnWOHy6xrkfxCTUuxa/ob1k1NueZiRgh9FRJlhZADlX3u/qd30kX99r9wcFIECT6OKtXWQ5aE0dgiitgZIQ3WKIJOkYFJQiIhNIqEn2koGEtCr9xzX+9OoNcV2RaogK411VTjmNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uezpKzYcd/H3fJ8tmEvrI1LCCW3A2oWmidZYjTmo8Lr1YeVeLq6X264ilM?=
 =?iso-8859-1?Q?vo0Z0gnGE7HKJjEyIH9TH+/1K8ZVA3YTVJzSDqzU5fMeuqspTe4kv2edv3?=
 =?iso-8859-1?Q?+8KRzkABDUnQE5p+8XQT01WrkqIiGZhUmhQOtD8NKHyS/n0hVH1ouLMfww?=
 =?iso-8859-1?Q?7LGgjZ3AGjxqwQPKNtfVxdPKw1qU14HxzI9k88OrM5V5t01onsxw8+7Bgs?=
 =?iso-8859-1?Q?hLRw8PsisudPJK6GHvDu8ew4/zhoXGsLp+xGHx6sruv+mNW0V/m6E33724?=
 =?iso-8859-1?Q?+R3IBK/dBi6uv2YfSmB0MTkXgy6zKRaedVXaYXlVf9mLUMTQMBObgNr++P?=
 =?iso-8859-1?Q?yrz6m8Jo+zwhcuE+xSR2IgWyTIxkryugLrZLx0yTPFsUEFuBu+5yLfyEUR?=
 =?iso-8859-1?Q?zofkwIlC061++MJC/tQongV3APcdsr8vstz8IqyNelO8brdVNUjRU433ge?=
 =?iso-8859-1?Q?eYhSNCfzbI02MaV05E0Qy+QYMnlcM1oX12rk8pPq8Yzo7Zi8PSYhvQYaUm?=
 =?iso-8859-1?Q?+ECkxkbxuzG8DiYv4WqoXqsx9eIy8uCY/MlgcCmFjMhfK0TujmBQ/BkU3h?=
 =?iso-8859-1?Q?iD652J5SbaPrVvvUKUodWAz/vcB7gZw3Gp8wu+wInDwBZeaumTZQSSz8nd?=
 =?iso-8859-1?Q?Qv8ABNUxS6YUn85b2EtLz+4VOe7LO/oNSIhkZ5yRAc8NYntH2R6kB21exw?=
 =?iso-8859-1?Q?kHaYOwyj6LUXvzyCh7EjmR6+MjWM0ooDFfxuq/zABBHP8Y+1PNr4NDVeZ4?=
 =?iso-8859-1?Q?fLPdfiQHs24i7ERHArsV2PTs+8fafboItQjWDNlfKEno+ZsSQWAut29nLt?=
 =?iso-8859-1?Q?4seSL1UhYnd1DeH1ncu5jf/1anjBsvhZzMPJ77ongmo7TLsNhgFnw6/sZ7?=
 =?iso-8859-1?Q?iS8fsGS4iIJ/g6h+foYVoH6DSD66L+YXidqwNsjUMieK19O+VjfiMCcTqZ?=
 =?iso-8859-1?Q?d5LNgbUkEOfxA6vXhVJUXU4xGIKIrr06bYDkhc4lkHk+rtVjMF/77RPFnk?=
 =?iso-8859-1?Q?WHFhWwvMHWbwIsS5AX3QshU6TC0P2TG9jgBIeZ9qkQe/niaWQnPwLbdhmi?=
 =?iso-8859-1?Q?LJ9YvxJPB69SHU7Tj+3rhHQ/lm9XLKWLXqvTVr7UVer+j+23ZgyNy/I9Yk?=
 =?iso-8859-1?Q?3vLgLDTw4/P2Grvvs7N04GZV2vuVSH7fzLXwdMCgGKciUJxI4a1D0dr9yv?=
 =?iso-8859-1?Q?DX2TeNsSkSBObuOMAc6czuwolbr10LjNLts8+Z/k8JGseosUatDw5vz+aU?=
 =?iso-8859-1?Q?ze6Q5EErYjMPgMH6v5INEYp4uwoULMFTusyLh+L6MG0tKHcKbE275htVlr?=
 =?iso-8859-1?Q?656xnAvO3MDlCIzvlle/s/CJNUFNh1Anuu0uriPmQAqfKCRWXlrBFmtWn1?=
 =?iso-8859-1?Q?r+IL34uFQYGp2WHgHfxGYn5N/C5wFA6VsK5mz12IUhs2LiFrYFLvhbRUWw?=
 =?iso-8859-1?Q?CFPu5HK3g1OTQ+u0oQ6argZ4qx23WiCEk/MmWEC57vEUKl5GMST6uG8Rrt?=
 =?iso-8859-1?Q?s6ubFRwErTcAGl+hqPWwbvop0gzz6Ak2CP7TJllZJKKj01Q+f9D3FNMw1i?=
 =?iso-8859-1?Q?BK6VIuqy+TgZmHjPoXiuDgHKynCRY6jnl6/jXpaRio+iy4EsXnJBpIZ3m3?=
 =?iso-8859-1?Q?acE8L6gjRLOQQVR/h7anzfbxFRzefp8hILkB56ODQYkVg2Pc6enBskHEYp?=
 =?iso-8859-1?Q?kJSHjQVSB+XFJtDVWrdAu8A48sPhuVc350PGvOlFsuDbWIZV9fNrJ12E2F?=
 =?iso-8859-1?Q?8B2LSa+MTF27ivDIUwHlIsiKq5Vs0U1+1gKrMDnQ1Go931AFt+C5lrZBO6?=
 =?iso-8859-1?Q?qvsvJmdj2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gcuvaP5W1DojS7yMnugIsFEscCTHkhFc5K+PbhTypHEkNPoGprItPe+y/rPrmXMLn8DDw0Cujwp+kLvlmOLXI8KjmEneWDKXNHnczONkrn6qaemF5HxvgTX+U70eQum5WpaTncZhKpb6lrqeVRYV8hkGD6fFDPsAYnt7I1zZiQejFzm9cjKksdkYvT3/ApxSmgVOnoJGsIKniMb3WGtzP3u9NATa6gg+mNVRgALOJY5yGU9S9vmHOwIfES3IhHF6BT1jbYPDyVEwXQyU3d/Mvh0xhTuSospaxWcdi1rgm/NbRu9Xi1h2JmekoLdo1frfTStqcsA93r03GAWzuBT/lA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8df030-c5db-4140-9803-08de8968e21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 05:47:49.6281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ep45w9wNtmRL3m9DdRA66yu9M6JLotY+Cf44xa0aNy4CynSiVN7/DOw5o6abTPehReMrv6nv9ZiOBi4xLw7UuvC7XxuvbHNycz+r7WztpoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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

> Subject: Re: [PATCH v12 06/10] vfio/region: Add a helper to get VFIO
> region from memory region
>=20
> On 3/19/26 06:15, Vivek Kasireddy wrote:
> > Having a way to get the VFIO region associated with a memory region
> > is helpful in various scenarios. For example, this capability can
> > be useful in retrieving the region info such as index and offset
> > needed for mapping a part of a VFIO region or creating a dmabuf.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/vfio/vfio-region.h | 10 ++++++++++
> >   hw/vfio/region.c      | 11 +++++++++++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> > index 9b21d4ee5b..3dd47f77f6 100644
> > --- a/hw/vfio/vfio-region.h
> > +++ b/hw/vfio/vfio-region.h
> > @@ -45,4 +45,14 @@ void vfio_region_unmap(VFIORegion *region);
> >   void vfio_region_exit(VFIORegion *region);
> >   void vfio_region_finalize(VFIORegion *region);
> >
> > +/**
> > + * Return the VFIO region associated with a given MemoryRegion.
> This can
> > + * be useful in retrieving region info such as index and offset.
> > + *
> > + * @mr: MemoryRegion to use
> > + *
> > + * Returns the region or NULL on error.
> > + */
> > +void *vfio_get_region_from_mr(MemoryRegion *mr);
> > +
> >   #endif /* HW_VFIO_REGION_H */
> > diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> > index 47fdc2df34..9d7ac339c9 100644
> > --- a/hw/vfio/region.c
> > +++ b/hw/vfio/region.c
> > @@ -539,3 +539,14 @@ void
> vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
> >
> trace_vfio_region_mmaps_set_enabled(memory_region_name(region-
> >mem),
> >                                           enabled);
> >   }
> > +
> > +void *vfio_get_region_from_mr(MemoryRegion *mr)
>=20
> can we return a "VFIORegion *" ?
Sure, I'll make the change.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.
>=20
> > +{
> > +    while (mr->container) {
> > +        if (mr->ops =3D=3D &vfio_region_ops) {
> > +            return mr->opaque;
> > +        }
> > +        mr =3D mr->container;
> > +    }
> > +    return NULL;
> > +}


