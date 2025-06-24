Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE60C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 11:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU1mQ-0005kZ-KG; Tue, 24 Jun 2025 07:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uU1mM-0005kD-De
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 07:25:31 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uU1mH-0001Y6-9v
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 07:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750764326; x=1782300326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LDOyC4TAZxatMWiEv6LrJVnkSU9NzQPch2sfg2GH9cE=;
 b=f7Js6Tki8ZkGMZbZqGKhUN7Zb0hcyyKRKdW8hDc3/stf5DVQhpUOLmyU
 Cckzq3HQKIT0EiglIZrcYxKv5oOUperCcdiEqzr45hYdz1qIVxtbOVHr0
 Hgfzalw5mzzjX+a3LnQCKaX7vZJTwGZdbsGLeXahvoL7yxW1HKsnu8bTN
 /drU2tanmEeNVpBIPEc9LAWg6DM+HVRDBzFIisbmOr06uGb5u1BTr4wJp
 fqiXQbD2UxBgZCJDA0qJFOjx5IPVMjVxqZ+FDf2YaLvuIOIdUPdjAgX9J
 /AWfbUz8xeDODZDfvt2NPTvFTnf7QjrIZJog/22sv0MAo8FFod5ZNUD3n g==;
X-CSE-ConnectionGUID: uVPEHeLfRF+NeS1U9R8MUA==
X-CSE-MsgGUID: a4yTTwd9SiOPwUdFvCB5RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53100342"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="53100342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 04:25:20 -0700
X-CSE-ConnectionGUID: z+njvOAJT0+FKaQB28aFdQ==
X-CSE-MsgGUID: bzq+Y3WhRMe9zLG9QDrH6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157657089"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 04:25:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:25:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 04:25:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.78)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 04:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIJqJ6U/+8rdh1nNbbfO8+MuS0zA6qtAz96xPuNoKW7pPr/5umhqOANZOhk6wkTJ2Bb41CHrVIXLSJuDGYAXs9DILrBDGu6uUx//xvnsKhpGYE0m7J0hl4fprSaFA7qlvF+7mkN+9oyjlpwIpL3Dyn6WSY29xRj4Ay5W/10Oqbc0KvYhjy/ETIB9uUn17RrwaqLrBtDpqncNGfoNvJfCVgV1hJQOsySZ5nPfQVDn4ETYYXry34lhBBai4gEfzCbDjatmm/P7ViwJTApKG91fo9LYQkyiEsRL9maA4skzPDdyt3w3yRzO0l0Xca0Sm8xILVgASb1gM8XP6KhfuY2DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+0UOi6VYBkjXvVWRixC6CmIsuL8rGaHfl1YQievvxk=;
 b=QD7Zpcmc0mgfgM+xA9dFXZn0guLf7b3cqoiYAmupTPK3yV4Ovu4FyyuH2K8EiHuZqJG678oUwj+SiuRoNF/dAZyFsAjCEh993NNOtPe4/xlQ/lSR7HWlFzKN13gBx+Yxug6LX/dZWtYwxh5hXFbxf2gsjP9+N5ZCg8j7bGmH4vsjA/5iazfq8BjZMogJy85t6gRkVS4Jzx5OwJ87A2tDezTXZQ5Gv3fdYG9JZUE4VEHiEWb4oE7BW5K7uAKO4YlNIQ9iwIlD/FN9QZm/nNw0Iw6WNJKj+UtYw1yWd57EIxQPuh7pg9yHhsa4IZQ2IQbHLnaKoBC3cLhgUnGDk9arHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 11:24:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 24 Jun 2025
 11:24:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 30/38] migration: vfio cpr state hook
