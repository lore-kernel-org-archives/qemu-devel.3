Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C314EC982F0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 00:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8odB-0002ld-BB; Mon, 21 Sep 2026 20:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8od3-0002kJ-IZ; Mon, 21 Sep 2026 20:45:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8od1-00076O-Q4; Mon, 21 Sep 2026 20:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790037904; x=1821573904;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lPyVtOwF9NzDtNfOlBJbrjk7ss62s1ABMdF+ecnm83c=;
 b=XcB0eMIiL5s/MCB8AaauEMEIhjWfxk4kX8CB52iy+f/dDl2AWEazVVBE
 gB0/JzioZ50QhMqq+0T52IR64iEkt7Xq82zE3ayxyrbF/yt2GGMAkr9ea
 bAQHbBcNdJl7LSOD9KzyDhUEW5ney7pQc4WUtapVmgom/P3MsAB+mDUzP
 sx0TMX5c1lnxdOqKp4n6qnolQObSTrC33xoyb+Vx2f2SZ44x/mAFHgLgd
 FMHAU0ra4Q+Q7tE31F9B6NAKolm7tY0tdO0k0EzsYpc3i4aiz0PDxQeWi
 ELgs6BRpbOVM4YVE8A1k3/U90VmbdH499wUoI5u3+CfsjSL3XgZag5XxY w==;
X-CSE-ConnectionGUID: 4AJRJIMRTDOVdOeR1Qg80A==
X-CSE-MsgGUID: x7S9BJcCQlCBTrbIGF6e/w==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="155264294"
Received: from mail-southcentralusazon11011011.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 08:45:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqnuMk3rp8OHQeRtmyQnkRnse3rdYEyizVzFILYcYz41c2lHiYmTbm5fbi553E1431yYABftK9MxPyYk/zUKL4RGMjKE5i2m9AzJPkGENHluK38oGxdUCsWmbfQHBk7byTx4Ofdp/gkNeQQpdPvM3HA4dLbMCXNtIQWlWCzSHstRLOIEigEA2/LQpnDZ6aKz0nruUfsWhHpaRkxvEGyNaol6QylPW+wQRDUdt9YjMIy+L7gYr1Bb9rbW9Rq1LSw1DHGRnbQIMKs/zprev3BapZH+lT6D/+qDiXFUi4aTAWvr5iepS9o1swtWYE7fypwT7erch9vW4F02eNq1rw/xCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPyVtOwF9NzDtNfOlBJbrjk7ss62s1ABMdF+ecnm83c=;
 b=ZHaCpFJmXaAj3ooGDUG8yZnE1Clqoj/qWVINrJPdKy1FzSX17oCc0hzpnhlul6hV4TAIy+gZE0eNSre80r2msKd6RMCEFxYGXWSRdTk5qORi85TeUP7ZHMvZOPF1bdDPZofig7iiQSxDYFwa1yF1Po3ceOBM5FTcjLmGzHvNrgY9Vg/+YUIo+G6/nXTN8S97VsZzTWNfqh3nKxqoF9gFgj2tEpoFVFzbrxxiE0tcIzuPEcIHTV62Vi5MjCht/kp9Uq+gzFEptO3ztc75nIpW6RAOjuEtkDzEqCXFDi8mPbAB1nbv+zd6Sqei1SgH3WPNllNtStT+cDHMxpO3WNTRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPyVtOwF9NzDtNfOlBJbrjk7ss62s1ABMdF+ecnm83c=;
 b=dFtQATl7qu4tOWRE93t8WlyOVQlQ1vYKtHuaxKTgfzIP3CFlQn8i4JAupzBHrtjqiH+v8NG8j0nUS2TZfSPJPyRDB06OTA4zbGXrXa3KqLsJxATce1W0ys8dwvPKSHFKxXNDjx6wqtGEpS0IGVYc/3Snvz7xghyImM6L0ppQaC4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SJ0PR04MB7342.namprd04.prod.outlook.com (2603:10b6:a03:290::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 00:44:54 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 00:44:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH] disas/riscv: Fix csrrs decode
