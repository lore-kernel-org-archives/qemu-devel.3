Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B364CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIpn-0003oW-EY; Thu, 18 Jun 2026 15:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIpj-0003oD-DD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIph-0007qW-V5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c6c101aeafso9598495ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812524; x=1782417324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=r7KNlyAoZLpyuzPmObPYHAJKgz/QLoc4iVktUervBh0=;
 b=d2YjzTIO/KoeUZsw5iCOXptGodUc8NKq0Euq46ImA6+fMne0ue/qts/XV8mIOI2iO+
 lkna6ELWNJ44Z4BXFc4dybZVbi5+GIbX/R0bUg7g0v7YP4LvWA4keVzVoxnHMU+fsl80
 Q93twA6cFH6ji0Fi5nNFZkhjmGTKArd8L85ohnjbZQX/3bSHJgtH8IC0//02Gdd8pWXW
 nKsSdktCSEUKapUeOCX18Z3T0QfDsdInLbZJ4F5L0LR6u3JDToFUekp2hQocl2zZm+og
 a3nho0ERReIyA4zw9KFrGUiZgKyyACc4VRBn/PCEQ3dlQtUKbTYFW80iogWEFYFVIB/h
 X6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812524; x=1782417324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7KNlyAoZLpyuzPmObPYHAJKgz/QLoc4iVktUervBh0=;
 b=J+gBGj2t/drQp3h3zaaLIE8cAawzc+Qc4GgRecX6W8xFzzpLp783trfG3f+DbaCz9u
 3s5Q5xcB1UnCeUFs7t1LmLNvBg4gYaKgPMwlDLBZiGY8qc4zHulqE1qCiM0dvugYbaAO
 HmfCZrbsyQLo3jti5ijiFUdt9BKXoEsbrgS2qiQWSB+OTOneG8Fc2y3cMN3lxwP/v1xl
 LWqd6o+7l/+ml5awgSfr9TxQtwE3EVRKfFMLfhLGjbUxWkyXZ7yOVGnMs/CcY8p0MrCF
 0yZmRnIm8vl680UQgpKObaM8K1hA4J1uBJKd/+poTUHOkqpWW6+FD5lsI/MfpTRi/wDr
 cuvQ==
X-Gm-Message-State: AOJu0YwsWyRww7Rf6XiuukouY4p7neHQGOZigkjVKIZnd8sBnv/whFwx
 jopOMLOeXAb0ISzTRMqyq+g291rLyW2aF4U+7uXY8r54iw2troQhYnTjZVNtpnOs+Bas5h2LmkI
 vROBh
X-Gm-Gg: AfdE7ckrARP4qdQhxlX2fmyMYMl9k7UvyB0RlJn7Mt50KHRDMROiz4GVCZBkKBPMVb7
 TXD48/qVSMc1s3uEDBdmVO9ZOwFMOviAL4MLt2171FnsuYNRs+DljJJo+sq++6IUqdP55V38RM2
 DhuiGzwrn1mBjJwoHBCiU/o5tto3BCFWtaFLC5HNd379kiYr3jBKlxDySFbhhWPxnzwa+VU88N/
 6XytII6VtA20eOxsHXsrki0PC1j8M69RSLtLwxRZ2N+tBRhLlfU+tSfhTlcJ+p3nNhxMapLd1oE
 njX15hRpYzdVv0CVwumEQlFWDJtLkWSQOgaS1EUARNNC/8r8GkchDqZe5+6yaP4fS/XsEtCxkvX
 cXtzgu6oU4Y0mLrTotovTVg4CLCuq1tyB4gk43Jfy8HxSARrRmEufmq7dRrq8ju3bTb3owqOLAe
 B8fDhgQScFty8rnyOZi8JVTbo2Fj9rhvHNUWSQNj/PSJ1dlRY6Wg==
X-Received: by 2002:a17:903:248:b0:2c2:50c7:58ab with SMTP id
 d9443c01a7336-2c718fe57d8mr6476365ad.23.1781812524138; 
 Thu, 18 Jun 2026 12:55:24 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/13] *-user: probe_guest_base improvments
Date: Thu, 18 Jun 2026 12:55:06 -0700
Message-ID: <20260618195520.589907-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Changes for v3:
  - Actually include the read_self_maps rewrite from Warner.
    For v2 I failed to push the updated patch from the freebsd vm.  :-(
    I've also expanded a TODO comment wrt the balance of MapInfo.


r~


Richard Henderson (13):
  linux-user: Introduce PGBRange
  linux-user: Use PGBRange in load_elf_image
  linux-user: Drop hiaddr out-of-range check in probe_guest_base
  linux-user: Pass image_range to probe_guest_base
  linux-user: Use PGBRange for commpage
  common-user: Move mmap_min_addr from linux-user
  common-user: Initialize mmap_min_addr for FreeBSD
  include/user/guest-host: Include missing cpu.h
  common-user: Move selfmap from util
  common-user: Implement read_self_maps for FreeBSD
  common-user: Move probe_guest_base from linux-user
  bsd-user: Use probe_guest_base
  common-user: Move guest_base, have_guest_base to probe-guest-base.c

 include/user/guest-host.h        |   1 +
 include/user/mmap-min-addr.h     |  12 +
 include/user/probe-guest-base.h  |  37 +++
 include/{qemu => user}/selfmap.h |   0
 linux-user/arm/target_elf.h      |   2 +-
 linux-user/hppa/target_elf.h     |   2 +-
 linux-user/user-internals.h      |  17 +-
 bsd-user/elfload.c               |  37 +--
 bsd-user/main.c                  |  42 +---
 common-user/mmap-min-addr.c      |  50 ++++
 common-user/probe-guest-base.c   | 347 +++++++++++++++++++++++++++
 {util => common-user}/selfmap.c  |  45 +++-
 linux-user/arm/elfload.c         |   2 +-
 linux-user/elfload.c             | 400 ++-----------------------------
 linux-user/flatload.c            |   3 +-
 linux-user/hppa/elfload.c        |   4 +-
 linux-user/main.c                |  35 +--
 linux-user/mmap.c                |   1 +
 linux-user/syscall.c             |   2 +-
 common-user/meson.build          |   8 +
 util/meson.build                 |   4 -
 21 files changed, 565 insertions(+), 486 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 include/user/probe-guest-base.h
 rename include/{qemu => user}/selfmap.h (100%)
 create mode 100644 common-user/mmap-min-addr.c
 create mode 100644 common-user/probe-guest-base.c
 rename {util => common-user}/selfmap.c (69%)

-- 
2.43.0


