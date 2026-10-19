Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9624CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdSz-0003KG-O4; Sun, 18 Oct 2026 22:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdSq-0003Jd-0B; Sun, 18 Oct 2026 22:51:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIdSm-0003tZ-NH; Sun, 18 Oct 2026 22:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792378260; x=1823914260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AWIRM8pkeerfC7ZQK78TTRArzc1jNgPb0CcGUJ1131o=;
 b=N1rVkLizYnSvCNIcipcXM3Ht8uJcpfllgJuOOovTgY2oOHJAQq4vZTNh
 JMl9n9m0jt37KGc7ovYw06cUyKhIOBrXfIZjEGVtbFbTqswK0sz2sWjDh
 nX7UHYhvQz5tTtASsmr6WG9BRbRl91K2m0tiUBxPCEzncJwNWEtLw4aeZ
 UiCCXblaC9fJwMFJKI0N3vLChdn/1H9dr3hOmVotAoj+8Zdc2yidy4WLu
 lhRprYERIvgyVUag2Bs+NTKik+CTSH4Pd5QYoXcJrBmsGEHyA2AIK63U8
 YC4rmTSKdXxRJr0sQjJXFhPNDfl1CbuqoID8yvfB49tj5j5355SnUso+i w==;
X-CSE-ConnectionGUID: qzuWY6ciRci0GaoLWjy9UA==
X-CSE-MsgGUID: PS5U9ThKRoe0zWaP9xjUEA==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="154190265"
Received: from mail-westus2azon11012025.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.25])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:50:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKB3yjhQ7BLyJZ1DVuG2N/1jSNdMg75Lcv7OXPCOrLE1St5Tq630QfZV3Dy5xyDWSZQZoziYudNFfBwasPa53uUbyGOckiWKB9jAbpr5AsbBcry6f0moSNq+E0vHR0kIGbZJqTdxKLx4c42pK4DLMlnO2t+n3rGEDRPYB/1Hl7AOBTJ0o9kZ2NbyO2vEH1fTfzqnnU60EFzN4kM7WyIgQl2hCSnRA0lvS3gMdGYBLJQF99xPiPbw8QpnGVv+eGKpKSDzDct2sR2O8XxcvKhAqpa2cEpeQpK+/Ku5yuNktavOpuZ6zz5lSjloRNYdFHAz9R5/3VOrAcZCVWsVdSQsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWIRM8pkeerfC7ZQK78TTRArzc1jNgPb0CcGUJ1131o=;
 b=i/j3s/xd9ECN+8DKMozOaGoqkRoxKPlMsNefUcNV0DMLS+RKK25OxkRspXPEwjszPGUA6/hU9AmeuLp9pxhyt60dxOe1d/U26FXwrUTTnIGLhSq1T2b2Tru6PdMSltJGWPCY5+B+qirFZ5erjBPUnO9IFT29as83Jn81z8vjw2HiiWKE1EbU32omkwWHq+3eFBkQ80Nu8G+vy3KsdL84EVptTpEpYBUCpADQt0y/vfb7FG3aWIyCuqB5hqEw8baZhLy+864pk1kxgXvhGXSfRsYAHH9RAVutEsjohJA2CQWFbVdukSm7HytJCos8IIrdurlHb+Spp5pFTuqALj6/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWIRM8pkeerfC7ZQK78TTRArzc1jNgPb0CcGUJ1131o=;
 b=u+pMhfLiPvVHDujZhoUuO1CLsFMuV2krbubNItRxQnzzj1JnrxKtmL63n3quj7aEMxoBu9FaTR0+a8eX60bTxzr25OZWznQjXGROXw0y1xJaGUzGsX/Y71VAnkOCRguJvEOshdtP8HJxeC8jTXauLgsCSlbnjWjN1eKJnK6ilg8=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH2PR04MB6789.namprd04.prod.outlook.com (2603:10b6:610:a0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 02:49:19 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:49:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v3 0/5] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
