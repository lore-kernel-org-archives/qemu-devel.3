Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB263CAC5A7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Le0-0003dK-CL; Wed, 24 Sep 2025 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Ldx-0003cz-M5; Wed, 24 Sep 2025 05:18:34 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Ldo-0002yg-OS; Wed, 24 Sep 2025 05:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUebb5JoI3DjReIT2NBgnX2iL6Gfa1FHXzaHluyr9OL/ZwAhr/C5ve999iaWplV5HXsT/+oQ+wSwwC7dqtpVeQSfcYIUaL27QzO06jQYTpWH6IhOMf134eUVvqJosb4zRRi2Vq2DqQjW7MZqE/Uv7ZjnQUOJAzVlRcHFCMuL1H3UvxFA5ov1j7OnzBHuNDJtLrHSiarjn98CoOw6xXa/YDUQahTkwqsFkFbE/XDN04iVCr80ISajlflwKD6h7FXfYQFCOYmX29ZwRwwTW6bQbyQaW8vxUANFIor6FqIWFACUM3iq94EU45VJgadRKwUEUvRbwQlj/rnANGjH/WVs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRY0U00yLtemEMLvQa3ogR1EhDayiqJUVjWZQMNBMvQ=;
 b=sVZaJ8VLLNL8e9UnLuzd7UlIifxYQlRGhcpWAkGGxz/bhQZXWuYVGOi7rolMcz0+fG7JtUFv3HoANikAjNPN9BI+d44a4E3ShEtzyWsXGDTrnUyAQisq3Ra1FLmGOzKebntfXAA1uF8RpK7b0s+8GV7nAEChkNzy7DWacJeLxV1VXHQdUJvoq4/BL/BuqaOBSbB7yef5cKrVY7m2Vr3mdVz5UXl9aZxi0h4gDi0FWeb/JC0gSMZzvh3MNuEasCv3LqAYiX48/TVvuWvUYpIDHI9oymwBPnO+QrlL6vRr34DFpvV9++gxrAkjOG1/afVdIX139Es3UsOEhVY6mSgLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRY0U00yLtemEMLvQa3ogR1EhDayiqJUVjWZQMNBMvQ=;
 b=WTGyeJ4t4seJZM2cl+wDYbyC5Mj/TofSJOiVZKD26+kX5F0Daaz8jkXlN5QivFW3YVQ4ACNs88u5+ptDt2oEgG4lOx6AeaAK0wUhgkBqr6j+UA7HK8kRVf7TpKZ06Y6WqoYEr4exVFBFdK1MNQLNWH2Dw07u7pL7d4Vf/Hk8Cu4Us8P/sTjN3dPROB92+kwMiapZpzG7m3wJMvvRXo7eXztve5jvcNGp2/1NL2LAi8CMn4PAVRp8fU67u5PxyTgp3T20qke5XlfEwe9gzJ8Qmq9V29WvN6Oj9KmS1F56nK7rdkVp9Fqbaiojw+zoS4MNCfJuwk+PZCDOsaUD5cuDcw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:13 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v8 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcLTQmMADswzjzR0a5CZo4hfbMyA==
