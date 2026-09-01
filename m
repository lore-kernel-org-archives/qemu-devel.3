Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A456C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 04:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1GNb-00036i-W9; Tue, 01 Sep 2026 00:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1GNW-00034g-3a; Tue, 01 Sep 2026 00:45:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1GNT-0005gT-LP; Tue, 01 Sep 2026 00:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788237943; x=1819773943;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=u7UUdOYqvI8JVmO1WMRsyKOfZvmLbXdkKsNLfpBd4wg=;
 b=AfAPCyYcCz2xfJqCQFt+RwXPlcFLUsKue9n6oAvy2kbE/ydqTj/rrJAp
 sDOz3obtuBT9M5USWJSe44vrkZHN+0ZPHty+ZAHRUJsugNrwvStxJVpvO
 XK42S4orgSL1km6Zb0Iq2h9FKjxWGdoYlx3M0plEwx/kkymmnNmc6S3Il
 tqt4+IRzgHD6g6Yg7KG396SOedb5yxyPsrGE2e38vhXxBO7tIkPQgacg+
 dK5jJT26D+HGAoa/3bUtUBMfnWWbTPeYb3gapAwt9OlJBk/00wMtRdGOi
 RV6eO81LTTuIeuvGXiyFAcAIdQRLZm1QGclwXMN6orED5+8CS7dnxJp7Y A==;
