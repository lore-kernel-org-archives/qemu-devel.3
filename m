Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2988FF43841
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGGm-0007BI-A1; Thu, 16 Apr 2026 02:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1wDGGT-00079F-Kr
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:31:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1wDGGO-0005Ta-Fm
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776321106; x=1807857106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vap7VZXFmWsPG0vqnJYb1WlcNZrT21gjsDsBifI/jXk=;
 b=DXMUxfs6KH50k6UMMnCBhTRUJ7Vw6Kxo3aqbuFUJ6Hr8ckz5yTFF9YeK
 Mk+5iD0/yEiYY0345ZxASflbJDE6oOCA8ZUQBpWaxRbU8UbEc8Dzvs8Ph
 WdIcjDn8cV3auXm3I3N3baQZp5HCVtxkJVpnim/kSLh//ZK+ikkOK0Go6
 OopFJfIDz5yxt/tvLf7dHZPvgMu/rs1Pv+QOcOwNt66sZ+Dhfl4VT7YOe
 RLiygnBYcxCzgLb4gnYCghZWZ3VWajmPwAv8fGG+del+KhHDO87+oA4NO
 TaMJ0bWuBkUKCr8xUm0itLt8ERveT5m9uEeI+jMW9f+M5GPqj4ngoTIRo A==;
X-CSE-ConnectionGUID: oYIUSGdAQ0KfYlhxi8yGSw==
X-CSE-MsgGUID: YqB/mJx5RDW/KMu9VVsG6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79894415"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="79894415"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 23:31:36 -0700
X-CSE-ConnectionGUID: 4CWNeOwFRyadhLNOQ2qs+g==
X-CSE-MsgGUID: zYgHmRw1R8qY0FKvnj9ohw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="227489662"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 23:31:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 23:31:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 23:31:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 23:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRNJvuLijRfkpI/ovQmz5D8IfEO4oWtCZ3VhRwzQ+8avse+1HUWsf+op/I0UJPUB/WDjQo2Rh0fd4FgxPHm2rvk63oGLHcNzwNoxKRxcqkmYnUoIt72pt52b0yn6s6/E9aU7ZiOd2CkWR5hqh6C6sG8izdRuLnNsWvRVtaqOMegp63nb4xSlo76NjoaOmRCbbOHOwYAYJMwlOspx6FGhLRvXpY5Ao6DGCFc3uVQQ1MDug93QWLd+M7oHY+eCBl2IriQkdXLbcameiq5xo0iVlaXB6Jp2reO5irUCGuEe4DMwYcHrtZt+/4PVC9iIh7fdxZkwvYV30z0fLVAI98kwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/o7CHhJ36fMpfewsuGp2YwVfMcdbC/P/gjvZitoC9U=;
 b=kiKPgVyVAxoZSHpnTBR5E0W/oR4blYW0vEw9nqHMkh108zFrwXTJkhTZSG5+S3Odjc/tnmrzaWziBCWSMGWViuXlPUxwiziO7a+d4ckTQYEkHthlS02OIVstuvvZZwjJt46q4AELh4BBpjGWpCnQh4OCmjBwhkcUDDDUK+lBIQcVPq5+Vn7c33FZVDpZEeK+rOneOuxxHnurSSoXF0z//dPQ8VHgpd8grZFqkVN8opPtRH0U64Y41oD0WSQtx/wQKJUd4K+UkZhm9m3dLtXk3gOhCr7znXx92oR5KmDJ0SLbv4Q7DTpSJjgRr5IEK0RiOq3Q2voVehjamCyjj/Yjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 06:31:25 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 06:31:25 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHct2CBd1EkLKy70EmTrlWjg/HgLrW8bKeAgAANlYCAAO/SgIAAuJ2ggADRFQCAIdYwQA==
Date: Thu, 16 Apr 2026 06:31:25 +0000
Message-ID: <IA0PR11MB7185F5B516E3FAC39290B6A0F8232@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-10-vivek.kasireddy@intel.com>
 <a112aab0-df42-47b6-a5de-f6827321c8d5@redhat.com>
 <IA0PR11MB718579B3F8EFCB2C2E2D1E93F848A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3434becb-639b-435d-a36a-71b5a3760ba2@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71851F5FD322F30FAD53D1F4F849A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA0PR11MB7934:EE_
