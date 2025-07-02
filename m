Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF0EC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxgO-0002Z7-4o; Wed, 02 Jul 2025 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxgM-0002Yt-Ln
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:39:26 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxgJ-0007Yf-UA
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751463564; x=1782999564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mnUXUgZQb2P8+6ecwAK1cqOMgG+T/ft+pER9DXFQACo=;
 b=VH6piqZi5s5FFIfqXzAe6vLbCh80a8LWrF8IWeTY8aIgmfu/kEmndvqM
 90x/Tijz/jtFhhFBfnV0jMXrpXqfQJpuzs4S8Q+jV/GFi8G83jiexQExA
 2zHoVhZMMl13jWDadOO8HTKwLudY4Kvif+YLnPcKBSBa6PAt5froiHIKz
 zow4Y67mZqRFA+9fT5EeJ5l/XUW9oKMhV0Fl5NRj5WAdmmwbwBXyhORcr
 t7CNAulntZ0sbOh2kTmMWYEIZmJE7fQvY5hoJ1Nr0XnKZ/W5kYzB8CnFv
 WqgxzQhFyR0GDIjulPvKMPsvS7/GhZQanOudAtMfRGhBna2aQhgvtWYm2 Q==;
X-CSE-ConnectionGUID: 5KLwyBRMS5O/8os3OOA4cw==
X-CSE-MsgGUID: PVGXvNydQL6YvRpVF9JjAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53900613"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53900613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:39:18 -0700
X-CSE-ConnectionGUID: Dl+BS3zPSZiVK+ZDx6ybwQ==
X-CSE-MsgGUID: FFAIx8UOREe6vP0cWPpXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153705395"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:39:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:39:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 06:39:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLai3H53yGOW77EokFJeI8okimcP9P3lb8Iq4nq4qg60EmdSBrEDxvvjsooN6Ke067KzlPpTtDnZvMOaUeub7Xfi7NOl3XwuImGpdlnh6rga0IS6M3tzxe+DRvOkkfvq4rg+vp6OZmiRV3+SNaUkhGDVtyprMuAoi27yaOSfqi+DiSrJWuSOHiZYpO56xFBkH7os/klsgwPpe4+3P89nHNHZLoiRa/JC2qu2MeyfZL6jRqQuypoDrdOGwIMOI50ny3jWiOTPO/X4DXkqmmY/oekrGv5NJcFDHv7WiA+nsZ0iOqfgvYyPAzlLEnoXl091sS8+wHXXCTcpnTJLInCOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3J6eQ+N9TjduaNMadJptn9Uh9Qgm8/skGBltfknKz0=;
 b=j671dahdx27HYmYktjRqpdrTpXJhLZctowVS2iFST+edhx1ldjMylN8giHUF2tyULso7fM4FnpaMoFG5fsW7Dp8ez+ARN3yYa5BQwH4jQBdib4xJn/oyhBzyd5e7S4g/nEYAFyZxXFkFs4tDeMor09qX80h9ip77gwUMvT+5KE20hp2EK3w7CCCbMCOAPTj0XR8dlqcuBbEq/ayYvRIbDkCBNxOu/yXnMZP5dHo1x2LfCDsIuU/7tE8ZYnPtd8zZaYHeUSTjpx8SMRdCIHq6pqdmv3yZig9PhkzxDVQCWrjL0i79w621z9IVoOVVeX3cazstxMeiPIxx9wq1P+AvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPFE70B31BEF.namprd11.prod.outlook.com (2603:10b6:f:fc02::5a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 2 Jul
 2025 13:39:15 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 13:39:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 30/38] migration: vfio cpr state hook
