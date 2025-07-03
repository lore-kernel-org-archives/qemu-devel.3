Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20364C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNob-0005XR-VE; Thu, 03 Jul 2025 13:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoU-0005WT-NO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoT-0008EE-4S
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so33385f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564011; x=1752168811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdRe1Eyp3xb/gGYQ1LjLDITtq8GdvFlAG//ViqGqDSk=;
 b=pxKSZnXbaUo3vwtV69vxKhWu5bbKARFobIh44VefwAk/mrTlhkwbZ9AyRwF033vOp5
 B/dp0/mSjniCYCgNbXAF6jAe858gr9Gwenb6UMIzIYoOd5UWFazqZQKtBy5a5DuzEOhW
 YwFBA2R0kRj65K4wEE/l49BVxJoce1/Y4twoDYObAsiz2yccnAl3UztKlT5daWRZAMnc
 EBa+kIiLd1i4akIq9T+sEFwij16lR/ve5Jcv7yCsCG5XNJqfeoi+QRJQzALRHX9bavFo
 kbj4tDsrnbWhQB0HnUBhSudA4S5kIvldWM2/5G4qmKrT5sLTlD+PNyzq94HhSwHVa0D6
 xlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564011; x=1752168811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdRe1Eyp3xb/gGYQ1LjLDITtq8GdvFlAG//ViqGqDSk=;
 b=cfQ9fiB1KXvDRKosF5om2mQFdrQka7sJBvQvxesV0Ok7tKZvSowdu23KHFo4tkUfXU
 w+QFXJ/dlwF2U8FWlVah1czLJyhHshod0cOI0s+Oe4vTE1uhlK1GkaN2i1KMnQ1diq32
 oPEQTMDC35h6T4zXSsL1Qrh7dUDjayxBNQRPaw/Oweic5eqf8BYYeShw4kC/JmUct8e3
 1HZwvPZTFrxu/cMc6jDggSzS7JCFt6zjZ/2onO0Q0E0MtpAzfXf5KCCQXqrdVyYQqQuA
 pcIq0eppKOkId13NoVUvv30HzWHiImXst2pazs2fubIyrJqSocJ/g/z+qTKpkTibo0uN
 90pA==
X-Gm-Message-State: AOJu0YyLNOp0ft4IXm/7b3ciyaLUcuxctS/cE1ict7CP7swu5oLCtcHC
 lJ+4RLmQHnmHgW4QnDznLi8WkTpIJYQfZ+Q9GYpcj66JYwkCEM1QXLaU8esYtma9AETz4CVVzdQ
 jIrcSTgA=
X-Gm-Gg: ASbGncu764jkKGzfe0XXxsSDRqlnJ91rAh+9O9/i38OwsjsVu7PkRrAclCb6wAC7Mxt
 uKWcXR4bOsiRQSSSWa+qHc+fFSsVVkKAXaJM0DGuMRmSzqwka9XocY53Zn7NyZPSdQ2wantpDxn
 oTsJH1RWRnFjPDj2A94pubIgebG5niSsnGxjrAYVf6+h/V9UoYBA18K3ScBnseBaAOthwOcg1tH
 b4RCqt1VrIiuLUPCZyjPtkW2lXlCBOFUUhCuqKB0C3UNaknD4k+VxqUrM78oAPXiUIyYvjnX2bd
 ILgi5DoAsNqoK4hmzfAZwHYA4BtJUfLiufCydwIcy+4Xlc5b0RqElJXETAeiRs1YyoiEqFw4B2D
 XqxCPhVrdxZew6VN6DWvoePAs1g3hxZYSekYuSig2E2TtST4=
X-Google-Smtp-Source: AGHT+IFlBhhDe52JTc049hOOly8Sw7KDsmpNVnTPFbLoZLu/v3WEo9FRpfyRo8F61cd3YJZvEeggTA==
X-Received: by 2002:a05:6000:4022:b0:3a5:2208:41d9 with SMTP id
 ffacd0b85a97d-3b32f28d80bmr3833770f8f.40.1751564011250; 
 Thu, 03 Jul 2025 10:33:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b966c0sm320312f8f.52.2025.07.03.10.33.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 08/39] accel/tcg: Remove profiler leftover
Date: Thu,  3 Jul 2025 19:32:14 +0200
Message-ID: <20250703173248.44995-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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

TCG profiler was removed in commit 1b65b4f54c7.

Fixes: 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 7c686226b21..344ec500473 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -141,11 +141,6 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
-static void tcg_dump_info(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
@@ -196,7 +191,6 @@ static void dump_exec_info(GString *buf)
     g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
     g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
     g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-    tcg_dump_info(buf);
 }
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
-- 
2.49.0


