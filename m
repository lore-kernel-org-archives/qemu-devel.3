Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAFEC8303C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9xA-00013D-6G; Wed, 02 Jul 2025 22:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uX9x3-0000y4-Gy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:45:30 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uX9ww-0006it-8I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510722; x=1783046722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pfp2qcJTmYTjz/0HZ43NuE6jGUJrFwb/D85mCsB2H4w=;
 b=J8G12JBQBFVmbKnVQJrGP1aDxrSEKs4QVCBwJszhzeHB8SPgX6t4/akW
 MtOEU0XIsLJbIskFuX5LUvnJZGgnY58dbzgIZUDLqj1ee/a0y1qz5ervR
 I0GMmwpNWuLGyJ434u8AQyMPbCO574pxDcYvjyvfa/STe5qOBsMq+GHgv
 0tsHXSKzDlGJbz4hHQhUZvXHPLddzCj0qCHStWxQjDLHn8VP7IICo04GM
 RvDZ082q9HXGNEnYiwU2QeCxkxZc4NnwEhWejZ+jAmYs4EnYrmMJZsDAL
 YJxn46ro48DEQGzfM74UjGivWRulXWulmLpq6VcJuyY6WECWftCTq+Ir6 g==;
X-CSE-ConnectionGUID: a3QmLpGkRReS5OIlsobeZw==
X-CSE-MsgGUID: vqQzBGpKRradfLTknNVhpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="56445967"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="56445967"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:45:16 -0700
X-CSE-ConnectionGUID: uKXtMneMTWq3Gq7vKWN3zw==
X-CSE-MsgGUID: +4TtQu+ZSkqK69DsH5fKqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="185177878"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:45:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 19:45:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 19:45:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 19:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmXMAstewH9R0s+yh/YoAmF2+NAl/ZrVj1yyQyuzhL4I3nIAv3SGhW+f++IfQczm/H4T83F2mG46280TeEnLxDF2ZPmcjZh5GJOfos6RaA5Ea33Zk7SP+RmcJ8YY1H4PkVZyrQw/UezEsWNuxZ3JlQabS5nXo175IzV4oN6mpr+uV8BdO/lqvgRIJ/DCfux49IMu+eIKrYvOaDVfQzQY6YG/35Amyy9IhypSM0KTaembVGiza7KUOdbTBN8h9IkyQPNcnM2otDaMwNYcMT7WZwaWH/L9VQ6eo7aqE8PHyzcJeONdz3HI5Rqx15duZ0mAH9h6d+UUqp/uCeGCiLgUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3+Gf0haNZwQe5qCLaW+2Ss7BLs5kIIZ7ciiq7FcPbI=;
 b=P8vZXVKn0GfERiyiX6w/MyE0ilt2L3u/HWSN0qUO4AO/JaRFmDp17ySH0ecp6w9AI0dPkPxz5FItS9oVAr2JJeHdXc53xcpUN0l83W2hPUtTsTiOLUeAwQSevjvKTiBhIrHjgz7VpifZbsXvP+YqZDA77sbRgv3deOKlLUktKjjB9PjwGYWGbMg08E14h2CodzxxWDZZmwmJnqiJvSsX5FwpmgqUSf3Aqdq3Xk4Xkke3h5H5qzGIWwFHTT7KV7vB4dmmrGZHKkVnrYvDrEK9mNTOyFIymMCmlOIQzJv1SS4Cl1L1JV1G29zaMDBVyjU9uwhdYkhpgde6CoY+ekoYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Thu, 3 Jul
 2025 02:44:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 3 Jul 2025
 02:44:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V6 13/21] migration: vfio cpr state hook
