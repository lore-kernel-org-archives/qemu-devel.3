Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DC7C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eA-0008Fi-5t; Wed, 02 Jul 2025 14:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dj-0007D4-Tb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dh-0002Zx-11
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso46029095e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482619; x=1752087419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1VDpsQ7dttUXGJ33IquKWtU8znHDu79LYhM3w4TmIA=;
 b=s8wdb5OdVw/PSXqsqn8Gq6Vf2r4NqN93S0wXZp/R+QUa+S9Oc9cVALAomLUy7MYDTy
 8YWTyW/44vIh1jPm1ShEJ5nmb5BKMdvTHK2JeLg4WjpUa6yZfm7sGGGs4j3iWqRE2Lor
 XA/uZxnDSBx5ccxuV4RVUlouYpjUwbA1Qe6XuT6WnL6k8Ri1jZC+na5LzcJWlWUZ0dCa
 jd984yLxg3+FxHjJ4DlHFHQQ4aMdCwX5XvzZn2RUZycefoRkzFZswqHtRo5skxFTkzbr
 JFqk7luxmv2mzwMg1KjO1NlPCEyMTdqSN3jWnxB45Vo50x+HB7cuzfldV++tZAx2IECL
 emQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482619; x=1752087419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1VDpsQ7dttUXGJ33IquKWtU8znHDu79LYhM3w4TmIA=;
 b=mRW3GfO0y9VJeT28SqBK2ATkJdpHYA5ISMomarwNU3Fahf9nnKVy/HDR2WlhmJ0j2r
 2TTo+Z2AG8QbkY65/cn64AMmgzvOTC4tdeg4w3HSu5o7J0kuyQjl1saZfxB7gnyJk6Jr
 iaVbv99Iiu/7lpG7BQPAhguWPUhfKQf3xJl8Wt/tDwdsheoYAFz2RV8MxLi67uS/W4Ou
 YQ03YjwxVxyekbF80PzA3Pa+uzNp/FDrGDd7Pfq4sgZDFgLcBwSREVasd4zBzMFjHXVo
 fEUozMNVre3TkN1wl5bV0Z3meuruImawZTUJKHZzbqPLs5tMKSr0cKXB5q+/dXLPbLAG
 FdZQ==
X-Gm-Message-State: AOJu0YxQTJJTIieGr1xYmJKGkqk/RV2gkFm3tBuflr+E6M2pqKDpULNu
 7LXxNmIWJjAM3QAjvxahi4Z3hC/bphiiYD7U5UuFSwPtM1Lieh1PhHbyYcBGDr4N6UVmWKaozp7
 rtBNi
X-Gm-Gg: ASbGncuWnkvaXEvme1YP30ycM5SaoLpN0fw2CfPfAhJ1vASWPeCvXXXOym8aB6q7F2O
 xlGz3wMVQc1qzxkibSGqMi+7/ychEl9azZPZwtIVM59ZdDjo0Q2gxrPWpOed0GHZUw6g7g7CBBA
 m+8ZbqajOlCu++MYCJpuj/jzEx0UdBYCuZl2wPiOTMLBv1PIKPGm41oGHenoWs5uZ4qQfSeb7iE
 k47pgzwTKOgwhgtxyprJoWFMElKVv/WC/QEeG7co8CP7x+kxuYsaKcGSoE41oQcix9UU3XEqeGy
 Lb/Pz/+E4lC07GBnOn/a4fRpd4+PNNJThh3LnYsMnLAcW9ijd0Yi53ovO7i6xo6zQdR0IRfCQJQ
 iqo9bzKymD4pVSBHzmWV+L+y3x7fSjOiCgON5
X-Google-Smtp-Source: AGHT+IE+mzD/e5CA95xas3AKSDmsnM1hsSAdR+kUfWqMkuB0JRYhxgYlWSSNY0c5/Xjto0LTb5/xCg==
X-Received: by 2002:a05:600c:3d95:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-454a36d7b08mr40552365e9.7.1751482618808; 
 Wed, 02 Jul 2025 11:56:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fada5sm16976704f8f.32.2025.07.02.11.56.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shatyuka <shatyuka@qq.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 28/65] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
Date: Wed,  2 Jul 2025 20:52:50 +0200
Message-ID: <20250702185332.43650-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We need the QEMU binary signed to be able to use HVF.
Improve the following:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
  Abort trap: 6

to:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?

Suggested-by: Shatyuka <shatyuka@qq.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c07ebf8a652..ada2a3357eb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -337,6 +337,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
 
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    if (ret == HV_DENIED) {
+        error_report("Could not access HVF. Is the executable signed"
+                     " with com.apple.security.hypervisor entitlement?");
+        exit(1);
+    }
     assert_hvf_ok(ret);
 
     s->num_slots = ARRAY_SIZE(s->slots);
-- 
2.49.0


