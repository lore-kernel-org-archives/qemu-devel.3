Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8126CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PEu-0002cL-SM; Mon, 29 Sep 2025 21:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PEs-0002c8-0U; Mon, 29 Sep 2025 21:33:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PEf-0001pM-81; Mon, 29 Sep 2025 21:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJcjeJAX2Td9bzJ2h0eMsg2S1vc4vtV2uvLzVE2BPsjeNtKiEH2aBm+getKLcZWtkkg5Pcrtz6YQEq0OtqsA2RZXXOEjxctMmDsebf6WLemnLB8nOIf4PbqiYZgYNslaDs91JbjUbTpCseL6N2cLaAEoXRh0e5iQ89BijOuAja9rnrxjfuRxDm89h61O9kGuhWOe/prpcMzb0MarNdw02y8Otb9bsGTAKgmlk/tWTbB/w67endK8oFjh8++PKFT/FZx4U5St0TLGiQyU3Q93wy2APTbwEVb4I5DyZi5ECMWwLJxVP0y5PwAIiuju/gtFpMrVoijDWumzuN5TazPhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OZ47GBRoVglfq+31Ij8N3jZFLDzZjngboA4+RUhXns=;
 b=aXNfbDTEyCQJIHbIByWzvtxeis4d2TgShQUukLEw+8ng4LdIMaV2Tbl0ANSc0N65dumXLy6iY7QNG/VgD4U2tDPgEUnr9OSKJwWjec92OaPadnkg56euOp56EtoXYNWG+SE3DnkAiNlQxNKVlx2le/y+ueDBmJPgmQy9+6QNQnpiRLGXbGMEd/CKWm5r5mCbmmzrBlB1KcM8T0N7MHzktE0SjRLw2/Y7iAIzLzh46CkTsPxnEIzho+cFDQVQ+/9sD5vx+sMdhoaaBoymLocdEE8Xa1bF8pN4a2oiA3YNn96FqlkU/e9L0Su28EvlXhjxdUycTKVbD+Caps+ex8V+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OZ47GBRoVglfq+31Ij8N3jZFLDzZjngboA4+RUhXns=;
 b=ZncFOOzSpdjV/B0+4KHnVrMVjnYcnq7yamgfXSJQdV/BjO7aMclhtO3xOWszDwDxJO1OobKVdt+4a976fdznI5ATt6VCCdn/pOn9JX/p2Etlk5vOv0NHdmnPloQq4EiAj8RPRp2+np0hU6OMrOfS5p6qKBbSzyN8yv8AVFFWkSRGLrpeH/UmYMGC1WGOOmLcob0JOgc7UG1+X1p6LhjeOfP9fHM7JE36HWYS8fs/5NRHY8/X7/a8uYr0TPG1gwhDLGyXV28dyFZ9IMj8pNgAeyIf4ZMKl54m+WwIhsoZKeMttLDBtkaMgh1Ir40QIes4h0m7clon/YwElsWHe5d0SA==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:32:38 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:32:38 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Titus Rwantare <titusr@google.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 0/7] Introduce PCIE Root Complex on Nuvoton npcm8xx and
 npcm7xx
Thread-Topic: [PATCH 0/7] Introduce PCIE Root Complex on Nuvoton npcm8xx and
 npcm7xx
