Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696F9CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcz2-00052r-17; Sun, 18 Oct 2026 22:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcyz-00051z-W6; Sun, 18 Oct 2026 22:20:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcyy-0001Jd-8G; Sun, 18 Oct 2026 22:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376412; x=1823912412;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KI4HkUEn83XBNhK0N8as6EVZ4aL04WzcDoACzxCBXzE=;
 b=CZrOJ050ouVsj5Blh8TJUF3EzK89pqG1vO0abHzvr1sdtQ3wqD5vfk4w
 PPZl4XWAbGxvo3A9Hkrv7YpLcYs2EUeWHhJlEKGFErmTIdGlTN+pKiUXv
 aIQqPn6IUm+EfrD6qz0vPtDZNdYq56ol09XHQrNdPoEdm5okBwU12bM+Q
 6DPaxeNWnfL5LlsxzL4OguOFmzW9fkbUWzIFdj0MzOAqzE7Mftl1YfxxK
 +xJQo5emU6eJorNxCMgyBtL4OPCKcisHtD73QlX7eQqNpNy+qo/WCjken
 PK/Wt+A+XYOBMGCZ/0jyqRFjWj5c3pf/bqfRXKLHMWaUFRg2nqrTbwbW0 g==;
X-CSE-ConnectionGUID: JgoZuggFQ6SFrEpGiGxUiw==
X-CSE-MsgGUID: 4G4x3FTGSKivR1pxU/ARMg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416425"
Received: from mail-westus2azon11012057.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.57])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:20:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRdisDwJ2r4KRDpHoZmafAl0xjWF6CbTsEs1HfFla8STGYtnWwSF5Mi/KXfOxLMvZU9cISSyu/jTgUpriE8yDeApQrEbH5OQ8pb8L51Dz7XhW9AYkOx66Vp9J4B0yV8WgUJI46SszhZofweX5VxfbDRFMryCg0DJRHuvlPeK+nnxGKvi2ZC3wgE3fZNYKAo2OEFhaddaYI87gV+ysHxblwNs1KX9TeuABI1kpvelR/Bv0mqkOwpT31AeUICsailmMyKa0mgCOE3zpkzM6HhWLP133vejn/DdlK66kgDmW1G40THbZGqirVQFda2wEkA+RXfzehBYXUR3Ccd/WS3PqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI4HkUEn83XBNhK0N8as6EVZ4aL04WzcDoACzxCBXzE=;
 b=EYGpotKsbSuSRMzij9feiWa2xlDC9rJdJZgAf+smn6wLt6VFsyuKszmc183AeplAZWfaPZYhHu02265/Sb5LBpUX+Fq7bvx8g7FIKQvnfdYL5J5JR087T7+RlcWJcNrP0yvh+nTDfhUd8dAvkHOsdNcBNvYS4ZmX1zx7Km4dSFEksX71uv6sYCWhFuFH3vyZoz8+jL/4e4ObKQOnpRbhfVT97jpQubzGkXjDjgOhJBsgWYYwD6JSqvjZYbgb0LU0bJcLW4EXIhkaAHVf33yRGrMuQNkOdCsEIQMJ5vmRTPXfveV0Jfi5fk4RDGxl2aa23fGxJ7dFB4HdofebPG4Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI4HkUEn83XBNhK0N8as6EVZ4aL04WzcDoACzxCBXzE=;
 b=FEdNJWQQwXg+Gpr36RYnf0Qx4Kp7+5lToCSE3X1ihGzZIPk46s3ECK30MpcxrAkRM/T5pllWxHNmMpUImvyy3slchwqnRuK/TiNLoQsYpDPrRFqr8Q35uq3HiFWFPJocV7luD3me3jYXyvE4amhfIHW+XrmfDiLpeOKoTsyS4NA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:20:07 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:20:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
Thread-Topic: [PATCH v2] hw/riscv/riscv-iommu: fix entry leak with
 ioatc-limit=0
