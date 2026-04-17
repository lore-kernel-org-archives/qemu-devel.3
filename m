Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E3F436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVf-0004y2-Lf; Fri, 17 Apr 2026 10:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVc-0004vZ-VF; Fri, 17 Apr 2026 10:49:29 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVa-0007DI-1k; Fri, 17 Apr 2026 10:49:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB1AiQK2pqE48KwhfoEU268nEevCAcEclNHA93gYUMtulWKStB6RaRkLq0dadyDBqxXd2/7pHfK1sA2Hqc8UjEzdKwus1b5HHDZlG4PyyjukkIb+emMgSHYvnRlnPZoADAWnAL4ElhasndbsCiKjxCo4heafwLq8VkL55043yzUJxFMgIoqkLaDOGNJusnh+v4g+buCWMNkk/iP8nKw6X/QYj1BChT/py4LoIkcGHgqNKd0NlQPaJPAhWd4J2qZJEuj9q04teVRYUSwzolWiQG/mgIWFBge7hEyf0ROeJGHhFrEN35c85d0xabu+FvHcwacgD35uiSquTbx5/kuOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oay11mJt144P7M4ouoSi8o0A0Ae8BlhXt3WQoUaRJI4=;
 b=KfMo2qRxla0NXMDT98UkPvjL15H50mSBAaeR0xNzrJ6ez3x7Wj/SfFb5X5oVG5KDU0a2muW9L1EahXenmv/tosBU8ZfEQSEdW6Mjn8GgjFNXZxyzMQz7XXx9b7/wEiZqlgpPTPy2F8CZUeQJY/eJlsSEo/hWi/xHsk5oqXc+S0TFLWY3MUCjau7O04FlqrWi3j40ZO7m9Y6fO4FNTVwnogj3Z6w/lr0WckJ0bbqNn79NU+UmzyD0HbawxqG+v5twv0I0jWK7WYfNFMeAFtX/xmYMy6wXh+Qw8BC4+zB4GZQWPKpBtrjYJobjHXIfu2+8tJ7Gw6Mc1fxdeB8OfuWaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oay11mJt144P7M4ouoSi8o0A0Ae8BlhXt3WQoUaRJI4=;
 b=Q9NnBPoncr+Ha1Ydxf+W5O/GiDnlLg9DNTUbgBO2J5OqAFzq10AhXR3wHcWcxM6WSSrC912pcsD+JlLRoCAJi0877YmI+Rm4Wv2xHtHYacrQWxjrH9h5WTCLnEHfP19CRaUaglQGOSQ0Uj4bvHoSM8ZD0OJdUlYcmLzrOAHwvVcyh1pVVQCfTmlJ0wLMjF76ZQ70BGCJoot3TcYMwCzkaBOBEbjCaxNoBKgPwuhs0bZ4U7KiMSZh4WqWq94cuOkEstrq6rvrsFfckzNHezwZ52IpOG3N150tnYUliFPPYCuuU4lEL5KVeuT7kVztylF8xV2HrSJQvixEpljdEBXlsA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:14 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 3/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v8 3/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcznlbYlebix+Vak2tXUF3GwInCA==
