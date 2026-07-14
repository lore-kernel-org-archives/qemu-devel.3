Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48CC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbyO-0002zZ-7i; Tue, 14 Jul 2026 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien@nus.edu.sg>)
 id 1wjWCo-0007LZ-VY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:01:23 -0400
Received: from repost01.tmes.trendmicro.com ([18.208.22.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien@nus.edu.sg>)
 id 1wjWCm-00006a-3R
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:01:22 -0400
Received: from 40.93.129.121_.trendmicro.com (unknown [192.168.163.165])
 by repost01.tmes.trendmicro.com (Postfix) with SMTP id 048BE10000680;
 Tue, 14 Jul 2026 06:01:17 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1784008875.927000
X-TM-MAIL-UUID: b444e394-ee04-4cf5-a40a-20e61c5cc800
Received: from SI4PR04CU002.outbound.protection.outlook.com (unknown
 [40.93.129.121])
 by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id
 E2A05C03096C; Tue, 14 Jul 2026 06:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL+1L8St+vzzrUZVfCg9rF6w0gBzpSJszx9+gEd+reD3iG+CHP0H8WSy+seu3NWCW8tfBN5/46RHR8bJvYyAW9JN8ZbejiYX9lHfnyGUADeHr+q28NTxFcmU8LY+dlkFsEjmuNXREejC/fgxkmEwAnPt3Yv3g1lCtzr6lKdwy+S2zx08MmSJC0MHfuXN0Z3bf+aNIE14bwfUMmCOC0SdWJrRZktyOCXfNFVJBVWvqgma+NtR8td0J9pOsr8YLii6LI/fLUSZRd+OTxH4/jH1trD0yjHhPnqPnWLRdDZNS+zgamzbRBdsROO+uBTiJ/42BmFTL5Bpya9ixjn+1HjkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmKhGHH8HG7Ym9jhD8IfmITBpQsrT6sV3x/SjHwADek=;
 b=HS0eQ2i8MRlRbELcsaWl7WuU8w1o+9wdKuruD0LQYIdQVKvWpF11Jb1Q7gvagBu7za2QXt2oXCALFpAJXkx4elFFHzvzCBkH/Cmiivhmz1D126RTuPU+lzxBtll3PZg8aiE/GD4shFuOI9Jb9Axjrf1rXUv7NI1FCS36vTPJpkhcQwwwBAkDMLIh6tlWljXe5rjDr+o95f/IAIaX/LhJRTEp4Qwl0cw1sTSJ1lKxiEqfUzOC5vWCvT6eENjI83cy7oCS5D2AQmeGZNuSAOlxd4afKL/aw4CzNiHxMsYPhntn/NTB0bCbdNYfEyAoOEzuvNMsXzJR9V/p1MA5OtZBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nus.edu.sg; dmarc=pass action=none header.from=nus.edu.sg;
 dkim=pass header.d=nus.edu.sg; arc=none
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 (2603:1096:820:a9::10) by SG2PR06MB4985.apcprd06.prod.outlook.com
 (2603:1096:4:1b5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 06:01:12 +0000
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0]) by KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0%4]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 06:01:12 +0000
From: Flavien Solt <flavien@nus.edu.sg>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: [PATCH] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
Thread-Topic: [PATCH] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
Thread-Index: AQHdE1X0Ny5I5jAFm0auxbl8rqlMsQ==
Date: Tue, 14 Jul 2026 06:01:12 +0000
Message-ID: <KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92@KL1PR0601MB4874.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nus.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4874:EE_|SG2PR06MB4985:EE_
x-ms-office365-filtering-correlation-id: 0a004d4d-9cb0-423a-b490-08dee16d4f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7093399015|376014|366016|41320700013|786006|1800799024|38070700021|56012099006|6133799003|8096899003|18002099003;
x-microsoft-antispam-message-info: 9n/E5M1KTisOty/6PCfG9IixldBsLtxgizHWfUdJ5o6DLWmhgoXE/pg5daN9defOIiJ21tEF0cF2YL+YUDsaumUbEMcapS9iyp5DwN3rkMMbE5Nss2fssTmwsGQVyBItbaeS8EbChpndLWqTwT5sUbPmPJwUi5d9GIGoCIhwBBqngVXS99dJQ42M+LixkX1QDCNgLEMzEpaC0YH99hAcj9ZRQHu77x0xEdTJIr92oHkF3rR9u6zCwTendkK9TjRf+4SrfTDSiyFBifkkdm/QytMvjB1Ta4D6F/GB6FNEOPVv4PxEi6DnRKH3gO+WhpSieejln+LVlxjlrBVhj9PSpvAbOWClBitKm+7mAYRsA9A8EVE04nq5+GSx4vc5Cny3tSofoiOu9PGt5OZY7o0dC5aLcoVXph7bLXs0feK5oML0YNjZJNVYfaSwTwb97XzIBFVgcbzpJMrxHwiV5a4wkbnxSdO9rVAzywULjVm8oQ5VB6tbNj+NVpNXrHi4sHtmKJi+3C4fdF5d9/g0qhetE32Y90htAngWYeCaVdcLL7/3zMkb2R31jZmb7vYvwUxefuDbvRO7GalIaszWuTXR/6USB0l5MlLkviQUfoGzAETlsv/QbYQRzr6NT05uD+2mxLqecnzOer8hAXY9bPPPeaBP26QbwBc3dO2QzH7q6rlkv9q50N9iSLAk2fluR7YCRdQ5RccVCSj+bT3ruauoMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4874.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7093399015)(376014)(366016)(41320700013)(786006)(1800799024)(38070700021)(56012099006)(6133799003)(8096899003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hsx1vl0L0aXSxNXATYf/KNFrD4VLovpwkC5ZmlxQz4DC12oCl/TUX4tgvB?=
 =?iso-8859-1?Q?U1Aira4/yX4fL5JWRbU6fxOqEymHghPlxJs7VzcSCPQ/z74mkV5vJMzi+8?=
 =?iso-8859-1?Q?pLd+0pCEf8brUy4Rr8hYPbLkqsDnbr0D+WgrZ8GRoSqXCthnBcdnY5wNYx?=
 =?iso-8859-1?Q?UGTFDRjZ9jV4m46JnOAMrDq/6jaxu06FlYSa+HfAO+KLMr4OLxSARUnJkf?=
 =?iso-8859-1?Q?XXuUx0YE1GMj0LMERdhCN3ggSR/DfVn/yC8BeuxQC29cfCRsAhI65voDsP?=
 =?iso-8859-1?Q?xem0wseQ1VWJWpO71XBEstePouldaHGwCHM/j7USbzN4dFvUGUSSygi+J2?=
 =?iso-8859-1?Q?+miz8wtESBg7jRpcDfPl+s1GeQ30/iczGS+RX05o91veC844lI/cQyQSi3?=
 =?iso-8859-1?Q?dTZAwW1JPMeLxCUhoM9Ptlb1TvRChMNYNMzevdpedke+oxXnJAF0IVSfHU?=
 =?iso-8859-1?Q?bBumZNfBOv8BkLw/xTkH7+usmTWyVBQ/f13ebsgDI1bE47zVC8p1axbPXh?=
 =?iso-8859-1?Q?wRlGClEuai/2eknEBniRqbEPyX/4XJRa12LVG49AaK9nBCuLeP/xNEYAyB?=
 =?iso-8859-1?Q?xMxNxnwlE2qaDfXFRfvMftvsABxqHJF5ciqM33J8/Boe3OTwKEk21Nc1Ya?=
 =?iso-8859-1?Q?5TtTKYRew4x0fBdAHb6DRPwPLffIYuvgmAxb4+RFuXehjaSt2eMHaObNSg?=
 =?iso-8859-1?Q?0XX6u+YppKF8x8PbSWnhPAVxc00HTFoQY8+5aitLDafjMZv7sn2WiQcgSL?=
 =?iso-8859-1?Q?zkNPPYvpeSsNLzHxB1UCavNM+/cr2bXVUnEVZlhis1jEy6UwsNoIjx1mTL?=
 =?iso-8859-1?Q?aGsqQSkmBv8t/YSGVmlebKGSrgMtHD/i/+H1YdtQOhhxSVz+VmtYB1B3YE?=
 =?iso-8859-1?Q?W3Uc1/QxAM8dpBm9SBw0nk1a/+oPGpuh0Cp0srJcTsTxxKPDhB7MHfDdWT?=
 =?iso-8859-1?Q?jtxsAdPUPVCE/zXBXQo+IRFGZapO1YPVzn7nAIbepzvsVtawSrig1CHqTY?=
 =?iso-8859-1?Q?1yEK5+JAq4de8O8EFaa7opvhAg1gUdiMhxaj8ydVvrn66o/j5/LUlxaWgg?=
 =?iso-8859-1?Q?hf3dHwh5D+W1dzOu6a818cmga8h3Q2vykhXuWuGKpN5TE0EijoZcVooulh?=
 =?iso-8859-1?Q?TwJ2fBlceC1/ji1ppcHkLtrsSa6eMuIEGEtj5j+tuuOyoXyLsHaojhWnCO?=
 =?iso-8859-1?Q?a1OnLsWOOZZDlvr3yBzRQY/JihuX/tIXnWj6TCjMC8NphWUr/8qDTv49OC?=
 =?iso-8859-1?Q?V4o8AC2nBl1mET9uHP/G/9/c4Pmqi5nJnpzR2BgfO7dEFKyAMSvlM5nuHC?=
 =?iso-8859-1?Q?IeX4grRE9g20wXn5Xpv+AmkvyWNYfJiTcj/JN51iWxrSpx3+tZS1tJBn2m?=
 =?iso-8859-1?Q?ktvmeESbRc1BJc+tjEknOJfbbz8jd8WkpjJOetELrSPydElwAvxihBDCnw?=
 =?iso-8859-1?Q?r96GGNpCCSmpGX6M6wq0iSrSmrTiopwnfCGR6gXgI+H4AcFLOTjpsZ78Uj?=
 =?iso-8859-1?Q?C/NeCqlrlI/EIMAwMPA8ym1e5YDYKt+N0xf9f9XV5pqdBtav1B4Kzv6r76?=
 =?iso-8859-1?Q?bT16OUgdxGLLNqdUVmBWgZXG2AwCvkNQk18qVGonVAl5hjomDwqgKT3ZYj?=
 =?iso-8859-1?Q?XSd9UReYHv9hYOLJp2qkWOSzXoeFrK3ek9hTeIlGJNkzEoRMIUsgksNBxL?=
 =?iso-8859-1?Q?AqJvnN66dF/nsrqUfmq+SGDs3e3mrtIvLkTyXJQTPfySheK8SNBlIfFt70?=
 =?iso-8859-1?Q?awxrF4axdJhpnnyejXlA4QTPEG0Nz8wJ/vKKWdOm6YIDC0?=
Content-Type: multipart/alternative;
 boundary="_000_KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92KL1PR0601MB4874_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: re4Qz0YKWPXMnc8OPxapzBC0EYbedzKvC7dRATltgxBsG5NS2J4qEyQyJYPB2V1xu0jm+QSu7yD9nF69XOT+GCtde+uPpC1L29eNqP5k5uF3pHV88igpXY199rOaPBS4wqJYNSrZu4T6Sr0Qa9n5ynEUa+5427OT2kT1ARYsQKjCU2ZzKWJb9fdm3THbCe17PQElgq8n+Wa5rZmK+i1McsV8sIEP/Jn6i3SJE6Jl1bdJS2YKdg5MbdvTBH4S9XwJpfbeWjD3CGnIMjmXu5JAWlVnvXZTtJW/VC/X7pihjiMFtix6S0mcC6N4GjvauwH2KrP/zE1KneYmWk/LrIK8xA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AbC8M4mNo0KetdhS0p/RnX9rgpAvxHbqmbYgqN5WpyqmfKoIS81lqIv9g5FuNMc7T/IwX3KQKAaO9nCxANwYXmnnY4f5p7SPOlQxTobMYvx1isT5nSfqL+50GDxMtSNT6rTc81yStjGCUczgAbVMOQztkXzbXeXCXawpyaKeRHeWyax7Cp+GKGnwpeKmNKmV+H6xnJYUiNOygE+euM2OEt+Sn6EJZ4Hhk0Xq9+gL4dmJdKG/0Xf1zfZ4UM1YK3dXih3mX/T1reSfmCGrd3Fq3RcdYMXeebnaWijqI378qvPNiUADBB5uvWbVB7YBjwMQUSWo5UYyz8sPbg8v3uPC0SNd7hwBBepRh41WE1W1k9y4NY+reijrNn67KB9HPj2Y19f2dAxPG9ctICVFPfJF2D3AkgIXjUcTqvbpadl/wlxpsx2KvOWUdHupViIi3jinloetwCDlIdswmOZ30/dZlucV/sHagDNRUiCIHr5kN1Kfy1LlvsXxgQQU/PwQS/TVQzxJslCFQHlATF/qbDEJADdkHknTlZtoDzNJx9BhdxO6Z+KCxrBxmhZMkyWJD5m5TcMjIcPZIz4D4sHh2v/EbrML8qB81Wd/gFPOYqEvUUyUs1MwSUqQTuepxVhSjZKy8DJop5StDC7vBK0Q54RkJA==
X-OriginatorOrg: nus.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4874.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a004d4d-9cb0-423a-b490-08dee16d4f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 06:01:12.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N63ieK9ogaMNUKi8XMfTFK4ZRPyVmDlVCaliUIhzsCIySfE6qX/Q3yv64yIvMmvan/2XsD1LNpsWQHqSIFElEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4985
X-TM-AS-ERS: 40.93.129.121-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30068.005
X-TMASE-Result: 10--78.124200-10.000000
X-TMASE-MatchedRID: DasU2AOz3ZGBbasXMi9E9zMRf3XBDZyYJgIHjJRnWneXYoGYte3R6ibR
 zjExEuTljW+hlTbs2Zy0j0r46R8QAnCeR7rRs+MCCqJ0RbJ3bb3uc70WAkC6Fb2L79/20sYbh21
 EBzIb6ozm9Tc/GgfFJwFtWueZlMH02M53mlQih9ihLKZs1qqHrxJLTjsia/4HJu99YSRm3xQIGO
 h1lQs9UJmWoJDkXBayhariXw9NeqqYOr6+obXGk7NZcSfsHwzCZsBazu632yJdkzEmKKnHIPQYe
 VryLK+kbHzfU5cAg68GelwNxd8kL/o7R1uLMslhsNA365dJC+uWA1ru0lvzJir67/FutmJkUOOs
 c/slMqNEKZlqWQag3rR/n6g6hoGK9najdW2oILxyw08Gxs3a2Aogz2azZIYEdLDerKchReDYmzQ
 vUsD+uZls2tIOEwT7kIMVuDRm2J8kkjF6zUdVf6ygkT7xiVcjyfjF8MS6pxVBRmUI+A4g/CzecB
 j190z12HlzhM3zNtmMGnQxsGJZyeerSjt0aAEbgngGSNsNcycX6nfwyd2cmqMpC85/qWukPimPH
 2/l3P4D/dHyT/Xh7Q==
X-TMASE-XGENCLOUD: 033ef523-b446-4617-b235-a765d10309f3-0-0-200-0
X-TM-Deliver-Signature: 21469FC661D2071C75BFDEF5D67BB66D
X-TM-Addin-Auth: FQmsafOtCkDeWERhf4sVSMumBngml9iMNZwNppJYrgbH/WA6EAy57EtqQgO
 SCDu7GNRJZkIbiiPsY5p4WiE0k/jwe/94nPlJyQvmJfdtKHMi+dwWGiZGuGfb29Mtrid51SiFU+
 6r0tVUcxLt2JZL/9VWqYA1AZ61tK9sLC40mxD+zKzah7q2Mg4JwuhNjFXsky1a3xGvgXBe6LeRP
 dshyzVTD2tATT6aTYv4wFdL9ii/wN7FchFwG6jjN3unBnBV7p/qWOY7CxLakF8bIp83AsNjIupj
 ZURbLVemHaEses9a/aozSFBO9tSJLpp/QdX9P5N7UvO0g7caAZ9+KuIkAOs/98kATes8TxO3x4j
 Jv/M=.QxVZGgxch40lLwFso4W8RNXxMrkeuSk9m7qZ59aRyDyQoEjiCk/C+nxT3B7BnkOnp02KU
 TJExtK5RMvkdO7vVf07Rbz+AHwahMtH3zhzzduFj7CVaRj/GdWHl/Y/eUfJYu0jjG0KzULzYtIG
 AbHGWW0S2MBf1nEpah66aopHw7OQGpfZdteTSnvl4Lf1TeOVKzq9eVqgsWUqjaVQNe1/6f5s0zp
 8McCuRsSeuO5gTq97fV1LsuN67PuUpYDtXRsNRUIEH3RcOqFoD5XFp5tuIOgQf1TNzgHJOtYSMP
 VrYkS3o0Ts72z/4vfpGRWJFcbVmCEMBtLkWWCEsnjvmqxvpA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nus.edu.sg;
 s=TM-DKIM-20240902111054; t=1784008876;
 bh=2WDFDLJIS+xbmpcUz3zPKucEAiQhulKpnYuSU4YMAJA=; l=10840;
 h=From:To:Date;
 b=CXcKTvRFQ2sAsQrEPm+rWQ9A5hJQwtrjXC+DzAPxKjaFKlNs2rQGIMRTuFtDhpHHC
 C0C5BqcWNYjhPT9fRVLfbDWVJGO1FRugEraQf0P0PWYe/kMOG0ckFZe6sXPHgWWcjc
 fu94+/OjTXTd14uUe84acCIxYfUnut5PGPb45cVj3HGqfsC4/nH0xqxfM0BA6WnUH0
 wAFjdnuM89DWo2tWzSvp5eISkx3CHF4ekrIhVl5rIDzBWB1H75hJ56B0R21mkDaDTZ
 ct8xlnJPHkSPL5rWSku4uUdD5L1hrcVqq6B9gndhuerwaKUi7Skpab8tV8il4RjSfL
 6mtLvTGvj7lXg==
Received-SPF: pass client-ip=18.208.22.155; envelope-from=flavien@nus.edu.sg;
 helo=repost01.tmes.trendmicro.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:10:46 -0400
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

--_000_KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92KL1PR0601MB4874_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The AIA specification requires an IOMMU to send the configured notice MSI a=
fter storing an MSI to an MRIF even when the corresponding interrupt-enable=
 bit is clear. The problem is that riscv_iommu_msi_write() currently reads =
the MRIF interrupt-enable doubleword and suppresses the notice MSI when the=
 bit is zero.

This patch removes the enable-word read and always sends the notice MSI aft=
er updating the MRIF pending bit.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Flavien Solt <flavien@nus.edu.sg>
---
Tested with a deterministic qtest using qemu-system-riscv64.

After this patch we get:
  enable=3D0: pending=3D0x20 notice=3D0x12d
  enable=3D1: pending=3D0x20 notice=3D0x12d

 hw/riscv/riscv-iommu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1..9627cab 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -788,20 +788,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUSta=
te *s,
         goto err;
     }

