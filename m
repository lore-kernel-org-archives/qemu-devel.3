Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220FAE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eU-00038M-Ad; Thu, 19 Feb 2026 14:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eM-0002Zx-JS
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:23 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eJ-0000hI-Vv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:22 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48378136adcso8200405e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529118; x=1772133918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10rczlQt2ivvYF0H7Q9KwUXjBDQx6guSkfaEKZaBddU=;
 b=mHoW5ldz5UbnnK6O6zC052POUKKFUITcRFCDrZX7SUi1hzZjkOr3g8vUmXAcTgi6Iz
 LWQKFbz+qVimi0qo931fozniWqBK07nnydpVKnwhkcQm6kN/w0WncrIoADEgSxDSnZ1+
 ccobEIjaw4v6cvpMerDxxmrGQMFr+kPwCJI0mvGmtvJc+j4g4zNX0pDooZaGf9BjmpHE
 df2Qb8XvwXT+I6WoXCmVtGMEtRBZnycf9rhYPfpfjZc8SFUzFYJHD4eJVdjT1sObNL+F
 BvQwGvP8FWbmDo+9xpJpOYwg/3UCUIYHBdpYJD4310foeATZ9ah27dbgiKthO1T+Y5i8
 FLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529118; x=1772133918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=10rczlQt2ivvYF0H7Q9KwUXjBDQx6guSkfaEKZaBddU=;
 b=VkDm016MJwqw+p4C95expclvmAMajPd+E2b59BbqQwS7xtOYJL3udMw0/l0Gv5JZSa
 +ZoukHDBNjT8l4RVoYWx3XuxIyHPwHbxyD3/3aucQYaHbXNLbWfn3RegFIBkzc4Ce0XO
 haU2U+NUQCBasEOY3hJO4f+iX2L/hWX3s3h/b1TNXoF/Fk3Kp3ToPLILpJCv4h8zNEMl
 4/1fQ78OpCgKFF/ZayGs8u2ABdIPBt53VkPICoiKeDPIfd6Vp50qbtbUTqfMKHdyhDjC
 hItgi+ipEl9poQ+i3JK5sY+H6StUPDXbCulrXlKL+w9ZS0azcGQjBVh6MypTOOIFa4ei
 iCoA==
X-Gm-Message-State: AOJu0YwSjZMXIU7rDqohqZLMOr4Vy8i2h0c3zIWEziL1yBZ5CWEUF172
 4c7aG0243gOKtNNZPwAeCxg3Eck0hnjJcOeNQ74xS0UWxZvmVhLBntPB/OKXUjdX0LI79+A4yaU
 HeeXT2Y2T4w==
X-Gm-Gg: AZuq6aLJPi3xAZwFekAHsAQECnVOhz6fsygk6yhgglH4FZNnGkvk+fhsoYg0YwryEEo
 c3eWtKr05phjihZur5+UlfB86vhZZRAIZKLDptZpyLeyw2NfQgJl4K/TTLPaIdcQfvcoTF2M54H
 gfkzb8Gy+PwBdMCyBGiBftAU+S9BvsGfOo9FyfOjAHZQVEwr6EnD3ZJRAXOQoqaxaRtG9UTh/bB
 5zFdimsHztYeaJAKI3Uad0JYLAzQRbmaX65G+95IRzygpPEWVv1UL8oeXiUoIkXbUrGu8tczArz
 fm9tnhzOgJ+hOzHoV4CNEMqC1T/ATvyvcGpQvUcy28RP3iqlhky6G6Xf/GVVRAGieyoVOOTbr7X
 XUNh1P+8fhvmjN1019hOAM4/y9hSNw8GBscFVkjwIQTRhzobG3j2c/eiHAAtX/EKx/U5YD9Vip4
 +ZO6OjUZh+G1dCZcsdn9VgKPiuMyPUwiaaFEUiWbHeFhehQJqifEikHSCpQG8fUIgnZseUAcSde
 QWFk8y4QYs=
X-Received: by 2002:a05:600c:8209:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-48379c1f524mr321746025e9.27.1771529118154; 
 Thu, 19 Feb 2026 11:25:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3d88sm21134005e9.3.2026.02.19.11.25.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 45/50] target/loongarch: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:47 +0100
Message-ID: <20260219191955.83815-46-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is a single qemu-system-loongarch64 binary, but by
moving 'gdbstub.c' in the target_common_system_arch[] source
set the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
          "single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS"
---
 target/loongarch/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 20bd3e2f0a3..2ae96d68695 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -3,9 +3,14 @@ gen = decodetree.process('insns.decode')
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
 ))
 
+loongarch_user_ss = ss.source_set()
+loongarch_user_ss.add(files('gdbstub.c'))
+
+loongarch_common_system_ss = ss.source_set()
+loongarch_common_system_ss.add(files('gdbstub.c'))
+
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
   'arch_dump.c',
@@ -20,5 +25,7 @@ common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 subdir('tcg')
 
 target_arch += {'loongarch': loongarch_ss}
+target_user_arch += {'loongarch': loongarch_user_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
+target_common_system_arch += {'loongarch': loongarch_common_system_ss}
 subdir('kvm')
-- 
2.52.0


