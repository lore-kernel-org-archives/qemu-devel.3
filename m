Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4472DC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtPk-0002D2-W6; Tue, 13 Aug 2024 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtPe-0001uF-UX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:26:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdtPd-0005hi-1P
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:26:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so2773470f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562774; x=1724167574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cR8DL4fFh9wwc7+M9JHjarbbrgOTCmPyE0fl6m12ljw=;
 b=T26+Sdu/Je2BUPFZmvi7nrdvBipLZyWTUHDxMnxE+A0H3ywT5lUwVfmM15NqLhFbhu
 DuYKOqTxxD+9llE3FyCP8mk4aYnf9Y3jufJjdbSth4JjN6jxhHfEoKKyGpTF233s0Srx
 z2oMxlYm6HPPKqA3ek0Lg6dZoxhnqr0mvRJDm1QuNV29qDWppiVc1UtohSIzAvQ1X8uq
 Hy6sVpFPlA2mIV2/T+PnNLnD/ygSDJyuwiD4AgAZpWkYKsX1zCbpe2Ze8XOriIBvseP2
 yQmadiowva2PnOy2ePk6eBMFd/PSjwDm/xteTbv/CDl6fPiVdnruD3EGIfxHZOYAxy5E
 s5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562774; x=1724167574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cR8DL4fFh9wwc7+M9JHjarbbrgOTCmPyE0fl6m12ljw=;
 b=ksHpL+lQlme3CcVRiNPxZ2p3aD15GuL0iOdmQwJAxzRk33tHKs2gqottuiyKhD+zIX
 Wi9j0a3u0P4OkJfSeEGSnArVLPqWfmrtrzeMQRK3UUO6ie8oRoOiKsuSecJ9GG1iZJME
 kWYP0Tfonza+SrF/FGEuuzTwaZKR8REIusgkUu5x16kJjpeobkrN+y0bpIdxeWeUy2ky
 edlumDNrEV1jOKevAtnYDR+KsklzRJ4hikHzIHmWgT6IupT0Qapvk1A0ErnlgLbcfTVh
 BLY3+pWZyDAKZ2y2VOviNulX8S5vzs6MNx/aBgv4q1v6vLbk0nXZOefIDfK1Vqa6id4s
 fO8A==
X-Gm-Message-State: AOJu0YwOgPqndeg41e3fZxbWzFO1x3fvsV0aAYj69vJYgPTAUvyaeZmL
 O3KJoqnkXbci5HO9tVoysvGU/SdmJeFV3by7EouVBfG5XgV+8/MYw/yCKDYivpB6v/FAAaBuHOg
 Z/rM=
X-Google-Smtp-Source: AGHT+IEwq/XIEpRxiRf6HpQeQZwTpeBSAaMjS84//ESorvACUWefTPRH+FR7n9Gw2o4BAX1JqMSTlQ==
X-Received: by 2002:adf:a451:0:b0:36b:bcef:b393 with SMTP id
 ffacd0b85a97d-3716cd256b6mr2712357f8f.57.1723562773910; 
 Tue, 13 Aug 2024 08:26:13 -0700 (PDT)
Received: from localhost.localdomain (80.red-88-28-4.dynamicip.rima-tde.net.
 [88.28.4.80]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36bcbasm10649361f8f.18.2024.08.13.08.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 08:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-9.1?] target/mips: Load PTE as DATA
Date: Tue, 13 Aug 2024 17:26:10 +0200
Message-ID: <20240813152610.97883-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PTE is not CODE so load it as normal DATA access.

Fixes: 074cfcb4da ("Implement hardware page table walker for MIPS32")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240813135313.96519-1-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 5bff4cb72f..7050ea78df 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -603,9 +603,9 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
 
     oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
     if (op == MO_64) {
-        *pte = cpu_ldq_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldq_mmu(env, vaddr, oi, 0);
     } else {
-        *pte = cpu_ldl_code_mmu(env, vaddr, oi, 0);
+        *pte = cpu_ldl_mmu(env, vaddr, oi, 0);
     }
 
     return true;
-- 
2.45.2


