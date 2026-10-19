Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5446CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId56-000731-UY; Sun, 18 Oct 2026 22:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId4q-00071x-CG
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:26:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId4o-0001mS-KL
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376774; x=1823912774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eslrPLtny0LL6P5h3AmN357VqKI9saY/B7ZTHLw9RKY=;
 b=L4kWZnoFCILtCR17noXahmAHZyiHSadN0sya7CBazuF9MTMmYuwlN+O2
 Ab6G2DV9J52tNAhW7hDVhBhDESVhS4eSZ1mkAA6SR9A/TY1dxhGVOsQzq
 mC87SbpRCiXEJvQDfnETiI2jKekuLUPuaZ8Hotd/f+NhtfKNFx6vHH6qv
 bKamTtVTMnGvMaA/IOESyT2vOGpflR6x9RN2Jc/pp5EoS1ScU1edzBs8R
 3bLZmwcqbIGR8shqbaRIkEqQRHl5IMRkYe2JMx25b9vebhQWDhoq/SUwx
 56R0apbKwXaBS3TMVBBYii81HgASNPU40XElKVKv3AZOdNzeYgnzjaPe4 Q==;
X-CSE-ConnectionGUID: rUL+O9DATL222XldUYAKmQ==
X-CSE-MsgGUID: 3MvSgB0FR46sXL0uFEBb9A==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416812"
Received: from mail-eastusazon11011046.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:26:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI3uD7QesVNFocwd8JR6Ou8Vwqy8rEsPP7g90q0C+/mxNmtAyXNTrsSIlZo2sF/ay4gN1ew8Q+ju9XHHB/RaLqNZzl9UvF36qaCoogGBXamZozR5Ut+MFbFALlS2W9jqfSteSRxqOoZ+x+4bnGqtlJ6hoIMwYzwfcIWNGCtKVHFegnaepY6IHXkxGHuJWN2LQeu8R2Kd5ddLbeYNUBgtybzBhkf8GqCY2qfxVpPF/T1d0SgbrGglYM8O6KZynOTTx4YQZOulrRRohv9tC4TWmOOdPtemtxkQZc0HbQ482wxu4G6MSBaOvL/Rz1ETnRwkSd/joIqimL99qEIoAayGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eslrPLtny0LL6P5h3AmN357VqKI9saY/B7ZTHLw9RKY=;
 b=jhujE0lDoIo6hoUs4gYH/VHUNjeTsQAWRuRF4Untj4j9BeUBQGHL92VX/ftrmeW6H3Z1vFENez6ICAfwpdTZKH/6MQYLS7wSOg2i6fMoMb+NrEO2nAjkRf71RhsaZX6JprGvytlXDotsz1RkKT600p0docrgF5jnvdKeUGYTfFQjgrb+QoVwtv84fxN3ts/rRlrCG8IM4/AKmjSB0ECXRjZRV+whg8v3PXLYMFVHjCMmq8PzMT5Hahsp8Xva7aXbdYqvsk6e9Ws1II7ZpWt6HE7iLe0F2WSO0jWsTMKILgtm8CYbPBCczOmy6RNXkc8u1sbNTV5+GRDLDLW9TxNObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eslrPLtny0LL6P5h3AmN357VqKI9saY/B7ZTHLw9RKY=;
 b=RH64qSZQf2TOSmJQzs0Xub4v8yt8/SPqcsY1eJHLtyJd1Bzuh8UT1l/gBz93svBnOMQQS7YFHAFODXR2rf9/elLwXCb1PYacpfsGtVWsmiw4ovAlBM1WErebfOj2Oev6tqHQp417Wmv1hj400Y+1z7RU6ommccPCLooUKpJcp1Y=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:26:11 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:26:11 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 5/9] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Thread-Topic: [PATCH v2 5/9] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Thread-Index: AQHdXcVW+cizStrzGkO5tJ939BjtTrcEJt0A