Thread-Topic: [PATCH V5 30/38] migration: vfio cpr state hook
Thread-Index: AQHb2h4KPkwfME298UuttDRrdIf1m7QSPE4AgAs3wgCAAYOLcA==
Date: Wed, 2 Jul 2025 13:39:14 +0000
Message-ID: <IA3PR11MB9136B9DC021B0D2B157BE4279240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136990A7C183E88A5E3A9909278A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <735fa30f-e5f9-4777-8765-7b1436e26a35@oracle.com>
In-Reply-To: <735fa30f-e5f9-4777-8765-7b1436e26a35@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPFE70B31BEF:EE_
x-ms-office365-filtering-correlation-id: e1874d41-2ed5-4d2e-e4a0-08ddb96dd5df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/2UiaNAkUP17yys32aIf2L7S407t+6q0wNBpMeq3JW77344J56Jm6HoEWB0+?=
 =?us-ascii?Q?4u8lZe9GtTKVFRDT0RVc0JMCyYQZ3qILxO72GudmzTmpeJcqRCE/JNi4ed8m?=
 =?us-ascii?Q?XK3mGNSdLnlIqEvcw0vJNF3Em/d44pqn1Et2NdOeS871kfJV3uspZsZGO1W8?=
 =?us-ascii?Q?boHuSluBBcZgWlV+XUNc0evC77DZHml3UskfEM8+MvStZOyo0dxMu7yREd9F?=
 =?us-ascii?Q?2/yZni1kLxPjWqp6D6JuovhufTwr4i1/pLFEmakFN3usRSED7YJ4wBqp2dAx?=
 =?us-ascii?Q?INP/KqkeAy3T8dZyXYYGj8J9uHJjgdfgROen1BlZ10ZC0VkywxOBOhUJS8Hb?=
 =?us-ascii?Q?j9qk9dg0yeHJ+d1T8PIcCWVQD26kVXbQD1ms+0g0PNDRQZewnuVVRALw0A/e?=
 =?us-ascii?Q?dxZvzrrx45Vm+j0qNFMJ4zAbYIpv31se6ga+V4V563F/fR7bICcRVnGKkaY1?=
 =?us-ascii?Q?k3Mol+Kpea9oGf0pYmJ9uw2hNoMsE0jA1PUbQnvIrI3WIiVdR7lKBQAseVHc?=
 =?us-ascii?Q?zir+F6cooE7PtH2Ms5qQcP0d9e8V/l8nX30d8z5qFkWhaRo6aEku8yKAY5L1?=
 =?us-ascii?Q?037SGwIAwKgtfTtrXA6t14uPolFPetuVcMeMWKIKVcGV6aPB1xrj1+X41Mq6?=
 =?us-ascii?Q?GxYyZ03TFBlrAlcC6GZgTROTl95P+HnEYzxuHMpIgucMxCwt8/GHWNdI92aq?=
 =?us-ascii?Q?qQ75lrq1vXq9+SqqynQlSSxAFTuHZbMvKYTmoRhAGO1X1ccoFJBC8BDjmEDF?=
 =?us-ascii?Q?8wAqoT2871/k8ON3Ibf2JAVS9X4rPOPa6Xd3GhPDc60Qu1l7xSG5Is9lCq5s?=
 =?us-ascii?Q?o7fFcrgDpndsGOtMgeNMc2KmQsG1pENSIbCnGo9sd8GQT+8wEiN2oHvHiI0R?=
 =?us-ascii?Q?VFgr+SDkTgq+5En8z06Z8/ulNmiM1GPIakv5aTn9llBWOe9woGV02V+U463I?=
 =?us-ascii?Q?XYCnr4gfnoydcpHi4IDzsqgprvSc5BAyCRNbDg0sOEvksLQh1c2Ix3SKyGYr?=
 =?us-ascii?Q?AVUky65pfrVqV7IlqUv4D11BkHTzJoDabIrtBB90BsZoWI0qP9yC7Hr47N4x?=
 =?us-ascii?Q?vbFzrChNX1FtvmciIvHzTo+K+EvlfWIWWm4YWPBfOTyEb776RPFMf9dgOCwy?=
 =?us-ascii?Q?y85b9MBNRAmmEQkA/jY1ReIqJIENmora+BtDKERKMIqW2z5fbmTbqpqgEDtY?=
 =?us-ascii?Q?YRFfifga1sPYMArqhTBlx83FHhKUaCMBOl32gcYPe/wkiCsG6rgVECeNTqyT?=
 =?us-ascii?Q?QFFV62chp5bEZL07MExl3OpPVNJcRfGLq13Ht5pT3Iu9/ZeHxGTfklorMZPj?=
 =?us-ascii?Q?Coigl/fmaw40RD5yasHSJDlTDPm2GQC+QyIZInmJBu+6DQxyxDreQXzn/b1l?=
 =?us-ascii?Q?mjlbf5ZH1wXnYTyQPPe7smKk9iPe1xKsbjw94OXmabGgS0qqaCp0TtAWKLP3?=
 =?us-ascii?Q?wBWrVOSHk9r3CLQcvLJrR2Gf66isqoIy58jy5c+egW9ufhZwJqP6sw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Icd1MGuE2GWoFji8P1cC7Ux2MFESullm1GyEdqhZd9w6Jri+nD9F3DVuoAmo?=
 =?us-ascii?Q?9jQjVwgVeD3ed/6MkfyVYAgMk4wdUjQpqHhYPKK6zstCiR4lda/hGeRceQN+?=
 =?us-ascii?Q?DCwH9/UYTUNmJodvMgw2F5ck2VboQsTAcem3P3t9YQc9FLOlqow4LcdpJwt6?=
 =?us-ascii?Q?2SjNXss2VUDgA8r3a44XpQNZZGwJLyUC+IMW78m7U2zGwxnrmptSYUJWBlb3?=
 =?us-ascii?Q?bGEP0Vsy2YIKEzAIwICGaZuElAaGhP48KMEe0121vTA6/yiuOguxz7oOBhHu?=
 =?us-ascii?Q?5KaIs41I4IXsbYcVQZnH5e5ALOpc3sHeabSzipYpvxqZNAmqiUDzPJs0tkZt?=
 =?us-ascii?Q?xsOwN1l0EXwJsK7sMzFd0wPVH30WQu4mwr0btblmg7xRuwKkhl4Zv6Tujec/?=
 =?us-ascii?Q?DCbhMquuAVSRQ37yz8RA87F/oc5ZPyPVm2lJpqiABNm7F0DrKnhDXtbU2SRR?=
 =?us-ascii?Q?UjYpZrgWYaF58t9s8c2jYAXa26QMOXnoldNTXU1fhRtic7iVTslGjTLNNGHY?=
 =?us-ascii?Q?i3Q8oJAeT428kszcNjJ5j4mg1k9yp+OnhE4GNsQdAKFOvGe9QkulerwkKEHn?=
 =?us-ascii?Q?e9a59nPPEUAqObmS2eIN8ilnR1+0eZgBuKIZRFVvoxdQsGkOhC5/RhbT8wPe?=
 =?us-ascii?Q?S4AOy+sup/6//bz86HDe6UoGaOt68VlSzIElPrbNklq9DliT8QR81oH1xHhx?=
 =?us-ascii?Q?zQusUE/jLKGZotPTCqrRBQRoIDJC7BcEfn2OpTmOdr/C7BllmwmvxvDPdAvq?=
 =?us-ascii?Q?TswSx0B8y6Jjtmep/Zx2/wJ3VUyGGcoKswASyp5kGXgN8cQGRAL8y5gD5LJV?=
 =?us-ascii?Q?TTKUGdZ4u0KlqUbIdRs4xjhVIfbkVCHRlqzt13RLBsJF7bNI0thnqcHFqG5n?=
 =?us-ascii?Q?g5EUhaVpKjpuE6mkXO4AF4gQq2rdKKag+ygNU0kuzW3hCJe8aJAxnYcJa1Xr?=
 =?us-ascii?Q?Jn6x59YWub25pvWkTlkp1nKC3MV6IRb5Wehn9FXYjivALzFYbYO4Wh3mGgjy?=
 =?us-ascii?Q?pYxvDLsUSjo2Dh9AbrTZf1O97rixssMErOGryXb0ijUmuDeLo62bsLv9G76o?=
 =?us-ascii?Q?Pq890Zu8mLPy5f8ANJ3yVnLgpZNABMDdmwcDGUDIFW/PVQwLhjXPVVd7qe2L?=
 =?us-ascii?Q?S6XbcABRqqdiHk6ZzFd19jIGjTdhBo9+NM/7s+T0yAMfLjiBR64RjmcZbMM3?=
 =?us-ascii?Q?rB6l1Z9F5Fz6nHmeWnTTdeGZc3gXHwKqHGzU/KEBpNoU4pIDzvrxwN33sCUI?=
 =?us-ascii?Q?5BwYJ5z9/5NT5Mg9KdaoJ/37jwIMTu718Qj8c/oikoG+ROXB9vPYMGCF8Eay?=
 =?us-ascii?Q?s/WQsnoX3Erq3B+YhQYUAnaFLFXTGuWzBhM+d1dEQSzaE0WCMdaiyTvaR+aZ?=
 =?us-ascii?Q?2CWNDsEp9hjl4E8Bk+TnL8pHSrKYE9H1amzKEI6kJGhqS9SXlP/1AalMPkiV?=
 =?us-ascii?Q?ePpVjYlB6WvEgm3XqRApe5sFeCSNCPaQZMn0yNCu5QXtmwjvmxpTPO+k4sRt?=
 =?us-ascii?Q?VY6atSOiFMfa5Ip5juVfFlLB/HbUV1QwJF+jPuCY104UU8mm2lcllzgeS1MO?=
 =?us-ascii?Q?6qR05U9/LrbRLEUG776DUDJn7Y70fh/yMK/vGqEt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1874d41-2ed5-4d2e-e4a0-08ddb96dd5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 13:39:14.7151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oJ8ePHQhQli7U9DYtZDsZdmzcahdTsd8YuJVhovSkTxrmnAEoGGfXF0NZwibUwt9JIDDZArORsVWW1iwkcCESf069PnYZeqiBVqS7obpLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE70B31BEF
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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
>Subject: Re: [PATCH V5 30/38] migration: vfio cpr state hook
>
>On 6/24/2025 7:24 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V5 30/38] migration: vfio cpr state hook
>>>
>>> Define a list of vfio devices in CPR state, in a subsection so that
>>> older QEMU can be live updated to this version.  However, new QEMU
>>> will not be live updateable to old QEMU.  This is acceptable because
>>> CPR is not yet commonly used, and updates to older versions are unusual=
.
>>
>> I'm not familiar with migration, may I ask how subsection help blocking
>migration
>> from new to old QEMU?
>
>Migrating new to old will fail with an error message saying the subsection=
 is
