Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3519C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYL8-0002H4-5i; Tue, 05 Mar 2024 12:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhYL6-0002Gi-Df
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:12:28 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhYL4-0006sK-Lk
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:12:28 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513382f40e9so4381707e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709658744; x=1710263544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rjXKS6vGeWEZgAJZUHM1h05LKR0JFC5i6Cm52KHRQw=;
 b=AdaHYCkqMO/bQfS4lDu9huiPfr/8Bvj0sbJNRuCmHtYTIvw/bE+s44S8w1KH75A7oH
 pyGbcGeq3tmht1qTgnmEJ7COaTk6/Gi/ncHJV9CCHujztfP9ci+09SoyRGMC+BM6tUQ1
 OtZGEws9lFkx/ZK/icixIypjNcZQmuMUQv8WU3BKQPsPkS1BviOOBUcn6evHhi1f3t1Z
 wMd7Y10MSNBE60pbhP2uSXVTQTshdOvJPxSchc5XJ9WXOKpkeMkfCNEavaxiFFG5/TW2
 N63Xs9e0PVvRk/QBkCa/+9B5SGNTKul2UHEyj8jBsyXRdGikv2wWupVXPgkm3rxS6po6
 6L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709658744; x=1710263544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0rjXKS6vGeWEZgAJZUHM1h05LKR0JFC5i6Cm52KHRQw=;
 b=IzcaF4UMoLAM7s2KoShd9+XsGKwgG5TVK5IGHH0lNBauBVFlQ+ccOcgVxIMyV5r/cI
 CRT0YqCkZxieix7V0w65po4Cj2rr6tjxdJXftnOlnILm8SAcjsQH8xOdbcObvbx8mPK5
 qN4g3twgsvHf3wloAd8UKzrzSbtfLrptWWXGlCHOgta3A6WJk1tgHu9XCLuKKGq1ExM1
 z1b5ilzR3WXzsSypLRE2FUB5X2CKLLxiFH5mjuISEN3EQGKVAPtJ6LZLdIP011YFGYDx
 t/HPftPgPK3O1ts1c4aHemlZWPBtOWKyMhdUyVRMR1q/Y5paSRQ8KNMeeAj1o8LSqRgL
 tsHA==
X-Gm-Message-State: AOJu0YyEFoXIfGbsRj4vS9rp+6CHpo+xLHOEaFnQpOI3i72A9OrrbdIF
 vxogdknmklsUlTCNNE1KFKif3tt+GPUlslRFMgT+lVA/m10rWYyIKuDvXALaCJGG3HmKOnjBcik
 5
X-Google-Smtp-Source: AGHT+IFcWtbAQWlGJF+jWWyWDmYFVNF+lym8tad+lnMV7PbDa6TOmhK+kUr9NAW1seisEP0dfSbV2w==
X-Received: by 2002:a19:915d:0:b0:513:2b36:3195 with SMTP id
 y29-20020a19915d000000b005132b363195mr1529720lfj.51.1709658743636; 
 Tue, 05 Mar 2024 09:12:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c35cc00b00412a0ce903dsm18465906wmq.46.2024.03.05.09.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 09:12:23 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D14345F753;
 Tue,  5 Mar 2024 17:12:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] plugins: filter out the PC from the register list
Date: Tue,  5 Mar 2024 17:12:18 +0000
Message-Id: <20240305171218.3621274-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU's handling of the program counter is special in so far as the
translator avoids setting it whenever possible. As the PC is available
at translation time lets avoid confusion by just filtering the program
counter from the list of available registers.

Update the documentation with some notes about the register access and
calling out the behaviour of the PC.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2208
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/tcg-plugins.rst | 15 +++++++++++++++
 plugins/api.c              |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 9cc09d8c3da..656df012e77 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -151,6 +151,21 @@ Unsuccessful operations (i.e. faults) will not be visible to memory
 instrumentation although the execution side effects can be observed
 (e.g. entering a exception handler).
 
+Register Values
++++++++++++++++
+
+Callbacks registered with the ``QEMU_PLUGIN_CB_R_REGS`` flags can read
+the current register values of the system. The plugin need to request
+the list of available registers after a vcpu has initialised by
+calling ``qemu_plugin_get_registers`` and using the supplied handle to
+query the values when executing the callback.
+
+.. Note:: the program counter (PC) is not available through this
+          interface but can be queried at translation time by using
+          the ``qemu_plugin_insn_vaddr`` and
+          ``qemu_plugin_insn_haddr`` on the instruction handle.
+
+
 System Idle and Resume States
 +++++++++++++++++++++++++++++
 
diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac3..fc3477acf2d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -448,6 +448,11 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             continue;
         }
 
+        /* skip the program counter */
+        if (g_ascii_strncasecmp(grd->name, "pc", 2) == 0) {
+            continue;
+        }
+
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg);
         desc.name = g_intern_string(grd->name);
-- 
2.39.2


