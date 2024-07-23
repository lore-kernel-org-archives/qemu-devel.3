Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E47C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7oS-0003Xg-8d; Tue, 23 Jul 2024 01:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7oC-0002t7-Ux
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:11:34 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7oA-0001c0-15
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721711490; x=1753247490;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cB2bnkVfrZtp8CbCLmQrU8deZ2uiM2DTvf9E78wQ0hA=;
 b=RiwfyUvY0XmP4paZiUlv4FaGJG+s04UYICvWtF4VUkZfJIwJCtck3SH9
 MXv1z1sl7+Yn3gGf6kVDR9r2emU0KPaQU2KCfG3pbjNx3QhhfnwlrzNOQ
 V9PlTzdhldQRKS2gjYmPDB9hR5R058d6Nc/pJ07a97pxxN2BSvy17Ol+9
 OdO8rnNFad52CM6eSttljsy7HGhINm8ph3MjRnqO7Cnji44Z2Rka9LcGf
 ueJw3eX3Jp8f7nJ1KEbF/EgTFTWNMZek2UX8sg/9AAMvRgapZdfjQ6p7X
 5/G6PO17+K9xP3pemiH/0OnF78EEMsov9c3aQr+GV0wdV9MhkBXsLQN3Q w==;
X-CSE-ConnectionGUID: 3sb4mnr7QryZoEiIOgEaoQ==
X-CSE-MsgGUID: rVb/s9M2Qne7WmhYwTkVew==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36835934"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="36835934"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:11:28 -0700
X-CSE-ConnectionGUID: Bgx3IvPvR8+KS4H1K541Ww==
X-CSE-MsgGUID: E4+N1oVTSXKoZQmO/4Ecsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="56954216"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 22:11:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:11:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 22:11:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 22:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c64IrucXpNDq8+3uFFDFlfKqiVH0Eom8S6dhP+9dFOr994PdC2fnfLRmrcinoZev/CDXWW05+VApg24nWZ4S83GM1+4t4HyiyCHik3xpNpyIXLbT92VGJ3/wF0QZGMC1aKKNusswqL2xQ3F7fAUg7jUh5UEZ0TAWeqGZ/jFg3qgyGTSCGUhZipxTcSXY1+XR1c0Zw22rsM78l+rl16RhWVxiK8cT4YxfwL0qYMuWEYNcw+DbAqnTIM/3ox8HoY/4TdaQTmddTBRnKV4fGqGECkECR1oTkcqq/ma2kDYpdcyeh92GMZvysVRQTQkCk3/McZpTupDTjJZ3UPYqS6UFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr9fFWthEmLUIdTh+NV7TdgeGHZIJXVhgo+aX3+e9Ic=;
 b=yD1ucBtJp/Dxjt7iKY8SIa0Y2ngA3WVSdn8CBTr1FEuUk97B8tS+SjvNiEj0x6kPS9RMT/DBUzfQp0hC3B3bT67AKQNBuQ6n1X2KB8DdUopEcfYA0iN+AcgWwXWrBAYWwwyQjO9l67Wk01KOlrn+aWL1tGGZGlzrqWWYOMjhEcjHtM3Moohe6TJoNGLQhNExK8JnWDH71fNbmhISStd7CGeKXIKc9Y1vLakkj1qOcmmXe9uc0uELfSudxZCeOaz78tK7XGm0peaqzyk4YeC8aPVGqTOSs+IXkT+SdzD0FtgybPv1H+JICms6Q8MVmo1R57JFlEvPgXJkF0GuNuI3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 05:11:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 05:11:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Topic: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Index: AQHa3HwbkOv4L/RGkU2FXdaMlUqNeLIDxF8g