Thread-Topic: [PATCH V5 30/38] migration: vfio cpr state hook
Thread-Index: AQHb2h4KPkwfME298UuttDRrdIf1m7QSPE4A
Date: Tue, 24 Jun 2025 11:24:57 +0000
Message-ID: <IA3PR11MB9136990A7C183E88A5E3A9909278A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7841:EE_
x-ms-office365-filtering-correlation-id: de6f4460-1734-4ac7-c1db-08ddb311bfea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LQLots7mgP2X3XkD/rjtYgiRSzgbi12Er+qkLzdIhD9+BGi9B/NFisl4feiL?=
 =?us-ascii?Q?bE7g7ZVm00xqOEnrfBD+lR4cxPmOOZeZON4p5Zyh7t/XEM0RAPzthy9sblWT?=
 =?us-ascii?Q?Y7nB1yw0uKcoPq6iJ8eH3SWyYqiG1PKSZklbbl46fRXCX9XUimnV+aObbQAC?=
 =?us-ascii?Q?k8jbKvo5JY3eu5meZz0rQ8REpqbFPzPyqlRAyBsu1Z/D1UPNRqSnIcHxGHb8?=
 =?us-ascii?Q?O2eh2lJbj9UfJM+ix+Lsl0JPROsR84MirspisXng4x4D1VG1M4isonVnvIb4?=
 =?us-ascii?Q?oITcZmvUqqiW0sbcIeS1iWx+kzng2ea2kRokAbp27OhjkVSIVo+Z8EIeDbhj?=
 =?us-ascii?Q?FdPzwPUKhEc+8clhgu6YTDaNk6YaLJSGJWSEnSkuaCwY5MTOHNfOy0Py4yvt?=
 =?us-ascii?Q?QvhyeJRrHgkc8Om6lTX/CzgnwojvBpCnsHVGrFFtq0juaWk3km2iYloRpk+Q?=
 =?us-ascii?Q?2p6Qi+4eGvivvCS75DBxXPDgJcnOV0a56MHAH4E7yV3irslZKPhke6EgeGxe?=
 =?us-ascii?Q?g9qYM20FfQzqOKNmivd3v+sx/wKnqsGKuwX5RCyg/rlxULPeXX+rAwipq8xS?=
 =?us-ascii?Q?UeRw3Fo+NKqOBgDCtgDBYtLocyGdyVC0rfqQxp1mixhGeAxO8iDgMH+1IXu9?=
 =?us-ascii?Q?icP/RXkm38ulbM2GK6+T1oghUsF0BqfijaR7QmOrm4Kdns3/q3pqSe8+C/iU?=
 =?us-ascii?Q?9/Z/7oZjNnWw6kbZN44Rdkg6axhj2SBjGAWALL0Lsc7iIsnA4S5Fn+idcZhz?=
 =?us-ascii?Q?adIqixUCDYeHsEP7aIC+L4Nl8xq3CzqsLIdohUrg1wCpayy99GhCRIK4g85/?=
 =?us-ascii?Q?hl0PyKfX9noT6ObtQX4QkOh2C9uD5MBUBCi5zYjI4U+5PeWOhljviiSFkzTU?=
 =?us-ascii?Q?p4hNaM18ExYJwgzUkHExSRVlSA3vqiQ+732Fxd7t0PHvRX98u5FLtCySOdJT?=
 =?us-ascii?Q?o5cNs72f1dQHIEVBJnFqU0m5e40vQripi5XxgF9xqTTPrGDd5bW6FMyKlZ9U?=
 =?us-ascii?Q?34R20m6pjgyIHMGJTddUbYOiBfMefbwkNL4dvaZtZR9XsYtTdbBPfvBUaYot?=
 =?us-ascii?Q?oBOyAAA65VovEk/XkrArzba5SItA+x9Fb6SHG11lwZw/SViUbq6YtvYG5PdJ?=
 =?us-ascii?Q?aKxX0pgb50mLuK2zwTDyp3xIh5P6MrqI5ANOMlxWh6iSHP6kGeaQlnmHuq1L?=
 =?us-ascii?Q?UhJKfUqbum5/pZv4Ld9sGa7QxXz0ih5BzcsATWNRYna76+mNABMnR3Vl/A7A?=
 =?us-ascii?Q?FPZSL6Vfr40qLezCX1a6fxCq42Em/mV+/YcsMo12z7s8Y1zFPyIe+1rgyrik?=
 =?us-ascii?Q?ccmfDnGakFZKcquPPowUBxgJLfK7xWhjOqOGSwdKJbaN0jQ/aCGuw2fPi0Pv?=
 =?us-ascii?Q?R69eGIAF1gKqViVRFFhCOWmPuReTY37edM3lTrVX8wzvQBs9Gxx9QtK6YdJt?=
 =?us-ascii?Q?Rlgidy8m3bCfHRpPlK+aPfU51F5svJ819KZP5oG/9LPKXwdQRR9/0X81zziA?=
 =?us-ascii?Q?dY1NtunXW9Lj2pk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRkxyTxLL1eX8D9iIy7bTn2K1BlzCU9RbzraMz8UAWs4URhfPUxm21lrjLPV?=
 =?us-ascii?Q?qxhhCGkq12Nae/X3L24X7ZA9SyXVBzWl7dbXNuFaOehwZ+K9YeP/i92xqdsB?=
 =?us-ascii?Q?zzO0u/dkkxbv9ieIRlrvt8Xn3Zo8aPQPmQmTXLR5W5wZls83L9ZOQXSYBZSX?=
 =?us-ascii?Q?7bkPmX9ZFufZnNkOxNqdcuKQHSuxp/4ezoFwlRdvch1/sw5mcmNCHItkljmk?=
 =?us-ascii?Q?U+gjxNkGKfJL+D5vo32kKaif2lTMDON6QaMcQrNWSvhUFZOqPHVQQvrO6hGp?=
 =?us-ascii?Q?aWM/DNiyNK0wcfklOz74WrwMp6bkL/490Awyy2SVWDpfIFKQO1JBkVwFeO1C?=
 =?us-ascii?Q?HNWGTezNv7R95zyu6sDQdPMkHomX888ktihCWOkCGHybCcBvdYc8bO70qXrn?=
 =?us-ascii?Q?Fkx3zEzTxL9gWyqHKjkLRD5AJ2A76ARKB0ww8eVsfHbpZQqfHH75ca/j4U1i?=
 =?us-ascii?Q?2ko+PUA/45wmoQ935T5/XPSFfhYgzyI1kyb9AJcruHzb8EJqqabX1VsbYc2m?=
 =?us-ascii?Q?FZFTjJ4qCONrRc7u1oRvFOI+kilrNgXE2LTdrjuOXkhrbYKV+2au3+w7h7st?=
 =?us-ascii?Q?rot+pHH0WiyoenXqEFs4tLET+WX64kcZhCtTiSpnBOlbKybZHP5PLwwDN9XQ?=
 =?us-ascii?Q?mudpAv3uzl9Vg7i9CcePWFs6U0K0tJ1PaO2lax9raKx6I5d+2AD1V4sNV5I1?=
 =?us-ascii?Q?BTOCNGsaj5PqyBszFqkjJS2JvGIVRnurR4MaP3cdMp186C39SM6Z/eyxaakL?=
 =?us-ascii?Q?sVCRXlEIrExLY8SgB2FGJyyw3eVM5xYENlW+HUJFgiJHy5KGN6awLacO427k?=
 =?us-ascii?Q?zyYuntNhVycgYwX88dyA234ktdm4yHOsADCaXPUM3KSWcCAN4erGE7e52Og3?=
 =?us-ascii?Q?7vdA7jM1LnzOZEhnHf9jZzTvh8Q2qBCDg7SKoMAz/hDYE2lkFaD2zjm9SQDZ?=
 =?us-ascii?Q?FnZLqfTsh4sHvnFmIJxCLUtYtXaBiAMFrZP0CMQn5ies+e9Fr7EvTH66yTp+?=
 =?us-ascii?Q?E3bwL41iF4fC2XqrZOWgyxPaT10j6G0VzqGA9/tkKixA5H9UquZO0RL3D0FF?=
 =?us-ascii?Q?OEHti6cI4y8ScjQHkhl0t6g2YfHRoC6Tp+pfWCBv8onVTXmwmiWEKYaY9wvI?=
 =?us-ascii?Q?+d3V3J5uOir5G01/rtyTjL+kfAPSHSYMV8b3QoxLEePS7zThjmbEFXAHiCor?=
 =?us-ascii?Q?Isfl919i0yU/HFBVl2rDCFoBQhVAYY8qz7nQ8HBwvsqcPFyPqXeVYuOdsHWH?=
 =?us-ascii?Q?6t46JJ37LPfA6BieGHpQm5In8CbL46HskdLLy3hHflbCIwPMi3HXmMkc3w0Z?=
 =?us-ascii?Q?doxkItqhPjSACSob6XxzpEtxyw6JxR2E2iWBFNOJM5qYukU4Wd1U+09tyua4?=
 =?us-ascii?Q?6bVws7omXLKN+dzZ4dGxTfI99MLigOMnHmzxGKU8/q1u6PKIJnqruXIE3twt?=
 =?us-ascii?Q?HiAs0WkAROqyJQBp94D5GzXVEd3/fQ5rNAir/yV/pBl9B7Adf7QeXsLkZ1RF?=
 =?us-ascii?Q?IDvd2DZE67GqmIyBm1YkvGZcuebkEO+IvpgKR2xTNX7TXVK7GrVOSf9z5IRk?=
 =?us-ascii?Q?27HCdZ9TeakxCA8p0fCQhxMI+b3FgxHL0cZKdPn3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6f4460-1734-4ac7-c1db-08ddb311bfea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 11:24:57.1482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fYqsm5Ovz/GKerK5bstCHc8H3TwIJc6poPST03Wp+MrePHTFZeZ5EeVAw+2IsTYj6YQ6f5aSV0T+08QXbjCKxZsLpzBxf62afB+poxFUzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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
