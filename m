Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E404C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtW-00066X-02; Wed, 18 Jun 2025 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtU-00065d-5f; Wed, 18 Jun 2025 08:27:56 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtP-0005VS-VC; Wed, 18 Jun 2025 08:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj/iEia9S0gaCHtqQZFPSkJPVZIvwatRy3M7UrTvRJuiFenwde+i1LQ5RZEm9h7p8zDpz72kAHFPKOS6F0JuSIMvKg0rXaDYKCYWa9ZuniaR8F5tqM3i7+eCBPo2mYyA6y4CCjb9rZmQQ62dMrSVC7sh4uNuKRX8/axr0cyD58GW3TsAmHaFs3wwVBqVnmTHbaaty4LQxHr31A/x9Uh5BK5ggjYc2W9oeaV2wz5JoT/vtzQjfXpcaEiD3p6pHwUs/pdsReww1Xv3TmuvyXwRrc27k3CMots4BHfoghkk9vGapU5kzlg3M/5UZttfNdF6LzlDRz1gqPowueFNbmhdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9YEd8Fg14yHdm1KW4uAaXLxqokJptnQbODUa7yAP5E=;
 b=DCyoXKFhHot3s+Gv8/sAIbxQ4zFdaOinAu0GukXi6TYgVeOwZdlUv/8jJtclv3G03bBzIApCp652wST9EGvj0pVLGpe9FxHsPsuO0knW2xNIwlHIXGdtnIx9dE3LdjzNAsiHb/OuNWt/maAy4hkK/rZJ+YviosSmzBCVhu/8I/gnqPnBi8K/rCM6LCQJs3KyaOgBmNIuMsp+Lw9cfQfFi+FrJqjr6Hgubt0Z49OKoWzW+JUzYSQtDfkfK12kcbGn2BYzgGlP3eJiexIhuM4eNP3h+NLHGZNvQo8Tyt/eRBbuu1hL5sn+eZOtQEtAYRJTewd/4gC3OkOjpUC5Cfld/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9YEd8Fg14yHdm1KW4uAaXLxqokJptnQbODUa7yAP5E=;
 b=Bw94HXRxnrUwoerp00yW1+qVM8FDAAlHCAaw1E/OWT/uYzOqxOjrKdTB/Y3MdsqwIbTqSPd5pMmFZJF4VkhRk3yz4mKEMEZUCVSyaJDdZZJJci76rKcx1n6M9b/mudt3iFggmVWtcDNK6qSnqTJixuqJ4OdyR2t/cri56kF4LIPXKjdnJyAtgmAfwP3PS/ByQz/EoUumIof6qmJQQPDL5zsOpRboSO8EcvYdQ4Sonm5z4YWVtU0+de6vRh1sJekjK1uQ2qKW+wrLDd04FeQTfKg/v5tSkmzIf7CNdZzlUSvhyf9gEx5Hcafp1w0N1sYXFmsL/+OMLz5UaKcmVhCC2g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB3834.eurprd09.prod.outlook.com (2603:10a6:10:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 12:27:46 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:46 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 0/10] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v3 0/10] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb4ExlRBn1g1tLaE6jy7hhVr5ewQ==
