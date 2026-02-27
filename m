Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE8AFD9E26
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 00:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvlLw-0001Y4-0o; Thu, 26 Feb 2026 19:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlLu-0001XM-V8; Thu, 26 Feb 2026 19:05:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlLs-00050e-Tk; Thu, 26 Feb 2026 19:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772150705; x=1803686705;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ma1NsxMmTaaDXvAhmaJtsUHE9RKclBqrRWLhS0d8wwo=;
 b=hA2Quo5lPe5rbwim+nrGAfLrq4U9cyqkYUs1QYljUQDkbW/RavEsKqzu
 l3lsJQbZ4kJzfI2DfaMBBRfi09PaSulFU9e5ip8T8HE2U1CXtdYCqDeEp
 cgC/048O58ixbMlEYhslln9VYc7g7On4Fxp4XaoIifLu36LlUJ+6lpubL
 DLAoUf8lR5iqJOkh6W3/SGy/9wR4MF4re6vAURVqxj1OaIYXb2g7pEADy
 w0XnSMJR7M8tBKJ25LB2ZUvvX7yS/FNl4+tdRXdqNx6AYf6ZBsk9Qqo3r
 4pcVzkUQD9HWqJq3F5G/7uJGosm7CKvCknlMUI0xku305J25RtzxDIutE g==;
X-CSE-ConnectionGUID: Ah+moTfuTOate/EK8XoSQQ==
X-CSE-MsgGUID: ZtxsWHjgQFmr84CNDGmlIw==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="142104854"
Received: from mail-southcentralusazon11011067.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 08:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6ZF/rqqLEM8w5ykR72HbkJtwJONFQmfw/83T2xIfywABhDH1Z12ytr5FPFFLh7W0eIMHhOikSHEitXCkFrlssA/tfnur1TIQbIoU2u0hwvKV0qhW9NzPiNtj+bhKlhH10f78AMs6zUE6Blmn0YxmZ3+8ObHw+FrHxSThEQ1OXb53ytYEVH8djcBB0VHwE5PkQ+9oQpWBUF1qXxdFYkalTOAtUQ50QBt4cU9sj90CpHREIL4tcJ6k6vQvByNBV51UDWDNvbvYPNOAAdLL+JlCD10VnwOuaJxpz86uR0K2KgJtrcpANqMz2NyVe1tHg2k2nd8wLk05vzreEu4qGphOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma1NsxMmTaaDXvAhmaJtsUHE9RKclBqrRWLhS0d8wwo=;
 b=ALa7EKkO+4Z8jpefRM90eZDaDW/PAt+7jnjMUHSduQ2frblQprocVhT4jgzs0ep1+D/axgp3VWbRUvd/7pTrsSAQgH3RH0dv+m9KKWlvnd3ro00M/0FD378egkieqWw4kiweb/C9dcoMTR/L4W05qzVi/l9FW+7eExH77j5HeGnqIvb+F4G4Vvy5D4ZEe0Dn+I0uluXkvmyyRL7n2KFwbeIBtoAPI4rusJfL41soHlJCyXnR1wKDagEMEP1zRlCm9d+EJiAweQ/evQOuKhwosZdmGF34d812zaZDkMlwgoebK35KviNLYZyZczGGtYrdaS3k8c751pjgzgzJwtnVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma1NsxMmTaaDXvAhmaJtsUHE9RKclBqrRWLhS0d8wwo=;
 b=HC0R4yngEz8jP13zZqjZIKUpsteHRhW1CUtvgy52+GqIg+sgUifmDA24qurTDIJK1fZrCFDfITCf1cKlewZNkVEQrMiPx5mMkidYEnhpg7MehrfrzQQSPrxjIMVte5F0Q94o40e005mv+iZTZtSoyMb9ZB+xx3xE8qA1r9Vobqc=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by PH0PR04MB8550.namprd04.prod.outlook.com (2603:10b6:510:295::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 00:04:54 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 00:04:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lex.bailey@lowrisc.org" <lex.bailey@lowrisc.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "amitkh@google.com" <amitkh@google.com>, "qemu-maintainers@lowrisc.org"
 <qemu-maintainers@lowrisc.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dave@treblig.org"
 <dave@treblig.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH qemu 05/11] [ot] target/riscv: add custom mtvec CSR
 management