Thread-Index: AQHdVLrsDqVesutOL0WXDlIlnjvi6LcENz+A
Date: Mon, 19 Oct 2026 02:20:07 +0000
Message-ID: <104336ab25cf6fde203280398f4dcdb2e80bc035.camel@wdc.com>
References: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261005111523.277550-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 27f2e335-db52-4f18-1ede-08df2d877e6e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: FFNgqpMDEOMqPa936xvAEbnf+8UsmXa+f2sD/4fY/JmYLfUYGb/6HS3OWWmGHzxg63+wDDUpxyofFi1IS60YEKkv3W3DWY7eFgwa7r7pzhKRR7u1Jo23kzMBGs1g6tly97o2Hroa73WHaooDvZdawPeP1lP2QSo3/dol2tEwLwMKj53yjMhq9j3spW+DRzA34nhnvIcLI3e/QqO7OBDl3bPgB2cayqglkDSXQpOeb3C55sNjmFwMluul2O1TN3MdaAKLHstW4DHBay7qL0KzcnJTgFNEruFW6RnhLTuhuIO208v88/gI7haH9s39PtigmXcf+ACvl3U545TURroaBqC0frG3lFBhQOjx/9/p95m+RCaYLxLfBnMA40j7Hwqa2M6MDX/02v2/TCxw/eVTslTvyRvMjXf+TQOjzZVecZpkiJglczNzhBXC9KdgsplJexxzi6qW8W4SqBi2V2uihAj0Ink1hgwBGNxTDJCUm0yRIBvuPz5kJjsiBis1bNSh7Dt74SLp0dXFLmrydALb355NIMMZYjkCMbQpKfhQza3wAWFOBnzfAGxxsjbMrLvF+veUyfg4Gbdvahc7MAPR/Uhi97JR8n5vpdtibBEdhQDAe2gbz0+1poDDS3U1oJCCMuAkPWR7reBRjHzDcUZJULelAcMhjhkKRJbC5qb7YC/FrIdoCUkkpgYHWcX11I1/8TPmYtiscsOOjbp5CqVxE/rwSc4TN6VdRSTIF1xbVJY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVBeFE5cmJkdGU0VUVZbk4zV0ZVeVVXTU4vN25XSThCN20wanN2UkJIWVAx?=
 =?utf-8?B?d2o0bnFqQlRHOTlLOUxtckdncU1WSHBvcWV4OHRlcE9NckpZNDIvOEQxMm9X?=
 =?utf-8?B?NEpibytRK3d2QnBqUUw2U2hGQ05uVWpTZmU3TlJUU3JCTlFwSnJzaXBjYmE3?=
 =?utf-8?B?am8vTTFMQ1Zpd1duYnJ6Q0FjZ0NYTVI2SDEyYTEwS0JSTDdrcUNPOERUY1BW?=
 =?utf-8?B?eXg0UkVEbkpVTjFIZkpxTU9wMm1hSGRNZjM3UndlOWxDVzlFamZyTmx1REJp?=
 =?utf-8?B?YmRrLzJFaSttaFpxVjZWQ0kzN1hVUFNXdmgwWkoreGN3cVFqajZoeFJORW50?=
 =?utf-8?B?QW42ek1aM05oNjZHdGVQc3VVWU9UNlR1ZlZoc3BkaWtvU1g5VXZRb0RWenNj?=
 =?utf-8?B?SjNyZFh5N1BlSzR0NVBlVTFXMnA0R05KcEdNcWxzdmhFWWxUTGo2aUN2a1NZ?=
 =?utf-8?B?cHE0aTBQVFZpWjcvUGNXQTBCRmNZcXVac2ZvRUhLMnNhVy9aN1BHYnhzU1Vk?=
 =?utf-8?B?L1AxRVk0QmhzYlozZkNOa0NTSklOL3UxNU4rQzJkcGZGa090MEZFNEF3Vmhw?=
 =?utf-8?B?aUV3SjI2Yi9vczJudzJlMFFGQ3ZOS2Z6NVlUZ0pHcVZldlpBWXRSa01wNFBW?=
 =?utf-8?B?RmVhY3Njb3A0azVVeWU4NlVJb2EwWk0zV3ptU2R3NTI0aVorSkY2VGhoakxS?=
 =?utf-8?B?ckU3QkV3cU0wS09rRXZMYnNxVHg2SVBjbForL0twOFloK3phNy9VNHZHcjYv?=
 =?utf-8?B?bk9EUGJ1VmNSbFFRTDNFUjUzQVp5QnNMT1hNREZ4S0RsS250Qm5vS2lWaHpL?=
 =?utf-8?B?NHUrcCttUGNMUHVnUFdIbUJSaGEzc0s5ZGlKWm83N09sQU9KUGYxa01GYWpG?=
 =?utf-8?B?UkxJa1I3dDVYSFd0REVEc0xWWm40RC9BdnlXNWdrbmpIYjk0Y3I2UUJrdmFN?=
 =?utf-8?B?OS92c28vbDdvRU9OUUdRZWUzemJkR3VlOG5iTUZReGJhenlWaGRQVGpJUklZ?=
 =?utf-8?B?YmhWWkZaWk9JVU1HaW90bG9nTEp6dmNhR29IR09PZkY0bGExKzJycVFVdEVX?=
 =?utf-8?B?RHdLb0duNkN3Q1QzQzYzRE1kazIwMXBQeS9UM0tGRmlQYWk0SHAydU9Hbm5S?=
 =?utf-8?B?QmZoT3BMYllsRk8xQ0xlOU5JRVJKdm9OZlp1LzQ1aUVKeDZxRyt2UCtQQi8r?=
 =?utf-8?B?ODV5WmN3UFRTY1g0aVo2U3Z0dlAxU20wNDRmWkRONEY4T3BlUVZZRnR1S0NR?=
 =?utf-8?B?SHo3NTFNZ1lOVEIrN3YwaFA0L1kxcjkyRlA2YkljQUZEVEhxWk9YVElRbmFC?=
 =?utf-8?B?ZFhHaFlObXdHNTkzZlBMYzFzdjBFdW8zaldMVVRnTWx0eUxva1kvWnc4SWtV?=
 =?utf-8?B?VjRiVmJEenVFY0JBRm1UTjhuTnE1K2NwelBJUThWTHJsaUlBSndyc21CT2kz?=
 =?utf-8?B?cFNTeWxGT1VNVGFRSzVwOHBlMHc0ZERNck5waDJyMFNUMVZpSXFrVFFLaFRa?=
 =?utf-8?B?ZWl2NWw5bEo5ZE5CU1lIbFFvVHBnVG43WWNzSXZVUjZFK0pISGtWcWU3Z2ww?=
 =?utf-8?B?azhjbWlFTVJGTEozMVVwbDRWOVRydzNPTDRZR3pYL2ZIajlPWGxYRXd5L3J5?=
 =?utf-8?B?S3NPRDFaQjFjamtKVkYrWVRmdmlER0lVUVFLNG4ya0Y1Y1dsWEhvTVJrVy8y?=
 =?utf-8?B?dDE4VXprcGlycTQ4STBTYXBtZTJtOVJOaWFzL1V0dmhDNDFJUTE5QjRITzJF?=
 =?utf-8?B?RVI2dDk4eHBMZkdJYVhES1hHWCtQK0h4d2RKWUViem1ub1FESWJQRTRwc0xl?=
 =?utf-8?B?TnhKS0Z0L0V3aXkxZENLaFJ1ekVvSmpuUFNyL0lDbVpyUnFmU3oxVmFNZ244?=
 =?utf-8?B?czdIRkxWSFU0Z3JoZThjeXh3aHNmZjh4VGVLYldzQUVJTlQrQVVaMXJZQ1cz?=
 =?utf-8?B?Skttc1RFdEtUQ3J3SHVKcWxyWXoxdFpJUGk1akRQVGl6WkVxTVR2LysrNkVI?=
 =?utf-8?B?cWhhNUxDMzR0UHU3R2FEeWloaVBOYU5FREthWFNxaGthVytVUWlXek5WV0NB?=
 =?utf-8?B?QkJsLzZSbHd6WlY1MWNRdC9QUUZzWCtFYWtaQzgya01ySTlocmNKc1lvNUhM?=
 =?utf-8?B?NWVoS214ZVRDbEVPNG9NUmFKNWNmZTVtM05EZHE5S1pEbW4xdmdQKzJzU09S?=
 =?utf-8?B?SXg5WFl2c1hSWTJDaVJJTDhwZTBZVDZvdVNNaEg1Zm5NSTdpWEFDb2RiMUZD?=
 =?utf-8?B?amg3VFFLOEM1WmNBQS9Eb0dtMDA3MGFaTVlBLzdraEJtNnR0UkpMdTV0a2py?=
 =?utf-8?B?SWNzdmUybzFYNFphUXdESlJld1dHN3NZbXpBYXhoVjl2RC9SK2NLc2VTQzIy?=
 =?utf-8?Q?vxv9sBwpLLI5iW+ilVfl9FQYOZpcKTt2BKchieueUG3E7?=
