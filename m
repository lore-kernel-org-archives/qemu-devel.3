Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3A1CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJT-0007T7-73; Tue, 08 Oct 2024 14:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qq-Qr
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002S3-Ak
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:57 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a377534e00so16743075ab.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413504; x=1729018304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+Rj8O/QK6Pa3filkPJ4FZfJms9lNPKqXWSFkDZyfyA=;
 b=SCFevais/ptMBAgP0n7GyvOII57QeabaSMjUDe2/PvDwe8YphxjsokK0o5XXlMccN6
 yrVQs4eZpPxqqHdBbwdgSJqse5yRNUCyKGSsbjswaBYzFy2oPZN85w+IwzMwoqGVTUv4
 O1bMLybWOo6j3z9aYqkQTgFk0FJ7oIDIE30Q1z3FEngdKBJ5dVJ0Ach/ubD0mELmRySN
 StfRwNz3rz0yqwIMUErX68RtDga1Qp8G/JTzAopTRziAj+jtXZgeWGH8chu18jxcg7j4
 Am9bvFimR6SmvJiz0l8Tllz7NfAtRxSODANcggzLueYltSIPT/U8QreC2KjHDTNvYfIB
 9ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413504; x=1729018304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+Rj8O/QK6Pa3filkPJ4FZfJms9lNPKqXWSFkDZyfyA=;
 b=QTvc/vFoNIcx3NK3IfNU+B4zdk7kKaxY12jHrhWO64qlPpsLzHYeGLRXZA3BIAE8nr
 2UUb/RYcXut6xozo/M8+GilKTbTboVbTz8JFvd3FKBPCBU+vPkVIw1VvIRziGWzbfq1Q
 FSKQtp4vTn66SrNIaxIdAofZnnO6gqi+HlFa1gn3MpqGrwNZf+EEIJ1Gp/7S+UuSrvUB
 q+1aNKRISVzL+YalvkdTsdg1dFLlBtBmUbu7Z+E7CuwgogyrJkSaUej7FizDpesMy/lf
 wZ28SITypz8L1a1kYKYRbwGNetDf1U9TZX52SDEM05N0XUwJr4kA2nlsc0zDK1+Ya3x9
 56lw==
X-Gm-Message-State: AOJu0YwRIbHJopK0H6bBlmWPMBC5dESuwxhh5/FFMLdDN0rnmxJo8DnX
 FXZPBAY3BMHGP81W+c9ET6NOs7XOrFRGkcOYSbBSZPKnahb1g0rrmuXBPz7JUO8BPZfc0cOsAQl
 c
X-Google-Smtp-Source: AGHT+IHCzTw4pxxpz67MpMwnYyjzmcO385GXk7lEvLewN1gwovRXyJSjNb0ZP+aQPtPfT84Sm5TnmA==
X-Received: by 2002:a05:6e02:20e2:b0:3a3:4221:b0d3 with SMTP id
 e9e14a558f8ab-3a3757c8506mr174156735ab.0.1728413504238; 
 Tue, 08 Oct 2024 11:51:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] linux-user/flatload: Take mmap_lock in load_flt_binary()
Date: Tue,  8 Oct 2024 11:51:28 -0700
Message-ID: <20241008185141.20057-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

load_flt_binary() calls load_flat_file() -> page_set_flags().

page_set_flags() must be called with the mmap_lock held,
otherwise it aborts:

  $ qemu-arm -L stm32/lib/ stm32/bin/busybox
  qemu-arm: ../accel/tcg/user-exec.c:505: page_set_flags: Assertion `have_mmap_lock()' failed.
  Aborted (core dumped)

Fix by taking the lock in load_flt_binary().

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2525
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240822095045.72643-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/flatload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 04d8138d12..0e4be5bf44 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -487,7 +487,10 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     stack_len += (bprm->envc + 1) * 4; /* the envp array */
 
 
+    mmap_lock();
     res = load_flat_file(bprm, libinfo, 0, &stack_len);
+    mmap_unlock();
+
     if (is_error(res)) {
             return res;
     }
-- 
2.43.0


