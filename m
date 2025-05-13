Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7182DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 20:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEw3m-0002lQ-2t; Tue, 13 May 2025 16:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEvpB-0001dw-GN
 for qemu-devel@nongnu.org; Tue, 13 May 2025 16:02:02 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uEvp8-0002Cj-Tg
 for qemu-devel@nongnu.org; Tue, 13 May 2025 16:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747166519; x=1778702519;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=PyDUHEeuMwPHPbJgXfP4KwUPM6BZmT3wurxUY6JufpE=;
 b=dKvAshd9kdZ9+5IBC1ML+mp/tJd19JNWcM5BiU7Y0dKJGja5wPxsQlNh
 eGJGZJBl9nWClFmSP4fbRRy5R2P8q7lYNu4yvqCO13SmndlCHTqh7rljA
 2Ct4MKHN37HFkTKDiOmpt85KecPmFX6vQUuIB888y56KFmNbADikrf0bY
 mqhvBn/i4f3TlnBXkzc59flHGXoF1451AZaFjVB7kI2ZTxImqU6D2OFgi
 9Ng9K0bv8zZReyjHQGXUy1erS4evb3e4uEgOCCKR6knVlJFlzFiHDrY1G
 goMCikd6EzdG3uuAmlbECnEnXFGqEiVWpi7g36VPowYWkShnlqgbOTi0S g==;
X-CSE-ConnectionGUID: 74tyDmCrQEyJaSDlnG5CeQ==
X-CSE-MsgGUID: RZHLrl1IQMqVQ4W8EUCaVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36661454"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; d="scan'208";a="36661454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 13:01:54 -0700
X-CSE-ConnectionGUID: CX4iYpw0RmiT08F1omreJQ==
X-CSE-MsgGUID: tCsY/bvFS+Woqih51TxPIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; d="scan'208";a="138326057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 13:01:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 13:01:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 13:01:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 13:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIsaFCUsrNUO7vhe89edpOhnq1RR4UiEeV62pgIbkJpeVDVwsCtNy923wvF/xlLns/2dl9OTN1Ezem7YChkOjaTMXftferHn2q+UBaKSihufVDj7UtP9zGpRK2H3UOYLk3KWwzd313STqkBl25j+5LvZLA4ybIox1mt0YgfFFoQU67mJhHDa6/WB/R+ogdkzcfUKvckXRrpHURk+sU3dvQ2t+dMVV10Eku7hVerZe+nBny9aqpjMDBYyL0ewSkpEfLw5BPgfwbc0EDswVIj0VkhIIgD6DEDhxbQs0G7bfDzorKybnt28sbJQ9y7kir05X2BVtduIHrp/oF1DxS4TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgVajLFVIgHifExy609ng3D5x2nnqIwPxC5sWvWuz0Y=;
 b=MDZjqXMe1UIAkwnkeqdYfHaYm537QRlgtTdy+IUyyJ2aCDWTJswcaUY8ru228jkbghJnpU4HH03mO2+PvyZSVyCpbU/HXHJVfNhQm+uV/x26uJRLQUr/OgT5dvd49dDjfKyYi0cMJH657jjYWUTiKBdReQgldsRrpmD/Ne8Nn5t+Fw4PenossX89kDpdxiwuMK0EQf+diVfpWpizvVbM1zIkk0Tp8vgYX5N5ZqFbj94nzo+z8ipYXQ/7F/frgbV9Jqap4VSxm+IsA0WZaV6UwkJ/caku6wpBApVQiLcn2xjPSsfvtPpf7nkfCZ1YwiKVKTYIqa1zMn2FYBFSEsqrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 20:01:47 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 20:01:47 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, Weifeng Liu
 <weifeng.liu.z@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
