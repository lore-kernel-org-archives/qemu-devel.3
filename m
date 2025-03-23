Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8E0C36002
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU0L-00068D-2m; Sun, 23 Mar 2025 18:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU0J-00067j-Ak
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU0G-0006Ej-J6
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so2080899f8f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769671; x=1743374471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCQIZKUBzJuxBIof22dcIv0mCLqdpttz0aPD7GjZTzg=;
 b=VJG5IBZJKk3GGPK1Wuuag6zrGVAUx7K6oYY1qZX0V9UeBxfP2hLX6GrzkZ3C4AxZnr
 B8FzgoCfkQHAOSJmGjdxFwmjjPZcnMG6WRjVWdpjVHyva7VbM7DNGKm1T7x3l3kTihPG
 1veJq/qLoK9ZEorIn8J1nFdX5aiSDKHtMHY34jPZfTExzc46DimfR3oTuWfxwLoMBWfu
 v2TFq4jG3jPUKtSrdpIWeOn8C4izgyXt9lzoQY0rBWWTiqRwUgsX2rPfKHMC6cR/tuTM
 hRKtp6+a+CaXNO9t7Hyhq7qqOrk0DPErKomCcUMjhXz4KOkKe1bbzt7NJ3K2/k3OT3v+
 4ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769671; x=1743374471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCQIZKUBzJuxBIof22dcIv0mCLqdpttz0aPD7GjZTzg=;
 b=mbVKqPOCPs0+iXCMZLouIqj0jfIT6T19fYWO0dUs08yh8ntUfCS6RSCOIrH1H14W21
 ViCKu9TRcVi+J9R6HJMI8II6q2JOgA0EToS+9X3oDHdQ7642CZTbquKiha27Ob+eIX6o
 R3HLYtiGvsZM8t5r2NOD1E0kZX5wu63Cfo3JzcKSE2UbRPk/0hUq/MW9t+ynb3947nXH
 lZGtQ6jYI2CZO/giAdoIiH+nVHU5ZEsLuEcEj57EMEG0mbCZ6XjS5E8jyU57oOAk77ym
 3YTAEugOY3ztarkZirQgLVxEsvUSVH7SRwnmsyiHOqwZart1CDEb9dYLs+jlmxKDiPkH
 LTkw==
X-Gm-Message-State: AOJu0YwkWs74+8m2P7GaWRXfk0bzEyAab78J5BKJsUQYNLIHEL+Ggx7m
 0VUC/tElYhzCm/o9IkTBtfszoFFB/FWje/Yh14QGc5TznkkJv0O9hcqpXMcQl21SeUgLPPsQUjY
 I
X-Gm-Gg: ASbGncswi+ZATX3q0fVHYg0/oChtvOZvGORhwp/2+xyCvItsWOMk5jlLOeF1mWqElyg
 rCmIh7r5DNSJvnvpijZHGxLCzRBtrCPzr2EL1lP/eWFYl+Ekt6lSGe7SQQ7aAdwv49jbof1EsTq
 IQih7MopHEHZcL5zUzEao1BnwGKdwwhxmZI32pw8+6TdvMAiXu/Su+DIXJ5jf4anPbhIZlSHKOg
 27+9WrbDsKxz8UrJwGndlmhYOlnhhv8EsR5mujmRRb3C6R0o3ol55xNkLqU8TlFjlZKTeN9jRG9
 se2qXeuetrA1VNWNqyhGM6rx8Wo2m3qXo/HCyYSI2WnDKiLIoPtGVuI4jjcMyqRiAXpp85mvqbX
 HDigqg08KAnmKyKbB3ES8SUJz
X-Google-Smtp-Source: AGHT+IEOgHfSlCMt+Rq/A1xP/IorgjGxg5TZ3u1AF/zjTwlIYo849QYaRMRWOJHJ5oxUCfvfDXbWbQ==
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59d3 with SMTP id
 ffacd0b85a97d-3997f8ee934mr8331895f8f.2.1742769670880; 
 Sun, 23 Mar 2025 15:41:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbd1c7sm102399385e9.40.2025.03.23.15.41.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:41:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 6/6] cpus: Remove #ifdef check on cpu_list definition
Date: Sun, 23 Mar 2025 23:40:35 +0100
Message-ID: <20250323224035.34698-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Since we removed all definitions of cpu_list, the #ifdef
check is always true. Remove it, inlining cpu_list().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5947ca31a0a..30598619581 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -71,7 +71,6 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-#ifndef cpu_list
 static void cpu_list_entry(gpointer data, gpointer user_data)
 {
     CPUClass *cc = CPU_CLASS(OBJECT_CLASS(data));
@@ -85,17 +84,6 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
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
@@ -103,7 +91,12 @@ void list_cpus(void)
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


