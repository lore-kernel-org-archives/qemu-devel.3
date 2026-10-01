Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E5CA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5yz-0007dI-Dz; Wed, 30 Sep 2026 21:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5yw-0007cv-4E; Wed, 30 Sep 2026 21:53:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5yu-0007uA-1C; Wed, 30 Sep 2026 21:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819587; x=1822355587;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=i81zX+Wks+prhM6Eoh6jw+2CuQzJ3T94rWg3Rl3u6zk=;
 b=OPBemToFbDG3WN9jxsYao8UaUiBKheOXDp06CPl2+WkBnINDlt68VJf9
 2wWS+cOmtnEaQDJ0bKejmC3ukiWYPXkg0D4/LkR6r6Um6uRtxwEe29O84
 LDNcGk1OFCp54xVsJ1xdgQHx5chNLzOSPqwBIrT5DBfWS1lL3rJ6p+PLN
 EkuC7FaE/ITttmF/BQ8fhIU6evECX/r7qms1fyUIuUDP7bVdwomiphgr5
 GMq80juRadE00UdmkpI+OLJMDX+D2zqVd/YDQBgNz8ePtYKQ8ovoJp/BG
 wXpUsjWN4NifiuAdmb5ObYIh9VvXDa+na/IIX9nWtmzgJOfVlCK5n1iN7 w==;
X-CSE-ConnectionGUID: ICvGCa1ETGOBRNGMTp5tkg==
X-CSE-MsgGUID: Wu7RFJBqTmWBeDGbHsVHtg==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="155393576"
Received: from mail-westus3azon11010055.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.55])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:53:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEBXnSOLKWktqQEIPd/nY1LFAdSS5UiN0UF6xJDLOyvFd1hCQjUIz9Uwr1Aqv42ekUdLKrpnUDZJJHMtiWRrnJ37oJgOtFDxwmRvC/4TF5zHKIR6yczMb+/xaE44z/VdUyPzw/Qf7nnEK88xYBqgqbusjUFVfdsDNePdCgqOq6KahuJpCBqx8/OXkGRwgfQyqEjxT0x2q+r8ObooU0DNW/y2/XKjSCYFO8vRC2QaCMJSSb1L4DEFW3M0ZE2YA59YCUjJrPjqbp22CGn+gEnYH/Y+hXxo4xwXZjIyP2UMJyykJKttAiOOKpvNsLnDAjy9fZaXL3yywNaj74JcTrevng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i81zX+Wks+prhM6Eoh6jw+2CuQzJ3T94rWg3Rl3u6zk=;
 b=ofBAap/lNLGpKSYiSMAygGQeYR612XjjUj2v3TJ/p7Xmaa2/tFZzKohwE22dxvLW/+clii24qIYhKPIcsqUcPclFK6BmvggHAfaTtBMrt6WCCNl8rFSNWGONBGqKl6fnT6xIxjpa25Susx/x7dadI3qksJ+MZ8b/ZeE1qzn8V4w93+ClSmACG0aMj6WlcGk6KOqv7JxTquQQeke9pnEqwYIjlTRUBZZS2n9vY3485z8Vod/tXvpnJQ44SV183L17KdHvXgpNYrumAkxDtGWawqSBGnBp5EXGXLXo90OmVO/iD04lSU10bR6gJXWlwE9tH/dKsx2METgSpsVCzKrd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i81zX+Wks+prhM6Eoh6jw+2CuQzJ3T94rWg3Rl3u6zk=;
 b=fibPkrRGc8krLxAXe9b30EKhygEpNMrJldHaMS1FFWG3OcdKI+87yl/AdDl/nHjsIQC+GQZP1ZrmJLP65b6BiKwq5BXibc+VdsVEWAksNpDR5mHMDefBBJHY0aY8ZwW+WIJLyOg6jU+az88hc4Md656RKqlOD6mtLP+i5Mgivtg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7811.namprd04.prod.outlook.com (2603:10b6:5:35e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:53:04 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:53:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 5/7] target/riscv: Add riscv_cpu_get_mip()
