Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD519CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pS-00078N-RM; Sun, 13 Oct 2024 18:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pQ-00077i-Tc
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pP-0000u8-Dv
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so1716381a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857562; x=1729462362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HOyhUsp26UJ2J8SI14m1Cw+uj1HUsjO2JpGhjMl70Y=;
 b=w5qjoMbXLUujZY1mYVUgnAHv2RtTWQpsoZBMdsLIQhkVkNg7mGOII+798J9D/vX3Ji
 wrtydsBjJeWxhmjnzcJ3xT5LQx0o68Zsy1Imr1b2oDYeE5HkWt9hxWUSSs4OvwXkeNa3
 cu604Fr2eITPWydKeXbXonRCx+jDeyJOqEdEZfetpZgaMLpaUKsMj5AhIqhDT5BHam37
 3Y+zfmeDy+UrioqAGgQsNkOPVYmJvHI11pM2OJT+NiR+Jvo8ULB5yiz1hZ0fet+zCG6j
 HRY6FrnLn+rtw3BPhjqQYXSdP9xynHAWo5UMQwsXWS45bygY2ZcCMGF01/mm0Eaig+Wm
 xpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857562; x=1729462362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HOyhUsp26UJ2J8SI14m1Cw+uj1HUsjO2JpGhjMl70Y=;
 b=QyCQfjgS4izj7NNoNL94g2XHAHfXgqGQFsreFhJ4AYMJpgZdPKnoQHK2qXniW2vfXk
 S1ydEvQngfivcaT0ep9+uVQeGhs15FtyQRmnt+D5a4uXvppF9hIb3tr+/ZBp8LpqZuHk
 krOUNizb+ozzxCKbDy8/CHud7lN16tcYol4SP/PsX5+6hUnImBUkj4cxa3QPTIKom9bW
 Eol9hi4Q0GySU4PhINhZOPNpWQfioeBOQraA8r/5utxMWEQNM/O5A4KdW9uiAOi0Ti3v
 GSDyK8gjPTJiOGBB1Q8SUKnNgpckfTh+CETtvx3QmT2VQl9LeMI3MlW4wKksSpWB9j76
 oEAg==
X-Gm-Message-State: AOJu0YzAVuRVcyLNJ7M60yYB/MPGTFJpY6mPgvzINvYJuQbKWnoz0SXD
 HeWFo2gRDNOS5V0phdS6XRHwO9zYzSuk/+edr1BPvPOWXpvVLnOYLrPx5GW5HKT6pWNReaBi9e/
 0
X-Google-Smtp-Source: AGHT+IFlPncfg6JqrJUW8elanZXQlO0zL5/swqfalZAOpHj2x/fZlpjZ5kKYbQulAnTbLG6PyL6rsg==
X-Received: by 2002:a17:90b:4c03:b0:2e2:ba35:356e with SMTP id
 98e67ed59e1d1-2e3152e1be8mr8183825a91.17.1728857562030; 
 Sun, 13 Oct 2024 15:12:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/27] tests/tcg: Run test-proc-mappings.py on i386
Date: Sun, 13 Oct 2024 15:12:14 -0700
Message-ID: <20241013221235.1585193-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Now that orig_ax is exposed and GDB is happy, don't skip
test-proc-mappings.py on i386. In fact, it's broken only on
m68k now, so skip only this architecture.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240912093012.402366-6-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../tcg/multiarch/gdbstub/test-proc-mappings.py | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 564613fabf..0f687f3284 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -8,17 +8,12 @@
 
 def run_test():
     """Run through the tests one by one"""
-    try:
-        mappings = gdb.execute("info proc mappings", False, True)
-    except gdb.error as exc:
-        exc_str = str(exc)
-        if "Not supported on this target." in exc_str:
-            # Detect failures due to an outstanding issue with how GDB handles
-            # the x86_64 QEMU's target.xml, which does not contain the
-            # definition of orig_rax. Skip the test in this case.
-            print("SKIP: {}".format(exc_str))
-            return
-        raise
+    if gdb.selected_inferior().architecture().name() == "m68k":
+        # m68k GDB supports only GDB_OSABI_SVR4, but GDB_OSABI_LINUX is
+        # required for the info proc support (see set_gdbarch_info_proc()).
+        print("SKIP: m68k GDB does not support GDB_OSABI_LINUX")
+        exit(0)
+    mappings = gdb.execute("info proc mappings", False, True)
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
     # Broken with host page size > guest page size
     # report("/sha1" in mappings, "Found the test binary name in the mappings")
-- 
2.43.0


