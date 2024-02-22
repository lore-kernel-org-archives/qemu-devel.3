Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EAAC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvB-0007LA-QK; Thu, 22 Feb 2024 15:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv8-0007GP-Mz
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv6-0002gA-LC
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:54 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so1995085ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634631; x=1709239431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Utr6CY7GZcNfj8e7YUB3Ing2Y6m3UnMyzHBBd5nSQRo=;
 b=LhrWrRa5yphmSfgH8AFGg3m3J/K0a+zZpzn9L6X5jDFpxXTlHq+B629Nah2BMMFUty
 jhC/LsBfE+jWnCKYfozqx4Nq6BuSNeSwihGKnxFgX0JDvhSFPzZXODeg/cBVfQe84pr3
 au/uSZy5Bzgdm6TKUH8KF6JclS+H5iH29Fgvf+Fk3dFfY7V+8H+fk3hbLpJaskwK1Ckc
 dRySbb038mqI9zPQCz27xhlDgODh5q3OiZjQ8z+2Eq46ECAKCJliTViawLsmnQxu8f/1
 CV3QOMiO3V6MGXnhiVd8uEalmFhbTzzT+zhCTmohW4W/IUoN9vx6bK4qkTS/h6OyEFZr
 3UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634631; x=1709239431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Utr6CY7GZcNfj8e7YUB3Ing2Y6m3UnMyzHBBd5nSQRo=;
 b=qD7hPwdGgFiPYlnQ7bMQ1F5Ir9LK9crJPVukYPhtVM6COosGDxQXbgdzWGbvsleCx/
 EuEjRH5oPvmBoGkTE+UEUQ/mj3SkkZrDvi37K+dB3kXncU592YEohYXBVMCLBbEKfVzf
 iz1FSwev7QAG4h/XwAqRH+Zhit0m2A/nbVEW/o64JUw3VL3EjU/19lcYMQWes1n4uxHf
 tz6jcpo+28y7ORJDrUDswqAZH49NFN22O8skknjUYObe2fahVuxx5FiZizHBkns6sOd5
 NxtcSTC0KQ6JFtHVr2QtssP0U41gyce9srHcZlgfbLSY3b5+ZLIYqpboFMg2a1juqFlI
 HQxA==
X-Gm-Message-State: AOJu0Yw0OsflRsjP9ZEdMaSkPw7Bix/B0SRxpxw/YN+qk/5XAs7vzVrM
 5GJop3lTg0rk3RzA3HulgQK0WXo0B/cx05no0XTKoXpgQNQDCEFKHhIC3xyDTeSh/EFKqEtNf7r
 s
X-Google-Smtp-Source: AGHT+IGjZgQixJ+pWhtnY9g01dKeCbpIoA1KNjOhjs64feytNdPX1hjHmmQ4xu4xWt0nDAfm0dhpZQ==
X-Received: by 2002:a17:903:2350:b0:1db:fc02:f96e with SMTP id
 c16-20020a170903235000b001dbfc02f96emr12801397plh.24.1708634630848; 
 Thu, 22 Feb 2024 12:43:50 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 16/39] softmmu/physmem: Remove qemu_host_page_size
Date: Thu, 22 Feb 2024 10:43:00 -1000
Message-Id: <20240222204323.268539-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


