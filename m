Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A04CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ulm-0006qy-5R; Wed, 24 Sep 2025 15:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkL-0006Ix-Uq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkD-0007vn-Pl
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77f41086c11so183028b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740490; x=1759345290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3tkOqHK5ejgU7JIInVN+rKgDfoWboky6FhXhkFrd/5A=;
 b=ZXCTcdpkYhbOfvZmODfcg2J911Im1VGvZJvloM2KZXTPBcw5as9+SCXzq4TsxkHIBJ
 9mhglj3TxtBHqnbp9FyHMrV1a4zG7rXnIUgWszrGENK/Z5wKDQxIr8+XYuSU25QREeSf
 79UzWkTVyBQdePK0abnWndZ6M4BeEy3Ksc6g2aGhoD+RTHn2xZrgdr4D8SZpGXkqGlaX
 9+djj65Q1rR87h11Jgp/++Mq3rWzNvoV+tdPXrt9HnT913JrSycbSYE0UrzFac0s9H2e
 E9iXZhzBnRxylDidyxBv6S9U7KvXe2K3o7loVI21BZLJhxkhUPXtWFEHpYeFHazwMGDC
 c03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740490; x=1759345290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tkOqHK5ejgU7JIInVN+rKgDfoWboky6FhXhkFrd/5A=;
 b=v+ECwKeuUdMRomsUl4KZC0BGPRm3JELFNU949Az1Fk7Rv01VBlZF+J7LyUO6nAHTtf
 Qu9AVJWPzF/Vm1XVONIxYqUxo2GWA1jSF286DiQMpuHeHqcVDPyRKol9K+hyZgDNNSdj
 fG6Jjj4boQ79wt3WRVqJNMuqtwjJJ5y+9m9wI0c9AYQWo8qRIUA2nWe8mzCCLU5ntLSe
 hTemfVe248b2EI/X8GOWMGARannflKbEKO7eh1E0QNTt3QBFWQdPU7y9FrvveIQlN9/n
 oWbZGSVFrSTmd2U8jXe7isgVefx4DdP3b59mK+VpgZFwHhAqC4BT9/HJvSRWpZqNzxsw
 CNVA==
X-Gm-Message-State: AOJu0YxyMyOMfvlQdWExRX8R+iBtaLcV/VZhp+FOCHhY8806SJd7TnJ6
 rs0fbjyBEZRKDuEg6DMp+5liBw3YsAFkgLD38GufbYsWwkRVy/NF9bxIzvZbHUbnWigwpAMuxIq
 iraUA
X-Gm-Gg: ASbGncuHoQ94HjjjFSefldTmE/pSrOPSeex/hBH5k2qo8ooGtcxuKDZLLfp23FnukLI
 q0+D51YlXV8y+AtirEh8xZnWpRXElU+xRfeTp94GwS6kMkzt6HLL84SgnXJeTuN0ZW/6LWjcPH8
 hl/n9ZGTqZ0gGhwtiF/Nfje8rz+xauGFZPv4stQeOZlipT4ZypO9SI6pAJSNI4yX+uvyknYlBis
 hqnOPQRHjr6a0djmDB+qv4P0dgLHfaGM5WHlfMzCi/FeQ7v2aLcmhtUP5clicQRbFCjXOrVhn+M
 hU5e2eDkpMm5lTMClHIOBM+1GKEP9cZFL5wXl2+5jboLF/7+zw9om5muKYRG/NTXmOONM9qn4RJ
 5B26XQSxQjEM+flydTFp6+7ruMmGk
X-Google-Smtp-Source: AGHT+IGbxKMjFi8NiXbpWrvCzXHlCc5IasZFQZISefCE+iB/1VDD91vQBBMkykz0GW6AS9JaWqQ1Sg==
X-Received: by 2002:a05:6a20:3c8e:b0:2ce:67b2:3c40 with SMTP id
 adf61e73a8af0-2e7c4dac209mr756754637.27.1758740489743; 
 Wed, 24 Sep 2025 12:01:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] accel/tcg: Improve buffer overflow in tb_gen_code
Date: Wed, 24 Sep 2025 12:01:03 -0700
Message-ID: <20250924190106.7089-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

If we only have one vcpu, or within cpu_exec_step_atomic,
we needn't jump all the way back out to the cpu loop to
empty the code gen buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 31bc0f8bc5..da9d7f1675 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -289,6 +289,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
+        if (cpu_in_serial_context(cpu)) {
+            tb_flush__exclusive_or_serial();
+            goto buffer_overflow;
+        }
         queue_tb_flush(cpu);
         mmap_unlock();
         /* Make the execution loop process the flush as soon as possible.  */
-- 
2.43.0


