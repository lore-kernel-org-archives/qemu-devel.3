Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7695C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 11:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu8SW-0003Ck-Fq; Mon, 17 Mar 2025 07:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu8SQ-0003Bl-Tl
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:16:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tu8SO-0003k4-RM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:16:34 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3018f827c9bso852624a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742210190; x=1742814990;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8AjyUr5UV/1dn4diFISWJ3OhQI00qD4NOFwWowWJJZA=;
 b=iASZ8L7AG0otoZ6vyJG5Y8am31zKpyXs9wR29Lztknjy7Y21kKTSnSkmQCjK8eqtFK
 bxWr0RRAm4knmU3MbUI3ns38UExOkMmLbbn7HSjdOcN+shJxXnGvxdUPp9J8fuyD1InU
 w24YzzucsghWOnuxZqs33RfB9JUrBBWARhpMznW+kYhceDk5a+FqV7M8ecLuuTkzt5za
 RUzUL+Obw7EAUgLh77SyHfo/dEBIIoIJ4t0Jne6zyB2shtsxLEL1JUGOwe8qwMN1vFE2
 DouHasfSTvMrSK5eC4XQ4zQ/6TdcSS17MQ/kk3qQIdsuF5D05c5wiSJrpNDGyHVq+7TO
 4s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742210190; x=1742814990;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AjyUr5UV/1dn4diFISWJ3OhQI00qD4NOFwWowWJJZA=;
 b=Phhf3qUmH+47vio5SrQa4A+9IZp9OAaTwxbv/7vNbhCRV403h+rHoMGPopJoVqmjU0
 sB2hrUgfdrfeh8VJCCNwX3nKVoWiE5CZO5oBnygU94quMbJsEvQoTCLBOAi45XNmHkbX
 uETBmYjq++6uqEm5i5tmrsBk3SGpkq1ugoLdxh6xyA5PHxnMbyddyDTt88m2GlLPV6Qt
 aBGDm05T85Vr4nG0Fqc7uZ1To7lRlaoDJtG0E6aikhHsdU5S4IEVRIIyo8UzhtEwpnK3
 eQg1MqTT7mL/vflk3WvwebgyNws6qKjJzEJWiQkrRwEUPsqJwXLlh9BFvFuPrxXKNy8o
 XybQ==
X-Gm-Message-State: AOJu0YxdOHAG3YChMnlQ85Yi9yhaifsFWMZkX0aXYCF2UwWeOYoTz86r
 4TcMj08PRJf64Z2avRLULGjWXV2DPRQinpIZYSA6ZR/FOELd7RMBHKr+V9YU42o=
X-Gm-Gg: ASbGncvWuehGdrWHVlCm5nw6hgaVPDB5MhnSVPICP2Y/QMPwTcC37TaPKRcbTwUIeWu
 vcDAAjBFPjCnjP2yBV+EJeRVD+RCJgxat74LuKVthw8oqu5U5ZoMcIQob0JhKdVtX0DPhREz+ek
 FkH7yKH/xGe3J6wgJhkeN9+AEbzdc5mKAN44HaBUMCvlYWtMl/pCa8P9AVCkt1on7kmFsNz1Uf7
 SwKBftj2PHECn8Uf7nZd7zYY9fU4hx3XojCjuWIDoEBz5Pt4Szjfx/7WE+sE/MvZw5WTi4eSMrn
 6VDLKj48A5Yu9iyW2n+TFDhbf6LzoREZJVaXkEipXxoAcBp0
X-Google-Smtp-Source: AGHT+IH0RMqb3vxfVdnD6L7GKMQ8Yd/x0C0pnGEDIXjcJVT4R6ZXnqJCMrIbfP2mDwajJeJcUN/ZaQ==
X-Received: by 2002:a17:90b:1113:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-30151cef70emr12805613a91.21.1742210190578; 
 Mon, 17 Mar 2025 04:16:30 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c68883b8sm72589135ad.15.2025.03.17.04.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 04:16:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW
Date: Mon, 17 Mar 2025 20:16:21 +0900
Message-Id: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIUE2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3aLEcl1DSwsLC9M0M/Mkc2MloMqCotS0zAqwKdGxtbUATdU/NlU
 AAAA=
X-Change-ID: 20250314-raw-198885f67b73
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Supersedes: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
("[PATCH v2] target/arm: Define raw write for PMU CLR registers")

A normal write to PMCNTENCLR clears written bits so it is not
appropriate for writing a raw value. This kind of situation is usually
handled by setting a raw write function, but flag the register with
ARM_CP_NO_RAW instead to workaround a problem with KVM.

KVM also has the same problem with PMINTENSET so add a comment to
note that. This register is already flagged with ARM_CP_NO_RAW.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      target/arm: Explicitly set ARM_CP_NO_GDB
      target/arm: Do not imply ARM_CP_NO_GDB
      target/arm: Expose PMINTENCLR to GDB
      target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW

 target/arm/cpregs.h        |   8 +-
 hw/intc/arm_gicv3_cpuif.c  | 100 +++++++++---------
 hw/intc/arm_gicv3_kvm.c    |   2 +-
 target/arm/debug_helper.c  |   2 +-
 target/arm/gdbstub.c       |   2 +-
 target/arm/helper.c        | 229 +++++++++++++++++++++++-----------------
 target/arm/tcg/tlb-insns.c | 256 +++++++++++++++++++++++++--------------------
 7 files changed, 336 insertions(+), 263 deletions(-)
---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250314-raw-198885f67b73

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


