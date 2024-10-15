Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADADCFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjV-00008v-15; Tue, 15 Oct 2024 11:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjT-00006l-Db
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:11 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjS-0000hp-1m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e06acff261so3678285a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007108; x=1729611908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHZo240/MKAErrBWgP22VqVce6gGXpeJw8VH+45Ycx8=;
 b=bF5XwocGiiIMkaND/mOr78bBQnuvMgxcoT/khKVInmDBm+XhH/zJ9n/1DPaaNz1JFN
 XTarrBCL67lA0Z+nX743vN7onYTdsdxdqbpd0OjPLsXv75s8Bo6Zp2iizUIr7o4+2PlD
 7PClDzBRsIQ/loXeqGjHScaIFBJQwzkFkagt4lsH2M6QiL47S6KYnPuc9eD3NzheM11M
 /cDMAO0MZba8qYs1W//fxaZ7AMVmVJrEw78yitFEucmctujLWUOIULGqWrUrgo9vybNP
 Gl/8DYztW/9oRB1TgglXN9q/pLBSZhuIV60vVOoNPZb8//PgYRjltmPV+ya0BSSR0XpO
 QAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007108; x=1729611908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHZo240/MKAErrBWgP22VqVce6gGXpeJw8VH+45Ycx8=;
 b=rn9cUZ5tWmiK+hmxDGTc1+vyyF856DW8JsCq8haXc7vswpDz85GIO9l2JCZnbWtVO6
 E9Y7Zw1nS3TeLYWCQHTvrls4Z3QzOsORNn2Mz015y+FzwUqGA9FPHg0bD2tUkROiv8Ds
 UrSzOUF3Gy1sgLNiPj4AOq0XU5QK8CIBH94rfIRYw+BoscCuemhKeqCw8uQLzcp2juAc
 h6gnbS13OpE2YxhyZ9wdQsD7LiRYLBCJrk6fryRcqecXXMEna90KsUHLL9KRlgXSezS9
 9girt8w+Rz6Sw5y0h3VepXFF9nExt2QPyyGWJgNmDR9kcag7JpdTqdrhukBZlxmnN8f8
 UgZQ==
X-Gm-Message-State: AOJu0Yy1D6Ueu1SddwRxab69CuoLPtm4MXlfKg+WrJj2NyZ4XZRC5OmB
 7LxdX5eoGH4oQNXlEvI1ljZbwzKQPmAJioFOepcdtSSrYB2eSn9odUa0+HKPVe0FnDZnzUtaOzb
 T
X-Google-Smtp-Source: AGHT+IGXlQoL40ZaflYaRzMdlDI5rCeFVNJtXlZbSR7n5Hkr4o1y9AewTgLOHp9SmfkesWAE9VDWEQ==
X-Received: by 2002:a17:90a:2d8e:b0:2e2:b513:fdca with SMTP id
 98e67ed59e1d1-2e3ab820d96mr747060a91.20.1729007108327; 
 Tue, 15 Oct 2024 08:45:08 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392ed396asm1971278a91.21.2024.10.15.08.45.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/33] exec/memop: Remove unused memop_big_endian() helper
Date: Tue, 15 Oct 2024 12:44:12 -0300
Message-ID: <20241015154443.71763-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Last use of memop_big_endian() was removed in commit 592134617c9
("accel/tcg: Reorg system mode store helpers").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241003234211.53644-3-philmd@linaro.org>
---
 include/exec/memop.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index b699bf76886..acdb40a9b3b 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -164,12 +164,6 @@ static inline MemOp size_memop(unsigned size)
     return (MemOp)ctz32(size);
 }
 
-/* Big endianness from MemOp.  */
-static inline bool memop_big_endian(MemOp op)
-{
-    return (op & MO_BSWAP) == MO_BE;
-}
-
 /**
  * memop_alignment_bits:
  * @memop: MemOp value
-- 
2.45.2


