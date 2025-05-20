Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E32AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJ4J-00069V-Mv; Tue, 20 May 2025 05:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ4D-00064v-Oh
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:15:21 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ4B-00015T-Bc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747732519; x=1779268519;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SuCXeDVanmOZxwbAZxieFAIcVnd5P/ar51uyDNuxbh4=;
 b=MouZnHrKq9LyYIV+uzSiJzbYwvSCCyoVyeLkKYkGOhz/WvdJ3fCoRhBD
 DhNNEvhSw5jJw7siWgavxvWw2SKb80hJdKTZPm7pGB/TjftWQxvTqUDGg
 WhDUSfUI6XdH/8uvJyi4s6zXwY6HIMcHntwQpwyrYQe4IR+2TAdbh2eNX
 WFbOGOXLJQbYxHdFsp0a1iEjPXCHnm5brfaYXKj5bzLIdongmbPzXPNgL
 4zWASX3+CkT2o/BnLNfNvuVPb7tzFa9vjVO4hGyvnS4YY2mSe9rqmP+h6
 DVsE4dO3MNHPISgU0qK+lXeglpt7Nlfh5SLK2hDFPPYeGu7AmaAP0YuhE g==;
X-CSE-ConnectionGUID: 3MGXmUG4TPWByq4Tx/VOow==
X-CSE-MsgGUID: /BqvHFkARcCLALj8F8tjyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60694835"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="60694835"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:15:16 -0700
X-CSE-ConnectionGUID: 92D+BJRcRdKTzBZi7dZDmg==
X-CSE-MsgGUID: iVqT5wP2QBu+M2Sc20Ycgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144758817"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:15:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 02:15:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 02:15:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 02:15:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeKbgEu3zeg26p3odku4Y48dkId8tJ5bIYF+BZ+itckYS4QdcU+6baEz93aodqK7IikTZfs8gKbrB18uEfaIBhh9yR4VTptrnV4DkNu4kSoH3HKu1Rnl8hAWnfKN+Pkjwdy3fXQwZjXRAqKw12jXlYUirPklHMyENg1ChSfkhuEReChYToUhAX6VAtcHjdOiuJgCc4GLdtWI/MPophM1Ter0K6432JxHp0AEbp4c49EpDiStqRiIbR+ECaFmBCNngETBvP5d5KuR5cQTDBuNEOyAX1VnSf9CnQm2IkSEUj5/+PhdadzE92as3x02P/RGoeJcJKLOG/4Gp/ee8jMqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAM1HkOteiFj7NVoNgDi32KWoqN+BcoCLFW7rdoS1kM=;
 b=Oo9O8nscXBUeZb7gBQYHWgxjZ4GG+peTwYtcv+r2nHKeZAmjuTuxCLAbkYZesOkK85pkEwOBWZCzuT/xHsXeGQLQOa0byYUrrum4DUHy6sl1PfZ7BCVAe56jl0hcWcFOLqUyJAEdeIQZEMrJplOC1O5leZVil1kxDWHvp8C2jS4Xe2j0RB/80Ri/O1G+A9umVhsQ2JaHnzxsvOKUzznOX27FM3aGB9rIm63KOd6klnhHPNrD+jT0zzy7WLxy8DHzT5YqoZnNTJ8zmIWqXIi+ybwI4HkWO4PN/5UPuehe6mjeriaNpOd8EfEN8Tv9IbUJnrbNSlOG2XzMnZJYMAaUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:15:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:15:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
