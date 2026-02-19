Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D34E9A05F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ce-0005Qk-6q; Thu, 19 Feb 2026 14:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bI-0002oR-7R
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bG-0008As-Lq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48371119eacso12117305e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528927; x=1772133727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SDQ1L6BuuAO5wqEwdTuhkDGVq6EQ0d0AnGhnbOHbh8=;
 b=HDfLowBJKYKX8KYWEWlF6l+hzaMO8Ch6SqfpRMay17WFL9lVpns9sWZKw7PgXqcRXF
 0MxqMFZuMMqJa2o2nbqu46XrIyjsIVmx78KVVCDqMifr2MO5suGt6pYx/scv+T9aTXdd
 c0q4M8VTc6gXeMiU3j/dN9PGcT7L1s1Gw+iTwlysFIw/jThZaM17IZM9755XvGoha8MJ
 WgArhPhk90adrHTy2mjbWMQuM5mjqNWc0B5rBU7PpHKgZRYuPb2bz+aBV4vMJfnPiHBA
 Wr7TQFyNOC/6WV9v3M1H6KKWUs5vLOOqLyno05rbBFQNolMgm/WhP//F6TzB7IBedw5g
 JoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528927; x=1772133727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9SDQ1L6BuuAO5wqEwdTuhkDGVq6EQ0d0AnGhnbOHbh8=;
 b=Wergl/eEwSzqQHlMufkwvfWmq1j/8nlOg61aBsPtr5bebYWnLueGQoFb5fxmzRT44y
 4oM0iSOs3VWbnj3O8uh9N/3Kt1dVNOb16x6Q9VyeL11gQ+CvfJmBbTc+2ewFvJVOIGJG
 CHAlwPIPx2NEsYC2n1SXKa8FVxalQ37j7vNPY6LQAsDxRK+Ey7UESSAD7qpy2OuwQs89
 TWf5ORxE3VW3tSLq9N7k8+4/OFNnFkquf0w0IlN9kAHnHadZYczgkyztgox1FeXNAYvM
 wv9jhWiQufVTmBsFXJUAAmLJbwj0kgxh+IgFYJL+mS5NCPre783dLnn0Lsvi4sA5/LCz
 C+Bg==
X-Gm-Message-State: AOJu0YycHsd8UA/tjHb4M/jYRqwHMGp9U46NMPAXwNghrYMQ6XmXaJ3T
 VWd/jI734aiwRu8DPopsGvabV+GhjxRIIiEvas/vvAkDKvLt+u7McVpMJcHFQyMDID2wabAP3OX
 Xbc0YXGm0Cg==
X-Gm-Gg: AZuq6aIZuqzI+lqHjb1y0coK/vmn9xS3pdmwv/G4n8uERkoML6LpBtWWewzN4xWg5zi
 uiC7xPMO1ciRvIpkPP/gXfbqs1wEGM/KqiqbERvgmZ4nx9P9WHnjWz/XhqCLbGOW6EhV/uVqn9i
 HcFggdeyBWSUnQjrQFsf/vw0l0G7fW2iLEHZgt3uIx1xPPAAra+z4dEw8RguqCGTx17KBcTBYDv
 UOoIYd4NL675Br4sE0g+3wiDxHNFbKWvSUcWQV49twyXfume6KqBCVFJmI8Brezo76/wkXqHRVo
 29VGURdAoterxCCb5ifP/FgXvKRh1lRP2jVs7ebj3NIFnv+mbzl2lngoU0pKgkdtK+klLowqmg5
 ZaLCW6A/2uUze87JCow/JPYTrdgh8FxIWu28nbzIDiJYYlyVOhL5ES8MLnnUrG/ndptyusURc3r
 Bz77vTd2Do/6vtkk5UhL3Tc3zv0SOKQMBRUGnGe/cLv4T/MpOXU2M1bj9fWEAUqHtL4YdppkOTL
 oumfdrc5Nc=
X-Received: by 2002:a05:600c:3e0c:b0:480:6b76:dfb4 with SMTP id
 5b1f17b1804b1-48398a65eefmr97540905e9.8.1771528927256; 
 Thu, 19 Feb 2026 11:22:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bac27sm23830395e9.5.2026.02.19.11.22.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 18/50] target/i386: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 19 Feb 2026 20:19:20 +0100
Message-ID: <20260219191955.83815-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/monitor.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 99b32cb7b0f..446428602ef 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -602,46 +602,7 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
 
 const MonitorDef monitor_defs[] = {
 #define SEG(name, seg) \
-    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_I32 },\
-    { name ".base", offsetof(CPUX86State, segs[seg].base) },\
     { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
-
-    { "eax", offsetof(CPUX86State, regs[0]) },
-    { "ecx", offsetof(CPUX86State, regs[1]) },
-    { "edx", offsetof(CPUX86State, regs[2]) },
-    { "ebx", offsetof(CPUX86State, regs[3]) },
-    { "esp|sp", offsetof(CPUX86State, regs[4]) },
-    { "ebp|fp", offsetof(CPUX86State, regs[5]) },
-    { "esi", offsetof(CPUX86State, regs[6]) },
-    { "edi", offsetof(CPUX86State, regs[7]) },
-#ifdef TARGET_X86_64
-    { "r8", offsetof(CPUX86State, regs[8]) },
-    { "r9", offsetof(CPUX86State, regs[9]) },
-    { "r10", offsetof(CPUX86State, regs[10]) },
-    { "r11", offsetof(CPUX86State, regs[11]) },
-    { "r12", offsetof(CPUX86State, regs[12]) },
-    { "r13", offsetof(CPUX86State, regs[13]) },
-    { "r14", offsetof(CPUX86State, regs[14]) },
-    { "r15", offsetof(CPUX86State, regs[15]) },
-    { "r16", offsetof(CPUX86State, regs[16]) },
-    { "r17", offsetof(CPUX86State, regs[17]) },
-    { "r18", offsetof(CPUX86State, regs[18]) },
-    { "r19", offsetof(CPUX86State, regs[19]) },
-    { "r20", offsetof(CPUX86State, regs[20]) },
-    { "r21", offsetof(CPUX86State, regs[21]) },
-    { "r22", offsetof(CPUX86State, regs[22]) },
-    { "r23", offsetof(CPUX86State, regs[23]) },
-    { "r24", offsetof(CPUX86State, regs[24]) },
-    { "r25", offsetof(CPUX86State, regs[25]) },
-    { "r26", offsetof(CPUX86State, regs[26]) },
-    { "r27", offsetof(CPUX86State, regs[27]) },
-    { "r28", offsetof(CPUX86State, regs[28]) },
-    { "r29", offsetof(CPUX86State, regs[29]) },
-    { "r30", offsetof(CPUX86State, regs[30]) },
-    { "r31", offsetof(CPUX86State, regs[31]) },
-#endif
-    { "eflags", offsetof(CPUX86State, eflags) },
-    { "eip", offsetof(CPUX86State, eip) },
     SEG("cs", R_CS)
     SEG("ds", R_DS)
     SEG("es", R_ES)
-- 
2.52.0