X-CSE-ConnectionGUID: OTnOAJm9Ri+KB5Kx6ToN8Q==
X-CSE-MsgGUID: dBKWUSMvRrmna+TAthkZlA==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="153093136"
Received: from mail-eastusazon11011004.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.4])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 12:45:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5lZ+axsUx4UG4QtUp6HOsOC24vaP43C5DjQx6Ff0fHnGabHYSbBWr4zwjDfmNgTTH91Bd1p/5sSmHMkTfmV96cBvLAQG/Po9UIwxICOYOShPCtpUKd/e6c1bfW0Gua+qnjOLJpn/4I/ZD0hA6QmTX84NTFBThSfGWMcOe548ikqeaaeubAuw7JGfF2xqHwPMlTpeNYFJZ3yZOeMkMDFxjI1RiOdFK05/7z/Yjy198AjjY3C5mGEqbEDE9X4Wn26gWVKn3ZEOYV0b5e2BCHI6tY4/tjrQEMGA3MXKp3H+bvG/cvFm0OIi15ANbjj2vZ3Jw3lf0Dkj5vha8SipTN9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7UUdOYqvI8JVmO1WMRsyKOfZvmLbXdkKsNLfpBd4wg=;
 b=dHlqCYEc2vec4K7cyAmDHXLbxd6p1/PZHMEwVg7+Twu1w8UKSHkb8UlGokCWTLvqIQnYiysEecwHsKdzUUvyMLtESuqFxtKLlqDm43HMZFNxpFuoF1pibK5U5++tf3mBKYn/wsrcMJ2hYuma+PIvUcYuOj4igiXIqwYZ3mkv2gmVug+uTSQwZuQy3Gn9l1Ls8QjnnrtV0SW/nCQaxdQMWQMkeWSMxD8GrcgBzGuZGD2o5VLGqxD+hfCOaPMAmq7Ut5Rse+z39jZ+LPL3NpriD6t4GuYl3CmtedhQr1LJ+ZSDsNkNYsFhz70YfboYtrGx6abbrbUUQ8nDBdEZEMJB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7UUdOYqvI8JVmO1WMRsyKOfZvmLbXdkKsNLfpBd4wg=;
 b=rEEPVWnTusFZqfvvk1dVoX4RDo1rxm4OS6hUdtJmMPcdpjQwkiG9oJAjBv4qgUz6e/ejNjzUPkPQ+Nf/MEb0PRISPDvbDUn9miaNDdwqyRditvc/r49nu7Y7X01XSfK2/GBFOf4kK8humW49VUG8c+W8nGVb209sbUfPuKlzNMI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SJ0PR04MB7310.namprd04.prod.outlook.com (2603:10b6:a03:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:45:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 04:45:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 02/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_flash()
Thread-Topic: [PATCH v5 02/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_flash()
Thread-Index: AQHdNy1aaum3danjKkSbwFfzQU/wzLa5KxmA
Date: Tue, 1 Sep 2026 04:45:36 +0000
Message-ID: <984331d37f56355611c58e3b3d88141040a5888f.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-3-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SJ0PR04MB7310:EE_
x-ms-office365-filtering-correlation-id: fedca0cb-547b-4eb0-5771-08df07e3dda6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|10070799003|376014|10067099003|18002099003|4143699003|11063799006|56012099006|22082099003|38070700021;
x-microsoft-antispam-message-info: 9UrsISfagIzas4yRC8heAPtSP89nNRpE/tRJoH4ycO+rMev+8s9RW1dq81yQhVGiQpWZV5kLU224FAZ9mRPS0KX806zcDUcriEVPPq5M/Ty2cqzCogpsFBLxl/JQPh7x+XE/mHoR989Wdb9rxWadkkl2zSXN5knFHvCMWU2did/GJTL/UFzP+jB8uJX58Bl3xhDZPeswxKwocMgmZk1t3HnTN4tGlgnpiu0xYgGaaq+lEinbvYSvU4yePog+QhpqR8qsva8K1TgO2WZvMLtiJbqwXwtF2X7MCbMB62cuqvFvjOa4osT+cOCMVvAE5Vno7V7NrUSXG/xlUEFWDdC1d2qy2OJrNrkB9erOmJyQ884i9O5NiMhBM/pxqgjuJuAJv0w/f8+kSODWiCD6gWmhd5Re5mYfhG1mEjUc9bKkmiEo/vtFMIDHkit4cHgo5/z3qnatERlIyiNZ73xUcLf74l7pPqS3wsSMixm7v5Dn0IqTPcwcUi6GvVfJMFmHnhHr0H6ZmMouq31XTDBCyyw8pzU6q2drVIb8vw0kVCxcFW62cuxXVxXRDGTAveZjW/rePNHphKd04xJKKnxTvDlWbdzr67yvdwS3iX1s2gaK8dXB+JDkJN0+kfdYlEB8jBt+81Aqherm7TEy8rQJlvzbOfriPz8mm9hU6cS7NwxxDVzejlqAmxsv8U7V0n7pbzj7M4i21cYNNO2BW6vNHB6s2GVlKBqAApX7GvVnoHUfnsg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(10070799003)(376014)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFXWmo1MDhqakpzTFVHZFlnVEYwdEQ4ZGpLMUhuWFp5Qkh6RXVzc3MvMzVw?=
 =?utf-8?B?Y2xrZkJDRTdMYjRsRTBwM0lzUGZYRDd2Z3VRU0xCNGJ2ZjRiUkx2Nlc2TGI2?=
 =?utf-8?B?LzhlVlZxSUZtV2g0aFREUmVNeHpzSDRWUk1ScWVkODd0RmlrWjF2Z2hVeWJa?=
 =?utf-8?B?Ym9YbUlCRENqV3B6SjJVSncwU1hvU2JySGxnZ0tHeXdPelhxK0NGYlBid0cz?=
 =?utf-8?B?QU5sR25mVi9MelVHdmRDZE54K0xYdUdmNWM5NDVhcy9TcGs1QWpjWGVjU3ps?=
 =?utf-8?B?Q3Z6VURTQ1N3Q29yRzJwcUxJam5JNk90S1BWMHI1b2lseGoxS1hHdlpZbUFr?=
 =?utf-8?B?K3JGU29LRjBQQ1RxeGVtRzhiMkpqNHlXZGZiSDRPbVQzVFF6TmE5TmRSd2s0?=
 =?utf-8?B?UFcxNWduMFY1K1lPRGFyREFGc3dkTjB5OHh4RTZvTC9JbUtCT0M3bTI1SXFT?=
 =?utf-8?B?QWdvN1hkWElEcjhRSkprWHhJelVNTFFqempKUzlMc05PT1FvRWt4MjJEM1VO?=
 =?utf-8?B?NUxRb1JVQWJNTU1Eamc2cTMzMkxMQ09UcytLWExaSUF2TUVCQmxZcUtNSmNM?=
 =?utf-8?B?TVY3YUw4SzFyMDkwNkxnaVZabk9VWFRpRWhqN3c0UzRYY1VqY0FrVnlrcUNm?=
 =?utf-8?B?b2gvWHBPcm1pdS81bHVzRVpLZWs5d0haTWR2NWF0MDh3Q2VBdW0xWnFId1E3?=
 =?utf-8?B?OUZlTkszQTRqcnhPd3AxWnI4VzZkVjhNS3k2SytyTmM4d1I2QXcyR2s5SzJu?=
 =?utf-8?B?RFFKNTBuY2YrTFYyZmpjZVNtZElPMmZpZE1xTkd2MktZQjFwU2tSV1FHcG9t?=
 =?utf-8?B?RSs3Tkw1RGlGczB1akVqeXdQMTBEcHdVaDJ4UUpoR1lidS9KU2pFWnhQMWVW?=
 =?utf-8?B?RkFHWnhKN0V0aE5QWEFkQjNwdCtrYjJHYVhXUDY3ZHpPbGFBRkszOUZCNnBU?=
 =?utf-8?B?RnhPajU1MU1Xc0JzME1MMnhxU1A1NE9VWnNuZkZ1clBsazFaK1lIeTFtNkFR?=
 =?utf-8?B?bzJORWdlUlBSK0dsc2RheXZhVGdVSmNidXpJa1FXNzJyM3hnT2dCMDRVb0gv?=
 =?utf-8?B?T0hkT0JYNGJIcTM1MktVamQ4bHl1MlhRSGh6b2JYbTJVSGtleWNOdk12WFpM?=
 =?utf-8?B?RDFwMldKNy85Z3JRUkdFRWNXdGVjaVR0U3BpTDJqZUEvTTBZbDR6M2Z4Y0Fp?=
 =?utf-8?B?Rk1TVjJrb244bldwQVlXdWlUL0hjQ21mVEMxdzdlTzRnUzhSWTdyNUFRMlYz?=
 =?utf-8?B?NzlnRWVJckpUUlcrVmYzTFIxSjI5Wkh4TTRVejNTeXZYT1IvNjA4ZkxqWTJ4?=
 =?utf-8?B?Q0Y5Z1RrRzA0KzdiWS9LY2ZJT2loNVZqSjUySFBNK1hnb2tBTER5TmRmaGh4?=
 =?utf-8?B?anRJYU1NVC9IWjZiMTNiYVlOalFnTlEzREo5U3dWWEtnNHl1NElBMEhNYkRh?=
 =?utf-8?B?QWFQdnBNVGdPMU5vMDVsV0hJRGltUEFiR3hQNnBZaFJ2SWhUN1VUczh5bnpH?=
 =?utf-8?B?Vzc0SXB0cUNoaEJiTktwa0dRd2JqYXFVT1B2dTBkRFFBVThNekNleXFZb24r?=
 =?utf-8?B?SDNVTE91M0RFa1MwRmNNY01TTG5IVjhtYytaUnBqckhjNEluK2t3SlNwWkoy?=
 =?utf-8?B?a1MrY1Z4L1BJQjBwSG55SXNEajRMQm1SSjFnZjIrWEhWNkJXa1NaQmtPaGJ1?=
 =?utf-8?B?L2diWU5Oc2QrcXI5ckFGeXlsVGpRcWd5QlZLUG9oZ3BWNjQvMXk4TmNBRUNa?=
 =?utf-8?B?R1FYei9uNXl1RE5zcUFyckFuWlZFdFdEaExGSW96NnprTXJlWlJMU3RpdFdE?=
 =?utf-8?B?OW9NWW5wb0R1YlRIVG5HZEV5SnB0OVhOdHJENFVWTWZMdzYydGtnNWdJaG1K?=
 =?utf-8?B?anFnd2FLd0pCaUNvcERoQkRBbmtSeHh1Q21TZlp4MXlncmlGZ1k2LzBNSDB0?=
 =?utf-8?B?M1lpbFVqaDFPZlB4NU9PRjNsVlB0a2dlWjh5eXZyV1NQVlRDOThLdnFMWHl0?=
 =?utf-8?B?dGg3VFJEbmx3QlBwR29NOTNnbysvWXJMWERET0orSmVOcWxQU1VlN2F5cjN2?=
 =?utf-8?B?N3o3b0I5VmcrRHRxZ2RGekdyZkMwMmE0Y0hhR3RFTGkzZWRpMi9qMXh1MlBi?=
 =?utf-8?B?MXg1SWpXRmxlTU1SMm9UaC96aGQ5ZWdRSGJyR09WS2V1Zys1djl0Y01rZnBq?=
 =?utf-8?B?WmF0eFlCMW5NK0dCQWVtS3E1eGRnN2pURnVjRzVOclh4Tk9HSlFJN2l6UDhJ?=
 =?utf-8?B?b2ZTTjRYakNhd3lSRHBaN3NaejNsKzE3L0puTm5weTBmL1NlN1dFelUwVnZJ?=
 =?utf-8?B?enVOaWlZNkZraHMvL3B5N1AxMGFaa3BIT0Uxc3R5RmpXazYwR3MwWnJDWW1R?=
 =?utf-8?Q?iWljzDYNz/5dRH6NwVKd0cal3K0+w1RvMuETFIro3kfPV?=
x-ms-exchange-antispam-messagedata-1: 6oBLrF+/DSLLBPRdZvXRczCxyYzFeHHIWVQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3F8F7B3D389AA48A6215C22237B4FB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CVND/1dXRVCUQd0s/fIwzU9EyJFKPHB521SemY3gNQzrv+yPNThIHmQJF03QxT2wLs+CPnkw2qj/gKf1Sp438vyMUKTVGW9RgdZ0b8E6gFyhg8RqxCvy11mGq16RnNhk7eXpTDfS/79fAiZ59/uBK8TJ6oF3yXLQuFyS+oZtmLizgYUJbHnT0YfwMLggSU/jDotri3Df/3WX+wnehMYqsJMEmQwcK37F1LJzYqw16u8CmrFLS0XQaNhsoIKedVI0GoFTyTE8/z/IJ5EOWkNpyeMLnv1IaOd8i0xYg7MIbJeB9Mu2ndPuk4jAZDPlKf29da1SNUQIt6LvMlGS9dBguA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wA12pnX5WGxvhcJqPSE52NpcCTXmVfClyIhzCE+MKw6bhgPaYFBuRQ/emRrg8I4OwVNocm86N8mzyTijBIxWmGVlBesiI8+u8sUW+SGB9uLG35poN8In3tRnUk8YlO4ZFdCti11hNAZocS+Dne3Tsln3FJiDlftGfFCv8Oh3zwfkoBYPy4i39V0kdIRR0ylBtUgu04JRG2r9UOPLtzmBTchJj5kRA3Tdrej4j5HjDk6IrlEEyPm25q2mewG57ych6ZnTzI/YUb3vxOkGpD4ss7TsbJFV9yK8GlLPDofJJXNJmTj3qwK/6wESwdVAtvyo0u8UOmmppcrzLvckWnf4cZ+6blyg4AReRVCBv4LaCtYsmP1oZD1h2lGaPkJVte6CL3k95NiaKghIZpTik8zhTNBODW16melf0Vbm+yKTEeSJT/PIGhRfJulUhB/218RjarxZtPlAbXyiMBwuSi7BqkECn1Vl0sd2rAFokE7l5GESommL5qKR1IQHX/0mjCnthKw4T5xMqJbMSMtdFXFHCDyk7Os//dho1cuubmf4uIcUA2ymCK/aVPogLr5dGd9ev8BvwUfmS6jabvIDbT8c4NnN1Ogp11G0IaLFW7QVOaDtGrJyyYulBYwg8u6GrMTO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedca0cb-547b-4eb0-5771-08df07e3dda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 04:45:36.7296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQxe7P2M9nT72UkJ62Dj83+q7zrdW6hrkArw1gzv3QGsNZNEiRs1YBYS4aBp8jjq0y4V4njJL6nQ+nCPJrp+uzI5E5zvMe4zXmD3JIYnYKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7310
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWRkIGEgY29tbW9uIGhlbHBlciB0byBjcmVhdGUgYSBjZmktZmxhc2ggY29t
cGF0aWJsZSBmbGFzaCBzdWJub2RlLg0KPiANCj4gVGhpcyBjaGFuZ2Ugb25seSBhZmZlY3RzIHRo
ZSBleGlzdGluZyAndmlydCcgYm9hcmQgZm9yIG5vdyBidXQgaXQNCj4gd2lsbA0KPiBiZSB1c2Vk
IGJ5IHRoZSBmdXR1cmUgJ3Jpc2N2LXNlcnZlci1yZWYnIGJvYXJkIGluIHRoZSBmdXR1cmUuDQo+
IA0KPiBObyBGRFQgY2hhbmdlcyBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0K
PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNv
bW0uY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1QHByb2Nlc3NtaXNzaW9u
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBody9yaXNjdi9mZHQtY29tbW9uLmPC
oMKgwqDCoMKgwqDCoMKgIHwgMTIgKysrKysrKysrKysrDQo+IMKgaHcvcmlzY3YvdmlydC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrLS0tLS0tLS0tLS0tLS0tLQ0KPiDCoGlu
Y2x1ZGUvaHcvcmlzY3YvZmR0LWNvbW1vbi5oIHzCoCAxICsNCj4gwqAzIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3
L3Jpc2N2L2ZkdC1jb21tb24uYyBiL2h3L3Jpc2N2L2ZkdC1jb21tb24uYw0KPiBpbmRleCAzYThk
YTAzY2ZiLi42ZmNjMWNlMjFmIDEwMDY0NA0KPiAtLS0gYS9ody9yaXNjdi9mZHQtY29tbW9uLmMN
Cj4gKysrIGIvaHcvcmlzY3YvZmR0LWNvbW1vbi5jDQo+IEBAIC0yODMsMyArMjgzLDE1IEBAIHZv
aWQgcmlzY3ZfcG11X2dlbmVyYXRlX2ZkdF9ub2RlKHZvaWQgKmZkdCwNCj4gdWludDMyX3QgY21h
c2ssIGNoYXIgKnBtdV9uYW1lKQ0KPiDCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcChmZHQsIHBtdV9u
YW1lLCAicmlzY3YsZXZlbnQtdG8tbWhwbWNvdW50ZXJzIiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZHRfZXZlbnRfY3RyX21hcCwgc2l6ZW9mKGZkdF9ldmVu
dF9jdHJfbWFwKSk7DQo+IMKgfQ0KPiArDQo+ICt2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfZmxhc2go
dm9pZCAqZmR0LCBod2FkZHIgZmxhc2hiYXNlLCBod2FkZHINCj4gZmxhc2hzaXplKQ0KPiArew0K
PiArwqDCoMKgIGdfYXV0b2ZyZWUgY2hhciAqbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL2ZsYXNo
QCUiIFBSSXg2NCwNCj4gZmxhc2hiYXNlKTsNCj4gKw0KPiArwqDCoMKgIHFlbXVfZmR0X2FkZF9z
dWJub2RlKGZkdCwgbmFtZSk7DQo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0
LCBuYW1lLCAiY29tcGF0aWJsZSIsICJjZmktZmxhc2giKTsNCj4gK8KgwqDCoCBxZW11X2ZkdF9z
ZXRwcm9wX3NpemVkX2NlbGxzKGZkdCwgbmFtZSwgInJlZyIsDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIsIGZsYXNo
YmFzZSwgMiwgZmxhc2hzaXplLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyLCBmbGFzaGJhc2UgKyBmbGFzaHNpemUs
IDIsDQo+IGZsYXNoc2l6ZSk7DQo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwg
bmFtZSwgImJhbmstd2lkdGgiLCA0KTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3Zp
cnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBpbmRleCBiNzk2MjIwZmMyLi5lNDgzMzdkZmQ5IDEw
MDY0NA0KPiAtLS0gYS9ody9yaXNjdi92aXJ0LmMNCj4gKysrIGIvaHcvcmlzY3YvdmlydC5jDQo+
IEBAIC04NjcsMjEgKzg2Nyw2IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfcnRjKFJJU0NWVmly
dFN0YXRlICpzLA0KPiDCoMKgwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIHZvaWQgY3Jl
YXRlX2ZkdF9mbGFzaChSSVNDVlZpcnRTdGF0ZSAqcykNCj4gLXsNCj4gLcKgwqDCoCBNYWNoaW5l
U3RhdGUgKm1zID0gTUFDSElORShzKTsNCj4gLcKgwqDCoCBod2FkZHIgZmxhc2hzaXplID0gcy0+
bWVtbWFwW1ZJUlRfRkxBU0hdLnNpemUgLyAyOw0KPiAtwqDCoMKgIGh3YWRkciBmbGFzaGJhc2Ug
PSBzLT5tZW1tYXBbVklSVF9GTEFTSF0uYmFzZTsNCj4gLcKgwqDCoCBnX2F1dG9mcmVlIGNoYXIg
Km5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9mbGFzaEAlIiBQUkl4NjQsDQo+IGZsYXNoYmFzZSk7
DQo+IC0NCj4gLcKgwqDCoCBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBuYW1lKTsNCj4g
LcKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+ZmR0LCBuYW1lLCAiY29tcGF0aWJs
ZSIsICJjZmktDQo+IGZsYXNoIik7DQo+IC3CoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zaXplZF9j
ZWxscyhtcy0+ZmR0LCBuYW1lLCAicmVnIiwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMiwgZmxhc2hiYXNlLCAyLCBm
bGFzaHNpemUsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIsIGZsYXNoYmFzZSArIGZsYXNoc2l6ZSwgMiwNCj4gZmxh
c2hzaXplKTsNCj4gLcKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX2NlbGwobXMtPmZkdCwgbmFtZSwg
ImJhbmstd2lkdGgiLCA0KTsNCj4gLX0NCj4gLQ0KPiDCoHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRf
ZndfY2ZnKFJJU0NWVmlydFN0YXRlICpzKQ0KPiDCoHsNCj4gwqDCoMKgwqAgTWFjaGluZVN0YXRl
ICptcyA9IE1BQ0hJTkUocyk7DQo+IEBAIC0xMDQzLDcgKzEwMjgsOCBAQCBzdGF0aWMgdm9pZCBj
cmVhdGVfZmR0KFJJU0NWVmlydFN0YXRlICpzKQ0KPiDCoA0KPiDCoMKgwqDCoCBxZW11X2ZkdF9h
ZGRfc3Vibm9kZShtcy0+ZmR0LCAiL2FsaWFzZXMiKTsNCj4gwqANCj4gLcKgwqDCoCBjcmVhdGVf
ZmR0X2ZsYXNoKHMpOw0KPiArwqDCoMKgIHJpc2N2X2NyZWF0ZV9mZHRfZmxhc2gobXMtPmZkdCwg
cy0+bWVtbWFwW1ZJUlRfRkxBU0hdLmJhc2UsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1lbW1hcFtWSVJUX0ZMQVNIXS5zaXplIC8g
Mik7DQo+IMKgwqDCoMKgIGNyZWF0ZV9mZHRfZndfY2ZnKHMpOw0KPiDCoMKgwqDCoCBjcmVhdGVf
ZmR0X3BtdShzKTsNCj4gwqB9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1j
b21tb24uaCBiL2luY2x1ZGUvaHcvcmlzY3YvZmR0LQ0KPiBjb21tb24uaA0KPiBpbmRleCAzNzE5
NzFkNzlkLi5iNDIyZGE2YWVmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1j
b21tb24uaA0KPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaA0KPiBAQCAtMzgs
NCArMzgsNSBAQCB2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfcGxpYyh2b2lkICpmZHQsIGh3YWRkciBh
ZGRyLA0KPiB1aW50NjRfdCBzaXplLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgY2VsbHNfc2l6ZSwgdWludDMyX3QNCj4g
bmRldl9zb3VyY2VzLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYm9vbCBudW1hX2VuYWJsZWQsIGludCBzb2NrZXQpOw0KPiDCoHZvaWQg
cmlzY3ZfcG11X2dlbmVyYXRlX2ZkdF9ub2RlKHZvaWQgKmZkdCwgdWludDMyX3QgY21hc2ssIGNo
YXINCj4gKnBtdV9uYW1lKTsNCj4gK3ZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF9mbGFzaCh2b2lkICpm
ZHQsIGh3YWRkciBmbGFzaGJhc2UsIGh3YWRkcg0KPiBmbGFzaHNpemUpOw0KPiDCoCNlbmRpZg0K

