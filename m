Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205910A3D9E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5x0b-0002IP-CE; Thu, 26 Mar 2026 22:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5x0Y-0002Hg-0h; Thu, 26 Mar 2026 22:33:10 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5x0V-0000pm-P7; Thu, 26 Mar 2026 22:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774578788; x=1806114788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XIQTGQsaAfDYevAITXPbz12uJL7aggz2dYkM6ZJS0JU=;
 b=X+/Zvl5/aA4oRUqiaVuhd9NDi7ut8v8oe1Y/u78wLDNywN9/0JRlstK1
 Txzo4yAEsoWX9QY2ScNvC4vqwl1WA2XGh7uy9BU3+gE60jEIvsYtBfS2a
 X81M55uCdd/OWOm/V7nab6q4/j0w4rxR1mle+SYEbAi+11BztuWisynUA
 a5zwVnYAy2IJJi5U3lXXtRAmV/f64TscqqXlLelypJeCQ4pkrt5O/SwP5
 66VrFg/m3XbfRHqLzV5VMdl60tiYgA+emOEUp2XrhCf4X9UUaRU6IUls5
 kx+NZ55yJf8whEA7aMaHDFFox/z9cQdSan4e+ctfnh8Sszosc+F0+M9Bv g==;
X-CSE-ConnectionGUID: RDH80ymdRmmlrJpuLiRAyA==
X-CSE-MsgGUID: MqssXVs/Q92GdcJeoV6CBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75532447"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75532447"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:33:06 -0700
X-CSE-ConnectionGUID: n6YHuoz7SJuSI9xzBudrCQ==
X-CSE-MsgGUID: KxJp3CQ9TyW2ZZFy9faTYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="224232563"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:33:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:33:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 19:33:04 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk1TGnWLux0ciY2YNC+bPDPAzWJRt2TMGXc0mf/w+bTxJsmiR34ZQxHB1pCepZMtPTXE7rSi94I4QqUQNzOBxOfgMcM0k3p3Tsycysa77ODvJIo/GoFzAX4IWZrI+2DLKV4lbbcQD7yNzZPaxI0yVbyiILbD8qyx6ReJiEIiegKho22vBxbyowUC6UIWYhT+P4J3hJDOX77x/LlOs1uvhPyXy9+VZXYXUVxgcFh4otYhxGkGSIKtCuihv/eVnmLiT69cyjCmFdYhUsei/9aI5vCau0iKrn8/Ems0c1TUDxtWgmMyD94OLzGsRDRe3OVQeSMCnd19874dzi/jrxgkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8QPZGhAiY2u590x+BK3RabHObq534n0RaHJmOZka1s=;
 b=MPAHlVVJhuD1llyfPuL7WiToAMMd1zIkZiSrUQlR/2SIPE4lVzzfTilRQr5cq9/gtHuGaomahCtthvSmmkpz8fOoPge6ehOVOtdDzgzGjQz8tg9+CAciOoYEJV5CmN9+1URPnCX9pzmrKJhP9kmmimSqgIRs2Di33v87/elmPzbM4xqD3qAE48FTtUxx7160kRJsVSxF53gOqWj+M9VwzZCqIiSxtscHcEWflJzUhgWiBNIDxewH5g/50cYDRW8kUzXbOjJabtclLjlDkcqJgrDAsPnE3jOwPlN3kZEczDjiWnsL0NSQIMzoCGbvx4U+sXTPa96y9yWDdZLxD2bm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 02:32:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 02:32:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHcvQCbR71K6Acm9EmcQazKuEj1x7XBYwGAgABGe0A=