Date: Wed, 18 Jun 2025 12:27:46 +0000
Message-ID: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB3834:EE_
x-ms-office365-filtering-correlation-id: 2ce1633d-0109-431a-faf4-08ddae63881d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J1p6AWcDNZ55p7eV6Edmqsq3a6PK8zUwg5QrLtKmug8742zn8NEjEvOL+a?=
 =?iso-8859-1?Q?JQ1J65yOHAgyM9wqgKwUfBNzZLMaHYkBp5b9SQfno/eQWkHPpR6pNlmsKN?=
 =?iso-8859-1?Q?RA1n9KO4GrfVvD95PpAgp1co/JUm2SaXSbiEUY2oRkj0qLe0fw4dKJHavs?=
 =?iso-8859-1?Q?Ho+F3T/OG/w8kkShLGrfkDuSTegec9Q0NC68dNBgsdtHNZC7k+ZDuO/KJS?=
 =?iso-8859-1?Q?z8PcOQV8k0fV9x29Jh1yGFpl+Qd/aTtt5cEQhMJwkGo2S+U02ZnqqvsF/M?=
 =?iso-8859-1?Q?il/Nc2CBkQkk3azCu4WlcH5D6cO0nXzqsV0Jh71n0RdLbyvVMHGovQHOtj?=
 =?iso-8859-1?Q?s9vZZG8EzFgyuyqi/MrngIEhuwqNjmTba5pce+eDzV+Aq6a74fqTLeGdpv?=
 =?iso-8859-1?Q?727+6gKhdNOg6CrwMZJlOS/iV7IQByhgShtaJAOW0p47XyrTJr5m9Rvcd+?=
 =?iso-8859-1?Q?0reD8hfShJ5XVTwutBp6O3pEiBqYUtkUMMOc6lj7DzDamepjyRGnt8leTH?=
 =?iso-8859-1?Q?0q9E/3JNznX+25L75Kue6q2AJsCLyXLXecCTbWm4ZGM6lUEVXxtSv15D1+?=
 =?iso-8859-1?Q?VCbvXF2ke8B1QPPDd9womn4R7fpOk+OuOZG1CYz2lS1yGjHtIvcq/rlRR8?=
 =?iso-8859-1?Q?7Gj12LWbRZVtFiOXR6HUiLweDDukaF2JYxwGlf+NB1bpiTzG0g3pN1HKDr?=
 =?iso-8859-1?Q?m8NYSa4ZZUVe+Zh/U5szLCm9PCO7powN7EAqOqEtwpEnhmcNYQ11y71OX5?=
 =?iso-8859-1?Q?Nb/0K5LlZBGkJlFYROkynZnOMYRXQLaToT5C4Hrjni86bqAzQaxzeEW8Xu?=
 =?iso-8859-1?Q?LzhkHMUssRRCma+1WwDGhhbmECeSI/p+GPZJjzRNgzoSZH1w+/42FHNU12?=
 =?iso-8859-1?Q?m9zT2x4OE759Q5ycIsX+anfPua7h2FaNp07bfrTIElKJThL9JaiOIufK5/?=
 =?iso-8859-1?Q?yDHoDcNxwUcFEK97kk0XALmjydKA7Uf3LQZmb0AAC8iOVIXgJ3zhaih9aH?=
 =?iso-8859-1?Q?Z0hytI0zfyBf9SgmmGFNBt3S5Bvq/b+gzdL6BfY+I8L8hVPFankNV47GCU?=
 =?iso-8859-1?Q?tVJBrWrrC1NuMOjbTe4W5a/uH5RzYsf6o/02c1J2M2L6Jqv8tdfwVL11BY?=
 =?iso-8859-1?Q?7K7wfM4NGF3jIV91pQ9ruiXBMN4UJlyRHdndb1FSMF0ZPfKZMEdMwJ59Tw?=
 =?iso-8859-1?Q?0r5TS7VlKqMh6vm1dEW4gt+EUOXjM0ou9gOapzw90MtsT7kmVhw7qo4Dxp?=
 =?iso-8859-1?Q?sVxAHqnYYLPjic1oKG4sDjjUT8wk2xn5Jewk8YqXCCHlTym75SV02Kk/2X?=
 =?iso-8859-1?Q?HRfVgAz6A+eYVQZXmKBagHy7mVT+c4Y/okhK0zd+op8r5x1AOn4xJmkYmi?=
 =?iso-8859-1?Q?RyPgl2En1i6aJrojAXAjTR7JZ2apKo6yEEwO0IC1T/p1kIHqCg1WMtnEa8?=
 =?iso-8859-1?Q?IchVG9n7VZNO+EgaeCh6ZaHe/ImCwBK7EK8QjWo76pu3NDXpewwH5y2iPc?=
 =?iso-8859-1?Q?ZArwFgseWN4GGY9R3CAAm8eTaCPxS4FQ2jM5ykzxgBFw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XkEyajRpC/u6AJJ0EbQaQSvgBmgUFJr3g0WCszhmKMlyDvUcjWScGhsTl7?=
 =?iso-8859-1?Q?wrhZSTdZf8xGbBC7xdbGrSzU+5Sd2JZNsHp1RnZHleXNTSy736k+S4Z/Lk?=
 =?iso-8859-1?Q?vPib0MZYG4hbuwf4rcwjelseEnjsz8RT3yoiy1tGH5QakIOigbFc/7oiGH?=
 =?iso-8859-1?Q?0msWIsBic9JGjHgcES5/Zka8Z8KV9qaJDV0rVwLvMlgt1PBT21/bwmzjGI?=
 =?iso-8859-1?Q?YWBjsQkTCtTH0GrecwZPf36kcJyCafjJfiCpDUWlYOoGqSKZOHhngu9+jK?=
 =?iso-8859-1?Q?NbZghZUx5NUP9PphO43KYIduL+/D0dX1KVvTXfA9TVlhtJkBk83rbCnhFM?=
 =?iso-8859-1?Q?MHtTFeitThRpr4cfHnUu6xTkL1r6RCcqsoSyggS3AXHdIcxR4MrEkFWCCF?=
 =?iso-8859-1?Q?MeWvG3367fSBD6Ei+GFJ1k+dEbsE3VABND6ljk/CQTzSEHCBl89C+8Ti6/?=
 =?iso-8859-1?Q?hTKfkWlmcdxUM6BraiL/Rlp6OmMI7z0LfPHW7y+q5xSt9p+VZyKNxIYv9I?=
 =?iso-8859-1?Q?iTYPAuK37Sjrtq36w9hZ6nkrsbB7GHXgi1fVIeYLYCcsPL83zm67Ix2/9t?=
 =?iso-8859-1?Q?82a5O06o+0aerShyaCC4P75o1fp68rSanwDIpqsIIoh6afcl/w8IqXUCjT?=
 =?iso-8859-1?Q?hc+paJO5ANuzkhFVRISH9CiVo8LF0+YIgVKfDyBPOMLd4ckQba4S5MZy4l?=
 =?iso-8859-1?Q?8wmBl2lOtOZoJZVxYwSKHYavdpIluUp22IEzE6qx8ivMbUU2BHr1vqwAE1?=
 =?iso-8859-1?Q?J7gdfJLIReP1h7uiX1C65gkfbdroXqjH6vKwf4OHUQ5N9NVcc92pOqlKwK?=
 =?iso-8859-1?Q?RaoIWTwuiFQHwbBWcBIOHsVgNa0ylboYlgLp5QyxcCYAwNUJ4RDfb0wUFH?=
 =?iso-8859-1?Q?mXxQqhQV/QZ46nMt9JiLdWPIQrMBuhWlre/L+dPuh/VxXXzVuUdt7KEP70?=
 =?iso-8859-1?Q?HoQs3k8k+4+eZg2QqWWXHm1v3dfjaCc99k+W5MIRHcJLS+1AvS/EBGt/Lr?=
 =?iso-8859-1?Q?WwCNY71M5qFbIsdkICa1pnc+sTcdG8IV8xOT7wXtqh53Ta/Tt8lPdTxhBI?=
 =?iso-8859-1?Q?X3SvHQUhCd/jjCsDHMj7uJBWSwtahJbeRZcBSgBMF7sw3XxttJmQVxZ1+/?=
 =?iso-8859-1?Q?hYkcP9RF7ubrcgjLiToeXSvk25LpLcpqYPb8ol9Re6yTzXfi42Hi3yVz6c?=
 =?iso-8859-1?Q?zsU2xICfi1dXujsSKNC6HXTkKivQYKyRnQXCLNBNv6JuTvkjgWrP146Gy+?=
 =?iso-8859-1?Q?necbVT0htPECDYJ73njzXdRndqYaTL585Rx3lDguglrF4phohrSdSCzadZ?=
 =?iso-8859-1?Q?T+6ybLs3Uq4k3MaYicfsdCmHSY3v2oqTC6mbOWd/3CrI1gZYjMb4zBoIeS?=
 =?iso-8859-1?Q?hNzh+m/NORxOKZ9sZpAza8eveBYebuNcFjRV7miAz+s5VTcNlw+1jAS4ax?=
 =?iso-8859-1?Q?NfJuoXa2WKzsSw4gCLDlZxlw/R+ccPi4NFpxgQ8TkRhfAwb0sQJh9qPai9?=
 =?iso-8859-1?Q?Tg7nFRV7jYBkL3SiOg/H/BK1Kyyko+Yh64FAIuHiXTchUDpu/DoD8crxxh?=
 =?iso-8859-1?Q?SqI0Gwt5kybxDDXaHxgv817Yr5svnRlIJWDQwoE0MfT+DB2bX3nahFFJab?=
 =?iso-8859-1?Q?rKyy0WppG1DLG2maRdu7N+QS38Aif7URKMKLItB3Vt0x3ScDfk3QiAREyW?=
 =?iso-8859-1?Q?JxhQfe4ubSOS6zTCSdw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce1633d-0109-431a-faf4-08ddae63881d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:46.4831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVV32/eMci5P+dvA3J9LFg2k3d+hZfDAvf6DEGS+/cbMXmaPDJiXV7ET/ZPnUapg8N8sLP8D9aSB3YXPx+9OCtTrcoOMyftObLe7a9B+Ijo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3834
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Several things implemented in v3:
  - Addressing review comments
    - Added documentation
    - Referenced MIPS Specification
    - Split e1000e and pci changes into separate patches
  - Rebase on top of master branch

Djordje Todorovic (10):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  configs/devices: Add MIPS Boston-aia board model to RISC-V
  hw/pci: Allow explicit function numbers in pci
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  25 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  27 +-
 hw/intc/riscv_aplic.c                       |  10 +-
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 206 +++++++++
 hw/misc/riscv_cpc.c                         | 225 +++++++++
 hw/pci/pci.c                                |  15 +-
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
 hw/riscv/cps.c                              | 187 ++++++++
 hw/riscv/meson.build                        |   1 +
 include/hw/misc/riscv_cmgcr.h               |  77 +++
 include/hw/misc/riscv_cpc.h                 |  69 +++
 include/hw/riscv/cps.h                      |  75 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  26 ++
 target/riscv/cpu.h                          |  16 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 140 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 219 +++++++++
 target/riscv/translate.c                    |  11 +
 target/riscv/xmips.decode                   |  35 ++
 27 files changed, 1867 insertions(+), 11 deletions(-)
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

--=20
2.34.1