Date: Mon, 19 Oct 2026 02:26:11 +0000
Message-ID: <079332ac31f8abf3b3e54da10b0df5ed79c58ec9.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-6-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-6-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 3ae560df-7e1c-457f-7b28-08df2d88577c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: iAdezVvlI+710ivsq9T9Ro+LMt/LA8H/JpVHb8qsyB+u6P3zVRcBxJGLwBLVp25H+9ZZ3YAbAC6wpAtPTigQojd2auyjtLzQinHIzydIdTepCMGtnTQN6eQ2mKHKtyWMQI4J3S2Cf6GXdkXVPbx0j5Ow5p6VCawb9gghoJJk+f22eRrqqXKyWZbFzTSYKmvEYabdHBMBKZcpd0Kso5iPq4fGoy3Sg9Juh/ILFTVBACCw/w9sxbkt8DwgXJaiS6Opnv6WnZ7hi++IaUKtYMJuKpoxy2tYNlP2Gg6J68kJJ6MRf7IO1xakoYshkUh+Y4AzR1yG1lRwkubCRoZhIrhDCTNeJeRMPllQ3FxqyuuFHHs51urbd0/CebfkdxdsAOMInM1NKKsjj1iQbVKAnMw1DLLQYrViAZPhc2jHJpq99hQuXhizNlLNI4GQI47hCfPiExHvMWCSOd4dzOUEaUGeuKLBljLl9eykMrXRHYSsdLAn2ZOOTyaWu+l3+CgPZT01JZyNkW+inIxfKXPr1exztdtMWizYF9b/D63FEyrFmmt2a/KIsJRLzjxbSkcMrqBuwGrB/3CLHYwsvetY2OALXV/FLxfCE+hz+paCwRkoE0ZRtzA07fLHxIdFn72uuS8Qm+ayXRgjSQ2WMkB8immsIw2NPwyqBn8L+sISrUI2zLTVVqr+SbfuHIsRD8HqI0lDWWDrxD7F6BasXqGRcfmNKdjVNRv63VZ8urkTdKsAuCY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW4vc2w4aHV6RjNGUUFVdlYzb1VqdVV6Qk9YbHZJUUlpT1BCSFZ3NnhiTlVX?=
 =?utf-8?B?ZlNpdlc5VTJvbGx6SE9FY3JoS3FzOTVxd01iUk1sZXVJbURLNVhRZEx6ZTlz?=
 =?utf-8?B?bVZHODJtZDk5SWZEZjEzclY5SVViTHlYWGgvYTJKaEd5a0FNa2R5OVk3dHkz?=
 =?utf-8?B?T095NUFGSzZuZk9FbWVoS05hOEdHMUMvbDRWTFpwam1PVWdlQ1ZENTdZSDFq?=
 =?utf-8?B?U2FWKzU3dkpBbkduVldxYWFzSUF3MHR1cDVGWExienVMMlo4ajF1a2N1cUk3?=
 =?utf-8?B?UnYwVGd2UWRuWmhEa3VqVXNOaWNmdkNHU2lrSUtzWUUrS3QwNlNKNXZDNVc3?=
 =?utf-8?B?VmtWMDNyNFZUTFVOU21ZZEFjOFZKcXMxNWY3OFFoYTY2ekpCSTJldWdtZjRo?=
 =?utf-8?B?Nktscjl6cHhIRThSdmNsL3F3Z0t0RGZLcElubFdqS0FBUndnUERUV0Z4dnVE?=
 =?utf-8?B?T1dIVDRqRHdYRWw0NDhkWXpHakl0RHlnVmRLUDA1SlcyTUk1cGRKTTd0cC9p?=
 =?utf-8?B?dzFxalErWE9vSlZpWUpZYzNuVzl6Nk1MUnBZZDRjSUlpdWo5N3RxbnVNODhx?=
 =?utf-8?B?ZDhkTTd6ZXlteGhLL0dDS3RxNUo0TjhBbUdoaVJDTVNvNWZqK3VsTW1Xd2VV?=
 =?utf-8?B?dDh2TXFZeHBtU3FWMmpKcWVZemtVemU5d2hsdEJaYVBGcUF6OE91M2VPKytX?=
 =?utf-8?B?eXlyZFFzVVhGTTdqM0xla1pqMnF3aDk1YTBzZXROY2t3V1ZwK0hCQWRtS0xV?=
 =?utf-8?B?czJBS3ZxTEpWbU8rdFBLczZ2R2djNU1DbmNra20wSGwxeUMreHdVQUZTYUph?=
 =?utf-8?B?WXNvN1M2MVNnV1Q1MjFEKzZxZnF4aWpFaWZmd1MxM3lBcTE1OXVVR2pha2VV?=
 =?utf-8?B?cWovSTU2WVhJZktmaWVvZ1czbDd4dlpaNTg0OU03YlE1VDgyRCt1M3JDbldK?=
 =?utf-8?B?ODJFYWpXam9QWHh5Z1pOV1BJZDBjbWJjdkVmOFZTVUFjU2pCZmFvL1dqN3NY?=
 =?utf-8?B?SnB6RlhWaHk0MjIyQWVjU2czRmJvdHFSZ3U4aXlaR2RGbi9VWUVqZXF6UkUv?=
 =?utf-8?B?Z0lPWFI1ZEI2T3lHZm8vcjJKaE9PWG9rNm83d05aWmFDU1BSYWlSbU1GVWc5?=
 =?utf-8?B?SW1OL3pSR2ZTcHF2aWl1REx4UWM4Y1JZdXV0L1JqWGhySjdVaml1ZTc0SnNu?=
 =?utf-8?B?MGdxZWZPdzdXeVArc3dHUHRNREEvam81dVIwdTNzMkJMQTNwUWZBRFZGVGFL?=
 =?utf-8?B?cmFETWRDZS9QMk1jSDl3R2RaS1h2d1Y2OExnRXRUcjNnN21GbHdVSTdjYVk1?=
 =?utf-8?B?ZFdHZ240cmw3STJ2QVg3RTJOYWV3WC9VeVN0SjByMWhneTNnNXoyTHRxMi84?=
 =?utf-8?B?dWlaV2tOZUpWdE9kWStTaisvZkRITW1MM0I0R2F6NEt2MDdnL3cxRnVoNDFn?=
 =?utf-8?B?WnM2WHM4UEhwa0R1T3BxV1RkaUNXZklRajlSYlh2Mll2MFlUbWVsYWJmbXZv?=
 =?utf-8?B?MW12ZFNpUmtZays4aWxPc0dJSCtNd3hIYk9DTzkwZzVPZWF4UXNWQVFRRDlz?=
 =?utf-8?B?UkNJYW1uVjdBcFU3bGNGR05FT2NUZGVzTjhlRUZ4YmtCcnJIWGZISUdCdkk1?=
 =?utf-8?B?ZlZLdEs4TW05Nk1jVDBEcFhNb2dVZ3JydlAxVDlCTHlMa0NmWjhlZWVkSHNn?=
 =?utf-8?B?eFBYd0krdkhmbys2Uyt2WlA5b0pPcVhmS21PQ0wvZ2c4SXFGNXREZXkrVUgw?=
 =?utf-8?B?cmpKM3Fvd3dxdEZvZ2JBTFNkZFRBZlJ1aWt5eUVZYXpSRjVoUFNvTlBBL2ZX?=
 =?utf-8?B?N3dPWHpnTzYxNXoxVGdoaWNOOEMzQnhGV1ROcHFWMGlTbjFCbFNrNGh2eXhn?=
 =?utf-8?B?OFFObFlDcDFWN2JvVHBLRGYzRDRMaUhTalY4WlZNT3ZYaTJOK0dWQVBsMjdN?=
 =?utf-8?B?V25Pc3drY3JpbjJqQTZ2QUhYdmtxRlhWNTRPZG9SeDd6RHB3d2dvZExHVyty?=
 =?utf-8?B?cmhCbjFYYzgxK1hmdkdpUGZYM2NXTG8xVDhNUXZvZXk0ZXJYSlpoOWswS2Rr?=
 =?utf-8?B?L0duOG9Jd0dSRWpEZmpxc0ZIc3lmVGJzNit5YnZMeUNYL1A2RXpBdFdoQUZ0?=
 =?utf-8?B?VEtMaWxXcG0vSjd1YmNGVExJZ1NpcVpZd2RXRlJRSXhYSjRnb1loSnEvem5l?=
 =?utf-8?B?bXBiSC9NeHFjQ2tTeGtSQ2ErcFFDSEp0MUN5YmpidHhWNkdiUjVYb2JUMUMw?=
 =?utf-8?B?QWNRcFRXbUZMVTN2QnpPbnZLK1ZMWGtTUXp6VXZKYlhUazdyVUNOT2hCTnBS?=
 =?utf-8?B?TmhmcUpGck9UV1JzRUJzWHJoM1ozMkVvNDR0dmJDTFpWaWtBbGpqdjNkODRj?=
 =?utf-8?Q?9vXwUK4IUbZJDDO3ryHEg+i23MXiYx1m5z5rSrzcaR2F4?=