Date: Tue, 23 Jul 2024 05:11:18 +0000
Message-ID: <SJ0PR11MB6744237AD1896B5EFA8E045B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-6-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: eb5947f3-d5d3-4b08-805f-08dcaad5e2df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3HkIlurSWPZ6SorCShn9lYKip9fv6LddTRZZu0CbvsiiI3cWqIUoz1ulF0Wk?=
 =?us-ascii?Q?WWucYWIRecAglZ8WpSeoL7VZGYjJUXRs4met7H8G9v9IKJ+Qt2JLJxjdH8Zj?=
 =?us-ascii?Q?EjtA0+eUSdIXH7AkxqrBDcqpuY24Us1JCPZtrh8XzfIK9Mn5+lGI0xHy07Mt?=
 =?us-ascii?Q?TKdJuxQy6jKDMyaZ5+i8ZoJKB1I/+ne+AtpY1bqjjkX0OG0Y1PHjdyM028vL?=
 =?us-ascii?Q?ME68CPEwu4NhcYWlJf6VbP+DxqBAgcN+IsAiJvEQrxrXcYw0a983g2LrFkph?=
 =?us-ascii?Q?hkM2TE42Nm6fkjHVzcIDW30B6uUO3Hi2Yh+taQm9QMlY0WLWuzCcmYWUJWtL?=
 =?us-ascii?Q?bJpfDU1rrGuYv+nuzifpFzX6DxLj5WKCDXCgAB6El//HOduSbFR9rei89fxs?=
 =?us-ascii?Q?s5ibg2nuUMfi7DgSC0mK7e1pIjjvlsAsoOVORXkSf7HcFks5icYOfF0wZ43a?=
 =?us-ascii?Q?h1hyNQHsb+ot1UXeJas6/1CA0RB2sK9srdSq9PfbcVZAJmnOEA3MbwSdkDjg?=
 =?us-ascii?Q?zpkDxJHb9d04ld9MP858GSXPMZlr0vwbNSEWFFWmIAvjso/bNxKDMn8rKTi2?=
 =?us-ascii?Q?Kcorqn9es/gfydNN/edB8vYUBrDzFEU0jOMSDk9ZI4AXqhPXvuS1UNcQThK/?=
 =?us-ascii?Q?mbCjTdDyGN0K23wJjJThEr1QnlpU6CJOqm9qvDJMaU9KBlXoDxxzYjrb6C2Y?=
 =?us-ascii?Q?rvbqDo285MciYSAyQLKrVTAfPDBor6BQD2xeTYHsyutmGFN/wCmK+9iIaPe1?=
 =?us-ascii?Q?HT0riCe90yHo/YiagB4sBoaC8iFeksgtUYYQNRRUQDxYwYcj8LGSTYqZtwaz?=
 =?us-ascii?Q?WexssBNrPvcl5nJxzfMNJqVp9Ehv87a+q+4VjLn6Zo3qey2aslMKdGyI1P2F?=
 =?us-ascii?Q?Efb9wfKPPXMhCAzO+6k13J2ojAzY3uw3mnp1npmLjyH9Ae5TAmSWCaNlmM0t?=
 =?us-ascii?Q?nxnQzyA2AKfsRT6Am203LLndd2lAL0RwDu3AvPDNwbH1TxNVVy29w6F5kB5y?=
 =?us-ascii?Q?KZ/68lVmas6IUz26T71HwBteYsaGRHjIDbT1NBDwCxah5WK8EXtc7BVjXo3U?=
 =?us-ascii?Q?gsn/pFr34gwrob38Iz0lKHLZGWWcTk1x0ATdZ8gHqli3VwSlYlbzUTP5co1i?=
 =?us-ascii?Q?tSnVwch6ALhRewUHIG/3XJsaaM9njokwZiby5PP8qN1bYMAJYpukJePf0zsA?=
 =?us-ascii?Q?SaZhfVk1XHfDMbZjheInloFHuxTYfusYEQl+U9MfNkG8IMXik1skAK8MJvJO?=
 =?us-ascii?Q?4KSiusMG8sLwif9zYaasGVCIWtohcuUya0XNYjxkahajs5PMqcpaQHB9wcor?=
 =?us-ascii?Q?EpCXGFjMojG90gpueXIW0zKexyp+g3eUVV9EJPcZRiDIs/TDeWbT6ZGs7Hek?=
 =?us-ascii?Q?wSvm3GrZvP7VnaIREHrfroP5puGOgZfV1mAwfrYqq2J7SdZcug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7ecApCifx09CPJGjy8aMafvL8kadBCG0qnzhFn692rVh7dRdjiCDSCpCVdi?=
 =?us-ascii?Q?HSWUSojC3rrG9bKAZ+SbEAU2Y8h4AqxiZM0NRkQAZOBYjnzankDLRpgbALbE?=
 =?us-ascii?Q?j5y7/BkBiiylT811VWUO+0O/ydRmCiDgPSZOy2ZFPvlW0wWG8veZfd6jrYzN?=
 =?us-ascii?Q?3z3I1DTluQXXfFSAIsqI7XKR6YWtj5m29HvYVxgPHzXA1np0OMoUUfs7A5wj?=
 =?us-ascii?Q?WFeqp5FSOCsV4hoEoFKX6xDT23mPX3YnNVHGnedKlpyt4IM+bRC3zcrVH65K?=
 =?us-ascii?Q?BrxoxzWsETgXJ6o9yzbKRKzhsDEYJIouj1zPPPVkpWP9lKcXrwwsVuNazAz3?=
 =?us-ascii?Q?Y4bfW71ixUW3ymTVhIGWfYTpoEiO/6dU9xo5iT5ExBnlc5FefK+iE+jzpRUH?=
 =?us-ascii?Q?SKQqazxYcA/YGZja2TxryuaMWEwybe9U4UEvWOa1FThuGDpHIMNlsYW76M5M?=
 =?us-ascii?Q?HCIVkRMWKh6OxuB/F69x/YpUXMZNAtSA9KqHWOkKMKvzOhEjUP0buHywSJnI?=
 =?us-ascii?Q?gmfsTyg3AfRE20LyOFDvtY/RghQ2PAKqg6FGfjiiMORdRFdQZY/Ag/nE+ipz?=
 =?us-ascii?Q?0KD+StS9LKhK5AU3N5fQGrhAaag0QLuYWl7K+sxyCb5n/Jg5a2C4piZoXcve?=
 =?us-ascii?Q?hhfY5lT+tFbDqNfgUoYKkNcBrS0SuoPkOWarnwMJKiKF3oJ5U+n/i7V6lXbZ?=
 =?us-ascii?Q?gkSdZAKGPxoFSwz9uOEYQzNTwwAODaEt3CKEFfaQaygMqfxI11v9lwY2I4O1?=
 =?us-ascii?Q?zE5dPDI9e3w6ic5LYksFfz7LqfpY0OFGAlLD/DYPezsPrqxsoElspA1RA9EO?=
 =?us-ascii?Q?B+pU0HMwrpNl1LjpyHEWYYIL8DkeJE12TIBW7Z5Re9D3e6Q9KhOyVeWOSj0e?=
 =?us-ascii?Q?9alNsoL9DEDzTSorZN+w8Ki4BTGT+bsrhWHcrkB1iJ1jcxi+L8I1IavF7Bw4?=
 =?us-ascii?Q?fttAIu6yM7ezZIh9T6MEETfHdmCip0Z6ZquZCsm/VtxoXbILLEo9vfH9inUY?=
 =?us-ascii?Q?wMoXAwUuzacHq2AFkbsmy27sSsu8oxpqQcKOVaZUkYLm8kZR+OFJhWr3AA3i?=
 =?us-ascii?Q?Rui68Rr92q2CP9aej1ijzJY8de+1q0iQMrGK98JEwWJUtuoQZfPb966bHDej?=
 =?us-ascii?Q?Rw9rTDUChTOKRzYHh0d+F46n3kDaLfG9VNR1E1wsh16MT0QOqXDQD3gmdvSu?=
 =?us-ascii?Q?1ghTtLAGUKO3wncJRIyp7ynS7tKdQoCCt0DdxtwSZ9euMe6A4KfWRJL6BN59?=
 =?us-ascii?Q?0NMtps7mXYQpLFL1njPB8j81UUM4BHj23GBKfej+uDmfH2RJUUL0FEQwJ1D4?=
 =?us-ascii?Q?tMxWSUu6XZRZ7Bo7wUmwpnCow0bS0JTzuY0CWj67YNLhGq27be8PBqhIi5eG?=
 =?us-ascii?Q?OKX4PevJoiUF0yzJZh26R9Un3O+kkJO0R2mhPqyhM/0XTATM/fZ4hHXEcxE8?=
 =?us-ascii?Q?uRdNWpfF8eQDjjxlagaITsr9107G9ITNp442OPGB3H+F8zz4DXL3tCzITpD3?=
 =?us-ascii?Q?7jzrMlxV5Bc9ILLr/vPjLCq+OKupr7ZjyGegnXXdVIc7M/qNPvrTgrwzehGf?=
 =?us-ascii?Q?3nnGhlLFsF8l6B/xN2+L7wx5GeqYwpUhWsgKyRZa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5947f3-d5d3-4b08-805f-08dcaad5e2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 05:11:19.0334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOLTrOXdh0lyhgi7/Qg+imjs7kulMQdhjUbrE1H5FGD22XXvmV6NC7KYvynZFvY4W6clgFtODmzT37dVvHcIuJJ8xz0qhfFgV4db39Hl7DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