Thread-Topic: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
Thread-Index: AQHbw1NdfsZ61LQreUmnGCD8bDk2g7PVDE2ggAUZQgCAARLjEA==
Date: Tue, 20 May 2025 09:15:12 +0000
Message-ID: <SJ0PR11MB6744E4CA30E811112D7DC9E6929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-37-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB67441B4BA69BF42F30261EB19293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <fee4df02-876e-420b-8afa-ca8745c81c1f@oracle.com>
In-Reply-To: <fee4df02-876e-420b-8afa-ca8745c81c1f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6034:EE_
x-ms-office365-filtering-correlation-id: 9c4a762f-591d-401a-7721-08dd977ed387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t8qNpa9rOPfYFzDdvdnETmH/myx8ufUizvS2LNYMDfykMMqTY8ZiU26TlBR5?=
 =?us-ascii?Q?K+cj9JLu3Cccf7ZGtwpYYdJnQVN+GL0oGg2Z5jerjlA3nF8xn7p1rYKL0/+z?=
 =?us-ascii?Q?buCzSvSXE0Itf+bqKHarlUCgO157mZKSF509pawUDXGPqdQEtBdKUpmzyO7r?=
 =?us-ascii?Q?CbqMmkAsjXUeN9gIKPEF3Nxa2DkF84/KAQFX19qTPtP9U1wVpF0umxAvz64a?=
 =?us-ascii?Q?v7kCVV733gYf4LWyMXn62nf3azBbIVXTHD/KYZM8zAd7zY2fJ/fHMnUIx2cn?=
 =?us-ascii?Q?6zgs8gQbU1Zxi5lYxQjtvrL6ANVIb/Iqbk6yUAZbW2wIqvHlCPtQBEdNBc4v?=
 =?us-ascii?Q?nwZdLcLJrB8/TpXMh0Q8GtXl3uxVkngzG2rgBvIie35Pk8L+DJXxiA42jxfq?=
 =?us-ascii?Q?rWDUNhvUg8R38QqPPwiakHJlcHGN4isHiwWXx/oPckk2KQb0tz+q2fYKxqLA?=
 =?us-ascii?Q?PFio9HCIMuwt0LsS9glZU+5OBD+5e8ew3hMubLBKf9ewAVSubQVsyGQTNl1Q?=
 =?us-ascii?Q?tDzAh9tKLj+LkdjwKJojNAlfo2RTLXr4YRZQx7xHY0YXsCtmV7W1zNG41p7E?=
 =?us-ascii?Q?Ij0b4bNwuPydq+Hb9iHXsF1jxKb50c3GTufGm3XD3xo/5lrsTp3yr3EGSrwP?=
 =?us-ascii?Q?jK5fYRaZSlQ5I7tSoytV302cQA1lrbRuf9DBXYBy+dq+kQHbCurknd41QaWy?=
 =?us-ascii?Q?56/LMIM/o7MGB5s6TYgP2imlMYE5S3gX5th2gGUCWE1M+v5afqX/jxsh3dYK?=
 =?us-ascii?Q?C4Wuo/N9aaiSGVwQINVKTgkSPp11A2oh2jeNShhZJkSye9zn5cVvEOC+kb9L?=
 =?us-ascii?Q?3YFpFdlgQoh5/io8jsir5+V+407ez729Ktzc9zQEYRQlPDpjE5DxjbIXs0UM?=
 =?us-ascii?Q?eOmmea2KedDvLeQoVucgqw2T+MmdpaU7UFTeuSALPJom/lrdZdOooWwCyd4u?=
 =?us-ascii?Q?YxAsiUJ4fxhjd2nifXBTyBuCF2m0OZh8DXtlv3lR0oWgW5hXnyntjV0c3UIh?=
 =?us-ascii?Q?lxu2D5cMpZ4QtSrvsqdWOHMuL7B4pJhv9Kg5RvdZWrdVpjRtfLXZrbb3J2TB?=
 =?us-ascii?Q?U7MXUqFNiBjJ+FpGKBk+/VrMa65N00gzOZvOFACm93B4XxL7sY/uUZ04K59k?=
 =?us-ascii?Q?jzn6P5FCxGZnibWhS5rRwUHccwpV7gJjOImdV4L+uOaGfEBy5aWiP5MXhs9P?=
 =?us-ascii?Q?EWGjUpB5i8qgyXnZedUZD+NLU5q1Hd3nUudS6SUqNMBhhCd9y82uErtbV431?=
 =?us-ascii?Q?B78CHbW3bJnLkKMhn6B9qIggHt4TtPVirppRVTghkbH0Zt5XaXj5oM1v4oHo?=
 =?us-ascii?Q?+mAzwRBnT0Fb+z1nWECS+1H6Uo8jmEM+HXExKAVAgr4FktUzgpJHeFxfWmuj?=
 =?us-ascii?Q?M2B/WVDR8OapQ5hx+eo428Xe4vucQ7/SGx1TgBwSuCNtB8BVjw98Ag8gNbOH?=
 =?us-ascii?Q?o2L99Q9pQgs5MCpf/KRkpGD39IVJe2CIgwJ95s27Qm3XXdW5XwBU/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxQEEG20AHZK26zn9J6eHzrk2A54mkuABBAOvwdl894OsgvIGjFb8uO5308g?=
 =?us-ascii?Q?duwtALu3FxAndI4EJzKAhDphKBUiiXvQgk2hig2fCtEfue9s48zJi4ke2d+5?=
 =?us-ascii?Q?F4wqRAnhrhkGoPubckRm3gzJVVm1aNd2NkYFr/0zRVhwuGuFNvB4r/AdqMP7?=
 =?us-ascii?Q?1HtspQIJnXwZNWZ82sIP5OmGbfhH96h3+5JxxLaDS6x1opOwzZnPuIeUx7Za?=
 =?us-ascii?Q?O2GEUgMgC/jJUprkDWeYtjcOBVmLHNJ5Y/yBDESot1Ev/lrWWlPdayWuj30E?=
 =?us-ascii?Q?84S7ppc6auPMGp/lV+zSHmbKyVWz2exfOpGV7mb/V4FJk3kcSmCOWHutjDRV?=
 =?us-ascii?Q?FbdfFOXBmViXJMoNJKr0eoHtjTlD+JrI6qKFIgUg1nIUCBu+hmRqUZgGpSA9?=
 =?us-ascii?Q?m3HuUmO7qKlOdq4pSwpDIml0DSCU6FjDbJpRZFwgGCPY3zDvluQqA09RCtFi?=
 =?us-ascii?Q?gMKLG/bcyG0L1xTOD5IQnh0IH6vNX5Ml7FNP1m4XqxY8w20Toxh4vUAXKqK/?=
 =?us-ascii?Q?BtIQN+B+lNy/+4vHDRIXgqadRKGrDgRJmphHPlu1By+1awgalhKRK4xV44ic?=
 =?us-ascii?Q?4U1uwi4FriZpO6iiHuNLBmTvjGu2WRBL/99yg6+wulDsVvzDbbunYFv30+5c?=
 =?us-ascii?Q?gI0VJYrnWR9799tDZWHdLMCAqA8H6n3Iy1fCcgQamaXZw6Cp+bgODQoJyuE1?=
 =?us-ascii?Q?DqLRtX6X1WuPRQZ1nPfufJxA+oeoTdSy5ePDrh2dQbNcD377oZ6MdKbR5e3f?=
 =?us-ascii?Q?7OxNWqSERxNMi7J+m3uyfXEtEQOBoTZTwHq+V7BH2z9Dm0ynWPb0mOnBtNY0?=
 =?us-ascii?Q?paZpIhQu/XFryZES2578dmT2iD1yavZGJx1B1FgpjIZL/Rc5pnxg/3kg6DLv?=
 =?us-ascii?Q?w3l07vf0LPhVxWs6VnS0720N9+lHplLrOudN8bG2OrhupHAaBDxVr8613h01?=
 =?us-ascii?Q?Ln3xFlD9Ycn9p/joFUeunDLIBYlWgE4ic5TbP9/EJyiMWUGQYJYcEd6z4k94?=
 =?us-ascii?Q?sH0qXfCmQXlNNpqrsLsPzjb2ySorDGOuivWrOSiHYRex3ejcyVc1qQMpl2MX?=
 =?us-ascii?Q?lD1yMIuQiBhuaixpLd9k8k9AEw7K1/O8o5ELxxJJ7r2IhWB/aUrWgLb49Xi3?=
 =?us-ascii?Q?m1VYO4Orw/Uv9EozCoX5YZjZimSilxVfiZPTuadA4Qd8PfC1k9HHYZEJWf0j?=
 =?us-ascii?Q?tSM1SwWVmcHDUkzmREGc+byfQvBfkB9TntLdR4mmoTxZff7sm8XrQpIsLiIf?=
 =?us-ascii?Q?D6gC1uaqbjP4SRGr6f3XTxauawEajAXn5snYRzeOz2ym/BTsyBHplIPmI6v5?=
 =?us-ascii?Q?C15NFn/6F3pGQKea3mRST+uK+KjJEQmuzeAEAwmhfHOvBl3sD7mLuwKQoqhe?=
 =?us-ascii?Q?T65b0fSiFWn3K6BaK5TYO20mX/tA3rzT7GzDeeKCnQGuEMxrh0Rd+Gm1xMwU?=
 =?us-ascii?Q?2SLqeIczL5HxZsQrNGaqxACwcLTSrj9cg2S/0GPyH887EMunxCbcyh6skWqo?=
 =?us-ascii?Q?/R6AwMHaxa2Q6Fb+R+C7++3zAhNQXB2XNx7WIp59y+iGq992KIWPVNhSd1Or?=
 =?us-ascii?Q?bSY0oOTn0AkbWcJMVbYJFOXsjJJ3epnJKxFWTqKI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4a762f-591d-401a-7721-08dd977ed387
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 09:15:12.6676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubazBt6550mBHo9cCke19VE098mNhpWdeEwW8tFwk1cFVEq/4UwMOZQrM4raiVWEA03g9wykscqxgeQDrUNBsk9MpR6ZfcqXcL57PDl8W4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
>
>On 5/16/2025 6:06 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
>>>
>>> Save the iommu and vfio device fd in CPR state when it is created.
>>> After CPR, the fd number is found in CPR state and reused.  Remember
>>> the reused status for subsequent patches.  The reused status is cleared
>>> when vmstate load finishes.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> backends/iommufd.c       | 19 ++++++++++---------
>>> hw/vfio/cpr-iommufd.c    | 16 ++++++++++++++++
>>> hw/vfio/device.c         | 10 ++--------
>>> hw/vfio/iommufd.c        | 13 +++++++++++--
>>> include/system/iommufd.h |  1 +
>>> 5 files changed, 40 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 6fed1c1..492747c 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -16,12 +16,18 @@
>>> #include "qemu/module.h"
>>> #include "qom/object_interfaces.h"
>>> #include "qemu/error-report.h"
>>> +#include "migration/cpr.h"
>>> #include "monitor/monitor.h"
>>> #include "trace.h"
>>> #include "hw/vfio/vfio-device.h"
>>> #include <sys/ioctl.h>
>>> #include <linux/iommufd.h>
>>>
>>> +static const char *iommufd_fd_name(IOMMUFDBackend *be)
>>> +{
>>> +    return object_get_canonical_path_component(OBJECT(be));
>>> +}
>>> +
>>> static void iommufd_backend_init(Object *obj)
>>> {
>>>      IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>>> @@ -47,9 +53,8 @@ static void iommufd_backend_set_fd(Object *obj, const
>>> char *str, Error **errp)
>>>      IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>>>      int fd =3D -1;
>>>
>>> -    fd =3D monitor_fd_param(monitor_cur(), str, errp);
>>> +    fd =3D cpr_get_fd_param(iommufd_fd_name(be), str, 0, &be->cpr_reus=
ed,
>errp);
>>>      if (fd =3D=3D -1) {
>>> -        error_prepend(errp, "Could not parse remote object fd %s:", st=
r);
>>>          return;
>>>      }
>>>      be->fd =3D fd;
>>> @@ -95,14 +100,9 @@ bool iommufd_change_process(IOMMUFDBackend
>*be,
>>> Error **errp)
>>>
>>> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>> {
>>> -    int fd;
>>> -
>>>      if (be->owned && !be->users) {
>>> -        fd =3D qemu_open("/dev/iommu", O_RDWR, errp);
>>> -        if (fd < 0) {
>>> -            return false;
>>> -        }
>>> -        be->fd =3D fd;
>>> +        be->fd =3D cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(b=
e),
>0,
>>> +                             &be->cpr_reused, errp);
>>
>> Need to check error before assign to be->fd.
>
>will do.
>
>>>      }
>>>      be->users++;
>>>
>>> @@ -121,6 +121,7 @@ void
>iommufd_backend_disconnect(IOMMUFDBackend
>>> *be)
>>>          be->fd =3D -1;
>>>      }
>>> out:
>>> +    cpr_delete_fd(iommufd_fd_name(be), 0);
>>>      trace_iommufd_backend_disconnect(be->fd, be->users);
>>> }
>>>
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> index 46f2006..b760bd3 100644
>>> --- a/hw/vfio/cpr-iommufd.c
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -8,6 +8,7 @@
>>> #include "qemu/osdep.h"
>>> #include "qapi/error.h"
>>> #include "hw/vfio/vfio-cpr.h"
>>> +#include "hw/vfio/vfio-device.h"
>>> #include "migration/blocker.h"
>>> #include "migration/cpr.h"
>>> #include "migration/migration.h"
>>> @@ -25,10 +26,25 @@ static bool
>vfio_cpr_supported(VFIOIOMMUFDContainer
>>> *container, Error **errp)
>>>      return true;
>>> }
>>>
>>> +static int vfio_container_post_load(void *opaque, int version_id)
>>> +{
>>> +    VFIOIOMMUFDContainer *container =3D opaque;
>>> +    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>>> +    VFIODevice *vbasedev;
>>> +
>>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) =
{
>>> +        vbasedev->cpr.reused =3D false;
>>> +    }
>>> +    container->be->cpr_reused =3D false;
>>
>> It's strange to set iommufd and vfio device's reused in container's post=
 load,
