Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B623CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ66-0005Xf-BC; Thu, 15 Oct 2026 06:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ62-0005Ld-KC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ60-0007wa-Qr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQT64RPQilPvwdPb0LkD3kd7Fzvx+yQCRQ512TDt1/A=;
 b=OUrvBmlT5eZLgrcrkzMJ+Bag3+1Z/yzjAdAzpZVxKGzQgvAh3oK3H+fO+tqRkzhBN3IAu9
 a6MpSJ61hpeNSBYrtC2D/Xj6RVe6dKSXhijjqYm3FqDhH8qDJ86MogBN13gMSQbg7Sh3pc
 hi4xNIwYrxGcP8HK7hsrB+AruuYK2yY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-mmFBL7cuMaSTVJ8YwKcsvA-1; Thu, 15 Oct 2026 10:53:58 +0000
X-MC-Unique: mmFBL7cuMaSTVJ8YwKcsvA-1
X-Mimecast-MFC-AGG-ID: mmFBL7cuMaSTVJ8YwKcsvA_1792061637
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so3258582f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061637; x=1792666437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQT64RPQilPvwdPb0LkD3kd7Fzvx+yQCRQ512TDt1/A=;
 b=CQHHqS+YtiL48sHdUR9H9LsWrcL8uCsOdre3FWh0sPHWw2b3JtKlPAcFhQJknp1hc5
 2FNuOpgIAR5MB4GVCSeKBqoJqT+FpidmD2Si380JPERvgZr/uIwt+S7VKRuneFrukaXP
 7G8hs4xMJHZFaQvKru5j2NiCW6nqUZ6oAZLS7F6KJcBG6rfpLcy7rv9yJtTXsdoVTKBc
 sztwv2ODd2KJPRZM7RF8AoZ0sfDtX0Y0wBgPop5eicOd/c4cblBDKdua533WIH4/FC3r
 VlI2ULF7bS1c8xnBa9eOg1pRFBNfnta0kjAL6jEQaTyouQbmJty5P3ha2N/QKQMR/dmu
 TIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061637; x=1792666437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQT64RPQilPvwdPb0LkD3kd7Fzvx+yQCRQ512TDt1/A=;
 b=I4Jgr8ywjYo7c8xju/3V6DzQUuyacvVtA1vZSbOTNe6PhRh5TzMkv9eXAfoVa3/NkR
 6aiFm8mgy7ifmHmviV8t4bnmjo8Ne6mCWOQunUKSGA5EtF+WrUf0ZZdWTABpOaCsgseu
 QmO5PpNm2PpycQUFfTnr4d57o1lwp/cCqhMb9m/jC4S9/hy8Wlyo23v+czeojJACsFX6
 Ei483ZvfXt8nse+U5FofF1YbiaBSNg1u9vf/GHESLLNnO8rLxsSqVv8y+c/fFhTMVhyW
 T5l713xeGIxdhsuChLjtabDtV0Niiog5GPoEG1m0BgEixdLa7h22XRRc//cAs3k7xaaX
 JirA==
X-Gm-Message-State: AFq9FYLwtPrFP+aOICCp/NqTXfwyPxTJdLnhGYd6aZvQ5jBzEZyIi8mM
 HMqE8dtxQkbXuC8UQscd1xxkx0YcohWKiT2CdTw5JNqI3XM5qUSfYr8ObDb/MDDXZ0BsmDwa3fX
 6miRaE3deSFNYKD0MaJe229aIEvelcbRm4wL85YDOflVIto4YgUA6Z3b9i1oqgcuPu+qCz4A4lU
 OZpGwaJChFLYXlWfU/3JSfnsy2K2QVSqtBQMtwgGQN
X-Gm-Gg: AYBFou1evgMpg2Da9/6kYBVVm1XdFSgJKyOt+goVYpiH7MITOLXI/h1sZB2hcpX1CC2
 dtzSivwD7XpA9es4JV0ftDF+vFnyXwEykQodSan8po9gIgoktPMwsTd2Y0xKfypi2dzf6HOtfjY
 buRIjgASYmER/9FL4SuAZitYMI8E+q3vGWQvpQ08qaCUlo+fwkyA+udEr0snm+nBzl7u4+DDndu
 IRSHSx4nqPrvi54Ha823RMPPjlPYnis+nSyj9LDn38taxRAXJWQ2+mswPu9nXJCCWgV9VSZgYZw
 04iz0n1rYYTZ/k+IgEU35MIwdNtGLJBEsRoEumLMwvWzE4Qw1qXpx39WhijXzxCzdZ/iCnPRm2h
 vlgi84dSCQPiHO9wuB1OXFyuFZx/BOAV6Wva6Hp+Oo7xw/i7nPcd7l9+LvWQy4qW4GGy4veE5ar
 UB5k96
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a196611b9amr269079255e9.32.1792061637146; 
 Thu, 15 Oct 2026 03:53:57 -0700 (PDT)
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a196611b9amr269078975e9.32.1792061636697; 
 Thu, 15 Oct 2026 03:53:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm64780665e9.3.2026.10.15.03.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:53:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Artemii Mashanov <ralerrdirsardx@gmail.com>
