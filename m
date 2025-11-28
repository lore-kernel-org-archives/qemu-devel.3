Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87222D111A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 02:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOnuK-00005w-Gz; Thu, 27 Nov 2025 21:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOnuI-0008WV-GC
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:08:22 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOnuF-0007H2-Mm
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764295699; x=1795831699;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EVwfNACcoIy1moD7vnqXPEF0k+v9Tfc4zW/XhiZvGoA=;
 b=MiHzFQfY9b19zfZfRtuXsPBjl7dfMFE/t8lo2ImAnB3AADfBeIvCQmi3
 461uPtzwDHSmjtQm3RVuFbzOp2ivutYygJK+70iz/NX8i36T4LwCSrZYc
 Y9N/4n4k2l180HCZNGjO0g4VRKarQguXtehNYnpV2L15fByEPaA+I+VXG
 mevCkq9ea5/Xmo+VmZrC3o2klYYi3zGL03DCr75SrtflTmwMzK8RCqYzO
 /H9J1YRYLazNE3OlB6WM+BIg742kiN37J1UPpjOqyLPpdDEtaXseYmlM9
 3Lvs85npYGuD2CNA8G77ydntWsG0Ku2aUDFNoNVYZplmXO63OEvJD9vPE g==;
X-CSE-ConnectionGUID: MiZkJx7+TjScHIqVACwOOQ==
X-CSE-MsgGUID: PumNjAjAR/6OF4lvkuMEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="69952382"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="69952382"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 18:08:15 -0800
X-CSE-ConnectionGUID: sE5XQ+yDSmC5gOI/IeqoyA==
X-CSE-MsgGUID: 3YFiZ87WR2Wt0LWL7+GRYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="193571809"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 18:08:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 18:08:14 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 18:08:14 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 18:08:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcV0C5xXOYW5BONOKbQJakUyhxCgzFhGqcDgz+h6IzkA7B8SHlOlOwIozW1XQZPpdxVEEDZiUDaayuhSl5F0TKQ7l/FWxRQTPTCMXwNX9pmSLOP24Szwv7nTFsH0trFJzSPosb2TfHrqn7a/bR5AFQ22IbH2FS4SU//eMkBtl0gnScSacbP+hPHTa164gdjOp8RRyUKKhkzXaI6kiMLkaAQ/8NZKzakFn1LNpdmgbHTyljslId1ToHD8vrx4vfJ+nMGO8NzlRkCXF8n7EhTnbR+hWVU+vkQgo4J/nUvxMqzPwtQzibH0H+PfI6sWFBdQdPaUgxJ3ZhjvTTP+TCiedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp734o8DUP0kUNrT7uNVzfyxi49qdPZ2dLP/F+PT5D8=;
 b=NjQRQG6ctkBH91aCUlmJbu4CebiXVkzFfzLhX2sK/7mrRFv+6Ib6Xiv+ynsem6InkacrldTVjhjWat3loeNCkNBfD9EJqZxgUct5k0Ljj2XVLgXx8n2P8JOMBjg4wqjA7sjKvXTPaJzwASFugtOqkg1Xnr1ytpbS2UvXAT8LHfxplE180eeIXvMY1pwaMxDt9AxxBuwJ0ennhTWMl9vuB2ACLP4bmVKrIP9XjDSqzf8YvpZeNBcrgukr0mviKPZokPR6WOTyyoBdyqgrwcegR/TUAVsOXvLHqpGlL5+bXOkwhXBLPKJ5qpWPZ+BQ35PWPltf5Z/E/2f65oglaCsMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by CH3PR11MB8547.namprd11.prod.outlook.com
 (2603:10b6:610:1bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Fri, 28 Nov
 2025 02:08:10 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:08:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Topic: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Index: AQHcV6YfX2HIuNoGSUCHWlM9EysSCrUHZtRw
Date: Fri, 28 Nov 2025 02:08:10 +0000
Message-ID: <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-18-zhenzhong.duan@intel.com>
In-Reply-To: <20251117093729.1121324-18-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|CH3PR11MB8547:EE_
x-ms-office365-filtering-correlation-id: 80565574-ba12-4d09-2f0e-08de2e22faa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qk5TCFaDGh/9x5NvWnkDWMsXRaB8MxKuCBHAw1y5UvISVPEro+daHxNmIMol?=
 =?us-ascii?Q?bP8p6MPDWNQEIPk/qcbH4ZBXn4B3Wi4EVXCy2xYtiIKK0/m/RKY34TB4Zfyv?=
 =?us-ascii?Q?CumaURyOwYRm6m0Iu5UaI3gf3gpo9qKmKH5IMjPykmpxKa2OhjfotYTHYNud?=
 =?us-ascii?Q?TLz9BUoPmBt8KXxXofEHLE9wtYBC9H8NMzsRVxpzNSGkG7P1/A+S2P/G8Yyo?=
 =?us-ascii?Q?osqaNpWjyW4n2OVIF/6TI3G3PsxNMPEH5rzrlu51x0woTSzv9eAsuLE5GKZ0?=
 =?us-ascii?Q?vHDUV5D9hrSCImzZzv3RB0eZf/+HepZhyPbyeHDBfspx2AehnExHjfy8wKHZ?=
 =?us-ascii?Q?KJ0vJyqOQMkq/nMQObsBJSEcSUc3nQUkqytrsupGpcIjEqUSLbWgbtLhf9HD?=
 =?us-ascii?Q?OkLFshz2+A4IxF7Yvw59kXBXWdDhCBtFEXfqes645BxfmzNlRMxd9+sCu1b9?=
 =?us-ascii?Q?6AKS3Ode65LJ84eU10Mg9a38/xl3myIT9O9g26riFspw60GUNyEbePY/4jp1?=
 =?us-ascii?Q?VRN2c32ptExcZfelevA6AJBCrjjbiyTpeoj5pZJpmSWl85C4yg/t5UZuV6Pe?=
 =?us-ascii?Q?oBf2cFyJVXpOx6cf/4UBjubltsIZ6aC9tsYuoStBvb2RJijh0QnT2whiPD0B?=
 =?us-ascii?Q?Z2Kc1kVKTy9cGuNSbbYIgb4ZIpLb7OlcKN/Y9nHjdwzeqXJVv7/L2TaoBOsf?=
 =?us-ascii?Q?MaqKcDomKWIvwh9FHMyogkWFzdU8od5A9WKqQ3X3xWEUHmxyCpEzeQc27ca+?=
 =?us-ascii?Q?DExH3bcbBgUGcArwmEGsouQSlvPaFa6OQygD+pgCW0Yl54YDK9adjuBqCqtV?=
 =?us-ascii?Q?iDR61iBdmflqNL6c5OyG9iiziqSm15FlBrEpK/pLwr94mya/6PhF5kLl56DO?=
 =?us-ascii?Q?s01b3GGsTgOt5NkqZEO4jhhlOqZEuEvQabOZu8rUVMrI6o03iVaj++uvUXN/?=
 =?us-ascii?Q?dpZ2ENypRr2gUnNCPEsR+78ZmJqe9O6PShCfA42x4j+x0DGQbDNZ5dvQ0AWD?=
 =?us-ascii?Q?3vbAtXP0kIypiO/8xOlpDGHFEcbWHasJyuiVHATr/zCVUGEpcq/Omk+wzubz?=
 =?us-ascii?Q?A2N+XeKTDl0qJEEJcrWQ53sJvfUcR7QV0Nx5fe7fT/zqU2lxe2XZz9i2U5GG?=
 =?us-ascii?Q?B6gxe2GtjbjTYT9dFtWF7u+5MALgrDmCVmAvHgw7LK9Cs2gzRDQLYdUQoP0y?=
 =?us-ascii?Q?BTQCGBDI9i3xvri10oyWFEiCgbNKPHHrD1XA++V4gAsqkXFSW3fykAj2hUjz?=
 =?us-ascii?Q?5EMjtKqQDNnH89Qo0jRyKTt29VCImU7PuMH+VIT2EyLdy5iiRyqj8eavNKL0?=
 =?us-ascii?Q?PGLw6pXUb8CrrdmmRh4xbbUSL7yP9utAViKDs5ZdWe33Uo7+C2yasT0JMu75?=
 =?us-ascii?Q?zqGg+6pRxBCUWaNG2Jqt6yMNCEutnap9UG2CU6/ZDa6f0r3cHGaQzHdH2rKI?=
 =?us-ascii?Q?ulvQOxvY/pMTkGQPnHiiYR6YBpfU2Xza26M0uHHQSyCCEJ7HaEJHA6Y+c/7Q?=
 =?us-ascii?Q?P/rmGbLKBkI0u0jg3DAMuXcfF3qNbXOGx+A1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EWNzLJ8etFxeE+4eqMFlz7akvq2tZvIX6CIOP6IEMXyHsHZe8PYl6naLAgO6?=
 =?us-ascii?Q?eHyFfosIQfquc7gRUTqhDdHWSrEBoeWL54K0gKAvRC7777GgHcpv047d9vP7?=
 =?us-ascii?Q?TEKbyFbGzCu0/EgFcZvMYo3nL55Xi+qQjXbNcVsZ9WKAVEuObk43HoV1Ev3P?=
 =?us-ascii?Q?eJqlSZPtVgrEM6/vvXs+drN496mK2XuUT6P0yW4pkwDIcCQP4Ol5WbTBHJzx?=
 =?us-ascii?Q?zQZ80aHJrWBrvoyq4zHRQAk8K0o+NA9hxFjE1Z+kliMo4+kw5ZZG5E+imAQJ?=
 =?us-ascii?Q?Igoehf9WfPYIwGk740hn+vaBHAaDOkOfZw6ajwZ+ikATwQiVP7l6NgmR/zTV?=
 =?us-ascii?Q?uve6W8LKa7qxLDt1EYb5kCfTpzD+1g7FPtyQ2OTBfqsLWlOLqhXPUFz2F6n7?=
 =?us-ascii?Q?l0etAiRjtYCtRzBR0SOR8+oCFoaemllmN4Lx+mGF+ExUDp5rPC0ASJLsf09R?=
 =?us-ascii?Q?6DBK3MhzxH9SeDe6Y0bjRrF4XnSKPto8X0RO7AhJdN7cVVlmiqOOzq9/HVXH?=
 =?us-ascii?Q?4Bk0VH8NrZYqyfIHZ9XAAwr5ZNkm2+JyYfA++6rT67I+c2gf4ZlkIBcyr7i2?=
 =?us-ascii?Q?S8xNmGq4Ob2slAK+rBaMidqwMl3jcqhA2vh/OUR78++VWROfQw/DD/sie8AT?=
 =?us-ascii?Q?Y2QDb1wUsSTKZLtG2PqFXTESyi0gxN44nwZv1EdYy8CywGQLW8z9+Ozfu95Y?=
 =?us-ascii?Q?l2+AW8Pt+hcsNDBUcX/ph0MkMFPqyXGW2uDsM9H+eCrSZD5Hs6QVhSJJdRUa?=
 =?us-ascii?Q?zbaq/fLPSio9TLtTfCLVz+xa2IM7s+B3kdlZPS65Imdz/cG0iQtgN9XJ7/nB?=
 =?us-ascii?Q?Imk608sY8hS4dvhpG9YZc/9zbE/H4u617Th9FPfQcmLAGOyNSzlRSybSn5zu?=
 =?us-ascii?Q?VVe1QHI3N0CmC0QcwNgMab+Z8N9u/4GmFXiyqyPSjLl+3zBcOTjHqzAt+sIv?=
 =?us-ascii?Q?Nz3o7B8+OacU/aQtqD/6tvIydKEblh6nvmPz8Iun/duVq1aHEJOr+zgMkwPW?=
 =?us-ascii?Q?1rzuo4Epvy76kJU8FpkXJLn0tLnp12dLKeTSA/ODunKqfWdD8aqmX7MPoF1y?=
 =?us-ascii?Q?vxNJmcDI5KxzmNGtOQSjiUfhbymfwf6zr+sw5vt9mLeq2+ZO+4i3wH8bnu8c?=
 =?us-ascii?Q?GaGpbcnlzZNgyBzgl29Yr/m25zdrsOWB0Co0DFtiRpsBrQtrNsYCZ2nTzwbL?=
 =?us-ascii?Q?2JofDjg8yiVTJK1iHwcdxwte1lQF3SDnQ2VwTyDj+R+bLnHxoJFpzkLggIBy?=
 =?us-ascii?Q?qK1N/b4697VVE+kb2K59+qjEvNCyFgikOHVqHs0tbCxkz+A0GqUGVvz74iRW?=
 =?us-ascii?Q?WOL34jdl4HdOLk/DleSqh5uVcIVVFApL3hNl7MhS5avO/zVtmziK4SaL+0V3?=
 =?us-ascii?Q?pELCh3Poa2l6hisGftXCF5KMWpxdpxqzxyBdfhw62zVsKJpUQ0xQT1WS7M54?=
 =?us-ascii?Q?uAH7QIX1gT3GwajLKv10hboKAv6t/jwXFYYlOq/m2lHN/hBRyKIDafqY/a+b?=
 =?us-ascii?Q?y+fL/f8jWCKuQkUQ0YIQn29a4aJn8pgdBlZ8dBHVV0R9UTBr4ZhbndMX3v3Y?=
 =?us-ascii?Q?nNokykNb75IR0aZ839sbHMlDFjp7Ysqouxn+Ilkx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80565574-ba12-4d09-2f0e-08de2e22faa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 02:08:10.1811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3UL9v4Oxvx+9RnQhqputDDyGAt7eaM93+deXt8apCLS+IO+5CiQgucSM71w1tgkBv055g/bTWWXNaCv9ujyb/oOMg9Gw4xE5XPPJcHC/Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Hi Yi, Cedric,

Could you also help comment on this patch? This is a pure VFIO migration re=
lated optimization, I think it's better to let it go with the "vfio: relax =
the vIOMMU check" series.
I'd like to move it in next respin of "vfio: relax the vIOMMU check" series=
 if you think it make sense.

Thanks
Zhenzhong

>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
>tracking
>
>When doing ditry tracking or calculating dirty tracking range, readonly
>regions can be bypassed, because corresponding DMA mappings are readonly
>and never become dirty.
>
>This can optimize dirty tracking a bit for passthrough device.
>
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>---
> hw/vfio/listener.c   | 46 +++++++++++++++++++++++++++++++++-----------
> hw/vfio/trace-events |  1 +
> 2 files changed, 36 insertions(+), 11 deletions(-)
>
>diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>index 3b48f6796c..ca2377d860 100644
>--- a/hw/vfio/listener.c
>+++ b/hw/vfio/listener.c
>@@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainer
>*bcontainer)
>     return true;
> }
>
>-static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>+static bool vfio_listener_skipped_section(MemoryRegionSection *section,
>+                                          bool bypass_ro)
> {
>+    if (bypass_ro && section->readonly) {
>+        return true;
>+    }
>+
>     return (!memory_region_is_ram(section->mr) &&
>             !memory_region_is_iommu(section->mr)) ||
>            memory_region_is_protected(section->mr) ||
>@@ -368,9 +373,9 @@ static bool
>vfio_known_safe_misalignment(MemoryRegionSection *section)
> }
>
> static bool vfio_listener_valid_section(MemoryRegionSection *section,
>-                                        const char *name)
>+                                        bool bypass_ro, const char
>*name)
> {
>-    if (vfio_listener_skipped_section(section)) {
>+    if (vfio_listener_skipped_section(section, bypass_ro)) {
>         trace_vfio_listener_region_skip(name,
>                 section->offset_within_address_space,
>                 section->offset_within_address_space +
>@@ -497,7 +502,7 @@ void vfio_container_region_add(VFIOContainer
>*bcontainer,
>     int ret;
>     Error *err =3D NULL;
>
>-    if (!vfio_listener_valid_section(section, "region_add")) {
>+    if (!vfio_listener_valid_section(section, false, "region_add")) {
>         return;
>     }
>
>@@ -663,7 +668,7 @@ static void vfio_listener_region_del(MemoryListener
>*listener,
>     int ret;
>     bool try_unmap =3D true;
>
>-    if (!vfio_listener_valid_section(section, "region_del")) {
>+    if (!vfio_listener_valid_section(section, false, "region_del")) {
>         return;
>     }
>
>@@ -722,11 +727,11 @@ static void
>vfio_listener_region_del(MemoryListener *listener,
>         }
>
>         /*
>-         * Fake an IOTLB entry for identity mapping which is needed by
>dirty
>-         * tracking. In fact, in unmap_bitmap, only translated_addr field=
 is
>-         * used to set dirty bitmap.
>+         * Fake an IOTLB entry for writable identity mapping which is
>needed
>+         * by dirty tracking. In fact, in unmap_bitmap, only
>translated_addr
>+         * field is used to set dirty bitmap.
>          */
>-        if (!memory_region_is_iommu(section->mr)) {
>+        if (!memory_region_is_iommu(section->mr)
>&& !section->readonly) {
>             entry.iova =3D iova;
>             entry.translated_addr =3D iova;
>             iotlb =3D &entry;
>@@ -834,7 +839,8 @@ static void
>vfio_dirty_tracking_update(MemoryListener *listener,
>         container_of(listener, VFIODirtyRangesListener, listener);
>     hwaddr iova, end;
>
>-    if (!vfio_listener_valid_section(section, "tracking_update") ||
>+    /* Bypass readonly section as it never becomes dirty */
>+    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
>         !vfio_get_section_iova_range(dirty->bcontainer, section,
>                                      &iova, &end, NULL)) {
>         return;
>@@ -1093,6 +1099,19 @@ static void
>vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>     if (!mr) {
>         goto out_unlock;
>     }
>+
>+    /*
>+     * The mapping is readonly when either it's a readonly mapping in gue=
st
>+     * or mapped target is readonly, bypass it for dirty tracking as it
>+     * never becomes dirty.
>+     */
>+    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {
>+        trace_vfio_iommu_map_dirty_notify_skip_ro(iova,
>+                                                  iova +
>iotlb->addr_mask);
>+        rcu_read_unlock();
>+        return;
>+    }
>+
>     translated_addr =3D memory_region_get_ram_addr(mr) + xlat;
>
>     ret =3D vfio_container_query_dirty_bitmap(bcontainer, iova,
>iotlb->addr_mask + 1,
>@@ -1228,7 +1247,12 @@ static void
>vfio_listener_log_sync(MemoryListener *listener,
>     int ret;
>     Error *local_err =3D NULL;
>
>-    if (vfio_listener_skipped_section(section)) {
>+    /*
>+     * Bypass readonly section as it never becomes dirty, iommu memory
>section
>+     * is RW and never bypassed. The readonly mappings in iommu MR are
>bypassed
>+     * in vfio_iommu_map_dirty_notify().
>+     */
>+    if (vfio_listener_skipped_section(section, true)) {
>         return;
>     }
>
>diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>index 3c62bab764..180e3d526b 100644
>--- a/hw/vfio/trace-events
>+++ b/hw/vfio/trace-events
>@@ -103,6 +103,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>"region_del 0x%"PRIx64" -
> vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t =
min,
>uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" -
>0x%"PRIx64"]"
> vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>"nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" -
>0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
> vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end)
>"iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>+vfio_iommu_map_dirty_notify_skip_ro(uint64_t iova_start, uint64_t
>iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>
> # container.c
> vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t
>backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t
>dirty_pages) "iova=3D0x%"PRIx64" size=3D0x%"PRIx64"
>backend_flag=3D0x%"PRIx64" bitmap_size=3D0x%"PRIx64" gpa=3D0x%"PRIx64"
>dirty_pages=3D%"PRIu64
>--
>2.47.1


