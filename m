Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E16CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvT-0003H2-3Z; Wed, 06 May 2026 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvQ-0002wD-2R
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvO-000286-Co
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so72997135e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076508; x=1778681308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PWbNAwxgFE54VWoaiHwHEhttmkywv5oUyoPiI95fGyA=;
 b=dD4m1Og44Orvis9nlhIxsl+Bc40E+3mfcC88dDKHN9rbiL5OQANQeltlbjcsshWUHw
 95yXjlBT1SjYr7tHoqmLdvJe5IIy/8NH0v76ZVGTwv2zG5Pth5W9uxcRo6VeXBJPDivE
 Xy11eMLa3g9NtFxDBNWTkQl8tkrgtIGX3k0FhVYAfw3VjJq6vMYBimw7O5mC+IClbXor
 Qnmsj+BRcPdepi0gSZOVrILna+EWLHuA5ebYuxGi7LPcEsqyUA0hPJR2TKXfZzij3uYA
 rWv+Ch/lnVV1AMKmVwCxANutklEIf4EptsCCip3dJL+rmJCGPfnRAU/X/BzmC+H1Gbhl
 KuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076508; x=1778681308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PWbNAwxgFE54VWoaiHwHEhttmkywv5oUyoPiI95fGyA=;
 b=Cj4nsD28pqcs47cjRAetQWZKP5yhYW7WqBOnH+oufOz/U7jw4qkwR4bLbtHSHcL8q/
 E1LnGhjcZuCkPY14dWaKOEbTu+eRG836ER6NTI/r8PiwsjVXAbkAAvHt1pAiSD22su5j
 GO6kJ/hh8hiLNmaNuTKzrosROq8RcDaIuiBkDvjNWK+3SKDIjQfDlvovzfD9TLVdstHj
 rqtsdNxUp3YJYmWqA6dsBpTYyScUG4pnHkxTLo2icfp1u3Y8B6CEaPcNvcQPf+AFyBCo
 NXV37GXMtZHVdWW6y4+uF6+MGVtfQp1DLxiLb44lofdCioGETbecquZHWyBytGZPye41
 YryA==
X-Gm-Message-State: AOJu0YwUYltG8vzq5c49uiPFT4u4OUUentJuQ5pO6+lHIOUwRFlewHJe
 hB26PXr9TsyzqUi6yCsLijc2NHWiLZthmT7p/JUG1gEvIT/cZCmTAGlqXAEAn8feFTtUZnST1l7
 sdJrADw0=
X-Gm-Gg: AeBDieuZAwqDkTesDIC3u1ANNMdqwFJdgEvlbtQjzOzhqit/afDap5uQuy02BO3R8X0
 +TfDWIlFnrWEhv24iy6kh0f6CGImooVItiTB5GQhxCdBPETVdAILtH0b9BLkgFDzfgTd6yI/vv/
 cx8a/bMcyHWCmchILCQ7Iez7yki6mpI4W4pOTXjWbm0WmssMUJO2ygQNM5vmpQLP05H+ahgqsjm
 pNePlWXSqvJTz8j88lUp4lsVW42oL37lScAf0ucebr5Y0uGW2HXP8TL5BvXfCTopc2luqvBGwD/
 TNDsVPHCEU0bF4cs+wcZjiyfn9/iGoTBbwFQRLkEBLnACD/wfguem8R4fVurzZNoihT5L6ej1oc
 HanHbydq2vFv1knp0Jp95cN1MoVtBwcvaWiVywls7S7A6VT/S9UK3DmXq5uloWnYlkqfHL9eCFW
 F7oGMDxWnRgSawzHu4P0YnuULMg+cpC3RqXl3odp8E2lydBOcWEHrRRZ+dnW2uRQYDgRMn2c65x
 CYUfXKSqus=
X-Received: by 2002:a05:600c:3548:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48e51e09706mr62060615e9.4.1778076507793; 
 Wed, 06 May 2026 07:08:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895f0asm54981505e9.2.2026.05.06.07.08.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 099/110] target/s390x: Do not compile KVM stubs for linux-user
 binary
Date: Wed,  6 May 2026 15:55:11 +0200
Message-ID: <20260506135524.20617-100-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

None of these KVM symbols should be used in the qemu-s390x
linux-user binary. Do not build the stub there, prefer a
real linker failure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-3-philmd@linaro.org>
---
 target/s390x/kvm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
index 588a9aa737e..437e12f221f 100644
--- a/target/s390x/kvm/meson.build
+++ b/target/s390x/kvm/meson.build
@@ -1,5 +1,5 @@
 
-s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
+s390x_system_ss.add(when: 'CONFIG_KVM', if_true: files(
   'pv.c',
   'kvm.c',
   'stsi-topology.c'
-- 
2.53.0


