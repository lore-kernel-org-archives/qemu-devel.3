Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B5BFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmu-0007Jh-Ob; Wed, 22 Apr 2026 16:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmr-000780-Ba
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmp-0003jW-Ez
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so76761085e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888181; x=1777492981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W7JnsWSD583NwCfXBcMoII3DZMxZeD/F0vRaJaEdiuA=;
 b=TI87HMMwjrK05zmj/Zp2mEw8z0ys+0YWmcEHjeLAfp5Ni0OMBi8ZTSty3uk8dR4M/a
 zD1byw/BjB396KZ9ihd9zCTWJCQ++8gRoXZtzYD1yhMeQ1HwWyAPGPl/Yzo6sJDmcFiu
 Bt8cIOq9e3u0WDumg6skNnnzbZ0sWpR9F82Pll25MGvhbgAZcEZFZ7N9FihX7xwTE5BP
 k904NBjqqzEj9HskW2Pp2lcw6Py7Xl5zeqTg2Pg78P/JhLnUkVWIl8OZBys1BqTVCX/h
 MbY32PPdxR0G8KywnVbLowQgzluabvE+Rh7PVW90+bfqVp9/jEHbMq1a7iM9F7ZF8qhf
 ifqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888181; x=1777492981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W7JnsWSD583NwCfXBcMoII3DZMxZeD/F0vRaJaEdiuA=;
 b=Jl1IX75/20ZUp7QgvXnt2wZ5AikuHRB13WZfTXx3djujGRjZnrTpZhWY+OHyRX4a0Z
 YVnZYqbM5kTBJ72+TwjhvkQBeJnN2S3yilaaZ/529VcO2hpdGURkXxoEDmAj252Xunmh
 e723F6SDyzJdQdsRz1BMxT93PVWAOQuZRYRm6gr0wCnhhmCnqk5DZacRioKWIJLLldJU
 zXIHjnqstp2en+C8u38+/ptnB0O+++37x+f3LKwXYzYJ570WS9sjfFrO0gUOI28GMcJQ
 NP6HMxPo8K4LI6eqPKy2uv6eK3ex9vQBsAnjfu7YRpSAhncvdLjYH6Sh7k9PmkA44J8B
 HFTg==
X-Gm-Message-State: AOJu0YxsDcv8zZiEWAA585vBl7ewBPd5FA13sDKy1ueuMRDqcSUkx/7d
 1KxEYZ1bA4ELzFIxRgJE4yUZJqq+ulS7TtxoO/1HWeuQMkCeZyaiZEdzKFKI6dN0YYYhdkPWsuV
 2EbPPsjU=
X-Gm-Gg: AeBDievdCXumqKVXSK7L8CkF+V4nU9nIcIMPI5Vaks9HVVhHHqN4KIzmRQ+kUXgha6C
 0cbr5VxzLPypzuBxYRm3Yxk46jraPUaPuYppHVQlQPZSz64WLzfzpssV3lQzC97XNG2Y0rG9XI7
 s7HhDhAuHVsOzoFSBVfDg2OjGDiz0pyuKaM1hycT3/KaYOoV3lVYiy77yBIV1fgt764AbpZ1MiC
 m1WUqYzEsqHVyL46Z4FXxtfM1kMFKnxvFX48AX21Q1xadPqXiK+b6YJEHPd88prAtst0q4/Pqvd
 Gt9b9FzA+tHzCapdrDKqSEBCDxfVi5QkpxXMM1wHiJFj6iucSRwtansfYKqFMZNEarWGD9mTjzW
 Cr3l8w+huXDZPfv9OLGl+npOiK/ECyXHnMDVGXJs+IT/1Z2AToFCZryvCEcHjujdjUjhhOVgcNu
 mZYcGvr6k6Iv3ADxzXC5jOZGGulkKVwPUsFRkZSzy1qm6HWAc7+QNM7IqJqYVWbw1xGdijEpKZu
 lyA66y/lRg=
X-Received: by 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id
 ffacd0b85a97d-43fe3e144b5mr38594562f8f.41.1776888181339; 
 Wed, 22 Apr 2026 13:03:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d112sm52195067f8f.29.2026.04.22.13.03.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:03:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/48] hw/sh4/sh7750: Remove forgotten abort() in the
 MM_ITLB_DATA handler
Date: Wed, 22 Apr 2026 21:57:42 +0200
Message-ID: <20260422195746.88865-45-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently aborts when the guest writes to the MM_ITLB_DATA register:

 echo "writel 0xf3000000 0x11223344" | \
  ./qemu-system-sh4 -M r2d -display none -accel qtest -qtest stdio
 [I 0.000000] OPENED
 [R +0.004476] writel 0xf3000000 0x11223344
 Aborted                    (core dumped)

Looking at the history of the code, the abort() here has likely just
been forgotten when the register handler had been implemented (it used
to be a reminder about unimplemented functionality initially):

 https://gitlab.com/qemu-project/qemu/-/commit/9f97309a70f12df5f9104f1f

Thus simply remove the abort() now to get rid of the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3420
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260422075429.341409-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/sh7750.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 3ae71f99fe5..6aa7f637734 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -687,7 +687,6 @@ static void sh7750_mmct_write(void *opaque, hwaddr addr,
         break;
     case MM_ITLB_DATA:
         cpu_sh4_write_mmaped_itlb_data(&s->cpu->env, addr, mem_value);
-        abort();
         break;
     case MM_OCACHE_ADDR:
     case MM_OCACHE_DATA:
-- 
2.53.0


