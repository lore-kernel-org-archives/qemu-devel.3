Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F2BCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7U-0000m6-Li; Fri, 15 May 2026 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7R-0000kL-MQ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7P-0001jL-Vb
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so515450f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842210; x=1779447010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qfD0No0qdL8q6qww+gYxRhKL5/900H94BXFH4ixM1NY=;
 b=roJI2khqMjW0gGvP6H8kWxqb5BLS7Y3m1ZB1ieei0WMA8XiA2EV+zINKPDt+e1qCYI
 BJG0/bW0JDCwyow+qZAL5SesUGAM29kZo2xOIdr70wphIdh4a+IGIPjPStAU6gK3lcFZ
 oSN+/19Dn5mjp1hDlwlXyxaqvUzStmrUFGeMFxCljodNwV7VkzZ0fAcWhh6OldgoKyfu
 8gZ8MQZgmjnyQy0g6gIL05PXco7LQXD0VvuEoEMKYWoZWZz0gPlUkXo52TqAW71fSLZe
 hRbh6HsifsROHU8jt1R4beaJ0LHlrGFIgfQgQydhVYjmhwuZie6g2cnk+vn6h5Nvss48
 WMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842210; x=1779447010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qfD0No0qdL8q6qww+gYxRhKL5/900H94BXFH4ixM1NY=;
 b=EJ0VmdiLxIBa+FbdEJuExR8zCVv/Z+73CXblLKi3JfYaz+YWWCDHmWOvHawuA8f0LW
 PCIFi4SqRSpUIfgudj/ArewJk4lv1PMxKwnN7lq5IS3NCfh6Nafc0T8ZqOd84Meic7yj
 d76M82n/zdQK/K+mgr1aOyGqe7/Ps1Dk5ZsrxP+7hGxNU9Vgn7D0RQ3yZr/gmMvityRY
 COo6lnsOlBFAfsqZRUsRtjejGxa9hKpW9bXAmTGfoRFyY+rvGCzu70clwmfKufWOmvHt
 O3D8g4MDdBwP05Esy14uvbu6OxBAmAwdIaVwqDO/mK3t85oqAxYHhGxo3cbesilaRFDX
 wDKA==
X-Gm-Message-State: AOJu0YwnWey6FVVUw/pCK4i55agtcfvcjdmuVuukDGsB0VXiQbaffS7s
 2Orpaini9UFRwo1uPE7wTIx8niIscVf+CkTzSG2LyAWM7HdZBuAOuVB1psr17U0tLbn6ddccjbx
 EM8Fj
X-Gm-Gg: Acq92OHewknToJdG9CpAxF3lM63kJmvXSoeu34Ne7GP89q7ndnC5K4A10Nk2jYDEU/J
 djLJO/IE+2gX5A6RoQm6CtAQsui0lgCwjME4fcGuwdQSTQpIW7UmKs69vavtXU/DbVqqlitdeuL
 /pYN1sWiT3Yi++gU6qbm5e2nop2DSuGANIbAg2v7pocx0O4o75QxZt/LgcmYIPwROnD2huAyUEi
 yNULoheDgVLmhdJQqgYsNRpvEzAdbgRB+sMbPHuMv81LNwEB1vZthyZvwpIpSCSCaZ8qB9ytN5X
 QeX4DZ+nDGm5JTt1T0BWJph3xyLP/Jpq0MJ2ulapiP/r6zvCvYc5U+tgPglNzgdSYTrflPNmBCa
 ctIy1uIQb6h5mlWUICcPMXxYHuOCdIDG3UVifIxUonfkaPOlxB99KxcpKCbe+fJIkdcCEuOQGxY
 sbqXzhZTVT9P1U69WjpnR2QUoWFBmeiqaLKMkBMd0RX7LIfLYKxIolzeBaHaNyJgG4wmj0trjvr
 BJgAh/3sISDTOS4Aoc7sIJUben4180=
X-Received: by 2002:a05:600c:609b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48fe4cadfeemr50892525e9.2.1778842210016; 
 Fri, 15 May 2026 03:50:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] tests/functional/test_hotplug_pci.py: Require TCG
Date: Fri, 15 May 2026 11:49:42 +0100
Message-ID: <20260515104945.4145203-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The hotplug test asks for the cortex-a57 CPU type, so it will
fail on an AArch64 system using KVM where TCG is not compiled
into QEMU and the default accelerator is KVM:

   Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

Restrict it to the TCG accelerator.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260507194728.2034696-6-peter.maydell@linaro.org
---
 tests/functional/aarch64/test_hotplug_pci.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/aarch64/test_hotplug_pci.py b/tests/functional/aarch64/test_hotplug_pci.py
index bf67720431..9ee1446a83 100755
--- a/tests/functional/aarch64/test_hotplug_pci.py
+++ b/tests/functional/aarch64/test_hotplug_pci.py
@@ -27,6 +27,7 @@ class HotplugPCI(LinuxKernelTest):
     def test_hotplug_pci(self):
 
         self.set_machine('virt')
+        self.require_accelerator('tcg')
 
         self.vm.add_args('-m', '512M',
                          '-cpu', 'cortex-a57',
-- 
2.43.0