Thread-Topic: [PATCH qemu 05/11] [ot] target/riscv: add custom mtvec CSR
 management
Thread-Index: AQHconoKYYvRG3mDL0mnJjygp7fQVLWVtG6A
Date: Fri, 27 Feb 2026 00:04:52 +0000
Message-ID: <d04ff0cafaca927beafe9b3a4796d9c9e689da28.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-5@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-5@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|PH0PR04MB8550:EE_
x-ms-office365-filtering-correlation-id: ec4393d7-6786-4db4-aad8-08de7593d4c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: Wj0fc+UtDCRkI7lZLt4X5cVZGX7Y0k6ywaQIzi9+p234cxD8sjUSeNV3UOYpJE/NeUu/vax+jZnWh+eWbzY81HlFCGGaByPKrZOfUG79PAUT7Xz8CEPKtq5v4+6siqzDyumIhHij1KZ5EbDqNqJmOnMEIlxJgs96YuyesZm8hkmfXFUlr0KM1o/4W75x921NwjKmKqdenZ0NoelnEiohf9TMgAi+ljEv5FfzSpIqKxNKK05yIi7wMt6CjKXE8ukVbLdDM9cH1bkZYAnKc7KmO75veSnhidBjeB1Z4mRHPl4csAe+IzFoIX8fvLal6tL/hHe7oZ+khONgtJ+qBceLTtpmq/kcjkeifP8U8tqi+HAX/vw/gK34X78ya7O5+PvduO6UgSxEkEUsBAXrbLw766QHpME4OTVIJWf1EQujDXyzjYQ/Z3t0lai8whoGqWNdwqD7O9nBCkTHpDzbAuQR9nR7p0hXBxHP38AeZJsBoX2O30/ma3rgTlrbLVk7BD8l33vdGEVbvgFSLGKFFmTplwu/txukYF9+aAuZNNbPZSQr9jEmxe5t5pUcHfoJEWqltFcc0nufX+/ohqYy9NJsqEpyGthdMICobh71N1RqAn14aaH6sgemnb+1rgtdsb7CRyJ0LsQVAUBtjNWizPlZKwVhwGrQhyEwalAlgPhXldCCSAughgDgF81oyBQbpXqHETxHdByIVZ9D+f4mp1bP/e7SpZbvpZkCQXPHudZ61a5QwRcSn0YWSLB2jhYmfbK9NN92f9UYIsgrUO4HVV/QlYuMJsdyMpUcOgGJJrRW/rw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZzYWV0V3ZQN3BURzFvcWRuenowS3Vna1JXUUpQMjFCQ3UzTEtTSUpzN0s3?=
 =?utf-8?B?Q2FUU1NXZ1pLajB3NjJYRndrb2VpUDg3RytKRWhnaEhQeXZjOTB6S2hMMjFT?=
 =?utf-8?B?ZFJLeG1XT0haRWdQemlYSDAyblJYSm5uQU5Ud3Y2cE1JWEJVTEFuVG1xdjVT?=
 =?utf-8?B?L0dRVEZsUkY3VDV0dlZVK1VuQWRZQUM3S2pZNTdPTjJTMmxDeHNHN0VpMXg1?=
 =?utf-8?B?czZaYjNVSHdBVW5QQ0VhMHR0bmdqQ3c4VTV0VlFPRlVlT2dHQnBEbXdBK1ZQ?=
 =?utf-8?B?SFJ6RklCeWkvMjZMRDlWRnVHR29Kc1hVT09KUld3Z21PZkNzb3BwN0VRSkFT?=
 =?utf-8?B?L1RUbFB2WktWdE45S3ZGTkdJbHYzSjRNMGN0Tm1SendvOG9QTE0vRXhrcEJa?=
 =?utf-8?B?STR3RjJmWm01R2Rxd2lsUHVERm1YVmFoWjd6ZVcxSENYOUkwTlZsVUIybHl5?=
 =?utf-8?B?TjYwSVVHbEtEM1JFalIybXgxUU5EN3p5ekVpeXlTWnlqWnROWGE4QTZhZ3NQ?=
 =?utf-8?B?QkRLN3pzdElQcWdRTnlqNE5VT3c2WE5Qakx6R2l2WHNhb1l0Qm9HMitlaTJD?=
 =?utf-8?B?Zlg4dDZFVUtNMzBGdmVGaGFKbXBUNVJEbk9tbXlQb01ZcUoxdHJiTGFYY3Zz?=
 =?utf-8?B?WVdrRGJHNmFUT1JkR2NHbVJETk9aeXMxK2c2ZlhJSmkwVlV3UDJGdnE4NHEv?=
 =?utf-8?B?VlcyWEF4UW02K3UwRmtKVDNyN2R3ZmdoZnhiWllqeTlvQzZOdkVoSm5SZFdQ?=
 =?utf-8?B?ZW1zUGNVeUFxVzFHZGNiU0tlcTRsZHF1TGE5d2pzZmg0ZmNXM3JjN0ZydEZp?=
 =?utf-8?B?N09pMHFiV1cyTkdBVTVpcXMydHNndTQ3NHorM1JaYVJzUWlPanhxeVdkak1y?=
 =?utf-8?B?di9DMXFTOFhtS3pqTURub0JlaURrQkE5RVczQWtrRjNKTDRLSzl6NGV1UUs0?=
 =?utf-8?B?a2xhVjlHaDkrcUN6djZ5bURXLzFwU3NJWjgzN1kxckxqZTkvbGN1TzNBTUgx?=
 =?utf-8?B?VTB5UTc5disyY3JKU2hES0dUVkJtRXp0eTZob3BNcU9mdS92QmZDQ3lJdmZX?=
 =?utf-8?B?T0grYlV3NVp4YUZrSEFieXBHZVYyWnpZVUhZaVBGSGEzd1RGMXp3R0N4M212?=
 =?utf-8?B?Y3poVGhuRzNZTmZ0S2hBUVI2MHluemNTOGxiS2FsNE9pZXNEeHY0Sk9wV1Rr?=
 =?utf-8?B?Q3ZkdUhwM0pGUWUxcnkyb2svdUFmQjM4NUdKYVBGMzEzNzQvWlQ1MTFxY3ZR?=
 =?utf-8?B?VjFUb3hURERGclp0VXI4OEtuU2ZqSzNZQjIzdXR5Y0tZZDZacyt3VHdtTzIr?=
 =?utf-8?B?T3VvRWtwWWlEcVE3d3QxNTFDV2dteHRhWFVnWXFHK2JkR1d1TjZRdFpRSGw3?=
 =?utf-8?B?WWJhaFBrYlYzYXkzVHpZRy9HbDVNbkRhMGJIbmM0ZmM5WHZjQWJEMUdQWGxp?=
 =?utf-8?B?eGkwTHV2aVBjUGJJNEwwSkVIajJRS0xvc0lJaWp5NW9TajBwcDdHUXFTbGRW?=
 =?utf-8?B?dU9pRVk4VFVXZzZ1OWkxVG5jNnh1cnBvNkFRNFMrbHYxQzA0TDRUbXFMOG5V?=
 =?utf-8?B?VVZ2RGVEYkVVTmM3NlhJSEFaS0pRYitacWVnMGRwZUM0azArQWtoYlRaY2Iz?=
 =?utf-8?B?ODhWRzc0SjdHTXNUdXJYY2daYmhGRDhNNm1TeWFtNFpMUExYeVF5OFN3ek1w?=
 =?utf-8?B?U3BwdWpKYnRRcG5jbzY4MTBLN1JSY2gxdEFlaUovcmtOVkZKTmxhMlFrcXNT?=
 =?utf-8?B?TW9xNUw2aWY2eXlxRVYvN1lQalNvaDViNHFTZ25MNEtkMjhZU1FjTEE4a0xv?=
 =?utf-8?B?QUFYNEVwc2hYR2I2enRqSEo0enJjYW1KemRjNEVkOHI5eXBxTFZEK2FTSTVT?=
 =?utf-8?B?bElxbUluSVloa0xON01iR2lJVU5DYncydFhmakQwUHEvOUZNWXN3bnNZYmM0?=
 =?utf-8?B?Ly9MQXc4bGxQTnl1cW95dFlFR3Q0R09vQVgvL0pFakhWUkp0c2owVG1mcTI4?=
 =?utf-8?B?TEZKb1lLbkNZb0xzVkN6NFI0UFhURDY3Q2RDbW9rSDRDekJ4S1o5anhZSU5w?=
 =?utf-8?B?Yk51aERGaEZQbFIzblVBMmdUTEY0V2crR3NrQ01qU0NxYmY1ZmIxTXVJd1lY?=
 =?utf-8?B?RGdKUTRJcUdrSmFzRXRETjZMVjNFNmplSU81ZGQ4US9pd0pEYW5JbHBPUzJK?=
 =?utf-8?B?Y2tYN1A1MUJHbURLSEt4M01MVWdwUzBNcUdKOTBudll4amkrL0EwZGhiRzhS?=
 =?utf-8?B?ZjZEUFZKbW10d2htdWMreHVPdmRWa2RHenV2bXN2NEVqd2NQTmpnRTRhcHJa?=
 =?utf-8?B?Y2MrSXB2NXdaMStmcmJySy90OHNoc1ZtVHJZRklHdDB2YmY4L3YxQzhVSXJI?=
 =?utf-8?Q?Ehfb2Ux69mLD0JsleeOJzJoyF5gQYRMcT2dXP0NMLlJAe?=