Date: Wed, 24 Sep 2025 09:18:12 +0000
Message-ID: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: cacc2842-d030-405a-4a25-08ddfb4b4982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MWltNHF4Z2hHTFZyZG4wMUhZMUx1UTRybnF2MmNlL3FoYUNaTkl4YWdaejA3?=
 =?utf-8?B?S2FXRU4yVm1ubForVXJGQWVPbzcrdWY0WGlTVTVENUdhc3RqdmlDeVdwRyt0?=
 =?utf-8?B?clQzNllJa080V3ZHeXVlQURMa0s5Y2d0Z1RDd0hFYzNzOWMvYWhaOHlWR2NV?=
 =?utf-8?B?L1hCcTdQRWFuVVJQUUZUYktlUVRRazlHM291WDdBWXFHRzBuRnVMUlFlbHM0?=
 =?utf-8?B?VmJ4aU14eFo5bytCcHp3WFBXM1N5YlUwOTFCSFE2YU1haTFkNTBEY3g0ZnZ1?=
 =?utf-8?B?NnM4MWRLczNOS1crR3BpWTdYMlk3MWFyT1FSL0dIQ3Z3UmZOT2lCdlRFTkVq?=
 =?utf-8?B?TVBiWldaYlBOaHd2UEZYWk9wcVhZQXpiS0EwMkVGRHhTZDEzNDVRNGl0a0NK?=
 =?utf-8?B?bjM1ZmQ2MFFiMXFtUnZlSThJS0tYd2kyVWRzbkZ5Vkh6L0JKM2tsYWNJT0ZM?=
 =?utf-8?B?bTNVUGM1bTYzVFUwZDFuUDdpMDVuK0RnYk11a21CZTY0Z1lFTGdmVlpvZm13?=
 =?utf-8?B?QjMrYnQxUjgzSVBFRnpQNk5qc0pNNTFCZ2RMOXc3bnNmbDN1Y2I5R1dvS25I?=
 =?utf-8?B?bXdGeHpud3RwaTRiZG9XVTdyU0hWYUlJTjgrMWprdlFZVms2enlyb2pXNHdL?=
 =?utf-8?B?NWVkNzlqT2xjQW5FSG9QcEwyRzBEMnVBTnpodENlb212c05ORGVERGJFTUhq?=
 =?utf-8?B?U21BellzTVZ5VXpnRHRZYzY1QzVtTnZaR1ZURjE3VTFOR0l4VEFzaFpzanRG?=
 =?utf-8?B?Y0hJNzI2blFLcUordlNIdExKNnBhSTRIMGpiUXp2RVkxcWI1cVhzRlRjZ1Vp?=
 =?utf-8?B?K0JGMTZaamwyaUNUMVZ4ZGMyK1Erc2trMk9WVytEdjdlMzV0TGtORkxvUEZL?=
 =?utf-8?B?c1VQZ1VVNTlhN25FUmVjT1Z2UWVBZ1FtRytmWmJXZmo2bEVUQXdHR1pBQVpC?=
 =?utf-8?B?YkVHd0VzZjZjTU41R3JmYkhsYWx5NEM2aHVXaVJFeHRqL0dKVnhZV1J3ZEdw?=
 =?utf-8?B?Y1VWNStQQlhkTm9KSGlZaXJkcXlPSnVaNHBjeDYxQno1TGhTVE1NMHQ4SWRJ?=
 =?utf-8?B?NmEybzVBeHFxMUE3ZWI0L2V1aGt5ckN2RHJXWHBQUmRzQkszZ2xjcmpmc0kx?=
 =?utf-8?B?aVFHR0dyRXpLa0NxQlZZaGJqNVhSaVRwZUxGczFzdTJ6UmNXeS9lRWVFUDNa?=
 =?utf-8?B?SnFDU1dOMSs2enIvdGlxMTRmQStsL2RSWWR6U0ljMXMxU0ExWkd0VXJiZ2hE?=
 =?utf-8?B?c0lncnZFUitxQ05DbWNCcFVmZXQrMnNZTCsyaDc2NFNUSWxCNEo5RGs0VUNQ?=
 =?utf-8?B?VDJJUXJBNDc3L3QybHBnMktKT25UNE94RGZsRWZJcFJhdW5NNE5pWXpKQTJ5?=
 =?utf-8?B?czZmOS9LeE5ISUtjTmJyY01mQTBqU09vUXJYUjcxbDNTQVRIdU9oSFNGUEFQ?=
 =?utf-8?B?dzdzbk9hb3FVbE9vbnlxMnM5dkdiOGpLUnV4UEJCTzRhbU56c3JnckpwTGN5?=
 =?utf-8?B?bXRaREt4WTgza0hSYUNaN01KaTVwUGp1QWVwTWx0SHpvSFNGOG4zUWZVQVUy?=
 =?utf-8?B?NkllZGgzQ296RjZUTzBvbVpMeWVwUWs2SDI4TDdlNFAxVHJlYlF3MDIzeUxs?=
 =?utf-8?B?bWJuZko1QXNXd3YxaGR5T09CRCt1REVqQ2duMUYyOTcxTElzYVZ3azhMeXlH?=
 =?utf-8?B?TjBLQTZ3V2UwZTRlWm82QlFDclJGRHJQcy9LYlk3RkgySFV1MXNaQXhFRU9C?=
 =?utf-8?B?NVFqbFBSZkUvaGtqNVpzZFU2VGNsbVliYWF0bkFwWTZEcGpIUHg3WjhSRStn?=
 =?utf-8?B?OHU2SHYzWE4wUVhzU2FXbVpEM3c5M2xINEtlREN2b2E2ZmhwVGExRFZxVzZi?=
 =?utf-8?B?RjBZc3g4R2cyZmlvdXJjQ0xpK05xcXZ3OTZNM0pORFA1YW4zRE1DWHB0dEx0?=
 =?utf-8?B?MjAxakNjaWdRc3QrNXVYUldEQmxDazBhbGpJZXBoTWRYdW9Qcm1DMEs3VVFo?=
 =?utf-8?B?YXpuYjhoT3pnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUNvS0k3cHFhUFJJRkNYendFUTlXMHREekJIWncxaXN0OTlHN000Mk8rVyt1?=
 =?utf-8?B?bWxUeFhCa0xjaTdyVUFBckgzWTVmQjZVOWJYclhsK2JBMGJkaEdROGRua1Vj?=
 =?utf-8?B?NjNEY1g5dkNpaUlCdmF3NCtzbkJwRFJQU0l3U2h3eWEzNDRUMlJKb2g1ZFBr?=
 =?utf-8?B?bTFrYWduVnIvVEhrbVNPd2g0bEVVb2lvWjc3UmlxVHo3UU9kc1YrQlJydDVU?=
 =?utf-8?B?eFJiZTRaRmVIRG41RkpvTGRJcnNjOWJnbTNhbktwc2JPY3ZzNFFxMFk3L2l6?=
 =?utf-8?B?MUZWVTZnSHZTS2RNUmw2MUpGYS9SOFJWTjdYMmRTd1V3MkNwK3dQMHFQUHQx?=
 =?utf-8?B?NkRZdlZ1RWRYLzdleml5dGs5eDUvSTRES3J0ZWkzSFpyazJGTy9DVHZwbURy?=
 =?utf-8?B?OEVwMlBNVnI3TmN5ano5MEdrc0hna1dWeXFPdEJ1cWNPWTgwdmlLRGp4VUxJ?=
 =?utf-8?B?UEkzalA3Vk9mdW9ySVROelhWejZQZ1lDQ2hXT0pnaFJBSnkrOVF1Y2Q0ZmFB?=
 =?utf-8?B?bnNhbjBIa2ltSFBBZlZQL1pVNDA0TWtZZHFqbEg3MytPY2pUWk1talNjZ0R6?=
 =?utf-8?B?cFFaZExJRTQ1NzN2bGdFeGRyRi9rZU1VMFpiblU3NDkrZjR0S3RhbkFmWHdn?=
 =?utf-8?B?dUo4OGd3SnFWRnJMWkpYdVRqSTdLeVpuM2tLL1FTSjU1TWc4L0JQb3liNEJW?=
 =?utf-8?B?cFhtRmpBRW1uSTF5ay9lTmpFVi82UzdoZ2ZUMWNVSnJubmZHdCtPMXZlOCt5?=
 =?utf-8?B?ZzgrUGlIVVA1OWFRNWVTSkdiTnJiNStUMnhNNXhwVmRSdGJQK0M2R1RmQjc3?=
 =?utf-8?B?RDFodjRCTzA4UHBweUptSWpBTXJwbklJZXlsdzMvRnFYZ3dqaHVSd1c3dEVR?=
 =?utf-8?B?NlBNL2dqSjFwVWpPN3hXc3VpVzhobTUzc0JKTHh3VVlZMEZqSFNXb1BMLytZ?=
 =?utf-8?B?dkRHQ3lNWm1KTWl2VHd1eW90QVEyTXBtYUx5b3J5K3pIcHB6dy9ITS9oN0hi?=
 =?utf-8?B?RHB4ZTlpM0E3bUNsTk5JVE80UElZM2pHQU5VUk53R0NRanl1VjJSVnNUR21D?=
 =?utf-8?B?azB3MjVRckNmRm5EQTU0RDZ1WHJQRVdaK0J6R2htRkV1Mm1MeVVxZFdkS3gx?=
 =?utf-8?B?aElBZkphdzZXaS85N21DdXIxdGhuTlAyQjJvSkJMb2NiTlg3MHptd3J4eFNM?=
 =?utf-8?B?Y2NxeTU4ZnBtdE91UjIvOUVTYy96eGpmS1dnd25qbzJ0MDErdWJjbHhXeW1W?=
 =?utf-8?B?WUtPNGxWa3paV1gyZENUeFd5SDVLTzlRRGg1cit4RElvdTVXOGdqVURjYW9F?=
 =?utf-8?B?UFpEWFp6cVNVbmtyTkQyZHVuU1ExL0taQThZNTFQQzRDK0ZzMHFsNlIzejIv?=
 =?utf-8?B?SldUOEV1LzFvQitCUlpaMFIzbGlqdE12THFPdVpBaktjWTZPRFoyVWxiNm1k?=
 =?utf-8?B?Sy9qbkVmVUhoUzd0NDlSN0c4aXRKUFRUSktPaTlpS2VWa0ZaRFVQOW1wYmhH?=
 =?utf-8?B?NjRBZzIrOHBSTkJROVI4UHNVbWVrSnlsSFpmMFJBVS9DK2dzNU1VY3MvMWhI?=
 =?utf-8?B?VFQwZnF0ZzdnTTg3RnFHRmt2anp3d1B4em1NWU1TbjAwZGNRVVRrTFNTQ1cr?=
 =?utf-8?B?anZsVDdUbXhlWG5JQmZySVhaSHg4Z2FicVBHNlBnTGJ3RVRURHZBS2V2cXAx?=
 =?utf-8?B?TURaWUoxVDhCc3FHWlhsNHVmZ2xpMTVOVkpHdkZja1NNMitXY0NQRW0xNXA0?=
 =?utf-8?B?OGhBamMzMjJIZ3lBZlRyaG9ybG93QkNHb3VaVmhMdzYrVEtBRERJdWJmaVAx?=
 =?utf-8?B?SWlYT0J0K2NBK2FZaE5QU1c0aWFKaDNWRUl4ZDZPZnNvRng4dmE1M2RUV1RE?=
 =?utf-8?B?VzNvaGdVRFp2TWR0WlBNNUp4K09yWEFjQW9iY1l6Qy9vb1hZbU9HeWpWanNT?=
 =?utf-8?B?bC9uQ1B3VVNSZjRLMTNRL1FBNUZDTm9iMnFyK3JPaTJUa3N3NlhtQS9VM0sz?=
 =?utf-8?B?OTgxYlVCSWo0L3FLVmY2U3h3TnpHQlpJaFRkZXdNNGdYeWZlZmlEQkl2elpQ?=
 =?utf-8?B?aEFkMk5vY0ZpdjZSNGs5QW9FdE9ySXdGWjFuaW9LU3l6ekRGVUU1R0R2ajAv?=
 =?utf-8?B?MGpVcWd6Yk5vWUgvUGl4SW5ySlFmTzdiNTh2T0NjSmVmRDNYM056K3doZzEz?=
 =?utf-8?Q?wz7Xe+3wKtmkHnVipj79Jjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC1E9E6BAFB5A4A9D9D6BACC3B92445@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc2842-d030-405a-4a25-08ddfb4b4982
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:13.0269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H506en2Uao18Ww1gjz7LtLSs6dGwnTBIin2TdvMZXTPSUUgJwzgdOZxVvBW3WMU/zYdBfoDu2Af2hsrlI4BPVss44NeOzxnkTbo5g5hJ3M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

