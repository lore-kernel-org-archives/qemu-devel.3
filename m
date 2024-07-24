Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC82C3DA70
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVDh-00071k-QP; Wed, 24 Jul 2024 02:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWVDf-00071D-8o
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:11:23 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWVDc-0005ri-Ni
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721801482; x=1753337482;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aWgb9thkH/C+JUp1qjemztuI+5yywr3pIwGIIPSNY0A=;
 b=rFMD8YfdR0owuC1FJxyOSVtcrqJyL7SYEfSIRy0omDrPUm4dDqIdiDck
 S9gRUWz5Vm+LkymvYMb9rFg++uzhkOPz/7r4MKBQlx+nu/IkteMPxkvXM
 P+GhoH359LzFWNAGgbCuXlmEv9ZySfVCyqpCb9u5ekVvK7oV7HDiMBHjQ
 1oSqAp5xv/AiRAP2apIojI06rahg5vDV7NUFg7BQzjsjg2tt8+2jrAw1B
 oPxYaXKMKLnXdtmZ4OTdJBxO0HhCpMsH5MnFT8TQt1HS8gNjwrGendXCE
 1cR0dmxlAYAIwRKDlzHFD/Zooc9+rWkcQJluLjGCFEvrXnAI9uZ5faIUI Q==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17222128"