x-ms-exchange-antispam-messagedata-1: gNHuUQE9guEWZg3+Hhq9/znh6vLIqhTpQhY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36150BAC5A7EF245AA7986649D7BA5BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qz+RPqwMna7uEOoNFp+Fo6/JmKUiHkYfo9EAd7tKpk3dq8EaxH5spRmTStQBqDVoXmbizosc8bF90TdZ7YQ6z8rGsa3P6koJCj0H0sAp0uz9+vQc2Ru+nj/5wqdnRheDtuCz67Hqxb5i9nnTrYRcb1x5vpAcp/lusHDxHhxmGrDeKZCgfI+AFy7Rul9zplb55ilvmX99tGf7TvQdmtIZHPon3e27WCHl9gb8cptONPX2Ojeoy0EIZ5AdDghQTkN208dNEvOReMeuN5+iNeRBILC+ZdW3OenAU1oLR9iiysVGT615Hxge1Cc3yeuBVTDWLYXuIxBPcgn8Wxl+XR2mydXKsWkB5DIuzkKz99v/MkicXyMSgEW5I4H9DxsXl04GQZaMfDfzP9JIk59pd1xEM8U+ulK9vrJEfXAWlPI1ayGmMLu3gNHBDC0wxI2QNSsnokG/vpjRLYBNlq9x5VQGhsq5yLFl2evvrfZGgXf0s+9XMvzJu7mLpL2dIM0SdEfjUotyIPesUYoPN7Moq7nqr7dEtYIG7PmDFrvUBRq0OKv5E8hrHdmicnEBVRldy3d3kgqNcbapzVwERKtldKkxKs2+d5ysI2TXH9/mWPvRNMpwlyAWYFuiYsAX5Is4M9/d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4393d7-6786-4db4-aad8-08de7593d4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 00:04:52.3072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0kGULPHCB0secAqizG3bdlKMxIkYfZ3cP3Km7HjMKC4IaSn54lQbwEZfbwVcfAGnsiN7HidgIC0+CpXfIyrD4CoD1ii2kupgD/lDJA+S50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8550
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=511ad3126=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDE5OjE2ICswMjAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToKPiBGcm9tOiBFbW1hbnVlbCBCbG90IDxlYmxvdEByaXZvc2luYy5jb20+CgpXaHk/CgpBbGlz
dGFpcgoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBFbW1hbnVlbCBCbG90IDxlYmxvdEByaXZvc2luYy5j
b20+Cj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvaWJleF9jc3IuYyB8IDMwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2liZXhfY3NyLmMgYi90YXJnZXQvcmlzY3YvaWJl
eF9jc3IuYwo+IGluZGV4IGQ2MjYzOGJiZmIuLmE2ZTgxNWU3ODIgMTAwNjQ0Cj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L2liZXhfY3NyLmMKPiArKysgYi90YXJnZXQvcmlzY3YvaWJleF9jc3IuYwo+IEBA
IC02OSw3ICs2OSwzNyBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24gYW55KENQVVJJU0NWU3RhdGUg
KmVudiwgaW50Cj4gY3Nybm8pCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsKPiDC
oH0KPiDCoAo+ICtzdGF0aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF9tdHZlYyhDUFVSSVNDVlN0YXRl
ICplbnYsIGludCBjc3JubywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgKnZhbCkKPiArewo+ICvC
oMKgwqAgKnZhbCA9IGVudi0+bXR2ZWM7Cj4gKwo+ICvCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1Bf
Tk9ORTsKPiArfQo+ICsKPiArc3RhdGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX210dmVjKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIHZhbCwg
dWludHB0cl90IGEpCj4gK3sKPiArwqDCoMKgIC8qIGJpdHMgWzE6MF0gZW5jb2RlIG1vZGU7IEli
ZXggb25seSBzdXBwb3J0cyAxID0gdmVjdG9yZWQgKi8KPiArwqDCoMKgIGlmICgodmFsICYgM3Up
ICE9IDF1KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDU1JfTVRWRUM6IHJlc2VydmVkIG1vZGUgbm90IHN1cHBv
cnRlZCAweCIKPiBUQVJHRVRfRk1UX2x4ICJcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dmFsKTsKPiArwqDCoMKgwqDCoMKgwqAgLyogV0FSTCAqLwo+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gUklTQ1ZfRVhDUF9OT05FOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIC8qIGJpdHMgWzc6
Ml0gYXJlIGFsd2F5cyAwLCBhZGRyZXNzIHNob3VsZCBiZSBhbGlnbmVkIGluIDI1Ngo+IGJ5dGVz
ICovCj4gK8KgwqDCoCBlbnYtPm10dmVjID0gdmFsICYgfjB4RkN1Owo+ICsKPiArwqDCoMKgIHJl
dHVybiBSSVNDVl9FWENQX05PTkU7Cj4gK30KPiArCj4gwqBjb25zdCBSSVNDVkNTUiBpYmV4X2Nz
cl9saXN0W10gPSB7Cj4gK8KgwqDCoCB7Cj4gK8KgwqDCoMKgwqDCoMKgIC5jc3JubyA9IENTUl9N
VFZFQywKPiArwqDCoMKgwqDCoMKgwqAgLmNzcl9vcHMgPSB7ICJtdHZlYyIsIGFueSwgJnJlYWRf
bXR2ZWMsICZ3cml0ZV9tdHZlYyB9LAo+ICvCoMKgwqAgfSwKPiDCoMKgwqDCoCB7Cj4gwqDCoMKg
wqDCoMKgwqDCoCAuY3Nybm8gPSBDU1JfQ1BVQ1RSTFNUUywKPiDCoMKgwqDCoMKgwqDCoMKgIC5j
c3Jfb3BzID0geyAiY3B1Y3RybHN0cyIsIGFueSwgJnJlYWRfY3B1Y3RybHN0cywKPiAmd3JpdGVf
Y3B1Y3RybHN0cyB9LAo=

