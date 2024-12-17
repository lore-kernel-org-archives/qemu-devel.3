Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E31E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHn-0004NT-Dh; Tue, 17 Dec 2024 17:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHj-0004MJ-Tu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:24 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHh-0001BI-CV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:23 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725dc290c00so143138b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475400; x=1735080200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hu3Esp4NNyduPBoo/WasSoSQDzLT4+3rhRtkkpGwr3E=;
 b=tjEl73Gm4ECZ2jnVitQeAAZEi9eqammy2zCXCe7SnYh/XSK4HJji+AekuW/cVwJzvu
 zzjbqwmcy4YcfDep8uSn7UKBUrR5sgDiMHngO5wzTFduB//8ZEuX0sDHwX4iblrKI8pP
 qC2zLFoga/idR+Kp04aHwz+CLuCvySsJGV9mkXSSIbWkqRZCb6LEGD6FExqlmNV1X+p5
 yzqIz+y41aVDICx1VW2d1tB996OwtLHuX4BPWdII0v+V8HRsmcNsMdq4+7XddsX9OcYF
 TS5cfu3nJUNNaJSBBY5GaZjqBEcWf87MGbtLmA2p/lXqyQagxwZkqBdGehFxKy0u0wf6
 PZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475400; x=1735080200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hu3Esp4NNyduPBoo/WasSoSQDzLT4+3rhRtkkpGwr3E=;
 b=D3jVYWlZ3qd0W1XDyuFBlX/04X4VrPLBb2qO4vu8Z/7B4ch5VnlgmUnjVrKW1Ky8/y
 FiYF1n+97GiGqp8oECUGziCTaWDdRCePYoaQ3AbnfdIq2uNe8xgj79bSlZoBdUOlhG1U
 TxHgs3vs++OyanXSL7YiOByGwLokO/Vhd1Jo+QZHb7pamNKUZNblJh1hcrEVTpZ6cVxt
 ZZjwyfYFnvYH/gZGOmsIosewSkqYoWvu8Pp1BqGyEIRY0r3WiYZvEPHxGEJT+aezbwnT
 0AqQ9/W16Vcb6uPfIZXOMYfYF/dG2wL3cEZ38zdV2r1vSAlUKzVF/li3BCWtAskqfTKF
 Pq7A==
X-Gm-Message-State: AOJu0YwGIK5tas0GhlrWDLssub65bP3gi4abSMmBLx/wcORhrpsKMG7A
 mmjpHaVYFZysyvJUjctxkllraxQR+MqPtbnHAMxuptAYfH7W89zh0N3wQvw9msuTdhvMmv3hn0I
 rNEc=
X-Gm-Gg: ASbGncuFjoM+Vcs6ga6r2ncGamP+tb9wtmam6J0Hauw7iYoRe1Ecn1JALKT+pQxlVbe
 iDz2jjfZLGmxze8ybtg4uZQa7Cqd3Y5ng+s/a8Ko8HWx69SCpWiz2GfLf1vc17XUQwmzn3aYrvd
 S/GUIVX1XFxNUxmvmzI00gB6wRL3klCFgu+JTkY9e5BNcrQXKLwE/Dl+38Y4VI4IqknUSFEWerK
 sxmw0wZRO4CrvXNJ+pyKoFfzok0esJqmUxN6ACyShdfQpd+bQTXKjoR
X-Google-Smtp-Source: AGHT+IFq+FZeCXaZUx5kF1xcLqImGYXhZPo9xcSFq7rXY3R5u5DgqVcpPBFIp5dp/9IbzlLDb/fxmg==
X-Received: by 2002:a05:6a21:3a8c:b0:1e1:adb8:c011 with SMTP id
 adf61e73a8af0-1e5b5a3e875mr730480637.18.1734475399959; 
 Tue, 17 Dec 2024 14:43:19 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 10/11] contrib/plugins/hotpages: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:05 -0800
Message-Id: <20241217224306.2900490-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotpages.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c72..c6e64937194 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


