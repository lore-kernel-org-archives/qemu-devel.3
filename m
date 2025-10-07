Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A593CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R2-00067n-7j; Tue, 07 Oct 2025 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qh-0005rt-Qk
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QQ-0002LM-1V
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso3822912f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846337; x=1760451137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SI4CyOuHnAyNnn1ALu382C8YNZCTgZ8H8fSMouj/XxY=;
 b=wK8boeZ01CX3Ue2UaiB1Tb5z3UqGHHhwzjh82itTdqbH/JltEjcCUGE0xI5NaCUkFB
 QW6HBfB9uWy5qVPv9CuQxz2vQl/+vsFXaTxCuQdbyyhb/FyqJSs01sBJ6nAwYM73UCqh
 CVtkSUgA1FXiqRaawt6YGFyEuAV9ZG267tiXzjLOYMB+W0QX+fmbP77dT9mrgpYfaWZF
 EeZJnPX+tJdeV8CW6vug29AYNSQERTWEaXTWRh8As1PsyHLTD2NCVis0x2WaQmI4piwL
 1LEyy2PT/oDR5L6VAbZ65HDA1jm7i7KppDneUk7mAuACmcDckc1K9f4grrPwy5vKqtsG
 t2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846337; x=1760451137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SI4CyOuHnAyNnn1ALu382C8YNZCTgZ8H8fSMouj/XxY=;
 b=hWeCEhvNtPIK3pLPxaioTv6McHdyc1d2ZBzH3/Q+iBKbj/sWpWD7SIq95SgqfrTP+s
 1Q90x4iEqaaLCzry26IS9s32nCyZL5TDagAZbaxKxahoZ6VnpoFq4UwBkH0MJG4ryrQC
 VY2Oi4O1Rw8nIUeZCPVQcceKBmrV5jG9S3Fl1tRHRYtPkpLkqvGILR/+OZP51iBH6r0C
 e7rF6NvStQP1VoOjHD0baenrlbDByvcBU2ygR0llioEfHdP9+GbuTsw0ld2QpocZv2sW
 ueuB+kDWX3Z+2QCO7Fhlqj0msbhwRkxzxijzWckxeU1nNuG5C6b9SPplVrhyTJsUIBEa
 pOlg==
X-Gm-Message-State: AOJu0YypGVw431qUVqn07lV0Gkp8hcjuQvBl7jvLjrdKxQwXN72JToa5
 FG59GTJqCwrt6msHSaWgyxTHPZ0VELz+QKbvPKVS87kDmY3qLKN4LI3E98UGr6n544L5oZwNV6a
 WiPCQ
X-Gm-Gg: ASbGncvLC2ot42zFPUJ1mFAGs6wS49XnxVahjFdRv1YKTNr2QhepE/vtIhD7GsygdAd
 2bcw/hknFeA/X9qjRstXxAxmBjLr6BF7UNt3sNLBlYykntGMVulogFUR1Ju6NGhAqE/EdsoHnsW
 p8dwzc+ZBn7wpCx6ySHcSl/qzQnJVDCwqPe7uk8wUtrvRtE3iuTxuX6LewNd0jDo802ccZNW/zf
 k/5W8SCRSlXEkEagnzh34klftCmnaW/EriLk2VUjfKVKUEvQ5XH+ZmJGRv5M5D0GfcNBlNIjOJQ
 7OpCOuShE9KBpTn70RhbEPdG0pe0IOqqdai4zZwWfXicuUFnBtTJA1sJmeYJ2PyFDedwg4/AoZU
 XfbjOhsRhgLyak/78rB33WpqK87RX57FMColQX9VW2SdxW6nWFvt0n63M
X-Google-Smtp-Source: AGHT+IEuCDuT4b5IHBshZsu4S39nfQVdqsG8n1EhJPGecquO/iLjZ3ne6eA6okVr2ksZB0OjSL0KXA==
X-Received: by 2002:a05:6000:40c9:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-425671c71a6mr10731964f8f.47.1759846337233; 
 Tue, 07 Oct 2025 07:12:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/62] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Tue,  7 Oct 2025 15:11:08 +0100
Message-ID: <20251007141123.3239867-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add a test for the amd-versal2-virt machine using the same command line,
kernel, initrd than the ones used for amd-versal-virt.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-48-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_xlnx_versal.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
index 95e5c44771f..45aa6e1b881 100755
--- a/tests/functional/aarch64/test_xlnx_versal.py
+++ b/tests/functional/aarch64/test_xlnx_versal.py
@@ -20,8 +20,8 @@ class AmdVersalVirtMachine(LinuxKernelTest):
          '/ubuntu-installer/arm64/initrd.gz'),
         'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
 
-    def test_aarch64_amd_versal_virt(self):
-        self.set_machine('amd-versal-virt')
+    def common_aarch64_amd_versal_virt(self, machine):
+        self.set_machine(machine)
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
 
@@ -33,5 +33,11 @@ def test_aarch64_amd_versal_virt(self):
         self.vm.launch()
         self.wait_for_console_pattern('Checked W+X mappings: passed')
 
+    def test_aarch64_amd_versal_virt(self):
+        self.common_aarch64_amd_versal_virt('amd-versal-virt')
+
+    def test_aarch64_amd_versal2_virt(self):
+        self.common_aarch64_amd_versal_virt('amd-versal2-virt')
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.43.0