X-MGA-submission: =?us-ascii?q?MDEX+dDh9Oqi0jsl5nOwu8kdlmkoux6ZC7tCoH?=
 =?us-ascii?q?9rCqbf1FnQgCfDD7lkb+N/yX11Bc1uIqqNgToVortc1hebawhReP7Olx?=
 =?us-ascii?q?QQEAKz7x+FVShicuKGVHtvLoOdPjzAEM+6auP1EdC5c+PUt0/1dT51gY?=
 =?us-ascii?q?qvnWRH1vdX9xf8QoRYU+qpKQ=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 08:11:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT0JXBWGLdwpUceETsoRNYlXpNGmRMAwPJWfi6++mNa9Ni1/GrLWxe+qaJ0lKIl40wqoI+w5llzjQYR4FTLwtfPABY2/BhLUy2Tsoh0vDNV4kMvG3gEQOuXwVmaKseBHWat6oZfPEdQhqdz//eWQAp8wzHKNFskdJs6AsRJtIe567sWDJO/6lzChRgVBAQZ8J42wq/dUE3uLv7cu7yJLKgdcBihneYIlsW5b8W70gWzjGImdkafShXbhfe5q0w67GCS72ktgl2Hc/g9rU197GxyHZW5MfuVF0LDBxI58Tk9G+nHrLSCnUfX2DSTqBOtcEkJpdO0lDcMV/2sXnXJLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWgb9thkH/C+JUp1qjemztuI+5yywr3pIwGIIPSNY0A=;
 b=mJ4ZnUG8fGnn9GnLTcEAg8NNVWPRgdofFhw2dyD6XMQM1KWdXqwDDWCuukpo3/xuYS8GLjqUh47b7SWZOoR7KPV9dFvzsqBxUsRZFIj2MRs7sOu9Z6w8xDwB9aYuzsPkBHRNEh5Se+/KZmMAK6Mpc7ZH9N/wMehKiJ7J4DKC+EV7OINap7pgF/eNTmDxCjOPR71XJ2FE1eQ/1J0pVrU/Ziv+7H4pucfO4HnS3wkC7oNKJwcnaoB+hgutWnHDHdZc3JFM2Gj/beZpgAcolwRlUiECfTdwcz+DSW5DtbKieVgicRRi7O5GAIgRBULFlBhYNumvCa6VMJ+YSgsQYsKzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWgb9thkH/C+JUp1qjemztuI+5yywr3pIwGIIPSNY0A=;
 b=kralOfNgiWgke/nbfISw9CGoYTOXtzTGZ+o8pVPg4VqG9IWEE+cpQqydg/9jG2b6IYe9YA84uVv45tH/dJRa1ttIMCCEv8YSm+xwptHkJhXgQdQZcT/JMZsbFvHCGJX6f8w1T5Ve8V4Uk1USq/nAToX0oiBcnzbnp04vO3KNnJby+3+RBInmEk/3XzCr1ArhFZtbnaVNYvRAjFvYzQeErAYn64LOVsjJNWV90/XBx11Wu783rOcCEFsH1dk9Ord0wOKs4KYHRlF0un21d9m7j2P3HIhMIDDmhR6w4QLaUJIr8En/xqd8Ozh8szOfBQ/Ya4j2n7FgFi8AuX3+9xRYZQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8872.eurprd07.prod.outlook.com (2603:10a6:10:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 06:11:14 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 06:11:14 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa2OtXvGur8faoMEeNH+HzRNGOm7IFZ3mAgAAFUQCAAADuAIAAAPoA
Date: Wed, 24 Jul 2024 06:11:14 +0000
Message-ID: <f1c728b2-e9c6-4f88-ae3f-ea4927b92985@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-15-zhenzhong.duan@intel.com>
 <700f34b1-d020-4a1f-86d0-878a0628cc5e@eviden.com>
 <dd6cf2fc-a18d-4730-a351-be4057b6fb31@eviden.com>
 <SJ0PR11MB67449812034F2086F97B3E0A92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67449812034F2086F97B3E0A92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8872:EE_
x-ms-office365-filtering-correlation-id: 760e7b58-e109-4b9e-3bbd-08dcaba76c3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?anpFa0RHeENJNU1hM3JMVE1HcGczMlJyMHRsQml0MFErL3YzQnBpaHQrSmpS?=
 =?utf-8?B?WkF5WEJickZzRlJZSlMvT3VvVWwreWhuNzE2ZHFQMXBScUxsWENrREtMeE95?=
 =?utf-8?B?Q2FKYUtodzZ6MmZhckVqMGRvSUJnREY0bDFucWpKemEyREhsaVFzRmZDMGx0?=
 =?utf-8?B?OENTbnUzcDZEa04zZFlTK1dGMmtSdDNHYXU1RktURWZkWlpNSUNTcUdMVERn?=
 =?utf-8?B?RE9xMzdhQ1FLQzUwa01HdU5QQkNCTlBHVjUxRjFMb08yKy8rQ1RhdmhMRUdj?=
 =?utf-8?B?MXpzM2k3TmR4Rm0xU1JCMGdQeVVid3AvZ0F1SG9aNUlrK0pOUCtISTdDVy9i?=
 =?utf-8?B?dG9IVkc1K0VTZ0hjYjVRSHJONnBqTGhmNDBWT2ZzRkFzSFVXSXZDWkZTM2or?=
 =?utf-8?B?dFBVWkJOZlVsRXhxYVl6bmdjVzJEbHRSMkFOQ3U3S3NDTnpmd3VsOUFsRUVV?=
 =?utf-8?B?QWV6VHNWb09JYVJsZlF4OWxFVHlpWUVJQWRRcWZVc2M1c1poS1RUYnRZUG5k?=
 =?utf-8?B?SUVEVjdwVzEwUGYvRzFEOEdWUlVMNWtRdyt6dHp3ZGxRTmhTWW9UUkhYZjZD?=
 =?utf-8?B?TzNJSTY1T3FrQVdVeXJUM2dRd085VStVdXJ4WE5udytoejNmTEdTVUs0R05m?=
 =?utf-8?B?VU43N1Z3ektoQjdZdWhUbnErNW42d1BzNFVSSWtXVjBNSFZaallWYzRFTjRJ?=
 =?utf-8?B?NkFabmlacUpLR1RWdTJDQStTV0hOQWdZS1NPOGY5R0l6OVpJK3pQOXlWS3Yx?=
 =?utf-8?B?MUI2TGRuRDEwUndEOWdwR0ZyWHBrRm9YREJyUk42eG9tUnZEVTlkTUwvSmVt?=
 =?utf-8?B?YWhaenErZnJPOXYrVHVmVStyUUFnQVFUdS83WWFGOUNwcDBzbS9FalE4aFRh?=
 =?utf-8?B?U05LMjRNTFA0ZnZlT20rUkZQNzdDNnpzR2ZkeXRBc05Ya3RKaWIveGVWV1BH?=
 =?utf-8?B?NE5jUGw4bmQ5cWJlY3lUQ3dNRk5ydHhRWU1lL3FyaG9neVJuNTNaNEYrV0lG?=
 =?utf-8?B?UysyWjVFZCs1QWlwU3ZjYzZFMSt0VVFqUzN0Z3IzL3BFZlV4RUR6M2NyWlBK?=
 =?utf-8?B?c3JrRWhNQVBuRWtlb2VRc0FZYUE3enM2cW4zRy8yKzcycXpSbVM4MUNXVFJC?=
 =?utf-8?B?ZjJRRERabzNodC9PdzY3V25FLzhqOHd1LzhrLzZhek9aT04vSVpOVjRDNG9Y?=
 =?utf-8?B?SHVlb0pzZXk1SDh6VzlGekRkYmdLRHBjeDdKMS9Cbm1QRWJKRnN3bXZLb1NK?=
 =?utf-8?B?M05razNndm1lc1lLTVVUV1FvSGFMYjNIWlNUVVZlTGc5dkpZM0N5RzhaRlV4?=
 =?utf-8?B?Z3g0eHlnUWZJV1hDZVhSeDZzWlUvS2RnN2hOWGxHcXlaVTE0RWxLSjZsUUFM?=
 =?utf-8?B?L0FjNkllM2hOc3lYZk96alJzRU9GMUtUNzR0djUzWUdvekZuYVZRZW5QSE9t?=
 =?utf-8?B?Sk9leWtCVUtzRkxBWFBKQjY3bis1eFdmcjdDSXhRZkdCY2VVbW8xcE9tWDg4?=
 =?utf-8?B?Z243RjZ6UlRRZXN0eDl0b3drWm9sNzgrcEgza0pwdFNFRTZDR0tsUm13OG81?=
 =?utf-8?B?TEhPSS9oVWFEYlJMbXhwQTN6VnBPWXh3VHJVUUU0ODVFRy94R1dTdTVXdXlH?=
 =?utf-8?B?dnExWldBbzVGZlZ3M2tNK3VQVnFhSEVjZVRJNlI5TmNkWHlYQnZJaHZzSFhP?=
 =?utf-8?B?QWtZci9NUmxyZzR5V0Rkb0EvSU5MUjRpQkZUdlc4SHRXbk5KdnpycHgwTDcr?=
 =?utf-8?B?T2RpcVdYREJRVElPV0lZS2RINzVKS1V3bEUwYkNZL2c1VzA3dVVSRkdsZGhr?=
 =?utf-8?B?b3BLdlViSElyZG9QN1lEY3RxR1dWVDRFNVZuVHZoVDZQRVJqKzl0Z3J1S2dT?=
 =?utf-8?B?cDhxYm1OTFR4TERzbVNNemxQS3ZNVWpDMmtvWTJVNCtNR1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5BSm91QWN0cHBsaHFXdTBWMFJGRXZZUm9vWGZjQ0wzQnVZem56TDJnbTRi?=
 =?utf-8?B?WisvdVJzc2tMTnBOeDVQOHdlcTd1dWVDbm5LOFZRZW1EK0JmZnF4MnlObFJ1?=
 =?utf-8?B?ektkN0hBSEpQdWFGYUxTMFljajUydURUYmcxQ1ExWmJXbHRjL05DUnFQaHc0?=
 =?utf-8?B?cHIyaWZhQW1wT3dXMWdiZ3FPQVBMREo0d3p5ZzdKVDRQUWJDY2RjZkMrSHNT?=
 =?utf-8?B?dDNOSW5PT2lQTWdxb0tncThJTFBjVFZNMi9Wb05WREZBaFVPd1h5Vk51NEF0?=
 =?utf-8?B?a1RTcUNjSnZvOFM3WHh1QjJ4OFNhSldpWWQxdFM1eVBCMzgrNDZteHFzbkNX?=
 =?utf-8?B?Z3diQTlJaUFzWXpibElFVzlqNzBLTnkrVXJBS09HcjJPY0grMFNsRzRJa0tt?=
 =?utf-8?B?M0xYMnIxN3prbmFpbjJVb3p5YnViT1VGRjhaTnZpdDNpaTVkek8zdjFFRXdx?=
 =?utf-8?B?MXc1R0Z4N296cFZaeENCVTIvbXp0VGRWTkNQRmk2M1J5TGRvVVhEbzFaQUsx?=
 =?utf-8?B?bzh0WlJ5eW5WZCt3QjYydytpQjBzUXhNVXB0ZTduL2pET2V0dEM3MDZIYVVi?=
 =?utf-8?B?N2REK040ZTY1emlQQURPb25ON2p1RWdmTHB5VnRkMW5Cbmk3aWJ0RWh5eEVx?=
 =?utf-8?B?QjVzWlRiNGZFTCs0NzdqSlBycGhSQU9ZbmJTajM3c1JEQmExUnBoaDdDcm03?=
 =?utf-8?B?ZVA5M0s1bkxtemZyQWpZU2plTFVpVlRzOXdaTERDc2w0Z0NMNXVwNkEyZWlr?=
 =?utf-8?B?MkY3eXgrUU1YT2Y5QytxdU5JSW5DZUZqS3p2MjkwdGhYcXFxK0xFSmVWaGk0?=
 =?utf-8?B?NkQzbFRiNmxlZy9qamhhdzRXS1NEZFZzNXFkRjhpZkdETGtiRE9jNlZaQThQ?=
 =?utf-8?B?NWxJa1hmbXNabEJiL0NJTk84RmhuUm5OVUhQVGxpMk5obFc1M01xVTBOcXZv?=
 =?utf-8?B?NVNjT2RLR2gvcWVmOEtmcFR2d3dZenV1S2szTDFpOERRVzNpTG1HMzJSVVph?=
 =?utf-8?B?UGViM0lYZlZNYXlRSHVwbDBjcU0yV1RQMzExK0ZkQ3piV0VkOWxLUkhDV2py?=
 =?utf-8?B?ZWRQSlB5VDQrVDQycmdaSyt6NHpJZkhSQ0ZMNlhSR3poanJnZlBrenZ1andv?=
 =?utf-8?B?WWFKOEM5QTg0K2lkdmJxQ0QwbkFVSEFsYTVwZHhPekQ4YXkzYzlUVFZvdEZF?=
 =?utf-8?B?dHQwdGdWRGRvMWIxWXFPTmtURXc2UEd3RGdLa29qTktrczFMenV4L3JpODla?=
 =?utf-8?B?eGJIdFBNZEVDZDNTajdRUkJ2S2lMOXJsTmdSdUtlSWlXOWlFbUxVV3Urd0JT?=
 =?utf-8?B?S3JPUHUyL0tSK0dnYWQyUWk2b2V2WFhJa3VjL1FWMWJ0dkRaT0hkNy9iTnlL?=
 =?utf-8?B?WDR2YzZZYit0SWhGS2VrVm9MTHF0d1A5RTNiR1c1Q0xIaUFXZFNhSW9EcHBM?=
 =?utf-8?B?SWlmSzRBcG1lYllMS3k1UUVNZEpNc1c1NUV4SVV6V1JLWE9JMmdPN3BiR20x?=
 =?utf-8?B?ekN0NCs2UGhWOWRiUVVvbGNYY09rQ3RCdEtYL0hpWDZ3c1ZscGhqMzBGR2Jt?=
 =?utf-8?B?azl1UUgwTnVDQ0FDcWpDdUZldHBIdVdTUEtYZXNTempoM2RJOEtYRit2VTJ3?=
 =?utf-8?B?L1RmOE0wYnFFVmNlS0t1MStSN2dmZlZHM2NQd2p3ZU9TTkxYUHVoRGx1eGxK?=
 =?utf-8?B?V25HUEtleHdjM0hQQ3ZnMVhtVTNDQ0RLUmdiSTBCc3RwaDhSelRjOENhaVB4?=
 =?utf-8?B?MmozTEJJc3B2b3UyU1pvL1hJSGQ3emtHb1lUTGpxZjNyQnJ6dHl1SlRvaWpa?=
 =?utf-8?B?UHNBMnpjNmMyWFFzU09JUTlvV3lMaUlySUplMzc0Tmo4RVNybnk1WmtwUHJ2?=
 =?utf-8?B?ZWh4QUQycWNXOXZsTU9kQkhQUDVtTG15WWpzNU5NdDdMWW5EV2tSSjFUNjNU?=
 =?utf-8?B?MmcxMjhRMXFIRVVTb2RLbmEwSmcyQklCWW55aUhBT1FnNGpNZ3h2YUdYVTY5?=
 =?utf-8?B?VjBSd1lyYU4yT2duMWFVUGlNQWIrcG9PYmxXVFFxczBYUEdnc2E3cWJVbkU4?=
 =?utf-8?B?M3RiZWs4Z1hMYWVGdGdlOUFRNTZabU0yS0NyWlhiSENVT0hadVZ4bzdhaG40?=
 =?utf-8?B?bFZ2QUxlNmFFTHdMUytURnJXLzBwZGJLNlFFclR3NHQ2c1VXaXRpUlk1RjRa?=
 =?utf-8?Q?gP6J1IiZ1YZvtS/Xkx5ec80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <226E361E5EBBB7439D7DB234E96386EC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760e7b58-e109-4b9e-3bbd-08dcaba76c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:11:14.3360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +phQcdFlqB1dOvGN16z0wICm6ra9zsNKY1bVUa5gVI7fovoQDWBXkYI8PXW76kGLpxgjSMLiC+m4Gd+S6GGz2YuyD+Q7q6bymwAiYs+Xp6FcyfdkVeTi3BJWB9llKEiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8872
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDI0LzA3LzIwMjQgMDg6MDcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE0LzE3XSBpbnRlbF9pb21t
dTogcGlvdGxiIGludmFsaWRhdGlvbiBzaG91bGQNCj4+IG5vdGlmeSB1bm1hcA0KPj4NCj4+DQo+
Pg0KPj4gT24gMjQvMDcvMjAyNCAwNzo0NSwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0K
Pj4+IE1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZyBidXQgd2h5IGRvIHdlIGludmFsaWRhdGUg
ZGV2aWNlIElPVExCDQo+Pj4gdXBvbiBwaW90bGIgcmVjZWlwdCBvZiBhIHJlZ3VsYXIgSU9UTEIg
aW52IGRlc2M/DQo+Pj4gSSBkb24ndCBnZXQgd2h5IHdlIGRvbid0IHdhaXQgZm9yIGEgZGV2aWNl
IElPVExCIGludiBkZXNjPw0KPj4gSSB0aG91Z2h0IHlvdSB3ZXJlIHBsYW5uaW5nIHRvIHJlbW92
ZSB0aGF0IGFmdGVyIHRoZSBsYXN0IHJmYyB2ZXJzaW9uDQo+IExvb2sgYXQgdnRkX2lvdGxiX3Bh
Z2VfaW52YWxpZGF0ZSgpLCBpdCBoYXMgc2FtZSBvcGVyYXRpb24uDQo+IFJlYXNvbiBpcyBldmVu
IGlmIHdlIGRvbid0IGVuYWJsZSBkZXZpY2UgSU9UTEIsIGRldmljZXMgc3VjaCBhcyB2aG9zdCBt
YXkgc3RpbGwgY2FjaGVzIElPVExCIGVudHJpZXMuIFNvIHdlIG5lZWQgdG8gZmx1c2ggdGhvc2Ug
c3RhbGUgSU9UTEIgZW50cmllcyBpbiB0aGlzIGNhc2UuDQo+DQo+IFRoYW5rcw0KPiBaaGVuemhv
bmcNCk9rIGZpbmUsDQoNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KDQo+DQo+Pj4gT24gMTgvMDcvMjAyNCAxMDox
NiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBE
byBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzDQo+PiB0aGlzIGVt
YWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgdXNlZCBieSBzb21lIGVtdWxhdGVkIGRldmljZXMg
d2hpY2ggY2FjaGVzIGFkZHJlc3MNCj4+Pj4gdHJhbnNsYXRpb24gcmVzdWx0LiBXaGVuIHBpb3Rs
YiBpbnZhbGlkYXRpb24gaXNzdWVkIGluIGd1ZXN0LA0KPj4+PiB0aG9zZSBjYWNoZXMgc2hvdWxk
IGJlIHJlZnJlc2hlZC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1
bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jIHwgMzUNCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4IDhiNjZkNmNmYTUuLmMwMTE2NDk3YjEgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+Pj4gQEAgLTI5MTAsNyArMjkxMCw3IEBAIHN0YXRpYyB2b2lkDQo+PiB2dGRf
cGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiAgICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiAgICAgICAgICAgICAgICAgfQ0KPj4+Pg0KPj4+
PiAtICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4gKyAgICAgICAg
ICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuIHx8ICF2dGRfYXNfaGFzX21hcF9ub3RpZmllcih2
dGRfYXMpKSB7DQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgdnRkX2FkZHJlc3Nfc3BhY2Vfc3lu
Yyh2dGRfYXMpOw0KPj4+PiAgICAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICAgICAgICB9DQo+
Pj4+IEBAIC0yOTIyLDYgKzI5MjIsOSBAQCBzdGF0aWMgdm9pZA0KPj4gdnRkX3Bpb3RsYl9wYWdl
X2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQo+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGloKQ0KPj4+
PiAgICAgew0KPj4+PiAgICAgICAgIFZURElPVExCUGFnZUludkluZm8gaW5mbzsNCj4+Pj4gKyAg
ICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsNCj4+Pj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7
DQo+Pj4+ICsgICAgaHdhZGRyIHNpemUgPSAoMSA8PCBhbSkgKiBWVERfUEFHRV9TSVpFOw0KPj4+
Pg0KPj4+PiAgICAgICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPj4+PiAgICAgICAg
IGluZm8ucGFzaWQgPSBwYXNpZDsNCj4+Pj4gQEAgLTI5MzIsNiArMjkzNSwzNiBAQCBzdGF0aWMg
dm9pZA0KPj4gdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1
aW50MTZfdCBkb21haW5faWQsDQo+Pj4+ICAgICAgICAgZ19oYXNoX3RhYmxlX2ZvcmVhY2hfcmVt
b3ZlKHMtPmlvdGxiLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
dGRfaGFzaF9yZW1vdmVfYnlfcGFnZV9waW90bGIsICZpbmZvKTsNCj4+Pj4gICAgICAgICB2dGRf
aW9tbXVfdW5sb2NrKHMpOw0KPj4+PiArDQo+Pj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMs
ICZzLT52dGRfYXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+Pj4gKyAgICAgICAgaWYgKCF2
dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0odnRkX2FzLT5idXMpLA0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfYXMtPmRldmZuLCAm
Y2UpICYmDQo+Pj4+ICsgICAgICAgICAgICBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQo
cywgJmNlLCB2dGRfYXMtPnBhc2lkKSkgew0KPj4+PiArICAgICAgICAgICAgdWludDMyX3Qgcmlk
MnBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+Pj4gKyAgICAgICAgICAgIElP
TU1VVExCRXZlbnQgZXZlbnQ7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgICAgIGlmICgodnRkX2Fz
LT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lkKSAmJg0KPj4+PiAr
ICAgICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4+Pj4gKyAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4gKw0KPj4+PiArICAg
ICAgICAgICAgLyoNCj4+Pj4gKyAgICAgICAgICAgICAqIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1Q
QVNJRCBQQVNJRC1iYXNlZC1JT1RMQiBJbnZhbGlkYXRpb24NCj4+Pj4gKyAgICAgICAgICAgICAq
IGRvZXMgbm90IGZsdXNoIHN0YWdlLTIgZW50cmllcy4gU2VlIHNwZWMgc2VjdGlvbiA2LjUuMi40
DQo+Pj4+ICsgICAgICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgICAgIGlmICghcy0+c2NhbGFi
bGVfbW9kZXJuKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4+ICsgICAg
ICAgICAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgICAgIGV2ZW50LnR5cGUgPSBJT01NVV9O
T1RJRklFUl9VTk1BUDsNCj4+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9
ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5Lmlv
dmEgPSBhZGRyOw0KPj4+PiArICAgICAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05P
TkU7DQo+Pj4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBzaXplIC0gMTsN
Cj4+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+Pj4+
ICsgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2FzLT5pb21tdSwg
MCwgZXZlbnQpOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgfQ0KPj4+PiAgICAgfQ0KPj4+
Pg0KPj4+PiAgICAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01N
VVN0YXRlICpzLA0KPj4+PiAtLQ0KPj4+PiAyLjM0LjENCj4+Pj4NCg==

