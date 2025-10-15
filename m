Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48C0CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909q-0007q9-Pq; Wed, 15 Oct 2025 07:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909o-0007il-SD; Wed, 15 Oct 2025 07:59:04 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909a-0007oZ-EE; Wed, 15 Oct 2025 07:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2sHWoFGLSZaZBMzxaX1u52wKj+MhY2Z1aamcikMvZYn0gLJnsFF6LU558GvGV1IP7NoEJrr1IjPnuA246AWi6kse/TMiuAARy1G7ISmNKkY9oif6dJfiDH01DIduVanXzHmOQh+o3/vx7tImdw7iZ5wHPx01g7INfowxqzUUFsGrbyLbLsAauvdPf/dENS0J3kvf0b5ejM5z5jaLGZAeG7TP1DXg6ITK31Y4XiL9xqmn8O0JMGqWVaoWsFmOcmEQP2cVi7EDVTczeEQN/XyP5T9V0nQxMpUOQc36+g5Xh3n2T4sUCP2IArUpX2qmhNfcq5PLpbO/IpgxcPRIMesVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqy2y9+yllw6h8CXsAC2vg8T+LN8ba4oNrGOqwKDCwA=;
 b=KgjnLkrjGMoGpPlMtX4gc8gqvYMNHK2c0i/vpndwNhbuexOe8j8Q0I3A4QtVVyUPGH/JswE11+Dwv0OpgWX5zHwVulMRXDOo4qJHmJc1VVEoP8oojm6W0a34nPI0D9olG1+LJXFOb1C7+g1SV2nQ2bm+0R29bjDtNbkrSmqk/Ac++Qo4EvS+Kd8Zuf77S8gFTl4PBKMrntqULdHwJm5aJDZnHpZQBp6KRkf1bpvAo6vFPG4ujzYoEM/svVSfeaFFcZoLTepq9bG2SMH09cYugk9WwyPylG1m97MliZSmR1rbVMWxG3AhxS+sc5NZqEqE/HjGaaTjD8LX98idacAegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqy2y9+yllw6h8CXsAC2vg8T+LN8ba4oNrGOqwKDCwA=;
 b=vHC+rlxoToF9E6tjDZWBFRSVgxTMpl3FbmyJWjFNZyCYrHKrDFe5kgDdmeo6MCjuzOCJeqAyYySYFB3LoEH2forabBUNZUGMOnTK9XJfu84PKemnMNc9VeNIypbG3jDgASEV+8eeRNu5VV1Lh3uh8qsWxSAiieGEv9mJ2hgFwLbwdCKiH+1/aQ2kj3uSmOMXXn4WcYNHAue91GRmhf3yMmICTcmJVqpwCuGrDf1JeMixfQ5p94ZfWbqxc9dW5n4UPoD/xg8nEirFItJ7A1F6aUQLinvKMLUzpzwek9zBWPE4GSDw9w8bobRlFrcSPDcasap/L6RFC83km9eowXIdDA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:14 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v11 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v11 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcPcr8hwH4IhPujkuT4aypYa00yQ==