>> Maybe better to do it in their own post load handler?
>
>vfio_container_post_load has MIG_PRI_LOW so it is called last, which guara=
ntees
>that be->cpr_reused remains true while all devices are loaded.  This is re=
quired
>so that we supress dma_map calls during device load processing:
>
>   iommufd_backend_map_file_dma()
>     if (be->cpr_reused)
>       return 0;
>
>"vbasedev->cpr.reused =3D false" could be moved to vfio_device_post_load.
>I put it here to be future proof -- al reused flags are cleared together,
>at the end of post_load, and to be consistent with cpr-
>legacy.c:vfio_container_post_load

OK

>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> static const VMStateDescription vfio_container_vmstate =3D {
>>>      .name =3D "vfio-iommufd-container",
>>>      .version_id =3D 0,
>>>      .minimum_version_id =3D 0,
>>> +    .post_load =3D vfio_container_post_load,
>>>      .needed =3D cpr_needed_for_reuse,
>>>      .fields =3D (VMStateField[]) {
>>>          VMSTATE_END_OF_LIST()
>>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>>> index 8e9de68..02f384e 100644
>>> --- a/hw/vfio/device.c
>>> +++ b/hw/vfio/device.c
>>> @@ -312,14 +312,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>>> Error **errp)
>>>
>>> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **=
errp)
>>> {
>>> -    ERRP_GUARD();
>>> -    int fd =3D monitor_fd_param(monitor_cur(), str, errp);
>>> -
>>> -    if (fd < 0) {
>>> -        error_prepend(errp, "Could not parse remote object fd %s:", st=
r);
>>> -        return;
>>> -    }
>>> -    vbasedev->fd =3D fd;
>>> +    vbasedev->fd =3D cpr_get_fd_param(vbasedev->dev->id, str, 0,
>>> +                                    &vbasedev->cpr.reused, errp);
>>
>> Same here.
>
>Do you mean, "need to check error"?
>If so, no need.  The new function definition is:
>
>void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **err=
p)
>{
>     vbasedev->fd =3D cpr_get_fd_param(vbasedev->dev->id, str, 0,
>                                     &vbasedev->cpr.reused, errp);
>}
>
>cpr_get_fd_param() returns -1 on error and sets errp.

OK.

Zhenzhong

