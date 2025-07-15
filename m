Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5B4C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgvm-0007rS-Ev; Tue, 15 Jul 2025 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgE5-0000My-9s
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgE2-0004W1-7k
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3143760f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588098; x=1753192898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oELVOVKA0MGEve9Q14hme01S+F7vJ1BQLOYs79+MlnE=;
 b=Fpbk+wcBZO0V6dpwM9WIcJ3kyEMDhxjUzI9qg0NwRilTW+UUnz3ttuD41kfvo/OSHx
 4k0KwttYDBs+EN9d7SkgsxjLI8DuywbHqK2lK6UfVDYRKy4XZEkwxJyDcjVB1pQbSxBK
 0oei9JHe4AgHnurNHl1qLAUTZV99uPWfl+hphfdRKT6GKpmfuH7xoitvwrpg4wkz/g0E
 WnIhvlyFz9fsY/ECHztrs5Bn9loOjXc6GjBqJVWoVud9hiGm5hoLnVYP7B04ULR74Kot
 0uz6Y3hktluICaYYYEVmq8ot8vrKVO6PDGfWwu172fpRz0+T1r8g28GSOf5Rp+FmjJFM
 w1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588098; x=1753192898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oELVOVKA0MGEve9Q14hme01S+F7vJ1BQLOYs79+MlnE=;
 b=Qiv38W821NQ5aGWACAsNBtAoTczGm5vq0vVhbO2Jamt8y9daRr+d0mwMWhWkTFZEUq
 ngzLnlm1ktF8MNjsQocBYqgGEGwV7WGz5Z4t18tBmj9vaa1RB0IqXx1mjxDFxITvYLoh
 BUrHy3z0l8IWbY+WIXJ19r0linScF3nIegUefoqMXcdXoLdYzIP44Tj1DaozbbkKeAFb
 YBQjtQ3fQ5Zuyao/qA4TN85C26GOsF09iXhGHEcOV5WgBOKO9rRbVYgHEX/3L9ukI9FC
 3iWx1pfuY3hJTWX1bjf0ijvWKNjxbcN819K0Z+S/Nl+UM1/8PIDYn+FcdousmtetIK4C
 /bXw==
X-Gm-Message-State: AOJu0Yy/bZp/HrAEQMjuBLGrB2NMwxcU61/zcSah9RVJrPO52sHLFEzi
 aFaVOrfw13mlH3wxTUjHQQNBqs1M80ScwAkgnz80/Prv2eZCjcWkJTIlZv2T8sfIDRW6A9z+uLy
 98XGm
X-Gm-Gg: ASbGncsauxrbqSswRx3jC5DOGikAD0mzefc7M8yFcjcTywomeSzhLNZcznUjP4Mu1+n
 oJFufT2Giw7KuTtG5CCmgH+0oCh/tXgDWJ728TG8wkWm98gHguZNW4wFEe2CyDFiLJhqqyEPqvE
 wRDEuXRTZ4WnH0OcmJUcc+0ySjo2tdWajIMiS/6Be744KwcCs7QyH2fr3fmQgWB2DHtTiuUA87y
 G/cO0JbwZPMV/Szv38eq0CZh8QRKYI6D3E8Umix++jgcuDusJiJWhe1KngX9r4O3uhCNXjWnAd1
 QmH5wn/aZcaIYWqcKnexe9CZF2oJcRUZ+PwebBc4KumPni8vs2LV4UwOCcqkWs6e3gk60eYHmhC
 SNAh5XpI+llkCtJVcimy4At5C3zRA2WvQ39LYK2fUGawzJWRH2ggRoHzlx2Ssn+3/B/K8L0YIGu
 OR7w==
X-Google-Smtp-Source: AGHT+IFhcfsSVuk2qIVamaTXEBpqKqkAfKnwZJlz1xkHDkl/GwT1S7OC2frwtK0W/txuJ7NuWbOoVg==
X-Received: by 2002:a05:6000:240d:b0:3a3:7987:945f with SMTP id
 ffacd0b85a97d-3b5f190000bmr15915830f8f.57.1752588097039; 
 Tue, 15 Jul 2025 07:01:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43906dsm164616095e9.3.2025.07.15.07.01.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [NOTFORMERGE PATCH-for-10.1 v6 8/8] linux-user: Dump TCG stats to
 logfile
Date: Tue, 15 Jul 2025 16:00:48 +0200
Message-ID: <20250715140048.84942-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Running 'qemu-user -D stats.log' will dump TCG statistics
to 'stats.log' before exiting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index 1ff8fe4f072..17d2ad0517b 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -21,7 +21,9 @@
 #include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "user-internals.h"
+#include "qemu/log.h"
 #include "qemu/plugin.h"
+#include "tcg/tcg.h"
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
@@ -29,10 +31,14 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
+        g_autoptr(GString) buf = g_string_new("");
+
 #ifdef CONFIG_GCOV
         __gcov_dump();
 #endif
         gdb_exit(code);
         qemu_plugin_user_exit();
         perf_exit();
+        tcg_dump_stats(buf);
+        qemu_log("TCG stats: %s", buf->str);
 }
-- 
2.49.0


