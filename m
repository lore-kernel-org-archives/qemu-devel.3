Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55F2C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsuO-0003Fy-P4; Mon, 07 Jul 2025 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL3-0005F4-Bg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:25 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsKy-0004Fd-EJ
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:19 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4a7a8c2b7b9so53192681cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919675; x=1752524475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gdwyjgqLV2mmRAFlL+Vg+s+HAk+o0jZAFb0Tu/qecK4=;
 b=Y8Uy+Y5qNyZqioxpEdsrUPGoN3i0ygmRR+yCZ90tLm1iEPp3RLxUA34acc+vJ/HwAJ
 2lGeWE1CT8FHz/qtcyNDV3raoyCIBbojSwfiJ6p7zLiuoWVn4fp67iGe+S5XIxGDYoQO
 DolkR1NS2WfyXQynGOZ3ig61fuCGXMS8qw45aFIlkfaPH/njyop5N+KZPJtfZzyDFra1
 tTgepXrW6ZMJk34xsUJyfDqwE6PpAJPT/pRbohLs4KxKHdxHd7OS6YeMPpkCZPBxvZBS
 c6dMsde9f1pMEgQB81UuzUqA4HHybtHN70OoiX/Ynr1PQOVLic7hsuD31NDrhyWFiRpa
 1sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919675; x=1752524475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdwyjgqLV2mmRAFlL+Vg+s+HAk+o0jZAFb0Tu/qecK4=;
 b=TKjbb+Qd9nzswF2Fnqy2Y5dj+X9FCLg5m5clJZPbXAM0i0EYcYcP7sF9fg30XaZRNb
 c0o+7Lq+86/fAYES9IoiglD3aI2rF8xKIDIoplqMOCHmMBadsBBBkfxRo6b3VkQtl121
 fFY0WNKL6h9Jya0KJa6Q+jyg5nLT2XddEdBMMMTazIH3W2az/FWEhhXibnkUDE1Bhfxt
 9AJYPq0utcOjpZv2GVKa/0AoAvsLO3OSJGn498hodQ/f+QZ5FE42DJObtSwiBZUl0nOv
 6mu7OEv3TWhZjARvvzKMmcTPV5sFo6q87CSH2RndYyaP5Rf12BA0jXRnkHnTiynkdzjf
 7P7w==
X-Gm-Message-State: AOJu0Yycim7j9Xta+Ey7CsMiEMxoC41kOSu5UoPQc+mofdBG9HuO3flj
 B5jbvIG8az60mVw8LyHofJy7vQPOs2GkO2ajsI1DLBd1fJBVGg3R/MkieceaBXOlbqzBtMW4mfU
 FPtRlJcU=
X-Gm-Gg: ASbGncv9fa0SdnarNp/DfpuAM34u3a9wWA2zHXYgBiOLYmxIBATZHXYAlBZmoWn/BxY
 mJzLTme38gOqxK2ikZR/3wgm/U8Ns2mnI+ZRb7mZNu3Tr0ftzPMczX4K2NzZzy8stMWNcgN6Zvq
 tlTb8ehmbIlJ4scnB1P2+A06a7AibNKDbrFtFbGZkKa0h46isyK8jMf+MEHkM0gYWQCzLw1hm/c
 BUQk0PiidoGrANnRdC6LhL9vpHSQHAGDJ1GWDxvTirOURJe6xX3+a9mq/0a70IyAJGesL0wx7Gq
 1WxhTbksVpXNRjy424kSFi7WpbbpitQUyI4Dmv3Za5j1QKTyzde3uF4pY3LDYgGp9/aCa7nqjA1
 G2Ef9nTajw/d3xEwv
X-Google-Smtp-Source: AGHT+IFsSvSSpH4EVQOmi2EwSdvLVfVe3zInpAu8F/yOtahHFu0N2uWNcfckhHG/In8gitb0z1wglg==
X-Received: by 2002:a05:622a:4114:b0:4a9:c4a7:4a76 with SMTP id
 d75a77b69052e-4a9c4a74bbdmr44603411cf.8.1751919675121; 
 Mon, 07 Jul 2025 13:21:15 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/20] target/arm: Implement FEAT_ATS1A
Date: Mon,  7 Jul 2025 14:20:51 -0600
Message-ID: <20250707202111.293787-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

Based-on: 20250707151547.196393-1-richard.henderson@linaro.org
("[PATCH 0/3] target/arm: Split out AT and PMU cpregs")

(1) Lots of tiny cleanups allowing the permission check to be skipped.
(2) Skip the permission check for gdbstub.
(3) A fix for existing AT instructions in that hw should not update the
    PTE dirty bit (and we choose not to update the access flag as well).
(4) Implement FEAT_ATS1A.


r~


Richard Henderson (20):
  target/arm: Convert get_phys_addr_v5 to access_perm
  target/arm: Convert get_phys_addr_v6 to access_perm
  target/arm: Convert get_phys_addr_lpae to access_perm
  target/arm: Convert get_phys_addr_pmsav5 to access_perm
  target/arm: Convert get_phys_addr_pmsav7 to access_perm
  target/arm: Convert pmsav8_mpu_lookup to access_perm
  target/arm: Convert v8m_is_sau_exempt to access_perm
  target/arm: Convert v8m_security_lookup to access_perm
  target/arm: Convert get_phys_addr_pmsav8 to access_perm
  target/arm: Convert get_phys_addr_disabled to access_perm
  target/arm: Convert get_phys_addr_nogpc to access_perm
  target/arm: Convert get_phys_addr_gpc to access_perm
  target/arm: Convert get_phys_addr_with_space_nogpc to access_perm
  target/arm: Convert get_phys_addr to access_perm
  target/arm: Skip permission check from
    arm_cpu_get_phys_page_attrs_debug
  target/arm: Introduce get_phys_addr_for_at
  target/arm: Skip AF and DB updates for AccessType_AT
  target/arm: Convert do_ats_write to access_perm
  target/arm: Fill in HFGITR_EL2 bits for Arm v9.5
  target/arm: Implement FEAT_ATS1A

 target/arm/cpregs.h           |   6 ++
 target/arm/cpu-features.h     |   5 ++
 target/arm/internals.h        |  27 +++----
 target/arm/ptw.c              | 134 +++++++++++++++++++---------------
 target/arm/tcg/cpregs-at.c    |  67 +++++++++++++----
 target/arm/tcg/cpu64.c        |   1 +
 target/arm/tcg/m_helper.c     |  17 ++---
 docs/system/arm/emulation.rst |   1 +
 8 files changed, 161 insertions(+), 97 deletions(-)

-- 
2.43.0