Date: Fri, 27 Mar 2026 02:32:57 +0000
Message-ID: <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
In-Reply-To: <acWwwzfNEzBg4n96@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: a6f80310-69df-4f8f-59dc-08de8ba928a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 6xnrfWwdSQ2Ag1kpXpgQpCe2XKPAduaucyg5Wsk9lW8mKI7P25lFFIlXkNGKTsOQ2qyf5af/ZFZuAY2QMkuhFI8Hmc4UldJaU12v2hwLytYyDp9w6Q4+/1TFlogsPygKqXwqDvcgYsCErFmkYiekzwM5fWB7mhyyfLo0s3wYK2hypWT1YMM9LMbGa2iCejJX5VY+toIFSWMMi/zkD3sla7mlrxbHeFS2nxEWyWJqmgQxNKUloUJZJ6y8nblgqD2VI1hUfYmrWp4lt1vCPmtx8RC/xlWh1V9RA8VrIArpxcoUtxsf2ho9eoXIHkYJ5uiwcDZXiLJyxZU4wSkppBEsae9w1KmsZm1YDtC+FAfug72PSNJwmokR2NwMjjYb2kdWW/1fUEolFikH0+vxzAYn5KY8bUxsdH+sqdGZkIswcM79iBvUhzTPt6faTGRJ6mH4qHkdhMxA5K71omxGbHmWVW68T3IaSN6f3qLQd+1pFmz0oOyE66GsC7Qw+iJBw3kmiKbxs41HAtY6a9BW6rfEWQfgtjke8nLaAq3iwila40lti23JmgotjAN3LhMnd8sDGujfZN61/n5etmbachio/Y8fr9s3td1LSV5AM2sppWJTzEQwwMx7N8ut3rdoArcjMwO9Qxj+krVfKNPf1DjAzRwWZbxF8B9iTtJvml5a9mUtQ3l0K7zHMazc9gMwxvf3x1T/0VdPw19JB4OG1FeKjYd9FAve1x5qp40EQv9PZ8zrpurm9+I08VaZgwq6RCMgizC8r4en+VBnUqPVxS/DY3F/c/kGTw1bXJblFTi2xd8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ss3ELoVmNSA6MqU0XqAWlc7otERaShv9+hs4mLdNpTRwTSbVJQwlHCKB+cEq?=
 =?us-ascii?Q?cvAx91Ue6XvmJwhSSHrs7WsgQP+UVL0pYTEjIRcPvFDphn19hpOos5RopsxU?=
 =?us-ascii?Q?uZr41BLSTM6JW8D9nG/fCIyTsa0qYmBvwsPGDcNFQmbeKGp3MyriDJypPgzA?=
 =?us-ascii?Q?hn22HVP3PGuo3MDWa0WJ7vPlvOi6CunanV39L0JzPFlgFZKEG8JniHN8Ernl?=
 =?us-ascii?Q?O3H/cjrTQH/XQQa6VypodKUkYcb6YWpZAFKmJ38t3ZdplxTkiADQiPMWa0yV?=
 =?us-ascii?Q?MD5lbKX8UU9BnBEpggxFgPJP4bJhdfzwWBVCQUrJfrzrGsOt134x43R2RIX6?=
 =?us-ascii?Q?oU8iRXWeGot/1GIZIfzya5bReKSGTEaeYjXcV8g8/td9ggEh6BJkUmptjfvo?=
 =?us-ascii?Q?kIcJ3buXyswuifnJL0o+AH5UVFiAoP+LZnQHtLjSKynUYGvzGvLCu3EbPPGs?=
 =?us-ascii?Q?fPuOhfhNV+ndi7IHE5iCYGFRUBYMkT/iyjqg2uMBUEaUjx8x3yzk3FOwRdIU?=
 =?us-ascii?Q?Wosxe7AIgiNFF1U0qkeYeFxSzi1UhDzrgldXlRqYrEfTSVJ/t8dxWbznN2b6?=
 =?us-ascii?Q?HGJdhRA6xJMexcJG9lGJ4IMmR+xv0xuikwxA5HlePcDbjQlYgyXVzmgSUBb4?=
 =?us-ascii?Q?1kGYEafL8OilSvvHY76KBqtqkvVQNisOh5hJwAccI4if/Sw2MHPbOBAI4Kgp?=
 =?us-ascii?Q?NwAmn4kMoTtlQ6UPyVXpuiLyJz3oJSjM5ItuWChr7doD3EGvp64UYLW/d+n8?=
 =?us-ascii?Q?XIn0glyIGj/0UPITM5ezjc2rhvlC4mogyZp9VsR/KN3TzVjpS+kqlCbPRpf2?=
 =?us-ascii?Q?FcJP/kb1FwJP8Sp5OTN37HwcwhJzOw735jyrAOmeGA+0RAa851QHOR2/uHIY?=
 =?us-ascii?Q?DjmgJS4yQb232rutVGe9pYyeWVctT9U9R+PhAK3bcda3QAziK7n+YeYaA7Wl?=
 =?us-ascii?Q?JsLrfyVhb/y/GbOV7k4lndgtAT2Zy5MmsWFLyJOQkyxdDYpbZRkz5WrYnQU5?=
 =?us-ascii?Q?8m3NpM6j/aWsFNG42MiWEDSfmC5LPD6IM3V86WzU7uD7Nrejm0NkHGDnfDg4?=
 =?us-ascii?Q?ffZZ+8KTwwGVZLo5g+OgYK+PfxZSu2DZgyDQ9IjGEJXkxO9ezw57ypsGVtf4?=
 =?us-ascii?Q?87muhAvdZL5Y6Yg6+G25WjmneOZu5J0CVDCGnYfGoAw8YRImoDF2aGt6wKOJ?=
 =?us-ascii?Q?9vJmdclwg18k7bfKedKJ3CEeHAY/aWZ8cW31/qN7yMYbZiOmW3TSreaM1Syv?=
 =?us-ascii?Q?X24R9qpU1OeXEfXm3c21dEcag0XxJZy41Iuipe0l2N5LODpdpxUXmIGO9xmG?=
 =?us-ascii?Q?7FD0h+3rkGskmIVPfIoZIxklQgFom3yH+LSsxEQMkr3+tG9LNo+aYr/RI9RR?=
 =?us-ascii?Q?vMTN9bbK7N/SMt23EWiwtpCQRaerLS5aV791c0gzRYbMQqSZRzKZzr1X9ewR?=
 =?us-ascii?Q?WTQVyY0BrT0emd7C10rmCL0i0KbyVsrpX5+hBUwCyIkztKY2t4lWv37AwIgn?=
 =?us-ascii?Q?2BPgmJ379Z3btrFIv04FCHCHVJy2ULOkG0f5rrHGhGyO2mLZVtY2tqBBC5ju?=
 =?us-ascii?Q?hfnEdkCrgdYSpyKze6hjwXAZYY8cV6yncsrhgmkbEjvoLxTijWATCPI+l7DN?=
 =?us-ascii?Q?zusIz+rXqKvZAxas/ix/k/bNGpezV77xu4Xy1S0QZSv9o+LOL3XLtqLSYwph?=
 =?us-ascii?Q?FfVZOJGktUIefLf6A8WpGzrWHXWKUamwzFpK9s3Kp97YjLA47oF7DleRvYm7?=
 =?us-ascii?Q?yrT97aT7WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kaFMnj46LM1DVGcR8QRKOZg9gJ7irENzyiAB25WYHizplyVfh/6ptLSYG44eFzKHz53yoMR68Iib/h1PCBgqPPfUp79gqUcFmDoxbUaeJ4JfBHSzejs1aXF1Z9c++67F8/WZ+Erzk9m6z98uYNxKNVkl/KmtFkaY8NSNx0NYLd6nUR8D+ZdXYRM2xWV1WFUcmViIMXi5s6x4psjSLLQAlIKinspl5xVVCqqfTtnea9zKlPtx93IB/UCBVx9kOjKPVp94b7MEkm4Gb833GheBAk04BU+dlRa5iRgzDhSU8BIXOIqAF1XRnJII/Xzp6YvBjB/HMXmw5/MjEsTskpQi+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f80310-69df-4f8f-59dc-08de8ba928a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 02:32:58.0297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+5fzpfDPlwSVllxkoRVm2tNa5bf5JsLa6Vjz2cZyvtdE9sDyylJkAlqxzn9lDDqWpJlaqoZJBGSTd15MVFCAA/vPnnUEu8HBpLYNSLGpds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks=
 to
>support pasid
>
>On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
>> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>       *
>>       * @idev: host IOMMU device backed by IOMMUFD backend.
>
>Not commenting against this patch, but I just found the "host IOMMU
>device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
>an "IOMMU device" right? Perhaps somebody can help me understand :)

A host device under host IOMMU?

>
>> +     * @pasid: target pasid of attach.
>> +     *
>
>How about "target pasid of the device to be attached"?

Looks fine, will do.

Thanks
Zhenzhong

>
>The uAPI docs has the narrative "pasid of this device", which makes
>it clearer.
>
>>       * @hwpt_id: ID of IOMMUFD hardware page table.
>>       *
>>       * @errp: pass an Error out when attachment fails.
>>       *
>>       * Returns: true on success, false on failure.
>>       */
>> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
>> -                        Error **errp);
>> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
>> +                        uint32_t hwpt_id, Error **errp);
>>      /**
>>       * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware
>page table.
>>       * VFIO and VDPA device can have different implementation.
>> @@ -154,15 +156,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>       *
>>       * @idev: host IOMMU device backed by IOMMUFD backend.
>>       *
>> +     * @pasid: target pasid of detach.
>
>Ditto
>
>Otherwise,
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

