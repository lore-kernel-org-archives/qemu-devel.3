Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF54C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmd8-00017O-8o; Fri, 17 Jan 2025 08:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcw-0000zo-Ul
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002E1-8n
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:10 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so326758766b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121385; x=1737726185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PIlRNEhkzbf8X8MOcKyxsekvkuQSHwlU51Y1LPAQWM=;
 b=p6n8wi+u3o2zxFwENdT39a2/JvLoCcQqEYXncne5DCi3NDODgUJNnoIMQLG8IyHi7W
 o1T1qtr3b4yTlw/rmyiSti3oPAZ4vYE9pHc5MIqXyln5FBpipqhNpwKCvvHhRE/TvxuA
 rcxXmZ6qi+/NAiSGkyZq4rmOJK+OEC5sEkFpyFJS18bC225nUcR6CsTTTkez5jAbHM/z
 12zge60wDX0e8wv6oigKob3d3zRaGtxkun4OplGxsLRY+kz6fUeS4++voB52kV0v87Ll
 csTAanh7+Zg46NEuh3dYIFzf1SE272Ts3QCz7Bdk/QlAwM9LqcBnlXSkqXSsj0z0htmj
 tqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121385; x=1737726185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PIlRNEhkzbf8X8MOcKyxsekvkuQSHwlU51Y1LPAQWM=;
 b=lf5wRLmJKOkDZ5bDuVa7L75BtvHdAHv13fn9Hc+ym6Z8yI3DBirbkpdGuhhgfmh0y5
 HPisduAJT6Y47OFLWIko3wJZWMuukUbHLmVzPUlSE1J/iyGCScqBZX+fam4g9MhloyOP
 v5po7wAUE4g5HqbzOTkx4PwvYeq0iFE4B6Lurzce63xcd078cZ7+EEUpk0Exzed+ynZi
 e4cuqYC1UVOCZCo7yI0AN2jTAfcxP2aOozFCdMOqDWKCXzn8U2x0ZtdbLfbmyWLWnz97
 liav+Eqquy/YJoeXYQGGetNXHbXVZUy69tn58iIP2JS1olOpcLTCDK5CU+SyFx0d1XVv
 HASQ==
X-Gm-Message-State: AOJu0YxmEhzCiV+StP8prCCuz5VTYnye3SC+Xay54RZqXXv2Mm7J0lbM
 tqfftmoYunducRzs1V1AqeVRAvvQ6dk5Fqa0+kIF9qzoRxZmEOByBi5TlbbWDSk=
X-Gm-Gg: ASbGncsCLOyn8bfvBsRIQSHnwRzVrJ3lJCvRxp3FtxkNgW0NR+uu0jZV2wk71+PQT3G
 TWNaO6e3kbY7jVhAoE7NewHEi0yMJF1liK5a22cMYua79HWc2GrObHx+zr9+eCplJkGhANTtl5P
 Ts8SYysKGj/7A1vc4jrkv59uax6dR/Kq1d15unjLspM0wui9fjZgKOk7buGfNv0vLlPMtSL++jz
 6BNl/7jZ3sfziwvJC+jV8NdjurU668s5ss2U7gCKHKdB3r0MjXI/vk=
X-Google-Smtp-Source: AGHT+IHZnD/jOEmwwp5SVPKf8ImkKKYiNumcE2rorfQwx+6+EyPTku/O1jdPYLDgjEvvz3WOnZ1M1A==
X-Received: by 2002:a05:6402:84c:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5db7d2f5e2amr6655809a12.11.1737121385613; 
 Fri, 17 Jan 2025 05:43:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm171047866b.150.2025.01.17.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26A9F60898;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 13/37] tests/tcg/plugins/syscall: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:32 +0000
Message-Id: <20250117134256.2079356-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-14-alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index ff452178b1..47aad55fc1 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -76,12 +76,12 @@ static int64_t write_sysno = -1;
 static SyscallStats *get_or_create_entry(int64_t num)
 {
     SyscallStats *entry =
-        (SyscallStats *) g_hash_table_lookup(statistics, GINT_TO_POINTER(num));
+        (SyscallStats *) g_hash_table_lookup(statistics, &num);
 
     if (!entry) {
         entry = g_new0(SyscallStats, 1);
         entry->num = num;
-        g_hash_table_insert(statistics, GINT_TO_POINTER(num), (gpointer) entry);
+        g_hash_table_insert(statistics, &entry->num, entry);
     }
 
     return entry;
@@ -232,7 +232,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     if (!do_print) {
-        statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
+        statistics = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, g_free);
     }
 
     if (do_log_writes) {
-- 
2.39.5


