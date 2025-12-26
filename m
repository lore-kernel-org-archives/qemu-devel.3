Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4C3E8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZB2V-0001sr-Lc; Fri, 26 Dec 2025 11:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2U-0001sd-1a
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:42 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2S-0007zn-HM
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:41 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso7694775b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766767898; x=1767372698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2ESE239HeFr5jeihk+EqITFM9KfJHH76phxmWGdRr0=;
 b=U07sj52MSDzORoHcnm/XfplMWO+svV9OzTRgGpAaBpu16zoCBcKHoQGCMJ/n/6BDjU
 kos1GTVMmsn5oaLHgzT+a3hfgrPDQ8xNzBiu8rYfrzjW2Or0kM6QhCQgs4tBeN5yKo7p
 2Ko2nz4NaqhvbiNJAw4Nw4/MTxwCisUYnH2YWsm+mMmPF+33YWnhPT2uMS9SQVR8nQyv
 +vWyc3XFYJBw6fvuBZbA6r3Ny2uCoeCFBZ8K1mcNZxB+YP43LxI2FXOrJ6Co74FBZ8tc
 XlPDWTcnG06hK6dkbxnh8yRmvIRTfAtmau30fmuWT6hQwL6mlbiYG/X+tPPtHqg+E5ug
 DghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766767898; x=1767372698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2ESE239HeFr5jeihk+EqITFM9KfJHH76phxmWGdRr0=;
 b=rFCdH1gFXyoX6tP2j7sULrznlsF23Nyb7WFFwXeDV05kVX5eww4RIQU489zpzqrpml
 RUKWoaiDsb/1O9s4AXutjTStu1lBW+s+FCiO6RrjueCsTRSUgNZUjeY1xXvrPvSHGVt8
 pMABoeAK9PSp4BWbGtEgaT/m6osvkZvF2iOa2AolKLrkrF86n6hgezJRCW15euwhd7jY
 bL02A1A0Ax3TULV6QLIYS6ojI5XaSxPlvKxQOlJUzzlu+ScLOgA8DOFxAx4Woogf3xlY
 9L2QO1st1aSlUd/v2++wWc25s7ohKnmvDZC2amXyeV1+fIlmug0P4gO8jyWGV4ROlzyz
 Yn+A==
X-Gm-Message-State: AOJu0YzVCDWLDJG5GlU+ummVSMd3veBUITGiO6XnO3SoF+4SNy9D/jYy
 GLHVf5nv0RdA45C1UZ+/XLedYOT3fVSVB94FCEwkkh7h4lFxbXph/Yhp
X-Gm-Gg: AY/fxX5Zw06IOB1CAiq+1v5XqUwuStQZjH01+YUHvcTj+XdFU9WmZ0Ll2QEaDKcV12W
 72S476aNeC3H6D0yj3JUSEQCBPbqlyc1T4nLg1UEoBX1UOmibge1b1wUA9c/eNwYOUVhh1LtiUT
 Ow1yMV1QqqSxFPZicUAN+DHYgJfFz7dvAJYcVE+uUiXKAIK4dA5JU9oFgGT6+mwIYvRZtCkbFIa
 qpyU2pKJLKIJpv8Kt0uMlBQX4ieoiXJj5+KiP0LxYpq4pvJZQq2Tk1uKXX34bES86TOxUqi3Wf3
 mQg41gW9QpA4zehbAZVwkyAfGz+paY6t8pciUV2fLCfbv6rpEr/PqraezzRmxbmHSUZ8liua8lR
 KaL5RpHR4Xsz5t75yza4PHU1W/zmz0w41n+XG22teinSr6Kpw6LxyO2b3G5aM59SJtawF5rRfWr
 sR5fIEl5YwC1YedEs8XLfaCA64E77pNrBGOfGXAdIc
X-Google-Smtp-Source: AGHT+IF+qI7CV7L5GcktMvTzaN2u15Ja7m813Q3O91PjBR/9t+TQdjX8q8pvVDKRcs8n/oiJFrl9DQ==
X-Received: by 2002:a05:6a00:44cc:b0:7ef:1af8:8f2d with SMTP id
 d2e1a72fcca58-7ff66f590efmr25663397b3a.42.1766767898041; 
 Fri, 26 Dec 2025 08:51:38 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f300sm22522225b3a.54.2025.12.26.08.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 08:51:36 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: richard.henderson@linaro.org,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 3/3] docs: add documentation for the tcg_gen_print
 helper to tcg-ops
Date: Sat, 27 Dec 2025 00:51:21 +0800
Message-ID: <82ed02136c45afca45a5706dac7a8544b88c6d12.1766767299.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
References: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 docs/devel/tcg-ops.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f26b837a30..4b5ee3b560 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -924,6 +924,39 @@ a constant (e.g. addi for add, movi for mov).
 as some of them may not be available as "real" opcodes. Always use the
 function tcg_gen_xxx(args).
 
+Debug Print Helpers
+--------------------
+
+When debugging decode logic or validating a freshly built TCG sequence, you can
+insert a printf-style TCG operation via ``tcg_gen_print()``. The generated op
+calls the ``tcg_print`` helper when the TB runs and forwards the formatted
+string to ``qemu_printf``. This impacts performance, so enable it only during
+local debugging or under controlled conditions.
+
+The first argument to ``tcg_gen_print`` is a ``printf``-style format string.
+Each subsequent argument must be provided as a pair consisting of a
+``TCGPrintArgType`` enum value (defined in ``tcg/tcg-print.h``) and a TCG
+register or constant of the matching type, and the list ends with
+``TCG_PRINT_ARG_END``. At most ``TCG_PRINT_MAX_ARGS`` (currently 5) dynamic
+arguments are supported; use ``TCG_PRINT_ARG_PTR`` when printing pointers. For
+literal numbers, first create a TCG constant via ``tcg_constant_i32`` or
+``tcg_constant_i64`` before passing it in.
+
+.. code-block:: c
+
+    tcg_gen_print("rd=%d sum=0x%" PRId64 "\n",
+                  TCG_PRINT_ARG_I32, tcg_constant_i32(1),
+                  TCG_PRINT_ARG_I64, cpu_gpr[1],
+                  TCG_PRINT_ARG_END);
+
+When the translated TB executes, the snippet above prints the destination
+register number, and the value written back, which helps observe the runtime
+values of TCG variables quickly.
+
+It is worth noting that ``tcg_gen_print()`` is only recommended for debugging
+purposes. You must remove all instances of it from your patch before
+submitting official code. The ``checkpatch.pl`` script will check your patch
+for any usage of ``tcg_gen_print()`` and throw a warning if detected.
 
 Backend
 =======
-- 
2.52.0


