Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C89ED35664
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vku27-0005hZ-8E; Tue, 27 Jan 2026 20:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1q-0005Pj-1r
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:34 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1o-0004jf-HV
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-823075fed75so198194b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769562446; x=1770167246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QL0+W6HAC1hQGNc/ryikijGbESR+3UNG+gkzdL4k4+A=;
 b=Be70+g+A97H9SiqFpwg6EM1KEe5zk1R4lTaTgqEJAGGmJyStx58jpiA7ab9G87wbXo
 dsio2shDWIFoisAO90fiuqZIlbibntzlhwpfx+dBiUaruTJUyVxJJ+SZnsPemovYJTW9
 De4xaJiXW1W0uCw8B7mlECXWC/ONowDv0d+aaYGnq7GZjPmBdwzSCd62Z6iZgzZnsR2v
 q6lyvs5SaeHqKeH3rrrUH+2grwg4Rssir8dq8VToawKbR0LRw9wgMA8IsVIXsYE81Ff4
 9vwwa0HWWc7SO8nqZUxNpZaKUN9BOF3QGKy5Yg9I75SXntRMFkfxeP3kzR0HoQ7WARLk
 drUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769562446; x=1770167246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QL0+W6HAC1hQGNc/ryikijGbESR+3UNG+gkzdL4k4+A=;
 b=UbXdbrRlD/IeH9Uq7ZWNEX1pYS11jqTznO8XUZQyKB6LEMgwCRWU+aym3SmFWjKBhK
 dEO3wawxdc+rqzABK0eRbYTqEYMssRpMQknUrjrSM4nxYqwU8GyOSe32OXGV0ecuiQIk
 o7nMAa21alwGYphqEikYr4SdHni6y3JcojO7pq4qKU3Fmio8fm8IQWHN14Esujmew941
 bV4Acqk6/iX9bnczlmKGjEbdz9bXQmu1DJ3gfSFzXVxe3SLrWvPa0CvhIy5BHUq36KoF
 9nUmL5T9xv2sjHt4wdqMLzvHWGRs60RSB3CED0WI60384U0xSuNaIaj9+f0JHHrDwzlR
 A0pw==
X-Gm-Message-State: AOJu0Yy4bhP60suLUN+DUFdfY6Qpj3pw8e5huwo/Xxm45D9UEupcje1w
 Ay2+T2TKRbMNqsc9ADkuvHPVTgXF40ILqcN1OAGnVxRRuNR6aLOGvKo5KGobE9TuWZdSS5D2L1c
 hYxS9azwgpA==
X-Gm-Gg: AZuq6aK4BlkehoPqecrfOqJOWB8qjKJGIHrifE84GRJ5VNMN9YcApH+4l+HpGQqnjMc
 LmUuxdV89h5TUX/HamDt/Y8aFm92fmndCf9o65EuUIdXJ/JttkOGWtCi9axXZZkk5pxhxNzV/TD
 FcKAqfphrhyvTL6UWmORvQ6tuJnULScDDLZXSZ81HE5QA/id4xMyc0BWcoqK4YPAmJJJVr8rikw
 17/DDU6oxfWXiT0jRbXhSLI7Bp2BOV+G/w2tuyiSRdJL4V2NqCnDjKYETO8bJX0UiYKvV+PkQIP
 Qzt01DIaXHAruxfOYwqIC+pM3mYnd1IiTixKw24LDWZGv6ozzUTQNxP5wjEea97LnBvBPQg15BD
 Te6EoqV/uBVEFP0VFGJq+cJS2AOG8aj7BhpD49w4IjUYQoFVcIOSYtH/0Hu4l851lTpSLomwVdQ
 lFW1Q9A95uaq53nCLeqpnrdFjHK3bP
X-Received: by 2002:a05:6a00:1255:b0:81f:440b:4f61 with SMTP id
 d2e1a72fcca58-8236a460e7cmr3190761b3a.35.1769562446288; 
 Tue, 27 Jan 2026 17:07:26 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c53f6bsm719407b3a.63.2026.01.27.17.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 17:07:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 3160104094@zju.edu.cn
Subject: [PATCH 2/2] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
Date: Wed, 28 Jan 2026 12:07:15 +1100
Message-ID: <20260128010715.347776-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128010715.347776-1-richard.henderson@linaro.org>
References: <20260128010715.347776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

This uninitialized value violates the contract in the
documentation comment, and may lead to a SEGV during
translaton with -d in_asm.

Change the documentation to disallow hostp NULL.
Pass hostp to probe_access_internal directly.

Reported-by: Panda Jiang <3160104094@zju.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 2 +-
 accel/tcg/cputlb.c          | 7 +++----
 accel/tcg/user-exec.c       | 4 +---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 0ca13750f9..9e7be2d78d 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -82,7 +82,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
  * See get_page_addr_code() (full-system version) for documentation on the
  * return value.
  *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * Sets *@hostp as follows.
  * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
  * to the host address where @addr's content is kept.
  *
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6900a12682..f9d9697a5a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1545,7 +1545,9 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env_cpu(env), true), false,
-                                &p, &full, 0, false);
+                                hostp, &full, 0, false);
+
+    p = *hostp;
     if (p == NULL) {
         return -1;
     }
@@ -1554,9 +1556,6 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
         return -1;
     }
 
-    if (hostp) {
-        *hostp = p;
-    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ddbdc0432d..f8b4a26711 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -822,9 +822,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
     g_assert(flags == 0);
 
-    if (hostp) {
-        *hostp = g2h_untagged(addr);
-    }
+    *hostp = g2h_untagged(addr);
     return addr;
 }
 
-- 
2.43.0