Thread-Topic: [PATCH v4 5/7] target/riscv: Add riscv_cpu_get_mip()
Thread-Index: AQHdUQOKpy7MD8EhQkSwWxA8FIxIPrbn7SmA
Date: Thu, 1 Oct 2026 01:53:03 +0000
Message-ID: <9e8c129e91ca6eb0c4c2ecd9dbc8a919eda36a52.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-6-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-6-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7811:EE_
x-ms-office365-filtering-correlation-id: 4c259f1d-283b-4ee1-d3db-08df1f5ebb56
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: P6vXFx/WerMVWBHBacKbNmTuejLdzotPnsflgpqZlMvvk+IVfAlgA3f06/I2Fu915n00Zpeo83+DErT6Q5tZ4k7+M0jC73nOvqc/g5gmHEL97Ev6uWVEDUtxXnf0NJxH6gAIZjSO2E5bqDZmoKgj9wOtUChGLQYOxrb2A3EiCGuE2NHofpP/8cZ2+5f10EGc7PY9oYWffRloWY8CMH6g6xJiPH0jcP1oYg73olP6X2R0MPFKN27czg6kWZm+lBgWVnDIyNBfhiYhftj/78hL/Py5YjSILB5LjIl3fyLWzm6ERHvSC10ZbWwRjXy+YwKLv4r6AE7SBBKtnrYgmsY3wZ2/arx3O3DA8NAqbC7YvmjWFTumD/LQmDujS6T+sZbTKAvCtxW6gQiBs9S+g3RB/WfYLLx0PMiqOsO2lYcVD/34PAyVYZgSTrJdS6a9VCnbxWJ9Ahjt0h68teunDj2qT+kisVBGoD+bddnGt/PNV0v1izP0v74VgrX/v58k47bWnDbBq9SuYm7InHJxdPpmB5ZnGy5O2kkyAWTNaomt5nByYVLKZMCJdDUI8CDDypFs9Jz69fB2IwtgHra7NXEeiTVlMqwX0hkX0dBOgSW9N+P6H5CQO4aCD3ZWu34AeQqDIvqIP1KeTMPrn/WXU7BT7SFNEboHKeMjHa9csMa1w8iiHGEP49rkP0HGiE5bn4jpEjTM5E6o6vyRbgk8V4IiGVG/V6/Z30W8I4q5x1dNeiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGZLbFRUcFVLd2E0Q25GYURiOXY5RE5kUjVOekg3Qm9FNDQ2eVBPYXhVYXJB?=
 =?utf-8?B?c0NvSTJIRHZkb3BFdkpXZlcycDR3TVp6c3NoWFpRck5EWEdITjhFZU03WXdY?=
 =?utf-8?B?dEs3TWJ2MjBUQjRmcGJ5TXI5bjI4ZERtay9ROXB0QkwxdkRJYmU1b2dCVGJH?=
 =?utf-8?B?cHo0WVU1ajBSUWJCQlF5LzV5ckdRM1ZrakRDNW5qK0JQcWl5NStXYm1ybDFE?=
 =?utf-8?B?WXlVTUFQaU1EdkdtM1lMSDEzdWF1emZWN29rNE41ZTM5bExva3Y4U1QyNGxZ?=
 =?utf-8?B?ZW9WM0tBT1VLVmlNOHJ6d0NHaHEwOHZuUWVxOHRkQy9VK0NDU3RmNURvWmEv?=
 =?utf-8?B?TmN0dnlDVm1Ub0RyZE1jcjBFQVdtamhpK1ladVR5T05Ha3M2RkJmRTJHZGph?=
 =?utf-8?B?SEFScGhINnp3VFRLZjBDRVZUSE1LRUZHRncvaTZoZ0FxY2hmM1FsZnpkTG1L?=
 =?utf-8?B?TWlqZVZUVFovK3dINXh3Z2JXR3ZRT2tKR0piRFRhVms1UExuZVpCY2FXY2o5?=
 =?utf-8?B?akFqNTRick9RUkRwS0p6eUhMRndESnNBMWl0SDFRMUZVSWtSVUxGN0hrVXgr?=
 =?utf-8?B?cWFaNHVjUGk2ZTZTWCtMQjZCY0pIYUZEMndMbFAxc1N3b0c1aDhmM2gwOGFU?=
 =?utf-8?B?UXlsemx4MTQwMDFlTDJCN3V5d3BoOTIrZUJoeDQyZ3JTTnAvNlFzU0IzdFEv?=
 =?utf-8?B?YWhKb3BJODZ2TFUzdzVaWHBtV2E0eDNGR3U1QVhhN3FUbkE2MlV6Z1hSRlBT?=
 =?utf-8?B?TXpodWZpMkdJUkhOaUVUS2VWWkpyRkh5T0pJK2UvdDY1RmZMaHpXakcxZjJH?=
 =?utf-8?B?WDNtWjl5VkJ3YzNTT1V1OCtqdWdmZE1OZFVXYW0yUllleGR6RHlUZEQ0di9P?=
 =?utf-8?B?U01vWjBPdzNmbGx1LzlaMDdVUDdsT29tSmtmWUdvNkVmejJSUEJ2TGxUdVhn?=
 =?utf-8?B?bkx3b2VsaHcrRGI2QjdvSitlVWphNEw2c0ZRWVpHS2J5SkZkKzluNS83QmJr?=
 =?utf-8?B?bCsrWVNncmd0S0hOY1FiUTd1MXNpR3p6RTVjZXZ0OWhXWkdKWnM1ZTBoM0Jl?=
 =?utf-8?B?TTh4OXhnQXJGOWgvT1djZjk0aWltQWYxUWEvLy9idVBwcUJiTnkwdXRETmRT?=
 =?utf-8?B?RUxtK2pYM2tvK3dzeWlsVGNheWl6MXQ0V1FZVm5CbDlvMHZhWXI5Q3p6RTJ5?=
 =?utf-8?B?cTFBR09SNWxVQXdHYXQvUzdTY0RTN2ZZUExkV0E2RFQwMHJRZmhqL0FKU1NZ?=
 =?utf-8?B?R1ZFd0dSNGpmcXhMcjZ5TnlYN3I4b1J3S3RXS3g5Z3RUZnRtZCtqUHRrS3Bt?=
 =?utf-8?B?MXpPOUFNUEV1MzZIZ284SHVoR1JEQkFobEdvMVlwTE43WFFyUGNYdE5hakRC?=
 =?utf-8?B?RVhsY0gzSnM1eXpZbk55c1AxZ3UvNGhNQWFCRnZySFVUTXNzTFZZMjBWT1lV?=
 =?utf-8?B?bzJsZnc0cHRGRWlwUDJlSUNZc0w3a0k3Y0s1OC9oRFZhU2dxVTFSa01KNnBh?=
 =?utf-8?B?K1RVRUllYkRzbml4SHVhMmI0RjBEN1lzNklEMmFTcFZpSmdDU1lvNkd6bkEy?=
 =?utf-8?B?YW5yRVVJcUVvQndaZGZKb2tlQ0RzRnA1R3NDM2MxWlNDRE1DOHVOYVVBUXFU?=
 =?utf-8?B?Z3lZYzlYZTM4SGJJTXZBY093Y1F6YkxFMVRyelFlYmp1TTFRRVV2VFViODNJ?=
 =?utf-8?B?dG9UaVFUMXo2WVkwZEFKTWpDSklCN3BOamlwek01eEtJd3p6Q0lBYWNjd0Yw?=
 =?utf-8?B?b2ZPcm9tbHBHTmxSejAxWUQ5Y3RPeU0wTVhKblBYbncxZFBCRTQzMFBZYi9v?=
 =?utf-8?B?THpzQnc2SmxVWkVCNmFEZGo4aTlJQk5UNlRHZTRDYmd2Rys1cnVWN2hVelMy?=
 =?utf-8?B?RDZpSzlQNGV2T2tydVBBR0YvSkF0V2FqVTJkd1hlbGhsdkNhSVJnc2xMajdo?=
 =?utf-8?B?R2JtM3JBdVRxVkdURlVUVldQemhQUi9IMTZsRmh2bWpjTmlsS21leHZSR3Rp?=
 =?utf-8?B?RDJKSTA2eDYrS2xJc0xjU1M3cTl6MnZXU3JUOXk3b1NONTJVR3diRWZYWC9l?=
 =?utf-8?B?Tm55WHVSaE14dXNmaGZ5YzAydXU4ZjRueXh0c3cvT2k2QUdLa1FvcWZxRms4?=
 =?utf-8?B?WlRISXpjYm4wY2VVcEdUb0R6UU5mZXF0UUorNXUyRlQ1V1hkSExMWGt6Uzl5?=
 =?utf-8?B?ZWdxNTRLTTJHWUxoZmN1NXkwbUh2cTEyK3BmTjZEd2YyOGNKYWtSbkRxcDR2?=
 =?utf-8?B?M1BSWWxXU2dTck5SMjRwTllOeGJiY2pJOEEvRm9YRTRzaVJsRkw0R1Jobnlo?=
 =?utf-8?B?L28vckladHZ6QXJnVFc5V2JJWHdCSmphMHc2STRxcXVKR1JpRjFBd3ZSV2R0?=
 =?utf-8?Q?Hj3sR+F/brS3RZp/23vHw9+oXiJsZ49rJJYUs3Gp15LFk?=
