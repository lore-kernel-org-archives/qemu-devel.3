Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FACCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSi-0006xY-FA; Thu, 02 Oct 2025 23:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSg-0006wk-VB
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:02 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSZ-0001Ar-OA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:01 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b5579235200so1214732a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462068; x=1760066868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYZEn4Qlzj2gbnJ1DtcpctrDhZQYl+eUbKGI1NSZqkk=;
 b=GHAUq9Wrhk8XUq3QJobpS12XBcygbqZAEVAqjtMquUkmdg3Qm3+XdnCIwqC/0gxder
 VnIeDMFXLFyjpBBrLkmeqMGZPEWDLjY+K5mn1HfEx5bovdNVDnH5V8QklQT/UaEP/lWf
 JXzyHIpGfYZuDyLVdCtjA6my6e1TjavUVm3gJTmE4/LaSIEzlaD3aOs2uAfkCYugbyvB
 C2zCph+tRfQJWzxMcP4RO1xOYvA+pIXNVbwHgHwUQ7Ue+PD+Tg6LGOHBNaXrY1Q6r15z
 WkuK+bWtmgWso3FZ8Es5f5IdFbf33TBC5KsHhYYskpMWxXF4f16rW4cwm/Cs6Apu/nWZ
 oz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462068; x=1760066868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYZEn4Qlzj2gbnJ1DtcpctrDhZQYl+eUbKGI1NSZqkk=;
 b=PdDHfiKwselN1gOpbEwLKuSABXRQPLtUVPz8KAVDf8DmNgB9M5goze+vTKQKqn75qh
 a9oSts25emPhwWHbBL1M4OtjdUDHU1OmQDwR93+zHbnsja7oBx+J580bNnkC9tjdP8Nf
 e6h3XD1c0PhqQQ4rn52zg9zx/vSImzUtxD3qYsDu6ipLm5+fEKFUwrgiBLBt0iMg9Z8I
 ZGCynCmb8JwImhqVOCYdzS0CESShbkvnlqOZ1dQaP7NGweXsJljdbJ1Vh3sCI//f8+fc
 yMUInMSFKtZb9laYS55RnXUEjcmLaJDascw8ISFZmtkwfY6Pv/jqTUPC90ke/PyBqIyI
 Ej1w==
X-Gm-Message-State: AOJu0Yzou74CFZQu2UJny6gfAgILmszoDDo9QpDwwOV7zTNcseLG5bH2
 k+HVxRRtiqIVHAaHZSt30k3R0SeoESPIvVSfWdxlPR5RBLOoZjOlNUtLh6SmSA==
X-Gm-Gg: ASbGncv84GkKTArCiiIJE/g+L8T/M5KWz5f5tvgI0zKZ8/8pb87H2Tgiz60ddLoOsPt
 q2DjXCdnXO/cx7dBpQ4S6fzLKClFlV5Xd2umjzT+DzLk9Uh2ZmCDLdrXrgQVHMd6UrilRE0wZnR
 fqCImHwr6j/TKOGMLU4yQoB5vdZgvOnirGLC6+Yz3l26hLDDmxBFdOreE0n+qZOArUOKkvs/WwW
 aY9hyAIQJ0ccgjFlrWQiuhlRnToiH2hkreltNjylkrlLC1DGnmTibXe8y780yOk6mci7xiwrVX3
 GkZv3WWhwtOBkFA7LaUdYmRekgZgNgUzmcPSjrbw3kcszCa6L05Cbcm/tnbw/JVL1X4lZtBTruq
 rBk4u+P2b9T7ZL8LCk8rQaWMfEllQ4OietcHvNYDouMpQoEvCc2kAX1mfy9lh84zHIBnP4cDtHn
 DS355bVLyeskx7ZFqiu07tIrP9hU9CfwrR4cRjXTBnSUxFPN7hMedK
X-Google-Smtp-Source: AGHT+IHbgp6enGLlg8IoUuuWSD2AYZlUueIRiTS5wE/mAP2s/gfXHK7zsJn86OJrNEDWR/56jUVynQ==
X-Received: by 2002:a17:90a:e70f:b0:32e:e186:726d with SMTP id
 98e67ed59e1d1-339c27a1901mr1519142a91.31.1759462068034; 
 Thu, 02 Oct 2025 20:27:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/26] linux-user/syscall.c: sync RISC-V hwprobe with Linux
Date: Fri,  3 Oct 2025 13:26:55 +1000
Message-ID: <20251003032718.1324734-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

It has been awhile since the last sync. Let's bring QEMU hwprobe support
on par with Linux 6.17-rc4.

A lot of new RISCV_HWPROBE_KEY_* entities are added but this patch is
only adding support for ZICBOM_BLOCK_SIZE.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250903164043.2828336-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1a5f2a03f9..d78b2029fa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9023,6 +9023,29 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
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
@@ -9033,6 +9056,22 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
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
@@ -9141,6 +9180,52 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
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
@@ -9150,6 +9235,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
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
2.51.0