Thread-Topic: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
Thread-Index: AQHbwkdbw2+kS8MKYEeJuKmHcqqnyLPPuxPwgAFBPGA=
Date: Tue, 13 May 2025 20:01:47 +0000
Message-ID: <PH8PR11MB6879321E34D2905C47F42371FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-4-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879A5858D3F4EA9F4EDB149FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DM4PR11MB7304:EE_
x-ms-office365-filtering-correlation-id: f87612ee-550b-4a38-1011-08dd9258fe15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MjLm0x8YI5+kpNZSAIie95bI33Azx3uhPg8R9IEHVLPqQG8ajxoBJHfV2mhd?=
 =?us-ascii?Q?upilYJnUrdPVB0j+myI7g2dppXx4Imp2/1+51AZmS7oxw3+VPuaGjkH7Ew7+?=
 =?us-ascii?Q?rFxFGVMd6VC3sIiIMUv+pm267JmlczsVRp8SXCMIF269wxIUMi40iuu/XlTZ?=
 =?us-ascii?Q?hTBru4iDlXLj7UlH+4s73jumtVpYOgypYy8ZazyNVPHPv1/heoXxMHaT1Lrm?=
 =?us-ascii?Q?W8iC2H8cm8q2PxoTTeLhW7e5oUrKIezkCAsgi3UkzOB/dJR2l3X/oLgZqO4l?=
 =?us-ascii?Q?+qscj9XyvfQwuJT8CXaOQaOEceW3s+5pNhytpfAGUqvbl7422QHEXTrvrjF6?=
 =?us-ascii?Q?btc/GOzS//BSADRg40Qg/RsVF4JbGvQK87N9tmOoNd1Lk37aQjz0FMl8pgyE?=
 =?us-ascii?Q?SjujWCy2A7QLTcYJ+V98Y6+HFQhsRwFTtCdBA9nL/8FwS7QXJvWu8dXde6dv?=
 =?us-ascii?Q?7Pti9lsUBQm0JrjD21G7u42rB8p/imZHDJ1+NsiOT1o55d5FcBCnaYcp8t5e?=
 =?us-ascii?Q?q/Yhp28cRh09dxLc7PAWLLHBK2u54at/hmR55SYgQAbATfAyOLsa/1ACRXlL?=
 =?us-ascii?Q?UCcl2E2es6iCkyAOEr2cSs5LTqeXvQb5n3ABf54jv5lumcsX6UIvY2qPmdMw?=
 =?us-ascii?Q?3oS7m1y/k5OTqOkwDPgttZs9GhozDzKepjRADtE/pTm8cSe/9QVhU+hz5RsE?=
 =?us-ascii?Q?U78UbSGaA+hpJ3cYVVBYQtg4wIEy2seGRXTOD4+0PwiAlFV34fzjpXKOYZKf?=
 =?us-ascii?Q?9UGUwMkfsxEHYh5BQ/6BnNBoGMQCdhavqt0ctGJd0ifK7kZYujjTvoYWAgVZ?=
 =?us-ascii?Q?a+SSPsG4k1CqDBroojVCqn55vH+THMiRDhFSZAdX+hEWpiZifZGnumlLrACz?=
 =?us-ascii?Q?RcgWGEy7JAnZ8Rm72OsbQKcqbo7g3xKt8D7+mjx2uVGelxtYNSXL7ALygOAe?=
 =?us-ascii?Q?fBpfBtIW0gWkwt3oVN1h+MzM6ygZHgleAPU+a1RGqBSNx1LRpCnM5j7S0/rj?=
 =?us-ascii?Q?GONbnP5TJvZk8nA7D5wKiSYB0RB/WjKQGEDnq1BvCEsn/Ne5GuEDhCR0UElI?=
 =?us-ascii?Q?2cQ2TO9GTzATa3PvRoqcAv2eypRG0vj1yhhGls1UhiPeB79NY5lEy98V4lwX?=
 =?us-ascii?Q?Rw1e2BqKofgPRDF6t/44Y3Pebz9yp0DUyWzVi658gsbbB6XLnCc+ZeueQ1Mr?=
 =?us-ascii?Q?TxTUovVDNCDSmiRKnG+Cazl4mujpg3T3zVlumSpc36Wq/wBmHvXsnAycjkiE?=
 =?us-ascii?Q?a7qq4wBz58oRWjQYGJjb/HBcckFJPg3L5QP7U0q0nboKsqzGkQtXZ7M1J/jp?=
 =?us-ascii?Q?0bXrBWsRN/n7DsCTJw9vTfljjx2u2gIydGIkvzoqVfv+87P/1JDPzZcpoSRc?=
 =?us-ascii?Q?4Ovsuz1gEI5nj22CXDKxrDHvStdSW/dMx/H99Dyrxgs2vsTgcw9lKvR7fLSR?=
 =?us-ascii?Q?z9xe2h5sFPWb54I03PdpAAGoTGNU+nQvN2eoxEoqWFtmQzqUCyh7qCqzwhZH?=
 =?us-ascii?Q?sPsvzISTBpb9haY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iYfaddqkpHRpmSka9KV0b0W34EZ3qcus1RbAiJiaSzHA1o0sYenQFzRe9tHg?=
 =?us-ascii?Q?/kgZBCcZVQtHIvAGM0MWdO2pyJkiyf4kHhTMJH8zes8e/Y2kuHbaDfm1qkpc?=
 =?us-ascii?Q?rBU+O+TXJGxSzuIyrdMYph6uQdWrwY/2Ghdd4agXAKBkRJ5CLwjiyaKfuQw1?=
 =?us-ascii?Q?rS0GqSPZ1dom4sZbTZIMRKRBfcIZkArvr70zLs1yyd6hAGenkrn9BQMaMOec?=
 =?us-ascii?Q?9Pi1dq4Ee7290qkpVH93cZl3sIcmMhGLzsP4RRB5njU0bboCssmzbGRwWHuV?=
 =?us-ascii?Q?9Tqr7Bw7HN9+FVvguTLRjGvASIIgN5aUZk1ruFu0fsbtbQTp/YI+rWGSfuWz?=
 =?us-ascii?Q?HTDdPDx8bjxiruX/XAX12js1QtyB5jtdcWKP4tN2KaSDQEFfvey1Tul5i3uu?=
 =?us-ascii?Q?pzhUVoMrepvsMYE97HttiUieSce+NnvnKxT21kHyR6ntGIvxVApozVYcMOzF?=
 =?us-ascii?Q?PkpdSzjBQhKABF74OaNDg6dVj9e4Bs/3YBpGm0XlkOhNAasDLEpDkEYzw6Bq?=
 =?us-ascii?Q?6ByTgRdY/HABvDNfbS4OK1Lj4BC8l/xp5VRnLv9ovnGpdLVThJkR/OqR5d2k?=
 =?us-ascii?Q?BlvCMjqmXVd7oQS9WO9mtiaPpQHvXE/G/ikRWuKxMrfCnLYWrU1683IUiyGE?=
 =?us-ascii?Q?6SIi4EdOUoOHJiCpakVbgHv0W5dUAn47IOuTzrnuWwF/c5M6oTofKcuw9Yo8?=
 =?us-ascii?Q?mbrLz0ZyRzjXenNNNhZJRTpAUi/H9O74SXUizOc+6EiJ+jDoqxwmdMe+J5n0?=
 =?us-ascii?Q?khCjt+Kqi0v0UFf2DqZklKWqun3TONbA4kAyNYqSeUQKIyftX6IJu4mtMloi?=
 =?us-ascii?Q?TNXIYdMJF/w4Q7W0jo/uDyHNP5sGipQby2xT10Kbg7dfxxUfrZ8tnakwZ6yr?=
 =?us-ascii?Q?kOg51yJdErHprVFCBmD2flJrvYbFLUxgz78INmRXlkjdPIiGBfOdVxpZRcWl?=
 =?us-ascii?Q?B4Xqvh8LdIWsr0MTkTsdruMkXap4Vt5BhYaD/ILdLw7VhxpGREghsE0ZJx27?=
 =?us-ascii?Q?bgFpkQWnUeoZpFtPreJFeMzu4xqbwOCNSDo4168yTJICFeZ0aI8WHqRjUdth?=
 =?us-ascii?Q?Aib6nNcXJktigiAU6LPW0vNPhz0EuRNvn/2trTfmI88sBNv8zkqelTAXaEDf?=
 =?us-ascii?Q?XXKhdxdUX48IBO/hURcjB+PN8kJ96ZXDz5+FbKNwysqOFqGPz6zqi+U2qasn?=
 =?us-ascii?Q?aI+l/4iBjFE1vNvYjjztI9XGdR6zfhtHrb9eUBjhJlLmsRMXg1jpmrOtwcZn?=
 =?us-ascii?Q?MNfzanyUc356KBHFQJv5Zv/MHHE5SFP2FxacKVaDIHdOzXvk9kPLV6ylrt6F?=
 =?us-ascii?Q?KmBYTtuwEmqOAj9KPfc6LiqkSqsXwB7wnM1QaYxRRZvSjOXVlXU3rp5l/I3V?=
 =?us-ascii?Q?R9tymzdRkBORt1JHrXdoq6nBQjHilMXzp2cPOJ7x+13rg3GzXVYCABNdwEww?=
 =?us-ascii?Q?65FX7+1LbljjBagzNI9siLvHPyAYaZTgBKXR+P9p2V0G0rjXuW1suvbYZIgF?=
 =?us-ascii?Q?jQJtT0pgjhSCH+O03CePqsGjT1m7EbCwSV6H46il+8J659qBHhFjFyIYZhOG?=
 =?us-ascii?Q?KntNdYurg77sDYGuTjQy7H2vhWs4e4WpmTFM/PE9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87612ee-550b-4a38-1011-08dd9258fe15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 20:01:47.3574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fne38TuYURXZCARxFK2W+HP5J7uT57t2Utqrl5yd98jnataJY6dQ2yontsFVuu0GvPi5qBC0tblQOEP9b7KO6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

