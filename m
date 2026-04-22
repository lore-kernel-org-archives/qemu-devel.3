Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFFAFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmn-0006Vh-4x; Wed, 22 Apr 2026 16:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmk-00066a-4u
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmi-0003h0-Eh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso76994235e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888174; x=1777492974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xk2AGROBU4yLCDrHurCs+gvtxVjHgTVzI4BES+U4YtY=;
 b=SJv/lBqTQh+fyHIipUS90GKlQ7c+DH1iWOI5MXgFrH05ZykNZxu2E1/KdHQ3asRpwg
 FHw8y+cRB2+bFee7Bj/bNt07epYFwfvsykjQdnN92XBo5VwB6MsJebkrZ4WHQjTFaKdg
 m2RLdWfldiTGA9bg8FrfqUQvCX69v6pfMCpmYhwucyz17FZ91gUJ/0RMS6ckGPUiQ3vY
 C7c3lhRNlhkLtY7EiWextVgof14Yyg/ChGe8uAMC2X6FxtxhhCLAx0xsvxD+/bi/AUpy
 LbV/6VY/IMppvmhVmAVKXFfKHura8TqlHh1Rs4lWLWUC6s+M9SHkKMf4qseEr2+AcWP5
 vX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888174; x=1777492974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xk2AGROBU4yLCDrHurCs+gvtxVjHgTVzI4BES+U4YtY=;
 b=kLNXF4P1roqs8Q0DthhiQpi57fHOPdjcxiCymLqAfGs7O6bLqOlQqZNopXVT8SyPq4
 MSxuEaL/rYfvoTVeLE+v+UCgZQiuAtwBu4W9bz0cpWvhcJRbf1T4wiX+GT1T1ZL44G7q
 wtI3yA8llKTGSCJz3LEpwXZpe606QKyFBYISm1SOUyxdiz/KDQ4FcMG3vRHCfZGRo76z
 U+yiV6GzdT+TjdiTbtm0cK2RDFjkl4Pz2h4w7IwpgKBEBY0NsOClkoXbLLiOdR0+Kzhw
 wb2+XtmR/cxXq/fKCwdkPP8Ic2UmUA/NlqR5nCdVyXVn+/WTuzNO1KmNy/Z0DtCATsww
 nYmQ==
X-Gm-Message-State: AOJu0YyxFAIZGNIcu/IBrSobNoq9ZwgYG6K8Nx3Fkd0YCA8EI2tU2v/9
 RqRbEwMB7FTva1nN7jm7MTn5mpU2qtV3hPAGfpv/PGKaTJArnnk754TkCB55OQkrqWz+D+roLHV
 Co5Y88Es=
X-Gm-Gg: AeBDiesL3BIywWsRGDb56tgCv3KHabzHbP+0Fn0jnWat61W5L9h/HV2s79dHnBK7g3b
 yeb6qlO40HDCn6FXrZ1+b/o4GugTvNR+o8qULFWbT9/1Fi/8cmTTSw/xf5Ccuz8yjzqVydBeHLp
 rvacERpKWZmaPeC8nLVM1yDy0TZNM9d44BTxokGsK+c8DScW4Abgxu7uxQpxtUJbwvuQ6QXZuc1
 3sFnz0i2Y7yucfU+PIK0rAxNeLYOgcdGdumbjsZcWSFkUTtmaNo83SzHxF55hH5IDrtMx3UxrQu
 FdsZdLQ4X6Azo6jZe4cp/LwmPes/DXabLlcPDEBvclGX8bkcgdeSaFX3UY16TwXDG+F03IHcpUm
 HQB5aFjNJvXzCgqyW0jC4oHTuBsnUqVxXDWxMr4iDGUVpEdeq+xkGjmo8G8SfFY1dqqdR3Z1DaB
 ibPVlqv9lGAHQbeHqPNwqXuDovCQ7uwXdNHEI7FB+lLMf7v7lHG/HVYFJNXctbTrbA5uk5xxXWh
 x7PTDcYNhgthO8pGBsAkQ==
X-Received: by 2002:a05:600d:8447:b0:489:1ff5:edda with SMTP id
 5b1f17b1804b1-4891ff5efe1mr146206235e9.6.1776888174474; 
 Wed, 22 Apr 2026 13:02:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891ffd2030sm70046305e9.20.2026.04.22.13.02.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/48] hw/misc: Fix the valid access size to the avr-power
 device
Date: Wed, 22 Apr 2026 21:57:41 +0200
Message-ID: <20260422195746.88865-44-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Accessing the device with in non-single byte mode currently causes
QEMU to abort:

 $ echo "writew 0x800064 0x4142" | \
   ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
 [I 0.000000] OPENED
 [R +0.001784] writew 0x800064 0x4142
 qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58: avr_mask_write:
  Assertion `offset == 0' failed.
 Aborted                    (core dumped)

Set the valid max access size to 1 to fix the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260421082935.85995-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/avr_power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index f42cf4fd906..42be2656911 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -73,6 +73,9 @@ static const MemoryRegionOps avr_mask_ops = {
     .impl = {
         .max_access_size = 1,
     },
+    .valid = {
+        .max_access_size = 1,
+    },
 };
 
 static void avr_mask_init(Object *dev)
-- 
2.53.0


