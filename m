Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C7CF0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwl-00013f-Rh; Fri, 06 Mar 2026 07:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwU-00011P-MP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:11 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwQ-0005Mw-DK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso83782375e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798760; x=1773403560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NxOBnzQxTJgWwjiPp6IkXP/wGFk0Sz5c7edRawQl4pY=;
 b=zrWSkijQx6NtnKJ6zNvfV1keOj3uHZWIvgKdurub7IiTVl3w0inkZ+YAfFXAU1YN3M
 CAqiuA1+c4yJzJ8EfPPtdHcJ+Q1epAZJonUvlIIYWPgd12Q40u+KplFvYwcRqmBdlp6D
 ECopVCnnFN7qFrDyLu7+5uH2dgmj+VgSY2pK+ismfa2DLuIyPI4ABFv2+QpjE9LmqYI/
 eVGaubAkEFAMhpaza5Jw/XR7NwJnw8VDtl6SRs8ICqFgmeX3wtOOEvqNvv9KoI+agOLS
 6PwugtXXXd/JIeXDPknQdlkDDIag0qA/CmLu8uUclWe306Z39LZxEiXMi6X9LS4sxcJ7
 FJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798760; x=1773403560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NxOBnzQxTJgWwjiPp6IkXP/wGFk0Sz5c7edRawQl4pY=;
 b=pOtca3a5AvLOnIZA9yEpUpafN9c3YhAbD8ks7Bl3qGayblCobV4sK1qsaFddQUVHOo
 2XXHB8Bn8SjF3+5qrB3Qc7YnuC1WWEMxCyYF/bf5gK8V1w+GmGjl51C3k61X0lwVPfkw
 BJwgCBWlGazaatDBjX8jECUpxL0Exvpecr3laIHKm38wv7qzTyJIw4BgmJbHuSDG8nXk
 +wPwhrJtcyRpw7xL5cp9YLi3XDKpM5RJuHqYAuV+IyZeHCs5JOm94mKEgmj15NHontvw
 lxapu1coxX5BIr2JPRoGJSMCAweXQ7LiWrJxbewSE/dN7KD/TDChnUDXmrzpuXRNVK9F
 kjng==
X-Gm-Message-State: AOJu0YycqYYsme9jIWDLBN2oay7QLDSLeYN53s/S4yJayQ06bI5rXBk9
 WPVPSm3sAIGLJ6Ff6HD7XvKzFLpql7zMvXSau4QPYjbJUkmHTdUIOV3nftU0jwIFWIOM30ygFdg
 LEbaj
X-Gm-Gg: ATEYQzyQPgPs9XQdrqbBtYHMVOBqY3K2xNSL9gYG1Q4mlBrvo5/1aDvsbkD+LknQf3i
 2mq5I+mpsyxkfhlB06qbSgGMA2f6T1PWxUnD933G7G1Vz6GhQwn/IOY50fE8i35CaNGO47vz8hu
 SgcXGZgY9pVRHj+nS8k3PXH3R3MhaOo9QkK3i0ZdpwEeUMZob78158klJt/cPO5q0Z7QHj9tYJN
 VRK3s2ia2dqpcNNz+EtOGmZm/gmY0LWALW/Vbv8oEfVOIRmKkQ2Ro7iVRXXTROGADdiEtRX+d9B
 euSxhu3ZJKbt2Cwj82bly7GtvazLYWmUjwRMfvFFY9yu9O5cdyAtR4qf+ctPVR7nJgEYS5ZyFDf
 L+K+bfQ1smqVZb+AXpHwcg8buiLZXsFgDyVCiq2zSGipPmZ7MbacCevc6FfNRzCDMVkTOmb2sNb
 EwFhazRgvhIU+jVVsS+LIU1Rig/WTY4gaTRwTLsPEWRZDzi+J8JH3A/MHf6YXgSEVejIIkE6JtW
 AkDHbX9gm/8waSvRAo7UOJf46Nfm6g=
X-Received: by 2002:a05:600c:3596:b0:483:709e:f22d with SMTP id
 5b1f17b1804b1-48526964c5bmr27894285e9.27.1772798759858; 
 Fri, 06 Mar 2026 04:05:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.05.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:05:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] MAINTAINERS: Remove Eduardo Habkost
Date: Fri,  6 Mar 2026 12:05:52 +0000
Message-ID: <20260306120555.2035421-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Eduardo Habkost doesn't wish to be listed in MAINTAINERS any more;
remove his email, and also the git trees he used to use.

Move the QOM boilerplate conversion script scripts/codeconverter
to "Orphan" status, as it no longer has any listed maintainers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 256859737c..5aa369e6e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -422,7 +422,6 @@ F: tests/tcg/sparc64/
 X86 TCG CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <richard.henderson@linaro.org>
-M: Eduardo Habkost <eduardo@habkost.net>
 S: Maintained
 F: target/i386/tcg/
 F: tests/tcg/i386/
@@ -430,7 +429,6 @@ F: tests/tcg/x86_64/
 F: hw/i386/
 F: docs/system/i386/cpu.rst
 F: docs/system/cpu-models-x86*
-T: git https://gitlab.com/ehabkost/qemu.git x86-next
 
 Xtensa TCG CPUs
 M: Max Filippov <jcmvbkbc@gmail.com>
@@ -2024,7 +2022,6 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
@@ -2047,7 +2044,6 @@ F: include/system/numa.h
 F: tests/functional/x86_64/test_cpu_queries.py
 F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
-T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 TargetInfo API
 M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
@@ -3456,7 +3452,6 @@ S: Maintained
 F: backends/hostmem*.c
 F: include/system/hostmem.h
 F: docs/system/vm-templating.rst
-T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
@@ -3559,7 +3554,6 @@ T: git https://github.com/kostyanf14/qemu.git qga-win32
 QOM
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Eduardo Habkost <eduardo@habkost.net>
 S: Supported
 F: docs/devel/qom.rst
 F: docs/qdev-device-use.txt
@@ -3582,8 +3576,7 @@ F: tests/unit/test-qdev-global-props.c
 F: tests/qtest/qom-test.c
 
 QOM boilerplate conversion script
-M: Eduardo Habkost <eduardo@habkost.net>
-S: Maintained
+S: Orphan
 F: scripts/codeconverter/
 
 QMP
-- 
2.43.0


