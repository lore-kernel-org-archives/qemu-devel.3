Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DAEC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQHT-0000HG-6U; Tue, 03 Jun 2025 07:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQHR-0000Gs-N7
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:58:09 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQHO-0000xp-IT
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748951886; x=1780487886;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AS4+m0EnLDX/VJanj4SIBrQD3Y1Koq9IudKZj0Lh1XY=;
 b=EhFwkWPNuR4+hmSiTFzc3gv1hf3vBvoFyKvsa3eE8RtciMNxH+HQ9Mh7
 UNGlxYoPPZt81odpPXGomrtpkivvLoHYpzd31jwNz3Tpfzzunzqik4Atl
 /j20hy3+Iju/QmqqpGOR2zzkXG2olYclt8vBRGIxnZPb68RjCo6T/mUM2
 EvBw2k+L4hTeAocDWVIdWUxIeJ204/XDjfQgFPSEo0IbR+CjRhGqX82Ux
 WZvw07N2CPVHV0M6q/ajEwFPgjUYkKkd8nCbk2NORRT80VijDYE0lV5YQ
 RArDH5C7KFYyv8sE/LwgLVouSaviQ/O/FdnrmBM3dDFIIKY40uDWF2ynf Q==;
X-CSE-ConnectionGUID: g7RMz3OnR8ugMZXLd02qxA==
X-CSE-MsgGUID: /DdinEIrSyuT97rnU13YLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68541647"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68541647"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:58:03 -0700
X-CSE-ConnectionGUID: 76iE+71kSpO5UQ7XqlkM0w==
X-CSE-MsgGUID: jab6tV+fTLCzy0XXiawWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150127044"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:58:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 04:58:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 04:58:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 04:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1emH8sOj79dmRGN5Izd3RQ8D3Pns8Od6J4ypiKn/TQIHjIQNjZTvaotVdzhVuLiy4P4vn80xO6d/PPZUb73jB8lbdjc3dEGo9/TnAxdJWjxaamxMEgbVa6kl6hJMZupkApvBh0haYs5HcFKpJdquhLzoqYd17kHlqzqYbfp6fWf+0iKefwIxTf1vHvQ8pU4oPr2wlxqb+KTFfx6AVLMr2NByNMvKYp2CpteHA29LVYLG9uPTScq0QbPXj3IPSFZrG6Qy25ayxqWhM/HTuxdBzwD4xYKFopQvtRH2KmLiXQMHUL/UIb5lrFhy9mnscbTQHhLSj63bei82PfS+ElBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBe4WecGp6HjiAF2alhjirSt7nuXFS/yIqW4gg6o1qQ=;
 b=UgFyyBddmtiZVzCQQoVCWur3dE1bLtd7PM30W5pQIRV1QyzjsDPCx4WQ/kLX+EAqw43SKB4l5H9oJdaaZHMNiuFo7zzn70EclW57z+moWL61Q8QDxzPIk3q7SP3QN7gWOwjMv4sjbVuTKwMKIIKmhgXu7i/f6KoWh9t7mMzBGHQUbyss4iqBLBDVeZ/M238FerRzjHmu9Y3Q+j08IjLityuTr6GU4jOp2UASf+BNIBLO+nrlrj+jNZBV7eMrTcvEJFVa6bPttgXYYTHMU5dKzi7FTco9HFiz9mH6+hGxdx461k5N2LEejMVeTUY5yDZkKntBaSllNbHMIJLHzPjV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 11:57:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:57:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 10/43] vfio/container: preserve descriptors