Thread-Topic: [PATCH v3 0/5] Fix integer handling issues in k230_gsdma and
 k230_decomp_gzip
Thread-Index: AQHdXwppgUPXtxHng0W0ZX28XcNL1rcEKsiA
Date: Mon, 19 Oct 2026 02:49:18 +0000
Message-ID: <43bf6b4e614824cd7f1e8db5b1f74704a6386eef.camel@wdc.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
In-Reply-To: <20261018141006.16398-1-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH2PR04MB6789:EE_
x-ms-office365-filtering-correlation-id: 4ac8c161-0e9d-4886-8da8-08df2d8b9261
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|23010399003|366016|10070799003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: Xgg9gga3uZgwPz81jg0CLsDWObN9/iS/W+YoW3kf454PXVOPpC5t3pt6sgT3eeeKkg+Q5cLMC5X3o5VtcpJaxvGKjmY4xj+q8c1/jFdpX6l1cyrZVyILiKhVrleMvcvHmCblbMMmDjDqccd8W/dE3dYuNuCHQQtC8yh4qpn0f3apNAwDlCg0Fg/z++6zWJk/9tPtGZTX4ZGfZwwt3bomq6rZgowezgEHpMrZokMMHhLG3cnYTq74HGDO2IGZU1a8RZeBuQDUDTpOQGzjWyiSeQRlN8auNnx/GAlsfyFrWuNK11bZJL53NlUZd6rmOFsUgZ77LSzjvBQwMz41+aXJ/KGoGPMXl/Ymdk6OXc+vyKQzh8r7G/XV0RyrXqo5kIX4CN1227iuppi0mSYKHM2h1875hweW06v+b7Z9MlePXJH781OTiw9bOgJZbuFDaJDgy3e+VK//FQdRPiFz3FQQorncogMK/ynmW3TwfKqn7n74Yv9Lhr+HxeDXvojVh7ugiatknk57fDwG+udNDzkHOu6RtdM2VIqbranMGpyfOWH3ayD/o6DxNPGrYHdUAG2UOo7IxHMEthkdE8Ex+bJngwAbPlp1HkRb22eT8bFf9auQufB3aQZOOxAYM+ZHa9FijHhJVo18CmbTxvNQwEdKOuxCEVS5QM5jd6SxQ9d6xnA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0ltTXFmM0JZcENCeEtSd3ZUNWpBL3lLZitLUjFPak5meXhsQ2F1azgrTzdi?=
 =?utf-8?B?YnByN3llU2hQRXYxQlNySjZnNXVFYXAxLzlRZkVRdUJDaFQvUnkzeU9ieWlF?=
 =?utf-8?B?MFcvTFRQeUJEVHh5Wks4VnNaSFZuS2JFMDkwSWd1Q2NsZjVmVGxRNVphZFVw?=
 =?utf-8?B?M25JM3RxemFXVnIvTjhVUEV5Sk5pR0t6am12aVEybnBQMk1ieGMybUFkSlNj?=
 =?utf-8?B?bDRrRS9ZODJQU2dhbzFhUVdVZFQ5YmVGcWphdjlYQjFPbWVmR05XT0FVdGgr?=
 =?utf-8?B?RFg5bDV2dnZicWZFT3h5cjdGWXoyQUUzeUprZUNvL1UwWkFtTmQzdTB2dU84?=
 =?utf-8?B?RTRaSmI0K0VsR2d1WVNtY3k0S0JtWGw0aUU1OWlyemZNQXl4bTB5N3RuUGpx?=
 =?utf-8?B?VDdGcjRCVTRtdmRvTzY0T2ZiU2Q2aU5lOFZYNFlYWWxVdmNCdFB5MXJUQ09P?=
 =?utf-8?B?NlJjc2FwZ1RYb1l4d0FqWVllYjZNQ3ZZQytNVmNYeVpXU2s5WFdBOWxZeWVx?=
 =?utf-8?B?ZzZsZTJwaDQ2am9qTHJQUjkrV3BtNXl4akVCNW0zRUhqejlHbC9wWHl3QXpp?=
 =?utf-8?B?MGhMTzZXc1pLaE8vMndBNk9ndUtPSmdRYXJRN2VzWEtKZWNVMUVmVDlsQVF3?=
 =?utf-8?B?ZkhvOFhPNVY0aTgrQXRoaVpqRVBpUzZnc3NRSENwNUMyQTVmUHhDYWtUMVFu?=
 =?utf-8?B?WlZjVjdIVHF2TFNjZnhlMzZ4ZGhuU0Zrc3dzU1c5cnFYOWlQUHNuU0Z2TlRU?=
 =?utf-8?B?aHBpVmpDOERXcVJ4aWFiZGZSa3NDdjg4T0tpYWdQWmd5NFR0UDZEempWdGhj?=
 =?utf-8?B?WnVTSkNyZEJ4T2YvTUFpK21WbGRIUzcyZmQ1WEJEZExGbjFtNncyaXJWU2pF?=
 =?utf-8?B?Vk1WNzU1SmlrL1dkeEFVVUMyV01RTnhhRkJWSUg4Qm9abENuM3hHb2lCYUxs?=
 =?utf-8?B?SEc2b0EyME5rQ0JCTjFtMmdPc1R3UnhicHVmNXVnQXIreVhab21YVTdFWjBj?=
 =?utf-8?B?QzR5dEkvendIUU52Z0tFSmhnMWduRVhodVZXQlk3aUNIZVVuT3RmMTBCVWM3?=
 =?utf-8?B?Qnl3TFp2SU5wQ01HV2pHTFpJRGpldVZqcDZuc1o1SUhsZjIyaGZWdnNMTy9q?=
 =?utf-8?B?MmNvNWtIb05FQzdOb2IwQ0I3WlBKczJNRjdnK25TLzBsNE9QbkFnREF3c3lP?=
 =?utf-8?B?ZHZKVTRmb0trTHllNVFVOElGWGNVNWV6Z3ZsTldtb1dHY1B6cWwwclN4c0JG?=
 =?utf-8?B?QnpjK3RIVkFYSFFHVmZFM2lOR0JUK2owdG1aamtEOVQ3eGFaVCtlZU1LdXlZ?=
 =?utf-8?B?QnpiZDg5dExRcEVmQU9rQXBVVDM5YmN6SmZNZ0p6NWF5SnVuRHBTSCtrR1ZL?=
 =?utf-8?B?L0ZPQzZXeElheHRkSk1admpEdHhPbzFjSUwvYXNpL29Ka2g4cENnVUZlWDlo?=
 =?utf-8?B?VnpQUVVBZ1hSSjVvYnZnam5tdHgxTVJ6R3kxQ1ovNzFrS2tQVWhlWE95Uy9L?=
 =?utf-8?B?K1hXV00zNTZjSmE1L3g1Z1ZQeDFVd1dIYXBua3d2M2RXcmJIak1tWHd0M3ZE?=
 =?utf-8?B?VGw0SXpYcFBlRG5vTVNyZlhob296V1dxSm82ZzRja1VhQ1lDWUJ2UUdxUm5G?=
 =?utf-8?B?QU1jM1hjUUV5ZjhmSWkzUmtDSGx3MXJVM3llVTQ0UWcvVVJSM1FkM1BCbVoz?=
 =?utf-8?B?UHVVOXVyYjU5MXFSUXNUdFpGQnFSTGZZemN1aUEwZ3AxcW1TT2ZXWkFuYUk1?=
 =?utf-8?B?V1BaV2IvV2U4VC9jdWVwQ1ROZEZkU2NjUlhINFlMMUsyQ216Q1ZUMTltcFNn?=
 =?utf-8?B?d2dPSGdmOS9hN05EY2drRGpxc0tkVEpUU2dqbW9CRm1Bejdranh1THlESmFF?=
 =?utf-8?B?T2tPc2l5c2xtM2taRHlWS1d6bFpwL1R5dVdiY0ZPYStqY3ZaTStVSllORjBX?=
 =?utf-8?B?TUxmVDdvQlYyWDRXUThNUk1mS3Nla1J4QzRrN0hvR05HalJlZVpZekJDWi80?=
 =?utf-8?B?MzRoUTdKb2NUYWVyWkZFSlM1Zkd5QzQwU3pxZmdTN2ZUdlBPZS9tdlMrMHJx?=
 =?utf-8?B?dE04Vy9JWHllS3ljRkxRN2ZyUnhqc2xEUFNieUlvamNlaXZTbVd6U1ZWWUdB?=
 =?utf-8?B?RDZZSkZ2Rlp0cnFJVnJvQk5QQlI5VFpSYmpaeThNSVJIL1lsZXBMZ250RDNI?=
 =?utf-8?B?SWhHemJYWU9objlvVCsyeWRLUHRNZGYxbDlHYTIwRks1Mk5BNlVFSGp6cUpY?=
 =?utf-8?B?QzFneVBWeEI4UmdPNnJqekpFWFZOYU9wSE9UeFVNbi9DcnFoVi9idDBMb1Rx?=
 =?utf-8?B?OS9LQ2x5REF6NllzQjhCdWJSdDlGWFVjWk01VlhaZGFZZ2pkYW5vcWpnazFv?=
 =?utf-8?Q?tw40e4AOvvXYx0w6LQmj7XT2aSsw6bT3a7oY+brG8kRN9?=
