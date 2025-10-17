Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD56CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mPu-0005L3-Mr; Fri, 17 Oct 2025 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPq-0005I8-CF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPh-00015h-A8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso4978455e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715032; x=1761319832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psius4cHlJsmBDgSNlELg8TK6nCqMNbS0nYX0Lh5t7o=;
 b=Mqiechj7ANj+AvTQHr4LtS/GbweNWhCxDkhw1/s+p6wQjwYJAXXHcWP5HbMOM5RZjB
 kEvpqRrqYF1TdL14LG+rjvKBJGsIo75NZcXh4iXJIlqhMEucVH7T1dU1iwgMbfPBCk+h
 lhN8t6uP0uvaRmnbqUnDz+3ubXZsp2+Po0zkzwhN1z1jqKslR94XMfVCbjcpCkmYjiht
 Wh5auNossL86tGEGCn+NYkHI+aGoY0C79aznKjrf1VclRp2F/VJP/Bs42h9HHFxq7Bxq
 JI2HIN+2tj5Av0DPYhQFq6dbx5TMlCDYSVlqL38mSc4E8QHPKntQ3SxBt6fmlr1aqEP0
 NYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715032; x=1761319832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psius4cHlJsmBDgSNlELg8TK6nCqMNbS0nYX0Lh5t7o=;
 b=PNDZs39H2A2YV8+tmTfzyiMfyKTE/HSQ6gJCg3lK/mnWAcK/ZRQ7VSppogfVizm1Pf
 VGxsQ+deuCMnWFQ7nEHNjsaurpr1h3EjELgWqtzuX93REg1QCe3p4OAixF0DmY2N1s+0
 H02NviDLuNT7RIf8h9j+dtwGGqTmNPNJ58NxnTFaT2GxRQgk2GZPmOBzvuwaKguoSpBT
 RkBqAboRsB5HSGliakh7jHGBCaIlGpTMHwskmGsPrZJFPd+rfx7ubxk7KuY0RCWKzhOa
 9UTDLSxTeyaztk/4NRdPjk0dN+6wEO8RpnibAt7i/FUhIuAaCLCpXmdM9IJXrpWEks8M
 jcIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgyjUOVxtBZfh1foCvJYtoko1bddiPlN7+tHjUGYXJe97+yRDwHI2A2SZyob49kjj8V5hQl+TnHvrh@nongnu.org
X-Gm-Message-State: AOJu0YyAOxY6Anw2iQPvSdXjXi7jvlDf37Vv4+bVAluHlAON81D6Z6US
 zsGNv/0Jxhm02LMA6QJjJsPMQbO+A2JBxrS8pcGWv0w9IUkLym0LQtYIUSlXhVKuIZ0=
X-Gm-Gg: ASbGncuDewa1TuHeZ30mnMsGj4UiAkKYJBqFEVYnM9Gls4Hrr/HbGRsm1+4GHQ4afVb
 cGw5Txbc8XXy8pUTF6wzZiEYaZlKEaNaGN8Jc/bTBwHuRrIWwFuFJ9Oa9lDmN8GaxHvY0d5pA//
 FLA5M9arqxA9qzoYANFUg1IxlP/9Mt1t1nyseLLFiVwKCV+Tm3jlfDNp3aOK+OcvaZpvFQyPadL
 ZwUOqHSaJnbUQRjgrbrZnWmAXd9ql2+cdyv6zDX6Qo090+PlkZZTBBRKCiXkgUtY5npnD4J53tE
 ObBXE6pcpkFH6w/9cXRZxmozUo+Ro5q+H0ChL0Vg+7Fo25Y4FH9m+fSMNhq1oGoNZ+8cKluieFt
 IMNHn7Sf/wDfOWs7SeObEZb+Njtxjy2mpu5JR2clb0ZaOpSvh++hf61I5ALSgsdcjYykLAeGAlV
 /qOrBMNg==
X-Google-Smtp-Source: AGHT+IF7jINcGz/mkOYP+Ez6vnPD2vp8sCWWCPL2D3TgUpGrrXYwcdETQZlw+BdyZFjiSAli3KQBEg==
X-Received: by 2002:a05:600c:5026:b0:470:bcc4:b07c with SMTP id
 5b1f17b1804b1-47117925d38mr35605855e9.37.1760715032157; 
 Fri, 17 Oct 2025 08:30:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm85038635e9.18.2025.10.17.08.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:30:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v2 3/3] tests/tcg/aarch64: Add test case for SME2 gdbstub
 registers
Date: Fri, 17 Oct 2025 16:30:27 +0100
Message-ID: <20251017153027.969016-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017153027.969016-1-peter.maydell@linaro.org>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Test the SME2 register exposure over gdbstub, in the same way
we already do for SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target      |  9 ++++++-
 tests/tcg/aarch64/gdbstub/test-sme2.py | 36 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 55ce34e45ee..9fa86874534 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -164,7 +164,14 @@ run-gdbstub-sysregs-sme-tile-slice: sysregs
 	"selected gdb ($(GDB)) does not support SME ZA tile slices")
 endif
 
-EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice
+run-gdbstub-sysregs-sme2: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme2.py, \
+	gdbstub SME ZA tile slice support)
+
+EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice run-gdbstub-sysregs-sme2
 
 endif
 
diff --git a/tests/tcg/aarch64/gdbstub/test-sme2.py b/tests/tcg/aarch64/gdbstub/test-sme2.py
new file mode 100644
index 00000000000..a1663fac658
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sme2.py
@@ -0,0 +1,36 @@
+#
+# Copyright (C) 2025 Linaro Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+#
+# Test the SME2 registers are visible and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Test reads and writes of the SME2 registers"""
+    frame = gdb.selected_frame()
+    rname = "zt0"
+    zt0 = frame.read_register(rname)
+    report(True, "Reading %s" % rname)
+
+    # Writing to the ZT0 register, byte by byte.
+    for i in range(0, 64):
+        cmd = "set $zt0[%d] = 0x01" % (i)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+
+    # Reading from the ZT0 register, byte by byte.
+    for i in range(0, 64):
+        reg = "$zt0[%d]" % (i)
+        v = gdb.parse_and_eval(reg)
+        report(str(v.type) == "uint8_t", "size of %s" % (reg))
+        report(v == 0x1, "%s is 0x%x" % (reg, 0x1))
+
+main(run_test, expected_arch="aarch64")
-- 
2.43.0


