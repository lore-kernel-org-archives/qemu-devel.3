Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D54DC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VZ2-0008KM-F8; Thu, 03 Apr 2025 21:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYz-0008J0-24
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYw-00081f-8c
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so1834697b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728976; x=1744333776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIRfp04i627hlfQrwyzx4Wu6n5OG/fKCaEKAfQ9ho1s=;
 b=os9Z4wzwCFxxIjWXVcpDC3LkzkhSfUncTEgVtX0TUzAfLkDye1dpUrahlOX9UolMcr
 zJixZHBt8hiewdHHmWfSr09TqYParESXroz1fhxi3at1MQlZyla9Kc6WWFbVwSjYtKqK
 oLI2VVlxCIrdJIRcH8TRXZ70WzpXvY+A5Y08XE8jKnHVN5WdZwviFrZCN3xAG18Pns0b
 f/LlvwSQBNwpjVmwxjClk9JpajZtQr/1gMC+LoW/yAvyUDrj3wChlXQBr+DSGBLfSgy2
 jhS4pywyN8cTlD2ZU5c6tHb5IbR3YLXNscsg3HDeJxCpVntFeVIIe1kNcAiDAyjI+z20
 JeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728976; x=1744333776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIRfp04i627hlfQrwyzx4Wu6n5OG/fKCaEKAfQ9ho1s=;
 b=c1A5lygN50tOtPFWPVZhpsIJd+QBk8+77Y0gkXb6wSWRg7eZxST3ahkqRDL15i2XW0
 KuQStN+//e3T8/CPvjMKG3wCA0fQg8SD5KNCuQQ/zOBZBBChti377uY8krcZJeRT2XU+
 xzIw1AVJPwuncBbMJIqtIFboRqROKjP8ii8pdrPBX0iQ0OdZb9IbSipxy0oX2cwJ7uv/
 aYU1rovsi97DLZIP64FsipbRxZH1tUK5AaRNp0XsinZH6bdCreuskCX6u1J5bXjSL1cg
 9K8JLcFDzdOnX7ArcfNpB4mN2CvR8I8qRyFtRGp07KFOQ0djQbeucMvGbd7Qv8+QqHt+
 ftNg==
X-Gm-Message-State: AOJu0YxjPEYIR0a5GLe54fwk0ddheEoLDzUVtlucdsrYSfBnHL6qgp7/
 r0r1w4eFQy8UY8OjbIzhfYn4NOP9FSXDtD0Sp7/SfiwahI6L0kdcqptDsDlTisWIO8z4OGAZOfz
 W
X-Gm-Gg: ASbGncvEt88qAFkDVcrV2gf8DYfE2Y0O+Ij74JV7Eg9jasZO32GA1QdZauBwgWcN/Ks
 XrtR3DmAtgxtCeMIHOv1fj/TmMyxWUXhDz+2BNDgO1T+vexnDnY5cSjFQW/m/YRxGzmy8PVCf/5
 msMx4AvJGJ+yF4+gry9xCZ4iCdGup76bsn/ujtNPuvTZOFt1k21NTw875q/VPBRFzouoiVhdIrf
 USRN/FNNCZLjrHod4gyeT89uAZpCLMO6HivXheDaZoytJbdVprJXM37LoV2h3dgz0ZoRNkwM+VV
 t7dgm7pHhXABmG5MpEqy5YINEOqWzyOjWww2hI1HlWpXNevTWT0=
X-Google-Smtp-Source: AGHT+IFRZXG26IM8KqxAtDXfNLVv3p0dxRQ1Toa0KfJX2MddRom6VO5A0sMJch110gMiJKXgGsDIug==
X-Received: by 2002:a05:6a00:1147:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-739e4f79870mr1895398b3a.22.1743728975961; 
 Thu, 03 Apr 2025 18:09:35 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 4/6] tests/functional: Skip aarch64_replay test on macOS
Date: Thu,  3 Apr 2025 18:09:28 -0700
Message-ID: <20250404010930.164329-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

As of v10.0.0-rc2 this test is still failing on macos:

  $ make check-functional-aarch64 V=1
  ...
  ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())
  Bail out! ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2907

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403203241.46692-4-philmd@linaro.org>
---
 tests/functional/test_aarch64_replay.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/test_aarch64_replay.py
index 04cde433bc..029fef3cbf 100755
--- a/tests/functional/test_aarch64_replay.py
+++ b/tests/functional/test_aarch64_replay.py
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfOperatingSystem
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +16,8 @@ class Aarch64Replay(ReplayKernelBase):
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
 
+    # Failing on Darwin: https://gitlab.com/qemu-project/qemu/-/issues/2907
+    @skipIfOperatingSystem('Darwin')
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-- 
2.43.0


