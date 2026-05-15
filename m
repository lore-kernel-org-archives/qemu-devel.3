Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02596CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7V-0000mC-4T; Fri, 15 May 2026 06:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7O-0000iR-Vt
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7N-0001ho-1h
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ad135063so74860405e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842207; x=1779447007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gBwP6y6IIY7F8UfdV6zdl38fTsu5nXVJ8xCaneQe8lo=;
 b=OyiKin6iN1NpVqJwgLaU4mFuyx6iPN9ua+460ckU1Bxkx+M7ndc2ReL5PqT9bizyzX
 8/fG0M2AGdyJLEU1uc5W0DZ7UqN8OW+0gjvRjmVerLB7B+ZTe9tNEod0OCy8wGBcOfK7
 1VYKIwNYEps84bfgJibk+c5LzSoCSBZJBpWbOlh+0Z5UBDjXRJEWVMoS9aN5K6NEJ16p
 XCcpgewgb2vLjGlNIzpciXe4j+jT6brAN7rGmkuIjaPGmb5JKIJVsmnxb9hFlwsp9/Ze
 Yy2LgOFWn0kLLg3onN0wGl9RNGDTbiHKoheHiloCFameazKnJz2fH22TeOCag7LkzR/+
 j3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842207; x=1779447007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gBwP6y6IIY7F8UfdV6zdl38fTsu5nXVJ8xCaneQe8lo=;
 b=UWWGE6jBsWuQSSd37yYvARzVEF2hU8nF2EU7yx9Mdmb+Br3L4T9hmnoDUhJT9U132H
 y7lgW0sNYddgekyXu3G3fwmaomxD+T1kQig5GbHHyPoRFPcsfNy79EWC9zPQS37ZmIDr
 WPi3PqAcivKqB7iK8em1T+pljlc6s4F5pRv9flw0+IYZBW2d9ePRLx0gCeu5Kv+5erlz
 h3jA/YUkTgHV2eI4koe+cbNOUETfEzjyyUURpaqIWWLrLqiTiz9bBnKHvSl41Yat4GsJ
 cqfdI/0zy1e8oOXZLTaoE6wCU6H+uX+EtfE8nLAAWHkbthuxgPd4FwFgauJW7YvARAfc
 xw4g==
X-Gm-Message-State: AOJu0Yw8phwo0iLuSaxjVqgZxtYjDpU4ziWOXKGFibnR4+idBaJXgZ6A
 C87kR08hoEt8U2L9gzaOJkwbtMeKJPsUVcpMou4QJtnvnp9GW7bua6COms/72I3vgcc1WSJSfds
 9sSLk
X-Gm-Gg: Acq92OE8BkMP4y4Yfhz0USeSK986kQ0ah0h6fT6gDGH4ioh011TY804UnTmaUReXw9z
 lPAAU7iG3MIccGnTC28ytrnoP6D6QereVRDqNp1iuB+g6UlNi1URfBqmsIb+vWrVxlBNyLJmRZA
 9FWEPdORURpF9UtYohm3oFyl4Dqi81kk0p/xB01NbqNqJ/7r6K9R8HBEdYe1y9brXPu5rU9SLqt
 lf0OCiB7F5Zs8pLza4ghbVERfG44NsjENPVV1UVvGUhMg8ibH6JxTPFLJJKLJU0irgGSO9UXDHM
 Ad96th3K1j9pH1nIkQl4j239oJubbS/Rw7ZUrff1g5oPMS4EDhd+WhPF4OBi93NIL4tHWCoxqXy
 CfsQrQoVnKz+bLs+/3W2msSApIxL6YpgvCJy+vBilVY1EjmiD9kneeiIPVqHsZtNd9MJrWGJIRM
 O9lO8L+4HmRI2TV2N69eT2IfhFxfBpbGeGHYfNH2PkXi4BHzKG16vjiEYhldqxyMW2fnnpQD19a
 LydpZFZh+sREoTnBGH8QzdnSeJdVLUI/+2iwUhvNQ==
X-Received: by 2002:a05:600c:a309:b0:48e:8741:fd53 with SMTP id
 5b1f17b1804b1-48fe61f1e37mr38778705e9.15.1778842207284; 
 Fri, 15 May 2026 03:50:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/23] tests/functional/test_virt_vbsa: Skip UEFI test if
 virtualization not supported
Date: Fri, 15 May 2026 11:49:39 +0100
Message-ID: <20260515104945.4145203-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

If you try to run the functional tests on an AArch64 host which doesn't
support nested virtualization in KVM, the UEFI test fails with:

   Output: qemu-system-aarch64: mach-virt: host kernel KVM does
   not support providing Virtualization extensions to the guest CPU

Catch the VMLaunchFailure exception and if it matches the error
messages the virt board puts out for virtualization not being
supported, skip the test.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260507194728.2034696-3-peter.maydell@linaro.org
---
 tests/functional/aarch64/test_virt_vbsa.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
index 57bfe5d7af..04b5ff0f9e 100755
--- a/tests/functional/aarch64/test_virt_vbsa.py
+++ b/tests/functional/aarch64/test_virt_vbsa.py
@@ -17,6 +17,7 @@
 from qemu_test import get_qemu_img, skipIfMissingCommands
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
+from qemu.machine.machine import VMLaunchFailure
 
 
 @skipIfMissingCommands("mformat", "mcopy", "mmd")
@@ -96,7 +97,14 @@ def test_aarch64_vbsa_uefi_tests(self):
                          f'file={img_path},format=raw,if=none,id=drive0')
         self.vm.add_args('-device', 'virtio-blk-pci,drive=drive0')
 
-        self.vm.launch()
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "does not support providing Virtualization" in excp.output:
+                self.skipTest("accelerator has no virtualization support")
+            else:
+                self.log.info("unhandled launch failure: %s", excp.output)
+                raise excp
 
         # wait for EFI prompt
         self.wait_for_console_pattern('Shell>')
-- 
2.43.0


