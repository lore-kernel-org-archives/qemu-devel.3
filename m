Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A661C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG8-0005w8-Us; Tue, 30 Jun 2026 23:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFu-0005gy-Nz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFq-0002oB-Lk
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:54 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c821a50615so953575ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875089; x=1783479889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=453lJLYfSza/GUfaKZX+AmJfUJI+W0lWC7DD9POCfCA=;
 b=DbkmgQhsTPiN93TarzKWntJgDzmm4sYiXLRapZHfGq975of//2F4//tiP03XkSCdtR
 6BH6LvoTFOHEM47WjDdvrvbIiBEDTgXu7hs+vf6AF5a+P48i7SCm4nM5tzl/DxolZvmr
 /NMPI2fHl3pOd+ARyQd6nuE5C4QGLHeSAAMzpj3TPrEIEYRpOhK7uSoxEC0GwRP+9zdL
 kscxxJCjwopFOA50ysadiWwznjy8iaV3I75XVDN6pu6N5O996bHgoZQxrJnD5tBvb8cE
 58FYxw3932D+7LX9v6nLTO3B/lQWV9BxTDPnRJvW0j87gFwzBLrDOl4uggE5F2zMwoiW
 wyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875089; x=1783479889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=453lJLYfSza/GUfaKZX+AmJfUJI+W0lWC7DD9POCfCA=;
 b=laKAKQJ7KAm4/psvKAhKN/OHlhO8VLoHnbZxiUCJjKSzk3SfjN5QD1gwDQh+HZyNGE
 T9+GkcQhkd0V+UianmdJE4V6gF5vUNdMm0cxdjv9Iueem1M1A936/7R87A8fckfUcP8M
 6xLGlnF42UcSopTegSLBHOvKqOEu1tfqJ4Rxz2gnshX570bdkpctofihX04NzLEG0W+A
 9gUbdt+JOVcjoSmb24FC1fVa5uSfiaN/BWxxArpOFtZZmAqrmb2duAsAOD5p9IVCy2H/
 OPgbOQJq0w+eLBquTS1nNW5i24t1UWnOZDy1YBRUDqLjNPxeifrWLN2lsn0jxQ2I9OuF
 0/NQ==
X-Gm-Message-State: AOJu0Yz6NkGvOHOAZg5xJAAzbENVvH3SfTEWPIko5Fk3PksPHu0dSlFV
 CqwmXeVypR/moFvMpowgikfkArtQG+F32nQLo1rSZLNdV+CRoBHFuQNDyF+JkTUnAkrBj7MjO9V
 hJAUm
X-Gm-Gg: AfdE7clq9uwmIi1z+08BoElu7OVDvZyRJuP496nNP7KZqkCCL18I88celJYftClg1JB
 r6Yx+QsRlmco1jk8M9bsebSLKZdXXXLtjZqf7gXKUDkg4LshgOsv8OcYXLVlzl07qnoZiBQH+n2
 yUzxOA2s3Qr1TSGgmAF0LbXoJXT/QhElBkOvvCTSNwj6VHOYs4/SyhYlRJ2SANiKExryAzlfrww
 9iRhucS4iwScyJKKQzX95y39mMQp7ZkK4rz8nu8kpH5Lm2YLTziAwuQDByXCr2zB3/9eVyCFOIO
 ZtPsK9y9rwZ5pszQyXhQOa+YWnbfwaFAUQbKyA5kS0adEWNR+16b9pFGVqdGRXKOLXjKZaVu5ee
 SL95meOPElzBq0QaeY8i9t8g/0tRcwBbt7wVta+Z4ZE6mfeFIyEEpl9aCx3AYZn2jQMK9bQr3i0
 Wbi3uGlYcllnttwHwSPCLEy/mRn9WFDhqkeeB3ae8iKrFf/DpVZQ==
X-Received: by 2002:a17:902:d549:b0:2c9:e5e6:8621 with SMTP id
 d9443c01a7336-2ca2e718688mr54455215ad.25.1782875089104; 
 Tue, 30 Jun 2026 20:04:49 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 05/17] qemu/typedefs: Declare CPUBreakpoint and CPUWatchpoint
 globally
Date: Tue, 30 Jun 2026 20:04:31 -0700
Message-ID: <20260701030443.1382447-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 8 ++++----
 include/qemu/typedefs.h   | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 4013d9a07c..fc91343875 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -26,20 +26,20 @@
 #define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
 #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
 
-typedef struct CPUBreakpoint {
+struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
     QTAILQ_ENTRY(CPUBreakpoint) entry;
-} CPUBreakpoint;
+};
 
-typedef struct CPUWatchpoint {
+struct CPUWatchpoint {
     vaddr vaddr;
     vaddr len;
     vaddr hitaddr;
     MemTxAttrs hitattrs;
     int flags; /* BP_* */
     QTAILQ_ENTRY(CPUWatchpoint) entry;
-} CPUWatchpoint;
+};
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182..919fe8ebff 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -39,9 +39,11 @@ typedef struct Chardev Chardev;
 typedef struct Clock Clock;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUArchState CPUArchState;
+typedef struct CPUBreakpoint CPUBreakpoint;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
+typedef struct CPUWatchpoint CPUWatchpoint;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisasContextBase DisasContextBase;
-- 
2.43.0


