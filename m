Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2BBC2BB9A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJExw-0005Dq-Hd; Mon, 17 Jun 2024 12:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExs-0005D5-Mm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJExp-00089K-PV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:12:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f44b594deeso42160635ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718640731; x=1719245531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AJmbNQ3qV9DlrSTGH9JXiRNJJ32pUUItmIHzCusvT+k=;
 b=tM0E0V0Xs/UCqhHCqk77d+bbn/3tkPqNMsae55YlV8xMFw3oedElIaC0Kbabt5pJfT
 TscrukT3bc7S+Rt+JcKaqM0tN9DA+dGSKLbaJ2O71+dZCaRVabWUQe7mjXHnFx7Of34x
 v3VMGTijuvMucDELWvU9gnSoQOWxlN+u+ARWFsffjdR+iwfqA86KRVDQh8CKzmYGAM1x
 U7dTnlxgH8qc1DCQBqVlR1pxLO3RD4XKPF9chyvjg85H6bGZQ/n1j1reM1uktoUKsF7g
 W3Gxyfv1QC8voIiomy9S4B6X2J4aCY4GBdAfn2gx+dINeKSuOUo0XpcA7bsP9cKIr/wy
 cc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718640731; x=1719245531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJmbNQ3qV9DlrSTGH9JXiRNJJ32pUUItmIHzCusvT+k=;
 b=FRWbdQVF7VaIqd4UkUl9ROuYr1FjWAe7fpLeKc4k2VUO8VfFRQdw+b2idKgYLu7BJn
 iA+n2NPvKBiZZfVSCkm647Nlt2Ubjx3NIKy/GD0BjhfJKZWJHPbs0ooRZNuCeuYp93mO
 cMxikg09UbJLliMVvKFlEvc7/tE5sXFG6bwQwGQNKZ+T8XKKlSsO2W7h+BWZ+aLnBh+2
 +lRJO58QQoaVqz422GQoU7cfQGos3I9L94J9iV6cvviiArsB6fJu4Mc3vd5r/XgYVncM
 Omhjr4ZrmG+BaU8M/yQfDCeunsOZ1GvuaM7E2YtwdNqOBUgFLik5hLdcRUB/FoekOa7P
 ecMw==
X-Gm-Message-State: AOJu0YzfE8wsz3+OQLt+vCVVX2SiweEK8rkObwQ8dezjs6ZTGHx1mvOY
 bM557syiGov6IPho46f4nkrNwmQ1QbCBslaDf1XAeAt8vYuZ5af9nniegvTjD1bJhR47C5cE97F
 D
X-Google-Smtp-Source: AGHT+IF7SKIbvBiO7hTA01Gky0mPhxyfr42iVuSrXZtDXsv7N9tJRr+jzUp7zrlFkKw5zp2RQeomfw==
X-Received: by 2002:a17:902:e546:b0:1f8:3b7c:dff6 with SMTP id
 d9443c01a7336-1f862a0ab3bmr110236305ad.65.1718640731521; 
 Mon, 17 Jun 2024 09:12:11 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee8317sm80829285ad.145.2024.06.17.09.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 09:12:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [RFC PATCH 0/3] target/i386: Reorg push/pop within seg_helper.c
Date: Mon, 17 Jun 2024 09:12:07 -0700
Message-Id: <20240617161210.4639-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Paolo,

Thanks for offering to do the work to fix the memory access issues
identified by Robert.

Here is a code dump from this weekend that I noodled with -- it is
prep work only, not intending to change any semantics, but it may
be helpful in finishing the work.

I considered adding a MemOp member to the structure, which would
allow the push/pop subroutine to choose the correct access width,
which would allow the callers to stop having 3 nearly identical
code paths.  But I didn't quite get that far, and I don't yet
know if that would really work out wrt long-mode.

Anyway, please you what you like, or not.


r~


Richard Henderson (3):
  target/i386: Introduce x86_mmu_index_{kernel_,}pl
  target/i386: Remove SEG_ADDL
  target/i386: Reorg push/pop within seg_helper.c

 target/i386/cpu.h            |  12 +-
 target/i386/cpu.c            |  27 +-
 target/i386/tcg/seg_helper.c | 469 +++++++++++++++++++----------------
 3 files changed, 280 insertions(+), 228 deletions(-)

-- 
2.34.1


