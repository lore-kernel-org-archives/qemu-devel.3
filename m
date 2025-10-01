Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C2FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tIS-0001CM-HJ; Wed, 01 Oct 2025 05:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tIP-0001Bv-07; Wed, 01 Oct 2025 05:38:49 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tI4-0008Qw-Od; Wed, 01 Oct 2025 05:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcnSw2pvtxKGmTN1KloMV+yTeXdWKDqCLCM3ZipFTlxveJv97jS0NxFLiVLYukuveDEHcvAym35g/setvLDMH9SRUUk7NK7Hdw7L/vrOn4g1sYsSDAYA5Tvm8eCUjWHNixe9b1izVnWOd0gWzKq+1BldzFAAV0+CdWBpAci+yaziW5+6ByDEEL6NZAvpm4pJ5syzwhIvCSi5GLJt8sJxmVHoWrsRFbZvx3aRJeBdtkf5s/U1Ljgn3fRyFcDpVhzA2HgA7EKhhE8bnmSJUIbAIDzz0pNI/AckFxocusLWqpy7CIgqFKARQW5p4JwVk7Z2zvYCRnINCHWfw2FecU5MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzVWXBMS1fA04kzBbFWumVJisDc3ICh9htVpLWVr5Mc=;
 b=iRnkFdHfLp2rwfIsHUFdqQkUIIckFMSnJ/b6R2CXsnfIJEloX0s7DfK/hPWmR7tTIc1OSfU3xieUoy0lC7DxmTf3xPFme58Se6Ivch5IiSbh8c+vKeUGXzbh/EUw7Glz5uP5pa2fl9C7B1/fbCoLsjEs8CH+3Rs9KArfleFh4tU8UMCSHgI63X65y84pAPw7+gvhOs7v7gFC4tJ7KkjrAbGWWto1Kg0uuhwFDN2sdxaz4TsF3SW8VxkN5m9FHzSAt1408NqI/5eI2qlFzoZs2DNOUeMGFu4T1ecZX8LNPkzODu+y58LvmGCev4JBDFbWUSVMn3AwhHZ3xjfgws4X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzVWXBMS1fA04kzBbFWumVJisDc3ICh9htVpLWVr5Mc=;
 b=mJNgOMf/h5ASNDYzVmn1pV4f0jmKZJWzKpyH3oUT3rc4JtGyqyKylSMZOV7B2eQbxP3E5njNmKdAQa75bml2ZC8CWB+F2Spp12PZTNjHotbJaTDpXsJqr/zYF60W9EfRWrDHjnbxjlJINb2BY5UvrtWOQU9o4jK1yUlzxXVBOjLEJoM37/ePl9in3loKdrnw7weWYy88NYesH9s74+27l27mZBAyVKg8wPCADIIKlhPhnNTvSySDWNAxL+HaBUt5WJdg+0N/HPxUCgcqvDZovp//Au+OT9BTZSewwrJzVKMvZRSlSLYDqNw/tcmBhYihJ98gZ4m5GkyViq/HVXqUwA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AMBPR09MB8181.eurprd09.prod.outlook.com (2603:10a6:20b:6ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:38:15 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:38:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v8 06/14] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v8 06/14] target/riscv: Add mips.pref instruction
Thread-Index: AQHcLTQo8VdT08KXYkOLNhB/TfR/u7Sq9isAgAIdpYA=
Date: Wed, 1 Oct 2025 09:38:15 +0000
Message-ID: <7dfd70d6-e9b8-45c9-9211-01e88a4730c9@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-7-djordje.todorovic@htecgroup.com>
 <CAKmqyKP=DLAZ=io1hSr66sZQuWk7zvsAHi1yXtFYL4DhpU5-mw@mail.gmail.com>
