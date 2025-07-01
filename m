Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16B7C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHO-00021A-J7; Tue, 01 Jul 2025 10:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGl-0008Ny-6b
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGc-0007aG-59
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so17596675e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381243; x=1751986043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IxOMy6xJpvfeZs7PzIhMpyVP2TJVD5qlNxoGjPSg9I=;
 b=IQP9rvZaD0T1LY6Lp+UWPiRNH49fLQ3Yerq28TYuzjfiGwXswI5rakIAivDigGQSu+
 ygvCjlSqvkOwl4MKGEhWKoUZh099Kx23qWfTn9QuYbGe/Y3Z+6a4zfRNISCaR5RmQ2HI
 n+MBXohcGe271ua4QBDLktFKdaYlaLgK9h1oNv+86stl95P5+xpV4HaC2+cJQSXuN4W+
 uT3rqQ/0pALB0BnJITDSABcQTH5gJzR9xQFch5rkj1eTymnON6XzRYpw3rrIlKHbNQOB
 K14wvUfRFHBuqautCX6fvWy22G1WNKo3hiMNPVcRd//tGxWZfsuybHfxY3QkyFDMN3/l
 5GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381243; x=1751986043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IxOMy6xJpvfeZs7PzIhMpyVP2TJVD5qlNxoGjPSg9I=;
 b=L7WvUXtTAU/BTSfcVbf8wBxXsX/a42eOTcbgLlmCSqu4O545ZAjCiRVeGjtaMJBWTS
 aEc6qf57bZEzxNT3cDsGpAj2Kkw5x5RunwAwNtmlvln/shgwXxxw3Lsp0mLmwynOGF+T
 /OSsDnlmDCtBWP9OVNlAgx1OQp5Dt70cYk4V144oL4ZYvnsRRaEw6bSxKpPWgXs0jZ1/
 Rts7s30jJstfXF2Yw3gx83BLPUvnC2NRWYIM0oFg/d8L/luRiEfVmB3V9/WJBqkhCwWe
 2SzuDhAWByquvdCOZKl2nX+7PX1RKekQTYwqqErKj5WY+i29clP79JWAlG0kTfcKShO8
 FqvA==
X-Gm-Message-State: AOJu0Yz6EtQb3d1qpiCcIH2DtqRjX7qx3fLnzHyixVjI5Qu2BWydTeSN
 QZMo6aZksqtRMy9qYC8BKTfxsG8oblFfvf3AddgDLNQ2SxG1xdilHGB2qjBxy07bxNKySSlD7E5
 7TSOq
X-Gm-Gg: ASbGncvCV0XGS4eLGBbgdptQhER+4ReVNYuk3PF3ctkRXAh/pFPh2rIeuVWQhjduwLw
 prmq9TWgY+h7WouOs17Cyp+w+/IMrc+WWjkwPXenxRLE/eN8xrnmfltFJZDbXfHitaT41cUQYMW
 GXDcHkvQ2O9l4V4zE3vyVQdRjr2PW6MnlyOoVhhhtwrInYdJCSy5++Z+EnHjPP+iXeedAJHSHBQ
 piWlQ2kcj6T6UuOszjuZCMoWirYN+689KQPglrIVgZj6WQECVdjpNOFiAo2loXPyFJbzpXR2RVu
 8Rhokr4GxIqboUa0HLbHbnez/B3G+X+cBHMCJG3C14Z/HbCe97Z0Cbe3jWKILta9K7J4fUVriJm
 HoEgtD0ZxXcjmjKYedWOBxWnLrOM4U9N6VJCN
X-Google-Smtp-Source: AGHT+IHWSzvyOt14oKFvaOEIz9wqYPwH6OAq5h1cy4WJcvJGC9LXD151JhPoGCmqV2+CCVyBmoQdGQ==
X-Received: by 2002:a05:600c:8506:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4538ee61ed7mr160641555e9.21.1751381243432; 
 Tue, 01 Jul 2025 07:47:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390c88sm177034285e9.8.2025.07.01.07.47.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 65/68] accel/hvf: Register init/exec/destroy vcpu hooks
Date: Tue,  1 Jul 2025 16:40:13 +0200
Message-ID: <20250701144017.43487-66-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b61f08330f1..d2b3217f145 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -354,7 +354,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpu_target_realize = hvf_arch_cpu_realize;
 
     ops->cpu_thread_routine = hvf_cpu_thread_fn,
+    ops->init_vcpu_thread = hvf_init_vcpu,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
+    ops->exec_vcpu_thread = hvf_vcpu_exec;
+    ops->destroy_vcpu_thread = hvf_vcpu_destroy;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
-- 
2.49.0


