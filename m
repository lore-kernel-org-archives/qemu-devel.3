Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF72CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n7-000402-GA; Mon, 01 Sep 2025 06:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mt-0003tC-60; Mon, 01 Sep 2025 06:29:23 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mo-0005KL-W8; Mon, 01 Sep 2025 06:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ymys14ei1yva8BpwVPtRRTzTLN3Wn4LUzLSUSmKsiPtdtAnH8pl0ynN0CunxxHyfvXrrh2Br0CcTr3hCERgT01wZX7p9Ov9Ido/4SE0m4Ma5PSomiIYcgXcBUiUz/jiQwsBI0aYL8JchhoLkGobVJ4fVzweK88EOC3U9XyuzYSuiBx0QDLSX0//uJjL11ZI3KN5s1oOnIwLqg2e07OGW2FPUjrbBb7Dul6uTiJvLebbYYIm3olemc2wmiZoiC5MypVi+xYSAtSizPyxRpUIDRBLkILMl47RVAZD+VwCH/wL7SCGUqbKUWOAmKEeB28llRCl0v8SCKlyxmy4NGDxI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+kuggFknK1G/MmQVJeetUyA9EO9T71TDwUnxmRbdKY=;
 b=tihP1T87i2G61UpwRFYyukiDtdxyqbuM33FC7JJGeJGmYeCbfhca3Pz5CA+U7Y22JdaR4e5bpcV6E0cxkZa3hS4VAhMxdzv8CqbM4f84UMJVGw+iRkGurCb1243KuLAf7OcM7rxDx29LKKF8HNZ8b84Kk9gQ4H3a/2OEbpHqUfcXfidbV459uejlr0gxFXThoFOklLJp15KGkCIR/eOs7YsupDA8AnjwHmmGRR0QGkWjcefPk4+nG/2fJIAxeLW9GfiBxVaEA8kTBLpRLawn8aMTp5Mfeke1QYHpfDDpYBKWjH6xU5J7mFNCmYAWbpgItkzDojlAHwEbBHLM9a8T7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+kuggFknK1G/MmQVJeetUyA9EO9T71TDwUnxmRbdKY=;
 b=DfU55tlsEOqdmgsUZvOW5lJfvofItShcQYoPKuisrlH4ilBf9GepQIFSPSBrKLo5eOpPqMiZiiKrf+s8M8naUyymzjolCfTtSVkVYiy5sEH9OzbEDk0yWfKxMpAs4JVNSbvzHFQ1yQm/ulq5hyIHBDTZBFwrrGwgZ7NSGs3Rp/LoMs+iMS5d79BuanqlY/mpMB75hQixHEUNRq07rv98YverDrbILmqZjjY19u9om6ax3cb52nBBf7kHDUXMAj6JIG6vWXknTEa0Cz2YumX8hX9a12P/02xqI+4tp21/oraf05173yemr7AEF3YaaRmjJ0OAXG4sjZZdtOUXSLYXJA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:07 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v7 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcGys9ELD6lzWz2E2YAV2wWDP3Ng==
