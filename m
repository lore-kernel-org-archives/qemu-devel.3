Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7677CCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtU9-0005hB-Kz; Fri, 15 May 2026 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU2-0005d5-6D
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU0-0000tu-Or
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso60422285e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855143; x=1779459943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=q4fgK36sSo3TBVry93HVuy8ilXSmIn8bEO/5kIWJOSo=;
 b=EJ6F1QcW7MeuisgOqsUkgDKNzjVnK9HsvPxIMc0sVtkfqO6LeirQlYekLld7S+MPSy
 f9Z7UaFDfNIOJt9DvdOdBGWY+/nsTQ6nFYbWE4ozkpRRkczao7H2it46BjECCkUob59K
 6Sc6UjGeld6JOXdsLKuRy33JYD6Mt40vjTqJ3q9quqT7RVDGClakbhtpCm9oQ5Kp46/A
 i1CXhkjVV7rs5pDNUgr3OOK7CIjjqNoxo4ndpI1qbzw4b+GF8tLljFJKiiomvYbB2qoT
 dhoN1yIo/JItt/Rm/aZb+ZhiEmPX/b1F/DaqV2fLM/EHGduQ7Pvt0JVulj22aPG2uzxJ
 h86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855143; x=1779459943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q4fgK36sSo3TBVry93HVuy8ilXSmIn8bEO/5kIWJOSo=;
 b=ZemWEvtLLp2P8QgCNQsue9fGReHK1WXZ5mMdlS9teBNJsh1G6q69SQpnfz55Luc4NK
 Bj8eYwNgyNv+0AhM+ADwRDoWEHlaQ5/tKRkH6SGLEvSNX78d/tzn7YMjuHy+4BE17gHN
 RDFCSTrRnB6hc4qBAhmGMtntFdanx8njOFu34Jlrb8lnOUdDgpm9dkFOD4w3HQu4Sqyk
 xFWVzdAShN6NAjAFUMSXstavugrimMr0a8Gj/gTvA4RY+IaquQjBFRaTSBWvEYMLl9KY
 GPSTBgjz+u03uoldB/vjelFwhLC9ZHgj64gK/294T28ojP66UCdmLms/MKUFVkqKRxIy
 EbJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FucnX/9mGENwNTBnkkig54rkoyiu2GWmJPdfwcbmMXzMP9jX9BHyLIVOgNgLIc5xqJ8fE9FqLbEYv@nongnu.org
X-Gm-Message-State: AOJu0Yy1cUBK02menTawlZffBIE3m3Nx3i2Vg6LdbotyGO2nI8dLXikP
 6HUWhzmfuiE1rXEYYZbKpQdvCg0mMgF4+E2Zjb6xLtEEU6DZjqezUhYdF+gERoDU6y1bkUMJmmq
 WSfop
X-Gm-Gg: Acq92OGZYG4fM6KReCGMCUHUWrDWgw6bJw3ltrWCffR+gzXvPvXpTBEN3F+oEZG2xr5
 hvy8jESLwZSF554x0M2W3ulvOUSNAXJdEYaZHEm+VXRV47FO1fp0HmEp0BwErppbR961AGGjyiq
 i0WG5BsGnT2L14HH07Nn94M3gf2E7Wk0d0zFCH3/whz6JFPQOlJyHN37U1lmqKSGaANKzGuqSJ8
 oJCbRHqShhWgZAirKtbW6MZhHzjqgCAtNaMc06nq31aSvY8qzuAKBU8hyELHLx5olSoPntdLY/F
 6Tuovmu5+wAvcZynO/2olO7CY/jS1+NrBfLkFkqa+XbonV8Wc4UN5k+GgRU9JkHnsgFKQDkX2AG
 dgxcJBgIC+eta5ieMj+8+RnxEGcRBF1uJRRoSUk8sW3Me57KG9hN7mZ6HZYmDo7q5gDOXrVmvHt
 hX6Lt919LQORE0J63QQWIWrg4Y9+mNXm/qTozYPIQYQXxTs6aKHf3W9bw0oUA63OZb8b/GL28u5
 vXXSikL6sUq2IA+ajy8KsAzp0+HR0CZ9Leypl/0uw==
X-Received: by 2002:a05:600c:8b18:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48fe6515983mr64148455e9.23.1778855143144; 
 Fri, 15 May 2026 07:25:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 00/14] target/arm/ptw: Flip sense of get_phys_addr*
 function return values
Date: Fri, 15 May 2026 15:25:27 +0100
Message-ID: <20260515142541.571911-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This patchset changes all the get_phys_addr* functions in the arm
page-table-walk code so that instead of "return true on translation
failure, false on success" they are "return true on success, false on
failure". This convention seems more intuitive and it matches the
sense we use for the translate_for_debug and tlb_fill_align methods.

I've marked it RFC for two reasons:
(1) I'm on the fence about whether the upheaval is worth it; I
think on balance yes, especially now I've done the work, but
you could argue the other way
(2) I'm open to suggestions of whether the patchset could
be better structured for review

On point 2: I opted to convert one function at a time, on the theory
that you can then review each patch by checking (a) are all the
function's callsites updated to invert the sense of the return value
(b) do all the "return" statements in the function change.  It does
mean that the patchset has a lot of places where we add a "!" logical
NOT and then remove it again at a later point in the patchset.

thanks
-- PMM

Peter Maydell (14):
  target/arm/ptw: Flip sense of get_phys_addr_disabled return value
  target/arm/ptw: Flip sense of get_phys_addr_lpae return value
  target/arm/ptw: Flip sense of get_phys_addr_v6 return value
  target/arm/ptw: Flip sense of get_phys_addr_v5 return value
  target/arm/ptw: Flip sense of get_phys_addr_psmav5 return value
  target/arm/ptw: Flip sense of get_phys_addr_pmsav7 return value
  target/arm/ptw: Flip sense of get_phys_addr_pmsav8 return value
  target/arm/ptw: Flip sense of pmsav8_mpu_lookup return value
  target/arm/ptw: Flip sense of get_phys_addr_twostage return value
  target/arm/ptw: Flip sense of get_phys_addr_nogpc return value
  target/arm/ptw: Flip sense of get_phys_addr_gpc return value
  target/arm/ptw: Flip sense of arm_cpu_get_phys_addr return value
  target/arm/ptw: Flip sense of get_phys_addr_for_at return value
  target/arm/ptw: Flip sense of get_phys_addr return value

 target/arm/internals.h      |  4 +-
 target/arm/ptw.c            | 82 ++++++++++++++++++-------------------
 target/arm/tcg/cpregs-at.c  | 12 +++---
 target/arm/tcg/m_helper.c   |  8 ++--
 target/arm/tcg/tlb_helper.c |  6 +--
 5 files changed, 55 insertions(+), 57 deletions(-)

-- 
2.43.0


