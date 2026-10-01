Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD12CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC9N-00072I-Pi; Thu, 01 Oct 2026 04:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xCC98-0006kZ-9l; Thu, 01 Oct 2026 04:28:06 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdondi@axiado.com>)
 id 1xCC96-0003Ww-CF; Thu, 01 Oct 2026 04:28:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0razekIxL5joRPVM8g58J0j2n0nUG9nnp1kVJWge62cG59WAzH80U34aFxVSg3KUk4ouLCPoZEDE6n/X6pdbagINZ9U2+1bwUTOjDPsPBo+ojdXdSaEAGtibAfLPIJ9ybKTSsV+pkUNK5hFsgZXXfPQsEUldL4pvUNt4SOuXOLKluATFPxY0m5RN1hPqeKkaaS+sxrQWBTZ+UN0VVwsRGrFzobvW/OFhKYx1jAAwHeXgJxS9X0Y6+eDEU3VT3gKblxGrtJJu7HwmXY6V/x5Pn3/+YhSboiIYxe6rbonvw3kF+nOkx56BmV61XQ6bMHYifZRebptnrVasKyFSMW24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujtIJvVS6zgBX2K/lp5tsKyyCINVWVN2iS/Nj4glrFI=;
 b=oKdBYGkDweK48jXbvOUVZxaIR09gI+uGJ+/FE756osnLiopzOTKrDZPj4YLpVe0sIMeZxWG61FS9/ZGJz3dxr/dOhnC93cCFO7IyB0kiOoZm3wk0/ETrMr+fMD0+D6cy6kFzA4fRq7HdZ2IEbgHFU731NI/Fsx2CPWuoOut3SkxKybQfDhW8pq8J9vZxH0sFvEI8LEzTOw+t2T/9EnLvygOoA0gE6kEBuRg+SJxAXvjmRiop/cQafiDcpa77JB94RNTWRbRuVh6OK970tfr3pSXkH2Jgu45ONvrSoroLef2b7dU/DTtBKXbHHRQeMhK6IzEEuLMOUpqBlN8GXjc/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujtIJvVS6zgBX2K/lp5tsKyyCINVWVN2iS/Nj4glrFI=;
 b=Iy3N8JiXLZTPFqDt0nfBo8Wn3a9Vv8TFRy6SBzF1/JKhQfLQiO6WXZYhFqfS3wOJF0c/QJvZwYL8MEB36UHJBjhsvLYj70SIBDH6/YzhSdWmchkla6HpF5Z3Y9FuSyHA5brXohHX6fom83lDEBe4+mxiprTyGSfVivTgSrAH8TJum3oIPqItQGK4GhwSgjENQk/kODVTCumCYT/4qUKXO6mjmNRj87zYj0jJstNwh0U438q7BtuXatnQEMVb8SGYZ3xig20/JEDj5xglL83FwXHjkU9doZ6kPY5n0cts4UXTRIHw+/VTyxEYHKOCgDwOukAiCvmLGMXmvCi0q2zYqQ==