Date: Wed, 15 Oct 2025 11:58:14 +0000
Message-ID: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 673077c4-7713-43eb-7892-08de0be21f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lY4w9m0SnrOt4u3uVg9EXJTZqBvqjWXJolmSQeWOi9r+zITB5XWwFuc+dr?=
 =?iso-8859-1?Q?dr5X9mo2gJjqsYjTHPsfHKSzDj7aYkos9XLuT1RooS61Zzsgia7qrx3zdM?=
 =?iso-8859-1?Q?lZW9wbvZVKDjHbVTrFhhI2hTIm3e4nQyYT+gjP10+9pcOeeyLv6/fwI1yf?=
 =?iso-8859-1?Q?MYAj6lQb1O2zhQ/ocKO7lMS42ylnr1xN66dupYA8jFn4oxcTPdgSdVhwwK?=
 =?iso-8859-1?Q?blRkn7JSuTkH1G5xGZEF1K0wBEpgNPYaqbru+Ima4D1yrQIR0udIDnmZ+J?=
 =?iso-8859-1?Q?B//25zLZjGPTJR0/Xigau32b39DEpg0HQfbrfH2UzJA8WtICn++iUpXK2j?=
 =?iso-8859-1?Q?6dye6jonXhYhhPgQlKXa3pBhnGyUG3j/+mFw6vHxyb8NZLX7XoJx5Zylda?=
 =?iso-8859-1?Q?Le0511DWabhevRIayhY/IXrZGMo5kyznHCjsjBWBnmnBr/lGhGgbV6lwdS?=
 =?iso-8859-1?Q?9Xt/2RQD90pWGieTD4UBhj291cswQffPYks5IaBvIK9Amq49qOgc+5Zm9X?=
 =?iso-8859-1?Q?p3himufADjMziJJ/eXBC3TKJ5AVuWDt5930FWtbhuXtabVS/uARp0CrQAt?=
 =?iso-8859-1?Q?mqCOQ0kzp8UuKe78gtrXlpb0/DdUtuc6Wg/YTjL4h62Hi2cnWvmh2NbQkM?=
 =?iso-8859-1?Q?I4Ad0PcCVBrHckYcARmTkrxtOAXG7saGI+RzGZB2MGh3ShSqACnyOFIebU?=
 =?iso-8859-1?Q?ooK9xUyaKpe9+EjXuUUsF5/i6dLV4kAo9JcpgD59dHsyKNZiEM3OvrgAnw?=
 =?iso-8859-1?Q?Uo4Mtk71ZNayLmTtvOG62JGqsLpO0KwOLCK6A1JhGTOGR3G1rAIE2eLvCM?=
 =?iso-8859-1?Q?7iCW8xS7T8KYxj2bWxSGC758nb2qp+RVcqgqag1nBmDB6PFInkyCAIfLel?=
 =?iso-8859-1?Q?cu9Jgs8bxNI2YJYOG4HO/1EMtnDIlyMaRspGfhp95+XnH8EzBDw3TrUCVH?=
 =?iso-8859-1?Q?QygDee3IpBK1jdDF1nn+ezp1c8BXAMyBdyoxOD0bkgb/ALbHajR3EjUEBj?=
 =?iso-8859-1?Q?TY+B1OXnV606L7G8uryrulAJ9PB6ohI7mn32az1fQCNATvXndOOoLykg3W?=
 =?iso-8859-1?Q?xyW6xS610HgAMi+cXd6PYiiYXCXmz6Xe2vwq8gYWVPSgndAj84nGG1kZ5c?=
 =?iso-8859-1?Q?MIcq7ed4Z84QnLEyJ57FOLvn5429+7FAD5fhu5BK54QMaH1hKw0vVA1iSI?=
 =?iso-8859-1?Q?16TvOTyIP2Bh+Q9icgibLFfvyIUp1PJ5PF/aFcysjnUSj4ymBPCT4bKZJ1?=
 =?iso-8859-1?Q?8WmWm+MibbDgrh9ZrEf9YdGxsNjOL3vpjEOxP0MmYQw6Iof7AsmhX1BkRH?=
 =?iso-8859-1?Q?IVhR6Bxz6mr8kQzphn0F81C5IYAOFNsxYp6t/L3snzNYewRU8UJq5KX7ZJ?=
 =?iso-8859-1?Q?XgiQ34dWLp8M6N9QLXgkc2AIJqATP1krp8NiCxdkUQbgtR6lfyTI+lmUpY?=
 =?iso-8859-1?Q?+asEqevSaDNjm1U1CinF1grg/ft6seuZsd3L6B05PgUM1u9AmAX5mfVG8f?=
 =?iso-8859-1?Q?BVTxAMeVW/4TP2fXCu0dMjWtl5kpglkA0P1bLDW6uGmCsPQDhQwLJw6VM2?=
 =?iso-8859-1?Q?LGsYwpOdqcoOs521zf6anIE+sTXc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aI/anpzywuSVVysXJTluuJJr6o7l53xmqPCSCPLMdCCQ5OuELo4/SO5hgi?=
 =?iso-8859-1?Q?nSz+7NytKlL71agItfW1oVkwcojnK9CBYTwC0h8/1vTUTlE8OgTv5jtSHA?=
 =?iso-8859-1?Q?53ckmFG5P2lmzquTp5yaB97Es2FZgdB5f5nfzRXJWY6gMCNme/vdUtsHn8?=
 =?iso-8859-1?Q?ES9AHFavE6hZpIhEoQtfOwKMffAa9fSBRIBgROc/3qcoWZPCizBOm+W2Ov?=
 =?iso-8859-1?Q?aIhSGC6lMMn3cdELSHk13m9xssyrFVDzUa3s1Q4znpb43iJGOCrZrRMFIO?=
 =?iso-8859-1?Q?9KOc6TVZUKQ/BzzqRiNXsGMwEV5YBsxU8oZu5oqzBefCmc7P4iKAFKG8hE?=
 =?iso-8859-1?Q?lTzMUoqm3TIsJ6R+jtWq6o6mJm+SyyAA3hLLAkR+Cb/PQk8BqXSNJrJKTZ?=
 =?iso-8859-1?Q?msXRcbUBHePcolKFhhx6aNf/DVfc8yj+2vfO4OqdbZjDu58HQq9nJZOJUW?=
 =?iso-8859-1?Q?Hfl1wPEkeaY/1SFNCYgECX48O1HsAW2ZKGUueV467Ih8dmLJBbTFONtXET?=
 =?iso-8859-1?Q?p/sJMT8u3dd8/AJcUXj5Rw4peF96Fe+urI6/sWoaCmDJpH2ln5uZwmAh0S?=
 =?iso-8859-1?Q?Mbk0qmg81utxeppVxFKXWJeXuE6veMjA1Sl3dkVC0i9qD+3cIqYl1qRumk?=
 =?iso-8859-1?Q?ThxBHeqNeqtORQ9j0gzv5bCK+KvVo0P9Po1Z9j0xU7Dx8flB7gMJh+Ny4f?=
 =?iso-8859-1?Q?XDU2T6ndbO53eiVGitPqQGF4BJ/s8/ZathoQPaFoCpMy+n2GvOPWRzOLpA?=
 =?iso-8859-1?Q?qkSZ7zD5vq93foB2E/c32o+2HkxCvtvgygdMcZGRL4bXUDhjgnYopwkIqv?=
 =?iso-8859-1?Q?5jSe5vD+Z1LYME4y/eqQuTGLSTikGiMGnqo8a17I0KSfpdMK3lXyf+hq8V?=
 =?iso-8859-1?Q?QStL7XnMUT5+2FZ/D01tSgiEYj01JDiro2jIU5+lH/DghaWxqqI0scDUhg?=
 =?iso-8859-1?Q?tPOYqz23TWq9T9/8cNiX/kzVfHO+pEJo+96+Ll1cdx7gBVVbN/tdXENb2m?=
 =?iso-8859-1?Q?eyO8ZMBTXP67DO5J0z5ehT0Ri4PnXL9/tvOWaJptlPD3dsh8U/Z7IY3I95?=
 =?iso-8859-1?Q?qkPdcp0HjKAnwceVr38EIh1IhfKKLYzh/4k/n+SzsKdzi1ZDQunUIoWqIj?=
 =?iso-8859-1?Q?Vedl0RSAhj8qyKggac4TP7Jzb8YqY0WbA5jXxt8xNKUW8Q+SPOedHcQMJJ?=
 =?iso-8859-1?Q?rNF0uX6KmhESZ6pU1Fzel+c0w8xmPxtIQzUqegyIrevY3EurZia67syN8B?=
 =?iso-8859-1?Q?0IL0UyAkuIvMeVWOY/eEeOh3y7jEyLTUyWwD54HiOaALx2pfTp3jBT/wsC?=
 =?iso-8859-1?Q?WR4DvVrN0+Cb+g+yjgDXKy8whgbA4+yODYbOBxSyJzTr8uA/iQznwuj9cF?=
 =?iso-8859-1?Q?kBDsKAJkmJ60JjpzMPrieYpvQ1HHIaWjcEEPof/bIZET0SnQnsO2l1TLy2?=
 =?iso-8859-1?Q?aRvUWpnDwPA6/LwTA2wtDu+ey9WxCNdsJmaUMtEuNfKxMoNIxq/6tGkwDn?=
 =?iso-8859-1?Q?FkLljCaPPuvBldLVajobxZTOHo9WXkmwSRLT0zNOzblwzeopdSIVvxzrYb?=
 =?iso-8859-1?Q?8G4GgzotrtYL6PIqobAR1AXnQEzTA9AmXBask45m/K6xqb9GDhAm5SNs5A?=
 =?iso-8859-1?Q?ieqyv+mraMwmjcVKdv3/ZMb/WS6sjXNMQ7Ynx9/TzZmA8k4tlItBmx+RoJ?=
 =?iso-8859-1?Q?6/ipAv2CnUnpA/KFzS8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673077c4-7713-43eb-7892-08de0be21f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:14.6711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /V9GUhytdcgrMfS8C0vyYRZQZkCyN6Yp3DiP0+CQCZvvIbMV0gbyit6G+Or2lMhrM7C8/4kFi3WpVEO4sejF5ENr5jy83pxWzy4KZWsFg2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