x-ms-exchange-antispam-messagedata-1: eoqrq0+pVq9P0X3HGvkMatSduh4obq2LruQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E14A087269983489F03E283C25F9BB2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rPXxXxlXtp3jtr7Pw6e38Bmw0rgzcpINLMN6kwtZKyEUz+I0mL6m2Cma3rM4a0eY9beIU8z3Rxu7hH5DiSd9qKY+ggmSThgk5JYAdRles38gZLfH5t0ZIoRiUTg5QzF4kC/mGogz0biNzRLKG9j2obLwP8q8Rsxg4FEL5ALXleZEkUqeeohLy7Fm8zRG+V4X5F0KzbtBnUmtv4EM6lPNHR7kVWJR6KIFbkVK6psjjIHyVk+bo7vZ0SW43DvxASCoDqW/diH/LSrPNtqIFgOIglQEKtyx0rTrSr4onnL7XXheIDyKIJ1wJzHwsPv/VPQ9JdwLYfy2CQw5DQk4iAMuPQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5IKCB6oc/e1ILZmuQKgZOxhjtzA7+71VCxG0ZUg/nMuGnfOKKC5K9RnPYvi36QRLQs0RdpbyMv6vckeuc0uownS5bqgfb9QET9Uu09ckk5UkbaOeeVQnZgVnYUy17HeBgmpHOC2HCi6ZoRPoeHA5HHJ/CviDKKDrNNMHaV6gwVTThvdGiD/oaJWFcoF0KVC7komNqKYr9urX+rpt9VSFCMLFqA2UERNpVcfMhLz7fibGFGYVhyHHwF+wlYy6DfwH/7MbJOzbweq5LtOD96reod/v9KiVoKOsAmQXCx1aL1zWk2TZq1DJHejNsmPIoRrLhLEgv1+cHOpgBnUARNhfR3w/+5eo/AtDcstO73PaPFUWOEI+SsqnE5+g6iPzfZHZ6i4+UT/VDX2P4Yzr9DP5sAqxJvUAiC7FFNmuSZkUJXQ51fZhXxW+qg0VP8u3JH3U1ZcEYFrY+LG0gzHaslJ6eQYUbAHV1FncfEfKwDvU6F3x3yvQyBVyCrkaviq3R9Ke1lUfqDiuZtKHg7L9pRQuRTumMv7i9K99rnIvFbDmxhR3WABzc9j0hyvbuO+X8lhJH8d0JxuBrjvMJz6C2Lna4YCLtx/I/kkW09kB8rnIuGVkKfHqW17ZF36HarpU5l2C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae560df-7e1c-457f-7b28-08df2d88577c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:26:11.6365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jx4lTJ4BFcNa/6jaWX6MB3aQnYZcJwTDg/4ZWmI8gsHE63HML3GAJz3awPOU6xHBIGdmb6WbrLARhrQSIhgS8oI60gxyB/1CDKdJZDooOoU=
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIzIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBUaGlzIHJlbW92ZXMgY29uZmxpY3Qgd2l0aCBzYW1lIGZ1bmN0aW9uIGZyb20gdGFyZ2V0
L2FybS4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFu
aWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPg0KDQpBY2tlZC1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0K
DQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3ZpcnQtYWNwaS1idWlsZC5jIHwgMiArLQ0KPiDCoGh3L3Jp
c2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+IMKgaW5jbHVkZS9ody9y
aXNjdi92aXJ0LmjCoMKgwqAgfCAyICstDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvdmlydC1h
Y3BpLWJ1aWxkLmMgYi9ody9yaXNjdi92aXJ0LWFjcGktYnVpbGQuYw0KPiBpbmRleCAwNDc1ZGNi
NWM2MC4uNDU2NTM1OWU5MDggMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3ZpcnQtYWNwaS1idWls
ZC5jDQo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQtYWNwaS1idWlsZC5jDQo+IEBAIC0xMDIxLDcgKzEw
MjEsNyBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uDQo+IHZtc3RhdGVfdmlydF9h
Y3BpX2J1aWxkID0gew0KPiDCoMKgwqDCoCB9LA0KPiDCoH07DQo+IMKgDQo+IC12b2lkIHZpcnRf
YWNwaV9zZXR1cChSSVNDVlZpcnRTdGF0ZSAqcykNCj4gK3ZvaWQgcmlzY3ZfdmlydF9hY3BpX3Nl
dHVwKFJJU0NWVmlydFN0YXRlICpzKQ0KPiDCoHsNCj4gwqDCoMKgwqAgQWNwaUJ1aWxkVGFibGVz
IHRhYmxlczsNCj4gwqDCoMKgwqAgQWNwaUJ1aWxkU3RhdGUgKmJ1aWxkX3N0YXRlOw0KPiBkaWZm
IC0tZ2l0IGEvaHcvcmlzY3YvdmlydC5jIGIvaHcvcmlzY3YvdmlydC5jDQo+IGluZGV4IDJjNmY5
ODNmODNmLi5kZTFjOTI0NjNhZCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jDQo+ICsr
KyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtNzEyLDcgKzcxMiw3IEBAIHN0YXRpYyB2b2lkIHZp
cnRfbWFjaGluZV9kb25lKE5vdGlmaWVyICpub3RpZmllciwNCj4gdm9pZCAqZGF0YSkNCj4gwqDC
oMKgwqAgdmlydF9idWlsZF9zbWJpb3Mocyk7DQo+IMKgDQo+IMKgwqDCoMKgIGlmICh2aXJ0X2lz
X2FjcGlfZW5hYmxlZChzKSkgew0KPiAtwqDCoMKgwqDCoMKgwqAgdmlydF9hY3BpX3NldHVwKHMp
Ow0KPiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfdmlydF9hY3BpX3NldHVwKHMpOw0KPiDCoMKgwqDC
oCB9DQo+IMKgfQ0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9yaXNjdi92aXJ0Lmgg
Yi9pbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaA0KPiBpbmRleCAxNmQ4NmVkZmNmYy4uNmU0ZmJmNGI2
NDcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvcmlzY3YvdmlydC5oDQo+ICsrKyBiL2luY2x1
ZGUvaHcvcmlzY3YvdmlydC5oDQo+IEBAIC0xMjIsNyArMTIyLDcgQEAgZW51bSB7DQo+IMKgwqDC
oMKgIChWSVJUX1BMSUNfQ09OVEVYVF9CQVNFICsgKF9fbnVtX2NvbnRleHQpICoNCj4gVklSVF9Q
TElDX0NPTlRFWFRfU1RSSURFKQ0KPiDCoA0KPiDCoGJvb2wgdmlydF9pc19pb21tdV9zeXNfZW5h
YmxlZChSSVNDVlZpcnRTdGF0ZSAqcyk7DQo+IC12b2lkIHZpcnRfYWNwaV9zZXR1cChSSVNDVlZp
cnRTdGF0ZSAqdm1zKTsNCj4gK3ZvaWQgcmlzY3ZfdmlydF9hY3BpX3NldHVwKFJJU0NWVmlydFN0
YXRlICp2bXMpOw0KPiDCoA0KPiDCoC8qDQo+IMKgICogVGhlIHZpcnQgbWFjaGluZSBwaHlzaWNh
bCBhZGRyZXNzIHNwYWNlIHVzZWQgYnkgc29tZSBvZiB0aGUNCj4gZGV2aWNlcw0K

