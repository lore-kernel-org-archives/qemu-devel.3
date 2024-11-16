Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E65DD68BE7
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 17:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCMFQ-00038H-Ll; Sat, 16 Nov 2024 12:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCMFG-00036Q-MJ
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 12:06:02 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCMFD-00014g-OS
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 12:06:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cdb889222so16651525ad.3
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731776758; x=1732381558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaLGhjAOYy2IzboAb4IO24QLbt6fV2I1geEVofMzaw4=;
 b=QMxmQDAOtJdRzGPFNxEMavSae8hz/Ne3eIJbvvmRlQIiinU3Nb5OLfNicwdqAw1jtH
 +OvKop9rQdEn6B6EhGWUDaYO9Evj5jyTqvaLxgeVxBj/OekgkgwKMUL6W4p2Sv6TEcyv
 c4JLoEZbaiZ11mBFj0fmy40hEHcfqmorBASsPwob5Cq/VxeAj0w3DMp37cJLYF6sv561
 VjpaGLmAsaem82O2PJKCIo5hWyJKnCp2bwwV+M0zydWqwG+VXLsweEe5EpDTxvTFL824
 5GV5ILTq/Tn4WcRxI0akdwVgFQeyqOPsGun5HjRInYVJi55dWKoll+gvOHiZSFHl48j7
 ot7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731776758; x=1732381558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaLGhjAOYy2IzboAb4IO24QLbt6fV2I1geEVofMzaw4=;
 b=PM5+DD/hkvDOQkkhBKXAxGNlc7C6XrkSRErb5ap89OTi5EkXRCYxxxriyFYAifGsAT
 AUhebg6O/tn5A/KsLgXGfz/QF3L31+TejiVLSw+ykocuxlEqkNsMNVjEEd+iF5zDEefu
 846SpBrzOh+jJzu0ietxpmu0rVhvRwE4DIG0Z1/TMZU2QOPQ2CokBQXmVHzY3HTF6EqD
 VrlLT9BStEMkTUp8i1A2CBRxBJrMro9djonmZx3iku5WomZtqepoPge+K/afODqeHPY2
 /lga6mXGAHhp4BatGU8ODip/Xkyo4KUZPvOhV2xtCsHwrBet+0UbAQ71Ir0kkryFNxdu
 8WQQ==
X-Gm-Message-State: AOJu0YwOQih3/t2CkrTLUv1snT9dYSsxPM7KfUlWL8fSwsLjwESUe5lx
 O0gxuEahTB1x3WyljoA9UjmLoyoarDvUdavP78Ve7KmznGbWSxJfw12xr3ezWln0I4FTE7qZpJ+
 n
X-Google-Smtp-Source: AGHT+IGB5w7YRfujTLQOLCVpavBsoQyRuMV3GMZwHnjYKp43G9A05O5ubkyWj/jZoASZXaOC+izcJQ==
X-Received: by 2002:a17:903:2310:b0:20b:6d47:a3b0 with SMTP id
 d9443c01a7336-211d0d7fabamr86941145ad.21.1731776757794; 
 Sat, 16 Nov 2024 09:05:57 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51ca8sm29574585ad.230.2024.11.16.09.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 09:05:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PULL v2 02/15] target/arm: Drop user-only special case in sve_stN_r
Date: Sat, 16 Nov 2024 09:05:55 -0800
Message-ID: <20241116170555.461462-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116170555.461462-1-richard.henderson@linaro.org>
References: <20241116170555.461462-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This path is reachable with plugins enabled, and provoked
with run-plugin-catch-syscalls-with-libinline.so.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241112141232.321354-1-richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f1ee0e060f..904296705c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6317,9 +6317,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
-#ifdef CONFIG_USER_ONLY
-        g_assert_not_reached();
-#else
         /*
          * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
@@ -6350,7 +6347,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
         return;
-#endif
     }
 
     mem_off = info.mem_off_first[0];
-- 
2.43.0