x-ms-exchange-antispam-messagedata-1: /lTmvkpP/x8BAybp29rhtFR1pvxZWwMYw2g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC0BD78BBF57B499EC714A9142BE73E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EYdaZypWbUNsJtnawfxOgQSS//a++0rrP83OeIOYkPkOpHeIhW0B45RHpeHW8ZsBmsnGXCAovhtyf7E2GeYEWQK74A7HXbBfPCoHR69lr8JosgKKyQekjolisXYlwmBmeT08RgRnzGspjK7HRJHltlb4Vtoqw/A9Tb6hZ0TFw0fCpjbIreuUp6n5P6BpeNYp9oLZotQprOyOM+d3+xBn2TwTd3vZuO/P4vX4tqh6PPZJ1eUWFGU/c912w9ziGQrq6ptt/Fqh51S9lavuJ2VBWL37qBfqTifwClSdEHpoIWXxKYotJiK4FaFOCKxGXTJrBMoo3ZViB2eGKN6BezZzTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c8FuEyi/5W1nRIA5AToPfE5PRfAZcckjrnKq/me7w4VpufKAnma/eP+QcnDRLc1/zbAI4KzLxZy5iadcJJg9BvVcRKOqAO1vGba5J91YLhctr1Pa/OHqgtqwv/l8B3buNqKHgRwep4+BxcWWsdCOD2uZyQGCbENG0n7hmilsEgmRy64tR0HtPpDIK/q4Z8491aKXdQVR0e+HlIz3chII22NzsO3nZ22AoluAfdLJYH6bCy2UeY+x7jPOA9LbN9uYn6eslyzBDaPpf8jM+uc9MIKUuO9ZU3SJRnamVv7+/KMAtgMr9V2Rg2c0N8TwT2959yio5gAkLAp9+Wr8pk7vnBQwzBOfBa/dnw55Lfd5RyJ5Zyegn2IbxONbWZUyL1/kpc7VD5Fh365OYB4IJsdOdPwsuOAYdKwhVTb6NRJSO60PcnIFc4pSrMxiOpTM5f9W3CTEtNaRSgnuLlVYO9p9npjSlpE6IymiR3dlPShpm+AZAO+ZNZSWHdphuDBo2Kg9/TNFTb+6vEJnWkaGIk135tP2WrnPzVXJNEb3ZaqUb6zg6RGtvOdK3vrZOfKu8V5X0c+7bZVUtet237nJJDIC1HMpg6l7nJkHlOxqBUG/2CAsCGdNzPpLVLJuywJQJqS4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8c161-0e9d-4886-8da8-08df2d8b9261
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:49:18.9175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dStFTQ16/FLkWIGJybYdKDVcXIKFkLKrHXl7mJqeMVq84+uTPjj8InO9H+i8SRYiZTXu9G6oQBT1VcJ+IJYkFuFH1JyCcu96ufUUewloxFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6789
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTEwLTE4IGF0IDIyOjEwICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gSGks
IGFsbA0KPiANCj4gVGhpcyBzZXJpZXMgZml4ZXMgaW50ZWdlciBvdmVyZmxvdywgdHJ1bmNhdGlv
biwgYW5kIHVuZGVyZmxvdyBpc3N1ZXMNCj4gcmVwb3J0ZWQgYnkgQ292ZXJpdHkgaW4gdGhlIEsy
MzAgR1pJUCBkZWNvbXByZXNzb3IsIGl0cyBxdGVzdCwgYW5kDQo+IEdTRE1BLg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzVmYzU3ZjQ5Y2VhMGFjMzU0MjEyOGQwZTIyMDhl
ZGQ2ZDc0ODRmN2UuY2FtZWxAd2RjLmNvbS8NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IFRoZSBwYXRj
aHYxIHNlcmllcyBpcyBwb3N0ZWQgaW46DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjAyNjEwMDIxNDAyNDUuMzAyMTQtMS1kaW5ndGFvMDQzMEAxNjMuY29tLw0KPiANCj4g
Q2hhbmdlcyBpbiB2Mi0+djM6DQo+IC0gU2VwYXJhdGUgZ2xvYmFsIGFuZCBjaGFubmVsIHJlZ2lz
dGVyIGhhbmRsaW5nIHRvIHByZXZlbnQgdW5zaWduZWQNCj4gYWRkcmVzcyB1bmRlcmZsb3cgDQo+
IMKgIHdoZW4gY2FsY3VsYXRpbmcgR1NETUEgY2hhbm5lbCBvZmZzZXRzLg0KPiANCj4gVGFvIERp
bmcgKDUpOg0KPiDCoCBody9taXNjOiBmaXggY2FsY3VsYXRpbmcgb3V0cHV0IGFkZHJlc3Mgb3Zl
cmZsb3cgaW4NCj4gazIzMF9kZWNvbXBfZ3ppcA0KPiDCoCBody9taXNjOiBmaXggY2FsY3VsYXRp
bmcgaW5wdXQgYWRkcmVzcyBvdmVyZmxvdyBpbiBrMjMwX2RlY29tcF9nemlwDQo+IMKgIGh3L21p
c2M6IHVzZSBod2FkZHIgZm9yIHRoZSBrMjMwX2RlY29tcF9nemlwIGlucHV0IGFkZHJlc3MNCj4g
wqAgcXRlc3Q6IGZpeCBrMjMwX2RlY29tcF9nemlwIHRlc3QgaW50ZWdlciBoYW5kbGluZyBpc3N1
ZXMNCj4gwqAgaHcvZG1hOiBmaXggazIzMF9nc2RtYSBpbnRlZ2VyIGhhbmRsaW5nIGlzc3Vlcw0K
DQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0K
DQo+IA0KPiDCoGh3L2RtYS9rMjMwX2dzZG1hLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDg0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiDCoGh3L21pc2Mv
azIzMF9kZWNvbXBfZ3ppcC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICstLQ0KPiDCoHRlc3Rz
L3F0ZXN0L2syMzAtZGVjb21wLWd6aXAtdGVzdC5jIHzCoCAyICstDQo+IMKgMyBmaWxlcyBjaGFu
Z2VkLCA0NiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiBiYXNlLWNv
bW1pdDogMGExZWJkNDQ4YjM4YWZhYTExODU5N2NiYjYzM2RiZWMyNGVmNzRkMw0K