Thread-Topic: [PATCH V4 10/43] vfio/container: preserve descriptors
Thread-Index: AQHb0M9fH0H8hCuFF0yIM2vW7rf2cLPxW7Pw
Date: Tue, 3 Jun 2025 11:57:59 +0000
Message-ID: <IA3PR11MB9136CA6987C70146C005951F926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-11-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-11-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW5PR11MB5809:EE_
x-ms-office365-filtering-correlation-id: afa6cf55-9b94-4537-9d06-08dda295e29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OWtmzaJpy/NtKc4MBJdjqxifNwM2+M2Pgr6xnJzT5eBRqIOaQkREMbDpVcF1?=
 =?us-ascii?Q?qhrReTfzFp9mqS1RDkUykOQWXyKJOk4SDrbXstQjt5xWvFkXac3rMvMXBk4d?=
 =?us-ascii?Q?17dHPtYtkLgjPuiFke8jLtopUnO5FygCZ3EOFA3/mlYarEHrXFv07Y1CC7h4?=
 =?us-ascii?Q?n5sIqwQ6MRrcTiPkMNsYQIVhzHHf6xw8CSmhWvYke0WHxaROq/ssf8fuZJMI?=
 =?us-ascii?Q?c44V0QlMfdM1ofLhrdkzpvhwNm/c/TntLZe6peAbyI/BQuGWJNyO9hyPN4ui?=
 =?us-ascii?Q?b3BmRblj2TfnQQdj1rXqUUB5l2StZnqw1sVfY/GGdGTOoNkskW12fdeUCXhV?=
 =?us-ascii?Q?8HW4CmorZdYdrYaRKPMHpi0oMsi0TMvyhoqBWyh2Ll0zmtTIqCtQ376C4lFe?=
 =?us-ascii?Q?jjtnNHE+h/h0RFp0LvtYL4EjTpf8R1feqpvuw1rU50KLzZu4G8eTj8ERXWws?=
 =?us-ascii?Q?z5guKne36gi8bSeyEM/JlSND5/Kqew4bRsXN2VRYfuKgmpfpwlfcHLEPGLjt?=
 =?us-ascii?Q?yHHe+JiDvDhTE0T2zAKMDui1H/1XwqLcx+Mqrsc/gHsdz8rlWfNWdNxgN6Wp?=
 =?us-ascii?Q?M6nuQMc8FkRxZ5hEdaPZbNYFwKGMse/t94l7QRqdV3SLL0m6Pwgacz97v8Rz?=
 =?us-ascii?Q?OSoTIGVZp5YaOcUZt0SW/09vB+xQMQNJKVLrQJJMGOo6LbxMZ9S5MjbZMHZM?=
 =?us-ascii?Q?5hpsM9vZ23tX21Sa/e/46MpnHZx3XzhhQMXg71Jy22bymWw/DOaVkkDVcVxn?=
 =?us-ascii?Q?W3O43ghfebedhpJsRazU0hsvGLX5Ea+/LHRwy3bKWxUiRt3zmztS0LOscyq7?=
 =?us-ascii?Q?0rc9eenQaGqoegHL9YOykRAgI9RU7EEjnX2Zh6DNcJeiyW9gvW45TGsF6eLs?=
 =?us-ascii?Q?9dDeEehhsnuua9iWAdR0SF9caWRUvqFxfClHbSxeQzPyWQzK7Tkm2JZlLRVZ?=
 =?us-ascii?Q?uU+mr5viP9QJDGyd0Acr4bdly3e/UB21PvaX5wME/SeNugcrJtvbFG4uP6bm?=
 =?us-ascii?Q?rCCLoO3Ysmc8vpAAhvIMzVXedDkVqqgx+6PadKLtTmho4trVwLRLRUfIY0NY?=
 =?us-ascii?Q?iMhP4MB+nLHS7jh8Ue6ewE2UkbBO4OwAF0LFZ09qEQPwccPvV9Exbox07L53?=
 =?us-ascii?Q?/x2DnlwFccD+66ZLJVb2YVsKbnuC/oSXpeZy7Q/pigl/kTeURSMxGteEmwCI?=
 =?us-ascii?Q?uMNaLHhRuSTfrh+lY1Y1cQJpYy1pLgwn0LvdlNVKLEqE3gQVtP3wOasmC77j?=
 =?us-ascii?Q?ConhZUS+PkeL0me5RHJ/9GAlSjqi3Ne3dHdJpMY/e4nQ/MDm9WQt3r7jwo5D?=
 =?us-ascii?Q?8dj49LMCPOvV+TeQaNfcRgBsrvO4aaAT8LOCRpR+4he9Hfuf1E7XtNZwvQFq?=
 =?us-ascii?Q?2d1o1GaSGyZjEpYcaef4Uf0+uZbEwlo2shgRWYQT9GsK/M9zlootkrHKx5by?=
 =?us-ascii?Q?5x3cCpLYtKmvsjxkCv1Ch/C7mXwsFcjNBWhVCNLmWE/XLq+rSs/giUCYrdxF?=
 =?us-ascii?Q?gw8GS0Dr0bbzPVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlG22nnBqBIjzAEY7lBy6uzAbfHSemVIg62KhNg7qtqS8lTyj0d/k60Ppmeq?=
 =?us-ascii?Q?HtaSRhnmmtQHwkXSqc407pTyx9wFMuDTPZ2M6ST+mPhf2G1zKrZx0N1tBBKT?=
 =?us-ascii?Q?G4ha3Kxt36RmZ6qZMCp008jI/xC3FteRL1yMh2WyU1bsvFwtgBGQx9HMT4kv?=
 =?us-ascii?Q?pB0d+N6RL1QA3xuSg3OHgT6Z8sauDR4rWsYf0iROAWSQ8qyYKicgNYeHuiBk?=
 =?us-ascii?Q?lLtWy2GfyiVigvXxOXMQgGZBHgBbRdUYWxztn60osllOlsxTGyueZQka/0f1?=
 =?us-ascii?Q?YxtrkTkJM3SXHNtjqJi2gS4stULg0Wq0o83IbKEyLekDwV9ozRYq1tfqaF8K?=
 =?us-ascii?Q?J3fz4T0QVvsOGqf5c07ZOrpba8OKWXkv20nFtpcxuyj1Kos7B0Sr226GsiZd?=
 =?us-ascii?Q?awxy5DQO8DAGirpJ4R7d71V2lJmwrNYR1RmAU49gs5PQwdG87uGTsRgzUXD3?=
 =?us-ascii?Q?Q7d4xSzUMyEeaX91do0gu4BvOtylsvvQ1HjPypteHboYW7TzoefOSydXEr9Y?=
 =?us-ascii?Q?0AOQNRJTJOS0lstQoEAEKTs1tYWEa+T5qNAPOYFj+iRIwf+HJEY4RVAGgVR5?=
 =?us-ascii?Q?0JhtWzHnU91LGD7OiMYZDm1Pyqq/8+3hZXc1V4GQTB6284KgdOnCg19i6ZIP?=
 =?us-ascii?Q?/sW24iLsbRWAfxTPdYCc8EwKOZlYxBa35Hmnnp1rj4kP7uCW1em/dicq2YPq?=
 =?us-ascii?Q?9jrZ1+U423WQTTLL+xvvFI9vOYIGUol+8ONErvb8rdLpWdvrHSG1ZV9S3qek?=
 =?us-ascii?Q?dQxkzNNcZkGb2V2bU+Ou088wea6r6sH0nAVKd2Mim7gtYD13jDDJ5sJotCVI?=
 =?us-ascii?Q?bA+VX1SB66z7GbgAQ+e3uzFDyVrmMX3htYlUjzcYaca1LUFrx2lQXzHT7ZCf?=
 =?us-ascii?Q?4T4KCt0YhwLJX8kGJrhY8/FZ+SZm027CM1jIFFjiPhDvPfJHieKe36C55oMT?=
 =?us-ascii?Q?4kIcEoIYu9Mtf7U46d989bxt/T2u5/9oJCa3OOdqU7kTBFGc7/5ox+EL8lH8?=
 =?us-ascii?Q?Q2lX/oou5TUKUNBvJ5WdAPvozs3hpGfpO0PpkNPU+pRMIhfese33GfRBsl73?=
 =?us-ascii?Q?lqj88u4M2JhDQDqSq6U0E4J1t6jZE81GVUe6Xz1kMebYMQ1x+rmwmr7OyxCc?=
 =?us-ascii?Q?fxpLZfHMiid8Bn7Y4e8DkYxH10GOn2C6P1w+h8L2rcUt1rowG3HoIVrU3U9t?=
 =?us-ascii?Q?x0hpX5ijMbcZE0Jxq5xBk7VZa0slpbF6BEoqHMsgpeFqvfeWyO2VDA1yXdEf?=
 =?us-ascii?Q?AI/rWa5yyLX8pCkeJXnj0GxfDmSBn9eYGUZmovKZ0GFUB/bDBnUzthzfs4yl?=
 =?us-ascii?Q?PyhKQgxaI1iQapuVNMJrltRrkEH0lsI/lI2MzyvnTFlIhiTqdBYYeiGVl0KX?=
 =?us-ascii?Q?WCPUFmosf4LVpSSV+t+Eqdml2RSCkgTlWYo+XIrlzcOGPfCHIZuEwuE728h6?=
 =?us-ascii?Q?UXUTjN0DvO61VHZggkUjTReIpaEBxr/qBz6vfuWkv241so2nUaoG1iW3ZTDj?=
 =?us-ascii?Q?0e1CxbLTqE0XDw0Z5l7R/wGTh6Iut96MS3/ikze/ZfDeIJKToWiYhQfz9Mmk?=
 =?us-ascii?Q?NayE3vFDfJcD4e/ZFxKAhYTmWrZFfced9ajpRI7A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa6cf55-9b94-4537-9d06-08dda295e29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 11:57:59.1974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXIyBJ9PQ81tlzdqbgabXrbG3LENy0GgY4NUKgWn0ZXpz0AFcvURkq7U0dBaQtPFIAPkJs//BLJSP5aoE6gNIs/NQmLncnOWkI2AU3I7rIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
