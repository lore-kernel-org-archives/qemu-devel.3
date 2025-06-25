Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12351C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOUx-00055L-9J; Wed, 25 Jun 2025 07:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUn-00053R-Im
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:54 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUf-0000T1-BD
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851645; x=1782387645;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pS4Eoxr1DdHXZO2xHSot06fpuL9PE0eeJy7emMIt2l0=;
 b=Cqpjs7E5Iyr1s+L+FtikgvkulEIwlsTEoejXQL2l4sPap/RUD/rKH+SA
 YpEUse4O0YPHRymiAdqp2YZHIhY+MDKZhgaccBXtpDLB20HdEdOCxdFKm
 6ysMYvOkdcHCnOaEdJ6RxHqta3EAO4d0MQblFgNYKbSZ7h+5ab1wjT2+t
 +EOoaJ2yd6lojjTJ6u3mnHyegAz87qyMLvtkwZ+ZzEnCSX9nZLC1ZCYN9
 OcHIcIU5bVKK3lk2fsZ0Ua5giMw3kXS9uPC6MjJ7AQH992ey3LwhnOltB
 wx4JDVFc7uv07eFss88KXgEGmR6s1VCi7Hoe2uAVbsmleymJkkHjGjQ3Q w==;
X-CSE-ConnectionGUID: VeO/5GluTg2AgKNRkSDRdA==
X-CSE-MsgGUID: UMfkXw1wSTGI2Bs1ld2tog==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63719541"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="63719541"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:40 -0700
X-CSE-ConnectionGUID: GfskFIeIQ5GJcvcd5PukeA==
X-CSE-MsgGUID: 8/zoCmTlSiSQr3nwGkw5iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="152324836"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syr8LPJfBL7w/J7EoyTIjC6zEbXXliAXbn38b3kYSGEIvy9VJVB35i6f7nvZdF/bG59W3Kc0NLIohFuPUeCEwXo+5O2QZcFNhd2uZFyxboxIPDyFHq672TwSzpdtoiNSmrjP+7+eOhhOEUHqaLxjJbUgcTwUBDZIGIBclsqCzwT94pkz/w4IEqZONxFg5j9bfReJ/LUsi+pzWfNbYJ7dqrWPo9nN5i4n4mnyEhCxh5kyn9eLVSzs0YASrruGlgSHZp+WOCEoegVEfxVRZ33llsr9oOGao3CSZsTO/M8WFiTFrATlAGtIvI5EGErdcFAtXZX9z6R9CwjGc4uTr8MxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyOo8txoWHPgJv48YHHTo/WaGLMKqcUjzR7BlzpvTvk=;
 b=aKmAcXChQP0Nm95tkqb8zw719itDnbs6eL9kSiVv2xFRVLMS1baD4mdqrzm6Rac2m8U6jBuYFrDiKBn7sqb05oS1jaaUMSGaLJavvHc89xE/V+YjLtWp157TCPcEp/dBA3IXTJNvp0y0T5Bx2GIrcbIPR4C29/Hw/dv77H5+IbFwAyX+rFNdfi5Xw3b66NItovX9oCto9Yuf1II/9S21qmbO2lelt5g1KkQmvffa63+i4of0wmETy6dFCB7olgLzEfiLQliX4/Xf2XHRdDVQCR1PV/eeBkuKuT40aQWAq2bvcqnE+/z02iqCBzO8YoPpb3DHOdOBCPUKEOt/Wc7qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