Thread-Index: AQHcIdaw303Fvu5nv0ev6gz/fcIHRrSrEByg
Date: Tue, 30 Sep 2025 01:32:38 +0000
Message-ID: <TYPPR03MB9497C05DA92E104D5418693EDB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 72396932-7487-4935-d638-08ddffc13dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Qm5tb2NCTlllQ0pZM3lFMVFKZmcrMStHbnJWUEhsbk5kZjJoWmlsenE2YlJr?=
 =?utf-8?B?NEdEampXcjVnaXl4NTJodUsrS3BLL0pHbkxiQUNaWDRNY3BOd1NDSUxic2VI?=
 =?utf-8?B?MGdCR09OT3pQTDFUallXZUlQUHBRZXpTQURpSWVEb0Q0RlZqeTAwQmNxZHhP?=
 =?utf-8?B?Q2toMW1tQVUxUXVSMi8rTGY3NFlpRzJYMVlxaGkvMGxpQ2lIYkZ2VUZpbU1t?=
 =?utf-8?B?SlR6TnRLMkI3cjVaejcvUmxqS3pORlVYRnJlVThCaHg4SjJrMkx4b2R3S3d6?=
 =?utf-8?B?ZW9JbTJnWFBicGhRSE1BeUxNZVZWRjJSVHdzSUt0L2paSjZBSzJ2TDd4WmF3?=
 =?utf-8?B?UmgxVTRNcVFBdC9kMWZKK2VxMjRXd0s5VDR2bkJVWE9CakdYVmFEZmM4ejlV?=
 =?utf-8?B?N01oRUxiNnA5eFcrbjFhZzc3d2lSdktFRkVXWlhJM21YdkFvNWhLQjUvRmp1?=
 =?utf-8?B?MEsySlZwb2VFVkNZS1pkVzViUXNWc3RzY0JwSllOdmNLakxFQlNzMjE4MXUy?=
 =?utf-8?B?bDFxZWhHbTBnaEJuM0Q1THVzeEZYSjRnMnlHR1FWZ1Z5bndiYi83S2h4UzNZ?=
 =?utf-8?B?VFk3UWFuNkJJZWVYTTNBY3J3bnE0TVliaXYvOTlNUlc0MGU3dTRJdnV5MGhJ?=
 =?utf-8?B?RXVYNGpleHZTcVpUN3E0UHoxM3U2Zjcwb3ZibnBDZmRSdTFFS05HVS9zb2tK?=
 =?utf-8?B?T2JrYjFlTVovTDhYSDZOK1g0QkhEVjJWTUpzSDJoSDBTNUF6TnA0ditNa3lR?=
 =?utf-8?B?RWt6YWZnWmYxODIyK25NR3JFZEtNV3V5NFJBSm9mdzNjVWdEaTdXeU5vZlJn?=
 =?utf-8?B?NEFKVklOTVBpbStpajBja1lzci9MZkNjSldScWZTTEx0VktiNkFVbE1PbzRv?=
 =?utf-8?B?TUZYTXpQdG9RMEs2VTVXcW51NnQrNW0vV1NOOUE1U2kvdTZreG9taGNuaENl?=
 =?utf-8?B?OHV5bUR4Q1hkNTB5N3RKV1ZSemlXQTZpTGwrdTVKTWFDeWVyVHJObDd0dTNh?=
 =?utf-8?B?ZTdTYkZoSlBnRkZUMWlIWlNGeXRIRjFnUzlIWmZpMXJ3UVlGbjI0aDd2S0pF?=
 =?utf-8?B?MCtKRW9RdHJqb1EzSHc5UEFCSk5yeTR5eG94V2RTSmhKdUdqdG50V01OVFRZ?=
 =?utf-8?B?NlpJenBQb01LQ2dNcWsyRzUvaXdjWVNNdnVVNlNrQzVDL05FMUh0aUxUVFhZ?=
 =?utf-8?B?TXNVdE9EdUZuQmJuV2pTelVXSDRNUEdOd3VTKzlLSFA4ZWhseGFhVFZjU29a?=
 =?utf-8?B?U1hSN1dWbHc3cDdFMHJKUzBIQW8wWUNhc0xqZ05hL0dyUjFrMkt2c2dJVEV3?=
 =?utf-8?B?Y1ltemQ5K00vRjd5emU4K3JUazc4dERTL1FZdmxOYTNQRU51TERKaHF2U0J0?=
 =?utf-8?B?ZzFUNEpQKzB2N3dTUDY4bkxZK25CUFU3YVZyR1hLVzNmdks3dHVjSVZvaExC?=
 =?utf-8?B?WVhZcm1SckNsN1NnVVRMQ3dYQTlQcDE4cS8wM2UwM1VTd1hxWGpVcmwyY1Nq?=
 =?utf-8?B?cFI2NUdJY1VGcnpBdXF3TVk2YXNJTU9YUjBOeTh4VldBRDBOVGlMWWNCYkJS?=
 =?utf-8?B?bDdsaFl3MmRDZVRpVW5XVDdBamhMNk1Zbjh3bTV3bkZRYjJwREJaVWdrSFl5?=
 =?utf-8?B?emlMTTZYUnovZmRYS1ExOGxFMXlNYjJCK2txM3E1ZTROcXZBbU5KbUdXbDdD?=
 =?utf-8?B?eWdDVmwxclM2OERoMWdoWWFYOHlWbTZNTWtYbndPdVBBdHM4YlNndmlqOVRC?=
 =?utf-8?B?UkR2RVFUUldubFZLU256NVg4blhweFZKOWhmOWVqK2xQWDUyUXBsM0xCSzJO?=
 =?utf-8?B?UThUaGw0Vi9OUXdOTS9WS2VTdHp3d2UzU0VnTkU4Y25WRTgyMFVvN0Z5MXph?=
 =?utf-8?B?aGVpREkvK2IzVmliNmpldjJyeXVOclc4ME1Wd3NUWXdFTG1RZFJaMFhzcWJ3?=
 =?utf-8?B?bllqVzB2YkFkZFV5eVRoamZ0cWFVSGZaR056ZjNia3RiSG94SEJVVjFmaFMx?=
 =?utf-8?B?enR3OEZuK1UwV3RDdDlZK2syZEMzYkYyT3ludE91K0EybGJuallDbm5SYTRm?=
 =?utf-8?Q?wgea/G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFVRbEtTMFU1SStCWWJURThBby9xQjdIUXJEdDRvL0x5THo5bXgyU1paTWR5?=
 =?utf-8?B?RWZyYm5MN3NMMWlwaWNVa2RXaW9sOUZwcStjVEZKdGduMGtyMU9tRms5T2NY?=
 =?utf-8?B?VVlwYVVUTnpHMGpYNWVyL0FUQ1B6Q3Qzay9QeVMvNCtmWGZaY1RzUlNZaFNj?=
 =?utf-8?B?SE9weXJHblg0bHpTRS9XS0hTSHg5ekFmdmVqbk1mdE1INlJMRzZyV01MbzF6?=
 =?utf-8?B?TG1aMit6d3YzM2pDc1NKaitQZmNyWU5xM2MvUzZUdGJ4YVdPdE9DWk9qRkl6?=
 =?utf-8?B?bVkyTGNXNTBldjZOZk5Ta0RIMExBSlhXWWZkZGVCK1JHV2krb3BlYjRhLzlw?=
 =?utf-8?B?VFdxM0ZRRVVHakQ0NEpDSVo0MGtYajVjV0h3VEp1a0dXaVpWS2dqcXBpaDdu?=
 =?utf-8?B?T29RTm04WmtjaUwwMTNWYU9sZzJRcTV5eFZ4b0J1UmI5VENVOU9oajMraGZi?=
 =?utf-8?B?NCtwd3BoaGQ2Umh4Y3R2N3l1eG8xUXlmRlozdFJzUlh3ZkpJenVtb3NqcEVV?=
 =?utf-8?B?WHdjVHFZMUxtVXVlS2xoSXBhSDdIbVJ0bmRwQXp4ODNKMUF3dFhSbHplRDE0?=
 =?utf-8?B?Y3ZRcFRMUHhaYitrb2l5SDZ3MGwrclM1ZFF0QUk4UktQZ1IyOEJvU0Y5Z2Ja?=
 =?utf-8?B?YjUrYlBTVzhPbWhidnR0UFFNYmtHNmFBekdEbEV6WElyekFaVWRaUEkrWndV?=
 =?utf-8?B?OG5kZTdGN2dFeUhtckcrVTdzVkdYUFVIWTdkUE1KTktHQ3IrZFBiRDIzd3dM?=
 =?utf-8?B?eG1OU3MweDlscGlSaDUrTWRUVDF6c3YxejFOWlhmb3oveWRDaDlNRUF5QUVj?=
 =?utf-8?B?R0pna3VCOVJYbjdYcWhONCs2RXBqY0JPWFYvUFNyTkJNWi85Y2tpSURSMXhz?=
 =?utf-8?B?ZFpjcm1BRHFlaytEL3l0WG8wTWZZUnp1Tlp2dHJ2dGtBMnZTQkdXbDdKbG9q?=
 =?utf-8?B?M3FOR283MjV3eGJyTVljeGMwaVdycjVyWXlHVW5NYmhzTnZVd0Y0RUJ0S0M4?=
 =?utf-8?B?QUMzOEwvK2JyU2FROVVZc0xZMFRPTG1XMyszQmRERENmTk9Zd3RuY0Y5MVEv?=
 =?utf-8?B?L01TOFFsZnRobFJ0a1dNeW1Nb0U3UWUzVDhFZmlhaXFxQXdwMlhicnV1ZUlU?=
 =?utf-8?B?L2hMaFU1VzBaWHdPcW0zNDBFTS9aSVVhSTE1bk5GbHRLeTIrKzdKZ2Q5NzJS?=
 =?utf-8?B?d3hnTVNrN1NsSjk2dWdZL3lSNVkzM1dabm9ya1krbzRwSEJwcmZzbDM3NEFG?=
 =?utf-8?B?L08vUlN5STVJaUZGR0p3bG1hclVNYklZdlFNMUdaYVU1SmI0MGsrTjAvMHhP?=
 =?utf-8?B?bTR6WmRtZUhzNEVraSt1N21Xd3hQVW93R0I1U3VzUTdRRXVhWllOdzZtejQv?=
 =?utf-8?B?V04xeWZ2anNiaEZrVEQzTEh5QzR3MDNVUHBCV1RYbUJVWENQWGxzNmdQeUpj?=
 =?utf-8?B?YjYvRFZDWDFVbW50bzl3SXFWa0dseW1TVm1HbUtGSG9udnpDV3lsWXQ2dzZo?=
 =?utf-8?B?emExdDVyRmNLUVVDaEkvcjFJdVRrd25uU1lEK2pnQ3A1bmFRU0JBWGY4VVdq?=
 =?utf-8?B?VUNaMG53eVZKTjRpb1Z3Y0ZGQTdDalZMZnhqSlFNODZyaWQwR01LUFpiQnRk?=
 =?utf-8?B?U0pXWFFDdFRZc2M4cWo2M2szOFYyWWJTSmRXVXVrRjF3YWhTQ3U0OGpCZTFh?=
 =?utf-8?B?SDd2T2ZBTzVrbDdFZWxqOUtpRmI5SCtQd0NnOGcydkE2a2hDaUUyY0drelhy?=
 =?utf-8?B?OGR5amVnemc4L0FoczJsTVFaMmhaYWxVS2c3WjBGWEVoODFiYnJyeFVLNVJQ?=
 =?utf-8?B?MUd1akg5YVFtbm5aYkYrQzQ0RnJ1RkNKL0NuUE4wc3FLaC9SUGpyWVJsMmhO?=
 =?utf-8?B?T2tBRGNlelBxUCttQllacG9EWjR1VG1TWWU2SHIvcGFwWUNLM0krUGZzYkpT?=
 =?utf-8?B?L3BuTDNweWpQd25jZ3lUUDZYaGhUSTQ3VG1SZGRpMUtvWVpBU2RmbUFkY09R?=
 =?utf-8?B?dHJidzRocGp6T0pxQzFIT21GVlVwS3JJSnNGMkh3TUllUkNsMjJxZ0gwa1hz?=
 =?utf-8?B?eklnUVg5b29PWFJWMzdPcER0NXg5VElDWDEzR1pzTFVGZWF1VCtocWZ2dER3?=
 =?utf-8?Q?CysuFqRE2qj6K546yNWKokwio?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72396932-7487-4935-d638-08ddffc13dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:32:38.5391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8CXg7KXlF1rGB5ecuhnY5mmdcqC9h4u36abyn/GUjzdo6FKcR40y1H9uYDlOuencBdvAlrVGu5Vl/mM9W9HMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=KFTING@nuvoton.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTAsIDIwMjUgNjoxMSBBTQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBDUzIwIEtGVGluZyA8S0ZUSU5H
