Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRY-0007vE-NT; Tue, 02 Jul 2024 01:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRX-0007uT-3D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:43 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRV-0006TL-1Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899562; x=1751435562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tCY2NdsV8FgpVvvkIkKruBVxFFeDxZcEieTETr17l/M=;
 b=SouFc/UvLQ0KM0/FufwgxrG47IUdPmlewOsINjhHEllpUh6FIbU1mcEZ
 8EWATvNM7V0Rg0FuB3bl+iYWfKRxvam3c3C8kRTX8gj6mlnCRVkjbHI4M
 nkMc5ho3E0uUBYuPNtj/0m0ZrB/3hxLput2zvQ3ewJ4JBwYAapweVJvDH
 GpwPW0Mp+GLn+hSZvYth3P5M4h62UXjJ+0hW37lm14ZVtDiYf+l1pN7Tj
 WtmS5NVb/uqyW+R2CjLmabPVQwwilYyvjxRUBhJy/fwGmncqfPjmWreEs
 Ha/IObdWIpl17/8Fxf7Zc7nYJwAVYGY1XmxicsCocsU11lPRncX+rXALx Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715676"
X-MGA-submission: =?us-ascii?q?MDHtOmzfwSvXI4JG+pWR59a5WhZG2P2g3lvumX?=
 =?us-ascii?q?r72PAQb00I80NigTjj5WWL7zdojv7YjxZ5SP+ia+Vm5eIO4Onl+5yBNn?=
 =?us-ascii?q?j+AV+mYqdM2pXpIZa+IYylbKhLcFZDJKIta7G1jKKoUyee8KgaE0BRpx?=
 =?us-ascii?q?j4182Y4hy4LtiuV9XWoO4g5g=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juU7P/IX6Na8zo0nG/bdQw1k+0Ub3nwdm2fRiVcvsizCBkZ4gsMC14vHVWDcFVTgVGjqqeh0ldxUfPfsCCr9Z83yo9zZ2vokpdY2r73w9IuEQidCfhIocBIDrpcbUlN/BUSHk0E13MPkyapHnyW0AJ6g9KAz1eGfTEGv1+3cdheO55UBjke14xeYZ55ZrYmiTEIrBb4BCWv09x1YsD4Z8oJ9yKovnLy0ZLmSZjTCXjAS4U2NXPKDYVUajggKaaHg3XHZvtLS0OYjt4wVWi5fDsoMC5qinMIS+ukA+QtStlrdwcG5CadcnzHsNKX+LAPqllvNpOc3ekkKRQpdRLoh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCY2NdsV8FgpVvvkIkKruBVxFFeDxZcEieTETr17l/M=;
 b=E39W9ngEyvNHy2oFEZUwfDwbDs58b5MJcTodN+LKugltbBvby9muqvG7nRuFZ7b5V9cCpLJmjmGkBCIGqacOBRC6pNpQZ+MzFaXjmXb4MBg0iTLWDfQY3cJ7uEYVDT7TjsSoasvxj1SamwetUq2eZvQPUQ8O8qQ8+hDgrVGYQKceDk0ZFM5Ncx9zYlFaSo94IGB3dIikW0nJGUSc7lN4J6dvy4TwpDcUly98aX1dkDYTAbtw6wBPqMO6VwdjLvCChFiv5bZOzADj3bvVvE8d/eloKfzBKFpRzxwWlnOxDPUoZbLIr7FakLA2IZTM1C0iSsBBWaXa48kr8++Fde9xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCY2NdsV8FgpVvvkIkKruBVxFFeDxZcEieTETr17l/M=;
 b=Gqub4UZJS8gSESLSQVFxZhJ0UbU3KMhWYKpEPLzU2RsPbid4wdZgXMioQYrskKSoFvybZ8krnDmmvUqnxPf7L4Xviqa8La4qK0BL3j9R8xTnXT2tcMgkJhNu7ylwITFL//+Z9jQWnTM9gMGC1kegSnbVyxGP81FbAxmR1SXXusz2XUKlR8R4Vd6aYZ5YWZ1EZvc87xDqoAMVu7+ecXHOFmZBPWWcVWXD1H/cOsUiSGX+JNB0E+tOMWhtsaHZpnKpfH2ALnICNxRpmYYZ8EWUYiOUA6lC6nTyuxHEzRgkYW/cip1gNrG0Epv0BZjms6vnTtMhTP+8C5eafMi1B9GSjg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:36 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 08/22] intel_iommu: declare supported PASID size
Thread-Topic: [PATCH ats_vtd v5 08/22] intel_iommu: declare supported PASID
 size
