Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C39AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoj-0005ja-LO; Thu, 03 Jul 2025 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoh-0005fR-EI
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoe-0008Kb-Ld
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cf214200so656415e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564021; x=1752168821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLpptP7XgFdYuwngCEYE9JrU2GvVIYMaqCxqGWt5OzE=;
 b=vFAUlq1OM33NFgwqk4P8rSWtGwJuYuMFj/h8SfrcLsKsFhWmFq2dQvoq8JxyTtLom1
 4D1AkqyHi/ZZSbvkrMBgCqWX+Re58BGimjncqle+UWEyVdHxmT5jR9q28yR8L6cppikz
 EyDN58wYL6+874vLB+9Dk7kk7uTDhqGy2WlY4j0pTQzCHEyQ51jxCvKuenH2OEpLzNx8
 AXbOOhk30fT9Su0flXCU+tmRIIdN7Gj7pFEJ6/z63cRyaEQtrtciFR6dHY/LdRzB/vv1
 yFkOq3uhuyObur9jB4vXx2fCrqexfgKTKsnSbaciMnp2zzHxNcDDj9Xs/tqK1OdFSSqb
 nKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564021; x=1752168821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLpptP7XgFdYuwngCEYE9JrU2GvVIYMaqCxqGWt5OzE=;
 b=GdU48n5HiVaNVX41TG/NKHa8uaYaVSYD3PILYI43kmYEkK6JQXLbFV8SnsJvZsXguF
 VSDVEEZHoJja0igIVaKndheJzIg4EqiOT1WDcQtRmYAz3f5rcnSYiTLniDTsLvTGJexZ
 D0SDv97oRXXAW9/hP9/OAAp795YofBAci/eWxvCIqiw4OJKzHOHmlJfH8XBRacq7ZxbS
 wOXQEPg+965zkDT36dcHXTLYbiDdmx2/I2QGSB4Qc/Bp6ccccHpa6eacAYMdSkCDmjly
 14T56EN/It8Okkmu9g+nL8sPtQFdcbkQs5NeXtfSB1R95IRwA5DZyjqPD2SdWi+EgSqO
 aRqg==
X-Gm-Message-State: AOJu0Yy/ylkxtrE8a4D8EzC290CA98frY6gR1xAZkjBiujccFDH6omNV
 qRnDMVJcoOANXUGWIf+cSF/rIC3vwgpaBVCAKsqUho5qWENVNl+q4TOjZXmW9lTvoLPRLg2GzSP
 NiS9vBpk=
X-Gm-Gg: ASbGncv9d8OwOrJcdUhGyZ6x6oHF4vpy7ST45glZNFCUcnh8ScmNS9KAqKhdPV/qG5l
 ZW48lFRK80ESlyjguuPbFrvmJZMf0S2c6cGnecVRteruV/Az9Zo89SouLMfaJ8Wvqp9to6QVpu9
 WkLs0QZ/BGM6u/OfRHb6vFcfoELEvS7Xaa+v4j2D1iaE+1RSQYShEF/cgtYYuuDVwsNnsrDUgbB
 Q1kjybys90AFEY0n4DnA30du2Qm/hK0eOKXgHqqHyvISprsTdTCBXuwp5CHZbd9AE5FCT/QlCcU
 yWBJPcyIPaOWA8tx+I5BisU7ciwKnYcBlCTzN9+o9WYlAkcgLp+WocTBzNrkbqg9ORQ5Z+as/kz
 RgmJxUt9KMJvtqdtfepHauw2nBebu8YGvynn7
X-Google-Smtp-Source: AGHT+IEoniw2Tkah9+tyteyfyEsV9dvLebSbbNOA1tJYC6nokK7s+lGtREJBLSBQ2OHa1jLShrmsmQ==
X-Received: by 2002:a05:600c:8883:b0:454:ab1a:8c39 with SMTP id
 5b1f17b1804b1-454ab1a8f9cmr29466115e9.26.1751564021219; 
 Thu, 03 Jul 2025 10:33:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1699162sm3451435e9.31.2025.07.03.10.33.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 10/39] accel/tcg: Factor tcg_dump_stats() out for re-use
Date: Thu,  3 Jul 2025 19:32:16 +0200
Message-ID: <20250703173248.44995-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