> Hi Dongwon,

> On Tue, 2025-05-13 at 01:26 +0000, Kim, Dongwon wrote:
> > Hi,
> >
> > > Subject: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
> > >=20
> > > The code snippet updating scale_x/scale_y is general and will be
> > > used in next
> > > patch. Make it a function.
> > >=20
> > > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > > ---
> > >  include/ui/gtk.h |  2 ++
> > >  ui/gtk.c         | 30 +++++++++++++++++++-----------
> > >  2 files changed, 21 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> > > aa3d637029..d3944046db 100644
> > > --- a/include/ui/gtk.h
> > > +++ b/include/ui/gtk.h
> > > @@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
> > >  /* gtk-clipboard.c */
> > >  void gd_clipboard_init(GtkDisplayState *gd);
> > >=20
> > > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > > int
> > > +fbh);
> > > +
> > >  #endif /* UI_GTK_H */
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index 8f5bb4b62e..47af49e387 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -801,6 +801,24 @@ void
> > > gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
> > > *widget)
> > > #endif  }
> > >=20
> > > +void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw,
> > > int
> > > +fbh) {
> > > +    if (!vc) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (vc->s->full_screen) {
> > > +        vc->gfx.scale_x =3D (double)ww / fbw;
> > > +        vc->gfx.scale_y =3D (double)wh / fbh;
> > > +    } else if (vc->s->free_scale) {
> > > +        double sx, sy;
> > > +
> > > +        sx =3D (double)ww / fbw;
> > > +        sy =3D (double)wh / fbh;
> > > +
> > > +        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
> >=20
> > I assume you are trying to keep the w/h ratio same here in case free-
> > scale =3D=3D true.
> > Why would we do that? We can easily stretch the host window to any
> > direction then the scale-x and scale-y
> > could be different any time.
> >
> Currently, the code doesn't clarify how we should handle aspect ratios.
> However, I noticed that in the gd_draw_event function, when free-
> scale=3Dtrue, it preserves a fixed aspect ratio. I believe this is a
> reasonable approach (in my humble opinion, it's unlikely that people
> want to see distorted images), so I've decided to retain this behavior
> for now and align other parts to follow the same logic, ensuring a
> consistent experience for users.

Yeah, I didn't realize it does keep the ratio in case of gl=3Doff in the or=
iginal code.
The reason I brought up this is because as you may Have noticed, scale_x an=
d scale_y
have been individually configured based on width and height of the current =
window
and guest surface in gtk-egl and gtk-gl-area, which is being changed with y=
our patches.
I am not sure which one is the best either but this would definitely requir=
e some discussion.

> Best regards,
> Weifeng

> > > +    }
> > > +}
> > >  /**
> > >   * DOC: Coordinate handling.
> > >   *
> > > @@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget
> > > *widget,
> > > cairo_t *cr, void *opaque)
> > >      ww_widget =3D
> > > gdk_window_get_width(gtk_widget_get_window(widget));
> > >      wh_widget =3D
> > > gdk_window_get_height(gtk_widget_get_window(widget));
> > >=20
> > > -    if (s->full_screen) {
> > > -        vc->gfx.scale_x =3D (double)ww_widget / fbw;
> > > -        vc->gfx.scale_y =3D (double)wh_widget / fbh;
> > > -    } else if (s->free_scale) {
> > > -        double sx, sy;
> > > -
> > > -        sx =3D (double)ww_widget / fbw;
> > > -        sy =3D (double)wh_widget / fbh;
> > > -
> > > -        vc->gfx.scale_x =3D vc->gfx.scale_y =3D MIN(sx, sy);
> > > -    }
> > > +    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
> > >=20
> > >      ww_surface =3D fbw * vc->gfx.scale_x;
> > >      wh_surface =3D fbh * vc->gfx.scale_y;
> > > --
> > > 2.49.0
> > >

