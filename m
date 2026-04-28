Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECFFF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHepD-0003RL-E9; Tue, 28 Apr 2026 05:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHepA-0003OF-KX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep8-0007RH-UJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so94716485e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777368825; x=1777973625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXWD/d404r16/lGHqQwmu63U44AcHTbqHQeSLN0NHAI=;
 b=nT+It1a1NmzL5tgvnPl0Ws9vdE+3uU38SVqRmpVigU31XRS7NnI5dFI7T24F5QwSGv
 yZQckBjx48vYaJGGWUmRJ6l4lwf0jjit4rcvMpoMWcW2VuiebF+qZEJDSRMtrXXYJg6Z
 MmDthAdQ69OoQ9LL7wYkyNUlH/HVNqjoO/rKfelwSsXVhIhHNKKA5eryY3Dj0tL9C3gP
 TuDJ9b63/x4RTlsFXyrePFXzF/JVOI4U7YUM872mBoF5u/65yTdMkNK+DToqHpYe4oDn
 ywaScH1j3fxvP44GKcisinlBpERugJzSGOoPItcFldu55J69XiA7g0ASScwjfpqVxxTx
 tdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368825; x=1777973625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pXWD/d404r16/lGHqQwmu63U44AcHTbqHQeSLN0NHAI=;
 b=dawTawO7Zs8L86BGhf0lqRNgilA15rMcM6VbxZ+77Eox6AjkvUspR7OxXzOj+KBK5A
 DL0kYJiiexrup+Zdb3lzsRW1GEzAwzImq2WXLjhN3phSjoP8m4PYuxTWC+iQaelczyCJ
 n4fzx7UmNzmPzHtU30TmJvs5iP5lpN1JGgK34trPWwdDgxjpNlLFMGpb4vQoddIx0VGX
 e/1U0UxgFsnE6MRY39PmHd8B+p3zfzyZGcCqQK5ZgSLOLa+qgUA11jHqV3kmAUurslKd
 nPPiCZq3vYTPBsPHDnCvPKDgP3A2XylVjeMNcvifQrKzOHN+uoRFEUXoXDkqs8dqHlmd
 IBEQ==
X-Gm-Message-State: AOJu0Yy41gC1f1OTyilHxrcvjP9DWYG1rbRfM3qCyqlUZ6A7+pOKB3WH
 quKHe5jWUctoNZRHa9WYWU/GSMA1bijXFgz2d+K1yaH5aMCRnOV+2UzidILbyKSh4nbOZKDz94C
 dyh+W
X-Gm-Gg: AeBDieuC668GDTznX2yFOMyHrjZJtcA/x4g4Pez6A+TDxFS1WIeKl96T2mWNZHMHdUM
 3vH3AP+29+FMie4YUqO8i0d5zCa2boydpBWfhx9nsjMUpxR30ywIzvYb6CzANZxTbyveyqFKrqg
 oG+mRbk2pYyE4NUaANIpi/qKyvk7XMsTzoqBAHEc4l8LHb41ZUeHEWCAoZQMMSdkoii0s5IjHyt
 vS9gRaakPm66po/e137VG6QZ2190UMpciq33216Cko2XpV5KShMxMvAzWuB7cIxud56hOEGrgBZ
 DSexLf5DdQ4/KaCUk4gP+Xc+wG4AMosbi59uOfLMXh10FDU2ZCOCPlvmrQR8Cv72QgSbmkXapfk
 aOIgaCCzehqbz8rSmQ6lzjpZNBO14DFvs3x4PZr6HN1gP14TsMGrAR9SU/5xsBttQXF5+0gNtwD
 B4gDbcfNIRFW2nKx5m5YKaX+Z7vgfjoxCwdbsoCfLQIpzOcrAGfgfGffWeRz3hBfrhIogukiy5j
 3106o3u29aIa30E7vWdtacc3U511F7AtlU+8EFRlC4SSl2fvh9L
X-Received: by 2002:a05:600c:a311:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-48a77ad59e2mr29036605e9.4.1777368825499; 
 Tue, 28 Apr 2026 02:33:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d7a1fsm19665595e9.4.2026.04.28.02.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:33:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 3/4] hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl settings
Date: Tue, 28 Apr 2026 10:33:38 +0100
Message-ID: <20260428093339.2087081-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The xtensa mx-pic interrupt controller has a rather odd register
setup, where some registers are 32 bits but are decoded at offsets
only one apart from each other.  The QEMU implementation handles this
correctly, but it did not set .impl.unaligned = true.  This has
worked up til now because QEMU has entirely ignored .impl.unaligned,
and just allowed through unaligned accesses when
.valid.unaligned is set.

To allow the possibility of properly implementing synthesis of
unaligned accesses by the memory subsystem when they are valid but
the device doesn't implement them, and for clarity of intention,
state explicitly that this MR's read and write functions directly
handle unaligned accesses, by setting .impl.unaligned = true.

While we are adjusting the MemoryRegionOps, we set also the minimum
and maximum allowed access sizes.  Since the only way to get at this
device is via the CPU's RER and WER instructions, which always
operate at 32-bit sizes (see the HELPER(rer) and HELPER(wer)
functions in target/xtensa/op_helper.c), we know we will always get
32-bit accesses.  Specify explicitly that that is what is valid and
implemented for the MR.

Add a comment to clarify that the hardware behaviour here is not
"true memory-mapped registers", so the odd-looking implementation is
correct.

Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/xtensa/mx_pic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 07c3731aef..098c1aaf85 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -69,6 +69,26 @@ struct XtensaMxPic {
     } cpu[MX_MAX_CPU];
 };
 
+/*
+ * Note that decode for these registers is rather strange by the usual
+ * MMIO standards -- the MIROUT and MIPICAUSE areas can be read and
+ * written at 32-bit length, returning different values for each byte
+ * offset, because the low bits of the address are treated as selecting
+ * an IRQ or a processor:
+ *
+ * 00nn         0...0p..p       Interrupt Routing, route IRQ n to processor p
+ * 01pp         0...0d..d       16 bits (d) 'ored' as single IPI to processor p
+ *
+ * This is because (like x86 IO port in/out accesses) the offset is
+ * not a memory-mapped address but is really a register number,
+ * accessed via the Xtensa RER/WER "external register" instructions.
+ *
+ * We set .valid and .impl to both allow unaligned = true to permit
+ * these byte-offsets. Because this device is not a true memory mapped
+ * device but is accessible only via the Xtensa RER/WER "external
+ * register" interface, all accesses are guaranteed 32 bits.
+ */
+
 static uint64_t xtensa_mx_pic_ext_reg_read(void *opaque, hwaddr offset,
                                            unsigned size)
 {
@@ -267,7 +287,14 @@ static const MemoryRegionOps xtensa_mx_pic_ops = {
     .read = xtensa_mx_pic_ext_reg_read,
     .write = xtensa_mx_pic_ext_reg_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = true,
+    },
     .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
         .unaligned = true,
     },
 };
-- 
2.43.0