>From: Steve Sistare <steven.sistare@oracle.com>

>Subject: [PATCH V4 10/43] vfio/container: preserve descriptors
>
>At vfio creation time, save the value of vfio container, group, and device
>descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>the saved descriptors.
>
>During reuse, device and iommu state is already configured, so operations
>in vfio_realize that would modify the configuration, such as vfio ioctl's,
>are skipped.  The result is that vfio_realize constructs qemu data
>structures that reflect the current state of the device.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

>---
> include/hw/vfio/vfio-cpr.h |  6 +++++
> hw/vfio/container.c        | 67 +++++++++++++++++++++++++++++++++++------=
----
>-
> hw/vfio/cpr-legacy.c       | 42 +++++++++++++++++++++++++++++
> 3 files changed, 100 insertions(+), 15 deletions(-)
>
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index d4e0bd5..5a2e5f6 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -13,6 +13,7 @@
>
> struct VFIOContainer;
> struct VFIOContainerBase;
>+struct VFIOGroup;
>
> typedef struct VFIOContainerCPR {
>     Error *blocker;
>@@ -30,4 +31,9 @@ bool vfio_cpr_register_container(struct VFIOContainerBas=
e
>*bcontainer,
>                                  Error **errp);
> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>
>+int vfio_cpr_group_get_device_fd(int d, const char *name);
>+
>+bool vfio_cpr_container_match(struct VFIOContainer *container,
>+                              struct VFIOGroup *group, int fd);
>+
> #endif /* HW_VFIO_VFIO_CPR_H */
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index 7d2035c..798abda 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -31,6 +31,8 @@
> #include "system/reset.h"
> #include "trace.h"
> #include "qapi/error.h"
>+#include "migration/cpr.h"
>+#include "migration/blocker.h"
> #include "pci.h"
> #include "hw/vfio/vfio-container.h"
> #include "hw/vfio/vfio-cpr.h"
>@@ -426,7 +428,12 @@ static VFIOContainer *vfio_create_container(int fd,
>VFIOGroup *group,
>         return NULL;
>     }
>
>-    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>+    /*
>+     * During CPR, just set the container type and skip the ioctls, as th=
e
>+     * container and group are already configured in the kernel.
>+     */
>+    if (!cpr_is_incoming() &&
>+        !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>         return NULL;
>     }
>
>@@ -593,6 +600,11 @@ static bool vfio_container_group_add(VFIOContainer
>*container, VFIOGroup *group,
>     group->container =3D container;
>     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>     vfio_group_add_kvm_device(group);
>+    /*
>+     * Remember the container fd for each group, so we can attach to the =
same
>+     * container after CPR.
>+     */
>+    cpr_resave_fd("vfio_container_for_group", group->groupid, container->=
fd);
>     return true;
> }
>
>@@ -602,6 +614,7 @@ static void vfio_container_group_del(VFIOContainer
>*container, VFIOGroup *group)
>     group->container =3D NULL;
>     vfio_group_del_kvm_device(group);
>     vfio_ram_block_discard_disable(container, false);
>+    cpr_delete_fd("vfio_container_for_group", group->groupid);
> }
>
> static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>@@ -616,17 +629,34 @@ static bool vfio_container_connect(VFIOGroup *group,
>AddressSpace *as,
>     bool group_was_added =3D false;
>
>     space =3D vfio_address_space_get(as);
>+    fd =3D cpr_find_fd("vfio_container_for_group", group->groupid);
>
>-    QLIST_FOREACH(bcontainer, &space->containers, next) {
>-        container =3D container_of(bcontainer, VFIOContainer, bcontainer)=
;
>-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) =
{
>-            return vfio_container_group_add(container, group, errp);
>+    if (!cpr_is_incoming()) {
>+        QLIST_FOREACH(bcontainer, &space->containers, next) {
>+            container =3D container_of(bcontainer, VFIOContainer, bcontai=
ner);
>+            if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->f=
d)) {
>+                return vfio_container_group_add(container, group, errp);
>+            }
>         }
>-    }
>
>-    fd =3D qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>-    if (fd < 0) {
>-        goto fail;
>+        fd =3D qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>+        if (fd < 0) {
>+            goto fail;
>+        }
>+    } else {
>+        /*
>+         * For incoming CPR, the group is already attached in the kernel.
>+         * If a container with matching fd is found, then update the
>+         * userland group list and return.  If not, then after the loop,
>+         * create the container struct and group list.
>+         */
>+        QLIST_FOREACH(bcontainer, &space->containers, next) {
>+            container =3D container_of(bcontainer, VFIOContainer, bcontai=
ner);
>+
>+            if (vfio_cpr_container_match(container, group, fd)) {
>+                return vfio_container_group_add(container, group, errp);
>+            }
>+        }
>     }
>
>     ret =3D ioctl(fd, VFIO_GET_API_VERSION);
>@@ -698,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group=
)
>
>     QLIST_REMOVE(group, container_next);
>     group->container =3D NULL;
>+    cpr_delete_fd("vfio_container_for_group", group->groupid);
>
>     /*
>      * Explicitly release the listener first before unset container,
>@@ -751,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid,
>AddressSpace *as, Error **errp)
>     group =3D g_malloc0(sizeof(*group));
>
>     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>-    group->fd =3D qemu_open(path, O_RDWR, errp);
>+    group->fd =3D cpr_open_fd(path, O_RDWR, "vfio_group", groupid, errp);
>     if (group->fd < 0) {
>         goto free_group_exit;
>     }
>@@ -783,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid,
>AddressSpace *as, Error **errp)
>     return group;
>
> close_fd_exit:
>+    cpr_delete_fd("vfio_group", groupid);
>     close(group->fd);
>
> free_group_exit:
>@@ -804,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>     vfio_container_disconnect(group);
>     QLIST_REMOVE(group, next);
>     trace_vfio_group_put(group->fd);
>+    cpr_delete_fd("vfio_group", group->groupid);
>     close(group->fd);
>     g_free(group);
> }
>@@ -814,7 +847,7 @@ static bool vfio_device_get(VFIOGroup *group, const
>char *name,
>     g_autofree struct vfio_device_info *info =3D NULL;
>     int fd;
>
>-    fd =3D ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>+    fd =3D vfio_cpr_group_get_device_fd(group->fd, name);
>     if (fd < 0) {
>         error_setg_errno(errp, errno, "error getting device from group %d=
",
>                          group->groupid);
>@@ -827,8 +860,7 @@ static bool vfio_device_get(VFIOGroup *group, const
>char *name,
>     info =3D vfio_get_device_info(fd);
>     if (!info) {
>         error_setg_errno(errp, errno, "error getting device info");
>-        close(fd);
>-        return false;
>+        goto fail;
>     }
>
>     /*
>@@ -842,8 +874,7 @@ static bool vfio_device_get(VFIOGroup *group, const
>char *name,
>         if (!QLIST_EMPTY(&group->device_list)) {
>             error_setg(errp, "Inconsistent setting of support for discard=
ing "
>                        "RAM (e.g., balloon) within group");
>-            close(fd);
>-            return false;
>+            goto fail;
>         }
>
>         if (!group->ram_block_discard_allowed) {
>@@ -861,6 +892,11 @@ static bool vfio_device_get(VFIOGroup *group, const
>char *name,
>     trace_vfio_device_get(name, info->flags, info->num_regions, info->num=
_irqs);
>
>     return true;
>+
>+fail:
>+    close(fd);
>+    cpr_delete_fd(name, 0);
>+    return false;
> }
>
> static void vfio_device_put(VFIODevice *vbasedev)
>@@ -871,6 +907,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>     QLIST_REMOVE(vbasedev, next);
>     vbasedev->group =3D NULL;
>     trace_vfio_device_put(vbasedev->fd);
>+    cpr_delete_fd(vbasedev->name, 0);
>     close(vbasedev->fd);
> }
>
>diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>index 419b9fb..29be64f 100644
>--- a/hw/vfio/cpr-legacy.c
>+++ b/hw/vfio/cpr-legacy.c
>@@ -9,6 +9,7 @@
> #include "qemu/osdep.h"
> #include "hw/vfio/vfio-container.h"
> #include "hw/vfio/vfio-cpr.h"
>+#include "hw/vfio/vfio-device.h"
> #include "migration/blocker.h"
> #include "migration/cpr.h"
> #include "migration/migration.h"
>@@ -67,3 +68,44 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer
>*container)
>     migrate_del_blocker(&container->cpr.blocker);
>     vmstate_unregister(NULL, &vfio_container_vmstate, container);
> }
>+
>+int vfio_cpr_group_get_device_fd(int d, const char *name)
>+{
>+    const int id =3D 0;
>+    int fd =3D cpr_find_fd(name, id);
>+
>+    if (fd < 0) {
>+        fd =3D ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
>+        if (fd >=3D 0) {
>+            cpr_save_fd(name, id, fd);
>+        }
>+    }
>+    return fd;
>+}
>+
>+static bool same_device(int fd1, int fd2)
>+{
>+    struct stat st1, st2;
>+
>+    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev =3D=3D st=
2.st_dev;
>+}
>+
>+bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
>+                              int fd)
>+{
>+    if (container->fd =3D=3D fd) {
>+        return true;
>+    }
>+    if (!same_device(container->fd, fd)) {
>+        return false;
>+    }
>+    /*
>+     * Same device, different fd.  This occurs when the container fd is
>+     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
>+     * produces duplicates.  De-dup it.
>+     */
>+    cpr_delete_fd("vfio_container_for_group", group->groupid);
>+    close(fd);
>+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd=
);
>+    return true;
>+}
>--
>1.8.3.1


