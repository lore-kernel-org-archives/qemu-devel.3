Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG9-0006sx-Ou; Thu, 06 Mar 2025 11:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFv-0006kU-59
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFt-0004W1-CL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso5998195e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279168; x=1741883968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3lF4QXwAXqr0/RhGUX/8f5AxZ/nEi7UOp1O/QtSQMQ=;
 b=IkG2lSrn9+bexSIoM48UUDiGUqb2oPo/muMlPRR5D6ReQVkxuEXdjRq4BzR3kcNAEH
 CLks8jhEglv+10P011jijeHHu0p8JU7QkzgR8GR2lE17qGM9+jfcE2TO/6yNaBWeYlzc
 0bgjC/qB2BlKYtst/C71dFV7FmFWTsgKigb11ASJ0YcjlYo1zz3zBKkPE1x+LPEqiGPF
 A3Xbha+HuAgJv4luO9Ol3QmxzOvboEyOdWc8qPJQZMkqetBul9MfTqOXgEDRNpwpgizw
 dVr4EuPUB4t2tVjPWUVsOPgVeRZj+qN6QEv9aXdxuThpnM83R9/8oqsLLlHupZ6ib+Tu
 HWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279168; x=1741883968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3lF4QXwAXqr0/RhGUX/8f5AxZ/nEi7UOp1O/QtSQMQ=;
 b=fgFsivpa8ykJs1Xt6oxbrIQqXzGK6XAjXrOJ2Vme0qZkFi04BQaTe63csFtSJRO0nP
 UVaWhzuvUJ1TVIyZfTxEB69xo/MbaG1OpvGVUrZMy631p/iTa52Ph3A8RcVPwtVAr3qZ
 yAGBGRR2UwN/jID7d4oGXPt6aI41/cH5pvQsqj9F8vF91rRMveX++Ev4bZfkCHAXNRGv
 8DaxtYPTxh3x7ViFCY/E5JswC/sh5MUr3WMOugsZPany4KgSMh9qmwjutvQIUX4hE5co
 YWEFBilQ7kDHhDYxkr8WuZ2AK2y16nxa6BFvQnVuoLZGUORrGy8WpcahlXcC91zT4CjA
 KZ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh9dzDej89jhW0i8KUdrCWiN4ZTRqrNg6/0M4PkJyzq2FqYrTotUZArkdxPTgiBRYEW85kiwBPIa3j@nongnu.org
X-Gm-Message-State: AOJu0YxRAvHaFcBiY4t3j5cZaOc1in3HLDsCSz11lhuaLqsWylaHC2nx
 ZeYgJ34KCT3jWsTs3qxauygzgB/PvQiCJWOK5w+D5v5yq3O1jzD7nECUJUT9dgTZW11c8PRSrkC
 q
X-Gm-Gg: ASbGnct8vTf4F+tvqORkmeXhS4bTU9aGWwZSb8dNVIni1zr76QSLsRdU3H7Ljqd87Ca
 uoYJYj3zbzhEMsLIsjJRHNIIXfLzv9BPd0QR/4QWYKwQLIrZZZhSwhg7A74Xs4LfVrtsGJQB9uh
 pBbWXNvCU7m9mVEv7NMBx3w/4vNfVsVG+5Jvtbm3RsMTdE9FweeOqr8VaJWMjqy/oHUpQ3wbWfr
 uxbKMY4wkmpMPPMexgmEc+j0koHlPcXsQ6uhCZSf2ktGjecVU+hqD6Z6mTS6R49MdIv4K+uQ7oU
 7O/ABOMhq/HBvnmnFP+sJMzawWNfeTPTKl3ztpQJukf5ArJVByw=
X-Google-Smtp-Source: AGHT+IFegjuDYBEVA/nuybmIrjSOCdMavvCdffBIz0j23VZQ1qlsd8N0SHHItuXfI+yWd6348PkEbA==
X-Received: by 2002:a05:600c:474c:b0:439:9b19:9e2d with SMTP id
 5b1f17b1804b1-43c601e1393mr1627435e9.16.1741279167524; 
 Thu, 06 Mar 2025 08:39:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: From ce9a42483c23c32cee233f648101a160b6604b45 Mon Sep 17 00:00:00 2001
Date: Thu,  6 Mar 2025 16:39:14 +0000
Message-ID: <20250306163925.2940297-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Newer Arm CPUs need not implement AArch32 at all exception levels
(and Armv9 forbids implementing AArch32 at any EL except EL0).
All our current CPU models implement both AArch32 and AArch64
at every exception levels, so we currently get away with failing
to enforce that the guest isn't trying to do an exception return
to AArch32 when the target EL doesn't support AArch32.

This patchset adds the missing checks:
 * SCR_EL3.RW has an effective value of 1 if EL2 is AArch64-only
 * HCR_EL2.RW is RAO/WI if EL1 is AArch64-only
 * return to AArch32 when no EL supports AArch32 is an illegal
   exception return

To do this it needs to start off with some cleanup. This is
because we need to add a cpu_isar_feature() check to
arm_el_is_aa64(), but we don't want to include cpu-features.h
in cpu.h. arm_el_is_aa64() is really an internal part of the
CPU implementation, so we can move it to internals.h; this
means also moving some other functions in cpu.h that are
defined as inline functions and which call arm_el_is_aa64().
Removing some unused macros from linux-user allows us to
avoid having linux-user include internals.h.

(No doubt there are other functions that could be moved out
of cpu.h, but I stuck to only the ones that I actually needed
to move.)

thanks
-- PMM

Peter Maydell (10):
  target/arm: Move A32_BANKED_REG_{GET,SET} macros to cpregs.h
  target/arm: Un-inline access_secure_reg()
  linux-user/aarch64: Remove unused get/put_user macros
  linux-user/arm: Remove unused get_put_user macros
  target/arm: Move arm_cpu_data_is_big_endian() etc to internals.h
  target/arm: Move arm_current_el() and arm_el_is_aa64() to internals.h
  target/arm: SCR_EL3.RW should be treated as 1 if EL2 doesn't support
    AArch32
  target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32
  target/arm: Add cpu local variable to exception_return helper
  target/arm: Forbid return to AArch32 when CPU is AArch64-only

 target/arm/cpregs.h           |  28 +++++++
 target/arm/cpu.h              | 153 +---------------------------------
 target/arm/internals.h        | 133 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_cpuif.c     |   1 +
 linux-user/aarch64/cpu_loop.c |  48 -----------
 linux-user/arm/cpu_loop.c     |  43 +---------
 target/arm/arch_dump.c        |   1 +
 target/arm/helper.c           |  16 +++-
 target/arm/tcg/helper-a64.c   |  12 ++-
 target/arm/tcg/hflags.c       |   9 ++
 10 files changed, 202 insertions(+), 242 deletions(-)

-- 
2.43.0