Date: Mon, 1 Sep 2025 10:29:04 +0000
Message-ID: <20250901102850.1172983-9-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: 4a4070a3-1eec-4342-4eea-08dde94261f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eTmtAH4yniiAKzJfveVPQVKnJILoBAFysO9d8qzjhu/n4Tn1wgVZexXO7A?=
 =?iso-8859-1?Q?P07+aCWBKRBpGozPWDJ0v2+/z1AukHmgxH8FliOx2yrRTIU63aDgBseGh2?=
 =?iso-8859-1?Q?BTL3YEOY3c4GBopPMwdgiPY+IkdGwgM+kOzpMLGCKk2bbw1qSA0VIElotd?=
 =?iso-8859-1?Q?32bQzPAzr6/Phfs/1ovdW2c2g43Vb2veCJ7+ny535sMmCqkKbnLflbQgDX?=
 =?iso-8859-1?Q?2Nbyf/UEsQYThsW2qxuuoFPzb3ot47p7AAuTpK4Op4YHGrYHUxVyUyM8Bo?=
 =?iso-8859-1?Q?756N0tzEF8FrTUkJUcPlzW3ZGLiwYcFhKAkSSjyhefLU8i1GxfBlmNw0dV?=
 =?iso-8859-1?Q?yZOrsPSbqAW/2/5phcQK0PRqLH/EDvrH1TrcAXnFdzllqwowa18GGYXzgZ?=
 =?iso-8859-1?Q?tT1Za0bwiDVP1DSZkdL7YERymzEyBm5Q1vQpTrySOep/iB+M4JCKn1+0eU?=
 =?iso-8859-1?Q?Zd7cDgNTztwxnHqpHDFqhHlxQGZOyBp+bF3OyrYlOQKNNePnaWKB6xOkl7?=
 =?iso-8859-1?Q?ZJc+cRf/R3zVm7mw9KwP97m1S6i+XHtjdBJA7EbPTe/9UG9UEz74Qlhvr+?=
 =?iso-8859-1?Q?85/1jYq+8K1OKS+8P8sxPXOBg1HWrm88yEiJAxUe3cIxfnvwjUF2c2wkgO?=
 =?iso-8859-1?Q?UWC/FcOGmyoP/4GdVR35Xlnht33ITBIUtK7XR/YzqJfzHg5VtlfR8vQ6/+?=
 =?iso-8859-1?Q?9p6f9Joo46TlnIJsj5UFew0lIV/xdokaHK0OzFco/kD2M5AfvOPJZ7uVrU?=
 =?iso-8859-1?Q?eLxvG05zXYMy03eh7wGzBKuj4G1CVvOXZ21hm+eoNAlxS3nsoIMAT87xU2?=
 =?iso-8859-1?Q?e7/Rce/z7m8UImYyVaNeccPGF8QPx3B+Tl8ivfKlxLFQUwR57QmWF4nY/Z?=
 =?iso-8859-1?Q?A8T8C2O6MLJ/xWCLuvlMvz2euK42/939nVoYvkyiW1yhcmV5oW5Nf8c9Sf?=
 =?iso-8859-1?Q?yuXn8cBIFUJ9rWwYaGA6vaXkRNmXGSJC2oDU+0JTeiVclJM+rlKpgaND/l?=
 =?iso-8859-1?Q?v3h03uH4PiVLLiCTgXZjsjEkoJ1VkXVUWssLHBHNpc8+m8jzX6qN82oow7?=
 =?iso-8859-1?Q?39cTY2fcNTdLmfQlX/1VL2HM75iCZhLI5wyUroyH7ltQh3nbt2eTCZNvfR?=
 =?iso-8859-1?Q?vBjS2H+1cjK7yZNGapOImbTSZcKG76DswYlL+lJ9g7jud5Pk8oA+dObOsM?=
 =?iso-8859-1?Q?48PLGoPV2eM7EZ5GMfn0HdBj2PI7r3hlaM+mgtipqnKEr8QhQCEXdJc1th?=
 =?iso-8859-1?Q?WAxwJyYAhMHPkPVAN13Rutg5PxhGeJjUGcUZLA3hp752Qzlhgfeulj/+X5?=
 =?iso-8859-1?Q?jU51siXtcduYGEaugB+wjoFawPfE9gDA+u9AFpezcvhXMhD3eXVFbBLM2K?=
 =?iso-8859-1?Q?F8/kqOOkqYe8N7NA+ID5zXWtKkyWfV37+3emdnNMouMLZSxm42Y1t5jP7k?=
 =?iso-8859-1?Q?W1PKGwkuagssbDsqAdf/QvGmJmZKGAFB0PZlgnJeZsMz0drE1b6BiOyY4K?=
 =?iso-8859-1?Q?2Il8/StTx3cu4IE1uFa2TLmR3NXLUO4nGhg+zxgebYHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MKhTAbjlHWKOMfNIMh/CuEmqfycUVAqzOIgzIYI/Y339NT4xLUQTZCR/wV?=
 =?iso-8859-1?Q?IOfZ/vOlE3YMLy/JJA56PidtenDvzraOHSX11F+tbVuglmU35ESE1LqkrW?=
 =?iso-8859-1?Q?m/T0ySoK7k2uq27CC88Rr8IpRSEJ77VNFmTHI0rqTElzCsZZbUicIx/dq2?=
 =?iso-8859-1?Q?eBdzdum1Sm/2D/992mkNtg8thfgFfUbqF58mIunukG/VPKZQQqB5P/es7Y?=
 =?iso-8859-1?Q?w0pG6yngvJlt6SLQ4exoS4YhbQAY7Cua+4dvq0pAipz8NU6GQ/ZFncj3eQ?=
 =?iso-8859-1?Q?MQZHUbzB/trwiBD+VeuFoRKVAUVZQfrV2B+XMpxBX4QZPZsLczJiYOLppB?=
 =?iso-8859-1?Q?teyD4A67vLZTu7mhjSyRqVKqG8vPAEUhxlooAxiEuvCWpvx3Ev1sTSE2SS?=
 =?iso-8859-1?Q?43YmnMqUnKvAVOEUwQ8ViXZfVB6IiAGgBHVZhDTsOmphKrQ7wZsxi2K5H6?=
 =?iso-8859-1?Q?hAwEBwPyXtbqjd5T6tExvYcbFpBglF38BtcG8lp+hEuKcOIHIgjdQBfmOl?=
 =?iso-8859-1?Q?2EkEsLNEPtaw7ygWKUr5yLKLv8dLbCEGwvV55wzkbOgthAutX8WuQIZ8Nn?=
 =?iso-8859-1?Q?iBKHeUbKbnTOxB220H3ltzG+FmZLrVa6/hTdtGlXU6wmMox6J86dcA/+8H?=
 =?iso-8859-1?Q?PkrZIWmfy3xvy6Y9dc88JgASSlsdOLIZrXhUnuXlLTJNI4x6jFlRWJE33M?=
 =?iso-8859-1?Q?Th8s7CoifQ+byat8t3L/1BkEYXJJEJ7iLNdUs/q1ekQy6RDySAbmUBVkWy?=
 =?iso-8859-1?Q?21hLTtVPEIxbADk+q8PYvOJePAr8VqLq9qQyGDIjeggRC0oGz8siaI6d+w?=
 =?iso-8859-1?Q?SdDOpEI+irKIkpnASje9cq7/z/irhiDduEuV5W3uWUwZIOPjxszigcp4ul?=
 =?iso-8859-1?Q?u9vpbP3CIOp8ZDvBbcR0y5xXdrlHSjN2R2I4zWapO5j95rHzwScU/3gx91?=
 =?iso-8859-1?Q?sUPCFcui2V8/vF7l3E6ZEIWDfZLdZlg91YY8CuweqtM0TVB73lDAGAcuKK?=
 =?iso-8859-1?Q?Ay0ST+zsohcsGH1te0+yt8dXA5XZ7cc9CKXriMAfEni8bgax0+jjrl1Ijb?=
 =?iso-8859-1?Q?93tAJrsrrDB+TYSQjv2KvhR9koqwSEkvZ3dpR/jyH0/mXnaswserKR1ScQ?=
 =?iso-8859-1?Q?pY4FuOjKu7fNvqExNu13ycUxRX+EiIylLpixHfuBhCoRx3BYWa4hnomO8y?=
 =?iso-8859-1?Q?d2fL5h3ijL51y9rg6bLRy5FHOw9uoO/QvfyF7PFxrgLACvEAb1XGlF9IoK?=
 =?iso-8859-1?Q?TOsOLj1kji6v0lfHC/zSyIcOUbGYp1reXgQC/dhuNDuzObbZuccCiqL3L4?=
 =?iso-8859-1?Q?kBgeKek3Fx9Y2OeW3msRQEdh444iPT5if/MdCoqsdwNZ/V82U11Jc5Jli3?=
 =?iso-8859-1?Q?8o/erzLoDK9uCGTLJBrn0BmbqXM5XNHLIg4p6c0zaMk5gHVu127ZU6TRa9?=
 =?iso-8859-1?Q?78ndvZbgKCzenSuaYnIAwt7VlKKp6hvNufD5m2t1ZqxASYUPj25pP0RCf3?=
 =?iso-8859-1?Q?6e81eV9sqGBXH5Wnfdqlwr6G9Z4DHWEeMJ6ir23Wji/VSdnx42y+V6Srr+?=
 =?iso-8859-1?Q?KJN/Edf84HsqdPyoXd5DwvytEtAEkREMhX1dkq9EtrcbWCHQ8lArEk9rdG?=
 =?iso-8859-1?Q?4He/8MGB8GAR8puwHWywfkKX56HTX/b5h5tJS8y2GCOnWSZHmTS+ikZgHU?=
 =?iso-8859-1?Q?fybCAqboj8DQDES42h8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4070a3-1eec-4342-4eea-08dde94261f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:04.8754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ErNzmR3fSrEPt+vqpR4QiJLfdR+D1Mxksadlbmg4LMiMjdt8uIna2je3qGSu8XRcGcRrE7EfNkkSmwWL5HLHLc8enhy+LPzfu2eTgDcKgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 244 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 305 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..c72927c3ff 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..ef891e465b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..1093eede19
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,244 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+       cpc automatically. */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..d7145a51af
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
--=20
2.34.1