In-Reply-To: <CAKmqyKP=DLAZ=io1hSr66sZQuWk7zvsAHi1yXtFYL4DhpU5-mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AMBPR09MB8181:EE_
x-ms-office365-filtering-correlation-id: 34bbf60e-ad0e-4c0f-dea4-08de00ce3f40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?ekJ5K0o0VEpobUtvUWxtS0tOc1RCZ2d1clNrYjRaZk4zVzNReGkrWFF4elBD?=
 =?utf-8?B?NjJNL0VTZTF4WkpSSk9zQkIxQ1J6eEdtV2pwZnN4YythMGF2RDZWNGNhejNv?=
 =?utf-8?B?YWVvOWt3OWxtSkl3WGRKby9mQkhYb1RTcmxtelE0eTJYMFF3M21ldFBvZWNZ?=
 =?utf-8?B?aVZKS0YxeDVSYTlxbGxoYWlOZmpLdStQTThNK2ljNFJJRWJIS1NqZ0VDQkI4?=
 =?utf-8?B?bVNUZXZDbXlLdW1adVBFMmtEcTZSQUNVY3hDTDMwOU4vUVd0N1EwSFlFNllM?=
 =?utf-8?B?QW5qOS9DeHpkQndGVnJjU01ROVpRS3FBdVZFRXh2RjBCc3dDRmtFT0FPSzBJ?=
 =?utf-8?B?NVd0RDZzS1VjMzhPZkRLUWFjRGxmNUtTRndpRGMzdkx3Vk5aZnIxTmNlTEoy?=
 =?utf-8?B?RkFxenJPVGlJcllkVmNMK00wNjUwekdnaDdvdzNSRUc1WjU1dGVta05hWHhx?=
 =?utf-8?B?ZGRTRHNITHduSHY3Y3FuelY0L3R0N0tjUjJIVnBGSkpMRDlUU25QU1J4cEtl?=
 =?utf-8?B?SU51L0YzcUVGN0hMODFOaHNLTGFsK3M5MG5ST3YzdVR3aDRWMWVoL3FFdzhp?=
 =?utf-8?B?RU1zRmpaNHJpVFpkeHdOOGdMZHRQTDN6Um5oeWxUSXg5emJlNWNoQ0hTbzJ4?=
 =?utf-8?B?L3ArV0R0RExjZlVHdkVVczNqMjB4c0FDUG1kTEtYaE9YSWtLL3BtWGUyTjlm?=
 =?utf-8?B?amV6RGdpN2g5QURyN2c3b3BxL004Zldmcld0UEhlWHBLOERYcUdlbC81YjZp?=
 =?utf-8?B?TlRZUEpUVkNEZGIzeUw3T1RJc0VWcU04WTNsMGxndStRbVgxNDNCRk83NjRX?=
 =?utf-8?B?V281bFJVL0RXd3RRTUdqSmxoNUFyUHpVenZPY1Y1V2pkV2FaOTRIUVkwWU1B?=
 =?utf-8?B?alVVT0xzN0lCdDUrRXU5aUtlMVVMaVVMN2JwVCtVeHJNd2VBVmNKOVFYWGxz?=
 =?utf-8?B?R1RzVFJHTC9KeW9nNEp4eDhCK1hsZnk1RXRZa3ltRlZTZ3QrdGlDNDIyS0Ro?=
 =?utf-8?B?KzUzRTltczNSNktkUXp1Wi9SR3dJRVg5ODlFeTgyZ09TaCtvMXlmWXlBeW5k?=
 =?utf-8?B?b0NqUUgyTTBCT1NYcytyTWFhWWF6M2N4ajJmWDQ0dTY3Mlo4RVdWL3BQM0dU?=
 =?utf-8?B?M20wb2NFc2gwOTR4dHVtR0toOHpCb0hOOWttTVRJVkI2QWdHVW9ZSS9lcUVO?=
 =?utf-8?B?K0cybG5oZUVVbTI1ekhLNlNOTHczSzRPZEt4eWFTREtpU0JUZFpxOXJ3N0d1?=
 =?utf-8?B?S0RNdVZUVEFua0N3VDNaaWVMNm8ycWplYXBJWVRnRmZNS0drZEJsWWgzbnZz?=
 =?utf-8?B?aHRvSWxkclpycE9sY1p3YmxMUXNCcW9BdS9WQ2dWY3BDNGF1ZGF6NEZUbUpZ?=
 =?utf-8?B?K3Myc2UzZUxyZVpNYWdzbGNYZmlRU1FWMEk1YVVTWkRZeUhubDZsWlpXYlNF?=
 =?utf-8?B?Wjd2SHg4cTlpb25CNEhKNFFYSk1MRDN4WmsvcklUUWJNNGUwNW1lWnJDNXoy?=
 =?utf-8?B?anZTMkJxeCtzT1gzSUVIcE44ZXFPbWkyd1pRaHRVdUtCdXNXSkdIMTQ1eERS?=
 =?utf-8?B?eHc5eTZTYkpmc0J2MXE4dFRCcHYzTGo1ekpuU1UyZzFvUXRCUkhMZERuck8x?=
 =?utf-8?B?TE01ZkpteDhtTDB0NHBSR2xXdlZDOW5ZYUJ2V1hFNFJFK2p1ZEpVZ2JERVZk?=
 =?utf-8?B?eExKaWd0V2xmV01BZHV0S3g0WUEvbENESDZKcEFMYVQ3eHNaYUFwQ0ZGVDVl?=
 =?utf-8?B?Ny8rbVFTbHphdjdScEZzWGJpRVNMNnZucDNnY1hub3Rxa3VsWmNOV0RYcHdH?=
 =?utf-8?B?VWF1RHEvSlRhclk0MllYNisvSktkdWJzSXR6U3h2UXJTK0xhODYweDBySHdN?=
 =?utf-8?B?a08vcUEzS0t6UVBQTDh0Z0RTNXdPZFdoZUpraGRGa3JUOE9sOEhJY0QxMGoz?=
 =?utf-8?B?N2lRQStBaUlsZE5GYWpGei9UaEs1TEhXOGpjb1lNTGFpaS9obzVtbVZlWWpJ?=
 =?utf-8?B?aFdCT1laTHN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXgzL3BVNU9aZnlTQVRUN2c4Vk9PL2h3TWhzYXM2ZjNDZElDU2FENFhnTDNp?=
 =?utf-8?B?bG1WRWtHdVV6d0JyUDJBNVl5MnF0Qkl0WExtM2prQUV0a2hNK1BBNlJ4cVJE?=
 =?utf-8?B?azhDMmtmenNEQjU5UnRIa0pUcjk1TS85UzFoUFpOejhnTUE0S05YUzVtSTBy?=
 =?utf-8?B?a0FRSE5Falh5V0NiYjM0NXlraEJoWUJxQ2phaEltM0NKM3RmMzVkeGtOZWc1?=
 =?utf-8?B?VVpzbXdZTVB2UHpaMktsNlJPdUM0bzdDd2lHa0xRRnlhZHNWMFJlbHR4WUg1?=
 =?utf-8?B?Y2RyZlpBUEZSYWtLNHd6aVV1OHFiazYzd3JOVnRVcGwvdzZZanlPL0t2RC9k?=
 =?utf-8?B?bW1oRlRSb2I0bjRVM2IyRldNZzhYUWd4eVMvOXd0K0w5Zjc0RjlhSjBzWUlH?=
 =?utf-8?B?K3JjOGtvQ3Vnczl6VE9JTmNXTXppVnlNalVpS2xBdkpnalpTQkpyYkdrbVc2?=
 =?utf-8?B?T29rRkRNc0lWdEVSOHhvWld1K3BTSkMvMXlqaWE2K3lMUjczV1VFQllnMFlr?=
 =?utf-8?B?dG5zTWhIdjR2KytsY0hkRFlCRmZ4dWU5M05MTWF0UjN5NjBRU2p5R3FhM1ZT?=
 =?utf-8?B?Y2VudUgrUE05WVlrWEROcGN4S3dwZEdIQURSMTRESVdyYkQzSHBvNndPaHY5?=
 =?utf-8?B?S2pHOWhqZkRNZWthZEx5S3hqWGxUVkQ0eWlkZTZGMG0wSVZOY1NHdG1tWFRW?=
 =?utf-8?B?RDVaeGJpdDVDZlVZcitVdmVXUlY3YVIwUk1lQ3hZeUhDdkk0cCtIM3pGb0Rt?=
 =?utf-8?B?L1AvakNSYW9hSUFMZ2VrTUNNMXNDTHZzZUhFQSs5MFFRZnBiUEwvTHdjZDlD?=
 =?utf-8?B?K0RqZFo2cDJsSDgvOWRYK3VmMFd1VWNXYnZzalUrVHVLTTh3bldaUERUMEZp?=
 =?utf-8?B?b0NUandzdG00cmxjckFXZWNNUmhmZllhVWZIWnVrd1Q4VkNwSlVYek9jeVhJ?=
 =?utf-8?B?Vy9mOFg0cWgyU0JPTWs4cHE0SGJWVXNiaWpteUdvTDk1dWNxMWdYMXhWQ21X?=
 =?utf-8?B?SjZGUE9xY0tLUEhlYlBseUNsVUhnNS9VVDhHV1hFOFlGaXFrWW5YVnlMUmZW?=
 =?utf-8?B?YnF2bW1CTzVjNVh3Q0FJbHFlaFNicmJJSGREOUtlR0JGaktOT3dJL2NhNTg4?=
 =?utf-8?B?NURORVhMUExiZlYzaUtNbDY3b1dqMU0zSTFSbFJEdzZEZzJZT2cySGJQRHRO?=
 =?utf-8?B?elUrLzlSUnZuczQ1d0V0NXVBdlFKRnZyK0NFSS83dUpaMWhrMDZjYk1KTVBJ?=
 =?utf-8?B?eDhXZ2g0NUNSM2psNjZKWlpkTDE2YlBSSDFybVNvV0hDY1Y5djdwN3l1KzJE?=
 =?utf-8?B?bS83NlVsT2lSakhlalYwbjV3eTBFeGlVcExLZGJEVm5ya2Z1bWlRckhZYnRF?=
 =?utf-8?B?YjRLcWdPRm9rZUVCQlM5MG9UaEJ1azB3cWlKYk5vcXp4aUJLUThFd3NVb1VW?=
 =?utf-8?B?dUVScFZodDlkTDBvS0g4VTZ1YlFibTQ5dUwwUzFGa2RsdHRLbTAvRzZYYkI1?=
 =?utf-8?B?NTVKM0EvU1cyalIxS05GL0N6c3duWlg1dEs4SThIRWtjdXRpSzVzRWFjay9u?=
 =?utf-8?B?STlSZTBZK3NUWGZGWSt2eWoyZk44QS9FN2g3OFp0OU5ENXI3TklFNWtoT1Z1?=
 =?utf-8?B?aW1JY2l3VVc4WEZQNHNFTGdMbjRlc1FUVy9PUUNQT01YeVFlQzI0bEZVMHBM?=
 =?utf-8?B?ZjM5NFg5S0F3cDNIaG1CTms3eFh2QUdzSU16VjcvMWNQN0s4SVBNemlWaWZi?=
 =?utf-8?B?cngrYzN1N0lhMmhGZzlhaXUzOU1zdGxMWFNWTjVtaGtTSk93ZnhFbVFobHdN?=
 =?utf-8?B?aSs2bzk2b3BBWVFpL1ZEQ3dVdEtMcTFzb0hJS3YrODFxdHh0M0h3QWF1MTR0?=
 =?utf-8?B?RVhZcmYyUUc0NEJZeWdqcjNWZE95cEkrY3B5a2pOdHdBMFgyVldtb09DM3l5?=
 =?utf-8?B?R2cxSlMzNFNRQlp2NHBFeTZ1d1RHL1l1Ylg3bFgwOS9qM0NKdVYvOGUydlZw?=
 =?utf-8?B?VTYrSHgxWi9RVUIvUE0yTmdTWUVaSCswTnBuUldmMnQrQ2Y0Zk1IM1d3dVFr?=
 =?utf-8?B?ODdEd2VOM0VheWllQTVUbUxaUW5hc1FmbXBoSGtiQ29JVWFEU0FZYldHNWlQ?=
 =?utf-8?B?WHc4UEZaMDVvNVZpRGM1RU0rbW5BcEZQYzl5YndzNHo3TGdEZjRlTGZtSXJv?=
 =?utf-8?Q?o/75XXV5FnbCqSYQmWgMCbs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43628B83C3F97C4C8771EDDB023F4600@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bbf60e-ad0e-4c0f-dea4-08de00ce3f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:38:15.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgWFLP6hQUtE1iVHZZ4sEAks9O1FREbVZ5nHz6C8ZJZh4EbsTYi2mHWYZHIpOLk5s84lXae90nZDIGOCi/IFeHNbh6CEAFrle2jIqt7TbU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR09MB8181
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQpPbiAzMC4gOS4gMjUuIDAzOjE5LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
V2VkLCBTZXAgMjQsIDIwMjUgYXQgNzoyM+KAr1BNIERqb3JkamUgVG9kb3JvdmljDQo+IDxEam9y
ZGplLlRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPiB3cm90ZToNCj4+IEFkZCBNSVBTIFA4NzAwIHBy
ZWZldGNoIGluc3RydWN0aW9uIGRlZmluZWQgYnkgWG1pcHNjYm9wLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogRGpv
cmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQo+PiBSZXZp
ZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZlbnRhbmFtaWNyby5j
b20+DQo+PiAtLS0NCj4+ICAgdGFyZ2V0L3Jpc2N2L2NwdS5jICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMyArKysNCj4+ICAgdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaCAgICAgICAgICAgICAgICAg
ICAgfCAgMiArLQ0KPj4gICB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmMgICAgICAg
ICB8ICAxICsNCj4+ICAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMg
fCAxNCArKysrKysrKysrKysrKw0KPj4gICB0YXJnZXQvcmlzY3YveG1pcHMuZGVjb2RlICAgICAg
ICAgICAgICAgICB8ICAxICsNCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBi
L3RhcmdldC9yaXNjdi9jcHUuYw0KPj4gaW5kZXggNzdmYmY2Nzc3Ni4uODdmOWViN2FjNCAxMDA2
NDQNCj4+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2Nw
dS5jDQo+PiBAQCAtMjQ3LDYgKzI0Nyw3IEBAIGNvbnN0IFJJU0NWSXNhRXh0RGF0YSBpc2FfZWRh
dGFfYXJyW10gPSB7DQo+PiAgICAgICBJU0FfRVhUX0RBVEFfRU5UUlkoc3Zyc3c2MHQ1OWIsIFBS
SVZfVkVSU0lPTl8xXzEzXzAsIGV4dF9zdnJzdzYwdDU5YiksDQo+PiAgICAgICBJU0FfRVhUX0RB
VEFfRU5UUlkoc3Z1a3RlLCBQUklWX1ZFUlNJT05fMV8xM18wLCBleHRfc3Z1a3RlKSwNCj4+ICAg
ICAgIElTQV9FWFRfREFUQV9FTlRSWShzdnZwdGMsIFBSSVZfVkVSU0lPTl8xXzEzXzAsIGV4dF9z
dnZwdGMpLA0KPj4gKyAgICBJU0FfRVhUX0RBVEFfRU5UUlkoeG1pcHNjYm9wLCBQUklWX1ZFUlNJ
T05fMV8xMl8wLCBleHRfeG1pcHNjYm9wKSwNCj4+ICAgICAgIElTQV9FWFRfREFUQV9FTlRSWSh4
bWlwc2Ntb3YsIFBSSVZfVkVSU0lPTl8xXzEyXzAsIGV4dF94bWlwc2Ntb3YpLA0KPj4gICAgICAg
SVNBX0VYVF9EQVRBX0VOVFJZKHh0aGVhZGJhLCBQUklWX1ZFUlNJT05fMV8xMV8wLCBleHRfeHRo
ZWFkYmEpLA0KPj4gICAgICAgSVNBX0VYVF9EQVRBX0VOVFJZKHh0aGVhZGJiLCBQUklWX1ZFUlNJ
T05fMV8xMV8wLCBleHRfeHRoZWFkYmIpLA0KPj4gQEAgLTEzODAsNiArMTM4MSw3IEBAIGNvbnN0
IFJJU0NWQ1BVTXVsdGlFeHRDb25maWcgcmlzY3ZfY3B1X3ZlbmRvcl9leHRzW10gPSB7DQo+PiAg
ICAgICBNVUxUSV9FWFRfQ0ZHX0JPT0woInh0aGVhZG1lbXBhaXIiLCBleHRfeHRoZWFkbWVtcGFp
ciwgZmFsc2UpLA0KPj4gICAgICAgTVVMVElfRVhUX0NGR19CT09MKCJ4dGhlYWRzeW5jIiwgZXh0
X3h0aGVhZHN5bmMsIGZhbHNlKSwNCj4+ICAgICAgIE1VTFRJX0VYVF9DRkdfQk9PTCgieHZlbnRh
bmFjb25kb3BzIiwgZXh0X1hWZW50YW5hQ29uZE9wcywgZmFsc2UpLA0KPj4gKyAgICBNVUxUSV9F
WFRfQ0ZHX0JPT0woInhtaXBzY2JvcCIsIGV4dF94bWlwc2Nib3AsIGZhbHNlKSwNCj4+ICAgICAg
IE1VTFRJX0VYVF9DRkdfQk9PTCgieG1pcHNjbW92IiwgZXh0X3htaXBzY21vdiwgZmFsc2UpLA0K
Pj4NCj4+ICAgICAgIHsgfSwNCj4+IEBAIC0zMjk1LDYgKzMyOTcsNyBAQCBzdGF0aWMgY29uc3Qg
VHlwZUluZm8gcmlzY3ZfY3B1X3R5cGVfaW5mb3NbXSA9IHsNCj4+ICAgICAgICAgICAuY2ZnLnBt
cCA9IHRydWUsDQo+PiAgICAgICAgICAgLmNmZy5leHRfemJhID0gdHJ1ZSwNCj4+ICAgICAgICAg
ICAuY2ZnLmV4dF96YmIgPSB0cnVlLA0KPj4gKyAgICAgICAgLmNmZy5leHRfeG1pcHNjYm9wID0g
dHJ1ZSwNCj4+ICAgICAgICAgICAuY2ZnLmV4dF94bWlwc2Ntb3YgPSB0cnVlLA0KPj4gICAgICAg
ICAgIC5jZmcubWFyY2hpZCA9IDB4ODAwMDAwMDAwMDAwMDIwMSwNCj4+ICAgICAgICAgICAuY2Zn
Lm12ZW5kb3JpZCA9IE1JUFNfVkVORE9SX0lELA0KPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di9jcHVfY2ZnLmggYi90YXJnZXQvcmlzY3YvY3B1X2NmZy5oDQo+PiBpbmRleCAyZGI0NzFhZDE3
Li5lNGQ1MDM5YzQ5IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaA0KPj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaA0KPj4gQEAgLTM4LDcgKzM4LDcgQEAgc3RhdGlj
IGlubGluZSBib29sIGFsd2F5c190cnVlX3AoY29uc3QgUklTQ1ZDUFVDb25maWcgKmNmZyBfX2F0
dHJpYnV0ZV9fKChfX3VudXMNCj4+DQo+PiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBoYXNfeG1pcHNf
cChjb25zdCBSSVNDVkNQVUNvbmZpZyAqY2ZnKQ0KPj4gICB7DQo+PiAtICAgIHJldHVybiBjZmct
PmV4dF94bWlwc2Ntb3Y7DQo+PiArICAgIHJldHVybiBjZmctPmV4dF94bWlwc2Nib3AgfHwgY2Zn
LT5leHRfeG1pcHNjbW92Ow0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgaW5saW5lIGJvb2wgaGFz
X3h0aGVhZF9wKGNvbnN0IFJJU0NWQ1BVQ29uZmlnICpjZmcpDQo+PiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jIGIvdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmll
bGRzLmguaW5jDQo+PiBpbmRleCBhMjkwMzAzZWU3Li5kZDNlZTdiYTJiIDEwMDY0NA0KPj4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jDQo+PiArKysgYi90YXJnZXQvcmlz
Y3YvY3B1X2NmZ19maWVsZHMuaC5pbmMNCj4+IEBAIC0xNDcsNiArMTQ3LDcgQEAgQk9PTF9GSUVM
RChleHRfeHRoZWFkbWVtaWR4KQ0KPj4gICBCT09MX0ZJRUxEKGV4dF94dGhlYWRtZW1wYWlyKQ0K
Pj4gICBCT09MX0ZJRUxEKGV4dF94dGhlYWRzeW5jKQ0KPj4gICBCT09MX0ZJRUxEKGV4dF9YVmVu
dGFuYUNvbmRPcHMpDQo+PiArQk9PTF9GSUVMRChleHRfeG1pcHNjYm9wKQ0KPj4gICBCT09MX0ZJ
RUxEKGV4dF94bWlwc2Ntb3YpDQo+Pg0KPj4gICBCT09MX0ZJRUxEKG1tdSkNCj4+IGRpZmYgLS1n
aXQgYS90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc194bWlwcy5jLmluYyBiL3RhcmdldC9y
aXNjdi9pbnNuX3RyYW5zL3RyYW5zX3htaXBzLmMuaW5jDQo+PiBpbmRleCAwNDUwMzRhZTMyLi45
NWI4MjM4MDgxIDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNf
eG1pcHMuYy5pbmMNCj4+ICsrKyBiL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3htaXBz
LmMuaW5jDQo+PiBAQCAtOSw2ICs5LDEyIEBADQo+PiAgICAqICAgICAgICAgICAgKGh0dHBzOi8v
bWlwcy5jb20vcHJvZHVjdHMvaGFyZHdhcmUvcDg3MDAvKQ0KPj4gICAgKi8NCj4+DQo+PiArI2Rl
ZmluZSBSRVFVSVJFX1hNSVBTQ0JPUChjdHgpIGRvIHsgICAgICAgICAgICAgIFwNCj4+ICsgICAg
aWYgKCFjdHgtPmNmZ19wdHItPmV4dF94bWlwc2Nib3ApIHsgICAgICAgICAgXA0KPj4gKyAgICAg
ICAgcmV0dXJuIGZhbHNlOyAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAgIH0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICt9IHdoaWxl
ICgwKQ0KPj4gKw0KPj4gICAjZGVmaW5lIFJFUVVJUkVfWE1JUFNDTU9WKGN0eCkgZG8geyAgICAg
ICAgICAgICAgXA0KPj4gICAgICAgaWYgKCFjdHgtPmNmZ19wdHItPmV4dF94bWlwc2Ntb3YpIHsg
ICAgICAgICAgXA0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPj4gQEAgLTMwLDMgKzM2LDExIEBAIHN0YXRpYyBib29sIHRyYW5zX2NjbW92
KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfY2Ntb3YgKmEpDQo+Pg0KPj4gICAgICAgcmV0dXJuIHRy
dWU7DQo+PiAgIH0NCj4+ICsNCj4+ICtzdGF0aWMgYm9vbCB0cmFuc19wcmVmKERpc2FzQ29udGV4
dCAqY3R4LCBhcmdfcHJlZiAqYSkNCj4+ICt7DQo+PiArICAgIFJFUVVJUkVfWE1JUFNDQk9QKGN0
eCk7DQo+PiArDQo+PiArICAgIC8qIE5vcCAqLw0KPiBDYW4gd2UgYWRkIHNvbWUgZG9jdW1lbnRh
dGlvbiBvZiB0aGVzZSBpbnN0cnVjdGlvbnM/IFdoYXQgZG9lcyB0aGlzDQo+IGFuZCB0aGUgb3Ro
ZXIgaW5zdHJ1Y3Rpb25zIGRvPyBNYXliZSBqdXN0IG9uZSBzZW50ZW5jZSBmb3IgZWFjaCBhbmQg
YQ0KPiBsaW5rIHRvIGEgZGF0YXNoZWV0DQo+DQo+IEFsaXN0YWlyDQoNClllcywgSSBhZ3JlZS4g
SSB3aWxsIGFkZCBjb21tZW50cyBmb3IgdGhlIGluc3RydWN0aW9ucy4NClRoZSBsaW5rIHRvIGRv
Y3MgaXMgaW4gdG9wIGxldmVsIGNvbW1lbnQgaW4gdGhpcyBmaWxlLg0KDQoNClRoYW5rcywNCg0K
RGpvcmRqZQ0KDQoNCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gZGlmZiAtLWdpdCBh
L3RhcmdldC9yaXNjdi94bWlwcy5kZWNvZGUgYi90YXJnZXQvcmlzY3YveG1pcHMuZGVjb2RlDQo+
PiBpbmRleCBmYWRjYjc4NDcwLi40MjE1ODEzYjMyIDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3Jp
c2N2L3htaXBzLmRlY29kZQ0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZQ0KPj4g
QEAgLTksMyArOSw0IEBADQo+PiAgICMgICAgICAgICAgICAoaHR0cHM6Ly9taXBzLmNvbS9wcm9k
dWN0cy9oYXJkd2FyZS9wODcwMC8pDQo+Pg0KPj4gICBjY21vdiAgICAgICAgICByczM6NSAxMSBy
czI6NSByczE6NSAwMTEgcmQ6NSAwMDAxMDExDQo+PiArcHJlZiAgICAgICAgMDAwIGltbV85Ojkg
cnMxOjUgMDAwIGltbV9oaW50OjUgMDAwMTAxMQ0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4=

