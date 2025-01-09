Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5920BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzi-0004nc-8T; Thu, 09 Jan 2025 12:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzY-0004jF-Ua
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:46 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzW-00070h-Sk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:44 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa692211331so220715566b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442401; x=1737047201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=mCHYkwnLpwt2v+1fH9+Oi1r3b2jCtd7AM4Wm+aDuu2Q1myIHVBsf6G+ikKS0+Dk0LM
 yk5bWsGI9ZPFqnkGUILduPzyhGgwGDaNRp5BLmk0npjYe6peNS8tATr9Fu4ma4XyI5a4
 PotSxFiBDiZUxLwV/BH0Rrzym+TpqeCpbRRos2WQ0kPdGgwblMXjs6fNfGo/gaOZv6E6
 aKEEMSiV1sZ0NXCGaCMUVNLOpA/8ZGZgne8E4fVXL515TPRA14cTSaRQM9Pub1dckmn4
 J2Ch9ESE1krx/ebqcFQZdXR0D67jEt/o4K6Ks0LBYVIJXBZSGHfCjMjwvfxzmVtum05k
 285Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442401; x=1737047201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2wuVbnc7sEvmDoO7gmBrl9t4VirrSgx6WEqdbF/SEU=;
 b=UcfhxehFNUa2LpJbo6Acc26WgNqgiahOMwa6DtdKR/w2FyIk02liU9fpD3qJr6QOj8
 ROGh/8zyHowWxDbkO+ZLY/r59BGQbvq8TSQLaYNQCB25SGx/MqKtQg8AuKy1wFCUzk8x
 U4dEOJHSg8OQjKeTcG1x4JDKyEz++9eXJrMtWdb2wV+E+LPQGwAGtnGmUhQvBNSvUpaI
 9jDop9MJwYPtL1pQipmCX5Sb8UxKsPRiGke721FPfWyfnat2K4A9Yv2IWgyEw6IHyxGr
 U0wgNd38F8C7kOZeWpiM/ViTn+coLpER9ZPXwf7KIrJ90DdJeXsxEpVGDdrfIDoyudFL
 EdVA==
X-Gm-Message-State: AOJu0YxKPVh/nSnE+RB8iLsZ/S3fDWPQFqBBMR9q08X7DoxenVTOLtwD
 Ue3Kon5nqz9FtKE84Yj3K+Am8qv8N+6YGn7rvTcslcN71GDAu41e6/FYUHYetIg=
X-Gm-Gg: ASbGncsZ/uykLGPrE/vqRBJoqAXOOP86Tb2Mc2zUtlpWUPGU5fkhL7btlS4emrxF7Qw
 JjugwuFAAc2WNQoA0Jy+p4WG9vWbscJ8r6+O7U3/40yZVsGdylVGi9vD113U+ul5hkYd+yaP23g
 YxqCxSqHzscRLw3b3SrgaDzYdXgwVYbwsAdowAvtwpryYQHbdDvbgiRqZ8jJ8I0/cXI3x6ntqkI
 s9P/7n73vY7Ffn/54oPxz3KP1Je6FINfHwgb5OBQeBS/9Se8NWO4Bc=
X-Google-Smtp-Source: AGHT+IGlUFjUjO8fNVMvcLzzanpFprdGrtWmaOlVCu2kQYatyr0V4hy1wf+wTBXYl0F6ztE7ajnhvQ==
X-Received: by 2002:a17:907:1c23:b0:aa6:9d09:b17b with SMTP id
 a640c23a62f3a-ab2c3daffc0mr320885366b.28.1736442401006; 
 Thu, 09 Jan 2025 09:06:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ecb7sm89462366b.26.2025.01.09.09.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C85A60030;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 13/22] tests/tcg/plugins/syscall: fix 32-bit build
Date: Thu,  9 Jan 2025 17:06:10 +0000
Message-Id: <20250109170619.2271193-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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