Thread-Topic: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
Thread-Index: AQHb2h4gQH+JbpON4UagdDOZcgrkKbQSRDbw
Date: Wed, 25 Jun 2025 11:40:33 +0000
Message-ID: <IA3PR11MB9136E189D71587ED549F823F927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-33-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-33-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: fc697ed2-6cd0-4dbb-e5d2-08ddb3dd182f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gmEyYhgIxpAP3g9i8b1xheiMuu3dCty54/AtOIxOvUQo16XRmyCFx9Fr34jI?=
 =?us-ascii?Q?ANjsnZgKigD4d2BqEug/caosUsCWmZxlAPEwVig5zu/4Qzz8ynq/CCkmb3zv?=
 =?us-ascii?Q?zsK/EnRiBw8/hwfKErLTHRql5K7jkCOK6zZrCq74xI6OgLO/3uzrSX3Jk4NB?=
 =?us-ascii?Q?WSpaPA/C5dsoezbpOk4otAwtsrlSgtsugC2ndDTy/g6PZgw8Sbcw10J4K5Y1?=
 =?us-ascii?Q?rw7Do8u1QCmRRu9HvjPD5fsgOfn0wu6IFWQNgQ1aVB468yL6JjEdvf8icbek?=
 =?us-ascii?Q?NZ6oKMdlTM5CmHioEbzaaj4ha4/6jYg/4S87psxnMXh2Hvc43m00QfgWvoVj?=
 =?us-ascii?Q?8Sna4K3PyB/H2wXvFCWiDG3Em1utFxF/66Djfa6zr97IG17uvPrSjGJe/Gwl?=
 =?us-ascii?Q?odyH6XS+bF3I4qeDdxjXwg4ntZzyCYCHhhQosYHppwxHyJrwpMR0315rw4UC?=
 =?us-ascii?Q?vyTpRRoNG/n6Wgmfdb7Dv8QtZup8UYal9TZWUBK2dUGgSAb0EqlBRePOQWnM?=
 =?us-ascii?Q?KnwexRa/m9vmfd+3DsNBoRWBx1C07POr9GZ9fNNZ6QGqiHiD7HFetynntfAZ?=
 =?us-ascii?Q?GwPzajGYDd1c4kqgQ/NPn1ZehghcEtVCDq4uF3eSCCClYUfKCxnvflWocVDE?=
 =?us-ascii?Q?MwWdxMKHIfNASfNGue58gVisJpuBF65CFjvc4fx0xlBtjDZt3XCtxOD6b+l/?=
 =?us-ascii?Q?RReq4+dxma2e5+tmInnqHK7xMMoIkINaNN7Gj3ep/8tTR6nmaTqAzOYtI+uX?=
 =?us-ascii?Q?Lm1WziojSbjISXtwEqmaXqerOg0plV1ImIHOLVAeN0B8a39ajY8NxDEzZosL?=
 =?us-ascii?Q?Ttj7F11zB6+lHLYyj6mxuLGtyijY+xas8eHg/PAapDIi2nd8zg+cVQ1hUEHw?=
 =?us-ascii?Q?dwj17HfXznWTn6r/CANqdBJNtczY90aMdNiVm8lw6qxa6ZtXq1suJgAbQPx/?=
 =?us-ascii?Q?vaQrrIBS+z3K37bymjI7FpAZDaTSUVl3oCRsAsVClRPgt10e3B0lO2Yjb/Ga?=
 =?us-ascii?Q?p7CviUSzcHSLgbY1roZGGRSFcHUg5w0QssfTrbXTvRvZy9Mq5eS5AHu+SKcw?=
 =?us-ascii?Q?PbrcVwrRZWsk4yPABo5pGk+4dFhrIXcA2m31qEYBlCut83y72cgt9iVAd1as?=
 =?us-ascii?Q?Ge4GyahhIFvkQtmF5ptXDN/hHXQfcX6CgcYuiYSIu9I1eISP1EUwi9zw9qpO?=
 =?us-ascii?Q?dI0/MDCFBfKpiYD8UUwkkltVPwgPVwjmp/EL2sFZB29pAkGFCyJWRGYlNkZE?=
 =?us-ascii?Q?N/gFootkdKIHPkWlt10LZnMbOgFjopLBbaCi/9FyH4nDvcVUaG4YqWV/JsRX?=
 =?us-ascii?Q?uj6kcQXyGJbOvbNb5RAamR2+J0sTmh1BS+3wlUi1MTDf9cls/A9XBWZ0qNBY?=
 =?us-ascii?Q?qYZyry0BwaajA2hsoUT/7vd2DIqHwIm3y3VUwwDeKkaB8qVR8dQdqA1NWfIC?=
 =?us-ascii?Q?chagHYEfEiS8eGsVhxFBjPz0cXamjRTa4xLotgwxoneAaAwYMl4DNMhZaEcl?=
 =?us-ascii?Q?V7LPzeuJup4LOXc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oua2kekV+qRIw2nXaQgA8rehQI0UsVqLWURr1qzezuumjdqyuOaDgPAJdtcH?=
 =?us-ascii?Q?NxAKwUiAkhkP6ZKzuyUILgyhmCbJuXyv7vs6iX/Ez2b4beEay7BqD8kh4CP2?=
 =?us-ascii?Q?NXOj40JPYqKMXw1HUpYSY/Gsx8IXgFk2bXl1RCGWI8TBip1OM1Kp5zqnsnBB?=
 =?us-ascii?Q?3xzOuFgCGDvhtESxYt5JYT09+2rZlWeAdt0YYPxi0L2SnYgizb2/Mdvyzkjk?=
 =?us-ascii?Q?OseHkynYZp72ByxO6eSUX7zoMzZvn2GrzHzGpzNS1MBhZGsIA9IX3zM4WLcj?=
 =?us-ascii?Q?UGGzhjphBGg4rsVIDUgx8yAWL4F4KgLdmE+zneRDcg0LYMCYHRz7jc5W6Big?=
 =?us-ascii?Q?Ka/53Xaonn0JL/DeQx3BsHOyFZxT03d24UtbZYUs37WrZyrbxQx91Cf36tDJ?=
 =?us-ascii?Q?hc4ncvaN2/ebetGRkoU4ZL7TBI8peRWu1jyEta9eP8Xv7pSbFbZvPYS3ygsm?=
 =?us-ascii?Q?6Uqy8kXhLb1iRXH92+Z1ibVQLfBPcmbzlmGLCKzMiSbuOx89bGZzSYdqsh9M?=
 =?us-ascii?Q?DJnFk5pjVHCV7qvrMe4QCZ2vKHLYTmkVxo24Q7agcMlECiy95XF1+oC0B+mU?=
 =?us-ascii?Q?MfGGxicBemVO0felNFbyvc7+WJGhgiRuvHl/e1iYRu8ZO6COFJ9uAAvDaAMZ?=
 =?us-ascii?Q?ynBI2W5fBQFRnAw7cNZOsDqhkHQHbOdYCYSpfUViagPpiv6zSxmRR1o1Mzsx?=
 =?us-ascii?Q?7cFnlfUrukdoit6EYE3cGQawQxzybCnQOpp/ju04o8w0g6pVLoBH5M2gAJWM?=
 =?us-ascii?Q?PuprS0y5LtBX7Uk5pX+hHjXV5M6v0Kfj4vuzOsxnVzHG1e7GLtS2gj4O0rv+?=
 =?us-ascii?Q?n9R7AINa3dhoSRzpWjcrzmMTAvE3t12YYUQMgMxSJ4ZDJkgv8gOJic5BXT7J?=
 =?us-ascii?Q?nAaVwHGo7VYNvGhkiz16gQS7yPVs1oNSBpvdtJzjxAw3e+G6hUpIR2bGogue?=
 =?us-ascii?Q?6fdDWn/HC/30jSXkiQggTlp7voNF78DCls+fWtggOes6AdoDlvgPATZjV8et?=
 =?us-ascii?Q?ceQldnOv+CWMeddk4OGygJDqC44sV+flfDboxXPnWaUbPAkeeEeDqsHu+T1T?=
 =?us-ascii?Q?EXGdi1T2u6OXieHzOj8EVQVWPHHYUTXe5UfmqJILrc5U9fONEhC7i6PzgPTz?=
 =?us-ascii?Q?pP6aYN7zX1PceoLmTOHwVQqsXX6O886xGC7qerB3EgLROtKhjlimO210EIje?=
 =?us-ascii?Q?CxBvSOwf3pMRP9Sz5DuRwELm3HORgAaari+CrvlMPr4vREZzYCX9DW7hC/ha?=
 =?us-ascii?Q?9WetNWLk8ZCCRCjt5KmKKxccmsSUSsbrkE24cQ/EOw+0LhMwtAGpko2hPvY0?=
 =?us-ascii?Q?HAOE7TeWh2cHCJcWShF4Oo6tLLiEssTXb2fK3rNiP/kfABt6XV6fJp0b9hC5?=
 =?us-ascii?Q?z4J0i/I0T0IaReO1nilmVYVVED7R2XLR0W6T1q6myEANE6wz379lruxlr+cD?=
 =?us-ascii?Q?G9JQOu2SFiizYyQrb6X9/Mmo+Yd3cI+P5Y0lF2yAV5ruinBw4zq8S8QVCfZx?=
 =?us-ascii?Q?TAHLfw0WquYPBTt2spqeH1dOz8K1Hu0xreHjD4XwvU83ItlC1WDNML9er1UX?=
 =?us-ascii?Q?f+n/6njTqAR+UCctAZ8BDs2p4JWjWpimlxMdslRs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc697ed2-6cd0-4dbb-e5d2-08ddb3dd182f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:33.1067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L17+9tgyAlOHTilUvcS5ptdyEwLe77op8hBMIwCcbFyNTFsIHN6QSDqNZeEg0hJ2QTE0zzhcS7SLQ4NqENRdQaLBNqELmV9xt8Re7pv+Rj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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
