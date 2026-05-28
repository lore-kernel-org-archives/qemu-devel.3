Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568A1CD6E4C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShH6-00076h-5p; Thu, 28 May 2026 16:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShH4-00071I-LP
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShH3-0004ma-1Y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so69765065e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999851; x=1780604651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P8hzLv5rTezOnHlBIA/73JGe4wigVWDSv3ySviF0snE=;
 b=CfM+M7dK01bB0Fu5Sm0J5kiyWhW+xVER9urfbVko2SQDTbA2e8/vk5QGBsUFaBx2+U
 cjLfrLdXXrrtJ6ArAoUQaYeFnp01ze78ACnSjGpGyoFUqsImistVTZVOEQ/QLMVd4ru4
 /Koe/seHU7c/+Tz81czgkl9zVECMGgdxBW0FiZSkfiMv+f65WYMxzsgz5fm5y2uYrwty
 mqyNaXNijbD/0eG2KOASJkTXCEhUgzCW+mjVLzf8V9RLHkpktu1msrPcQW17XfBW+VUQ
 sMpyiFEBxs431D/Wlu+qPPTzdBjdbftuVw5GcN3OcGeT5ppl7Sp5LURlNKxpp8ERTq9W
 3cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999851; x=1780604651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P8hzLv5rTezOnHlBIA/73JGe4wigVWDSv3ySviF0snE=;
 b=oIu5GE6xnGE64qcYYaopMgO8Od250xk3x/yGvQV4+m+Vt9mOoRB4MiAdDb+78Fd0wj
 2ot02LVz/mUb89IC5Mfv01Bliq6e8v1hS9HoYfzhBwgPZ4TMILevYADhdhQyCxsYVGBQ
 gJtkySzjg1FacehGqxvPjUvX/hnPZfL3X56l5IxVbljrhs9qobPlECAJmvZDp0MbPWfc
 oqH2WMHHqk+PhoNf3hrSOqC3UrBmAvmSGtKQdDcCoparNJQG3quGxhrbtZAfFMrq6OQA
 NLLJfvnxs0k2qKTFQcnaAL2rseQ4eNJmB5WXAEeeoa65WXblraG5MsW0NjtkZmoHHRjM
 4AsA==
X-Gm-Message-State: AOJu0Yw4r7vvICaERcvhBjobT+hoQ2QuslI7eSg/rNx3E04FrtL3lPVz
 OoqftTxv9LUgLmW7SwEMKQmxkZZJVbD422lFzfb1na7KuTKSUMjclc/C9oO3MD0VePd/C/b/O8A
 ZHTHFdXaPfQ==
X-Gm-Gg: Acq92OHROPBwCzPL4oYSeGpIcUJ/cCeu/zCzxGi8Yh1Lx7+8qdOD6eI+jg8Ke1ob5tk
 EDrdSSGgQKOYWCtj/AGnM5xs2qs4/KAbJTxXA4BcIYq57RB4W51N50o8yjRKdT43ur1eGGXj5In
 L0CZD+/5rfnpsYGAXWVpLB+0b5x8fPTlnHG6up1FSpUiUgPWbXnPeBv/tScBGLjSrtN6BQc+TFG
 GfciQuYVccGCO75M+T+A5bRES7SnzkqGwH/i9/Xnrxbb2QUXg93gf0z7KdENr5Bc0My8WSDC/IQ
 DX0EzRjS/cs5MiSKecb11O4Go7lXFMg7A/KFy1VTLo72LXHqrIB9E1qLThz3GpxsqVG32y3XLTi
 oymFPjgNfZ+RyjG6B/cFEaTPPk8Fhx3OUT1oYn1K9j3f3wqI8ss18KGWsuqKgdtan9aJ9ZJZxml
 2EkbUYaJZ0gtkTZFMfQ4JFyHK4HO2dLiAthgc1dkfe7m3D5pVmsHPNohL11gyNRIQMXg==
X-Received: by 2002:a05:600c:c04b:20b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-4909c06f318mr554135e9.7.1779999851291; 
 Thu, 28 May 2026 13:24:11 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a9cc5dsm57044575e9.15.2026.05.28.13.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/22] target/arm: move kvm-stub to arm_stubs_ss
Date: Thu, 28 May 2026 22:22:40 +0200
Message-ID: <20260528202253.49122-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

This eliminates symbol conflicts for kvm symbols on linux-aarch64 host.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 9408131d178..4412fde065f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -35,7 +35,10 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-arm_stubs_ss.add(files('cpu32-stubs.c'))
+arm_stubs_ss.add(files(
+  'cpu32-stubs.c',
+  'kvm-stub.c'
+))
 arm_user_ss.add(files(
   'el2-stubs.c',
   'cpregs-omap-stub.c',
@@ -44,7 +47,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
-- 
2.53.0


