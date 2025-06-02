Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7900BC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4y7-00080C-47; Mon, 02 Jun 2025 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y4-0007zW-22; Mon, 02 Jun 2025 09:12:44 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y1-00028N-LR; Mon, 02 Jun 2025 09:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvA68FZo3KyNSG7Lgn2doHz5ncRbOI8Amd3gYe2WYBhnIalE2vbjZcXLt6vS49lP6nViTtHvgNNwARVxmf4MST5HNduHVIfWX7Mql0STgqB9N5qCdAY3hoK/S7FtpuUi0sR6Wip+l7H7zsR9tXD0ljWLuxtP02TckecEo4OhZItrRp4FFKfzmj+HyPo+HZLC3XO2gyjwi5w0iIjcorAqNDAoAdz+dU7eiaebejOcfEAP7SRbq296UdXw32urs/Oohv4uN5irP77bViBiYfsX6xblIe0c+ajFKXTUrunhopk/lBwnE9M5e1mLi9Y0kr36FyjRZJ+uyWxIwBL+BNiARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WH6GsvJwAaUe9ZtMSYS7mMyTZGVbltw0Cw1nIZf1J4=;
 b=lof9jdGlQYttrQROooVRYxF3YTYlNh6B5JFVjeolXE/0T0E5fKVZQQAJyQ6N9qBjWuPMw3ctSpMhu9z/s0qBntrSkrMPi3nN4D9wTLBUELnx1IWmV7rikA1L2+XOasFesJDUOWij32Ouk0PsLTiyFfi+Wek732FSS40piF2qebR7420K2AW2iNihJ5hy2yb1ZzAekyxkfYkqzynVqq+sjdBT2LvRamy8s5BA2Fon+dKmhwGS/by/uQN0cWKdhx833EpPDTzeugNKcMeQeWN69KyhA2zOyfChis+cuXoR5BmsWvUtF+DW88eEpmfEwB2+HLYk3QLzUE3IWYQhbzPCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WH6GsvJwAaUe9ZtMSYS7mMyTZGVbltw0Cw1nIZf1J4=;
 b=jaMrwhOSRG8NA33Fl4phj618SON6zZFEIdowrcH1B9exF+dz4pte/1T+4r4yGDis4KRBgmZJASM2PMuBymNY0pFIsBv6demFWE65U4CgYQTqMwbJPhtTW//PTOhdjk9BR0oPWDsVTxrLYgz90rwy2gULVxCH73I5JuiywbEqshi3Ob57GcbverId64bnlb9v23fsIC49tjpWl5/N6cahpquEj48NxmLSsSh35lOV/B7zD1swLdGqAQK7BblQxftQbX26MWS+9aOyc5gPnC/sxkdRcZgBQfg/sE0naIHbUB6MIk1IVX2NvomMvX5//8RrVQfa7CweC5VbTQgFlutyfA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:34 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:34 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v2 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb08AAl5hcaytutEa6PQm7OHafYQ==
