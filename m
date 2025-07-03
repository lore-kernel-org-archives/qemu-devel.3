Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C7C83F09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgr-0000NC-RC; Thu, 03 Jul 2025 07:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdj-0005GT-Tw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdi-0002R6-9H
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so7259347f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540280; x=1752145080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdpUA+n17c1R3e2qTbyN3iueYfohDJviDhKsKtUO7c4=;
 b=SXYWGpe78cbHMbygGXlEUR9HEFh93qBsCirM4HNmpJpOf/iCBWyS5CsVvdIEcXlhno
 loceh2JGQFibR+s1bWUUhz0iQFuYStzyVg4aA0O2nIEqOaUS6cKwtcnVJ15IWJWsSKWB
 bUZqBVLjhs5EZij9NZpD9ohN6p2ViNXKg9F8eMYPUl19fHZaTzvyPDu7WRHntOkMclcW
 iqq47iSvWxpAvTVcDRBLJpe3D4sepaRhDmPOhhD4tKg9ep4E05wfxbJvtMBzCyxoX2qA
 eGrMTzRolNsB51+BEO3ztadi4eHbLX2rdCYXne7dPT0s4lA6kMKpVDvY3NVD1Al+AlqN
 peAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540280; x=1752145080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdpUA+n17c1R3e2qTbyN3iueYfohDJviDhKsKtUO7c4=;
 b=blJgZy8pQw0DuZyK/YOJK8vfU0JeNl+KmdzaqV/2SGuowlGEEYxV5Eu7m+jpXeQj9r
 nvkVIiPdUJkaIEJTuqzqzxoRwtQZJsBflzWic9NbOdaLnpWVrb4CqDBurLo7B+nOn0b4
 g2Jn85Va1haYdMQityUIl9RPsFi/RcD19JYlluA6qcwl7DckLDjA6zXoyEu542TgPYGO
 WSdwl2lpm1qcM5u102P1fKX5n3BwkpV+UN9o9/lCiWqSgbM9031jE3X/0pLiyeYVfaXm
 MTMfIyx8UrnJThe9y340Z3VJg0NSbqoE99TZjABCaBk5+7eI6l4GRg12wAkbE8rm6ofs
 QxNQ==
X-Gm-Message-State: AOJu0YyFbxyh+xTOyVIzeZ/F1wCyPiBuBRsgds4UO+u8pJA094CyPH9n
 rTJ3VE1laeJY5UWWjyq6nAaXzKufU7tQxWtEBpOiiXguvYjwE4j0zTU6p08mWfrD5lYJn/I6lG4
 sNsiu/+I=
X-Gm-Gg: ASbGnct2VKayD7F1NGKJmk6BLrthu36uO+5Yyl05tNb2o4wTRWkDVaiuztn3lEzNi1R
 ag7W3YAXR36pFY+q/9ZB3JJNOW23KOspEH2Wg6luubtwj5lpYZLKvbgShyBQg138cxTzXsxqblZ
 wXzFQwWalSx64pGCCsHUarKblpFJDrmg1iRFEB1DfJiQihiGadbc9eq7+0A6paT+l6Pf2eIfn26
 4j3lykqiPJRAcrrCuB8oK6EwHaBj6qCVBovAd+AGKTS3JD9PNVgub5c9gNZz6TCk5DPkyJmi6yU
 GDZQuNRVrngNikXw4O2MUnYH0WmrnVwaj6KfQZw3mUTcbHaiR4hfaDPN1W1Qwu8Jhf3s8bo14r/
 hSohrQ0q4RJ4=
X-Google-Smtp-Source: AGHT+IFYoy2jQHRxcLCpISz8RybYDo93PQPw4aLsWNTWwxU2T9z7OKjWchTrnK4NWLGFuMukr4V3Vw==
X-Received: by 2002:a05:6000:41de:b0:3a5:2949:6c38 with SMTP id
 ffacd0b85a97d-3b2012033e3mr6067660f8f.52.1751540280194; 
 Thu, 03 Jul 2025 03:58:00 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c800eaasm18721782f8f.37.2025.07.03.03.57.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 26/69] accel/tcg: Factor tcg_dump_stats() out for re-use
Date: Thu,  3 Jul 2025 12:54:52 +0200
Message-ID: <20250703105540.67664-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h |  2 ++
 accel/tcg/monitor.c         | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..77a3a0684a5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_dump_stats(GString *buf);
+
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 6d9cc11d94c..e7ed7281a4b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -200,6 +200,13 @@ static void dump_exec_info(GString *buf)
     tcg_dump_flush_info(buf);
 }
 
+void tcg_dump_stats(GString *buf)
+{
+    dump_accel_info(buf);
+    dump_exec_info(buf);
+    dump_drift_info(buf);
+}
+
 HumanReadableText *qmp_x_query_jit(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
@@ -209,9 +216,7 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
         return NULL;
     }
 
-    dump_accel_info(buf);
-    dump_exec_info(buf);
-    dump_drift_info(buf);
+    tcg_dump_stats(buf);
 
     return human_readable_text_from_str(buf);
 }
-- 
2.49.0


