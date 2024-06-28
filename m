Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C6BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAx8-0005Iu-D0; Fri, 28 Jun 2024 08:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwh-0004tW-OJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:24 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwZ-0005jD-Oq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5854ac817afso716466a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578589; x=1720183389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXuTP0GCGD1U2EC0jCbVCWmWTWrrWZHqHe3306YwCaE=;
 b=NLhOCkB2EwBfJWKws9yOnq3qir34Ojujpgjc3ab33esJcobTb6HC+x71VgCSZvwzMW
 fa4nMw9t+qhiDvonVYJh1NpNhGmYefj0KPVoPHJxQyC9YFxKK8v1arwemADznvQ93OGY
 mKN5O0JmeXRxii+rwZhp/dOWgWUkK5H47SHaACHuesagNiVyj/bJycSF6jWoFEHKaRD2
 NtRnEVEszFjVj7Yju05KACho4yaI0XzlTdLA8D/yZ3vXe9FYYPRCdyxa5ksobfIY4cdg
 0suhl2F5BBDof4WC8aU8nn1mIvlBQGpOAkyO+xkdKUa6az1EZuk31QsHHRSpIwJqIPyl
 1upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578589; x=1720183389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXuTP0GCGD1U2EC0jCbVCWmWTWrrWZHqHe3306YwCaE=;
 b=LBnexLpYpESCnbNvvJGK8krjardjKHz6ckgEZP740MdDuL4HeXL9UN6rdtyvQHRuIg
 z3z61Chsx7kd0pK/HB7NFMVwpsmXosJMJBVBCk7KBzzmEDVa0Tvq0dpoR1GzTAXe34n5
 jTI6+kQqQ1wRphuiI/5qKJzMMQVrkbqlXs8pxRcPmxKph4wTx3FOqBjxiJEvQmtVcqYS
 WnmpT+o27eMM26gqcrpuhyELdsDrB4AmTfTY50lZMpvJC4Nxox1pK9T9isldMq6qrFUq
 OXlsIAHoHyxi8S7CmoDhDOkDIQ1M4pMuMkBTz9vA8tj/2znTZxNd4kOu/7TpbGj6ybE4
 SuWw==
X-Gm-Message-State: AOJu0YyPqz1HQAjqeSz6dFPBALafhzWrqO09vw2K+DDE9ftEedvkkZaz
 ll2sut73U0S8y7qIDTMXSlg3d+ApQBRonzFe7QqOWGJwZuTqed2+9j+vssz0CFM=
X-Google-Smtp-Source: AGHT+IFHf0vSbzs8VZ3LvmyqdlEDv7/sSys89Do03bGPWfowgmT1MGAW+NVV+Onr6HnELLwmC6+l4w==
X-Received: by 2002:a50:d503:0:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-57d4a2815b1mr13889247a12.13.1719578589284; 
 Fri, 28 Jun 2024 05:43:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58615038a86sm978580a12.95.2024.06.28.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EFFE5FA39;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 12/23] plugins/lockstep: clean-up output
Date: Fri, 28 Jun 2024 13:42:47 +0100
Message-Id: <20240628124258.832466-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
---
 contrib/plugins/lockstep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 353bf12dfb..5b7dfc9c06 100644
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


