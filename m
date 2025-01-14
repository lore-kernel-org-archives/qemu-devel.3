Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFz-0005FX-D8; Tue, 14 Jan 2025 06:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFj-00057e-D9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:35 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFg-0005QZ-Hc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:35 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so991654366b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854711; x=1737459511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=jwEE0VIVJpTSr42t4WT0WXaF18KP/d/WVpNGzWwmflVHLo1nds0uxCVMA3hvmM/5gi
 lBmjXq54MAWun1WDGrwuOT06P+85h2O0aQzHYEqOYbBlpL83hb9TsJclOjz559gfan/O
 PbvmZv7xHpXQp3nZBpkWrfNmEPjU16h82XvJk7yc9WyUMBGNVnMMgBTTQBtXFdbDqVHx
 1V1E+yjMi3zfZEB5CPharlnXDST3PLc9lWzgcHq0VFsCamjTz3N6DKR1m8dGyJGNXKdy
 uAPDwlbiAqFSJDOGXbQj3eoEwurizH+W4Bjx3eBWjpjQNPNZIg5CK+b4DXjKFvqASHGr
 vSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854711; x=1737459511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=QXd1nzHvy3+EbBf+P/H7doT7mjrF2fIfZH9ntTm0NdZss/8FcMe1KGHhh2dZwrHD/w
 y3eyva6i9cPTRyhVoU1jUyJSSsZmGBdZTniFgkOe2F4PGHZVrioxKUJffa41SbvFO97H
 d9bmBXg8DQskfBptFOVtTuo0UycJM4rN3Fc6sz337GcSeVVSoVsqkIHBdrUMlq+MMhWm
 TysZl99Zs0BE0WEWremDfoDVzFi4TFV87N2GD9dEji3C8VXDzH5nPQ2SGo6lA5nqnvjG
 NV4rO2ysUFoZyBN9VynwGNxaTmr14TY1cqIp6LGlGjZmcs7bo3PpTkvME4+XSW7PRb07
 Zg8A==
X-Gm-Message-State: AOJu0YzpHf4qGwVRkM4IOtGoh6zW1lsOCc5U606TUmYfXtLNiAJj1AHG
 6XWRMMHqKlY2Dgb91w5LnkK/GFJAdKVaLp1kB/TnDXM8KQejbxtc9hlFL31DlBU=
X-Gm-Gg: ASbGncsauFbBlp5E/Z3+NbPjWRxBrt1wM9V5+oo7D/gqMG6+cSUvtz65QdPqYKHll9n
 c8Ik2gV7/DqViICrcTXNvKUvmVwfaem9MnokyrT9jhkDybHMllH1bGpnyf7gVbQsALPWTJpeaUz
 ZjOuWxZVTLke6ARdgDwmR3F6JbSyXa+br91tJ6sEEPano9lGTZ3gyb55hTxllSXO40NRwnR4Q30
 tw6Rys25q9SQOuD3K+GdMEU7yU5aTep6sYRn31rJRcvxrfsoDTXuHc=
X-Google-Smtp-Source: AGHT+IFLfZIU2SZ5BzGyrqtX0pYu6xnhkkOEvt/UFwJ/eE2R+VR5Mb1qF6clHgepM8x+nm4RMOMElA==
X-Received: by 2002:a17:907:94c2:b0:aa6:824c:4ae5 with SMTP id
 a640c23a62f3a-ab2abc9f6e0mr2178659766b.56.1736854710675; 
 Tue, 14 Jan 2025 03:38:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ecb7sm618677466b.26.2025.01.14.03.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 004F35F9EA;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 13/37] tests/tcg/plugins/syscall: fix 32-bit build
Date: Tue, 14 Jan 2025 11:37:57 +0000
Message-Id: <20250114113821.768750-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
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
---
 tests/tcg/plugins/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