Date: Fri, 17 Apr 2026 14:49:13 +0000
Message-ID: <20260417144905.178056-4-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: 30327b07-8fa0-491c-9188-08de9c907e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Aw/UZ6m9PgPs6/D6/BYZYW5mknKtio9hxxNChz0Gfv16EKU/MhXWUvyA/+qVpKRTea2mo7NAsul39y4Y1NAL5a/OTg0JCvqOd4pZ3d5cBFElOjdMibGr3XID5M0/wMFn6eAU4tDARhQuuB9IaIw8z2P3goxUfNS5CthZwBvlq/oMiyBH4BsZvdEZ5W+jpRvtxe/aUaihmV3ifHwn77z3HzsqOimLBNbkt/Sss+E7uaUvIRm1QCmVuqzUq5ILONRBc5fXCgSoL6MHyl52ZkxvqLQBYULEMedxad2XB3TCu7feLMBEWMCLS8efYR4Ga0ZUCJ0zsHrvkEZ8tSo79+6nvsmHTk+0sNIzcQsL7bntbYRoAIGqV4PHq0zWQeIux6ngSdZzeLBtje2eG9ttoEUrAGkQONX9/DezPQp9tb9m4MBU2mDHRPE/90WtuEmKm4JM4V6iHVCXabOjuD8PNT0pw3qXEpsB/OmI9ZaoP9J7/jWgX0fGVZES54roD8cyu1MyLYEx5hKbrh4VYEd3yaw4LqHnvOPoAx5kjRuyX0gdW60oFAwlicLhkex7MxRPQqQiJRJHJWEuvqQAnnCC31F3XZ8eks0YUz1q1w3Q/bPc4Ih7LJRcqjjEEI1cMpWQKgScrNSRTHgun4uuu8ZD76yGcfnkv1wZUAds4AScGz42oleIQOn7dkfzApG1QX8vWWO1mJROQQrjjasWKlncfKSYktOBcQC9WMFS9NHkUsxu2c7VteMmpq1V1f4Clc0lz41hyAwQ3Xq16CsTafBy8aE4NUYur1GTQeYvTMJDIWjtLl4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3+6cHd+dlbiHHicXOtc7u2wY3Lxl6HLgnoCcEmF2cafvh0KN4M/Es0nSy?=
 =?iso-8859-1?Q?1WM4pt/rCSsYtzFWjOVfGkGS3xTcHCA1U132mF9PQ6qeS2vw1l4yKzmb+n?=
 =?iso-8859-1?Q?V01TmydqFi6W0Ilrd0SnDAvFMlT/ibYaaDpEy2qwRpOwZPrMMoJqnElse5?=
 =?iso-8859-1?Q?vxwTZrqICNAKAn7f/LoRdrmq6OWnV0FlfT48hUbGR9MBGRcjl2XZOzDv12?=
 =?iso-8859-1?Q?CVsoBWyt+SrpgZASuxddoidj3zbq3f/hb4UjrWwfVpqDbTtu00O/0zDfbM?=
 =?iso-8859-1?Q?5C7a5PwtDnQ4vkDU12mrdABC7UtUPRgTlOVchJdeGf+B94KDZfbHpvzvXE?=
 =?iso-8859-1?Q?1yzbunOJ08mIJ9wPQc+2LptIOr+Jgq4XgFXp5r0/n1GpBwLIRT11NA/Jgx?=
 =?iso-8859-1?Q?4XP8PiLors1F3jNEC/xmTpr/zrbMBW+a5asKfZGzGKEvXJXN6LggmnxjQU?=
 =?iso-8859-1?Q?qS5EOmkY7F6o0Ij5YkK46VAVCz8jr7faqdOEcRyqvKGEeGb3uifL/2aGAJ?=
 =?iso-8859-1?Q?YbemnsIMokn/eW6fTUwiu9r1IGzSCRmT0hshN2AZetgvwKnOvqt3rhlsF4?=
 =?iso-8859-1?Q?gHZdT1bo10vI8rRbrMYQyKNzsgSedF+2DXZEohMM8K6MTY00mllU8wjlOU?=
 =?iso-8859-1?Q?EQqkLkPI+1cdoMPGcg9FScdsGXjeDbG2p5i/IwOjFffrd+CccKxsAPFvCk?=
 =?iso-8859-1?Q?SSkkVrUR01TeKwbktNW7HcdfnEC2P4SX2lu4U/lEqjtFKkhryP1sH8JqNV?=
 =?iso-8859-1?Q?J9XdCd2PU8hJiohjrKj/TKSIvyBm/C2g/bNIG716lJgr/t625KdbiQ+HWu?=
 =?iso-8859-1?Q?yyYiYdlJJmbghhIe4/p/L1nwybkC2OiEwkerraoKJnONgswa5Ba52UedGj?=
 =?iso-8859-1?Q?3Jj+Ky5i7Wkrz5MfpyJR3cYahZdhUySZemI5GD16OC2NOh0Lf2w1UOiK8B?=
 =?iso-8859-1?Q?jQr/9yUfvGKWuS6GrCHzHQcMOF5Ke9vN631Wb2mKIxZcJvEFoZ5KpfVF2U?=
 =?iso-8859-1?Q?ElGU2OmUV+uc7gprGEO1RWbvetXr3l/YzYwyYKxyX9kOCcatjh8CKRwbeZ?=
 =?iso-8859-1?Q?nmEyAITu6E2iV9jAYfdYcmyZMdDRmXg5nMpQQjYP4u19NUSBhn6omO6ZQu?=
 =?iso-8859-1?Q?oB6qKfCnCAF0Q5kZ919snB9yEupp158rcvfCQZDPzAlaENlvrEXQOJ9cTR?=
 =?iso-8859-1?Q?YWOYdH6HVcE+qfF8MzKGiv7k0Vj1935HVeq50ouEFlxN3JEz5MJsbll6HE?=
 =?iso-8859-1?Q?8+7ns/wipuQFQKDDvMlPHmSHFalILVxw+7EAmxhHxUcYSfbd0jJKvMSdQQ?=
 =?iso-8859-1?Q?N19VNL8EX2Aah3zKOH3utIqsL1WC42hnnmGfxNjL1e7wg/JuI4HUEGsZrw?=
 =?iso-8859-1?Q?CF0D2Dkmi51lA639g1wthPfWMIWJ5MD5Vnmimogc1ilZk/22SiYvs+jH3f?=
 =?iso-8859-1?Q?gugqJj6EDaCANIOqyBTXp87rc91Q889srcUZwSgWqdFLxzzypkFabWV64s?=
 =?iso-8859-1?Q?D0nRLipEmyAj+m/XvmFwnMjX3nhlc/N2ijbEYZ4cHTzCNjbTMC5s4P2tm5?=
 =?iso-8859-1?Q?DOtuc+vmsLJdKd768/wBlbErAJPK3nh2wgXUT76lsSMS+2X4G9ScnNRUB1?=
 =?iso-8859-1?Q?x9JBX+4Yuq3vLC7LWPisE1ztviprce5CxiZzikwKOyGIiNVC+YLCHnvH9M?=
 =?iso-8859-1?Q?V+/6mQXRVwckrRAWp3w4DDUuHH3O7c24zokFzxLaUOHMgSaS8iAqQdlKe4?=
 =?iso-8859-1?Q?nhqlRx/KjNQFO4Hs404DCsfQakwpj4+3HoRWjycrAGNUbuZqY0M47lSAq0?=
 =?iso-8859-1?Q?MNYapR60R1UMxs/1aqvYdyH5t2KL8eO0KgTXXXsXSKGrmKbV54A1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30327b07-8fa0-491c-9188-08de9c907e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:13.5064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XN72386rdKARLYxwTMk5oy31edjwOMac1hb0WftytthxPzGDsrZzWValS0gQwm1qW0x2IT2fND8DLe/xxqckDmbgNWfmt2SlQFHpwmwjdp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Make data accesses honour the MSTATUS MBE/SBE/UBE endianness bits
instead of being hardcoded to little-endian. A new helper,
riscv_cpu_data_is_big_endian(), picks the bit corresponding to the
current privilege level (MBE for M, SBE for S, UBE for U). The
existing mo_endian_env() wrapper in internals.h now returns MO_BE or
MO_LE based on that helper, so the hypervisor load/store helpers in
op_helper.c pick up the runtime endianness automatically.

On the translator side, DisasContext gains a mo_endianness field
holding MO_BE or MO_LE, which the generated load/store ops OR into
their MemOp. The trivial mo_endian() wrapper is dropped and call
sites reference ctx->mo_endianness directly.

TB_FLAGS has no free bits, so the endianness is carried into the
translator through bit 32 of cs_base (alongside misa_ext in bits
0-25). This keys TBs correctly on the current data endianness. The
cs_base comment in include/exec/translation-block.h is updated to
document the RISC-V usage.

Instruction fetches remain MO_LE unconditionally; RISC-V instructions
are always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 include/exec/translation-block.h              |  3 +-
 target/riscv/cpu.h                            | 28 +++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 +++---
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +--
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +--
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 +++---
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 +++++------
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +--
 target/riscv/internals.h                      |  9 +-----
 target/riscv/tcg/tcg-cpu.c                    |  7 ++++-
 target/riscv/translate.c                      | 22 +++++----------
 17 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-bl=
ock.h
index 4f83d5bec9..66068c61a3 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,7 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: misa_ext in bits 0-25, data endianness in bit 32.
      */
     uint64_t cs_base;
=20
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..ef870d05b3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -703,6 +703,12 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
=20
+/*
+ * cs_base carries misa_ext (bits 0-25) plus additional flags.
+ * Bit 32 is used for data endianness since TB_FLAGS has no free bits.
+ */
+#define TB_CSBASE_BIG_ENDIAN  (1ULL << 32)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
@@ -718,6 +724,28 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPUR=
ISCVState *env)
     return &env_archcpu(env)->cfg;
 }
=20
+/*
+ * Return true if data accesses are big-endian for the current privilege
+ * level, based on the MSTATUS MBE/SBE/UBE bits.
+ */
+static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
+{
+#if defined(CONFIG_USER_ONLY)
+    return false;
+#else
+    switch (env->priv) {
+    case PRV_M:
+        return env->mstatus & MSTATUS_MBE;
+    case PRV_S:
+        return env->mstatus & MSTATUS_SBE;
+    case PRV_U:
+        return env->mstatus & MSTATUS_UBE;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static inline int cpu_address_mode(CPURISCVState *env)
 {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_tr=
ans/trans_rva.c.inc
index a7a3278d24..6597ae8bb7 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGv src1;
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
@@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGLabel *l2 =3D gen_new_label();
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_tr=
ans/trans_rvd.c.inc
index ffea0c2a1f..3b9a745520 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
@@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_tr=
ans/trans_rvf.c.inc
index 89fb0f604a..e935523c93 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tr=
ans/trans_rvi.c.inc
index 2c82ae41a7..2de74fac3a 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -392,7 +392,7 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a,=
 MemOp memop)
         }
     } else {
         tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_extr_i128_i64(tl, th, t16);
         } else {
             tcg_gen_extr_i128_i64(th, tl, t16);
@@ -409,7 +409,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemO=
p memop)
 {
     bool out;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
         tcg_gen_ext_tl_i64(tl, src2l);
         tcg_gen_ext_tl_i64(th, src2h);
=20
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_concat_i64_i128(t16, tl, th);
         } else {
             tcg_gen_concat_i64_i128(t16, th, tl);
@@ -520,7 +520,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
=20
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/ins=
n_trans/trans_rvzacas.c.inc
index 8d94b83ce9..79bca1e957 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *=
a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amoca=
s_q *a)
     TCGv_i64 desth =3D get_gpr(ctx, a->rd =3D=3D 0 ? 0 : a->rd + 1, EXT_NO=
NE);
     MemOp memop =3D MO_ALIGN | MO_UO;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/in=
sn_trans/trans_rvzalasr.c.inc
index 0f307affec..79b0b2c63b 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aq=
rl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_a=
qrl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_=
trans/trans_rvzce.c.inc
index 0d3ba40e52..71b4ca5473 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, boo=
l ret, bool ret_val)
=20
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest =3D dest_gpr(ctx, i);
@@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_pus=
h *a)
=20
     tcg_gen_subi_tl(addr, sp, reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val =3D get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_=
trans/trans_rvzfh.c.inc
index 791ee51f65..f36b46c211 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/i=
nsn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965..43f586dce9 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index c1a30156d3..1b9993a9b0 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,7 +47,7 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
-    MemOp memop =3D MO_SQ | mo_endian(ctx);
+    MemOp memop =3D MO_SQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -71,7 +71,7 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
@@ -94,7 +94,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
-    MemOp memop =3D MO_UQ | mo_endian(ctx);
+    MemOp memop =3D MO_UQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -116,7 +116,7 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn=
_trans/trans_xthead.c.inc
index f8b95c6498..f4e3051000 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) =3D=3D MO_32) {
         gen_nanbox_s(rd, rd);
@@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_memi=
nc *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_mem=
inc *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memi=
dx *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
=20
@@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_p=
air *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_=
pair *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_=
trans/trans_zilsd.c.inc
index f50c52f22c..8068cc1aec 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr =3D get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     if (a->rd =3D=3D 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     return true;
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 460346dd6d..e2f0334da8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -64,14 +64,7 @@ static inline bool mmuidx_2stage(int mmu_idx)
=20
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
+    return riscv_cpu_data_is_big_endian(env) ? MO_BE : MO_LE;
 }
=20
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3407191c22..d73b749bae 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -189,10 +189,15 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
=20
+    uint64_t cs_base =3D env->misa_ext;
+    if (riscv_cpu_data_is_big_endian(env)) {
+        cs_base |=3D TB_CSBASE_BIG_ENDIAN;
+    }
+
     return (TCGTBCPUState){
         .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags =3D flags,
-        .cs_base =3D env->misa_ext,
+        .cs_base =3D cs_base,
     };
 }
=20
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5df5b73849..9f538ba96d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
=20
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -126,18 +128,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t=
 ext)
     return ctx->misa_ext & ext;
 }
=20
-static inline MemOp mo_endian(DisasContext *ctx)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
-}
-
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -154,7 +144,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
=20
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
=20
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1147,7 +1137,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size =3D mop & MO_SIZE;
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
         mop |=3D MO_ATOM_WITHIN16;
     } else {
@@ -1168,7 +1158,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -1346,6 +1336,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     ctx->zero =3D tcg_constant_tl(0);
     ctx->virt_inst_excp =3D false;
     ctx->decoders =3D cpu->decoders;
+    ctx->mo_endianness =3D (ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN)
+                         ? MO_BE : MO_LE;
 }
=20
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
--=20
2.34.1