x-ms-office365-filtering-correlation-id: 8d577b87-a0e2-4549-3973-08de9b81c8aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: izihUwl7tOiQLvah0zAfv3X9CdKvuM3rWxf7rgtslsmyU+pVKiO9iB3M60io7/HK2Ot1WpX+kozJuXlZvyEeUO76PNTU+feBcg+HvppYVvdrcnE02PHWaCvHAKTCYZB6VJY47IahETyPSweUCDv/P6IK3UI3YnEv9+MPkOyBYlu15bqjtE3m1YPwvYvAu83tbtwrrIhvtIH4lodesEzjUIX0xA3OTDGiXzk18zfCLQZ0XfEVMnO0kJzSBr453JP1Ayv5vfGEWhfarI6/wMemUy4/Isb3YEoBAAOnMq6l+LtYVqFJjkvaowSKzNpb5RH3uZNOpgSmIBuAMiJpinl0TPE7lZ3+l94S+gKCuQbA4CC/kdWM+Xcstn9068x0vKt2BefybpchZNeQDIH53ltzuXA/EpNXUu2iVohJhRU7fNVpUst9gBU+s8KuXiq9fW+RNYbfRTgTN0nHtxMrkcK7t9pmBbQXdOnKaB0r9ene5iI66uVWaLmi3/1ky2AfjWXyoiMRFULkCXGY16eSOegtdNiGRQV3exqVKQMebOy3Kqopy65CLEDk4T5zFAsAMP4QwOU/dathnkevsvIPXosiDSZuawe7XQhY90Va0rfQRdOQnfNFQ0vA4/eLIkvFZNa4aPvBCl2Bmhpszv7O9WJP/nxFPtSkiMF8cr6nKyUT6knaVlABLECH3VjHqA1Z3KABk1ui9+ue+7VVRoS4YpgX6NG1OGpmsUhinAYKwsNatXLQGeuOuQzeIC55qYoVZ0/XfIRwxO1rBErxyv0HuW2QKjt1LqA0bcLM37lGTfAjqvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IMaAk3x+q/MAHfzmPt+5KnaJFCHiKdDVWLUlZOrroguIqSxdfakxhp2CAv?=
 =?iso-8859-1?Q?4zwFd/d3yzjVN64z2JbaX9MDSrsOahtuVK/L980xuqjODVWVmAXg5/I//2?=
 =?iso-8859-1?Q?wCSw3BV1o+vl1JTzivN7Oym2zMHcnf7TBzpOCYUHRQXjgrB9Q3zJcET5+g?=
 =?iso-8859-1?Q?plGJKI2Cam3IgnTgozEAIbYtUM9zUaIc1Yk4x3gpcFL23TVudyB2DzVDfY?=
 =?iso-8859-1?Q?Bd/DBVRkEJriHpY6CuhjQUXm0Uv+NPAbhMIY9+aNNbmGgOG/65p/M+xXMv?=
 =?iso-8859-1?Q?TgkvSzcQvjBS8VAnYt/HkE7nnmVdhuS9JXI8nOhOrrRqSbyzR9IUgYNmEZ?=
 =?iso-8859-1?Q?CIA1v5dLyHyI15Y3Bpbhx39kL+QDNzwF3sir3GvGqu7/Hh51KYrpjmAz9S?=
 =?iso-8859-1?Q?CS1saRHo9S17z2QZ+Lz4fc6IgQqLE6Pw3CTwRYez7rYOh/63rpNZA0WyHH?=
 =?iso-8859-1?Q?aBwedl1U/Wvwne/7Q+PDv0uPH+qVCz7SSjRUsRrGRQRY4waZflWKquQpYo?=
 =?iso-8859-1?Q?l82Ugbrd3BaRx+xtuvSL0QRS2W2f2GB+LWq8xlNSTr87gHimwN7LNMPkdi?=
 =?iso-8859-1?Q?LG1q5H4txQK6XdRIzQYHiDhP3VL8AHM2w2UrTSQa9y6HjsQAfBicwMOtXX?=
 =?iso-8859-1?Q?nWAcdiOyBCf8obr0lQgGBSoyaRtvOXNOwLBOX9yrbFJOY5wTKVxesxaSdH?=
 =?iso-8859-1?Q?D7d4J4UQr+RPuqO0TSqTwe6QQZ6nnl9KLHEGL126nlvFW9Vldo+NfN/ayf?=
 =?iso-8859-1?Q?5wxzzmf7mAnlvUL+ZAgXS/TWxhjtAIxQQLLk2SN3ZxwxY5SW7IJL1sSIKe?=
 =?iso-8859-1?Q?LyjYWdAxEX0Y0GbhV6NHIRn6JPpjBfA48arHGoA8T09tBnMoANf72mqmWY?=
 =?iso-8859-1?Q?89NHOAoakVqk4LLtM64C0rGEi1SSTvLl6JUNRFjAsFwmnWUKMXzl7cfT4P?=
 =?iso-8859-1?Q?FxE0QB5kAuW6FbHbSQ29DXqvqp4WMB4TddBUZnAZGzBdp9xg4g9UjImJC/?=
 =?iso-8859-1?Q?aOW1pThz85KHgf4zUvATPgDD6zmzI2D33TYFnVhWhHv0Bme53u7mbzuNQP?=
 =?iso-8859-1?Q?XRMRdGPGmqzvjl9nxVjPs9VITmdxxy9Wv7t8M//NQFwEKB4F/XqNjrl+if?=
 =?iso-8859-1?Q?6dLtKZdLN/h59KCYsz3qE68lpu3+pO+DdFE17vVWtqxs6KNCu0YdrBbsJ9?=
 =?iso-8859-1?Q?Nerj2CgLqcQoP940SDS272nFiKV3nxirNvDQf/upOsXYs6e77ssi2TbTqK?=
 =?iso-8859-1?Q?/LAZPgc8vxdb3NqJ100JA+CZmTzytJROpHy7LYmG4oI3zVlsRnyzvlNmbO?=
 =?iso-8859-1?Q?MXr4XB+58NZArQHi52zoG3gTnrEA0G892aYjmTkWDwamw36Lk49B74Xup7?=
 =?iso-8859-1?Q?ZpKXPkF6VD4Z+kvNULyKxAr7GbNNtsxv4uIFhuN8OKv5wB8Rv5NZD0VNX0?=
 =?iso-8859-1?Q?9XK4+y+cYlQY+l3zQUsRcEQqGw0wUu5crXFxzD9KZ/xdDM6mLDZ1iAk9vX?=
 =?iso-8859-1?Q?yyWUoNwPzmurXWhM6hFJUjhkyaQllEM7ovDdHqblDti99saMcdl5wdABpo?=
 =?iso-8859-1?Q?nFpldNVGcUue1pTYhj7a7VDmXJcaZvELbEyYbE9Q8HDqeNGU2VYYrP59hP?=
 =?iso-8859-1?Q?XGv/85LNSdhYZ41GogbeXq9Fu+jhgCEdSPDSXWpMr2nN2QkdEcSMR7nSLf?=
 =?iso-8859-1?Q?CdBYgQFnMrEYxhAktqA+BMQfjVsGwdSRTokeVDRG03poosFl61HSFevlnU?=
 =?iso-8859-1?Q?3WVsY+ZbEboCaTe//IWYn+obKCMvod7kdqgWqjT8HKhaMwW+WbKvT8UhHr?=
 =?iso-8859-1?Q?LNmvDbcIBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v0uIKL3DzjfMMMXmsa939psiZ3IEFu2LWMeoY+vAjzpFAG8vLT01lmoX3EF//PTaLNPmVsNkHysRLBol6IaY7s3KBF6XA1aCHdnV4WlTyjafyLGnNN8KbwzUixsdZANUzZvA77QPi14Ss2BQFSyQWuCBFcbVKm/y6kvOygixULUOjT8Ud5N1RlzJbqYvmXDruUdTDWWnrIjOSzTmuOyN1w1+ibJu9ubv/za51Jj43mpm7UBFKEdam1NefhpbN+LnCS3WKpVKUabq+BClQtaB6OgMU2bajCuVQLRonXxomsT4MghtJRSLcqJJIZwZNWa6IrCZkY9l8NriBM0sU0PFFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d577b87-a0e2-4549-3973-08de9b81c8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 06:31:25.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFINgzHZolrcN+kTexnFpLHeUUN9qCAvdEuGHLrBXT3PseuzKiUw0wjdrFGTLg36/85QxcrKMCTHGipQ3QUxMSpD/5TvfDFbjRuL6bJtW8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Hi Cedric,

> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
>=20
> On 2026/03/25 14:31, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v12 09/10] virtio-gpu-dmabuf: Improve error
> >> handling with 'Error **' and err enum
> >>>>
> >>>> On 3/19/26 06:15, Vivek Kasireddy wrote:
> >>>>> Make the error handling more robust in
> virtio_gpu_init_udmabuf()
> >>>>> by introducing 'Error **' parameter to capture errors and using
> >>>>> an enum from VFIO to categorize different errors. This allows for
> >>>>> better error reporting and handling of errors from
> >>>>> virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/virtio-gpu-dmabuf.c | 67
> +++++++++++++++++++++++--
> >> -----
> >>>> ----
> >>>>>     1 file changed, 45 insertions(+), 22 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>> dmabuf.c
> >>>>> index e35f7714a9..89aa487654 100644
> >>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>> @@ -18,6 +18,7 @@
> >>>>>     #include "ui/console.h"
> >>>>>     #include "hw/virtio/virtio-gpu.h"
> >>>>>     #include "hw/virtio/virtio-gpu-pixman.h"
> >>>>> +#include "hw/vfio/vfio-device.h"
> >>>>>     #include "trace.h"
> >>>>>     #include "system/ramblock.h"
> >>>>>     #include "system/hostmem.h"
> >>>>> @@ -27,16 +28,18 @@
> >>>>>     #include "standard-headers/linux/udmabuf.h"
> >>>>>     #include "standard-headers/drm/drm_fourcc.h"
> >>>>>
> >>>>> -static void virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> +static int virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>> +                                     Error **errp)
> >>>>>     {
> >>>>>         g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>>>         RAMBlock *rb;
> >>>>>         ram_addr_t offset;
> >>>>> -    int udmabuf, i;
> >>>>> +    int udmabuf, i, fd;
> >>>>>
> >>>>>         udmabuf =3D udmabuf_fd();
> >>>>>         if (udmabuf < 0) {
> >>>>> -        return;
> >>>>> +        error_setg(errp, "udmabuf device not available or
> enabled");
> >>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>>
> >>>> The function virtio_gpu_create_udmabuf() is returning
> >> VFIO_DMABUF_*
> >>>> enum
> >>>> values, which is problematic because the function creates a
> >> udmabuf,
> >>>> not
> >>>> a VFIO dmabuf.
> >>>>
> >>>> This creates a layering violation. The virtio-gpu-dmabuf code
> (which
> >>>> handles both udmabuf and VFIO dmabuf creation) is using error
> >> codes
> >>>> defined in the VFIO-specific header.
> >>
> >> The rationale of using error codes is as follows:
> >>
> >>   > In that case, using it for udmabuf is cheating, but I think it's f=
ine
> >>   > since it's locally-contained in virtio-gpu-dmabuf.c, its intent is
> >>   > still clear, and it has no adverse effect for users (at least ther=
e
> >>   > will be no bug).
> >>
> >> https://lore.kernel.org/qemu-devel/becde56b-90bd-40ca-9329-
> >> 0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp/
> >>
> >>>>
> >>>> Please find another solution.
> >>> Other solutions I can think of are either move these error enums
> into
> >> virtio-gpu
> >>> (and disregard the error return type from vfio) or move them to
> some
> >> other header
> >>> where they are visible to both virtio-gpu and vfio. I'd like hear
> >> Akihiko's thoughts/
> >>> comments on how to proceed given that he had reviewed virtio-gpu
> >> patches in
> >>> this series.
> >>
> >> Disregarding the error conditions of VFIO is not OK. That can cause a
> >> guest error to be reported as a host error.
> >>
> >> I think the simplest alternative is just to have a duplicate enum for
> >> virtio-gpu.
> > That would address the layering violation but Cedric's other concern is
> > that he believes having errp is sufficient and using these error enums
> in
> > VFIO would be overkill.
>=20
> It would be beneficial to describe the rationale behind the enums; the
> patch message only says "better error reporting", which is quite
> insufficient.
>=20
> The rationale is that we need a special handling for the INVALID_IOV
> case. The INVALID_IOV case can happen in two cases:
> - The memory is backed by VFIO. It will result in the INVALID_IOV error
>    for the first attempt to use udmabuf, but this error can be properly
>    recovered by letting the VFIO code to create a DMA-BUF instead.
> - The memory is not backed by memfd nor VFIO. In this case, the error
>    is a guest's fault, so we should:
>    - Use qemu_log_mask(LOG_GUEST_ERROR, ...) instead of
>      error_report_err().
>    - Emit a message useful to diagnose the guest error, which we have
>      discussed in this thread.
>=20
> A common pattern is to return -errno to let the caller implement a
> special error handling, but in this case we specifically need to
> distinguish the INVALID_IOV case from the others and these enums are
> more convenient for this.
With the addition of the above rationale provided by Akihiko as to why thes=
e
enums are needed in VFIO, would this solution (having duplicate enums in
virtio-gpu that mimic VFIO's enums behavior to address layering violation)
be acceptable to you?

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >>
> >>>
> >>>>
> >>>>
> >>>>
> >>>>>         }
> >>>>>
> >>>>>         list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >>>>> @@ -45,7 +48,8 @@ static void
> virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>         for (i =3D 0; i < res->iov_cnt; i++) {
> >>>>>             rb =3D qemu_ram_block_from_host(res->iov[i].iov_base,
> false,
> >>>> &offset);
> >>>>>             if (!rb || rb->fd < 0) {
> >>>>> -            return;
> >>>>> +            error_setg(errp, "IOV memory address incompatible with
> >>>> udmabuf ");
> >>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>>>>             }
> >>>>>
> >>>>>             list->list[i].memfd  =3D rb->fd;
> >>>>> @@ -56,22 +60,28 @@ static void
> >> virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>         list->count =3D res->iov_cnt;
> >>>>>         list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >>>>>
> >>>>> -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST,
> list);
> >>>>> -    if (res->dmabuf_fd < 0) {
> >>>>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>>>> -                    strerror(errno));
> >>>>> +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>>>> +    if (fd < 0) {
> >>>>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST:
> ioctl
> >>>> failed");
> >>>>> +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> >>>>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>>>> +        }
> >>>>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>>>>         }
> >>>>> +    return fd;
> >>>>>     }
> >>>>>
> >>>>> -static void virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> +static void *virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>> +                                     Error **errp)
> >>>>>     {
> >>>>> -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>>>> -                         MAP_SHARED, res->dmabuf_fd, 0);
> >>>>> -    if (res->remapped =3D=3D MAP_FAILED) {
> >>>>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>>>> -                    strerror(errno));
> >>>>> -        res->remapped =3D NULL;
> >>>>> +    void *map;
> >>>>> +
> >>>>> +    map =3D mmap(NULL, res->blob_size, PROT_READ,
> MAP_SHARED,
> >>>> res->dmabuf_fd, 0);
> >>>>> +    if (map =3D=3D MAP_FAILED) {
> >>>>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>>> +        return NULL;
> >>>>>         }
> >>>>> +    return map;
> >>>>>     }
> >>>>>
> >>>>>     static void virtio_gpu_destroy_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>> @@ -125,22 +135,35 @@ bool virtio_gpu_have_udmabuf(void)
> >>>>>
> >>>>>     void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> >> *res)
> >>>>>     {
> >>>>> +    Error *local_err =3D NULL;
> >>>>>         void *pdata =3D NULL;
> >>>>>
> >>>>> -    res->dmabuf_fd =3D -1;
> >>>>>         if (res->iov_cnt =3D=3D 1 &&
> >>>>>             res->iov[0].iov_len < 4096) {
> >>>>> +        res->dmabuf_fd =3D -1;
> >>>>>             pdata =3D res->iov[0].iov_base;
> >>>>>         } else {
> >>>>> -        virtio_gpu_create_udmabuf(res);
> >>>>> +        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res,
> >> &local_err);
> >>>>> +        if (res->dmabuf_fd =3D=3D
> >>>> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >>>>> +            error_free_or_abort(&local_err);
> >>>>
> >>>> Why not report the error in the QEMU log below ?
> >>> I think the idea is that in the case of INVALID_IOV error, it is
> sufficient
> >>> to just report that the Guest passed in incompatible memory
> >> addresses.
> >>> But I guess we could also just do:
> >>> qemu_log_mask(LOG_GUEST_ERROR, "%s\n",
> >> error_get_pretty(local_err));
> >>
> >> The error message may not be useful. e.g., "UDMABUF_CREATE_LIST:
> >> ioctl
> >> failed" does not tell what error the guest made and how to fix it.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks,
> >>> Vivek
> >>>>
> >>>>> +
> >>>>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                          "Cannot create dmabuf: incompatible
> memory\n");
> >>>>> +            return;
> >>>>> +        } else if (res->dmabuf_fd >=3D 0) {
> >>>>> +            pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >>>>> +            if (!pdata) {
> >>>>> +                virtio_gpu_destroy_dmabuf(res);
> >>>>> +            }
> >>>>> +        } else {
> >>>>> +            res->dmabuf_fd =3D -1;
> >>>>> +        }
> >>>>> +
> >>>>>             if (res->dmabuf_fd < 0) {
> >>>>> +            error_report_err(local_err);
> >>>>>                 return;
> >>>>>             }
> >>>>> -        virtio_gpu_remap_dmabuf(res);
> >>>>> -        if (!res->remapped) {
> >>>>> -            return;
> >>>>> -        }
> >>>>> -        pdata =3D res->remapped;
> >>>>> +        res->remapped =3D pdata;
> >>>>>         }
> >>>>>
> >>>>>         res->blob =3D pdata;
> >>>
> >


