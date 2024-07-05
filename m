Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3215C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPebr-0001Wu-Vk; Fri, 05 Jul 2024 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebO-0000yB-6D
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebA-0004Bw-QO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b966b4166so1703069a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169238; x=1720774038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXuTP0GCGD1U2EC0jCbVCWmWTWrrWZHqHe3306YwCaE=;
 b=RRZnb2GUQhy61z+qWf+Rx3ER0q7PL+L7miqdTgAKbVUUsb30ASE2wamM85iLjy6jo+
 k/gCHsLO1Ycv5kMDgdIO2zA+yvnoEQ46qcxH14LUIAZ6jWmsOdpxdS33wbNauJtiu8ty
 59zLi2RAI9PFmlWgz6IE80fVkbNKvFHO9J4ljUX2G/HwQ1yRqLPv7Uuf5YWYUn7ocPK9
 3EV6gu5zZXE64mNDTQ49qgWU1s0hidDu4pVuQ/vylfGK60YC1BYrHJbB3kIUTdwoCVc7
 Z/uUiqKYWCURfEDAKSnB1KsIKKkzswNdLRiPiq8o0kf1TtH2L3Rb56jaMRjO1lAl3+JX
 jtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169238; x=1720774038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXuTP0GCGD1U2EC0jCbVCWmWTWrrWZHqHe3306YwCaE=;
 b=e2TB7zJc8ykOE/nCERlhiko7CaRv9FupP1VLaVYZJbIYUyojZ+ITAZFe0qk79c6DrE
 oXUFf29pXI9AIBqkUcnbabdEOafNHzlTq0YxbjY2MEzvAUGL5l5rCTj5vnmjeDpI1JHe
 eahPWsWOnSGH9B2grudIQPDyyRLS9YB7IT0bPmNNmAig2fHxcJwe91OSjlEQ519k/Dsd
 RYTwdSWO0IWXGuptFvx55VlheZ9C/SKO16o/wLGzNNBc++G5Im3wmqoS6dn3Zb+PjZbN
 04MqafKpJZmxE6sp92NlXklM1DZXvCiTGlkmiqSizUh8j09toXYACC6fIlb2adj4Ew4h
 CBig==
X-Gm-Message-State: AOJu0YxyLOPqpxlZuhwPPDnkzKM0q59ycjYjuuls9RCYABZsaRwpTnCX
 WKD3zDr6h5wrTyE3c/0ifqIM+YQTrjZzh2IXZO/ukZh25557FSIIeb5/2S5Qbco=
X-Google-Smtp-Source: AGHT+IHW9KiHz33DZOiQ1P/zJcB5THfCLhw9h/N1JFfzRGzsRsTEIYccfvxOFuQ90S0y6vbL4TU61A==
X-Received: by 2002:a05:6402:2105:b0:58c:2a57:b230 with SMTP id
 4fb4d7f45d1cf-58e5955a333mr3220448a12.13.1720169237559; 
 Fri, 05 Jul 2024 01:47:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58fb3ee74f6sm493139a12.68.2024.07.05.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37EA062152;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 26/40] plugins/lockstep: clean-up output
Date: Fri,  5 Jul 2024 09:40:33 +0100
Message-Id: <20240705084047.857176-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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


