Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE8C98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9xB0-0000Et-7x; Fri, 25 Sep 2026 00:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9xAr-0000E3-My; Fri, 25 Sep 2026 00:04:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9xAp-0007e0-Jg; Fri, 25 Sep 2026 00:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790309080; x=1821845080;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=itrXV/FHjkWCUL9DcrkIJ36Xi2sPKtb33VrSL9SUpls=;
 b=qazDo2pE1APrXYhfbD5k8HOFQ2Xu+RrutBH3cL26bNPUTTquvfx6Tagw
 6jkMhsUKCRIBkMCVrxnbLNHG4g2ne5swLyzTMgRSO2ZR9jlUdAChqGGwh
 X+bPL4iZPrYSLAWeVwTrHmw0LfCSMbVEIetw+2VvYBqRzJ9zTDoQ7IR71
 X3q9XqVQm5dJ+1Mp5K5/WS18f9cuQc+JAu9+DnbtY19P5JgyBN0wGDQn2
 O17Wyn4z79uo5eS00SygmlBcp+wgCgu/6krqUcLoF+3WJZQx2eXqKBrs2
 EQMP2SSQpu1mxiuhcY0DzNldIHxKocMteEKcocrAhzZ4iOHxLU+QSlq2X w==;
X-CSE-ConnectionGUID: r4qgQJhFR2mCqjbZ1jabDA==
X-CSE-MsgGUID: OyCaiOgbQLSUKL8i9UhnVA==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; d="scan'208";a="152298307"
Received: from mail-westusazon11010022.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.22])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2026 12:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxWstYc8aE9V1rcaLAM6Ik+vEgb0XzCqYf+xKLInHZ9l3GwtFFbRxRli1qC1/1f5td9x4My0k88pCkpB2FG/Q+LqPG3S5WElv6jHfgceWWt/yoqh7TJfcqOgFx6aYGAVZU+7FmXh/I5ahw5aUG/87kfjOxa/vgRUzKVwP1f6CoYK+Kxb52kP/aZHpfUCdavEizVphK1elIhPQgIFF5UF5ro4YIO9zbrbfc+ZRRTNr8DPyX7YF0adxct3hBv+hKd5/TiHS2A+aRujZ5zDgF47mNg3w3wsC8Am7N7IUXOg1VENMZKy2gRiCgTzQNqUyLGpNcuq3qouUQhwR8q7VF6THA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itrXV/FHjkWCUL9DcrkIJ36Xi2sPKtb33VrSL9SUpls=;
 b=J1dcpJLvboBumyneoK8ldeFS7pnXVsk8g5OJFGcYdWwndhet77VLHNwuk+3aHeIG/GYS0VsTA6e1wo2XpihjHPXnOm0/24u8iWymLqhcPyh82MRr4PF5PcHiwwZLV5L3EP0IyUwrU5T2rCT7jIbI3hMxgyzqEGWnI2i5VwRuzqzmvBiVx4DQyfXRHlNZ3fvc2FUWbZerCyb4s+9rb7S/0AuNcbMibJBGT0sk+cI0cs0nzl0RCdChhQKlziXOm+9Z9gc8vw9NU5W9i5d6yZE/yUrMijvT1xEzT1U9ydcBBRpJquHgnkOrSx2M4AzhTvqIiJe8Xh/+ekalNOj4oibJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itrXV/FHjkWCUL9DcrkIJ36Xi2sPKtb33VrSL9SUpls=;
 b=kOkmwzYghqEeNletRGzl1CrssKUzs29T7KX2sdAIHjX2tAeObDwi7gmwy2FlGYe+tQ/6J00zK+nhSs1UdGZHISX0oN3xP7Apv+SQV/wPCgKChPtNJlEOBwN2Z4UemZZSo3si09r1nM6DXpVceHMrfoD18mRF6yrNqkA8J79luSA=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:04:30 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:04:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "almer@dabbelt.com" <almer@dabbelt.com>, 
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 7/7] docs/system/riscv: Add Milk-V Duo board
 documentation
