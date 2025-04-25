Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28114C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kzf-0000GC-GJ; Fri, 25 Apr 2025 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzc-0000FJ-7d
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kza-0003Yy-FQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso22786915e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594968; x=1746199768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8k0AAfziCombWBxMnYqzVC+KQuFL76YNid+OWSCgv8=;
 b=uJUiN2j1PDuy+efAgjMGKRD9vo/G3bfxMyN8KwP1QhM42cwduzAWGveCoGPWWZ/X0t
 vgqhVjSpPi5QfIBbviHrZHazlIUzqxto1htlQYai+V0rPSI9avBO5SjMAtG6WAqL3zsc
 dm05DlUjJWq9pxPIHXFedhzf3RKxcAg8Kyra01Q+tBzXTKYPi3Ds5ym4RVRl1AOo0Gac
 vm/d0XvO1508yF9qoTSAY6tExqwt+Oqt8knIwELI0FIzE+R8su0bIxKVfWxL/wlgxbzo
 7m9ac6Nwa1470b2RFYT5QsHPDwjrOz9BwmVZX6EtPwkMVVOZ8vgWlJJVLvfyUE7o1qFA
 1FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594968; x=1746199768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8k0AAfziCombWBxMnYqzVC+KQuFL76YNid+OWSCgv8=;
 b=FmwR80MyvpFUPNzATs+qsNs2MOmNfNc5/ONeM421vJVP08hT6l4S1u9Ro5fUOxi2a3
 TMN+RaP85Zza7YTSmQ2mKUqOYbzcx+H/A1e/qLVopf8TzCVrfB80FCZdR/ZBfrnlJits
 XKvbUPLNo6PscbyqTyPza8yckyB+t5SRVtd7QVMruoD3xwyMGbODVA3HKdhqWS53aOlg
 ckbrV9mwzJ/RtNmcmqoWVgOSyUxsTIb2H3+8c2pA8/uyDSKYVottNMjFLj6Yas1Y9KSV
 yB7jbwgxGHYMrsS5hxPUI/KdqlcJ1e7ZVefc7a5feqVYMseFVgvl/TzXU3ufTbAhpTA6
 u6Gw==
X-Gm-Message-State: AOJu0YwWRDvKQU1yAfGhFDia1Da1fkk9L/FUcquH9O100Z6muIksM5DN
 MoucwzVQ647iv3KfCY/7YSlwvzCV7p+T0hNfkjLNOtHr0Q7DlpOnzB5T+80bL5tMUXSKv/82evH
 m
X-Gm-Gg: ASbGncsCvE7ckAJWE0qBrQXCuxBhUKJUeXaG050Vb8EgH6yUo5rv9YFYCNvRVZvyAjj
 1llE5jvTR6HVlEXCezNUIAKEXeZSomOCTvZOYpsI6Gu7xC9KWQ2KiedKMOl+fdLgLQNB81EKKRt
 uTx+t9Qs6mb26sJd+yF5CDTOsUUvIi6q3lL2rR5Lxuup1r1PYAr4UVQ9PFDVZDeytT8bbyVMi5g
 zrVal0MHZOg34pSsHoRbLk++ns8lhrsE4Vo6GAmPTDH1kGWInR4UANx6PBjuxnleFLRyjIGHIIa
 s7VMB7QjQFrJv3hcCiUbQnKrFmR1lRf5oUF1LHswCDTGjU/mYMQrS/VXRS9Uj3IYHwLMdZqZpTP
 cYzfjK54TWnCBa10=
X-Google-Smtp-Source: AGHT+IFz7Dmk1Q35CZnGUj4v6qhlSM1pncCBRIbvDFsC+0X+/rrphLxBOiGcKKUlrjoSYqlIBbLphQ==
X-Received: by 2002:a05:6000:4006:b0:39f:91:4444 with SMTP id
 ffacd0b85a97d-3a074e1da79mr2399310f8f.16.1745594968528; 
 Fri, 25 Apr 2025 08:29:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5310a1csm28161565e9.20.2025.04.25.08.29.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/58] cpus: Remove #ifdef check on cpu_list definition
Date: Fri, 25 Apr 2025 17:27:53 +0200
Message-ID: <20250425152843.69638-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Since we removed all definitions of cpu_list, the #ifdef
check is always true. Remove it, inlining cpu_list().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250324185837.46506-7-philmd@linaro.org>
---
 cpu-target.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index d139a18f5b1..c99d208a7c4 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -77,7 +77,6 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-#ifndef cpu_list
 static void cpu_list_entry(gpointer data, gpointer user_data)
 {
     CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
@@ -91,17 +90,6 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
     }
 }
 
-static void cpu_list(void)
-{
-    GSList *list;
-
-    list = object_class_get_list_sorted(TYPE_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-#endif
-
 void list_cpus(void)
 {
     CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
@@ -109,7 +97,12 @@ void list_cpus(void)
     if (cc->list_cpus) {
         cc->list_cpus();
     } else {
-        cpu_list();
+        GSList *list;
+
+        list = object_class_get_list_sorted(TYPE_CPU, false);
+        qemu_printf("Available CPUs:\n");
+        g_slist_foreach(list, cpu_list_entry, NULL);
+        g_slist_free(list);
     }
 }
 
-- 
2.47.1


