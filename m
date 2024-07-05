Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CE0C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0E-00032E-NF; Fri, 05 Jul 2024 11:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzw-0002bM-B7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzu-0001Ht-Pe
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so2365231a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193837; x=1720798637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WM8Oz4o9c2T29sVKmOxM7YRppBa9hMmSs60bXcG4GL4=;
 b=fFLu3nfSX4XXV8wpthNLS5Ml1/Vb35lL7gzgtD8R+3tj8OleGZ4BwWkdV0rIADfaom
 GFMoMnTBtB3KwAIK4qWFvtzXG58LnnHBFbPPHQ/wm8xvbUr4nDGuXF+Kaf4neIlJALra
 ALvZtRaki0dLPcDvjKRg70UQJVyKQLbSegohB4hw+mJqT4wky5Rrz8L8r8F2dTY5LGI3
 lw6OzCmKL3FudHqAcHU1gNiodbbMX2J19iQw1TIwnzb01vN8tJWfsnBC/ZrZ8ieW+r7H
 ab/asXQCRbRKJrfC76p5/QYinSvln+7mus/0urOcXRzzH3hJ09BbihxNq8F+vKl2rsEY
 zyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193837; x=1720798637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WM8Oz4o9c2T29sVKmOxM7YRppBa9hMmSs60bXcG4GL4=;
 b=KZnPrvpU3a4JkCveesfPCT/bxvA4sOF7/3wqs6iXPe0+ycIkilMKEmmKTAEW4J7OYh
 IMlMNh/JqogX+PbRstjB/dBoEI52UKX9F9lRfNuBkffnZ1LAsRfGZlLf/KCpHMHZQAgh
 ipXCzfGQTETyCU0oKJiR22bYbKns+Zcr4+lzXGSt5BX1o7L5VBeF/5W/AaVue3ksKY2q
 2Wvz19XKU9MA66XFTLUldT4KFscUqkYJAfEG0v6tLK2vb6eLSkp5rKVYxI+vBWHvJplF
 r+3EniVIrMg8/Xo93vJGLi/4Eed7aF+dhUxQcUTY8PJZTNDZ2jHNyb0KA856e5mNMoDT
 wP8Q==
X-Gm-Message-State: AOJu0YyB5sgLtg+qb8hxhNTYoRpcDg9fVpCe8Z/9e1MCX5rHaX4Giz9i
 hSmSMgLWG68HWNgDtm5j+YsliRGbgRGaNe7xd7kEyk9Fpc16K7gP5zKm7eQ/jA8=
X-Google-Smtp-Source: AGHT+IFub/N3G6hdjFsYcNS+1QLYj8GR53cqoUWTQFkL/xqPfEYgLt5skzjhHwCGDqivmUh7OZPcnw==
X-Received: by 2002:a05:6402:2548:b0:585:c001:c1b5 with SMTP id
 4fb4d7f45d1cf-58e5a6f21bemr3745694a12.5.1720193837133; 
 Fri, 05 Jul 2024 08:37:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ec828b34asm1785413a12.15.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7384E62152;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/40] plugins/lockstep: clean-up output
Date: Fri,  5 Jul 2024 16:30:38 +0100
Message-Id: <20240705153052.1219696-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

We were repeating information which wasn't super clear. As we already
will have dumped the last failing PC just note the divergence and dump
the previous instruction log.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-27-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 1765fd6c36..6a7e9bbb39 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -135,10 +135,13 @@ static void report_divergance(ExecState *us, ExecState *them)
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-        g_string_printf(out,
-                        "@ 0x%016" PRIx64 " vs 0x%016" PRIx64
+        g_string_printf(out, "@ "
+                        "0x%016" PRIx64 " (%" PRId64 ") vs "
+                        "0x%016" PRIx64 " (%" PRId64 ")"
                         " (%d/%d since last)\n",
-                        us->pc, them->pc, g_slist_length(divergence_log),
+                        us->pc, us->insn_count,
+                        them->pc, them->insn_count,
+                        g_slist_length(divergence_log),
                         divrec.distance);
         qemu_plugin_outs(out->str);
     }
@@ -147,10 +150,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         int i;
         GSList *entry;
 
-        g_string_printf(out,
-                        "Δ insn_count @ 0x%016" PRIx64
-                        " (%"PRId64") vs 0x%016" PRIx64 " (%"PRId64")\n",
-                        us->pc, us->insn_count, them->pc, them->insn_count);
+        g_string_printf(out, "Δ too high, we have diverged, previous insns\n");
 
         for (entry = log, i = 0;
              g_slist_next(entry) && i < 5;
@@ -163,7 +163,7 @@ static void report_divergance(ExecState *us, ExecState *them)
                                    prev->insn_count);
         }
         qemu_plugin_outs(out->str);
-        qemu_plugin_outs("too much divergence... giving up.");
+        qemu_plugin_outs("giving up\n");
         qemu_plugin_uninstall(our_id, plugin_cleanup);
     }
 }
-- 
2.39.2


