Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5759C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzlcQ-0001Ow-KO; Thu, 27 Aug 2026 21:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlcM-0001O9-TY; Thu, 27 Aug 2026 21:42:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlcK-0003nb-UO; Thu, 27 Aug 2026 21:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787881372; x=1819417372;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jVKVMqjLhp0bvmO6L/HoxUte00NpfxcFOXvzgptDATw=;
 b=bB3ETemlH3SCjlqIYAbL830nSJiSFa78w8ztRU/eJ0tZRz8ZlGGD9BEK
 x3q6SDixCtx+hq7/LSsOXVoXPtKeKuKspS6ccW4aOsjjSMDmYoqjul3Ew
 9Nbv0r69/gDFhTSQrk7UZNj1gxUV6Fhw64hDoQpHZTdGuj7Kyb2D4IByM
 MwWgd8N5vtvVeN49odHeO9sfxibYCl9kmPZZP3JzDNT3yc7JagO2eLrWE
 YkbSelKOdy8DPG5/CcaUZAEuiK4a8kfHlKcxWF26VqM5xxA1vo+Y2HfXB
 ZsHvF3Y+RP1Cz18j25n5zS3iFxh3ITI/1LEwqBiCKO2i9bHznnMSb501o w==;
X-CSE-ConnectionGUID: S8U65vFHTfehAyooNZ6k8g==
X-CSE-MsgGUID: MM6zRzqjTRy8ggfcehI2Iw==
X-IronPort-AV: E=Sophos;i="6.25,247,1779120000"; d="scan'208";a="153469202"
Received: from mail-westus2azon11010033.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Aug 2026 09:42:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVF0QFTzLZFBhkHemAQH3CbBtqCcxSIJvJSQWMM6osVmuad2FgnhMORFLVE8pkH8fGfSD9c27YLNEGbT3PveuiMRkc1GmNt1MJXXM7wetXjzwucDUhuf2+m0zM19tggxIxUxJ9FpYm578mgEKuN0NR3u3/G92823sUibKlxfvG5PYtXpOuBgTSdibI7bwp4vIjprphtVqdpEQfU4IVyOWsDrHNNDnmYzEZ5Xx2mv3nLRM9QiwJVy1LaNNIWwU1ZkgQKyQXrc2Amvsg+GDpPiZVWjmXDGUyVTEeZw/1WE6qjOFh5ASMugzscBeB4zAkxT7rPdlOAHF+lLJlNNQbdEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVKVMqjLhp0bvmO6L/HoxUte00NpfxcFOXvzgptDATw=;
 b=u12dFODW3UT160S1h9XZHPK3iVi55EaKLqeS7uWyLRU+FlXdd2FoIcjvLwiBWz7z5IfiL07PlDXc0YOmLZkwpOW0qidFYyDmr0EwWdkPf8wBh2iuhGchXOq4REKm2AoHot6NrVwkuRkAfgvcOEPVVlGTCaXQwpuT3Xn1YHt7KtJhY1/Je4hO3JvMQJxBoV+odEvHqrYd+SpdHflchKlu9umtZNiOMjw29JQa5JBADxoXHXsrecY6DItLHke57j8UlZ6mBElhvFtbIwZCYyLIkCuR1vgrYsG6GD3v4BGAsENjgmvNOB0Hiz3VR/3bDOp0ORHpPy/vunVItc03AKljCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVKVMqjLhp0bvmO6L/HoxUte00NpfxcFOXvzgptDATw=;
 b=M3nm7QoW1ceuPpkA0uemm9zlrDRlytwBVVMNVNKtvpbjh/3+pKmIgdk/gBkIODaRE8rNZdPPGT902l9UYlO7ob95iTQKoK6tASGymB2OHW/yTVGl2KDTgc7kj0841i9wiFoLIlKX/aK/C3VPXDp9lVdT2u5gwTacMIO01MoSV4w=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DS2PR04MB994026.namprd04.prod.outlook.com (2603:10b6:8:4ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 01:42:47 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:42:46 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "nendensu@ispras.ru"
 <nendensu@ispras.ru>, "joel@jms.id.au" <joel@jms.id.au>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
Thread-Topic: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
Thread-Index: AQHdInKaEtzmgMsKLEiieqD+bZMjeraufRGAgAKSVACAAHLHAIAACHSAgAFNhoA=
Date: Fri, 28 Aug 2026 01:42:46 +0000
Message-ID: <0d4f91f417c2b0ce3d9ae0abbc7512ddd44b1307.camel@wdc.com>
References: <20260802113130.7818-1-nendensu@ispras.ru>
 <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
 <a985157941bd10429a3048618e3fb977@ispras.ru>
 <CACPK8XfEQnEqQ923ag8kWXcvBNsxmUKZK_dCdUm-AddD2Mf0dg@mail.gmail.com>
 <172a17a4-9438-4536-ba51-a5e649e435d9@tls.msk.ru>
In-Reply-To: <172a17a4-9438-4536-ba51-a5e649e435d9@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DS2PR04MB994026:EE_
x-ms-office365-filtering-correlation-id: f9ebc8c1-10df-4ec3-e710-08df04a5a929
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|10070799003|366016|23010399003|10067099003|38070700021|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: NDNpVkw4OwnNZbUS6qk7F8apjtTslPCWcYAf0dZeLn8UP+blhMQOvXDfECtyzeqCbeAGxipSJ3LTVvD2ftB7/6r0WgD/8bVTn8EHv+ObFORSdMMVRjRDHbDh8ScLbKStkn4443snRGRS4uf8my0Njl4PAk/WgEAzIuwKgpEjwCyWYY4yRFK+iPdsp8k2MeZP4NGiyOmY65LFrLkvwicy97+/Pkp8NNtRJ9Gjsen+iR0UeUj5isw0VcTdq8Zv8BGY5FygY+R9Q55mv70JNGlIHXGZg4ci4X2yu4d2it77Z6fEn2zxJytA6pKzCAcq+RYcuk9je2/NZQT7KefXr5dz6ieBYqPkxfNIXkidIE4nS88/7SrQGHc7Px918EilZ5DggIZj+xgukTY0phhzEhjG3OG+C2xRojwW4Kbu+1YSvvnTMzE57IkwxdeLrDVPZ2iQci05xtYF7Kb/v3OywbTMP20El2i3ZQPm0QFjGfqpjBM+06l0k8kj1fl8/j27NH2T6zgRzGdhvFw8oN0uLz8dNVsregi4IqjJeoFbAWsJfXiOTw9hOxolqKj9GyeLVUsG5Xvc/Zm6Wu89+H1FdnwMxfYUmYDxT8yeg3nyTgHxtZ8IgH2jSz70EgPvdt8QVM5SDZueOW/vxobTktZHSPS15VAQXwxXwKcH3lZvTbr6fUVYmsIZ+sdzj0K8iZX8wOp/Q1jbuUSBbcwB/RQxH3J9aF8YNDtgfoIhbtnRtk4/uO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(366016)(23010399003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWlUeHVSN2ZENWorVlhZVUpGWitjUDdES0tXcUlwMVlXT2t6V0d3MTYzaURh?=
 =?utf-8?B?bDd0dlFOdU5kUFdPS0RZSnlWNjRXRi8rKzY3djlQT2ZaTVVnWjZpSVlZSzJy?=
 =?utf-8?B?WWRzcTVZRzN5dno0STk1RVRqaW0rRlRGN0tVRFFTRFRtWTF4TFdUbGhPOENF?=
 =?utf-8?B?dm4wOUozeWtnYTlLMGMrc3dqcENYVmhXNEdOak1KV2x1RHU3ZXBBcGYyZW1W?=
 =?utf-8?B?ZVpPZ2Z2VHFYWXR3dUZQVnB3UG5XOFVMUU5sdG5vWVo1MU5ianV5ckFZVEhY?=
 =?utf-8?B?K1VDU3J6RUhJRTVJbHo1V3RkcnZDSjFHbG1kaGJSRWI3WFhob1p4a0szUVZI?=
 =?utf-8?B?cFMvYlJDVDJMZkhJQVkzcFdXaHF5ekNON0RyclVxcm1TTDd1enVOMG1xV3VX?=
 =?utf-8?B?cWk3MlVSek9KdDhWZmg3Y1JvYlNyazBBL0N6L21VMjBMV2ZCZHpJRzVHQVYr?=
 =?utf-8?B?eDFkdlNKd2tZN3BtbEJubU5LTnRhRkp2cHlBejM4aFV0dDdpRTgxT09UZnBH?=
 =?utf-8?B?bHBKWmliZFZZcGc3L1ZtSTQ4L2hyNHA2RGFmYWtDckdQSnhTYlFPeGc2WmZo?=
 =?utf-8?B?dkoxTTV3QUIyT0U5cGt6R01kSzBOYlp5clltU2RkaVNWMU43ZStrSEt0RDVh?=
 =?utf-8?B?bzJXbkx1TnJxS3BhSGJBR2F2V2J4RzB3T3dlTHdlaUpNOWNFaTBZMFFVU3Fx?=
 =?utf-8?B?bUJrSUl3QlUrbS9zWmlnT3pCK0xyeXVuUFNpaUZDazI3VmtFSldJT0lodDN2?=
 =?utf-8?B?VEphUnlkbFcxTmozV21kQ2JpMGhvOVNTK2c1djBJZFE4eHdqMFpJOUQ0bU1H?=
 =?utf-8?B?RDB6b1ZKd0dySHE5eHc2eStJaFNMbEE0TG8xVE1aMVo0aU1zYVovV0YxeGFH?=
 =?utf-8?B?UXJVb1VsQWNzNXhlbWhIdTdoVWl1c0pUeEVnMVFKQ0s4WklZMk02NW0rMEhW?=
 =?utf-8?B?NE5sN0VwRFBGWm50SXExQjJFQTZGVjY0MkdJZ05WV1dJNVpDVnhyRnFrcHIr?=
 =?utf-8?B?b3JWN0dOcStQUEYxcUdBNy9jTUFldzNId3I5NUk5bTBCdVpuSnZubVFUVysv?=
 =?utf-8?B?Yk93bXN5L1F4RTMyS2RHTUt0WGVFMys5QUlEV3FuTGZwbnduM3NQWkhWZkRz?=
 =?utf-8?B?eFI2MXY0ZU12NkxjNlVnNC9FYnZlZE9tQ013OUdJN2FYRk5ZS2RMRXhnZTE1?=
 =?utf-8?B?Uy9UbjVWVFZ3NkdHRFFGa3BuS29VQXo3dlJZRmhwQ2JXdDNDaG5DV0U4UFNK?=
 =?utf-8?B?UmdWNE5zWTUxS0pmQnpDTWRXRklxTS9mc28yOWo1b1JLR2xOL0NmSXhZUVdk?=
 =?utf-8?B?aUlFQlUvVGs2M3JvTFByUm5ibFdCaVQzMGE1cUNadkpjaEhQMkFPNkw1Vitm?=
 =?utf-8?B?UGNYVllKWnBranphOExtejRSWlVYTjRGbGt6bVBNUHZMUFV6czlpVXRJYXd1?=
 =?utf-8?B?UlpkTVNtVWVxMjI2UzN3c2NGV3NmSXZ4OWxGRUJxWUpaRVFQeDZOaHRxZGhL?=
 =?utf-8?B?aHdxbzFOenVxSDE4TmhGSmZKeXpGa3dqbFk5SC9od0hjNWNuTmt4UVVuYlFV?=
 =?utf-8?B?R2o4cUIxUXVPK2RwR1hEUW1jQmZmSDI0YlF0a0NnWDZXajltTThFSkMydXZ6?=
 =?utf-8?B?c2xnQzF5N1RXc1k3Qjh1Qm14V3JCSWdXZ1lJdlVPbmF0cTgrZ2lXMTlxSitj?=
 =?utf-8?B?MzJhaG1JRW5LREtDL3RBd3cvbm1LemxsTklnWlJJT1VTOXJtb3ZNcitSQjhT?=
 =?utf-8?B?bnpVNXIyWDYxa21SWDJUTGwvYzg5TzJKRnJjNUpjZVQveTd0UXJJWUY4MTha?=
 =?utf-8?B?T3d4KzlyYTZDQVgwMU5KblFVUVVTYU1na1hpQUo3OTFwRUF0c1FHUUE1cXE3?=
 =?utf-8?B?ZWFtbHpuYW9ibkZsc2NDWVdsbjJHMG0wR3FZN2xTUEtNeG44TDlPWnhuOWlx?=
 =?utf-8?B?VVZhV0VadGhyVzFqbEMyQlFVYThSRHRYdWdpM3ZrbnhLU0JxTEJhcCtXeXNp?=
 =?utf-8?B?RFVGV1poNzhMOHcwbFVzR0k3TUJOd3M0ZS95dW9Eall2R2RNcFo2RzZuMnlQ?=
 =?utf-8?B?OGlNMDhoNmRYaGpTMWJYN1R3VkQ2YVVObDIrVmlRM0czdVlUVm84dTQ5eFJk?=
 =?utf-8?B?WFowTFBPQnlmaUlaUEZMRW03Qit0SGlxL09EalJEeVcrSGVLZ2ZrT2JQMEQz?=
 =?utf-8?B?eUs4UFFCTTV2c2FTZTRMVGtraGdlbkNHUmtkdU1vSVQrb2d4QThoTEpRWVRo?=
 =?utf-8?B?TjJheHhDNGJyR0hxcWJEdmFtRnZEdFZVNnBtdWVaMzlJdEszR1J5djhKcVZN?=
 =?utf-8?B?eHJyTG9qM215emlGYm9mZnJpOGRXMTg1QVNxbGROcURrdjJDbFU0RS93L3BQ?=
 =?utf-8?Q?ZfRYqEgZMRcavvJlc381agrNpQOqb1DotzjzTEshHTBR/?=
x-ms-exchange-antispam-messagedata-1: 18/VQ1ASaRfGg7psh/usXtVrgbzXvugNg8g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE29187F1F994941BEB152B50508348C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D/22gZd7t30GS6x5MtBrMWZSJTB4z3INnnFUJM4+V9pbNfqf9PUC6qj+xz+EwAmDldtdNUJPyi92p/kqZvoiEv2SxkkhQtCAAFNx/kUtPPhEbwGoyjbqQjQCVFOBnZS60QcGpBYGpN5D6TEs80kmm5k/AMIKgQwdK5Rqc6epfe4LPraZBnY1367rlkNpJvpg6TgVhellN/A9fmfFEzLNCBx7ba3tA8iV6Jf9uraLB6YVIiuB65sKWwQZ8pzmowxTIfdrR/tJB2mlrFUWjx6ANvqBPBl1HySipTHb9j2FwAqHakrM8OQDREHgqUqlNE2/3J1L4ebuPCORaZ05IRWPWw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zcx+oRcssqRkRoN3Mo1AuzN9Srfk+DBkpEFTkC+xEBGl6r3KvmrNHBkUAi+DWO32HJ4GFIlcfKVpA8eJf1ptNFm7H7U0Jj7LxtfU6TxN4vHE4p9HpKPZXvsljZORXs0IrfLp8w7UIRdDw3w6tWQ0aC3+TrmWRFQA9sPfNK7cVl0HD4KSYjWJsJ2RomEjFDJZ51NxvtAgMd6FMBQQ2jXZWKMYEl4KwFVj6ha0fJT1RB9OzmlfCpmtTg1nMYVYjtCYR5TjQLB7XRokrWbOiWG84hjjZtabZqBVIZqpU3jTPBdW3MdLidgKulK/xhFbpEJLalpiCkAaQ6uVV1v1q/F8jIC5EKE81/o4mnBXykotHM8K/ZFJ9xCd80kUQDqUVxGQSqx0W0wl4jJF42l7d6+QmFNQTkDxYWHvlgBvrZ4RYZzVQa1RzW4ZnrLfg7ZjYvfEiTVTijBEGQQ9Ee9UrxJIG3wmQWM1zLA0dcp0AlnG/ShqDs68a/hMB0RaRAjdgsfmxGKrwIVRslWLaPg0mg+YPDXnqlBfNvfWwsDYMI/pIUrB0rxY5o/wYOejD+0KwEtlZMO2USv+tyMAwV7c/xLcRmqqOFcY3Z0ZCjjWeDs+MoT0SByAbMXuCI8nTGSNJCQS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ebc8c1-10df-4ec3-e710-08df04a5a929
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 01:42:46.3836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNkQOQJAIf2AGf/TiQMWQzqgFD7zija3UivKZYnkWUpqAbXFNVp6zkaYZpxADcPr/v0WzYDG3OirjI/vpPyKdXzvotRFksENtqxPE7F9N14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994026
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6935b7a9c=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDA4OjQ5ICswMzAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
DQo+IE9uIDgvMjcvMjYgMDg6MTgsIEpvZWwgU3RhbmxleSB3cm90ZToNCj4gPiBPbiBUaHUsIDI3
IEF1ZyAyMDI2IGF0IDA3OjU3LCA8bmVuZGVuc3VAaXNwcmFzLnJ1PiB3cm90ZToNCj4gPiA+ID4g
SSdtIHBpY2tpbmcgdGhpcyBwYXRjaCBzZXQgZm9yIHRoZSBjdXJyZW50bHkgYWN0aXZlIHFlbXUg
c3RhYmxlDQo+ID4gPiA+IHNlcmllcyAoMTAuMCBMVFMsIDExLjAsIDExLjEpLsKgIEhvd2V2ZXIs
IGl0IGRvZXMgbm90IHdvcmsgb24NCj4gPiA+ID4gMTEuMC54IGFscmVhZHkgKGl0IHdvcmtzIG9r
IG9uIDExLjEueCksIHRoZSB0ZXN0IGZhaWxzOg0KPiA+IA0KPiA+ID4gPiBTaG91bGQgSSBwaWNr
IHNvbWV0aGluZyBlbHNlIGZvciAxMS4wIGFuZCAxMC4wIChvbiAxMC4wIGl0DQo+ID4gPiA+IGZh
aWxzIHRoZQ0KPiA+ID4gPiBzYW1lIHdheSksDQo+ID4gPiA+IHNvIHRoZSB0ZXN0IHN1Y2NlZWRz
LCBvciBzaG91bGQgSSBkcm9wIHRoaXMgcGF0Y2ggc2V0IGZyb20NCj4gPiA+ID4gMTEuMS54Pw0K
PiANCj4gPiA+IFRoYW5rIHlvdSBmb3IgdGVzdGluZy4gRnJvbSBteSBydW5zIGl0IHNlZW1zIHRo
YXQgMTAuMCwgMTEuMCBsYWNrDQo+ID4gPiBjb21taXQNCj4gPiA+IDU2OWFhNjI4ICh0YXJnZXQv
cmlzY3Y6IHR0LWFzY2Fsb246IEVuYWJsZSBaa3IgZXh0ZW5zaW9uKSwgd2hpY2gNCj4gPiA+IGVu
YWJsZXMNCj4gPiA+IFprciBmb3IgdHQtYXNjYWxvbiwgc28gcmVhZGluZyB0aGUgc2VlZCB0cmln
Z2VycyBhbiBhc3NlcnRpb24gaW4NCj4gPiA+IGNzcl9jYWxsLiBBcG9sb2dpZXMgaWYgSWBtIG1p
c3Npbmcgc29tZXRoaW5nIGhlcmUuIElgbSBub3Qgc3VyZQ0KPiA+ID4gd2hpY2ggaXMNCj4gPiA+
IGJldHRlciBmb3Igc3RhYmxlOiBiYWNrcG9ydGluZyA1NjlhYTYyOCwgb3Igc2tpcHBpbmcgdGhl
IHRlc3QNCj4gPiA+IHBhdGNoLg0KPiANCj4gQWhhLsKgIFRoaXMgaXMgd2h5IEknbSBhc2tpbmcg
LSBJIGRvbid0IGtub3cgbXVjaCBhYm91dCByaXNjdg0KPiBpbnRlcm5hbHMgOikNCj4gDQo+IEl2
YW4sIHRoZXJlJ3Mgbm90aGluZyB0byBhcG9sb2dpemUgYWJvdXQsIHlvdSBkaWQgbm90aGluZyB3
cm9uZyBpbg0KPiB0aGlzDQo+IGNvbnRleHQsIC0gaXQgaXMganVzdCBtZSB3aG8gZG9lcyBub3Qg
aGF2ZSBrbm93bGVkZ2UgYWJvdXQgYWxsIHRoZXNlDQo+IHJpc2N2DQo+IGRldGFpbHMsIHdoYXQg
ZG9lcyBpdCBhbGwgbWVhbiwgYW5kIHdoaWNoIHBhcnRzIGFyZSBpbXBvcnRhbnQgb3Igbm90Lg0K
PiANCj4gPiBCYWNrcG9ydGluZyA1NjlhYTYyOCBzZWVtcyByZWFzb25hYmxlIHRvIG1lLg0KPiAN
Cj4gSSBhZ3JlZSBpdCdzIGJlc3QgdG8gcGljayB1cCA1NjlhYTYyOCB0b28sIHRoaXMgaXMgbXkg
aW5pdGlhbCB0aG91Z2h0DQo+IHdoZW4NCj4gSSB3YXMgcmVhZGluZyByZXBseSBmcm9tIEl2YW4u
DQo+IA0KPiBIb3dldmVyIGl0IGhhcyBhbm90aGVyIGlzc3VlOiB0aGlzIGNvbW1pdCB3b3JrcyBm
aW5lIG9uIDExLjAueCwgYnV0DQo+IDEwLjAueA0KPiBwcmUtZGF0ZXMgUklTQ1ZDUFVEZWYgY29u
dmVyc2lvbi4NCj4gDQo+IEFzIGZhciBhcyBJIGNhbiBzZWUsIDU2OWFhNjI4IGlzIGFib3V0IFRZ
UEVfUklTQ1ZfQ1BVX1RUX0FTQ0FMT04sIGFuZA0KPiBoZW5jZQ0KPiBpdCBpcyAwOWVmN2Q5NzQ1
NCAidGFyZ2V0L3Jpc2N2OiBjb252ZXJ0IFRUIEFzY2Fsb24gdG8gUklTQ1ZDUFVEZWYiLA0KPiBz
byBpbg0KPiAxMC4wLnggaXQgYmVjb21lczoNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlz
Y3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5kZXggYmY0ODU1ZWMwMmQuLjVlMzdj
YzM2NDVkIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0
L3Jpc2N2L2NwdS5jDQo+IEBAIC02NDYsNiArNjQ2LDcgQEAgc3RhdGljIHZvaWQgcnY2NF90dF9h
c2NhbG9uX2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KPiDCoMKgwqDCoMKgIGNwdS0+Y2ZnLmV4dF96
YmEgPSB0cnVlOw0KPiDCoMKgwqDCoMKgIGNwdS0+Y2ZnLmV4dF96YmIgPSB0cnVlOw0KPiDCoMKg
wqDCoMKgIGNwdS0+Y2ZnLmV4dF96YnMgPSB0cnVlOw0KPiArwqDCoMKgIGNwdS0+Y2ZnLmV4dF96
a3IgPSB0cnVlOw0KPiDCoMKgwqDCoMKgIGNwdS0+Y2ZnLmV4dF96a3QgPSB0cnVlOw0KPiDCoMKg
wqDCoMKgIGNwdS0+Y2ZnLmV4dF96dmJiID0gdHJ1ZTsNCj4gwqDCoMKgwqDCoCBjcHUtPmNmZy5l
eHRfenZiYyA9IHRydWU7DQoNClRoYXQgbG9va3MgY29ycmVjdA0KDQo+IA0KPiAodGhlIFJJU0NW
Q1BVRGVmIGNvbnZlcnNpb24gbWFkZSB0aGlzIHN0dWZmIGEgYml0IG1vcmUgZGlmZmljdWx0DQo+
IHRvIHNlZSBpbiBhIGRpZmYsIHNpbmNlIG5vdyB0aGUgZGlmZiBkb2VzIG5vdCBzaG93IHdoaWNo
IGNwdSB0eXBlDQo+IHRoZSBjaGFuZ2UgYmVsb25ncyB0bykuDQo+IA0KPiBXaXRoIHRoYXQsIGl0
IGFsbCBzaG91bGQgd29yaywgYW5kIEknbSBwaWNraW5nIGl0IHVwIGZvciB0aGUNCj4gbmV4dCBz
dGFibGUgc2VyaWVzLg0KDQpUaGFuayB5b3UhDQoNCkFsaXN0YWlyDQoNCj4gDQo+IEJ1dCBvdmVy
YWxsLCBpdCBsb29rcyBsaWtlIGl0IGFsbCBpcyBhIHJhdGhlciBuaWNoZSB0aGluZywgYW5kDQo+
IG1pZ2h0IG5vdCByZWFsbHkgYmVsb25nIHRvIHN0YWJsZSBzZXJpZXMgYXQgYWxsICgqKS7CoCBT
aW5jZSB3ZQ0KPiBhbHJlYWR5IHNwZW50IHF1aXRlIHNvbWUgdGltZSBvbiB0aGlzIGFuZCByZXNv
bHZlZCBhbGwgaXNzdWVzLA0KPiBsZXQncyBwaWNrIGl0IHVwIGFueXdheSA6KQ0KPiANCj4gKCop
IEkgbWVhbiwgYWxsIHRoZXNlIHNtYWxsIGZpeGVzIHRvZ2V0aGVyLCB3aGljaCBzaG91bGQgYmUN
Cj4gZWl0aGVyIHBpY2tlZCB1cCBvciBub3QsIGJ1dCBhbGwgdG9nZXRoZXIsIC0gNTY5YWE2Mjgs
IHRoaXMNCj4gcGF0Y2ggSSdtIHJlcGx5aW5nIHRvLCBhbmQgdGhlIHRlc3QgZm9yIGl0Lg0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gL21qdA0K