QG51dm90b24uY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgWXViaW4g
Wm91IDx5dWJpbnpAZ29vZ2xlLmNvbT47IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNv
bT4NClN1YmplY3Q6IFtQQVRDSCAwLzddIEludHJvZHVjZSBQQ0lFIFJvb3QgQ29tcGxleCBvbiBO
dXZvdG9uIG5wY204eHggYW5kIG5wY203eHgNCg0KQ0FVVElPTiAtIEV4dGVybmFsIEVtYWlsOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGFja25vd2xl
ZGdlIHRoZSBzZW5kZXIgYW5kIGNvbnRlbnQuDQoNCg0KSW1wcm92ZW1lbnQgdG8gUUVNVToNClRo
ZXNlIGNoYW5nZXMgZW5oYW5jZSBRRU1VIGJ5IGFkZGluZyBlbXVsYXRpb24gc3VwcG9ydCBmb3Ig
YSBuZXcgcGllY2Ugb2YgaGFyZHdhcmUsIHRoZSBOdXZvdG9uIFBDSWUgcm9vdCBjb21wbGV4LCB3
aGljaCBpcyBwcmV2YWxlbnQgaW4gYm90aCBOUENNN3h4IGFuZCBOUENNOFhYIEJvYXJkIFNvQ3Mu
DQoNCkltcGFjdCAoQmVmb3JlL0FmdGVyKToNCi0gQmVmb3JlOiBRRU1VIGxhY2tlZCBhIHNwZWNp
ZmljIG1vZGVsIGZvciB0aGUgTnV2b3RvbiBQQ0llIGhvc3QuDQpFbXVsYXRpbmcgcGxhdGZvcm1z
IHVzaW5nIHRoaXMgU29DIG1lYW50IFBDSWUgY2FwYWJpbGl0aWVzIHdlcmUgZWl0aGVyIG1pc3Np
bmcgb3IgaW5hY2N1cmF0ZS4NCg0KLSBBZnRlcjogUUVNVSBjYW4gbm93IG1vZGVsIHRoZSBmdW5k
YW1lbnRhbCBhc3BlY3RzIG9mIHRoZSBQQ0llIGhvc3QgY29udHJvbGxlci4gVmlydHVhbCBQQ0ll
IGRldmljZXMgY2FuIGJlIGF0dGFjaGVkIHRvIGVtdWxhdGVkIE5QQ003eHggYW5kIE5QQ004eHgg
bWFjaGluZXMsIGFuZCB0aGUgZ3Vlc3QgT1MgY2FuIGludGVyYWN0IHdpdGggdGhlbSB0aHJvdWdo
IGEgbW9yZSBmYWl0aGZ1bCByZXByZXNlbnRhdGlvbiBvZiB0aGUgb24tY2hpcCBQQ0llIGhhcmR3
YXJlLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KLS0t
DQpIYW8gV3UgKDEpOg0KICAgICAgaHcvYXJtOiBBZGQgUENJRVJDIHRvIE5QQ003eHggU29DDQoN
ClRpdHVzIFJ3YW50YXJlICg2KToNCiAgICAgIGh3L3BjaS1ob3N0OiBpbXBsZW1lbnQgTnV2b3Rv
biBQQ0lFIFJvb3QgQ29tcGxleCBzdHViDQogICAgICBody9wY2ktaG9zdDogYWRkIGJhc2ljIE51
dm90b24gUENJZSB3aW5kb3cgc3VwcG9ydA0KICAgICAgaHcvYXJtOiBhdHRhY2ggUENJZSByb290
IGNvbXBsZXggdG8gbnBtY204eHgNCiAgICAgIGh3L3BjaS1ob3N0OiBhZGQgTnV2b3RvbiBQQ0ll
IHJvb3QgcG9ydA0KICAgICAgaHcvcGNpLWhvc3Q6IGVuYWJsZSBNU0kgb24gbnBjbSBQQ0llIHJv
b3QgY29tcGxleA0KICAgICAgaHcvcGNpLWhvc3Q6IHJld29yayBOdXZvdG9uIFBDSWUgd2luZG93
aW5nIGFuZCBtZW1vcnkgcmVnaW9ucw0KDQogaHcvYXJtL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgIHwgICA0ICstDQogaHcvYXJtL25wY203eHguYyAgICAgICAgICAgICAgICAgIHwgIDEwICsN
CiBody9hcm0vbnBjbTh4eC5jICAgICAgICAgICAgICAgICAgfCAgMTIgKy0NCiBody9wY2ktaG9z
dC9LY29uZmlnICAgICAgICAgICAgICAgfCAgIDQgKw0KIGh3L3BjaS1ob3N0L21lc29uLmJ1aWxk
ICAgICAgICAgICB8ICAgMSArDQogaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuYyAgICAgICAgIHwg
NTg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaHcvcGNpLWhvc3Qv
dHJhY2UtZXZlbnRzICAgICAgICAgIHwgICA0ICsNCiBpbmNsdWRlL2h3L2FybS9ucGNtN3h4Lmgg
ICAgICAgICAgfCAgIDQgKy0NCiBpbmNsdWRlL2h3L2FybS9ucGNtOHh4LmggICAgICAgICAgfCAg
IDIgKw0KIGluY2x1ZGUvaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuaCB8IDE1NSArKysrKysrKysr
DQogMTAgZmlsZXMgY2hhbmdlZCwgNzc5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQot
LS0NCmJhc2UtY29tbWl0OiA2YTlmYTVlZjMyMzBhN2Q1MWUwZDk1M2E1OWVlOWVmMTBhZjcwNWI4
DQpjaGFuZ2UtaWQ6IDIwMjUwOTA5LXBjaWUtcm9vdC11cHN0cmVhbS0xZWNhNGJhMWM0NDgNCg0K
QmVzdCByZWdhcmRzLA0KLS0NCll1YmluIFpvdSA8eXViaW56QGdvb2dsZS5jb20+DQoNCg0KVGhh
bmsgeW91Lg0KDQpSZWdhcmRzLA0KVHlyb25lDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiBUaGUgcHJpdmlsZWdlZCBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5k
ZWQgZm9yIHVzZSBvbmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3Jp
Z2luYWwgc2VuZGVyIG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUg
aW5kaWNhdGVkIGluIHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZl
cnkgb2YgdGhlIGVtYWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8g
dGhlIHNlbmRlciBpbmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2Yg
aXQgZnJvbSB5b3VyIGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91
ciBjb29wZXJhdGlvbiBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBh
bnkgdW5hdXRob3JpemVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3Rv
biBpcyBzdHJpY3RseSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1h
aWwgaXJyZWxldmFudCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBi
ZSBkZWVtZWQgYXMgbmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==