Thread-Topic: [PATCH V6 13/21] migration: vfio cpr state hook
Thread-Index: AQHb65yPIuo3FcQr+0WsQZQgA4h3nLQfsW5w
Date: Thu, 3 Jul 2025 02:44:44 +0000
Message-ID: <IA3PR11MB9136A7E8EFA7E1C98B2C96779243A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-14-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1751493538-202042-14-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5061:EE_
x-ms-office365-filtering-correlation-id: 65ff86a7-4205-4b31-e9d5-08ddb9db9123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hV5kD4MA6Wd3GPmtQ9oWEdKgrT1aTMshsEQqccMOZNNAQp57L3gx1ME/Rvb/?=
 =?us-ascii?Q?X1EIVqPlzTNpAzIHlXiONeAPlzvr12UXpncNxsSMyRCb5eknH9imKyDd8/j8?=
 =?us-ascii?Q?hrcV7NMmw+O6eo+HBXfsK6WcFAk2V3toYw4Z7y+DtxIaRo9+uAp8qiRZP1R1?=
 =?us-ascii?Q?Q+yXWu8m96FOUGx7kIlbgWEoZhf1wEA2hkKmqaxZiFMUs3SiDJEU9Te8f2/p?=
 =?us-ascii?Q?wVgBE5/LjQ2rrZsUeZ9YBjkeoxZjTK1r+GMQPudq3XNEPt1Pc+q/tGB2NpiW?=
 =?us-ascii?Q?zQzYJfPGRlnwOrafueJpHCeiJbqK7ALefrYCRcf27Hu4ttIisc42hJ5IeyhK?=
 =?us-ascii?Q?HcQxHfqeZtIISRmiOUY8Nf3oZ8Jrhp2/Y6DlvpXNifRO5ziDE+IiNInH0uSW?=
 =?us-ascii?Q?35XHtB+kjXD3qtrW2lDwYabAHryeW8wjB0kbwTR33GUpysGxDWEL3uMiPGDO?=
 =?us-ascii?Q?hjPEO2OoazkPpTTbormZ/VLKIkeiZqr6lTiFHrNhQKRoaT6B7kNie2NNFQBk?=
 =?us-ascii?Q?61fqJYPfVBVMpSFhwbD3kCoR1ODdMQr1TjGVdupWQcgwvjaizEvYZXp+wjaD?=
 =?us-ascii?Q?0mjwhfH9yF85Zh3LzqgPOHuZVU30oe5FUrnLZA9rhTo0+44CV4y5Iiughpye?=
 =?us-ascii?Q?wR8UXzBaUZDMyMyCpMAe/fleNVYX7MBbELjbLo4HVE9scXSPaI+kJtFtXKZe?=
 =?us-ascii?Q?42t/Iv41JvaAOZAB4K6LFxYXXQVerPKfRITyUS7wFPm9gVen39/x4FnfJlHV?=
 =?us-ascii?Q?2tRG/H+oKTrJtcCBT3Z7a5SjNeY+49TlbtCarwEnBbt1ZvHQVE04YXHVdUIJ?=
 =?us-ascii?Q?BvThWKrXVrmUUvSInY6Tcm6waKAS0AQWNJxsRxfzzAEHDJt/NcPw6qwRcuGD?=
 =?us-ascii?Q?wACA+1cMmYT6/hfhyQwD5ZFveCbRIJrsC/1usrEnd3mXk5HA38lBJh8rTohk?=
 =?us-ascii?Q?7g+LtFHq1x4CtDoIusiFqShMHZky+EEU5/LlZcUTNF/2vlXYn8MLbI19UOUz?=
 =?us-ascii?Q?fzTBIZOPrrUh0PWPf0VOFEXsKTRlEWIDSt77GH5ZcG67y1qo2Jl7q3HMZUgx?=
 =?us-ascii?Q?Dx5efnYaHzaO6Ut9k/vvHRMn8pmzd6HotXXrTYsj8Hbeno8UODZ8l03CXRm3?=
 =?us-ascii?Q?Eq9tVBR6odmop8VKBPxOsbJPn9do2jWEJ0n7WQBSW40RJFNWSZwVD7ihm2vE?=
 =?us-ascii?Q?YB152OGJjrfQi3T8DUHEQTWZxHV7OtyMTCX/jcVRz+9v2k+K/JFI0cCuzB9H?=
 =?us-ascii?Q?iccBj0xx25Xt2Ullp3DnWudf8vGt8MYbL/JWXkJkfyvqe9ve8O4+dKlJcjzL?=
 =?us-ascii?Q?yyh4Zly6bYJ67hDXwG5WCuqSB4XrH9/CssOazdMPfLz3cyh2N2/RmN0dY5V7?=
 =?us-ascii?Q?mIEA3dqsSBnhZleobjbYctU2QcrBuDmrKg+NK9zO7RgUfsN/N9cB5V4fBO4r?=
 =?us-ascii?Q?YATsTCeK+jS6Tir6Q80Xbc9p2qs3Y34yjUEmaIr6n+O9u6S+s4bj3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aziEsDZ192L8v2CZ5lbbuoH+Za1d8sgY++04YJDBiq9g0JcfiHKCafieaTFz?=
 =?us-ascii?Q?PkFFmmASTL0CO1Zz3BbN+GHWUDdgKE9RKc7gxF0fR+QFd+4hakkwKIydFRr6?=
 =?us-ascii?Q?u9de97Yt4dZm+02Tg5uyCYtGtgjIZOqosjMu/lC03juP+U55DbEgdQ5DtgV5?=
 =?us-ascii?Q?/rTZEhzR/7rr03ec/y878jP0IGz9CuQTXsJfYBhJCu8v3on24crRJfjnPuBu?=
 =?us-ascii?Q?Apn/+PqUEofrO6SqM7/xoCIbb9j0cRdbEcn1AfCpc1Yzn5RfJ3dfSCc2XV89?=
 =?us-ascii?Q?cb+f1sbcqzKhESV5qnBY/5rDRYb/acNdiwvsWpI+wvRUVzLKKOA4jvgLsK1Y?=
 =?us-ascii?Q?040fYCmi8aDv2rIJreMpszTNBFdlK5i5OBbMV4MscNj+d+7h8CLQT4pDs16j?=
 =?us-ascii?Q?0ApXYoILkK5zXDIxZlSPYHI/Jv/Vg+JpNjlRjdm6rh2u7wIQ0LZ2Y8aSvnsQ?=
 =?us-ascii?Q?e9Xr2e4FghsZ/vuNiM0ffd89WLupkt7VlDuDEKH5d8R+pdBQMHrJISyRsZiF?=
 =?us-ascii?Q?cu3f/MXCwQEXgoL2FSwCL5/yCrHJ2L7fx0e+RAOQNUkjX4tsKjzR/0kP+/z4?=
 =?us-ascii?Q?S7MjWPVwk45KKonbXLT2INnJ/7VCrjBty5UuwyDMAoQV1pwnvpD0VzIF8wy6?=
 =?us-ascii?Q?rgwzobjtaGm1EIJV5QCh1hVvwldmG4MY+jqpjx5tq83irF/joVOGrj3nH+uo?=
 =?us-ascii?Q?vB+uEjpr27LDGExuJG2EUbSy2dx0rYtGsxygYn0Fhpuarrl2yJg8cXX+oWRs?=
 =?us-ascii?Q?5Y71QtEGPc5gv22kXRhBFrb68Xuna+q25ctalIGp8sYzE1VMzLPF3SM3ztD0?=
 =?us-ascii?Q?lVhpTt6rFl6kqyKAefjX73KXtVQr2EdEz2dZgt95u2kFRepwuJrcwej+wJTl?=
 =?us-ascii?Q?P3wwSQgAZTIWmiLstMRqx1Z21sRcB9yIk5xXsAzYwivDT631ATewv1m0w4D6?=
 =?us-ascii?Q?14u6SBS/GaekAsxcJ1CKQjRuXofGtoN8nZcqABStuDFZ/MUa40Q+/ODCX3tP?=
 =?us-ascii?Q?OCLA8SekGvNcu0JWcihTVCZ7cDEDi/GoLozjMYirCezpG/Kne5L4bsbXJcEL?=
 =?us-ascii?Q?aBF4dSKF11gseujUaDu7xmCkMzrFexmDpsCiLsMG4PC8n0xzvS0d0fSiETNc?=
 =?us-ascii?Q?X8jG7RW9GshIavKwGiSvJ6CyCA/MpBPDSHwqIGzy55Bd7H7HshMYdMTekNHG?=
 =?us-ascii?Q?PzFwyTaTnAqdmYGZQIRJyyDEARmauKT/I3bN91nx9zw+UZgCQ5deE4JfBCPJ?=
 =?us-ascii?Q?z9mbUrtO8HUAC8vGOSJubokU6omi8dlJ6TkDabzTA8V+NusxDb+COiYrCIJj?=
 =?us-ascii?Q?0r76OCTcRzOSQBmifYswFtMKSsC9IQm80SqY9YVfQvB64gIszVvdY8QmsNpl?=
 =?us-ascii?Q?E3fYgKdUl3cxk1zF2bXESkAuev0WOvcj2c1k/BjQg0FCS6QZ/i9JGbduzRx/?=
 =?us-ascii?Q?YnkqbaCA/R/duMDFCAnFRr3XXT5l2bEmedthJTOBqHgI52G6LqszO0UoZtb5?=
 =?us-ascii?Q?BppFpyfOf/ZPSlz7IyAuaf0MAt09ygYB0R8MmPsAG5bEqiXsSSIFrcnoi9ku?=
 =?us-ascii?Q?RuTbbadMQj5KeyG1KkWj4CkOwdErADWvtRwBQkv+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ff86a7-4205-4b31-e9d5-08ddb9db9123
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 02:44:44.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHz+ipuHdVCCj7EWmGWjdModQV7VbXOLwdz2IXhislNqYv72hvhfn0Pzq3hOIHIkPUb55gpMntWGz4Ll+hWobEPlAPhbMrPFFWntYThLwBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>Subject: [PATCH V6 13/21] migration: vfio cpr state hook
>
>Define a list of vfio devices in CPR state, in a subsection so that
>older QEMU can be live updated to this version.  However, new QEMU
>will not be live updateable to old QEMU.  This is acceptable because
>CPR is not yet commonly used, and updates to older versions are unusual.
>
>The contents of each device object will be defined by the vfio subsystem
>in a subsequent patch.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