Thread-Topic: [PATCH v4 7/7] docs/system/riscv: Add Milk-V Duo board
 documentation
Thread-Index: AQHdMm6e/iRkciPmXU6Y6zHJUKrn+bbe4Q+A
Date: Fri, 25 Sep 2026 04:04:30 +0000
Message-ID: <c96a5405f5f2737c8df00c863e324f21809c1319.camel@wdc.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
 <20260822194315.2550260-8-visitorckw@gmail.com>
In-Reply-To: <20260822194315.2550260-8-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH0PR04MB8194:EE_
x-ms-office365-filtering-correlation-id: db547add-377a-4081-bcd8-08df1aba19ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|10070799003|22082099003|18002099003|3023799007|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: Bp9hE0AZJa2Sg7U9fNuYSEs77uPxeXYVpD108Zq+kmaBQ1YOuWiXXGqQHU65aGd0hou8zMe9vYneMpQ06EsbNYB+R1zOc8wsaUIhwQL/91KGNJHaHdFVVVrEhCsdrjTCoNFTbZsCh1GtNUxLX/FW9rCKygc1FdXnRVvk0D9Gm5m9aRjki5RayoUmyY/A9dqVXIItCP7p6UpOSJcYry4v4JEBNwRIxSWQvT3+guTbFTaewOID3va8TcryJgUS3/AMKyXIYZspg9yaAFZEM9A89rHif2FMgVjRRMJvcTlXpKwQCVjEMsFHYzac2AHw0BQVsf7wBAshJXu1zTTSxKEmcbGGbvAcv8w0BkT3FhlQCEgS7k5TcpAivuq7j0P33CdrA67rEd1hwZOVMuF0aq7fbofL5kebsuUXyJKoee0mfdvOnOwJUXgzlSlF9T78V1KkbwxKmbzEhstmO7XtEXb0CoIiDtAlAJMCtydyA8WTqwSRFGax3x93fxsVUeLwEBW7nk65rVDGNjZAIPIqABizL4N0mIvxvDB/1I5PfMfaq4FJoD3JdxG+Oeb+bg8O6UZZswyTgLvFWcRuCwP1I+yp2R8ackjDnN2jSm/xAj/nPuJLVYiSkWn13sI+XK966uh1jcWRI5xflHTkm4YQly1tcObvFbHq/F0V59MnyHb34eA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlF6SzBzV251RE1VSE0vTWppTzhzRGRjcE91VStLYzg1aE5XZ3FXelpHLzN5?=
 =?utf-8?B?STNqTFBGTW1kU055QlBqZFFIWDR2eUs3a1RwL1cxNTNRNXhRQndFQUdRQkZa?=
 =?utf-8?B?MUdqUXBsUDlHMnIvdkdNdXJEalA4YmMwMUF3WWFIVVRaamhDZXVUMGxmMTky?=
 =?utf-8?B?UEZZbE91UnNoYjd1OHd3OWhNdjJORnl2ZkROeFNpSXRsQ2w5TnFyN3Q0OVFu?=
 =?utf-8?B?bVFwRjlXbkJIL0hEQ2dJL3VCaEtXRkdZY3ErbVB3cU92TTEvVnQ1elNNSFVQ?=
 =?utf-8?B?RDRzUnlZa0tXVzZJckZucjRxVkNMMlJ4SFN2aHJOR0g0ZkdaRC9GOTRZOU9C?=
 =?utf-8?B?NFVSb2t4cUFkaW9Zd3pGNHpZV2t1VDAwNzRkTkkvSzBXYXRPS2phak5SNmxa?=
 =?utf-8?B?aiszcm8vOFRoT1dVVzRMUnptNWwvbGlLQ0pJQW1uTFVJbzJRQy9CZVZoUnlZ?=
 =?utf-8?B?OW9jWEJSSXVNSHlVQ0o0ZlkrellBRUw4ek5YRjJpczQwZy9BUE9MeDZSSGxE?=
 =?utf-8?B?VUpVWmRva3oxWXlTZnBlZWxiVmhuZFkwWXR6ZVhJT25rM201c2F6VlN5VTAy?=
 =?utf-8?B?L1VObnBxMC9KNGE5RDhybEwzY25SR3Q2bUl4UDlwQVd6R2NlT0NOaVp6UXVi?=
 =?utf-8?B?OTZERVJJOFFoVFNDN3V1bHVLM242MEJyUERJTCtQcE1RVDhkL0F0RWlQbnBj?=
 =?utf-8?B?NzR1UGhSUE1YQUZab0djcXBkUmRIMUtXblh0NjhmQXVCcGprd2wzS3pBVHR2?=
 =?utf-8?B?RUkrTjdicEx2YlcwRlRoajQrV3lkdzR3SWV5aWtIUlNsVitoaFcvN0FPRng4?=
 =?utf-8?B?ejZlbGhUNWxhMlVTSFNUSVdBMDlDYUpJNzlOcGJjNUlxaFRUR0ZOR3Yxbk1q?=
 =?utf-8?B?SGVLU0FMN1FZODB6Uy9ZbGNCUGtTM3JFMXY4cVE2bzJxcncvT0w1WXZTeVda?=
 =?utf-8?B?Y1NpZk9XVDJzWkJzSFFGMEJGMGVsUzFWMmZPMGh0UGhMVHRURTNFQXhvcVRs?=
 =?utf-8?B?YUQzN2VKdmJ6Z3ZnUGxnSlREVmYwbUxTVzZrWmluS1pDV21MUEVGalp3dktW?=
 =?utf-8?B?OEtTZDFJWW9PNi9vbmg0dUgwTEEyMXpYMFVlTzJ1eFRZdW9Tc3RPaENmTmF1?=
 =?utf-8?B?eFlIcThxV1JJcVNubHR3WGZzMnpIRVpkdEh1c0VMSjlNTmYwbFJ5OTZHMVVC?=
 =?utf-8?B?cWR4M0NhRTdORTVLM3NCTmJYQ3NvcGFkcENxYXdOMzBOVHdOWDZ0S3l6Ulcz?=
 =?utf-8?B?TjFxYnlhT21hMDdPTnFrdHVvcHRDN1ZNVWVObitwV3JQMjlMUVBvS1pYRFcy?=
 =?utf-8?B?T2FNYW1nOUR6NlJCeHBoVkxiYzY2eWhyVlFWajJ1cnF1RDBUTHlyejk5aUdC?=
 =?utf-8?B?cGhnNG0rblc3alI4Yi9UMDZrdG9la1ozdE56TG9MNU51MVY2a3dMN3ZNK3ln?=
 =?utf-8?B?V0VPalVFa3FOSWNhanhaL2FJWWNUVnFIeis3N29LNDVwNGk4bktqWmtOdDM2?=
 =?utf-8?B?U0V4d3htRlpOb1JRQ0czUzU4eEREOHFMSHdod1NxVVArSFo3ellkNDVYWEVz?=
 =?utf-8?B?dExoNGg1dDRCQzY5NWhRaUJYN1hGV2NIL2RNamZSbjMwY1A1Q1dGYTlPTHJW?=
 =?utf-8?B?QVlmUTEreXo4M3BvYlgrR3Y1VkpjWlVkMjNiQWFkT2dvUWpOSUFmbkViWHU2?=
 =?utf-8?B?WmpXZUNvSCtlcEM5Y2Z2SmFjYTlEZWVpeit3YzFqRHJtOG5mNWFmWlNzUUFp?=
 =?utf-8?B?Q0JzaUFBUk1YZW0wWC9pdDFLV2d3bmZXTkQ3c0RmOE5JVGRwZml5Y0JSbFd2?=
 =?utf-8?B?NlN5VURCeEp2YjBLVFh6RHl2TnQ4cEVCanV4dWNBMk91NVAwUDZBWDRyZjZG?=
 =?utf-8?B?Nk1vVkF0SHZXd3dXTFlNSVlJUFZZVExMTzJ0SWRQemt0V3YyMVZCRk5EWW9m?=
 =?utf-8?B?cm1nVVlMK1JwMVFuWFZTR1NjVDVTT3FJMmttMko5dHVwNTEvZldhVS83elE0?=
 =?utf-8?B?UDl3TVVrVGZzb0pyZU1qdzV1b0c1d1R5TCtocDNvUWFxSXhQRGF1aDd0SENK?=
 =?utf-8?B?ZUZvVU8vb0J6NmFLRDBUTnhDRVFYdDE0Y2JnZUgzYm1oN29aMjYxL1B1K1RM?=
 =?utf-8?B?cHlkczlWS3ZqTHFVem8ycUlnN3pWMjZUN1c1OVh1eG1kVHdLWWVHSSsyUzZr?=
 =?utf-8?B?dFR5NW8veUN5SExHeFhRallDVzVRZTBtR25CYUxJRkpiT3pQMk95bUtQZHhr?=
 =?utf-8?B?UUlUNG01Q1BOclVJQXdHWnNiT3B0VkJSU0lLaEFaalVSak5iblVZTldWYnZ1?=
 =?utf-8?B?SnBYN2tDU2lXS2dYeHY3SEw0cVJZQ20vSUZYbmUzT001MFhTUGF4U1JOcUhj?=
 =?utf-8?Q?Yl05JSNQTYvaaRNyFb1TqBONyCUBp0Z8JMAKa4BHOpUeY?=