x-ms-exchange-antispam-messagedata-1: rf90JgovX92YsW7G2kA0y1EfG8fZd7wAcYE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <726B30AA578A9140BE027BD89A0250BE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yelrT55wmT1RJSfoT+xGjd3+lvOfxbtquvYODgF3zWBAGsOeSz2M6g7j6D6FFlavAhWwY+zO3KJ5vVK5+7gSqA0V0uzdOLJjNjLhqj1x1JvDqTtmrS2mIcEGkuNb39+FTPmDHseQBMzOvGY+jyYDWKFtr36fBrMsdv81kjn//xwzjph2yop5+Edzsc1QO1Jr3pwRx3yImeFk41sjfkAbTWqbKPP5sCBnSW2umLcFbZmFMIFHwzWrYYT9PKHEaMpe85DZqCVnT3HjVpJiUlkFQh3wkGRrL73zzGmVhUyATijj4p4iccpOtdoB8kj8Ma/AmlezoemJ/RyBpVhmd4PARQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bfiL7oAvE7pt2IHwmicTpzXtinTDEUN57r/8po77F6BFETK4jTYqpOXIFiKAAII7QXiNoyd2BuRc0jrAUn25cpa5nSsjry610ZLUIxUamVI12XAaoVNznsh7YPT3J/LZSLWNQiq8SJ33CNzCYdLi2pvpc1qIGIDnGZTwlRPbJ19oF+FvUZ5GLt52nUyse1SamM4sdhQ2inoY/PUTBkdX9/jiU7okPR6rqeWCyau5B62hyfIioGEQP/0ad8HWfCyUQdX1VBtv82/aZC/O+7FP8I/IUPwIqhpOyVh2QvoOEYIE2bTLPRHhD8V7xADiXXhqDf7zYkR7TRPSQagFHOx40hRuTDBW6oBUbz039sTG0phSPkTNXAh8MY/R3v3GJaCnSuAdT5kTpr5NZvL9Kj6YWMSKa1nygK16fjvALeY7yx+NBsqsaK4XnktC5KlwoHGFKp++DYOSgg3npzRZ6IC56Q4WX94mJRmS9JxStLdL6DehnKE2TD8gUwk9gQMnPngi0KwTmBcSNpuQ3KfGaLbquhopGH6AckhqPb+Xi9RjeYoGeo/WycJ+m263WO6d/lyF3ZsXN/W3O8RdkflIJQw9dEzZfmOQ9VjyLypxUErspczvtHAQ+LvThr+NcIVtKbpJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f2e335-db52-4f18-1ede-08df2d877e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:20:07.4282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mo157BEP/YGzpLUVTvsDQJmBnnbXhKwPUux0Ge5O7Ay+GVRycyNh+Inmva/T8TMS9u0gSJQZJjFL8ju3cwG7tPltDUl70OUPDwwXLMzd1j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTEwLTA1IGF0IDE5OjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiByaXNj
dl9pb21tdV90cmFuc2xhdGUoKSBhbGxvY2F0ZXMgYW4gSU9BVEMgZW50cnkgYmVmb3JlIHBhc3Np
bmcgaXQgdG8NCj4gcmlzY3ZfaW9tbXVfaW90X3VwZGF0ZSgpLiBUaGUgdXBkYXRlIGhlbHBlciBu
b3JtYWxseSB0cmFuc2ZlcnMNCj4gb3duZXJzaGlwDQo+IHRvIHRoZSBoYXNoIHRhYmxlLg0KPiAN
Cj4gV2hlbiBpb2F0Yy1saW1pdCBpcyB6ZXJvLCBob3dldmVyLCB0aGUgaGVscGVyIHJldHVybnMg
d2l0aG91dA0KPiBpbnNlcnRpbmcgb3INCj4gZnJlZWluZyB0aGUgZW50cnkuIEV2ZXJ5IGNhY2hl
YWJsZSBub24taWRlbnRpdHkgdHJhbnNsYXRpb24gdGhlcmVmb3JlDQo+IGxlYWtzDQo+IG9uZSBS
SVNDVklPTU1VRW50cnkuDQo+IA0KPiBBdm9pZCB0aGlzIGJ5IGRpc2FibGluZyBjYWNoaW5nIGF0
IHRoZSBjYWxsZXIgd2hlbiBpb2F0Yy1saW1pdCBpcw0KPiB6ZXJvLA0KPiBzbyByaXNjdl9pb21t
dV90cmFuc2xhdGUoKSBkb2VzIG5vdCBhbGxvY2F0ZSBhbiBJT0FUQyBlbnRyeSBpbiB0aGUNCj4g
Zmlyc3QNCj4gcGxhY2UuIFRoaXMgYXZvaWRzIHNwZWNpYWwtY2FzaW5nIGVudHJ5IGZyZWVpbmcg
aW4NCj4gcmlzY3ZfaW9tbXVfaW90X3VwZGF0ZSgpDQo+IGFuZCBrZWVwcyB0aGUgb3duZXJzaGlw
IHNlbWFudGljcyBzaW1wbGVyLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4gRml4ZXM6IDlk
MDg1YTFjM2NiMiAoImh3L3Jpc2N2L3Jpc2N2LWlvbW11OiBhZGQgQWRkcmVzcyBUcmFuc2xhdGlv
bg0KPiBDYWNoZSAoSU9BVEMpIikNCj4gQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcNCj4gU2ln
bmVkLW9mZi1ieTogVGFuIENoaSA8dGFuY2hpMjVAbWFpbHMudWNhcy5hYy5jbj4NCg0KVGhhbmtz
IQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0N
Cj4gdjI6DQo+IC0gRGlzYWJsZSBjYWNoaW5nIHdoZW4gaW9hdGMtbGltaXQgaXMgemVybyBpbnN0
ZWFkIG9mIGZyZWVpbmcgdGhlDQo+IMKgIGFsbG9jYXRlZCBlbnRyeSBpbiByaXNjdl9pb21tdV9p
b3RfdXBkYXRlKCkuDQo+IA0KPiDCoGh3L3Jpc2N2L3Jpc2N2LWlvbW11LmMgfCAzICsrLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ody9yaXNjdi9yaXNjdi1pb21tdS5jIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUu
Yw0KPiBpbmRleCAzMjNhMDQxYjRhLi44NjZmNDljYzM5IDEwMDY0NA0KPiAtLS0gYS9ody9yaXNj
di9yaXNjdi1pb21tdS5jDQo+ICsrKyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LmMNCj4gQEAgLTI5
MTksNyArMjkxOSw4IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5DQo+IHJpc2N2X2lvbW11X21lbW9y
eV9yZWdpb25fdHJhbnNsYXRlKA0KPiDCoMKgwqDCoMKgwqDCoMKgIC8qIFRyYW5zbGF0aW9uIGRp
c2FibGVkIG9yIGludmFsaWQuICovDQo+IMKgwqDCoMKgwqDCoMKgwqAgaW90bGIuYWRkcl9tYXNr
ID0gMDsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpb3RsYi5wZXJtID0gSU9NTVVfTk9ORTsNCj4gLcKg
wqDCoCB9IGVsc2UgaWYgKHJpc2N2X2lvbW11X3RyYW5zbGF0ZShhcy0+aW9tbXUsIGN0eCwgJmlv
dGxiLCB0cnVlKSkNCj4gew0KPiArwqDCoMKgIH0gZWxzZSBpZiAocmlzY3ZfaW9tbXVfdHJhbnNs
YXRlKGFzLT5pb21tdSwgY3R4LCAmaW90bGIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXMtPmlvbW11
LT5pb3RfbGltaXQgPiAwKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIC8qIFRyYW5zbGF0aW9uIGRp
c2FibGVkIG9yIGZhdWx0IHJlcG9ydGVkLiAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgIGlvdGxiLmFk
ZHJfbWFzayA9IDA7DQo+IMKgwqDCoMKgwqDCoMKgwqAgaW90bGIucGVybSA9IElPTU1VX05PTkU7
DQo=

