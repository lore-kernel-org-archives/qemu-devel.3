Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F56BE63F2D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXQ-0002V2-Aq; Sun, 15 Feb 2026 22:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXO-0002Ur-Ul
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXN-0002NF-5d
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aae146b604so20919615ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213479; x=1771818279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N1dWwblShtU/K1pEStkcQTqcgPLAHki/FI2GQRACns4=;
 b=HoynBAOEicHDhN7yujRWkptybXL+GXPdjqmhtdOR1AEwLCkYb/Eg7bR25xXYcpELXI
 THiBx+tmLe9kTxCI8zXkPSfJDQ6nNSreV22WLLHmf9+aHZkrwgJYhrlR5GZ0vtmkoWwR
 lQpAwx2XBSgSkaynkw8Bu5GUuRRgZBk1kQUZAtL2BXIfMDraRQfn3OU88UZsuOiwalhH
 rioT0K+p8v2pjl1gRMZ174rp4HpGpdXYwQ551TCT9SLMu4XhtBz8Y92kZ9gONKenTEY2
 xNfmrlP+hVuSKu3F8qYqsg/rj+7w0c9otNtbhHcl/xu9QTc7jDmbkdhZ5lT4WZhQlf7H
 pRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213479; x=1771818279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1dWwblShtU/K1pEStkcQTqcgPLAHki/FI2GQRACns4=;
 b=Ew6ol1ZLwGEmAz8LZx7ax8d8N/Ezx54Sbtdr6FQymYu6QEFKgd4/iSje2ppvg6GiQc
 JfzjUqdnQvTU8lLpFr3wp8PQsgw2c8TKllOGRpAVwdrRG4QX1I4Pg3evlRnEGE+KKKfL
 wUPBpbpBazy+7flKSkzIxH7vfJFfxW9PVK9MM6w1viSlfgQFWhaZZueTkRALA3KZC8yI
 grztDFmwLJHYvPXSrew7YfE1kcop+G5p8h9WQ3lSN3cN6oLzpgyVzadLyeO8V9rryxG/
 w7d3/SHbAVJVPj0EzqWvL7l7zkGV4hy6Hx+/b+irgMAvw3k2eiUnStc0EyllDgj6erpF
 4q5g==
X-Gm-Message-State: AOJu0YxFAGKCGZQ3oF64CiUDm4fhWL1Fxkciy8WNnj6hTHRlK9YHY4dw
 iHrv9+/zblVHOZM8TIawSFEgBuVnVv2zp55pmaXPp+xml7rCtOjNzU+QSNbniXRIhhuwqvzuKx5
 khVAFQE4=
X-Gm-Gg: AZuq6aLbzMTlYedQZIi45SnUkISzUiqpyJ6eKA1W4Tftll42XdNcEX6UoeEKlfEAGBv
 bFoBJR0zRW9yUwNqdx5yHf/nFHOfe9wyYq4IBhjtUGmnLKiVYiDCyjw5AWJca2JaEZR80SEJ/yy
 3QVN9/5Z0CdNJfyOl4fSBqy/twMzfrzWJs4sJ6ZukMiLPI69NA+/OAB0RSnjeRhegS1Tmm/TORw
 lfI/XWgDlEWJ5u8H7XvTT/G6n5cKLJKnpgNwID8tgHlllm5MObK3EqL+Ism8JUmwrmeOIsM9PWd
 dJf/6b/cvPDLic4YbZZ/GdlfFZKM3hJd8H4lUGhorX/4LrCAPm0GwdUIDwVfUcHjrJIDBVfzMBl
 B2hstlDOdU4nqK8eHplhtkB2EMWD+aPApsLsoW+HJOdqdVm6cwZUS1Hyifg+q8mn0jSLYiOC9IS
 UJutnmFWW3SVu3TFtHMNV+9nPyUVKxbkMrrNcz2AUQf4k=
X-Received: by 2002:a17:903:b48:b0:2aa:d600:d03e with SMTP id
 d9443c01a7336-2ab4cf84015mr93452445ad.18.1771213478601; 
 Sun, 15 Feb 2026 19:44:38 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/13] target/arm: Support SME for KVM
Date: Mon, 16 Feb 2026 13:44:19 +1000
Message-ID: <20260216034432.23912-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

RFC mostly because the kernel support is not yet upsteam.
This is based on

https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org/

Properly testing this will take more time.  I'm not 100%
sure how to confirm that the SME registers have the correct
value across migration.

I'm thinking of a test case in which the ZArray is loaded,
the test program pauses, migration or vm save/load initiated,
and the ZArray contents are verified after continuing.
But anything that takes timing into account like that
seems way sketchy, so I dunno.

All I can say at the moment is that the VM does start up
with SME enabled and stuff doesn't crash, but that the
get/put paths are not really exercised.


r~


Richard Henderson (13):
  NOTFORMERGE: Update linux-headers for arm64 kvm from SME devel branch
  target/arm: Remove aarch64 test for kvm
  target/arm: Move kvm_arm_sve_get_vls within kvm.c
  target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
  target/arm: Move kvm test out of cpu_arm_set_sve
  target/arm: Drop kvm_arm_sve_supported
  target/arm: Remove kvm test in arm_set_pmu
  target/arm: Drop kvm_arm_pmu_supported
  target/arm: Detect SME in kvm_arm_get_host_cpu_features
  target/arm: Add vq argument to kvm_arch_{get,put}_sve
  target/arm: Add have_ffr argument to kvm_arch_{get,put}_sve
  target/arm: Add SME state to kvm_arch_{get,put}_registers
  target/arm: Add SME properties for KVM

 linux-headers/asm-arm64/kvm.h |  33 ++++
 linux-headers/linux/kvm.h     |   1 +
 target/arm/kvm_arm.h          |  35 ----
 target/arm/cpu.c              |   4 -
 target/arm/cpu64.c            |  90 ++++++----
 target/arm/kvm-stub.c         |  15 --
 target/arm/kvm.c              | 308 +++++++++++++++++++++++-----------
 target/arm/tcg/cpu64.c        |   2 +-
 8 files changed, 306 insertions(+), 182 deletions(-)

-- 
2.43.0


