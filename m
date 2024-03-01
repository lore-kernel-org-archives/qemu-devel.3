Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF19C54E55
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByU-00068P-GF; Fri, 01 Mar 2024 18:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByE-0005cz-E2
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:14 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy7-0004KT-K7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:14 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso27275035ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334426; x=1709939226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Utr6CY7GZcNfj8e7YUB3Ing2Y6m3UnMyzHBBd5nSQRo=;
 b=lWQYCvevQOkfEFQjadXLdX9jIO4yXAwVkrHtd1OaNxQV4Z68AtEUcxNqJWN+1i+d27
 vx6swDWuUOdVuf9UapdTPzBEYdQ+M8AC3GLihcwpwibJeIdyhkcJZZwSAZ0KXHZKnkpf
 s3ji/LNRUaERcV4FYA5NZAJFIYlpA5BqGNicdcidzYiQrDAKLUwfrb62Ln3Vc5TMhVrQ
 RFV+saBk3r+TjInxQjit+s5WQWijoj6vB0PIbBEJyvV85oIc6/iHiH21mqVV8oQYEMSD
 82izZh22Dx7yF00fYWhkbcZkm6r0kEhrcs3+aDdO9RXhndc0YyRDoaSuRZwkGkfRncHn
 STpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334426; x=1709939226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Utr6CY7GZcNfj8e7YUB3Ing2Y6m3UnMyzHBBd5nSQRo=;
 b=ri6h0uEHqKDRXimBFxfHTBSkiFIsQ5+olcQTfS9uai6zmdca2OsxSGA5bdCMgRM9O7
 I6Yxln+7eU/Us8XvpPHWCD/ozgNDfdm8yKtVuhv2m0MHmGjpO47gvLXN31kHhyVjQI2a
 gx7Gs9hT0aheVk1AOoApoVWCkZ5mMffd9+i2xrVwMD42Ha7CBfiAokBIgVJOAI+y8Kq4
 npIZp8zbTVmWHSNrc6DwKeSeE0T0PD5slCBZitPmirEov4x1rt70ocCMGEyI02KyjlXb
 RAu6q60DrGphkpnOKeYNVUIsytDOt1yxGKKNrxErizjdIekHY/5pbUlIIiLI3S8KQkVG
 FiGw==
X-Gm-Message-State: AOJu0Yz7SaCIOqdZF825GS14hZrlLoRxYgFqdp8FeiEtteCpVjIl4vCX
 fCTqnqhpDliaITbWlrqSp4La34A1UEf44WAKzPf6Z3fId+iVYbnQFs3VeWBm7gz2M7rn4FHNFS+
 k
X-Google-Smtp-Source: AGHT+IFU7/fWNsnNRqtkS+1PaX0eFqi6eI4GMdj52oGR7oj2CbWuW9HwE5+TSiqGWpH6r1jHtB+1zQ==
X-Received: by 2002:a17:902:c952:b0:1dc:a84b:e93b with SMTP id
 i18-20020a170902c95200b001dca84be93bmr3746021pla.4.1709334426438; 
 Fri, 01 Mar 2024 15:07:06 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 31/60] softmmu/physmem: Remove qemu_host_page_size
Date: Fri,  1 Mar 2024 13:05:50 -1000
Message-Id: <20240301230619.661008-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-14-richard.henderson@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index e3ebc19eef..3b08e064ff 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3511,7 +3511,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
-- 
2.34.1