x-ms-exchange-antispam-messagedata-1: ZEqdMZjSia/rmgb0iasaRyX4Tc0u13DKpUo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D879BCAE934D76478CECDEAFAA75762F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XnOcFmp/2/KBh1U32mbtEd0m19ipF8tsTARN3vQATjQtF2N3/M6hyNDO9OOg0dun1eEFhHA9gM5rwa3F5PyknGBHoSYVi3fAu8pkHnJsGaUu29TUxW5BrqJHUf8g+Qr2NvNBush+vBo4K/AT4CO4fT1UMK5oR2vDMUOu7XZ4OhQduywRRNbxMD7VjzQ8WAEhXSfXdmpbthT1WzHuANUwLYOFBVoCq62zYTws/ov6SIA+ejm5sQfV89UL0tugTeADC9RRNEmq7LbI3nLB2J++LC9b4PJ8Vj3Qtgw8P4OoKDLlH91wbIGQhbgOoA7dl7R8m5urth4YThsgbWM5yg6cFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ya/k6yNZaJe153kZw9djCilNiCLvpJAmTZfzrqLAjCdTUS8evf42cRRfu7ar6MQPCrCJwO1KsWBxgJmvC3z4sanPaV4KKTBpwOjHsLJHS9LrMbjAEt8ilaEg8v0o1xQOJTuDJRNc3H+D/Rw/I0wUCpB7kvysQUyrpis8R/KGqSGLiaFeLg5/kJdkxA4kHcyrAb96ee13XrytuoI0DVvk+JxMfX1LQs1jlWdsbIm65gMfPj6K8bk5+W1jOxMESTjPKqOIr76vnfsyZ3ehxgdKDalmTOCCp4o5NgJNSfCLDZYNyGSjZWGRV+r/PQS+zT6zp5GBm7GMOO6M6IbSmI82ZWeIfI0hcq8k1K3zOiRa9bgZ1VuLICocUPi6GXLGiqizuJlSFSrSBUUXQZg/YnPax5Lx+eezTC64CghxMkCtA5z+4zm0lpqvKzJlVNVcNPWGN84WPpOlj4eduYW2D0TechpqSeOy3MNcDdMgNx/ihQTcrh4iTJUJWzKeV+c5fSPR7TQdCGgHreTbh62rY0u8x3CUD3EE4a4KWXY4uwzI+HxiyoNYiIbuximc9vh8wu22faj79n+m3taJcWvJSzjQsKgkwllmw8kcSTNFNYrp91kPB0WtOftfJU4qp2IaSD6s
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db547add-377a-4081-bcd8-08df1aba19ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 04:04:30.6472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zk4+ePMK450Wwmgvs3/HCfY/M1QC/r2cscnZQG0fHAc/gL7yHgFoWLzostQiXRu5WnYJRQ+iNyGM7iA5XPDDDXLupmaHB85yIA9ZJx50ZU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=721c190f3=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gU2F0LCAyMDI2LTA4LTIyIGF0IDE5OjQzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIE1pbGstViBEdW8gYm9hcmQuIFRoaXMgaW5jbHVk
ZXMgYSBicmllZg0KPiBvdmVydmlldyBvZiB0aGUgaGFyZHdhcmUsIGEgbGlzdCBvZiBzdXBwb3J0
ZWQgZGV2aWNlcywgYW5kIHByYWN0aWNhbA0KPiBpbnN0cnVjdGlvbnMgb24gaG93IHRvIGJvb3Qg
dGhlIG1hY2hpbmUgdXNpbmcgT3BlblNCSSBhbmQgYSBMaW51eA0KPiBrZXJuZWwgd2l0aCBhbiBl
bXVsYXRlZCBTRCBjYXJkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Vhbi1XZWkgQ2hpdSA8dmlz
aXRvcmNrd0BnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgTUFJTlRBSU5FUlPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBkb2Nz
L3N5c3RlbS9yaXNjdi9taWxrdi1kdW8ucnN0IHwgNDkNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IMKgZG9jcy9zeXN0ZW0vdGFyZ2V0LXJpc2N2LnJzdMKgwqDCoCB8wqAg
MSArDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspDQo+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL3Jpc2N2L21pbGt2LWR1by5yc3QNCj4gDQo+IGRpZmYgLS1n
aXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDNmNzkzMzRjNTkuLjk3NTBh
MzljYTMgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+
IEBAIC0xODU0LDYgKzE4NTQsNyBAQCBGOiB0ZXN0cy9xdGVzdC9rMjMwLXdkdC10ZXN0LmMNCj4g
wqBNaWxrLVYgRHVvDQo+IMKgTTogS3Vhbi1XZWkgQ2hpdSA8dmlzaXRvcmNrd0BnbWFpbC5jb20+
DQo+IMKgUzogTWFpbnRhaW5lZA0KPiArRjogZG9jcy9zeXN0ZW0vcmlzY3YvbWlsa3YtZHVvLnJz
dA0KPiDCoEY6IGh3L2NoYXIvZHc4MjUwLmMNCj4gwqBGOiBody9taXNjL2N2MTgwMGJfY2xrLmMN
Cj4gwqBGOiBody9yaXNjdi9jdjE4MDBiLmMNCj4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL3Jp
c2N2L21pbGt2LWR1by5yc3QNCj4gYi9kb2NzL3N5c3RlbS9yaXNjdi9taWxrdi1kdW8ucnN0DQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjE3NThkYjJjMWUNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9kb2NzL3N5c3RlbS9yaXNjdi9taWxrdi1kdW8ucnN0DQo+
IEBAIC0wLDAgKzEsNDkgQEANCj4gK01pbGstViBEdW8gYm9hcmQgKGBgbWlsa3YtZHVvYGApDQo+
ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArDQo+ICtUaGUgYGBtaWxrdi1k
dW9gYCBtYWNoaW5lIGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgTWlsay1WIER1bw0KPiBkZXZlbG9w
bWVudCBib2FyZC4NCj4gKw0KPiArVGhlIE1pbGstViBEdW8gaXMgYW4gdWx0cmEtY29tcGFjdCBl
bWJlZGRlZCBkZXZlbG9wbWVudCBwbGF0Zm9ybQ0KPiBiYXNlZCBvbiB0aGUNCj4gK1NvcGhnbyBD
VjE4MDBCIFNvQy4gVGhlIENWMTgwMEIgZmVhdHVyZXMgVC1IZWFkIEM5MDYgUklTQy1WDQo+IHBy
b2Nlc3NpbmcgY29yZXMNCj4gK2Fsb25nIHdpdGggaW50ZWdyYXRlZCBwZXJpcGhlcmFscy4NCj4g
Kw0KPiArRm9yIG1vcmUgaW5mb3JtYXRpb24sIHNlZSA8aHR0cHM6Ly9taWxrdi5pby9kdW8+DQo+
ICsNCj4gK1N1cHBvcnRlZCBkZXZpY2VzDQo+ICstLS0tLS0tLS0tLS0tLS0tLQ0KPiArVGhlIGBg
bWlsa3YtZHVvYGAgbWFjaGluZSBzdXBwb3J0cyB0aGUgZm9sbG93aW5nIGRldmljZXM6DQo+ICsN
Cj4gKyogVC1IZWFkIEM5MDYgY29yZXMNCj4gKyogQ29yZSBMb2NhbCBJbnRlcnJ1cHRvciAoQ0xJ
TlQpDQo+ICsqIFBsYXRmb3JtLUxldmVsIEludGVycnVwdCBDb250cm9sbGVyIChQTElDKQ0KPiAr
KiBEZXNpZ25XYXJlIEFQQiBVQVJUIChkdzgyNTApDQo+ICsqIFNESENJIGNvbnRyb2xsZXINCj4g
KyogQ1YxODAwQiBjbG9jayBjb250cm9sbGVyDQo+ICsNCj4gK0Jvb3Qgb3B0aW9ucw0KPiArLS0t
LS0tLS0tLS0tDQo+ICtUaGUgYGBtaWxrdi1kdW9gYCBtYWNoaW5lIHN1cHBvcnRzIGRpcmVjdCBi
b290IHVzaW5nIGEgZ2VuZXJpYyBSSVNDLQ0KPiBWIE9wZW5TQkkNCj4gK2Zpcm13YXJlIGFuZCBh
IExpbnV4IGtlcm5lbC4gVGhlIHJvb3QgZmlsZXN5c3RlbSBjYW4gYmUgcHJvdmlkZWQgdmlhDQo+
IHRoZQ0KPiArZW11bGF0ZWQgU0QgY2FyZC4NCj4gKw0KPiArUnVubmluZw0KPiArLS0tLS0tLQ0K
PiArVG8gYm9vdCB0aGUgbWFjaGluZSwgeW91IG5lZWQgYSBMaW51eCBrZXJuZWwgKGJ1aWx0IHdp
dGggQ1YxODAwQg0KPiBzdXBwb3J0KSwgYQ0KPiArZGV2aWNlIHRyZWUgYmxvYiAoRFRCKSwgYW5k
IGEgcm9vdCBmaWxlc3lzdGVtIGltYWdlIChlLmcuLCBidWlsdCB2aWENCj4gQnVzeUJveA0KPiAr
b3IgQnVpbGRyb290KS4NCj4gKw0KPiArVXNlIHRoZSBmb2xsb3dpbmcgY29tbWFuZCB0byBib290
IHRoZSBzeXN0ZW0gZGlyZWN0bHkgdG8gdGhlIExpbnV4DQo+IHNoZWxsOg0KPiArDQo+ICsuLiBj
b2RlLWJsb2NrOjogYmFzaA0KPiArDQo+ICvCoMKgICQgcWVtdS1zeXN0ZW0tcmlzY3Y2NCAtTSBt
aWxrdi1kdW8gLW5vZ3JhcGhpYyBcDQo+ICvCoMKgwqDCoMKgIC1iaW9zIHBjLWJpb3Mvb3BlbnNi
aS1yaXNjdjY0LWdlbmVyaWMtZndfZHluYW1pYy5iaW4gXA0KPiArwqDCoMKgwqDCoCAtZHRiIC9w
YXRoL3RvL2xpbnV4L2FyY2gvcmlzY3YvYm9vdC9kdHMvc29waGdvL2N2MTgwMGItbWlsa3YtDQo+
IGR1by5kdGIgXA0KPiArwqDCoMKgwqDCoCAta2VybmVsIC9wYXRoL3RvL2xpbnV4L2FyY2gvcmlz
Y3YvYm9vdC9JbWFnZSBcDQo+ICvCoMKgwqDCoMKgIC1kcml2ZSBmaWxlPS9wYXRoL3RvL3Jvb3Rm
cy5leHQ0LGZvcm1hdD1yYXcsaWQ9c2QtY2FyZCBcDQo+ICvCoMKgwqDCoMKgIC1kZXZpY2Ugc2Qt
Y2FyZCxkcml2ZT1zZC1jYXJkIFwNCj4gK8KgwqDCoMKgwqAgLWFwcGVuZCAiY29uc29sZT10dHlT
MCwxMTUyMDAgcm9vdD0vZGV2L21tY2JsazAgcm9vdHdhaXQNCj4gZWFybHljb24iDQo+ICsNCj4g
K1RoaXMgY29tbWFuZCBib290cyB0aGUgZ2VuZXJpYyBPcGVuU0JJIGZpcm13YXJlLCBsb2FkcyB0
aGUgTGludXgNCj4gSW1hZ2UgYW5kIHRoZQ0KPiArc3BlY2lmaWVkIERUQiwgYW5kIG1vdW50cyB0
aGUgZXh0NCByb290IGZpbGVzeXN0ZW0gZnJvbSB0aGUgZW11bGF0ZWQNCj4gU0QgY2FyZC4NCj4g
K1RoZSBjb25zb2xlIG91dHB1dCBpcyByb3V0ZWQgdG8gdGhlIGBgdHR5UzBgYCBzZXJpYWwgcG9y
dC4NCj4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL3RhcmdldC1yaXNjdi5yc3QgYi9kb2NzL3N5
c3RlbS90YXJnZXQtDQo+IHJpc2N2LnJzdA0KPiBpbmRleCAyNjM5ODY2YTNlLi4xZTQ5MDU1ZTI5
IDEwMDY0NA0KPiAtLS0gYS9kb2NzL3N5c3RlbS90YXJnZXQtcmlzY3YucnN0DQo+ICsrKyBiL2Rv
Y3Mvc3lzdGVtL3RhcmdldC1yaXNjdi5yc3QNCj4gQEAgLTY5LDYgKzY5LDcgQEAgdW5kb2N1bWVu
dGVkOyB5b3UgY2FuIGdldCBhIGNvbXBsZXRlIGxpc3QgYnkNCj4gcnVubmluZw0KPiDCoMKgwqAg
cmlzY3YvazIzMA0KPiDCoMKgwqAgcmlzY3YvbWljcm9ibGF6ZS12LWdlbmVyaWMNCj4gwqDCoMKg
IHJpc2N2L21pY3JvY2hpcC1pY2ljbGUta2l0DQo+ICvCoMKgIHJpc2N2L21pbGt2LWR1bw0KPiDC
oMKgwqAgcmlzY3YvbWlwcw0KPiDCoMKgwqAgcmlzY3Yvc2hha3RpLWMNCj4gwqDCoMKgIHJpc2N2
L3NpZml2ZV91DQo=

