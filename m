Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E96ACD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAT-0006kk-Ix; Tue, 16 Jun 2026 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7q-0004Ud-9i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7e-0000vH-1p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso2659745f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636812; x=1782241612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WBtSV8TCpO70q9Fff+5grXWMF28TTKbkq2iuNuY8wtw=;
 b=r3Z4ccZ2gYMrk6rRkmNq71wQ3cXDC1gcqZwcCApsm/1T1KXhllv5VZH3TEpSs8I6Fs
 IJL0hskQu370QDTSJc7hrLbcuqrcv7O2vvQ/GLtN4YrHiHN+JzH4BD9g7J0st5Iylep/
 Qtikwi39rKzQZhAtHSmoJXDeEKHNIanXApoArvnocKawtV7e0oPnHcadrMS7G8aZ5Vmk
 z62MlSVw5aon5f1cZvbzMogoTefQvpPBsRqf6wXstQ29mSti3FfJ6LrAxncaQtF3yBW+
 ixPutPc8DJL/rYoXIIfyJmZv+WwGTZOumwU64EZZoLLKka5qGj9/+mMUPPaaKBlsENC4
 H29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636812; x=1782241612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WBtSV8TCpO70q9Fff+5grXWMF28TTKbkq2iuNuY8wtw=;
 b=i6yiZDg9MTT2O6Ng89BOdKASft0oi0s4F9lvVh9etvxVWSVOXqdohDATHflQJlf7n8
 uCzTg2EzP6wf8dSV5IbqFmL3DnZ06uLUr1k9KZKRNl5AionSS6ZNLWDO3e3nhV/Z8e5x
 33DafbX6lkqojmtVertcqkzc8mpde7iWpr8pL2hc/uyL1OY/4mqShMqPpgJFpNhFyA+z
 kTc8bbZh/U4SaDuWMYCEJc+DPloIz9rs/+7KgfhyRO7badgIVvUCxZHwcFHy0EcI9pAm
 vPq2B/PLIt4hNe7sgwakF0t3Nf1R92tlOjZS207B1zMwFTgDys2hXlXeAOesfJjAOSED
 lwCQ==
X-Gm-Message-State: AOJu0YwIORhj/YRC6wRRvdGOSv4Ho1bDdhe/gNoDxMJkUB8RavEq81kX
 K5aN8kyWjTD9hlZnNxcMTo0eTtYwcVftYXzE/gAqs9G5JHqHQK/+OD1vnI6xiz+eQZZQlwu10NC
 nyTel
X-Gm-Gg: Acq92OFIonh+ri/CdsIuw+VEVby4OXa///Mzvds7JlRDFViqvQD4DlDtJBIN2KinlbI
 25NbkQQI7AQZbVP861eSPtdxu7WFPrSGGTpzClbKQN0n+Yu2usx5+4JggqTzze7lUmJUGRIeLQi
 DKVWsD4T06TRK99h3xuDblMoN/WGs2OK27klw4rBx0mVOjWhAN+0vf3qKoBqz6yO0ABNwLz0izp
 XawH5MQ0Pgz5yN37RaKN7R4ek3zVAWfTbsT4LTzyWoPRnAiGs2l+NrjZRgbYHUU3PspZ252I8Yr
 ZHi17yde6uQT4dtCbFPEkaN4sLr//PlANhsuXA9QhgWp3C/HLB6vGWmyGFQAvFdmRvc9ggDPpwQ
 ZtDRR+Vlgj0hCKWHvkdiaJlI/MYlq+QpBlIpQD2APeMYhg70KDFBYeTxyiiVY5D8ypr6Ql7zkQJ
 pRlmBr1ORSE+FCz/fxrqhiRw92Z0EnPHJCjrFeflBS9e0LWEujwkHbpv6+7k7X/4rmJ2gJgx2FH
 s4qB5URC3aLklPK48frM+NfKFMMGUz2
X-Received: by 2002:a05:6000:22c4:b0:45e:fb69:f02b with SMTP id
 ffacd0b85a97d-4623f2e7641mr939787f8f.1.1781636812179; 
 Tue, 16 Jun 2026 12:06:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/61] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Tue, 16 Jun 2026 20:05:46 +0100
Message-ID: <20260616190639.3462006-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-10-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2fd21519b2..a5979d0a5b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,31 +1291,44 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
+    The following options will be set to auto by default if not manually
+    set. When accel=on and these properties are set to auto, the value is
+    derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+    accel=on, this requires at least one cold-plugged vfio-pci device; if
+    none is present at machine init, QEMU will abort.
 
-    ``ril=on|off`` (default: on)
+    If accel=off, auto values resolve to the non-accel defaults given below.
+
+    ``ril=on|off|auto`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
         Range Invalidation support.
 
-    ``ats=on|off`` (default: off)
+        - With accel=off, auto is resolved to 'on'.
+
+    ``ats=on|off|auto`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+        - With accel=off, auto is resolved to 'off'.
+
+    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
         translation do not exceed the host's max supported IPA size.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        - With accel=off, auto is resolved to 44.
+
+    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
         such as Shared Virtual Addressing (SVA) are supported.
 
+        - With accel=off, auto is resolved to 0.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