Subject: [PULL 01/13] target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
Date: Thu, 15 Oct 2026 12:53:35 +0200
Message-ID: <20261015105347.827029-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Artemii Mashanov <ralerrdirsardx@gmail.com>

TCG's do_xsave_fpu() omitted writing the FOP field and the reserved
bytes (10..15) of each x87 register slot. Those parts of
the destination buffer retained their previous contents.

The reserved bytes of all eight slots are zeroed. TCG does not
yet track the actual FOP value, this patch stores a fixed zero instead.

Add a regression test in tests/tcg/x86_64/fxsave.c. It fills the
FXSAVE area with 0xcc, executes FNINIT and FXSAVE64, then verifies that
FOP and all reserved slot bytes are zero.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3522

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260826171655.117679-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c |  3 ++
 tests/tcg/x86_64/fxsave.c    | 66 ++++++++++++++++++++++++++++++++++++
 tests/tcg/x86_64/meson.build |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 tests/tcg/x86_64/fxsave.c

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index fb473c28f7b..4bbac996326 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2620,6 +2620,7 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     access_stw(ac, ptr + XO(legacy.fcw), env->fpuc);
     access_stw(ac, ptr + XO(legacy.fsw), fpus);
     access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);
+    access_stw(ac, ptr + XO(legacy.fpop), 0);
 
     /* In 32-bit mode this is eip, sel, dp, sel.
        In 64-bit mode this is rip, rdp.
@@ -2632,6 +2633,8 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
         do_fstt(ac, addr, tmp);
+        access_stw(ac, addr + 10, 0);
+        access_stl(ac, addr + 12, 0);
         addr += 16;
     }
 }
diff --git a/tests/tcg/x86_64/fxsave.c b/tests/tcg/x86_64/fxsave.c
new file mode 100644
index 00000000000..d08a4e8a0e5
--- /dev/null
+++ b/tests/tcg/x86_64/fxsave.c
@@ -0,0 +1,66 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * See https://gitlab.com/qemu-project/qemu/-/issues/3522
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#define FXSAVE_FOP_OFFSET      6
+#define FXSAVE_X87_OFFSET      32
+#define FXSAVE_SLOT_SIZE       16
+#define FXSAVE_RESERVED_START  10
+#define FXSAVE_NUM_SLOTS       8
+
+struct fxsave_area {
+    uint8_t raw[512];
+} __attribute__((aligned(16)));
+
+_Static_assert(sizeof(struct fxsave_area) == 512,
+                "FXSAVE area must be exactly 512 bytes");
+
+static uint16_t u16_le(const uint8_t *p)
+{
+    uint16_t v;
+    memcpy(&v, p, sizeof(v));
+    return v;
+}
+
+int main(void)
+{
+    struct fxsave_area area;
+    uint16_t fop;
+
+    memset(&area, 0xcc, sizeof(area));
+
+    __asm__ volatile(
+        "fninit\n\t"
+        "fxsave64 %0"
+        : "+m" (area)
+        :
+        : "memory"
+    );
+
+    fop = u16_le(&area.raw[FXSAVE_FOP_OFFSET]);
+    if (fop != 0) {
+        fprintf(stderr, "FOP: expected 0, got 0x%04x\n", (unsigned)fop);
+        return 1;
+    }
+
+    for (int slot = 0; slot < FXSAVE_NUM_SLOTS; slot++) {
+        int base = FXSAVE_X87_OFFSET + slot * FXSAVE_SLOT_SIZE;
+        for (int b = FXSAVE_RESERVED_START; b < FXSAVE_SLOT_SIZE; b++) {
+            uint8_t val = area.raw[base + b];
+            if (val != 0) {
+                fprintf(stderr,
+                        "Slot %d byte %d (offset %d): expected 0x00, "
+                        "got 0x%02x\n",
+                        slot, b, base + b, (unsigned)val);
+                return 1;
+            }
+        }
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 968fe27cfc5..95c7ee676eb 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -61,6 +61,7 @@ tests += {
     'cflags': ['-pthread', '-Wl,--no-warn-rwx-segments']
   },
   'fma.c': {},
+  'fxsave.c': {},
   'noexec.c': {},
   'segment-prefixes.c': {},
   'test-1648.c': {},
-- 
2.56.0