x-ms-exchange-antispam-messagedata-1: iTfAb8g5U5YPTygYFx4udH3k3sOltZjVsxU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B550094F38C88B4D93A73BBF7C7D83B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CHOwTjBSG0FC7LoGy3hAahvKGsr0xCq2XQmSdVojaUzDiAMkXdhsVQgDXMF2UjfLp4VO14rzqYlU32MOsO2vgE4QThunTc62n4g4IdMt8KAT9eiNH5Mq3yY/gCQGBLsZy3tGWrTn0+XlLTmpb9lcoD6kEY0Zju+q4rFlArCenG/0apIYBZDE+3dBaW5CZivFMlPGQ/r8tDwZ4E+wNcVp1JhFFilM+b7Hlx4Fn0R5FCgwptYKnHqDZe7yLtpNzMK64SnG6LoEd+A8w3ZlKurh1igX68ZFkzgP6ZKzwbHxxgPF0L5TCHm23+wea1wId5s0aB3fNM4gKwKRFs8/ZPZyJw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1SLMISalH8G50gmX+momWM4tctWsr3CrRYGgsqNCYz4e9SGhUiQWyESGc9JCheO3sZCxvBfGCXLdrrtA/wdC7AX3/FL6DlILLwi9yolS08IoedVrRRECuvf1kwn+a0pplZ3O3L/WLTbvidLYRTZD/flrNK5rU2IZ5WQpSA2W4rPTSr7FRkzpRAekuoaQkzq/X+En9bS/KZKDH6I6gUI0YOJrn8jieLv3NVFJKpq/redS/q8TUAMiuIZAcfWhI52r4yGUhTuHhsiXCJrmI9Xx2ZXp1WQ5eH3wjkt1AcXRcDoUSa1k2HWhi17NU5wHPGniiSbWG0XaLeobfoMUIS5nuph4jGL0hzTUYKhJAIz7AuTvht+LLe+nKOx7YWzEDikgwyWK81QI2H+o7TKTuAt4kjpvTcsPKAXz2cK5duIYGEr88hcRnwCL22CL/XjndXfh250CAdtEvJTkAoQ52BsuE+difAm/6H0g4pbhOeFkSa1MwAKCBwhjn7CdQwcDS2nTjptZBnceceJLvRqk1YvW9YB/UAvBNq9vkVuXDDyiXFYMUzfdRdkPpWc3UXkunIXV69Cvx/0kdNZA4cLrkSeECd6XcthnfQdg95tpcqhcPZZWQUeDibw5VlkuPR1hhCIm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c259f1d-283b-4ee1-d3db-08df1f5ebb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:53:04.0060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih8Moz8W47JS43bBHx//IGSfG0j+CsWWbs6VoO4KuEfnlQrssGPneRfVaCF+E63+9ezHQGfP7nrjXhCluFKnIZb1BzVM1WxcWtJOUDSaKUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7811
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gUm91dGUgTUlQIHJlYWRzIGluIHRoZSBpbnRlcnJ1cHQsIENTUiwgQUNMSU5U
IGFuZCBwZW5kaW5nLUlSUQ0KPiBjb2RlIHRocm91Z2ggYSBzaW5nbGUgcmlzY3ZfY3B1X2dldF9t
aXAoKSBhY2Nlc3Nvciwgc28gdGhlDQo+IGltcGxlbWVudGF0aW9uIGNhbiBjaGFuZ2UgaW4gb25l
IHBsYWNlLg0KPiANCj4gcmlzY3ZfY3B1X3VwZGF0ZV9taXAoKSBub3cgcmVhZHMgdGhlIG9sZCB2
YWx1ZSB1bmRlciB0aGUgQlFMLA0KPiBzbyB0aGUgcmV0dXJuZWQgdmFsdWUgbWF0Y2hlcyB0aGUg
b25lIHdyaXR0ZW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKg
dGFyZ2V0L3Jpc2N2L2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKysrDQo+
IMKgaHcvaW50Yy9yaXNjdl9hY2xpbnQuY8KgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+IMKgdGFy
Z2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKysrKysrLQ0KPiDC
oHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jIHwgMTIgKysrKysrKy0tLS0tDQo+IMKgdGFy
Z2V0L3Jpc2N2L3RjZy9jc3IuY8KgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKystLQ0KPiDCoDUgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmggYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gaW5kZXgg
ZTM0YzBjNjc2ZDUuLmFkNzMxYmY1ZDM0IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1
LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+IEBAIC02ODQsNiArNjg0LDEzIEBAIGJv
b2wgcmlzY3ZfY3B1X3RyYW5zbGF0ZV9mb3JfZGVidWcoQ1BVU3RhdGUgKmNzLA0KPiB2YWRkciBh
ZGRyLA0KPiDCoGJvb2wgcmlzY3ZfY3B1X2V4ZWNfaW50ZXJydXB0KENQVVN0YXRlICpjcywgaW50
IGludGVycnVwdF9yZXF1ZXN0KTsNCj4gwqB2b2lkIHJpc2N2X2NwdV9zd2FwX2h5cGVydmlzb3Jf
cmVncyhDUFVSSVNDVlN0YXRlICplbnYpOw0KPiDCoGludCByaXNjdl9jcHVfY2xhaW1faW50ZXJy
dXB0cyhSSVNDVkNQVSAqY3B1LCB1aW50NjRfdCBpbnRlcnJ1cHRzKTsNCj4gKy8qKg0KPiArICog
cmlzY3ZfY3B1X2dldF9taXA6DQo+ICsgKiBAZW52OiBDUFVSSVNDVlN0YXRlDQo+ICsgKg0KPiAr
ICogUmV0dXJuczogdGhlIGN1cnJlbnQgdmFsdWUgb2YgdGhlIE1hY2hpbmUgSW50ZXJydXB0IFBl
bmRpbmcgKE1JUCkNCj4gcmVnaXN0ZXIuDQo+ICsgKi8NCj4gK3VpbnQ2NF90IHJpc2N2X2NwdV9n
ZXRfbWlwKGNvbnN0IENQVVJJU0NWU3RhdGUgKmVudik7DQo+IMKgLyoqDQo+IMKgICogcmlzY3Zf
Y3B1X3VwZGF0ZV9taXA6DQo+IMKgICogQGVudjogQ1BVUklTQ1ZTdGF0ZQ0KPiBkaWZmIC0tZ2l0
IGEvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYyBiL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4gaW5k
ZXggMmQxMzNkMGRjZjkuLjRiZDM1OWMzMzgwIDEwMDY0NA0KPiAtLS0gYS9ody9pbnRjL3Jpc2N2
X2FjbGludC5jDQo+ICsrKyBiL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4gQEAgLTQzOCw3ICs0
MzgsNyBAQCBzdGF0aWMgdWludDY0X3QgcmlzY3ZfYWNsaW50X3N3aV9yZWFkKHZvaWQNCj4gKm9w
YXF1ZSwgaHdhZGRyIGFkZHIsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19t
YXNrKExPR19HVUVTVF9FUlJPUiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAiYWNsaW50LXN3aTogaW52YWxpZCBoYXJ0aWQ6ICV6dSIsDQo+
IGhhcnRpZCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmICgoYWRkciAmIDB4MykgPT0g
MCkgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gKHN3aS0+c3N3aSkgPyAwIDog
KChlbnYtPm1pcCAmIE1JUF9NU0lQKSA+IDApOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gKHN3aS0+c3N3aSkgPyAwIDogKChyaXNjdl9jcHVfZ2V0X21pcChlbnYpICYNCj4gTUlQ
X01TSVApID4gMCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4g
aW5kZXggZGE0YzFhMDkwYjkuLmI4ZDZmOTkyYmE0IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlz
Y3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IEBAIC05MTYsOCArOTE2LDkg
QEAgdWludDY0X3QgcmlzY3ZfY3B1X2FsbF9wZW5kaW5nKENQVVJJU0NWU3RhdGUNCj4gKmVudikN
Cj4gwqDCoMKgwqAgdWludDMyX3QgZ2VpbiA9IGdldF9maWVsZChlbnYtPmhzdGF0dXMsIEhTVEFU
VVNfVkdFSU4pOw0KPiDCoMKgwqDCoCB1aW50NjRfdCB2c2dlaW4gPSAoZW52LT5oZ2VpcCAmICgx
VUxMIDw8IGdlaW4pKSA/IE1JUF9WU0VJUCA6IDA7DQo+IMKgwqDCoMKgIHVpbnQ2NF90IHZzdGlw
ID0gKGVudi0+dnN0aW1lX2lycSkgPyBNSVBfVlNUSVAgOiAwOw0KPiArwqDCoMKgIHVpbnQ2NF90
IG1pcCA9IHJpc2N2X2NwdV9nZXRfbWlwKGVudik7DQo+IMKgDQo+IC3CoMKgwqAgcmV0dXJuIChl
bnYtPm1pcCB8IHZzZ2VpbiB8IHZzdGlwKSAmIGVudi0+bWllOw0KPiArwqDCoMKgIHJldHVybiAo
bWlwIHwgdnNnZWluIHwgdnN0aXApICYgZW52LT5taWU7DQo+IMKgfQ0KPiDCoA0KPiDCoGludCBy
aXNjdl9jcHVfbWlycV9wZW5kaW5nKENQVVJJU0NWU3RhdGUgKmVudikNCj4gQEAgLTk1Myw2ICs5
NTQsMTEgQEAgaW50IHJpc2N2X2NwdV92c2lycV9wZW5kaW5nKENQVVJJU0NWU3RhdGUgKmVudikN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIChpcnFzIHwgaXJxc19mX3ZzKSwgZW52LQ0KPiA+aHZpcHJpbyk7
DQo+IMKgfQ0KPiDCoA0KPiArdWludDY0X3QgcmlzY3ZfY3B1X2dldF9taXAoY29uc3QgQ1BVUklT
Q1ZTdGF0ZSAqZW52KQ0KPiArew0KPiArwqDCoMKgIHJldHVybiBlbnYtPm1pcDsNCj4gK30NCj4g
Kw0KPiDCoGJvb2wgcmlzY3ZfY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykNCj4gwqB7DQo+IMKg
wqDCoMKgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoY3MpOw0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxw
ZXIuYw0KPiBpbmRleCA5MWY1ZWI3MjkzMC4uZjhmNzc5YTAxZDggMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1
X2hlbHBlci5jDQo+IEBAIC01NjcsNyArNTY3LDcgQEAgdm9pZCByaXNjdl9jcHVfaW50ZXJydXB0
KENQVVJJU0NWU3RhdGUgKmVudikNCj4gwqANCj4gwqDCoMKgwqAgdnN0aXAgPSBlbnYtPnZzdGlt
ZV9pcnEgPyBNSVBfVlNUSVAgOiAwOw0KPiDCoA0KPiAtwqDCoMKgIGlmIChlbnYtPm1pcCB8IHZz
Z2VpbiB8IHZzdGlwIHwgaXJxZikgew0KPiArwqDCoMKgIGlmIChyaXNjdl9jcHVfZ2V0X21pcChl
bnYpIHwgdnNnZWluIHwgdnN0aXAgfCBpcnFmKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgY3B1X2lu
dGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQVJEKTsNCj4gwqDCoMKgwqAgfSBlbHNlIHsNCj4g
wqDCoMKgwqDCoMKgwqDCoCBjcHVfcmVzZXRfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hB
UkQpOw0KPiBAQCAtNTc2LDE0ICs1NzYsMTUgQEAgdm9pZCByaXNjdl9jcHVfaW50ZXJydXB0KENQ
VVJJU0NWU3RhdGUgKmVudikNCj4gwqANCj4gwqB1aW50NjRfdCByaXNjdl9jcHVfdXBkYXRlX21p
cChDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQ2NF90IG1hc2ssDQo+IHVpbnQ2NF90IHZhbHVlKQ0K
PiDCoHsNCj4gLcKgwqDCoCB1aW50NjRfdCBvbGQgPSBlbnYtPm1pcDsNCj4gK8KgwqDCoCB1aW50
NjRfdCBvbGQ7DQo+IMKgDQo+IMKgwqDCoMKgIC8qIE5vIG5lZWQgdG8gdXBkYXRlIG1pcCBmb3Ig
VlNUSVAgKi8NCj4gwqDCoMKgwqAgbWFzayA9ICgobWFzayA9PSBNSVBfVlNUSVApICYmIGVudi0+
dnN0aW1lX2lycSkgPyAwIDogbWFzazsNCj4gwqANCj4gwqDCoMKgwqAgQlFMX0xPQ0tfR1VBUkQo
KTsNCj4gwqANCj4gLcKgwqDCoCBlbnYtPm1pcCA9IChlbnYtPm1pcCAmIH5tYXNrKSB8ICh2YWx1
ZSAmIG1hc2spOw0KPiArwqDCoMKgIG9sZCA9IHJpc2N2X2NwdV9nZXRfbWlwKGVudik7DQo+ICvC
oMKgwqAgZW52LT5taXAgPSAob2xkICYgfm1hc2spIHwgKHZhbHVlICYgbWFzayk7DQo+IMKgDQo+
IMKgwqDCoMKgIHJpc2N2X2NwdV9pbnRlcnJ1cHQoZW52KTsNCj4gwqANCj4gQEAgLTIwNjEsMTAg
KzIwNjIsMTEgQEAgdm9pZCByaXNjdl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykNCj4g
wqDCoMKgwqAgYm9vbCBhc3luYyA9ICEhKGNzLT5leGNlcHRpb25faW5kZXggJiBSSVNDVl9FWENQ
X0lOVF9GTEFHKTsNCj4gwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIGNhdXNlID0gY3MtPmV4Y2VwdGlv
bl9pbmRleCAmIFJJU0NWX0VYQ1BfSU5UX01BU0s7DQo+IMKgwqDCoMKgIHVpbnQ2NF90IGRlbGVn
ID0gYXN5bmMgPyBlbnYtPm1pZGVsZWcgOiBlbnYtPm1lZGVsZWc7DQo+ICvCoMKgwqAgdWludDY0
X3QgbWlwID0gcmlzY3ZfY3B1X2dldF9taXAoZW52KTsNCj4gwqDCoMKgwqAgYm9vbCBzX2luamVj
dGVkID0gZW52LT5tdmlwICYgKDFVTEwgPDwgY2F1c2UpICYgZW52LT5tdmllbiAmJg0KPiAtwqDC
oMKgwqDCoMKgwqAgIShlbnYtPm1pcCAmICgxVUxMIDw8IGNhdXNlKSk7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAhKG1pcCAmICgxVUxMIDw8IGNhdXNlKSk7DQo+IMKgwqDCoMKgIGJvb2wgdnNfaW5qZWN0ZWQg
PSBlbnYtPmh2aXAgJiAoMVVMTCA8PCBjYXVzZSkgJiBlbnYtPmh2aWVuICYmDQo+IC3CoMKgwqDC
oMKgwqDCoCAhKGVudi0+bWlwICYgKDFVTEwgPDwgY2F1c2UpKTsNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IShtaXAgJiAoMVVMTCA8PCBjYXVzZSkpOw0KPiDCoMKgwqDCoCBib29sIHNtb2RlX2RvdWJsZV90
cmFwID0gZmFsc2U7DQo+IMKgwqDCoMKgIHVpbnQ2NF90IGhkZWxlZyA9IGFzeW5jID8gZW52LT5o
aWRlbGVnIDogZW52LT5oZWRlbGVnOw0KPiDCoMKgwqDCoCBjb25zdCBib29sIHByZXZfdmlydCA9
IGVudi0+dmlydF9lbmFibGVkOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3Iu
YyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gaW5kZXggMDYxYmM5ZGI3N2IuLmEwZTMyZjE0
Mjc2IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi90Y2cvY3NyLmMNCj4gQEAgLTM4MTYsNyArMzgxNiw3IEBAIHN0YXRpYyBSSVNDVkV4
Y2VwdGlvbiBybXdfbWlwNjQoQ1BVUklTQ1ZTdGF0ZQ0KPiAqZW52LCBpbnQgY3Nybm8sDQo+IMKg
wqDCoMKgIGlmIChtYXNrKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgb2xkX21pcCA9IHJpc2N2X2Nw
dV91cGRhdGVfbWlwKGVudiwgbWFzaywgKG5ld192YWwgJiBtYXNrKSk7DQo+IMKgwqDCoMKgIH0g
ZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoCBvbGRfbWlwID0gZW52LT5taXA7DQo+ICvCoMKgwqDC
oMKgwqDCoCBvbGRfbWlwID0gcmlzY3ZfY3B1X2dldF9taXAoZW52KTsNCj4gwqDCoMKgwqAgfQ0K
PiDCoA0KPiDCoMKgwqDCoCBpZiAoY3Nybm8gIT0gQ1NSX0hWSVApIHsNCj4gQEAgLTQ1NDksOCAr
NDU0OSwxMCBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24NCj4gcmVhZF92c3RvcGkoQ1BVUklTQ1ZT
dGF0ZSAqZW52LCBpbnQgY3Nybm8sDQo+IMKgwqDCoMKgIGh2aXByaW8gPSBnZXRfZmllbGQoZW52
LT5odmljdGwsIEhWSUNUTF9JUFJJTyk7DQo+IMKgDQo+IMKgwqDCoMKgIGlmIChnZWluKSB7DQo+
ICvCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBtaXAgPSByaXNjdl9jcHVfZ2V0X21pcChlbnYpOw0K
PiArDQo+IMKgwqDCoMKgwqDCoMKgwqAgdnNnZWluID0gKGVudi0+aGdlaXAgJiAoMVVMTCA8PCBn
ZWluKSkgPyBNSVBfVlNFSVAgOiAwOw0KPiAtwqDCoMKgwqDCoMKgwqAgdnNlaXAgPSBlbnYtPm1p
ZSAmIChlbnYtPm1pcCB8IHZzZ2VpbikgJiBNSVBfVlNFSVA7DQo+ICvCoMKgwqDCoMKgwqDCoCB2
c2VpcCA9IGVudi0+bWllICYgKG1pcCB8IHZzZ2VpbikgJiBNSVBfVlNFSVA7DQo+IMKgwqDCoMKg
wqDCoMKgwqAgaWYgKGdlaW4gPD0gZW52LT5nZWlsZW4gJiYgdnNlaXApIHsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNpaWRbc2NvdW50XSA9IElSUV9TX0VYVDsNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNpcHJpb1tzY291bnRdID0gSVBSSU9fTU1BWElQUklPICsgMTsNCg==

