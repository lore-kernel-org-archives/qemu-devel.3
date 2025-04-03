Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE38C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UWC-0003tL-Fq; Thu, 03 Apr 2025 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UW2-0003ei-Ab
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UW0-0003L4-JO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso954206f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724951; x=1744329751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdaEC/09b6goQVlqijhfvoV2qVf7kL62iAT2aGCf0/8=;
 b=dlLajGiSZM5gaiRenq3y81dPvlACvXb4RJBajSw/DFy8wRV7ZUmQBLmw6WHLi6XU5t
 ahD4CAAxNSNsjogopoMGdFjcllFxXaN3pqGG4HRK6XeoltTQLDgrv05ApOlQokdrePIF
 n3CM+CC0BuCkf051eFBOiPr/YyIonSfvp7Brz+M6+nwCTLvQlaIQ8X/8MQgon51eBhxl
 +mKGNmipM/Z4JEh2uXL2Fqo+5cdJbF/f+lskwPINucinxAVYsRDADUg2o3LqVYuCmaIv
 WudI8vUPBPZ3FMJrVMaf5OMic3MWjBEqUAadLE6WI78uyFU9umPVwxbAZHnPc7E3dmns
 vi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724951; x=1744329751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdaEC/09b6goQVlqijhfvoV2qVf7kL62iAT2aGCf0/8=;
 b=PSr27L2gM6IFjzRabDH53hcHgxCu8umagwFVOjt+BoJE8zYPa6lOtyeyLIKCu6Awrf
 ADiNMSP3IZN2XaUdFlaZx1kL/DQHcGp/2D7/kT5aSqFTo7m3BJSZSpla/f9CEZeMUO/M
 fstJo7I2rT2rVUQvEqfSi1C9Jqc0T2ceAvm3CsLHACJPp74EEnePuaRlB2F3bi5fAOz6
 uJoMouDfjY4Es0aDxA1XbKlgp4iWgTKNP77ebkF0tS8lCaRl0H6+X37XZty7P9avEEwo
 F75zUUZvd/lLzy3QDyTN/2py/sBM07QzIM0E4y5DG88TypfzvyioNZ/3nncR+OKRe/WE
 6q9w==
X-Gm-Message-State: AOJu0YwrKNzVeIHlKMhNllSID+1WQnDH7enrAhiL5rsyb4p3bZMZoPqD
 UOzoHErQzyzHiCJysSjGlKYdHjhQC1Ula1WiyJHY8+GPaUL4ATdvNxVczgVsWRVXfWeYHSQuRUc
 A
X-Gm-Gg: ASbGncu19WNlvYiVeZreCZQ5+ttdwRhpohrQnEavPlpSdpL47Knm1BSJVHj2rKiSrpn
 6A5F7QYPSqTZ+uLujlxKKvh+4QDejhXK/+NFDp/YFcuSNyAiK83Bz1borge9mK1Cf3eilTFwKnR
 uhtvzIc1WfiKCsRp6zUkQ6TQnVEYCXJnnh5w/wbqK5bIC9t6m2p7o6Ol0HSOa9JA3XgyGoZpg98
 Ar79/PqhEmN5zQYFSVgzhBOqQ/4kW4RJmwK7svm2vLVRtfKD9yWlcAsqf0JH8QskiR3Zg2fwf7o
 4EkuAncb3xs0+y435mzHkKmwK8/SHB30FATyP2FZ8qt5/1k9A3Uds6NnEyo5vfd3gHIiGSpTfBh
 NQpCgKkwZH43xmMwX6gw=
X-Google-Smtp-Source: AGHT+IEp0z7YXPYmr8JCPV/VdqD80kQE0M+B+P3ktaqgGl6AEKS/DSDouQuCbkQxlDT4TIrQnCz/6Q==
X-Received: by 2002:a5d:59a9:0:b0:391:300f:749e with SMTP id
 ffacd0b85a97d-39cb35b2592mr929112f8f.11.1743724950868; 
 Thu, 03 Apr 2025 17:02:30 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba17csm3011179f8f.58.2025.04.03.17.02.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 38/39] hw/arm: Move xen files to arm_common_ss[]
Date: Fri,  4 Apr 2025 01:58:20 +0200
Message-ID: <20250403235821.9909-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
XXX untested
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c46e5036722..61f145f901f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -63,7 +63,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files(
+arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
   'xen-pvh.c',
 ))
-- 
2.47.1


