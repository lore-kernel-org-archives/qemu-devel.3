Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A0ECD9A8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6uf-0004dh-OV; Thu, 05 Feb 2026 16:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6ue-0004dQ-La
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:29:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6ud-0002GY-1P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:29:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so474475e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770326957; x=1770931757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnKiFlav7UgaZxndqkDzb7Iemff3Mov2XWTDysgHbc4=;
 b=YKoVnyWyq/Cby7ncCtyVB96GEupQCRZdhV+89pe3NOqrDxnbG/buIGGNBY6IhMJby7
 HnGM/VpGamh1V17zX06++WJvscZh6Y0QBH7rTjahoGHzflqUzebmG6DwpkFnnvUu+xQN
 zeD8GBvLli96Og8ZG8n9AHrqYqcrv+bIVCgLJQdoo+qZWvtqyrIwcFEK1lPeaIYKo5oj
 jotYWzekh9yo+N1zSqYN3TSZCIsRRZ/m7rwPzerYqAdXBmunokiweTEQW8rq9nXnDoZU
 S2a3aYe6KBSKDnMA7dO8+38dvHJxUCxiYwXPLOmvaAgQcHs4B6JntpgCsrMu2xD/KwiN
 Z2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326957; x=1770931757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnKiFlav7UgaZxndqkDzb7Iemff3Mov2XWTDysgHbc4=;
 b=GxGNeFhbSyrXxefQhuyUVvLVzCaaGqp20in3L2nmthLXT7D56PSsIGsxcM43zJoEdH
 TcvkhtwicDamdWeTHgzGcy40p9YCips9zraEB5ZFgVR+NERG+v8yyel4gAv/p1OXaOIP
 3Johs7lDQNPjt6l1h4vkijsUrJHyswyO0hKycvJ6jeNJbw5hFlj/E8drvsMOQp9JUkz8
 vR8rQ807R3rPf+3thd5PFRYtf01EMlhruD4twsoZFNMrXGdVSKIQUX/InXIvIFDYAG1R
 GFWHWnTWsxZ4eUQyVUWScImF6EicRdvESYgKO+QWftPjAw7wHVC325C8vJe3jR1tWDCv
 7n0g==
X-Gm-Message-State: AOJu0YwvLk0SU/9j14i3l9INGs8b9YUEaikQVMfjuAaq7l7f8I0ad0TC
 htg4K6LgWWPKzhLOT6ddNWYt/79qBwVszBGW4lR+wkdEsnJv45Jz814KE7tOlbdpZMI1LMbSHfZ
 HIrBYa6s=
X-Gm-Gg: AZuq6aJ4reumzS8gpVuvd1sHtVmSBzvmBNsOGrkvMPcagZVvftZI5Agdbw4Ll2B1cxY
 6jJsx9QpVgbkiBOGb1dKloavc+IdnExDcxFDCbs1n5kadJtFscbirU51v9X/+PhWlHXg16Vrv53
 IF2HgVuMXoCJQFL/QvYxgq4afTC6tyZw+4T5D3O5b2dG0V6cSldeHck8b2vVDLbeRWgxliUkCBF
 fCbOzAd8woKvp3kgs4h7t0YtgdbAHnyqt/2xu4OumtYLFLMlokmpqEAjFONEUQdz6VXC3SqnTTR
 0PntDX2ZZc5YuN1HYwrTPq51CYOYFUMgY1Wi119F7+DiXa/2H2ytRyNC0Mkaxw1OxAQPqLQPAj1
 ikZrZKa4i2fn1elJu6ndu4wkNhBRRADiBTzglLJOKMDW9X31Fz6F5lWS6dDNCIgDk62XPGsxUdA
 2RLftmJpHA3hb63Kfk45zbQs/6RKQm8ctPqmRaNJytO2JTFUgqJmqplNgcqqpu
X-Received: by 2002:a05:600c:34d1:b0:482:ef72:5787 with SMTP id
 5b1f17b1804b1-483201da065mr10652375e9.1.1770326956682; 
 Thu, 05 Feb 2026 13:29:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209c1a64sm1754185e9.12.2026.02.05.13.29.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 13:29:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/hppa: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Thu,  5 Feb 2026 22:29:14 +0100
Message-ID: <20260205212914.10382-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The HPPA target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0f8a66f7732..70c20c00377 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,9 @@ void hppa_translate_init(void)
 
     cpu_gr[0] = NULL;
     for (i = 1; i < 32; i++) {
-        cpu_gr[i] = tcg_global_mem_new(tcg_env,
-                                       offsetof(CPUHPPAState, gr[i]),
-                                       gr_names[i]);
+        cpu_gr[i] = tcg_global_mem_new_i64(tcg_env,
+                                           offsetof(CPUHPPAState, gr[i]),
+                                           gr_names[i]);
     }
     for (i = 0; i < 4; i++) {
         cpu_sr[i] = tcg_global_mem_new_i64(tcg_env,
@@ -322,7 +322,7 @@ void hppa_translate_init(void)
 
     for (i = 0; i < ARRAY_SIZE(vars); ++i) {
         const GlobalVar *v = &vars[i];
-        *v->var = tcg_global_mem_new(tcg_env, v->ofs, v->name);
+        *v->var = tcg_global_mem_new_i64(tcg_env, v->ofs, v->name);
     }
 
     cpu_psw_xb = tcg_global_mem_new_i32(tcg_env,
-- 
2.52.0


