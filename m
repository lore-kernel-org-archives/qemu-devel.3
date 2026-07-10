Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC00C4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIGj-0004FM-23; Fri, 10 Jul 2026 16:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFL-0001wx-8L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF4-0000oa-Bi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8484a0b998fso2000788b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716867; x=1784321667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FgdeNV+kSDtwWzzSUG7k6o21nzzJqi9iKyuHEyE17qI=;
 b=wsQ5gUMkRhKZrcAVRFyM8sA0bqo/bh0We/ypT2qhV7AJsu2bjgkqek/92kC6ZWOtCz
 uaDgOxdeRXVUKnhLwFRNFYNO8JQr9FLJs53bouWZR9d8WSE9jUbMURkmpCVvei5whd3l
 lAdO4YFqOyyvrhGKYTW/5spAZyFp+sDepkH+LU36JsqCJeZn9QLgiERzNbdXA4JmUAA0
 fFJJdPtqj5LeUctC03bKC5m8BG9aZxTfdylycKMmUk8BX5wac8JmtZBdTDHsUR6DRUD+
 fhNh620W3BEAqZBriqjoenzDszHDMCFhyo/7gNMI6CpwcGHEIm78JSSTliv0YuLfl2N6
 uRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716867; x=1784321667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FgdeNV+kSDtwWzzSUG7k6o21nzzJqi9iKyuHEyE17qI=;
 b=Rn9TXPN8mIqjLLIkELWZaTWuNcsJS8HHQ1JjlvjRW6zrVZ82r1Wb/4IZ0FqC73Os23
 F1ka6QxMwGaLhTOwaD0TnmXYHD0xcJSZ2escgXTor1OT/rAudVWXmPnKlnR+KECr62wP
 6I2BEgK9hSIX8RAjSMKTk1KCQLJj9gLRsjw6alvLQoovEBRGu8VdUvlftBWRWGYcZ1mt
 yAlOrZh4z8Sltso0/XcmAcIgFpi4UlyeLOg6zJuEuMCrhFZ5PSjrJXfdV1Ecfo2Tnkky
 NQdQNMkg++ZSKwkghY8Xvf7oAru1DxCJCxNX0RJ3KixluBMI7+V6JnlM7iT7Fg8HFvol
 7H5g==
X-Gm-Message-State: AOJu0Yy0zAZ7KWVRkGj4abUit1nXkUAT4l8zNi9d7ByhJ+IDolKPPS72
 OPHMRea+WN8ycRfizeg48jEKw9PHZnnaBdg0QTLCYdT9nZDghNSdciykfrgBkbXNc+fbY6AhUGI
 G01Bx
X-Gm-Gg: AfdE7clJGjwnpQ4K5c1C6nHaxyuxGHfTOIdzF8azamUmQGrbbAEkEhMS9ghDtEaApY+
 o3e7CRv6CO7K3b8tGQkLdMpAVHBGakTfcyZsBoUr9jgN2N0k95C1gV/6LTLhMENUVj7MiWIuojh
 OaTkpTfXXK5ycMR6oIzi07VENrkS0uOmkTaBzPwa7jeiQja++7gMPLcLRXoUZjgY6AOdh4Tk8W1
 0LpkH4PsCJ/J3LJKq3veG4dfIL4/m8O15VH/eqYqtpR3DiLnmyZx2wzy1HAU+Bk/QDy62lJWtVF
 iCqnl9pUixk4FDbSBB9k8QJXhv9wta+b1HjDw2g0IXqH+N++iAl0KySZMs8oEJ7g8xum5UAYLKp
 loHlz31XeeAxDGlb05p/qWZUVPXTwoQ9NKqi4WnKiqou7fNF9PYTd6fVMeyp9PM7VxtK3JTX8YL
 yfYlZZJSaVPeRA9PAaKw==
X-Received: by 2002:a05:6a00:98c:b0:845:e432:e93 with SMTP id
 d2e1a72fcca58-8488970af5bmr490069b3a.48.1783716866766; 
 Fri, 10 Jul 2026 13:54:26 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 22/51] system: Validate flags in cpu_watchpoint_insert
Date: Fri, 10 Jul 2026 13:53:32 -0700
Message-ID: <20260710205401.836304-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Flags must watch reads, writes, or both.
Flags must specify GDB or CPU but not both.
Flags must not contain extraneous bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/watchpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/watchpoint.c b/system/watchpoint.c
index 183b194403..fbaebba7cf 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -33,6 +33,9 @@ CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
 
     assert(len != 0);
     assert(last >= addr);
+    assert(flags & BP_MEM_ACCESS);
+    assert(ctpop32(flags & BP_ANY) == 1);
+    assert(!(flags & ~(BP_ANY | BP_MEM_ACCESS | BP_STOP_BEFORE_ACCESS)));
 
     wp = g_new0(CPUWatchpoint, 1);
 
-- 
2.43.0