Thread-Topic: [PATCH] disas/riscv: Fix csrrs decode
Thread-Index: AQHdQ+vdYJmb4tjJPU6prq4uQawLabbZz1AA
Date: Tue, 22 Sep 2026 00:44:53 +0000
Message-ID: <a2ace4bceef7cf3ff64e3ced5c99eb5ad6cfc8f2.camel@wdc.com>
References: <20260914015316.792751-1-richard.henderson@linaro.org>
In-Reply-To: <20260914015316.792751-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SJ0PR04MB7342:EE_
x-ms-office365-filtering-correlation-id: 01b7aa2f-6cdc-4202-c238-08df1842b77f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|366016|376014|1800799024|23010399003|11063799006|56012099006|38070700021|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: enzNdg2XuJ0zIznoA8c0siRnuDRRkN6oII3A8IXJEpI5e2qZFIpRUWDW1pdOE8gi7ndZLpGo6+JeG+1tLfIG+5YAFnQbCys34TLia6WP5xi+xokiMJkJGNPMwJxCl4YOTSbRH5s7GUI3ntvnO29eiNW8pxHcrfvTr7EhToXtpwg+oqJgFo5Bx10LP/cgqnYxMnZ/r20Oo5LtlBMMSYdniseDOpUNk7YhM6kItSUgaJ+quQ4kjJffIKQQIATKT2UE7fV+VHGFT9VcrjxcJIxjh3EaWfLq2tt5fosfU702l+KjemQqMEj+2N0FZf+JoDYmgpkj2A9oz63ILdYvMA0+KZzlto05CFLSfwCW1sujKtYIdREftNcDFu0M+MbXnKgczo4VxXTu5rtmHFe7d6BF6I2oivd0vuKVAknxQh1NCNP57gfu26E9SOv8J2CFc//a9RAkB5hDio3JqAXnJ2Q1eHEtrBQ6+baQwbZFOrVosFLgAYgqyqPx6mZb6DgX/h8EXjAMrlt+Lgmfitxgld+ytF+J9X7R9xKkxyg/Prvis0TOirW1K/u+ITk0cVQHCXwpSH0xsueIqCAjSOZjwFtZvhCnplFLp3Et/NK+mvIifnIPf5lz4djcogKwyh2GBaIImNiG3qmaGvo2HVenrSmSG09OLRcW4cnfD2tn9c6Ygo4eMsm7CemTt1i5sDZ6ti02YjAvwHuiP00npESDog5GfLyrvP4TOwdliYdWB+RuL2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(38070700021)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdzdm92SlFPUWYycVgwQnRRUjFlOU80NkQ0UldiaFJBTzljUUkrVTIzeDVo?=
 =?utf-8?B?N1dzTFEwZnJ1d09mUDROaGkyWlhic1BTUGdPSnljQUsrd3VYRml0MGJnUVdD?=
 =?utf-8?B?YnlpekIrTS9jTG5JaTZaaFdwazk0ZlVxeFh3dWlKUDdtcmxuMW55eEFWWE9n?=
 =?utf-8?B?SEVFV0UrbUNROHc2TVdFWXlrcmNIRzU2M0ZORzkzQnZhNjExbTBPbUpsdjJn?=
 =?utf-8?B?bGxONWllbXlsQzhyVENjUEkvcENGUlJYL1dMZVE4dDNkREVObzFSeEtCM0x2?=
 =?utf-8?B?WlI5b3RjSzNSTG51TktCWGI0RXlBMjYrLzFabE84UXZXTDNObWV2QkdhOUtC?=
 =?utf-8?B?OUlrY241dWtFbUpndTJYZG9SM1huci8rbmNrbmZtOFRnTXVITlRyNEV4OGox?=
 =?utf-8?B?UlBFdHNmOXQwZzJES1ZHYk11dVJXdkgvVStBQjBFZ3NkaHRnL2o3Y1FvLzFX?=
 =?utf-8?B?Wmx2ME9uYUw3UHJwblVVNmNQaWVad2ZGdHY1ZmFadlhIU1dYeUt6WGNadHVh?=
 =?utf-8?B?ZTk2dUtrU3ZqWjFsUUt5Y09RUEFJNm1ldGorQnE1YXdwR1gzclVvaFgwL3Zi?=
 =?utf-8?B?ZWZZcUl6cEZQQmp4REVMcEJ0WEdZdDdrR3BlRElvT2JxRm1Ld3JqRTNsdmNE?=
 =?utf-8?B?cHJWMUZ2N0xsWndGVnRVdXA0djVSUFNRRFVUY2ZXcDhTakdCSGkveHZUcXZM?=
 =?utf-8?B?OTFGNG5ONUQ1T29FVjI3WDhVY1FVR1hEYlRJVGNCTDdXRHZjMXBjRmtSK3Bw?=
 =?utf-8?B?UjdZY28rY3ptdm9zVFNKb0VaeWNlRkNGOGpzaERxcU4zUERZamRoY0IvblVa?=
 =?utf-8?B?WlRjd1QwMFA4aDhaTHlHSTdMYTR5dTZSbjE4cE5uMXVCVVpteWZXNHA4THIw?=
 =?utf-8?B?YkdYU3J3K3FhaUxNQjFSbzVVbmF2cFMzNUxpMGRlRVdrU01lQW1FSWFLVE9K?=
 =?utf-8?B?UWNKS25uVktFU3dZS0IxWVNENWxtazFkeUdXS05INkh5RjZGMFZnemlUbDdN?=
 =?utf-8?B?MVpUTkNkcS91T1E0c3doRmUzTDRzaDRqUURqczZBM3cwOEVQMThKbDAzdUNq?=
 =?utf-8?B?UklzS1NuUUc5WjV5NnI5KzhEQ3RhMy9rQS9qMSszNk1EQ295T29FZExwckho?=
 =?utf-8?B?ZVpsV1p5ZDNYbjJaSGpUNjZBU285bVZRV3MxVnNXK21SUUg1NEFTNllmbCtW?=
 =?utf-8?B?aVIrTmxkN0t1N1l0VEp6NllsWlBwSWw5eGJSbVZoek84bzBUNjJFUzg2ZkJu?=
 =?utf-8?B?RVQ4QjJUajMyYU9RZ3JkVkdyNFQxeGdTb3FYM3NYZ25uRFMrUU5YekxUK2pr?=
 =?utf-8?B?d0FJL25pWmFBQjBocjRVNldCUXZ0eUFTa29SMVZHNTh5NWJVMzZYcWtwN2Fj?=
 =?utf-8?B?bTJZSDBYbEdkMnorVWVHakFTelpIeHRQcVFMSHAveDkzZjFCTzZpWnpEdnht?=
 =?utf-8?B?WW5FYkxFMkVrcTlBVC8vaGtRWFhleDdXUnhrdWRhMllvb3UwbFhoKzNBbnI2?=
 =?utf-8?B?Lzh3cDhUeUlSYTI2R3VOblV3dUVkRWk4KzlFL09YcE5wMXppKzFTM3I1S2dI?=
 =?utf-8?B?bk5uMDBkaUVPd2NEcGZvMmNqQ09KdXk3RWtBSDE3VzJMbGhKc2NYM2hqTk4v?=
 =?utf-8?B?SHhIcHcwTGNYTVRHb3ZRd0JDbVphWTBtNTRXOGp1TGVwYmp5Q1VTMGw3M3RU?=
 =?utf-8?B?dnFWaks5ZnE1eHRsT3d1WlJZbFQzUFFLZHdhWW1PYkM1TEthdUluY1JPSWQ4?=
 =?utf-8?B?Q2lyU2ZuRUJzTDRkNzNVWkVlRXZBNGtndTJZdXN0WmM1RUh5SDM5QmVuTzJ0?=
 =?utf-8?B?THdqclVyRnJtQUhYUVNWV05CUFBzTnBZZ0tRNDVrNU5iWDAvSXBQc2JneDdG?=
 =?utf-8?B?Z2plYjZNd2ZDL25SRkhFYkp6aHFCWTM1cDZLWjJlejRvd2VDQVdPTU1zVGpY?=
 =?utf-8?B?aGFGSU9jOFJpRzZUNUdtUW9MMjUxMWN6ejgrZGl3WVFMWVZXaUdMQ09pKzYz?=
 =?utf-8?B?Sm1DMXR6aXVNNjZaMmNjODVGSEFhMERnWkdsdlBFQjlEaXJDVUR3RmpRQnEz?=
 =?utf-8?B?S2ZoT2g3dzcxOGhIK2E4ak44aGxFeEp3U0tSVXN2eGJIcDV0NVJjNUFpNDcv?=
 =?utf-8?B?bHRGditKaU01UklmTExhSG13eFh5TmxzMVhaRGdFYWRPalhMQVF0algxMkEw?=
 =?utf-8?B?L2ZNeHpEcytoSy91S3gxdkZpYVg1RXJ3RXp6SG4yTU81VDlvTW82bTQzZGFw?=
 =?utf-8?B?TXhsMGc2OVRIOHE2dXp5OEhXLzl0eEE3eEhxSDZyL0pRNFlqbGI1blNRUnpw?=
 =?utf-8?B?YTM2WE4wRkhGcDF5TmVUS3FjN1ZZTDhmMVpXdVBBb0RIZVQ2TjJwZTdxdW4v?=
 =?utf-8?Q?PTpy8KtGGlpV0n4C0jy9lVd9uUSugU8a7MgI9jZC4COQh?=