-    /* Get MRIF enable bits */
-    addr =3D addr + sizeof(intn);
-    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs=
);
-    if (res !=3D MEMTX_OK) {
-        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
-        goto err;
-    }
-
-    if (!(intn & data)) {
-        /* notification disabled, MRIF update completed. */
-        return MEMTX_OK;
-    }
-
-    /* Send notification message */
     addr =3D PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
     n190 =3D get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
           (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);

base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
--
2.54.0


________________________________

Important: This email is confidential and may be privileged. If you are not=
 the intended recipient, please delete it and notify us immediately; you sh=
ould not copy or use it for any purpose, nor disclose its contents to any o=
ther person. Thank you.

--_000_KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92KL1PR0601MB4874_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
The AIA specification requires an IOMMU to send the configured notice MSI a=
fter storing an MSI to an MRIF even when the corresponding interrupt-enable=
 bit is clear. The problem is that riscv_iommu_msi_write() currently reads =
the MRIF interrupt-enable doubleword
 and suppresses the notice MSI when the bit is zero.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
This patch removes the enable-word read and always sends the notice MSI aft=
er updating the MRIF pending bit.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Fixes: 0c54acb8243d (&quot;hw/riscv: add RISC-V IOMMU base emulation&quot;)=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Cc: qemu-stable@nongnu.org</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Signed-off-by: Flavien Solt &lt;flavien@nus.edu.sg&gt;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
---</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Tested with a deterministic qtest using qemu-system-riscv64.</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
After this patch we get:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; enable=3D0: pending=3D0x20 notice=3D0x12d</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; enable=3D1: pending=3D0x20 notice=3D0x12d</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;hw/riscv/riscv-iommu.c | 15 +--------------</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;1 file changed, 1 insertion(+), 14 deletions(-)</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
index f6865d1..9627cab 100644</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--- a/hw/riscv/riscv-iommu.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
+++ b/hw/riscv/riscv-iommu.c</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
@@ -788,20 +788,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUSta=
te *s,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto err;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;/* Get MRIF enable bits */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;addr =3D addr + sizeof(intn);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;res =3D dma_memory_read(s-&gt;target_as, addr, &amp;intn, si=
zeof(intn), attrs);</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;if (res !=3D MEMTX_OK) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp;cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp;goto err;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
-</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;if (!(intn &amp; data)) {</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp;/* notification disabled, MRIF update complete=
d. */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp; &nbsp; &nbsp;return MEMTX_OK;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;}</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
-</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;/* Send notification message */</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;addr =3D PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRI=
F_NPPN));</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;n190 =3D get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |<=
/div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(get_field(pte[1], RISCV_IOMMU_MSI=
_MRIF_NID_MSB) &lt;&lt; 10);</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
--&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
2.54.0</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"1"><br>
Important: This email is confidential and may be privileged. If you are not=
 the intended recipient, please delete it and notify us immediately; you sh=
ould not copy or use it for any purpose, nor disclose its contents to any o=
ther person. Thank you.<br>
</font>
</body>
</html>

--_000_KL1PR0601MB4874F12178F49F9BB8BEA7DF8DF92KL1PR0601MB4874_--