>Subject: [PATCH V5 30/38] migration: vfio cpr state hook
>
>Define a list of vfio devices in CPR state, in a subsection so that
>older QEMU can be live updated to this version.  However, new QEMU
>will not be live updateable to old QEMU.  This is acceptable because
>CPR is not yet commonly used, and updates to older versions are unusual.

I'm not familiar with migration, may I ask how subsection help blocking mig=
ration
from new to old QEMU?

>
>The contents of each device object will be defined by the vfio subsystem
>in a subsequent patch.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> include/hw/vfio/vfio-cpr.h |  1 +
> include/migration/cpr.h    | 12 ++++++++++++
> hw/vfio/cpr-iommufd.c      |  2 ++
> hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
> migration/cpr.c            | 14 +++++---------
> hw/vfio/meson.build        |  1 +
> 6 files changed, 39 insertions(+), 9 deletions(-)
> create mode 100644 hw/vfio/iommufd-stubs.c
>
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index b9b77ae..619af07 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vde=
v,
>const char *name,
>                                int nr);
>
> extern const VMStateDescription vfio_cpr_pci_vmstate;
>+extern const VMStateDescription vmstate_cpr_vfio_devices;
>
> #endif /* HW_VFIO_VFIO_CPR_H */
>diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>index 7fd8065..8fd8bfe 100644
>--- a/include/migration/cpr.h
>+++ b/include/migration/cpr.h
>@@ -9,11 +9,23 @@
> #define MIGRATION_CPR_H
>
> #include "qapi/qapi-types-migration.h"
>+#include "qemu/queue.h"
>
> #define MIG_MODE_NONE           -1
>
> #define QEMU_CPR_FILE_MAGIC     0x51435052
> #define QEMU_CPR_FILE_VERSION   0x00000001
>+#define CPR_STATE "CprState"
>+
>+typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>+typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
>+
>+typedef struct CprState {
>+    CprFdList fds;
>+    CprVFIODeviceList vfio_devices;
>+} CprState;
>+
>+extern CprState cpr_state;
>
> void cpr_save_fd(const char *name, int id, int fd);
> void cpr_delete_fd(const char *name, int id);
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 60bd7e8..3e78265 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -14,6 +14,8 @@
> #include "system/iommufd.h"
> #include "vfio-iommufd.h"
>
>+const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later pat=
ch */
>+
> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
> {
>     if (!iommufd_change_process_capable(be)) {
>diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
>new file mode 100644
>index 0000000..0be5276
>--- /dev/null
>+++ b/hw/vfio/iommufd-stubs.c
>@@ -0,0 +1,18 @@
>+/*
>+ * Copyright (c) 2025 Oracle and/or its affiliates.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "migration/cpr.h"
>+#include "migration/vmstate.h"
>+
>+const VMStateDescription vmstate_cpr_vfio_devices =3D {
>+    .name =3D CPR_STATE "/vfio devices",
>+    .version_id =3D 1,
>+    .minimum_version_id =3D 1,

Is there difference if version_id=3Dminimum_version_id=3D0?

Thanks
Zhenzhong

>+    .fields =3D (const VMStateField[]){
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>diff --git a/migration/cpr.c b/migration/cpr.c
>index 4574608..47898ab 100644
>--- a/migration/cpr.c
>+++ b/migration/cpr.c
>@@ -22,13 +22,7 @@
>
>/*****************************************************************
>********/
> /* cpr state container for all information to be saved. */
>
>-typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>-
>-typedef struct CprState {
>-    CprFdList fds;
>-} CprState;
>-
>-static CprState cpr_state;
>+CprState cpr_state;
>
>
>/*****************************************************************
>***********/
>
>@@ -129,8 +123,6 @@ int cpr_open_fd(const char *path, int flags, const cha=
r
>*name, int id,
> }
>
>
>/*****************************************************************
>********/
>-#define CPR_STATE "CprState"
>-
> static const VMStateDescription vmstate_cpr_state =3D {
>     .name =3D CPR_STATE,
>     .version_id =3D 1,
>@@ -138,6 +130,10 @@ static const VMStateDescription vmstate_cpr_state =3D=
 {
>     .fields =3D (VMStateField[]) {
>         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>         VMSTATE_END_OF_LIST()
>+    },
>+    .subsections =3D (const VMStateDescription * const []) {
>+        &vmstate_cpr_vfio_devices,
>+        NULL
>     }
> };
>
>/*****************************************************************
>********/
>diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>index 56373e3..b9420cf 100644
>--- a/hw/vfio/meson.build
>+++ b/hw/vfio/meson.build
>@@ -33,6 +33,7 @@ system_ss.add(when: ['CONFIG_VFIO',
>'CONFIG_IOMMUFD'], if_true: files(
>   'iommufd.c',
>   'cpr-iommufd.c',
> ))
>+system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
> system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>   'display.c',
> ))
>--
>1.8.3.1


