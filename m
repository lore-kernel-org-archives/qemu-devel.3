Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E4CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4iF-0002xy-4f; Thu, 07 May 2026 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hY-0002mR-W7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hV-0006AS-9I
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so10928255e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183257; x=1778788057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9/CpwSdzPAWM3Y46+VvKwWfePHfvifEEPhGbQPsqQ0=;
 b=GJNdiooxWuGyjBMlphnzITOvNplSSAZ+e9yvnejHnwa/8/vDas2rMpLSFVxLHUEGJs
 bUYV/BbFU+3UVMfCFKnAmXvENjzctIHJEOW12/vpPr0Fj5Wce9leYXYosMTkMJ4bH00A
 RiqxJ6jnnXky6qSjw+mQrlTJoa+upE2wHRFUVO/DcJPNgPLJuDZ8apm/moa0jmxW+FJv
 NtPfor6vqetLR7vKQ40u28UQ4aCQxi75DJ0VHuf6yx/+XZk0TbJhDosFhn7uLm0DETEf
 a2YtYCvfYNfQTXMlIM4fIH4XvNvRlhfMDO0WPhUTQE9OH5AJOfIQb7nOkaIk30zp0+T2
 pcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183257; x=1778788057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9/CpwSdzPAWM3Y46+VvKwWfePHfvifEEPhGbQPsqQ0=;
 b=NMWUNQRBmmfST/HX9VJTunH5jPODtLp4iWtbz5Pk9VdNbVzjlWgMdZO2k9tTEUqskH
 /Osxhc55uwAeJFdbnuf/y03hgqSikgQ9efhUanBkdHksRzawIvwmalYMWCrTCeOvyEjI
 KnpKvlOk0aZUKfsCzCgIEYOEOnrpjh3BHlNrSv7U7fknXuccnFTALkWT9SVfO1c/vXy3
 q4HIwvAF6kef76PugcmE8cakNN1YefgmhJ8xBLYnxWtaO7U9uLDucHtjOHcQ1Vwra+80
 dOOS5gXB7Eo7suxU9rY++Nse2QUoAHztsIEaks4r6E08zz4iWaxEbhDrrPNvgGKusZH8
 nHQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZDQRS/DXm3y4g1Jim0Svp5V6vuLhUg7dXnsy2+ggVWEiqYt9AAkyF6O6UM31+XQg2wpQcHfZ71hkn@nongnu.org
X-Gm-Message-State: AOJu0YyQ45BJbMmmNEYM7Dj8UldOXPCzGnC30DN1amrzFKNkLugPSIIt
 OPehCqFwEysw5ll+pObREzkv6fLZ0A6SpuSLr/+TFXQ3pazjQRMleNx4sq+G5GgFFFk=
X-Gm-Gg: AeBDietdxxgYQ7cb5SPyIDWNyiQ+jyXYNMWGPBxck6xqZ/lncdzdo5QoUQz6SLybRCU
 RnD+H8OeZmBRIfAof9nqmQ9bZKPegnFcl99ipeKJ0F6gnoTJ9RH65+r+nU23PXjMSjnjaCT4cGV
 fnz5eNAh1W8vswcw11ohvL7YMjq+J76sjwUl+QNOWLy56PnoMPpfTd499oIrBMPB2fM3Yduo/aw
 zLwOBKX5pV0VFEkQCS7ZR3iKk6GZWtsBfjEEqCF/Cw8oYAMCuPH08Oes17wuOE3kvznaumyNi/D
 jThpVrFHQNQRy4xmPVjiSY8RImvI0F5lXt3w6w/6F6SYtSx0IydPAYRumQISXofJEmPpkX6VDR2
 UDMub+7BtfrwWEfDPIHoMTbShLyPXVMjLWaJfa9MBVGvxNdUVsH3TEX9TX6YFzHxt3MPPanBkl/
 Wff7p5OhL2fY8dhAB0Hhmg/sg7DEQ+9XuVsYETNl+SFbtBvFN2fifh2PWe7NDktcENd6CV1j4OL
 9ZheJ3JqD8oW6vR38ZRM65AVup9zqY=
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id
 5b1f17b1804b1-48e51f2f91cmr147347725e9.15.1778183257503; 
 Thu, 07 May 2026 12:47:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c145aasm958375e9.25.2026.05.07.12.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:47:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/6] tests/functional/test_hotplug_pci.py: Require TCG
Date: Thu,  7 May 2026 20:47:27 +0100
Message-ID: <20260507194728.2034696-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507194728.2034696-1-peter.maydell@linaro.org>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The hotplug test asks for the cortex-a57 CPU type, so it will
fail on an AArch64 system using KVM where TCG is not compiled
into QEMU and the default accelerator is KVM:

   Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

Restrict it to the TCG accelerator.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