In this version of patchset I have addressed some minor cosmentic
comments.
All patches are now marked with reviewed-by/acked-by.

Djordje Todorovic (13):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak   |   1 +
 docs/system/riscv/mips.rst                    |  20 +
 docs/system/target-riscv.rst                  |   1 +
 hw/intc/riscv_aclint.c                        |  18 +-
 hw/intc/riscv_aplic.c                         |  13 +-
 hw/misc/Kconfig                               |  17 +
 hw/misc/meson.build                           |   3 +
 hw/misc/riscv_cmgcr.c                         | 248 +++++++++
 hw/misc/riscv_cpc.c                           | 265 ++++++++++
 hw/riscv/Kconfig                              |   6 +
 hw/riscv/boston-aia.c                         | 476 ++++++++++++++++++
 hw/riscv/cps.c                                | 196 ++++++++
 hw/riscv/meson.build                          |   3 +
 include/hw/misc/riscv_cmgcr.h                 |  50 ++
 include/hw/misc/riscv_cpc.h                   |  64 +++
 include/hw/riscv/cps.h                        |  66 +++
 target/riscv/cpu-qom.h                        |   1 +
 target/riscv/cpu.c                            |  44 ++
 target/riscv/cpu.h                            |   7 +
 target/riscv/cpu_cfg.h                        |   5 +
 target/riscv/cpu_cfg_fields.h.inc             |   3 +
 target/riscv/cpu_vendorid.h                   |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc     | 136 +++++
 target/riscv/meson.build                      |   2 +
 target/riscv/mips_csr.c                       | 217 ++++++++
 target/riscv/translate.c                      |   3 +
 target/riscv/xmips.decode                     |  35 ++
 tests/functional/riscv64/meson.build          |   2 +
 .../functional/riscv64/test_riscv64_boston.py | 124 +++++
 29 files changed, 2022 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

--=20
2.34.1