SSBhZGRyZXNzZWQgc2V2ZXJhbCBjb21tZW50cyBpbiB0aGlzIHZlcnNpb246DQoNCi0gQWRkZWQg
bW9yZSB0ZXN0cw0KLSBGaXhlZCBsaWNlbnNlcyBpbiBuZXcgZmlsZXMgYWRkZWQNCi0gUmVtb3Zl
ZCBMT0dfR1VFU1RfRVJST1IgZnJvbSBhcGxpYy9hY2xpbnQgZm9yIGdhcHMgaW4gaGFydGlkcw0K
DQpEam9yZGplIFRvZG9yb3ZpYyAoMTQpOg0KICBody9pbnRjOiBBbGxvdyBnYXBzIGluIGhhcnRp
ZHMgZm9yIGFjbGludCBhbmQgYXBsaWMNCiAgdGFyZ2V0L3Jpc2N2OiBBZGQgY3B1X3NldF9leGNl
cHRpb25fYmFzZQ0KICB0YXJnZXQvcmlzY3Y6IEFkZCBNSVBTIFA4NzAwIENQVQ0KICB0YXJnZXQv
cmlzY3Y6IEFkZCBNSVBTIFA4NzAwIENTUnMNCiAgdGFyZ2V0L3Jpc2N2OiBBZGQgbWlwcy5jY21v
diBpbnN0cnVjdGlvbg0KICB0YXJnZXQvcmlzY3Y6IEFkZCBtaXBzLnByZWYgaW5zdHJ1Y3Rpb24N
CiAgdGFyZ2V0L3Jpc2N2OiBBZGQgWG1pcHNsc3AgaW5zdHJ1Y3Rpb25zDQogIGh3L21pc2M6IEFk
ZCBSSVNDLVYgQ01HQ1IgZGV2aWNlIGltcGxlbWVudGF0aW9uDQogIGh3L21pc2M6IEFkZCBSSVND
LVYgQ1BDIGRldmljZSBpbXBsZW1lbnRhdGlvbg0KICBody9yaXNjdjogQWRkIHN1cHBvcnQgZm9y
IFJJU0NWIENQUw0KICBody9yaXNjdjogQWRkIHN1cHBvcnQgZm9yIE1JUFMgQm9zdG9uLWFpYSBi
b2FyZCBtb2RlDQogIGh3L3BjaTogQWxsb3cgZXhwbGljaXQgZnVuY3Rpb24gbnVtYmVycyBpbiBw
Y2kNCiAgcmlzY3YvYm9zdG9uLWFpYTogQWRkIGFuIGUxMDAwZSBOSUMgaW4gc2xvdCAwIGZ1bmMg
MQ0KICB0ZXN0L2Z1bmN0aW9uYWw6IEFkZCB0ZXN0IGZvciBib3N0b24tYWlhIGJvYXJkDQoNCiBj
b25maWdzL2RldmljZXMvcmlzY3Y2NC1zb2Z0bW11L2RlZmF1bHQubWFrICAgfCAgIDEgKw0KIGRv
Y3Mvc3lzdGVtL3Jpc2N2L21pcHMucnN0ICAgICAgICAgICAgICAgICAgICB8ICAyMCArDQogZG9j
cy9zeXN0ZW0vdGFyZ2V0LXJpc2N2LnJzdCAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBody9p
bnRjL3Jpc2N2X2FjbGludC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKy0NCiBody9p
bnRjL3Jpc2N2X2FwbGljLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKy0NCiBody9t
aXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKw0KIGh3L21p
c2MvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQogaHcvbWlz
Yy9yaXNjdl9jbWdjci5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjQ2ICsrKysrKysrKw0K
IGh3L21pc2MvcmlzY3ZfY3BjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI2MyArKysr
KysrKysrDQogaHcvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIwICstDQogaHcvcmlzY3YvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA2ICsNCiBody9yaXNjdi9ib3N0b24tYWlhLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA0
NzcgKysrKysrKysrKysrKysrKysrDQogaHcvcmlzY3YvY3BzLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTk2ICsrKysrKysNCiBody9yaXNjdi9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5o
ICAgICAgICAgICAgICAgICB8ICA1MCArKw0KIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jcGMuaCAg
ICAgICAgICAgICAgICAgICB8ICA2NCArKysNCiBpbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNjYgKysrDQogdGFyZ2V0L3Jpc2N2L2NwdS1xb20uaCAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiB0YXJnZXQvcmlzY3YvY3B1LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNDIgKysNCiB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KIHRhcmdldC9yaXNjdi9jcHVfY2ZnLmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNSArDQogdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmgu
aW5jICAgICAgICAgICAgIHwgICAzICsNCiB0YXJnZXQvcmlzY3YvY3B1X3ZlbmRvcmlkLmggICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3ht
aXBzLmMuaW5jICAgICB8IDEzMCArKysrKw0KIHRhcmdldC9yaXNjdi9tZXNvbi5idWlsZCAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArDQogdGFyZ2V0L3Jpc2N2L21pcHNfY3NyLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgMjE3ICsrKysrKysrDQogdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5j
ICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCiB0YXJnZXQvcmlzY3YveG1pcHMuZGVjb2Rl
ICAgICAgICAgICAgICAgICAgICAgfCAgMzUgKysNCiB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQv
bWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0KIC4uLi9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF9yaXNjdjY0X2Jvc3Rvbi5weSB8IDE2NCArKysrKysNCiAzMCBmaWxlcyBjaGFuZ2VkLCAyMDYy
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2Nz
L3N5c3RlbS9yaXNjdi9taXBzLnJzdA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jpc2N2
X2NtZ2NyLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9yaXNjdl9jcGMuYw0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9yaXNjdi9ib3N0b24tYWlhLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvcmlzY3YvY3BzLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2
X2NtZ2NyLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NwYy5o
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvcmlzY3YvY3BzLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L21pcHNfY3NyLmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9m
dW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9yaXNjdjY0X2Jvc3Rvbi5weQ0KDQotLSANCjIuMzQuMQ0K