Thread-Index: AQHazEQKCL6APuAIA0yeft7aOMEPog==
Date: Tue, 2 Jul 2024 05:52:36 +0000
Message-ID: <20240702055221.1337035-9-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: c026e771-9bab-440d-7cd9-08dc9a5b2d09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0NlNWk1dlBtT1R4RWxyME9UVllCN0NzKzh4QVF4NldLRElWZlZNOEg4SlFC?=
 =?utf-8?B?WkVmN1N5YkR3SzJjV01DaUV3d2NPQ0tGemNvMUVEdjYybVdmWkhpTGNPVitN?=
 =?utf-8?B?dk5JWWtmcVR4eFJXRHN4QnZDZXJ3L0d3Y1V5bEtDQUNSaTdZWVhsWDIxK0Zv?=
 =?utf-8?B?elpyUWRoeU5pVUZoK0x4Sy95NVFGNEl5Q3pDRHVSa01hRDduMllrRFBlS3hj?=
 =?utf-8?B?K3UrdW4zTGRSa0wzOFJMdnh5K3pIWTY4K3h5b3lYMkk5YzZnTHVnRStIOEdr?=
 =?utf-8?B?aXRhVXdiN0VsOUU2NXQyU3pPUGU5ZDRjWk5WZWFrSytsREJXR2N1aHBxNkVL?=
 =?utf-8?B?YmdLSllHa2M2dVNRUkI4ZmZzZ3RveHlsKy9qOEQrT1JjUUxZR1NpRVNNWUpu?=
 =?utf-8?B?OXFKM0RsYU9Dd3NIc3R0N0NGOHBRdXJkVHhRTkViZ2J3OXI1RC82dThPY3pH?=
 =?utf-8?B?TENRZHczZzhRbndKTG1LRFZWdXBCU2hJd1g4R0gwNlhLbE8xa0NIdzN3L1pp?=
 =?utf-8?B?SFR6cWZYL2xBOTVrZzM2VEhROEJQWERwSHdhemltaE1JWm1YNDJNNHk5NjBM?=
 =?utf-8?B?L2lkOUdONkRQd1J0MGhMTW9WZWVuQTlJdlhvYmVOalliN0dneU5WcldTdG5a?=
 =?utf-8?B?MWEzZUpQdGZGenZoeDFmL1pJbG1wVE5DQ1JxbXdYOXNRTGRORWFmdFVjTElQ?=
 =?utf-8?B?L3BDYkgvSEN6ajArVERYbGtzUWgyWHRjK2JiWm5WRmtTMG91c2VCWFAwTnRR?=
 =?utf-8?B?ODEwSGVvMSs2bGJFOTI3a3Q2cUc1U0tqUDFKYTlXcGN1bW9pZmVpUmlocUx2?=
 =?utf-8?B?ckp0ckhZZmpIbFVuSU9SQWg0amZBOC91SzlvVzB6SzZtSCtuLzk5RkVJTE4w?=
 =?utf-8?B?MkkvY3dsRHpIbjByZUJlWWVtY1pFaGt2bWF1ZzFvNk5NZm9CdUptay9sbDR1?=
 =?utf-8?B?OTNvYjRKT3JSMTRxRHNRQlBrM0cxejF0NERmdEU1OTVUZXdhcHJYS2krSklJ?=
 =?utf-8?B?WUYxTE1pOFhiVlA4MytGRytrTVl2MkZRZ1dVbWFnNWErS2lJR3M4STdvZFhB?=
 =?utf-8?B?WW5TUEFuQmNHVGFvU2YwR2M4V2FLVm1jcmx4OUMrRHBaRjhGWTM4UHB5M2lU?=
 =?utf-8?B?QzMrb3c3bnF2eGllMlp3dGVaZFVmbXJTTFlGRVhRN0JTSVRzU254WkxJUEJI?=
 =?utf-8?B?aUNvRTQrWHAzOHJUdmhHN2htMTFvQ3RaRVVJamhCQXd0eERwWVhZVThJQlR1?=
 =?utf-8?B?UnVLVlVSalY0MFZ6RnhIeFNERml1QlM5K0RwQzYrbERXcmxXcFR1NGYxRDlL?=
 =?utf-8?B?ZVNSU1kybEhIczhrenoxSERnS0toV0lIeDY1cDJSTy94VWhyWnltNVliTkVP?=
 =?utf-8?B?YVNIT2RjRnB3SVhKU1o0QWFEcm9UTTN1bWNNdnFXRjQ3YWdOS1NpWnJkR0pR?=
 =?utf-8?B?NXlKeDF2aFd5dk5FODRUM2diSzhKQ010RjRVYTdPcTVRUml2MHVxUEdaeEJx?=
 =?utf-8?B?eDlVdjZzWkZ4VFFFYmZqamZHZlpjOThIWVdzRTNvSjJJUG5PaVp3SEpWSHpC?=
 =?utf-8?B?Z0RwbEx3Lzg1YmxOQnFrSWEvemJ2citVdVZhYmd0TUJHbjk0aW9PS1FMODFQ?=
 =?utf-8?B?VnprdVZ4RGczbmFGZTdmMDEzS3pvMTZkd1l6Zldja2hDWEN5WHk0a09MY0d5?=
 =?utf-8?B?bjRjMHh2R0FIY283bm13TWQ0azh4cEE1NDQyWFVpREM2U3NCSXBVVFpvRFBo?=
 =?utf-8?B?ejE2ZS9yb2ZBTVIzajVPYVN0S0w4bUxXRElQQjU3TCtJU0V4eWRLeWJXYnQ4?=
 =?utf-8?B?MEpaa1AxV0pma1BxNXNCMXRRRThlenM1ZzY4RTFWMkxQT2JOdm5OQ256YVkz?=
 =?utf-8?B?ZnlzZGk0RUw3VmFxMExPM2tkMXlmNkY3MkJ3b2FJWlo4aVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXRPMHBaMlZnYkgyQWY5QjF5WFlsam5TbGtGT2ZWcEFraDcwRlBkVitIdTlJ?=
 =?utf-8?B?Z015R1p5U0UwWUJqZnRDWkRteDY3K1NZOUhHT2JBdzlGTGg1emQrU0czdENV?=
 =?utf-8?B?U3c1dUZTb0NWQnJqRFI5MElkdTBlNzZia1FaQ1NFM1EyQ214WHhJZ0NZaks5?=
 =?utf-8?B?YmZ0NVZUQkRuR1YyM2RQeENDY1grRnpCSExHS00yM0hzeXdiMkNWRUE5QTA0?=
 =?utf-8?B?UzRnOWZqcXA4UG1sdmFBRmZncnhyS3JDMExmZ0xBTWpNM0FvRnNOZlhCeUND?=
 =?utf-8?B?YjRhMFVScWZ3bXlwVU8wY2xGOEVSNHFRUkhDQlBRVDlPZlkvMll0bm42d0th?=
 =?utf-8?B?ZnZlMElFY1FXSVBYNEhZa0haR2UvWmhxQjhsajQ4cUsvWjdaK1ovMFhBbktv?=
 =?utf-8?B?UTMxd3BDWUVGTDJaZ0tlaUp3RHdHaGxuZXhwL2VGTUtacDBaZ0kzVGkyS0Fh?=
 =?utf-8?B?RmpwdTQ4TTlzU2hUV2JqcEdhRWtHRE5FWjY0WnV3bnEwSy85aTR1M1RwbUdn?=
 =?utf-8?B?Vm8vWWpJc3VPd1d5dkZoNFlYaHJZS1dOZjJtWkQ1MjliZkV4a1pkUjhyRFBW?=
 =?utf-8?B?WGp4VnU5ejJBQnpmWFFaZS9SdTlYOEc0L0hnMmxVaStYbG1RVWR6UEZERzU4?=
 =?utf-8?B?V3B5Ym5JNVk4dURTVmlOSVhHTmxlN0U0aU11RTh3dUNKTFNxZGJERU5XZjND?=
 =?utf-8?B?RXY1V3RZK2pIYXRJcGFManBkbmIveXIzbUJuUDZuZTdCTmhyOEhoSW1KK25H?=
 =?utf-8?B?U2VsZmJVVGtZMXZGSjc3NlhkZGRuT1AvZ2p2SWNvaGJnN2FCMTNPdzBWVE4z?=
 =?utf-8?B?VXdCdFMxYUZBSGR2MUZEWi94ajUySHNZUzQ2Slh1MysreHExYlRhc0xyRTdm?=
 =?utf-8?B?bmFKK3JzSmZYUENSR2R1eXZqZmxpdjVoUTdnQW01akU2WE5CUDIxWTRVd2xY?=
 =?utf-8?B?RllkZS9hRmE3RHVxb0RqYVFDNU44dG5xZjR6MTN3SjRoVDl5WWMyUi93SmNR?=
 =?utf-8?B?VWpGdU9neHlSd0Fka1BFRG5WT0V4N1FtUEJ0K1VzZytKVERXSUt4WU1qdDN2?=
 =?utf-8?B?amhmZThwYlJCYUpnNmN3MmEwcjArRkxpdk56cU9QbzlqSlNkM0xrM2dUYjhD?=
 =?utf-8?B?Tm5lUHhXSVdqMjRxeUQ3eTJleGZhM2tLM0xVcGtGSFJhMXNqODkxd3ZKZkZ2?=
 =?utf-8?B?M1RyL3IrRXBBalpUaDlaak1POTFJZitzWThFYU5yWUxNalBNL2JhbkdlK1FV?=
 =?utf-8?B?VHdXOXFTRForMnZEWE96UTlwYjhLUmMweFNIeWRocTlGSThMeU8xQTRZYWVh?=
 =?utf-8?B?WGYyb1JaeFJ1QlY1aWY5VXIwZlplTFpVZHRLNmxPbGtiNFdCS2ZUREJiQW1y?=
 =?utf-8?B?Wm54SFFWcWpPVlFNazN5dFBERVAyQ0NKY2prNUYxOXh2eFNJajg2cCtBRktS?=
 =?utf-8?B?d05UL05pbGpwOUFrZVZkRFRSOGpNVzU2Mzg4ckowZVZZZFRCbkx3SHhwTFdZ?=
 =?utf-8?B?VGhZaHMzRkZwUUEvNjNLN2xLRnFFZlErR3ZaaDAxbCtqN0I4aGhKWlVtVlV2?=
 =?utf-8?B?amk3K1F4NWt6TFdpOTlYK2tKS2hiS3Eva2FEbzk5OEtkVWxDTHBZeGFVaWVz?=
 =?utf-8?B?V2JYVkFjaHdxY3ArRFdhTm5EZDR6OTRQeHhodG1LYmZYOTVxWWU4VHRldWQw?=
 =?utf-8?B?eFM4Zy95RnZkekVwOVh6bDQxaXFmcXhlbSthSm9MWFpYRkt4QWxiaWo0Ymdq?=
 =?utf-8?B?amNGblNlcE1mZFZyR05JYk5HNXBVcmJqSUxWNjh6aWhkL1c2RFdrUVdObjE0?=
 =?utf-8?B?NXRBVXFucFhxaTRSMFIvcHYwQTZDQjJweEhyNjlrcFVlMU1rUmNzdWloeDBk?=
 =?utf-8?B?T0xxbXBOTTAvbnBHRU5MOGIzejJlV1k0TFRSc2dJVEZYWlBtc20xTndrc2FP?=
 =?utf-8?B?VENpQnNIbFdxNG8zeHNNWm1zMjFJTlhqZFJjZTJEY3dRdkxJSGV5eTJqY3BO?=
 =?utf-8?B?MEJKQ1lEVEFPT3ZRRHJTcGUwbFRkZ0dCK3Nvdk42ckV0Qzk3R2VPSlRmYnh3?=
 =?utf-8?B?ZkhlRnMxV1llWGQ1YWN1QlRlR2NWRkhiZmhVbUUvV3N5dHBWU2hCUlppaWUv?=
 =?utf-8?B?b01qUmpzU1c3RzFzVHhQTlp5VzhXR0NHZUhLRDhrUUhEbXg3RW9PM0JxUFl2?=
 =?utf-8?Q?3mrG+9UHymNmWIzM9a+zrR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6432B209B683E4B9FE2E285176F4476@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c026e771-9bab-440d-7cd9-08dc9a5b2d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:36.7892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwbO+WzJBMsRHTBrVHVLVJ+EcJ3emH7xA3P2b9hatRwKZ9nXEMcGTFEGr4wm0b5RmPQ4YIVZd1gE7fTWjT8fC1bTUHMYAqVoprGgwMqby1Dcr8dpNV86ggvrurT9NhMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgMiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEgKw0KIDIg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4
