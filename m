Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA39E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfiQ-0001iZ-Df; Fri, 20 Dec 2024 11:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhM-0007zz-AF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhK-000862-SW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1846838f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711472; x=1735316272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk2kJcFJiTxcXpEmnTEW0065NBxhhN/Zlic7ABafI0A=;
 b=azyLyrnGlqw3z2oEckNhRA2v1AcIJlkgutMSKKqQmK6uy6pJCblrEeasS1PGC6PSMe
 oTu4PyOWB/r/XtphXJkSvv7e3H5+UAZuB0lUqtpqpf+OowEMnp8d+haumbJ+cVc6rsSx
 UtKmCCBOxkT5LfVeqTix4wsf3OC/aUBeIAPHqtYiTrQVydRENBXJkdbZcyjYsb+ntYOC
 l0/JkTdz97zMzMQzS0uyutKa8NToC+B8vYYUHYeSqKYerAG6k1WoH0cXgr4zS9usLkow
 uRnWQSp3pUlZMOF2n9Un9G6ZVHlVEhb4pQ6RuAYc2Z2hfPS/oAUY5Mk0HlfcGRKPNFBl
 VNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711472; x=1735316272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xk2kJcFJiTxcXpEmnTEW0065NBxhhN/Zlic7ABafI0A=;
 b=v/XosTFzP/1ewTgNlUEDlUcl3PbWqFRPQSY3GwztcAlil6H9w/p6k57jQCtXdTJNqR
 X209omwPAda9x7sda/kSFVJ2N8zHt8MX93ElNBnvwAwgQTXnP78+k4o1xlQbhr2huQwb
 nnsorBTlJyrKszgS/yq7J3sAB7IQ9ro7cDuJfOHXOFsaMdxSHYeJyLoMcMxAyLniXWpA
 0nXDMICJ+D/h6+8KUdYW8kCw9CBFIivkb58YHG3cjguzpVVvkj/6kG4V8T9vzDxDqx0j
 M4ET28VQ3hflfS4PqhgnJfoPnvSNELS8VETi8HgMQ8EszGizRBxT0d1w3QZiveVZ40ai
 yb8Q==
X-Gm-Message-State: AOJu0Ywcvtjmv9NyXF75Qe6cTHaUA0NbW6OHE46dD/Qerj4PTEych7tV
 hnnXmgRGzABHbHEPP1QTvaTRuxFpfz9DzwU6C2BK7JfVMMC/366zqNU9XtmdEpf9o1uBoP9GWed
 G
X-Gm-Gg: ASbGnctb/tlH/Gr8O4LOY+L/QVsyxXNbU1OPiNme2LdNnYn45I5c5cx1YKRB5M+xaCN
 Fp0nSGgwQJEy4QKLdCHeKut//pgok5vqHmSp0Z/ZRmHwZ1nAIQMf0NHX9gjBFoCf/Wf+y68mFE8
 pU0gnlCtvDdyLfz0YuJ8T9w5GYNjqUzwd1WQNrnmgZra4GLjlZoK/qkF4AXAC0z7eLlAR+kPnTb
 nEFvRrWh8RhgAf9jeOtznfuzM4XT/O45IBVtkbBLm65lIXyew5PCesQmIvicYHGf7xQ4Nx1AKM=
X-Google-Smtp-Source: AGHT+IGnjS3Us3qEchOtb53T9VY2BwGMSZpHVkSuNQeVICijurEHzLJi2Nd2fHGA7tzcD54shjKa0A==
X-Received: by 2002:a05:6000:178c:b0:385:f17b:de5a with SMTP id
 ffacd0b85a97d-38a221f316cmr4256230f8f.28.1734711472390; 
 Fri, 20 Dec 2024 08:17:52 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008b1sm49311365e9.15.2024.12.20.08.17.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/59] accel/tcg: Use tb_page_addr_t type in page_unprotect()
Date: Fri, 20 Dec 2024 17:15:17 +0100
Message-ID: <20241220161551.89317-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Match with the page_protect() prototype, use a tb_page_addr_t
argument instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-6-philmd@linaro.org>
---
 include/exec/translate-all.h | 2 +-
 accel/tcg/user-exec.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
index 85c9460c7ca..c50661a05d5 100644
--- a/include/exec/translate-all.h
+++ b/include/exec/translate-all.h
@@ -27,7 +27,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 void page_protect(tb_page_addr_t page_addr);
-int page_unprotect(target_ulong address, uintptr_t pc);
+int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 #endif
 
 #endif /* TRANSLATE_ALL_H */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 06016eb0301..4ed6dd19f30 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -696,7 +696,7 @@ void page_protect(tb_page_addr_t address)
  * immediately exited. (We can only return 2 if the 'pc' argument is
  * non-zero.)
  */
-int page_unprotect(target_ulong address, uintptr_t pc)
+int page_unprotect(tb_page_addr_t address, uintptr_t pc)
 {
     PageFlagsNode *p;
     bool current_tb_invalidated;
-- 
2.47.1