Date: Mon, 2 Jun 2025 13:12:33 +0000
Message-ID: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: 25d52c21-b504-4a24-4e23-08dda1d72388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pBn4SCef0C4kQogENtarD4qt6I5q64JIIO5wTH0uE6beo5RpJ77+M878Pr?=
 =?iso-8859-1?Q?cacmQR/yx+cyCN3nWPh3Ay1SjCYJeCWN2e83HopjrVPWa0iQVXwtLv2vyK?=
 =?iso-8859-1?Q?njgYSAcNF8x+Z8q/aPeRtP9hVyBQ5tHMgz4HB5I6ugENeafICMzWsIjMhm?=
 =?iso-8859-1?Q?SwHlsM/iUxmCUoBXbj3FCisKlX1h0oPDwJHHaS2GvbFuGk+LKMZgsTJSkX?=
 =?iso-8859-1?Q?jKG4MElKsTfJc9wQMADl9iOR5o46IpYFSmqDcnWhM3W8Py5u7h4YeMHzbM?=
 =?iso-8859-1?Q?mA8g/XSxJjR7AluFMhBt+Frc2+rCkda15aoYton+hcfURccaXM4DB6tye3?=
 =?iso-8859-1?Q?h0ub2PxrUJyiCMf8M2+BHKLSTb0I92mCqcICbQkKIooiJ0Uch2vfTyuErg?=
 =?iso-8859-1?Q?Y0xZAt/QWG2F5DG1D4zcxg96kW7AXInYzOoq+LuHuF+RcrDiGgnpEthnfE?=
 =?iso-8859-1?Q?zxxYRB05vLrnBGdVuPrgRgOgHYxsNe1uqABb2/izrxNGOGnDN2mzM8rQO0?=
 =?iso-8859-1?Q?cPsMue8USk8qOk6kDcOWtWU8DF4+jobMacMYrKLTIPIf6CuxqYsPjU3xk5?=
 =?iso-8859-1?Q?hib2HliKnhu9MNjYYFOvZmtMvJCjWDhKClq7gL2X1sg9RXx7qhBkP3A7IB?=
 =?iso-8859-1?Q?ZgUiwUGCxTWKQMbF0QhR3M8DZGR9sYYBe8bvXii0Vo1+2UDqPDwXCIVDLt?=
 =?iso-8859-1?Q?XiqwoMzkZuSWeF8ZXiNlCj9Tq0Zaw1VzE0c2V+EZL6fxVbkvrDhoBI6lEK?=
 =?iso-8859-1?Q?6plDDVb1yy8QbLLrLYOJkSOSGDYb/LyQcTmZoWHdrX5a7blCc/s6I0OT3a?=
 =?iso-8859-1?Q?tcvKjhHVboo3e9VE3zL1jK31GZHqM1xQyU4qGu/zkx3sEPTpXennX7B/NJ?=
 =?iso-8859-1?Q?24ojDKGUdcYxvlYDbFEaE9uuMAt71DQRCG/RbcVxV0pIj+764xEM8gYZVv?=
 =?iso-8859-1?Q?kjbaxH19366knwE811KFhWxdD8GiMXw0lrpWInw3Ls0hPCDYlgkxjJBGG+?=
 =?iso-8859-1?Q?SaiBQLsU+6tSTd4eIZTS1OuvUw8kon2CUxGBNCkAfDi+Y0l/f7Ga9PNaiZ?=
 =?iso-8859-1?Q?CECjyVSdNQIswSkNUm71o+Wu1a1jrFLRabZuf/SvrtUnGDqZTuAETNfnvo?=
 =?iso-8859-1?Q?Xdwo43kt+N6N28aXzGw5xlWi0eRRy06txXgFMwS7ksWNZ1yUb4t2YE0iKu?=
 =?iso-8859-1?Q?gln7XZbYtacqBxRpC3aJDJCd1R5MVhPx6rUYmrYbnQvVA/Tv+sA95wzdkX?=
 =?iso-8859-1?Q?e219wIBdj5zRzo5G93ojCSqSYeK3owJmtezKyv11Cs1IgXFRRJZJRt5kEx?=
 =?iso-8859-1?Q?lyPwC0DhsHPc6eStHBmhbVfu9sTDvM9BTaqew+ItVJwQcah4uZ2EVbbOr/?=
 =?iso-8859-1?Q?G+Df0/bv616YrZlaYu1ShCYdzn/0AHVpJVe6xuRH+YbQ2rYyJeYVmStzXE?=
 =?iso-8859-1?Q?yAfNm3PXWdMUWQIvIhc7wJhiWlS3aFCT4pJP2mz/3szQY+1W7NUQnt96Q3?=
 =?iso-8859-1?Q?w6nZxbv5gZqaY3gdg9HKMH1kKKRIf9Z5TARCzuE9x5mQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fgjdI6OvJzKmI+ZngVUZLnyBYVb3fZmKFsoBfHD5lTXrcKriqhheID2qOo?=
 =?iso-8859-1?Q?OZ52dzJhvyVgBtRlkZ6cigujFr0McJ5oLFgGvaYJQ5RgUwzedXXHiA4KEV?=
 =?iso-8859-1?Q?tU3n5bRB4XMuAuYnZPW4URq9TbmRzn/zyVQak2wiET29yV2NW9RZLeWpkn?=
 =?iso-8859-1?Q?T1iONeDQv2kjgIRc2I5/hytye6H6INEhKh71n3pisav14Hb5+4pTA2IFKP?=
 =?iso-8859-1?Q?+dZ9gkTzV2CzsKjyQ2cGGAVn+vDkhzxDw0Nt6aahoXmY6U3/pw6lnlMBCO?=
 =?iso-8859-1?Q?ma+/tTMW9SY7c+gOYGhpLtQ/TVPAetK2HVZJ8yzgfHEf1bMRbD38qtBNUK?=
 =?iso-8859-1?Q?IJXxd7CQBPjR0m14XB3B59mT9z9KxsJZxKw3nndZSNaJHXbWfCTVklwsut?=
 =?iso-8859-1?Q?6YaarHAHnRTSHsxgbD4mVHu0bXRO9kxKEGkCcHXYbZmDT+6LwtiM1e/36D?=
 =?iso-8859-1?Q?SkwqAtoFBDFpFGjzImScwJXFzYNParohcgJycJ1Rybuwfuek4qXavZBJ1c?=
 =?iso-8859-1?Q?NxD9VwOhg5h5GcPSeiGcN2nGtpU7snFa4HhlRaKU1nu07K0q/srTMYI5lh?=
 =?iso-8859-1?Q?6oe2ha9w3ao3aC6bh5BfD5Il/+XZx/NG3EGc3Sy/WQAw/DNF7p74tDROOP?=
 =?iso-8859-1?Q?YU85JJtlnUzVuYxR2vttInsxqsIwjFRAaW1bFJhwdLSrT/mUajfcc0+444?=
 =?iso-8859-1?Q?UOG5q+uCBAUaGcMFP0IDzTbIGyyVuGwP5Q46nu6Wyetmch5rX2x1y05jVS?=
 =?iso-8859-1?Q?GnD8rFe7Mdhzu44NTcZH0fm7i6yjmhirnTFRHSaq/sbIDej8HHA1sdoP8o?=
 =?iso-8859-1?Q?y2YICszKvlZc50RXE9YmctdvWnuTDw+rhNRLg6POsuk1dHNBE3lPXNcU4K?=
 =?iso-8859-1?Q?p0AIt8D8xT26qwkU5cqsiNKpbrzMEXe9WnozG8y5BuiTJkJjhqo5uuh0eX?=
 =?iso-8859-1?Q?R3VGK8L4ybYqgrSfM8Z82qLEGu2mPdnbXl4K8OfoaQXDOz0ycUeQOuj7nS?=
 =?iso-8859-1?Q?7GOdIHTEASYqv60uCDXQQsVNK9MYDPZlWIIZO/w6/vcOk8QGhacEkNUOwh?=
 =?iso-8859-1?Q?e3gzDqFGtjBy9MUj2SQ44av6Icjaf0guuqOs+dfb83tIGnCc23yJlrd3qH?=
 =?iso-8859-1?Q?0U59xzGDZCuBU73KXzQwBHRJY2nNCObpmMlqBQNMdXhjpzSsXOodvsYacd?=
 =?iso-8859-1?Q?6PHSv+zaYH5PNw4sp6Ga+znWdd2THg+PrDECuop/Pt/moEko0z/WiFI0y2?=
 =?iso-8859-1?Q?mNT7gazRnX221zGfZa/a1p8PuDzc8XDgNB5ZjEjkB6aEaYbvinab/uNKFp?=
 =?iso-8859-1?Q?Iqe6gTMuJL8eo70ymlmBrEPeci9+X08Ui6NBi5CHf/qjs3hMw02yNeJGYl?=
 =?iso-8859-1?Q?vtG4y3UXgTKGn0XuB2FoHvFnfcWc/nqqHroeExgZ3MxhgLOk7LmC+S0ptx?=
 =?iso-8859-1?Q?MvpFXg9SP28gfDx5M4IWzYqQXdW/RR8Tc6JpWN1nCIk7BSrudLV6pvTCgL?=
 =?iso-8859-1?Q?bd8xR09XIFbTs39tqtwTcem5RezzgUaHp4I+RQ9Z50hdtelqhl4Xlb9G+b?=
 =?iso-8859-1?Q?j82GHcvvXVmpIkOrpMNr+/ZkB8g2YNyGucEj8Hlv1dGGIKy2GIGVsWpVZW?=
 =?iso-8859-1?Q?LQNrkdCEtnEFMajmECt1JM/91949yqrX/VYUx2BOtRVfEZTZuj+g8Bpckl?=
 =?iso-8859-1?Q?Sczi/wY9+g+JIoDJAGY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d52c21-b504-4a24-4e23-08dda1d72388
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:34.2129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irQsziEXBnxjigDmWEdy8N86t1mb0eva/zO56d3zG0rJETSI5vXllMHQTLTVSZ/vgsGw/3dGz2mvnWWfxc8+VqtJZoWObW1Su15hD5BHCSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Several things implemented in v2:
  - Addressing review comments
    - Simplify `target/riscv/xmips.decode`
  - Rebase on top of latest master
  - Fix code format

Djordje Todorovic (9):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  configs/devices: Add MIPS Boston-aia board model to RISC-V
  hw/riscv: Add a network device e1000e to the boston-aia

 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/intc/riscv_aclint.c                      |  33 +-
 hw/intc/riscv_aplic.c                       |  10 +-
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 204 ++++++++
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
 target/riscv/cpu.c                          |  28 ++
 target/riscv/cpu.h                          |   9 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 137 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 219 +++++++++
 target/riscv/translate.c                    |  11 +
 target/riscv/xmips.decode                   |  35 ++
 25 files changed, 1837 insertions(+), 11 deletions(-)
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

