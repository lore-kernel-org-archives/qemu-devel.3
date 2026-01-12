Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA119CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQo6-0007HG-Me; Mon, 12 Jan 2026 17:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQo4-0006xq-QZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:40 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQo3-0003mD-9V
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:40 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso4380317f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258477; x=1768863277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kDstsuDcvZUupZFuNL2SK+ghVYfLJrb4xiqSKkpEbyE=;
 b=NG9aP1HWsx3mvIJD2T5RU1GXINIlvQEc9LkXJFlFSZcwrLKcT3N7l8yY7bRExQl086
 L3juY63UYM8gwMdUpvTBIDmUp2B5g6lCw4/bSN+FR68SMK7VKoUsMYukqVjhb5M1xRY0
 1vcLZ5thlKKmxOmTmHa8MhFUco5r0y4cqoxaIJpBUU0aUjO3tmVMrsFLqQGU1enGpS55
 8nrXRQl5h9epHmMLbiNUn+iWxXL7jkrsJxf9O4RqPo5Qk7XMMLqMnVc1d9NxIE6HoHAM
 ejEUGj37h2mvDUgggRme0jVNOUUjNdX2eEepov1bi3SRPirkVr1ndKM96WVkotcZcsPS
 bG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258477; x=1768863277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kDstsuDcvZUupZFuNL2SK+ghVYfLJrb4xiqSKkpEbyE=;
 b=eg7XezyzvpFdGW9LvnJvGX5/EM/uNjQXWOp+Ww7chPani7CExZqS5CJFMKz03DggWp
 KcUZo1/cxg3MeiyO64AwZYgdYWnCFOOY3Bn/+Z/jA9LVhheDLKpXgzhtUyJ/PJlwQBX1
 24TJ92RLI+SCl+WZreUQX8M095OYLfnu2sWvmGmGUxDbAOlTNxTC+iyunWx8VTT5h8YO
 d8t8Y2KxwjGHxqGXckVnKEbmhzvdjmJW7yxfH2cK2oYVXb0escRyX2mXdTwGWGjPJu7f
 /2BnLp+E8/f8KtFozSVVx6vUBCN/d09puuLCUIKUU4YAq6rXuG0mB3SNjgK8Pv6L0Nmy
 6ftA==
X-Gm-Message-State: AOJu0Yz+jB30stHmtfn1a0qusBEwJC0iB3k40cLnvh3zjtPSdvn2IcCj
 r18hbKRUEweo7jMVh9vvZ7tMO3qi4Pb3L7KZ5CL3Iq5F5ewiXFWrulaaVGoZxQyoalXwMnekxVM
 9w0YaxSQ=
X-Gm-Gg: AY/fxX5Jdp5kvxVA9K5SUvu7mx1sbVSD+L8DzDQMXOCIZqkxvJbcIngu8FVFOKwe+dl
 5uFvZK/sT7QtIs+MgFCSjpcQAy0wpxUq9x76aFbJIVhldQgQwo0BewZgbW5HybKu45DPPU7L7SI
 N2sN1jBf1FusRaJpJT68m6h/EgiXsbJ6ORrk8pTkBgU01FcfbUu5m8KFJeCH6yJ9I/oo8w7TL0d
 7NV/rWuQhNyIQv9fuxUPbyGlFOsMDYjO4TQL5jcdFNE5LWxbmvBdP0mAz7/nm711t4YgozsxbS2
 WuBLohoE0lxJVFZvvUSZWxOYHnph7kBvPvtBWtKc99oGCgrRukSJQRoriSvFqR2KWS5ZFwOEZb3
 uWYhIleKGee+adkAACtl02gKD3rx0a4HKkaSkCJdfLca36p+Lu9e1CABTiW+eRMq8XPh0uWcWQQ
 dYub8WEccESmT3bg/LQVmrZeOeIOVdD6MFgSdFwu+7/JVxccL/cfgpQVLpZt81
X-Google-Smtp-Source: AGHT+IF3Mw0vf1pzpvSnboXeqTTgiesSdz0NPJOmNAX8NkuOq/6Xt+k7GiplgEYVDiyV5ajQnAWMdQ==
X-Received: by 2002:a05:6000:2087:b0:430:f8b3:e834 with SMTP id
 ffacd0b85a97d-432c3629b4amr25356636f8f.11.1768258477402; 
 Mon, 12 Jan 2026 14:54:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa78sm41395966f8f.6.2026.01.12.14.54.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/61] target/sh4: drop cpu_reset from realizefn
Date: Mon, 12 Jan 2026 23:48:44 +0100
Message-ID: <20260112224857.42068-50-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Shuffle things around to ensure that gdb register creation was
done after dependant peripherals had created their cpu interfaces.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260108143423.1378674-2-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 21ccb86df48..1dd21ad9ed6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -255,7 +255,6 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
 
     scc->parent_realize(dev, errp);
-- 
2.52.0