>Subject: [PATCH V5 32/38] vfio/iommufd: preserve descriptors
>
>Save the iommu and vfio device fd in CPR state when it is created.
>After CPR, the fd number is found in CPR state and reused.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> backends/iommufd.c    | 25 ++++++++++++++++++++++++-
> hw/vfio/cpr-iommufd.c | 10 ++++++++++
> hw/vfio/device.c      |  9 +--------
> 3 files changed, 35 insertions(+), 9 deletions(-)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index c554ce5..e02f06e 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -16,12 +16,18 @@
> #include "qemu/module.h"
> #include "qom/object_interfaces.h"
> #include "qemu/error-report.h"
>+#include "migration/cpr.h"
> #include "monitor/monitor.h"
> #include "trace.h"
> #include "hw/vfio/vfio-device.h"
> #include <sys/ioctl.h>
> #include <linux/iommufd.h>
>
>+static const char *iommufd_fd_name(IOMMUFDBackend *be)
>+{
>+    return object_get_canonical_path_component(OBJECT(be));
>+}
>+
> static void iommufd_backend_init(Object *obj)
> {
>     IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>@@ -64,11 +70,27 @@ static bool
>iommufd_backend_can_be_deleted(UserCreatable *uc)
>     return !be->users;
> }
>
>+static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>+{
>+    IOMMUFDBackend *be =3D IOMMUFD_BACKEND(uc);
>+    const char *name =3D iommufd_fd_name(be);
>+
>+    if (!be->owned) {
>+        /* fd came from the command line. Fetch updated value from cpr st=
ate. */
>+        if (cpr_is_incoming()) {
>+            be->fd =3D cpr_find_fd(name, 0);
>+        } else {
>+            cpr_save_fd(name, 0, be->fd);
>+        }

Maybe this can be handled in iommufd_backend_set_fd() instead of introducin=
g
complete callback? Can we call cpr_get_fd_param()?

>+    }
>+}
>+
> static void iommufd_backend_class_init(ObjectClass *oc, const void *data)
> {
>     UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
>
>     ucc->can_be_deleted =3D iommufd_backend_can_be_deleted;
>+    ucc->complete =3D iommufd_backend_complete;
>
>     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd)=
;
> }
>@@ -102,7 +124,7 @@ bool iommufd_backend_connect(IOMMUFDBackend *be,
>Error **errp)
>     int fd;
>
>     if (be->owned && !be->users) {
>-        fd =3D qemu_open("/dev/iommu", O_RDWR, errp);
>+        fd =3D cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0, =
errp);
>         if (fd < 0) {
>             return false;
>         }
>@@ -134,6 +156,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>*be)
> out:
>     if (!be->users) {
>         vfio_iommufd_cpr_unregister_iommufd(be);
>+        cpr_delete_fd(iommufd_fd_name(be), 0);

I think we shouldn't call this if not owned.

>     }
>     trace_iommufd_backend_disconnect(be->fd, be->users);
> }
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 2eca8a6..152a661 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -162,17 +162,27 @@ void
>vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
> void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
> {
>     if (!cpr_is_incoming()) {
>+        /*
>+         * Beware fd may have already been saved by vfio_device_set_fd,
>+         * so call resave to avoid a duplicate entry.
>+         */
>+        cpr_resave_fd(vbasedev->name, 0, vbasedev->fd);
>         vfio_cpr_save_device(vbasedev);
>     }
> }
>
> void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
> {
>+    cpr_delete_fd(vbasedev->name, 0);
>     vfio_cpr_delete_device(vbasedev->name);
> }
>
> void vfio_cpr_load_device(VFIODevice *vbasedev)
> {
>+    if (vbasedev->fd < 0) {
>+        vbasedev->fd =3D cpr_find_fd(vbasedev->name, 0);

Maybe call this after checking cpr_is_incoming()?

>+    }
>+
>     if (cpr_is_incoming()) {
>         bool ret =3D vfio_cpr_find_device(vbasedev);
>         g_assert(ret);
>diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>index 8c3835b..6bcc65c 100644
>--- a/hw/vfio/device.c
>+++ b/hw/vfio/device.c
>@@ -335,14 +335,7 @@ void vfio_device_free_name(VFIODevice *vbasedev)
>
> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **er=
rp)
> {
>-    ERRP_GUARD();
>-    int fd =3D monitor_fd_param(monitor_cur(), str, errp);
>-
>-    if (fd < 0) {
>-        error_prepend(errp, "Could not parse remote object fd %s:", str);
>-        return;
>-    }
>-    vbasedev->fd =3D fd;
>+    vbasedev->fd =3D cpr_get_fd_param(vbasedev->dev->id, str, 0, errp);
> }
>
> static VFIODeviceIOOps vfio_device_io_ops_ioctl;
>--
>1.8.3.1