IDcxY2ViZTJmZDMuLjJhNzhmYzgyM2YgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTU4NjAsNyArNTg2MCw3IEBAIHN0
YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQogICAgIH0NCiANCiAg
ICAgaWYgKHMtPnBhc2lkKSB7DQotICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEOw0K
KyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9QQVNJRCB8IFZURF9FQ0FQX1BTUzsNCiAgICAg
fQ0KIH0NCiANCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGJkMjA3NDYzMTguLjExN2RjOTZk
MjIgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTE5NCw2ICsxOTQsNyBAQA0KICNkZWZp
bmUgVlREX0VDQVBfTUhNViAgICAgICAgICAgICAgICgxNVVMTCA8PCAyMCkNCiAjZGVmaW5lIFZU
RF9FQ0FQX05FU1QgICAgICAgICAgICAgICAoMVVMTCA8PCAyNikNCiAjZGVmaW5lIFZURF9FQ0FQ
X1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8PCAzMSkNCisjZGVmaW5lIFZURF9FQ0FQX1BTUyAg
ICAgICAgICAgICAgICAoMTlVTEwgPDwgMzUpDQogI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAg
ICAgICAgICAgKDFVTEwgPDwgNDApDQogI2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAg
ICAgKDFVTEwgPDwgNDMpDQogI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDYpDQotLSANCjIuNDUuMg==

