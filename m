Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8906CA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utqXp-0000dW-RM; Wed, 03 Sep 2025 12:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1utqXh-0000cG-H6
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:41:08 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1utqXc-0003GJ-Uf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:41:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77287fb79d3so121592b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756917658; x=1757522458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=peOgdQDR7Jp7t8z6GJiGFqGLvBe6W/ZtwJSEvPMjO3Q=;
 b=VsCnjh6hAETcB+knR+8iwmy/0689YyoxQCr19Tl7Rzg3WmG4B/N3tHBPvOB7n08/9K
 lyUYlZQJFxWZckyIgPhiF2SrxRZXa/6b090PiR85fZDbg27rx6CZkaSm2MKbLdbf3cdh
 c8elDbrZBIGGUslagDHiPsRjQlRCdsvxRvtjW8W7+uxxHQgTrvFeJ5jAl19o2qoKsZmI
 EHMV3aF+iQLOE4UuJWaHfWp/HbLlMrdyek6sBA/c0SoYASs1ZbCv2Dx8GSHRSd1rXRF3
 jgyFaYSt+N/daawMJ+kndKnZrL4GZSxiao442czNqvkHeKv53xEsolL9RLGdhh8hsjXh
 0O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756917658; x=1757522458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peOgdQDR7Jp7t8z6GJiGFqGLvBe6W/ZtwJSEvPMjO3Q=;
 b=naO+1+oLhZ/Z+XmDbNHbpLPLEZMoWKHnTuPdnkjVBdmU/pPmlsK6jnzeMVTilk1429
 HNDcn4lmBINZSb4UVjd11rnP3QI9TOyZbeGsw0L5/S6sj2LmdP4Wp5tk4K0wvfT1xCtR
 2w8O79YN86dutbxx0Qimw0yd1MuGzQdkTFWdQGwO1mwwGtYXq0MGMBj5ACv/ZcjB60rV
 oK3x6jPoNNBuuGePn0cEVk8Ifn++zWh2VVoa3yqOv4A0zOY7s+1XdEfj3aJksMNNDGr9
 U4gKH8F6Pb+xpmAaTkPIOsARqnlese5qqlfDiz+UN6WcFd6sRYyNkSOjRO/qvawKW3s+
 wplQ==
X-Gm-Message-State: AOJu0YxAMbuTpIK6Im4f8KBxTj0dFDF8uPJ0fMUsF8ujzhieh+DwPFwF
 XeqWnU6K7ap+3F8d6qYE0hhwQ/KBWvtEvMm6INoVU7hfsLdqEZKZZDAtedLob3kiX3F1Rys/QKX
 K0eTi
X-Gm-Gg: ASbGncuNWX7jaEPuMJQ+NHacViHHkYOToKdpGLEQTpABL7hpnYZBh8pYWiLdUWwtsNP
 1MxZP8vCVo0pp2+G5vYh8IGJPmYO5OdFnJRb4pwJpa+esAyJmFv0/THuRDP2Xk4pi1K0stgiHrK
 NtqcgMhAVysnBIrYokSerSWNzMDJVOLf2rVPaOUKTW0OIPi/maFLIQtimVdPkTXjGcgu50e1hr2
 HHzisp7RStdfcO1bsUQTzZxSw3ot6V/3xPI3LXlAoh34XAKmrNYWkTv+Z9y72MMlk2ArCCalJoT
 00vcfhZWQwx+KRFZQDNU4f1WAD5cz295E9eP+YcOaVeoYYwTcIzAx3RVllkLaDtIHE4w0MzFp/T
 g4mQnqOzlOFf6pwDkCIpks3HdwqqXfIzm
X-Google-Smtp-Source: AGHT+IFLksObn6cMs1VHSbnxG3voVJZ9IsP3yLRooyGqKPu8VorIzVIW+BKt/nyI8FkXJLnpu6cHdQ==
X-Received: by 2002:a05:6a20:9189:b0:248:7a71:c1e with SMTP id
 adf61e73a8af0-2487a710dcfmr4561076637.52.1756917658060; 
 Wed, 03 Sep 2025 09:40:58 -0700 (PDT)
Received: from grind ([187.10.187.251]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d6cde2f0fsm14284511a12.13.2025.09.03.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 09:40:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] linux-user/syscall.c: sync RISC-V hwprobe with Linux
Date: Wed,  3 Sep 2025 13:40:43 -0300
Message-ID: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

It has been awhile since the last sync. Let's bring QEMU hwprobe support
on par with Linux 6.17-rc4.

A lot of new RISCV_HWPROBE_KEY_* entities are added but this patch is
only adding support for ZICBOM_BLOCK_SIZE.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 linux-user/syscall.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..ef80c689d2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8992,6 +8992,29 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
 #define     RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
+#define     RISCV_HWPROBE_EXT_ZIHINTPAUSE   (1ULL << 36)
+#define     RISCV_HWPROBE_EXT_ZVE32X        (1ULL << 37)
+#define     RISCV_HWPROBE_EXT_ZVE32F        (1ULL << 38)
+#define     RISCV_HWPROBE_EXT_ZVE64X        (1ULL << 39)
+#define     RISCV_HWPROBE_EXT_ZVE64F        (1ULL << 40)
+#define     RISCV_HWPROBE_EXT_ZVE64D        (1ULL << 41)
+#define     RISCV_HWPROBE_EXT_ZIMOP         (1ULL << 42)
+#define     RISCV_HWPROBE_EXT_ZCA           (1ULL << 43)
+#define     RISCV_HWPROBE_EXT_ZCB           (1ULL << 44)
+#define     RISCV_HWPROBE_EXT_ZCD           (1ULL << 45)
+#define     RISCV_HWPROBE_EXT_ZCF           (1ULL << 46)
+#define     RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
+#define     RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
+#define     RISCV_HWPROBE_EXT_SUPM          (1ULL << 49)
+#define     RISCV_HWPROBE_EXT_ZICNTR        (1ULL << 50)
+#define     RISCV_HWPROBE_EXT_ZIHPM         (1ULL << 51)
+#define     RISCV_HWPROBE_EXT_ZFBFMIN       (1ULL << 52)
+#define     RISCV_HWPROBE_EXT_ZVFBFMIN      (1ULL << 53)
+#define     RISCV_HWPROBE_EXT_ZVFBFWMA      (1ULL << 54)
+#define     RISCV_HWPROBE_EXT_ZICBOM        (1ULL << 55)
+#define     RISCV_HWPROBE_EXT_ZAAMO         (1ULL << 56)
+#define     RISCV_HWPROBE_EXT_ZALRSC        (1ULL << 57)
+#define     RISCV_HWPROBE_EXT_ZABHA         (1ULL << 58)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -9002,6 +9025,22 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
 
 #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
+#define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS 7
+#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ 8
+#define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF        9
+#define     RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN     0
+#define     RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED    1
+#define     RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW        2
+#define     RISCV_HWPROBE_MISALIGNED_SCALAR_FAST        3
+#define     RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED 4
+#define RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF 10
+#define     RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN     0
+#define     RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW        2
+#define     RISCV_HWPROBE_MISALIGNED_VECTOR_FAST        3
+#define     RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED 4
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0     11
+#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE      12
+#define RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0    13
 
 struct riscv_hwprobe {
     abi_llong  key;
@@ -9110,6 +9149,52 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZACAS : 0;
             value |= cfg->ext_zicond ?
                      RISCV_HWPROBE_EXT_ZICOND : 0;
+            value |= cfg->ext_zihintpause ?
+                     RISCV_HWPROBE_EXT_ZIHINTPAUSE : 0;
+            value |= cfg->ext_zve32x ?
+                     RISCV_HWPROBE_EXT_ZVE32X : 0;
+            value |= cfg->ext_zve32f ?
+                     RISCV_HWPROBE_EXT_ZVE32F : 0;
+            value |= cfg->ext_zve64x ?
+                     RISCV_HWPROBE_EXT_ZVE64X : 0;
+            value |= cfg->ext_zve64f ?
+                     RISCV_HWPROBE_EXT_ZVE64F : 0;
+            value |= cfg->ext_zve64d ?
+                     RISCV_HWPROBE_EXT_ZVE64D : 0;
+            value |= cfg->ext_zimop ?
+                     RISCV_HWPROBE_EXT_ZIMOP : 0;
+            value |= cfg->ext_zca ?
+                     RISCV_HWPROBE_EXT_ZCA : 0;
+            value |= cfg->ext_zcb ?
+                     RISCV_HWPROBE_EXT_ZCB : 0;
+            value |= cfg->ext_zcd ?
+                     RISCV_HWPROBE_EXT_ZCD : 0;
+            value |= cfg->ext_zcf ?
+                     RISCV_HWPROBE_EXT_ZCF : 0;
+            value |= cfg->ext_zcmop ?
+                     RISCV_HWPROBE_EXT_ZCMOP : 0;
+            value |= cfg->ext_zawrs ?
+                     RISCV_HWPROBE_EXT_ZAWRS : 0;
+            value |= cfg->ext_supm ?
+                     RISCV_HWPROBE_EXT_SUPM : 0;
+            value |= cfg->ext_zicntr ?
+                     RISCV_HWPROBE_EXT_ZICNTR : 0;
+            value |= cfg->ext_zihpm ?
+                     RISCV_HWPROBE_EXT_ZIHPM : 0;
+            value |= cfg->ext_zfbfmin ?
+                     RISCV_HWPROBE_EXT_ZFBFMIN : 0;
+            value |= cfg->ext_zvfbfmin ?
+                     RISCV_HWPROBE_EXT_ZVFBFMIN : 0;
+            value |= cfg->ext_zvfbfwma ?
+                     RISCV_HWPROBE_EXT_ZVFBFWMA : 0;
+            value |= cfg->ext_zicbom ?
+                     RISCV_HWPROBE_EXT_ZICBOM : 0;
+            value |= cfg->ext_zaamo ?
+                     RISCV_HWPROBE_EXT_ZAAMO : 0;
+            value |= cfg->ext_zalrsc ?
+                     RISCV_HWPROBE_EXT_ZALRSC : 0;
+            value |= cfg->ext_zabha ?
+                     RISCV_HWPROBE_EXT_ZABHA : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
@@ -9119,6 +9204,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
             value = cfg->ext_zicboz ? cfg->cboz_blocksize : 0;
             __put_user(value, &pair->value);
             break;
+        case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
+            value = cfg->ext_zicbom ? cfg->cbom_blocksize : 0;
+            __put_user(value, &pair->value);
+            break;
         default:
             __put_user(-1, &pair->key);
             break;
-- 
2.50.1