>not recognized.

You mean old qemu supporting legacy container live update, migrate to new q=
emu supporting iommufd live update?

>
>>> The contents of each device object will be defined by the vfio subsyste=
m
>>> in a subsequent patch.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> include/hw/vfio/vfio-cpr.h |  1 +
>>> include/migration/cpr.h    | 12 ++++++++++++
>>> hw/vfio/cpr-iommufd.c      |  2 ++
>>> hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
>>> migration/cpr.c            | 14 +++++---------
>>> hw/vfio/meson.build        |  1 +
>>> 6 files changed, 39 insertions(+), 9 deletions(-)
>>> create mode 100644 hw/vfio/iommufd-stubs.c
>>>
>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>> index b9b77ae..619af07 100644
>>> --- a/include/hw/vfio/vfio-cpr.h
>>> +++ b/include/hw/vfio/vfio-cpr.h
>>> @@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct
>VFIOPCIDevice *vdev,
>>> const char *name,
>>>                                 int nr);
>>>
>>> extern const VMStateDescription vfio_cpr_pci_vmstate;
>>> +extern const VMStateDescription vmstate_cpr_vfio_devices;
>>>
>>> #endif /* HW_VFIO_VFIO_CPR_H */
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index 7fd8065..8fd8bfe 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -9,11 +9,23 @@
>>> #define MIGRATION_CPR_H
>>>
>>> #include "qapi/qapi-types-migration.h"
>>> +#include "qemu/queue.h"
>>>
>>> #define MIG_MODE_NONE           -1
>>>
>>> #define QEMU_CPR_FILE_MAGIC     0x51435052
>>> #define QEMU_CPR_FILE_VERSION   0x00000001
>>> +#define CPR_STATE "CprState"
>>> +
>>> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>>> +typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice)
>CprVFIODeviceList;
>>> +
>>> +typedef struct CprState {
>>> +    CprFdList fds;
>>> +    CprVFIODeviceList vfio_devices;
>>> +} CprState;
>>> +
>>> +extern CprState cpr_state;
>>>
>>> void cpr_save_fd(const char *name, int id, int fd);
>>> void cpr_delete_fd(const char *name, int id);
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> index 60bd7e8..3e78265 100644
>>> --- a/hw/vfio/cpr-iommufd.c
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -14,6 +14,8 @@
>>> #include "system/iommufd.h"
>>> #include "vfio-iommufd.h"
>>>
>>> +const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later
>patch */
>>> +
>>> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>>> {
>>>      if (!iommufd_change_process_capable(be)) {
>>> diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
>>> new file mode 100644
>>> index 0000000..0be5276
>>> --- /dev/null
>>> +++ b/hw/vfio/iommufd-stubs.c
>>> @@ -0,0 +1,18 @@
>>> +/*
>>> + * Copyright (c) 2025 Oracle and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/vmstate.h"
>>> +
>>> +const VMStateDescription vmstate_cpr_vfio_devices =3D {
>>> +    .name =3D CPR_STATE "/vfio devices",
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 1,
>>
>> Is there difference if version_id=3Dminimum_version_id=3D0?
>
>No.  Some developers add a new VMStateDescription starting at 0,
>and some starting at 1.

OK.

Thanks
Zhenzhong

