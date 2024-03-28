Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0155C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpgcN-0005qA-Gs; Wed, 27 Mar 2024 23:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpgcM-0005pf-1H
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:39:54 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpgcK-0004Sf-FX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:39:53 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso402790a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711597190; x=1712201990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aXBZFu2s4VI4gx6Rv0AU3SgCaeiACnYHqJQpFd1hK8k=;
 b=Puc2x/DiavTgzB74yD8iMTOjGdeXKg+ApuGIWnzqV44c2Kprkn20zxHJf32Y4zCbiT
 kuFYZEQhxt8z2dYEzFbK6ycO7IO55B7Rjz9rzUP5YCY0D/SolVeKMOBu8obfg8+qfcsC
 pCK9wAe8Vg24xfbVJLjCbOG/1oUFXBftrHLW8Dk189p098ntX1krXFgcSt/8Q37VvEj9
 0uZvE0mSfEVpA4WEC2b1yyvFzu9XZwheNnAm9sHNDcw+ozBfvKQPCEq1Ljsr0MFkEosG
 3wgv32YnErVcIS31GZ4XnHEAqz3YzRUiR7rrwRmSEgAa7VMgZq1zvObPXjqZbf0if97N
 4VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711597190; x=1712201990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXBZFu2s4VI4gx6Rv0AU3SgCaeiACnYHqJQpFd1hK8k=;
 b=Clg5Jd4qFA9au9Oj6FcEkfw1uqK8dEtcJVNcd25lEPH5tfdMiid3/JAi9z3W9w3HZS
 rUjiu6v1sZ1hKee97CJcQqMytM4lJFScWIIHWwChSc16RXU8qF5VppCWBR3qUch42WBe
 jU/0ROmOrlQu1ZhzIvGtLv8isCFdFYmoBZiWNBIz88+oAjtAcDCt594lTKsVBwklteOu
 ix82YgNoqDN/Z8qGVEU6Rq2E3uL9dWI0iXje5IjqqGOkXXyBUl6Z16+kHdDFIbbDMEnB
 wCgGTQkxRrUxCOiUepxRJjNXX2IFQmZ41PDq7QRDVmSSyYC+fsK9iM9SRvpTewQXZ9zJ
 0tZA==
X-Gm-Message-State: AOJu0Yw+v1B/MfjdKIj1sxlMP06AC1jxO2YypMqZ6EIMX5mTo99jbr6t
 f5ovtYCbw5grGDS3Y4pk6oKhLgK6dw8IAYJuzMvxBDXI7bnrxyazG4YzR3eM9zyFREyHwOYpT6I
 v
X-Google-Smtp-Source: AGHT+IGdt5oMEKgKYJFtUids8DjrSeI9jLjTVM7Zc3pD+7/+XCvlnW9eiPAZzhi/q18HhYzaNSvX+A==
X-Received: by 2002:a05:6a21:9990:b0:1a3:c4ba:2bb3 with SMTP id
 ve16-20020a056a21999000b001a3c4ba2bb3mr2254378pzb.9.1711597190526; 
 Wed, 27 Mar 2024 20:39:50 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a17090a014800b002a04f430937sm392622pje.43.2024.03.27.20.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 20:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.0?] accel/tcg: Use CPUState.get_pc in cpu_io_recompile
Date: Wed, 27 Mar 2024 17:39:47 -1000
Message-Id: <20240328033947.1268943-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Using log_pc produces the pc at the beginning of TB,
not the actual pc installed by cpu_restore_state_from_tb,
which could be any of the guest instructions within TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c1f57e894a..83cc14fbde 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -634,7 +634,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-        vaddr pc = log_pc(cpu, tb);
+        vaddr pc = cpu->cc->get_pc(cpu);
         if (qemu_log_in_addr_range(pc)) {
             qemu_log("cpu_io_recompile: rewound execution of TB to %016"
                      VADDR_PRIx "\n", pc);
-- 
2.34.1