Received: from BY3PR18MB4610.namprd18.prod.outlook.com (2603:10b6:a03:3c1::12)
 by SJ0PR18MB3898.namprd18.prod.outlook.com (2603:10b6:a03:2e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:27:56 +0000
Received: from BY3PR18MB4610.namprd18.prod.outlook.com
 ([fe80::3a16:7cd7:36bf:fc1c]) by BY3PR18MB4610.namprd18.prod.outlook.com
 ([fe80::3a16:7cd7:36bf:fc1c%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 08:27:56 +0000
From: Ratan Lal Dondi <rdondi@axiado.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 Kuan-Jui Chiu <kchiu@axiado.com>, Ratan Lal Dondi <rdondi@axiado.com>
Subject: RE: [PATCH 0/2] Add Axiado HCP network device model
Thread-Topic: [PATCH 0/2] Add Axiado HCP network device model
Thread-Index: AQHdRZcStTweyMtPQ0uC+aY9yzDbjLbocXlg
Date: Thu, 1 Oct 2026 08:27:55 +0000
Message-ID: <BY3PR18MB4610744EC36195678C0A4497B58A2@BY3PR18MB4610.namprd18.prod.outlook.com>
References: <20260916045134.1687145-1-rdondi@axiado.com>
In-Reply-To: <20260916045134.1687145-1-rdondi@axiado.com>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4610:EE_|SJ0PR18MB3898:EE_
x-ms-office365-filtering-correlation-id: c0a13927-33b4-45c6-c0ed-08df1f95e4c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: WhDqqOXg8pYHUusz62mD9tJy+422H6kyke9r2UxIvJDKaXfCRX29Tb1ZuE98+0rKaKinVS7cfdFEIu72TwCPSFTv7CtwEyevCK/vfjK2prmNXCaaF9WnXGd5tDTg1iBGJ/ncIiHJtHYPKpgK193p9YkTbuiq0rN95GC4hJBzUu/LqeTNYhDW4Gq51WmYV6H+v1erEXlIRwBA8efZfAtlHIMjBydIICXNklvH5gHW1uyEZDLUB7iK5Jr85/OEYFOQxbP/A8B194NRRNyOFJr5UReNZ3eOb2zTyZuED3tQciYgPBJVPjh6ZDeX3LRLwbzGgwL8xNrtKOZkWT8ji2ni2Ciz+m96Xq2EupQT2Uo+da+7NCL6sIotrcmhuanU+zAXGuylth/xBMr4tybKuiVHSSdmtkT+xmJTH0Og//5fQIX2HIKNzRRWs3+k/ZqSB/2p2XiKH0XH0wpkUJK87XS3A5jqQjvaUNIRkqYn3c9fze19CbHB7BGHb9zsK1btVJKIqDHIsnJx1MGyDV5XZZdcV73XZhF+UAsa2L286mUggFkQ1vp4abJ+gaANVifgZ0ojCb3AM0T41c+djJgEmabXoa3CTeRk7W2f/CjrMR+TVR++uKnyEGFnq33krZDLf9OP/g2MHjmn5MeEsldrEbK/hrzQ0mkP53H0HEyXcsvg7rc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4610.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CY/5hnf718Y8xHSajrlSx0QXVuQ5gP36k4vQaciu7vbI53Abb4Xap6jC3CdN?=
 =?us-ascii?Q?+fNiEGJNyc/n3Pse0bGcKFe1X7Qqym/479NE7UI+sH3ETQkMM5or3Bysx7Le?=
 =?us-ascii?Q?oxSaRR53Y1FyqHkuJYKCIfWIRCSqvHMLWi1yv7T5sEMJurbHN/8mT98UR7yd?=
 =?us-ascii?Q?v/RKLx+EWwMb2gnGnzMGQov4p+gaIZXHpjrQtMXkRzQQz6xtzycjOWICeuhF?=
 =?us-ascii?Q?+8UY1q7yehoaLE8fKnhGhS40rLb3tgi4y3FnjMZkmiPzxnT7qodmNzh7nsGK?=
 =?us-ascii?Q?ND4ZKWb3iCwLISSu6BGZ29PX4CEbTOzP+AHr+U0GyGqgbNoM5Oth11FK1EDV?=
 =?us-ascii?Q?7ljbhDCTMHtusXUyNXVkqzcoso4xr9lc0Ib1dZSgTdiVloS9yQ1IxrSTzdX1?=
 =?us-ascii?Q?ejHkMLFxFBFUkgfjRJng0uIdsgbfpAVCZK41KK/yX+uPEFHF7sQmbjxuNeGL?=
 =?us-ascii?Q?2WC03GCDXzaaR5Maf536ZmcT+XqFIC74vh9lP3FEyKNrIz7WBgH+bVZDE14G?=
 =?us-ascii?Q?7IL3jvoNL/2SwJ3pwuJ5peQBDWrtgatiSAJn4KV+jFK7sjGLngu67W20OA8j?=
 =?us-ascii?Q?d4c5U+G7y8n80wp3ocJdOmo0J+LrC+gunnNEvglh825DRVJs7dwk1aYukjUD?=
 =?us-ascii?Q?eyTKxsiwgbunJkYt6LPL54uLu0hV/aFF0Ux1/BlwXr4sFK9fLh3EuYMzEEZC?=
 =?us-ascii?Q?mTlYMlNKN9hQhtG4gQoME2hfaPDPtgFI8B2DFWn+9NZKT1qnAidl/hpMJVEw?=
 =?us-ascii?Q?1pN8LuLynIrXjkqYkrDaVuj4Wl4yW5bvmfD7Pea3vVK6EqgHeUhalvuvh6ij?=
 =?us-ascii?Q?jsTYd612fGT+Jl0wV5iIPQKzA5qjZ5na0YZfVO+Xcjmp+y4Ni1gceE9TrFiB?=
 =?us-ascii?Q?GE4fI5uGT78HWR4SzUARDhygFTk9lcoAFhMRRy/L8AeQK5F4rrLFiE5/UH2c?=
 =?us-ascii?Q?oh7Hi3WbkG/cV3zEhb/xnITyRxfy0y2eK3PwYdmJacaBmZG4aIMSRYZDWmff?=
 =?us-ascii?Q?LW5DTPntuZ4VUJSkvNpPeQExE4FAvxOtXbXGtm8AAUawbNBJnFAclchcG2y6?=
 =?us-ascii?Q?lXoW/al7XZu6l6DImoURJP0vjgLIB6DuTKUzXccWrGhMjVUvxf2zw/xguizN?=
 =?us-ascii?Q?FloY40mOshFaqNtXuC9RC4pgan89zloZ9n4v9xfUJZekadi8+hWWTkzmsMnm?=
 =?us-ascii?Q?+/o41uBIaAJl0BZzq7rqMdy4DWx97fuyJBQR85esWCg0qqB1Q70TWt2+AtH/?=
 =?us-ascii?Q?oGJDGRX8XQB0bc8yEcwI//DQr9dIx44PCdBFsXkUdzFC1pNAX8DNHEYzRlos?=
 =?us-ascii?Q?sjS9G7acQ1NlvvTAHi4s3kpzJC6XimwrGPjrLx13/CPUhn8GAyfTC6zVsaK3?=
 =?us-ascii?Q?kaz+lyMvw1qU1nFtC/Sm2XhrT1jgaVcKUIzxJJ6VdbphmNwo5aMp+hAI9Gdt?=
 =?us-ascii?Q?roAiHS6r8Z9DJJXRnz6JJrHLq4+8GRfItLOPnfKgjwxL9ZSm7Se6i5rQeSoH?=
 =?us-ascii?Q?pnkzvKofnxQCbQFUalIokkEmjeuflPWMTSE9fiQbv96ln6D4Z+lrCqfihRgK?=
 =?us-ascii?Q?v2/ot1WTwPOyfXBoKfhKMejRVIuH5yIUfJlujdiROMkWb5oIOLv5rJc43iNN?=
 =?us-ascii?Q?xEbIp8AbLZmFHun/20aX9mWatNKt5IG4kTIE04RemcRVfIPu9ImXsyc3PDMK?=
 =?us-ascii?Q?vdmgkR5C4/fqm+ktOZLqlMmweqDospRCzL2ZjXltI32xP+PD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4610.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a13927-33b4-45c6-c0ed-08df1f95e4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 08:27:55.8299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0j+uircfQR11RZTaadz4mKxw/VaTpubSxtDnqTHC4fHfgLAC9l12qvTsjGc4qdeo36gx/IM646zVyNqH/XLdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3898
Received-SPF: pass client-ip=2a01:111:f403:c100::f;
 envelope-from=rdondi@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Hi,
Just a gentle reminder on this patch.=20
Please let me know if you have any feedback or if you need any changes.

Thanks,
Ratan La Dondi

-----Original Message-----
From: Ratan Lal Dondi <rdondi@axiado.com>=20
Sent: 16 September 2026 10:22
To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org; jasowangio@gmail.com; Ku=
an-Jui Chiu <kchiu@axiado.com>; Ratan Lal Dondi <rdondi@axiado.com>
Subject: [PATCH 0/2] Add Axiado HCP network device model

This patchset introduces Axiado HCP network model for SoC AX3000

The HCP (Header and Crypto Processing) block is the substantial part of the=
 series. It is the SoC's network complex, built around an Inside Secure Saf=
eXcel EIP-197 packet engine that acts as bus master for all packet I/O over=
 four command/result descriptor ring pairs. Five MACs are demultiplexed by =
an "application ID" tag carried in the EIP-96 input and output tokens. Only=
 the packet datapath is modelled; the
EIP-197 cryptographic transforms are treated as pass-through, which is what=
 the guest asks for when the block is used as a network interface.

Refer Axiado website for more product information https://axiado.com/produc=
ts/

Testing
-------
 The user-mode network backend is required, so configure with libslirp  ena=
bled (it is auto-detected, and silently absent otherwise):

  ./configure --target-list=3Daarch64-softmmu -Dslirp=3Denabled

  qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=3Du-boot.bin,addr=3D0x3C000000,cpu-num=3D0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=3Dsd,file=3Dobmc-phosphor-image-evk-axiado-qemu.wic,format=3D=
raw \
    -netdev user,id=3Dnet4,hostfwd=3Dtcp::2222-:22 \
    -global axiado-hcp.netdev4=3Dnet4 \


In the guest, bring the interface up with DHCP:

  udhcpc -i eth0

Then from the host:

  ssh -p 2222 root@127.0.0.1

With the unmodified vendor Linux driver, the guest:

  - probes the HCP and brings eth0 up
  - obtains an address over DHCP from the SLIRP backend
  - resolves ARP and answers ping
  - sustains an SSH session and completes an SCP transfer

Not modelled
------------

  - EIP-197 cryptographic transforms. Descriptors are pass-through.
  - PCS/SerDes behaviour. The guest configures these registers and never
    reads them back, so writes are accepted and discarded; the link is
    always reported up.

Ratan Lal Dondi (2):
  hw/net: Add Axiado HCP network device model
  hw/arm: Wire up the HCP network complex in the AX3000 SoC

 hw/arm/Kconfig              |    1 +
 hw/arm/ax3000-soc.c         |   23 +
 hw/net/Kconfig              |    3 +
 hw/net/axiado_hcp.c         | 1372 +++++++++++++++++++++++++++++++++++
 hw/net/meson.build          |    2 +
 hw/net/trace-events         |    6 +
 include/hw/arm/ax3000-soc.h |   14 +
 include/hw/net/axiado_hcp.h |  172 +++++
 8 files changed, 1593 insertions(+)
 create mode 100644 hw/net/axiado_hcp.c
 create mode 100644 include/hw/net/axiado_hcp.h

--
2.34.1