>tracking capability
>
>In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>supports dirty tracking. This is done via the data stored in
>hiod::caps::hw_caps initialized from GET_HW_INFO.
>
>Qemu doesn't know if VF dirty tracking is supported when allocating
>hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>VFIODevice migration state hasn't been initialized *yet* hence it can't pi=
ck
>between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>dirty tracking it always creates HWPTs with
>IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>even if later on VFIOMigration decides to use VF dirty tracking instead.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  2 ++
> hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
> 2 files changed, 22 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 4e44b26d3c45..1e02c98b09ba 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>
> typedef struct VFIOIOASHwpt {
>     uint32_t hwpt_id;
>+    uint32_t hwpt_flags;
>     QLIST_HEAD(, VFIODevice) device_list;
>     QLIST_ENTRY(VFIOIOASHwpt) next;
> } VFIOIOASHwpt;
>@@ -139,6 +140,7 @@ typedef struct VFIODevice {
>     OnOffAuto pre_copy_dirty_page_tracking;
>     bool dirty_pages_supported;
>     bool dirty_tracking;
>+    bool iommu_dirty_tracking;
>     HostIOMMUDevice *hiod;
>     int devid;
>     IOMMUFDBackend *iommufd;
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 2324bf892c56..7afea0b041ed 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -110,6 +110,11 @@ static void
>iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>     iommufd_backend_disconnect(vbasedev->iommufd);
> }
>
>+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>+{
>+    return hwpt && hwpt->hwpt_flags &
>IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+}
>+
> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
> {
>     ERRP_GUARD();
>@@ -246,6 +251,17 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>         }
>     }
>
>+    /*
>+     * This is quite early and VFIO Migration state isn't yet fully
>+     * initialized, thus rely only on IOMMU hardware capabilities as to
>+     * whether IOMMU dirty tracking is going to be requested. Later
>+     * vfio_migration_realize() may decide to use VF dirty tracking
>+     * instead.
>+     */
>+    if (vbasedev->hiod->caps.hw_caps &
>IOMMU_HW_CAP_DIRTY_TRACKING) {
>+        flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+    }
>+
>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                     container->ioas_id, flags,
>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>@@ -255,6 +271,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>
>     hwpt =3D g_malloc0(sizeof(*hwpt));
>     hwpt->hwpt_id =3D hwpt_id;
>+    hwpt->hwpt_flags =3D flags;
>     QLIST_INIT(&hwpt->device_list);
>
>     ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>@@ -265,8 +282,11 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>     }
>
>     vbasedev->hwpt =3D hwpt;
>+    vbasedev->iommu_dirty_tracking =3D
>iommufd_hwpt_dirty_tracking(hwpt);

Don't we need to do same if attach to existing hwpt?

>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    container->bcontainer.dirty_pages_supported |=3D
>+                                vbasedev->iommu_dirty_tracking;
>     return true;
> }
>
>--
>2.17.2


