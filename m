Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB70C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmr-0004Jk-Rn; Thu, 15 May 2025 06:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmo-0004GI-3j
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmm-00086Y-4s
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8367505e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304754; x=1747909554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7QtsMbWF7VE6Px6bLjp5onVkzczQnDLHxWTCi6gF8ps=;
 b=vL7bC4/5r4i4GuqhwXZAXFaO8mc4/35wlFZbZmipaYUfnxSsRePslhPubL8L/wUmG3
 mMJBlu8qF5B9K+t7YZlJArdH/z3CiGUoeWVpIpfASOOsnffVrlK+yKmJBsJKMdZrA7cM
 J8JOCTi1XUTDqZMq1RCHzul6DCrN7mVJZrZVvuGdsWU30cr0e8YiUqSE3dEoPIP8t8PG
 RlI7+n9yy4munKFjcyr9fmOvALOHG752xKShBg2eer5pW//2Gv4wRUJbJXtAMLwj7Uvk
 7bdPhcQfmG4RY/uNB5sqWu0fL54idCtS4DqKi4egkgslKG/xWEZGWk8ItPn4WvqRYjAL
 +Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304754; x=1747909554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QtsMbWF7VE6Px6bLjp5onVkzczQnDLHxWTCi6gF8ps=;
 b=xPLS48LPGzn3Or7SGSnSZVjBu7imMkk0xOu2vh15adqecLdZc8b5z7EXsT9weCeGzF
 vV7bUlZmmPuyVOi0YGcGtchhp4uCRVbJ6Je0JajKSf9J/dzA8N1VMuWsmkAtog0v1NAD
 wBD3izE4ZA1OOfneWkgH6wq6FvFJb1ukfOgiR4c3RbNVIFhBxGAKyrdA33jT7UN6sAJY
 nmkhZ1t1ZOp/b/S6ZyX9GILkRpMl0954a2RfKlz4uB5Jql98/0+BNhfvToQu9sGOKb3H
 ihACtk4e//GHJKlG9gfn1tMu66zbeNp2hwZ3FRG1peAAMcjzkmQ+GoWYQbrzouXqVScE
 maZQ==
X-Gm-Message-State: AOJu0YxMiaRyxd1I9qNSSfSOI3cBKo1ee0hgENqxMrngFbeRtL9FqmQs
 hLX8dCygNcnl/PB3WTxifpy8VMAYCiN74TcmW7GtKsgi9ynedF62FpuNO4fHKiUIpQXhDr2SWsN
 +iMQ=
X-Gm-Gg: ASbGncskAT4iqAbY0wXxF8zH5I2CbD2ozhQKjQbSLacT/S5Aa73N2y6b2hUqFilg8pE
 5LU3RJQWczEk1hOQ3Bsz/zI/vv1In7zEtoTK3klE9EaA+9tDYQisTy8QiQ0B2v2bmYxziwU2Lc+
 7v/KtVRn/9vnQ/Y6qWr2FAVG8rfpUTYan4ReRvcnOzWCXOf0gIyGXoMMqVY/V6AVKikQftYT4XE
 0WpBrWPF12L+cZuDfCVgL+ooazExywrn/sHDmceubwcI558joaraR2kSzwdQW0H2uSUif7TwSWC
 m9kHQu3YhehgBKjw6uuCAZe+doD/uNs93zJ1vD0vyZiKWRBJtr/JTVSzcg==
X-Google-Smtp-Source: AGHT+IHlFbT0p+7Se7sYBLG2Ww4KJIDgkIg1oh/aojKGaXwTeHLZ0RPSWnuba1h4Zylawr2K8dIRqw==
X-Received: by 2002:a05:600c:83c8:b0:442:f485:6fa4 with SMTP id
 5b1f17b1804b1-442f971924amr21742645e9.31.1747304754143; 
 Thu, 15 May 2025 03:25:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/58] hw/core/cpu-common: Don't init gdbstub until
 cpu_exec_realizefn()
Date: Thu, 15 May 2025 11:24:51 +0100
Message-ID: <20250515102546.2149601-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently we call gdb_init_cpu() in cpu_common_initfn(), which is
very early in the CPU object's init->realize creation sequence.  In
particular this happens before the architecture-specific subclass's
init fn has even run.  This means that gdb_init_cpu() can only do
things that depend strictly on the class, not on the object, because
the CPUState* that it is passed is currently half-initialized.

In commit a1f728ecc90cf6c6 we accidentally broke this rule, by adding
a call to the gdb_get_core_xml_file method which takes the CPUState.
At the moment we get away with this because the only implementation
doesn't actually look at the pointer it is passed.  However the whole
reason we created that method was so that we could make the "which
XML file?" decision based on a property of the CPU object, and we
currently can't change the Arm implementation of the method to do
what we want without causing wrong behaviour or a crash.

The ordering restrictions here are:
 * we must call gdb_init_cpu before:
   - any call to gdb_register_coprocessor()
   - any use of the gdb_num_regs field (this is only used
     in code that's about to call gdb_register_coprocessor()
     and wants to know the first register number of the
     set of registers it's about to add)
 * we must call gdb_init_cpu after CPU properties have been
   set, which is to say somewhere in realize

The function cpu_exec_realizefn() meets both of these requirements,
as it is called by the architecture-specific CPU realize function
early in realize, before any calls ot gdb_register_coprocessor().
Move the gdb_init_cpu() call to there.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250429132200.605611-4-peter.maydell@linaro.org
---
 hw/core/cpu-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 92c40b6bf83..39e674aca21 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -234,6 +234,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
         return false;
     }
 
+    gdb_init_cpu(cpu);
+
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
@@ -304,7 +306,6 @@ static void cpu_common_initfn(Object *obj)
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
-    gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->as = NULL;
-- 
2.43.0


