Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2119C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tizds-0001Kd-Qp; Fri, 14 Feb 2025 12:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizdq-0001KN-7B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:18 -0500
Received: from mail-am7eur03on2072b.outbound.protection.outlook.com
 ([2a01:111:f403:260e::72b]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizdo-0005Gi-Cj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXtQqlTSKOzbUYpWEh3cxlhuIky3zKlit7IFjz3dDOZeSAjMJoN57ujA36U9L1Jqd90d2oqu2lYTOLeI7UoI3D9mBzzi3uqdy/b/em3hM9qYqq0C+Un65IpxcIke8iQ08g+WRPmYA8WxjVpUrL1l6jBqBQ19k9DqLvOHo77zVdZnJCmJLLZbSGmvTG2/fpBiUPSU7wy9RPTAYImMwTUBXdlHVGCaFo2mOhe4AtvgXY1mNHs7Lp+9AwX/LS4wivvD9d1x6W0v+spMM3jl+PH3ehMLjAn6362X8XbOh/WTBRTRuXIVbcQesiklJe954RTJzBhgLuz6KyW/3Aou4K4nvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URGmpAlE++J6Wj/UUocEEZdPKubg/SWRt8RwFsoNUZk=;
 b=LItmEd6i7TMuL/yZ3i0gVAmBBEuuDYj8VZndpSFvrHA05y6sDZFMvm9logSri946Gy6gv0c7NqnYFIr8LykOfzmbznrvj44iDHgRmG0hYlRvSkfrkxwWjMHCk8OGBvKMhympIocFRLvNtqta8BNIizSLVY2hr6+m9TGOO79GS5RBo6KtvIHO+kY8b0T6Km0bx5K0FNsgP7x7iwie1wv9PvmpWxzPmdwVNzRXAEPWg+V5zrx5aKoXrRzrT91GMlbUP45TOuS0MUjLhEnYhq2CGW6jnrQZa5/cfMTsuAZzerZcT0XcTDKX0pOruc1vPY8br0sCGYT46ef7EjxZqdErWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URGmpAlE++J6Wj/UUocEEZdPKubg/SWRt8RwFsoNUZk=;
 b=CbNfofY0dayUYdlNcvijbnYOiaPF1L6iZhizy3WytXCKYLJKkgp9yL1KcEKkcEuUP5y9cBVUuGH8szG/uLD7KsPDouH3rrCdQafEyrLhBwDBQ3frLrKDMeu2fCT3gP0Jku+q68+izoIW1B6jU0vOJzrLhTbT3EY+jLpMWaBBM2ielVIeB0PveAIWjjY+xABwv4aVZ/ajYnlVItfUORcVg1qp18EhKs3VKqcHaA0jUbE5hV3SwE30r3XdTVlmUb1/xj8wsj1ExmZjSdwGkP5ee5lN3ZnjZurVqaVlUrTZyLUor29fvBeBP56Qi/q4SJ3NoeKE2fw2vKNhEdYKL8YftA==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PR3PR09MB4329.eurprd09.prod.outlook.com (2603:10a6:102:3c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 17:37:38 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:37:38 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Subject: [PATCH v4 0/3] Improve Mips target
Thread-Topic: [PATCH v4 0/3] Improve Mips target
Thread-Index: AQHbfwceUr8DrAArg0SLvh99V0Mq+bNHEAqA
Date: Fri, 14 Feb 2025 17:37:38 +0000
Message-ID: <20250214173702.2308488-2-aleksandar.rakic@htecgroup.com>
References: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PR3PR09MB4329:EE_
x-ms-office365-filtering-correlation-id: 2e8b45e8-fa8d-435a-768a-08dd4d1e4653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/t+6ZlJtFgBTKGnd0Bek4aBqXbO1wO5hd0bdfEG9THrK/VnG1i+j750oFj?=
 =?iso-8859-1?Q?PFfK20iZD0vVx8Yt1DPuv6CEHX7BUVIuGYzYKUqOVEvd1z6tqL4JP9Wo4a?=
 =?iso-8859-1?Q?YRFivmcjERgCf2dGB8A7jFQDAAg/xB9yt2XcugLh5i9r2stYF0lHLQErS+?=
 =?iso-8859-1?Q?LE0zXNqweN8JkoJ1LOZ2Cijlkn4mwzgBk5AFyL6ejzYu+akvRE5+l3/JIG?=
 =?iso-8859-1?Q?YCs2sGDdkCvu4Ttfx5gHJ6q8hMK9rHShqfTnt54tgmaq01diE4OYdsBAvv?=
 =?iso-8859-1?Q?6yIHd4W5UNYHu7KsE0vqpxQyvVQFqD21n/E2Bz32o0uuFvOHYBh3JIV5gI?=
 =?iso-8859-1?Q?Dxi+x7NablijkNCFBwBW7jIuTPJIft/kmhescVZK6jcj7IuUxj53h0hs1i?=
 =?iso-8859-1?Q?JewDMQgRbXXBzN1NpcJueXXccda5ge6FTU7xl9LihHJGwUCrKL3ydmuNF0?=
 =?iso-8859-1?Q?6w+9BG59nxuPuQa9Z2Asq/RX0ADqa+VvuPaSWugv0bj8RzBbjTsbxMW5Nf?=
 =?iso-8859-1?Q?C8zg43rnVF6Koam23w82DcaTx14CJV4BXxmHgqDHKKKkOIPUi/oii4NwLg?=
 =?iso-8859-1?Q?LMAqix1XlgpYbmit3ujHkEu6hO+wfYC94YzQ8VGmWjTxgYAcc6qDsLepZz?=
 =?iso-8859-1?Q?DBFbwI0ZI5evYShJh9wcfuPSKOtkwD8/2kVmMRl+jDpSUpPK7ZrH01Y2Ip?=
 =?iso-8859-1?Q?Iu3c0i+Mkk40jeVAlLCvn210IDS5pL+9kio9ntc6JZ8aNy66QTf2GElCq4?=
 =?iso-8859-1?Q?q2w5zAT05mwLiJ9Qu8c8vm+d5ZZkPBNufThRNZapbBSvqOItqvpgFxsCwa?=
 =?iso-8859-1?Q?f3NdqkQi0HrrjJJINJ+qcWQEbJw/xc0s6gpK623M4IaWTNKq6S6u8m9LXY?=
 =?iso-8859-1?Q?ZUq5CloDjnXFhfXwXNwHJC1TgDlenXu9faKACXCl6EIB5Hy9C9NnIZDyEI?=
 =?iso-8859-1?Q?S5KDJfg9DlbfqJIpWEt1i71bVZsR6ImfOWztS+Ygls/hI6zvHf62x0kDGe?=
 =?iso-8859-1?Q?YBFppAtHhTMfX/tUnr24emYg9hQFUjItOe8f+ao5AF3l8LjK/q0og/0FJK?=
 =?iso-8859-1?Q?wfrNFcMM69bmCzs6wT6SLFk2dlgyB6SHNnFL2QL0yOD3jjxXn5zhHeKTuu?=
 =?iso-8859-1?Q?7ClXyegUs6EgKO9+EG5VV72vZPQU7U36T+6dObMlJri2siqaUlwFSrzRYU?=
 =?iso-8859-1?Q?73+iYfYXYKWSDi8yGiSIgvo4CfZ5qVi4nJJvCm5TDGWQ5AKyMr2TqrsmJF?=
 =?iso-8859-1?Q?kGHMBmDz/RxtlGRFnflSaFlDr8OoiJNKMgot//sMjTqzAagKCtgnSkd6XS?=
 =?iso-8859-1?Q?W8M8qbrQ0aRONxWZQLIzR3ZMIwozWtPmEXxmaWKz5kA39BalaNVyPx+8fK?=
 =?iso-8859-1?Q?gTmmB/QLLlUjxDrjI2ybb5GTXwICpIAvT/fs5iXpDCjw37MHeCu2xFuux3?=
 =?iso-8859-1?Q?k7AYgB+k075sHhhFUZOHfVUY4rO7YdYZ3/y+lt8lpJ6CF38AX9NZRPziYk?=
 =?iso-8859-1?Q?l6xYPNj+Fd2Cri59N980RB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v6wwMlr9RXGXpFL5O1x4rjkwfS6q23GHKRHTnc4HzS56au2cJnG68fB3ey?=
 =?iso-8859-1?Q?Je7Sck9iFwzEn4RrFq6pJcGFRVdSoOgLUPW+xeocRXskW6+TTIcHuH4cx3?=
 =?iso-8859-1?Q?cyLcZRTvW766zG/i5nD/mmgDrqSFXC9ZsUz8T7rEtA2Yp44Msde+nPhn0p?=
 =?iso-8859-1?Q?vJ0gXa3whjck6vBctmgPI1zPMogrE14+s/tt3x8mPJ+mNFtVRtYqkobBns?=
 =?iso-8859-1?Q?NbvG8LWiKnLEDBSntwBKe0JEqE7rR/jXi6xFZVCbfwgjNuN9GIuDUQRhmV?=
 =?iso-8859-1?Q?rRIMGO+FJF2ePrblx0/HQ1cdvX3rpT6a0n71DCqwKIfk79k2nvFAG/62bk?=
 =?iso-8859-1?Q?DWwBcS1kSGOWuHNGAlTveAHCX6Ds94CX1Lv3xDX8etL5aPuS3U8cjcWBDy?=
 =?iso-8859-1?Q?MjA6RfvlthkhGyj8380e5M5d4oU4+cUEy1W6p2Zzi2XkPiL9ucB8tz7/i0?=
 =?iso-8859-1?Q?SAS4N6V50C/wMbaj5d0A5BuOOm7ktznIkS3XhaHcG022RABdWOV7fNd0V3?=
 =?iso-8859-1?Q?0XEu9o0a4PkMXGgbYLQASO2iWelca9Z5LdJ4diQsKW8IsNWpciPceWOTLZ?=
 =?iso-8859-1?Q?8Yonmt0wRz3KaXgE0wp9/pfzfR9c0a6kgmIxfLkPaWSUDbwh8KNsj6Hb5l?=
 =?iso-8859-1?Q?ER7ug/scavhXR+q5q166KfKsz5wQCf8tsxjmYIaj9LfQBK8NsFNbrwwKN5?=
 =?iso-8859-1?Q?EhslQYelylW3O6Rx/cVbigfP6Q+fWhXUSY+s1ysGuJ40oI/xqkckdTezlp?=
 =?iso-8859-1?Q?WnKUo57Q5/HV9nLShVDf1kDNF7/rllDgZTR812raPQD26dQ5VNohZfVa3u?=
 =?iso-8859-1?Q?8UOUbNUyy3+m3uLIUa/o5sXdqz61dKOcwLMt30/L9mDtjtOAmXyUjptL6c?=
 =?iso-8859-1?Q?wDKAddSDga52TU/DmuwJQu3KhKcs57bGhriUJKR4im+c3eFs6ZQCrOdhFu?=
 =?iso-8859-1?Q?jLSJ85byYxY25b7+WYwt6l5ADu6iHePJqhdQMSxyPg4zosb1QFOfDpA6nh?=
 =?iso-8859-1?Q?vsXpYP0Ll25H6B6EaZSTpNXQimg+PWSVlLRzE84ZatpPmTA0iozcvnAj7r?=
 =?iso-8859-1?Q?VnVCG5AqD5IOdllekKH/HVbqonuXDy+iWvCjtEamvAbxaJ2A2kK0X/pZZ1?=
 =?iso-8859-1?Q?CI41sPLWYRUHTcBknFvO5QINaBIx/3rqrzCjhYWoFJ5Ie6ROiW00bCQVHv?=
 =?iso-8859-1?Q?nu5tEOqybKzbKHfZWyNR8lS5s92TOnvmL0scQuczOmesXnfM2vHN+wB04h?=
 =?iso-8859-1?Q?mKfik9778JjXK666Rl3xhRs0La9lOYGgJse244V7yoeGHiZwFy6gKEJZqa?=
 =?iso-8859-1?Q?b/2KVYeI6jtHqq+QJprsLvIXHvyshmz9S3TCsqiXavOWH02KqzryCl0tOd?=
 =?iso-8859-1?Q?cZhd7+SahHWYrL+5gUKaIB5rMnw3tS/is8NozUZ1wZdiq4Vderj3VNL0b0?=
 =?iso-8859-1?Q?upDg00iCoSFezpjkl6Szuh7m30yLuCGl0hstzfSu9tdDV7KaLTPd7Yka6j?=
 =?iso-8859-1?Q?VuOojnZakEmsDP0dBjE3/yu+yeHyzoW699MH3sNKsoEUrVO2xpe3LD4sjO?=
 =?iso-8859-1?Q?DAWyrPujLqrHlfMTaINJRa/x7JGTfxIQa11sbccsYPGA4Ax5R/Y9+cpyco?=
 =?iso-8859-1?Q?L515bbtCH3wvGXXDJvMAC+sXsSgvpoxQlH29szWaMe6oQZZxskH2UCXYrO?=
 =?iso-8859-1?Q?ic5ZoEINhrjS1uxjRzE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8b45e8-fa8d-435a-768a-08dd4d1e4653
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:37:38.0296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fggfKNrd9WZpAp7mxJ0QP8wP3HHdJ1nAppdxjloajUp0jcpPcBp8yGI0II2SffLYrocpbBUngFd9kMZhufiQ9hX4K0ejG14tQu2w0ojc8E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4329
Received-SPF: pass client-ip=2a01:111:f403:260e::72b;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Aleksandar Rakic (3):
  Add support for emulation of CRC32 instructions
  Skip NaN mode check for soft-float
  target/mips: Enable MSA ASE using a CLI flag

 linux-user/mips/cpu_loop.c                    |   6 +-
 target/mips/cpu.c                             |  16 ++
 target/mips/cpu.h                             |   1 +
 target/mips/helper.h                          |   2 +
 target/mips/internal.h                        |   2 +-
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 +++
 target/mips/tcg/translate.c                   |  37 +++++
 target/mips/tcg/translate.h                   |   1 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 ++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  34 ++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 154 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 154 ++++++++++++++++++
 19 files changed, 1391 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

--=20
2.34.1

