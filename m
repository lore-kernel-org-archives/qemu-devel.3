Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A82C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 15:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15nX-0006BH-99; Sat, 05 Apr 2025 11:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nQ-0006AF-PJ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nP-0002fx-7m
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso3633056b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868256; x=1744473056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NdYCVDvrgjk5vJpHMjPCvppjcdEfZpZQeiN/B/ja6wI=;
 b=cRfWgQXmLjweFRbthch4dIrn80qBEqlG37VVIigdEu0SDXRvHG7/x8b3AN8bqJoxBr
 JzBBD9OUjSPRK5R2nwpDO3sldnmKr84dMtwLHaXYhEY//gAxi+YtrfGYcg6/c3obFURJ
 DQFXsYkXy3uXbBUYc10QNP84jmcLEo1Xql5MVeHhM6xsgBhyIR9MDCAnVr1zu/w0jl7d
 D6hh8BwVf711CEi4uCqGFP+QWEeMLR3H/0oaykVb8mebHOmnhmiM6yZkdsJkExGWy5Kh
 J0ElhO1Y0322tCK/1bCqQnuNUSaGTpSdeXFyVnd4ILDPn0tJfftqahKN8bS2EdN3N1V0
 xQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868256; x=1744473056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NdYCVDvrgjk5vJpHMjPCvppjcdEfZpZQeiN/B/ja6wI=;
 b=R1I7PKP2mnSvzgJDw5I24xJAxYqUMi/S5nIfI182nhIEFeYQN/FPrwuCAxUhGTYONM
 aTA2Pst3Wl1iQZl53kSd7YCBawUmsR6GbQ5cLS5dzWzcjH1nQI0oDfs8spKXNZU0ve1T
 YW0VhFBZvM5Z1YA/I2ZFdV2J77spsGHaINN6sNT4zGoLECLZq9OLUDrzZ/itqgPmYVxo
 fn9UUSTCfSAY0ZZYJB+caQtZx2exQBnFj5FR2Eug/YKnVfsk93HO4mc08JGMNcc9uqYK
 /CaEOlHMGGiQfReJiwoPbNIx1j2iq46x9gjQ5w6nrD7QPmMCQrqXrObc9afHJTzfQupL
 Ja/A==
X-Gm-Message-State: AOJu0YyoBfB/luf96em+zlrGAkvtyV7p60P+KUcK9yn96AlzAttdd53U
 CYYsxIEhKkb7lpoojAnp9SZxWlzgp/umxh5NkYkMBIYDrRFrpcuZ2I8tTGX2IwA23UnKWdUAnAW
 Z
X-Gm-Gg: ASbGncsa76gN+hfk3ahDzrMq5BSe2v1HMzOggs9x41usdcaUoQ6c4hWGD6cpMZwasA8
 xDmBn1yqlhBIKalFMsr7A86CPTrqd85fEloHUICjl8hLs9k1BuR5c/a4N0tkOV9MMfsiR6jmBDu
 Co+7CdQEVy1i11rvV2CBXhek/AHQ/EamESNPkV6RoTDWeqWP6L4+xpI109s/whgyqaafjsBgteC
 3NbmQJm2BSuXQaJAS+2JE5XuO+x9pKgyde1zOHvsxrknPgZFrt3sfMGZ7W/gJhyqsd+bVUvhb4I
 uoUQrVSpc6lhQImK7Mqw/gELgVxwQjbhzBjtdnQwXoFdi6pi/Nck
X-Google-Smtp-Source: AGHT+IH+8ot0+YPQp3VqTCVWn8DWwGJrDgBz/MeY1fDLVNgcxwj3F1uLY1ojaeXHr93ORaGvCW8D+g==
X-Received: by 2002:a05:6a00:1251:b0:736:4830:68a6 with SMTP id
 d2e1a72fcca58-73b6a9e839cmr3851496b3a.4.1743868256009; 
 Sat, 05 Apr 2025 08:50:56 -0700 (PDT)
Received: from stoup.. ([173.164.107.234]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4851sm5554790b3a.146.2025.04.05.08.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:50:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 0/3] tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
Date: Sat,  5 Apr 2025 08:50:50 -0700
Message-ID: <20250405155054.967307-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Supercedes: 20250404235624.67816-1-philmd@linaro.org
("[PATCH-for-10.1 0/2] tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps::has_precise_smc field")

Amusingly, I was already working on this before Phil posted his patch,
as part of trying to compile tb-maint.c twice.  The major difference
between our two patches is I don't introduce a global variable; I read
from cpu->cc->tcg_ops->precice_smc when needed.


r~


Richard Henderson (3):
  accel/tcg: Add CPUState argument to page_unprotect
  accel/tcg: Add CPUState argument to tb_invalidate_phys_page_unwind
  accel/tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps.precise_smc

 accel/tcg/tb-internal.h        |  3 ++-
 include/accel/tcg/cpu-ops.h    |  6 ++++++
 include/exec/poison.h          |  1 -
 include/user/page-protection.h |  2 +-
 target/i386/cpu.h              |  4 ----
 target/s390x/cpu.h             |  2 --
 accel/tcg/tb-maint.c           | 34 ++++++++++++++--------------------
 accel/tcg/user-exec.c          | 13 ++++++++-----
 linux-user/elfload.c           |  2 +-
 target/i386/tcg/tcg-cpu.c      |  1 +
 target/s390x/cpu.c             |  1 +
 11 files changed, 34 insertions(+), 35 deletions(-)

-- 
2.43.0