x-ms-exchange-antispam-messagedata-1: pu32JhmZpkpW1SWL7YFkRlSuT3sBvSDZaAE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <944F520108A2944D919D3909ADC4FB8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PEA7hsS4rT6vDV7FYtRIPY5IDncgMSFCOuLRGMOqEe6woAx5VZ8bbI+1mEyXOMT7wcZBFHCUhCfv/Z3dGtHdLe307K7oCH/gFts37VLVFob5BTVqjlE1epzzDHw1cT0/RwRKFBEzdzVBLwXikJyMUny61UfxZPUp066/bgb19hwZR+GQjHYA72ZuOpQ1p+P1GgHdf+/nbb+ocUQIPis9bej3tcseA+/EAe4Ogxa9dDWcEL8SsvjNG9jV3Oaya5m7DFWkY6vL0mz9XNuR19vuuw8D6QXItxWb4q3fuIM6Qy/kvd/ynyxTsiKXRxqeYS29dZBj7dRLvWuKA+oJaasiQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hkL4Edtj729MfZwz9ddJfrAjUkdoox7C7OZ1RJ3X6O7uGDY9ilg3vlYZuzTDSWlr5MfW3M46NekEV6g7CU0lZvU/gc8UVI2A+3lFc1x8s86w3G7YafFzBYKq2v7AdL8ZGaarhv78pOu21ESRWShkfqIgbR0+3cV0YfUcszHKXX2AD9LQ/Ji69nQUxx0ySunvafvKs9TV/AQGTuyxbO6R6RBo0wqre3e7zA73/iqOaD8Vebiu/lF/8n2KxNpGmxecs6vikLQEHNGfO+pQb92CAIg5VyWnZmNRuXs91PSkkWVbh/Mp400MLTss4CoQqS3i4fIgdiHv2hL3ozM3qpNynUxXLyTuv8MyfLVP9WjLrikpiVIdO9dGBaynyKJ60gOumt2jtBErz5MWgrRB/gMF38s+vx8n9KNzai3pcSUEJpC7jdj9yeqV6Gv2lmlQrHWcNPbMCZ8o/7Y3a6ygtfijdIWrKU1ffd/8orkdPBDpf29HTXxPkeYu91qS5rNM1MkzeMWxBDXQ8Jga/Wg6fo/wydQwHSx/7iPaTEyPTe5MdJWWvoYtu+evzy4RMYmhyO2BvV6Tkl0ELd/UyF+wFDJifSCOgFsPWa8EtJM4tLMpXfmm6hbDKh8szmz782wBcizn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b7aa2f-6cdc-4202-c238-08df1842b77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 00:44:53.5120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pYbMooC4SxySFDEt1hAKq6Ycey2aUa4uOZM4m2UGU1doMsBGtkEpHXQfPWA54jT8wIr2KzKcXsd9jPMC2jc42IITWxddFnrkoEcUnoimYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7342
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE1OjUzIC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiBSZXNvbHZlczogQ292ZXJpdHkgQ0lEIDE2ODU1MTMKPiBGaXhlczogNGZlYzk4MWYxOGZk
ICgiZGlzYXMvcmlzY3Y6IFNwbGl0IHJ2aV9vcGNvZGVfZGF0YSIpCj4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+CgpSZXZpZXdl
ZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3Rh
aXIKCj4gLS0tCj4gwqBkaXNhcy9yaXNjdi5jIHwgMyArLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZGlzYXMvcmlz
Y3YuYyBiL2Rpc2FzL3Jpc2N2LmMKPiBpbmRleCBlODVkYmFjMDM1MS4uZWY4YjdmZjIwZjkgMTAw
NjQ0Cj4gLS0tIGEvZGlzYXMvcmlzY3YuYwo+ICsrKyBiL2Rpc2FzL3Jpc2N2LmMKPiBAQCAtMjU2
MCw3ICsyNTYwLDYgQEAgc3RhdGljIGNvbnN0IHJ2X29wY29kZV9kYXRhCj4gKmRlY29kZV9pbnN0
X29wY29kZShydl9kZWNvZGUgKmRlYywgcnZfaXNhIGlzYSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgMjoKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAmb3BfY3NycnM7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKG9wZXJhbmRfcnMxKGluc3QpID09IDApIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAob3BlcmFuZF9jc3IxMihpbnN0KSkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAweDAwMTogcmV0
dXJuICZvcF9mcmZsYWdzOwo+IEBAIC0yNTc0LDcgKzI1NzMsNyBAQCBzdGF0aWMgY29uc3QgcnZf
b3Bjb2RlX2RhdGEKPiAqZGVjb2RlX2luc3Rfb3Bjb2RlKHJ2X2RlY29kZSAqZGVjLCBydl9pc2Eg
aXNhKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAweGM4
MjogcmV0dXJuICZvcF9yZGluc3RyZXRoOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuICZvcF9jc3JyczsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y2FzZSAzOiByZXR1cm4gJm9wX2NzcnJjOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNl
IDQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRlYy0+Y2ZnICYmIGRl
Yy0+Y2ZnLT5leHRfemltb3ApIHsK

