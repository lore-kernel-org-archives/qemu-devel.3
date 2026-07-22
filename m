Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8B0C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbsx-0004RS-Qt; Wed, 22 Jul 2026 14:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsi-0004Mg-VQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:28 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsf-0006Mc-Il
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:24 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso9599115a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784745680; x=1785350480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ci30RsoW4mS9/4BClyDGhjGaYIKtBfyn+RMKn46TFnM=;
 b=YKQzfI9x/7QFd2FfTm4a+gRbirxm5naCAQIvYUleSq1GiGC+zrzSApUHhvlhiXE+dp
 gASW3Lu8fFCrpRCJ73rhlr04f/d2QmmYbLzxKrDhRCN94SbyPYt0hBDgKMT4OAkOATEp
 6j2eAYBBKVmEdzNx/1Q4a3YKgwqax3rWv+tDHJDH5CF7qnPBUnD06T3VgdrmvaxMhI/X
 bQLVszk8CUaOMK5apfCzO/ZNkxhJPXBXQz/BK6g7UQ++ynZXCgmVnk6ovk3NBvV0l1OO
 ty8JGIJ9dBQtee2CWqNplaie8FsuK8uU5we27dCJJ8SZM76L42dYoYmjrtD1inMR/+YJ
 kmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745680; x=1785350480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ci30RsoW4mS9/4BClyDGhjGaYIKtBfyn+RMKn46TFnM=;
 b=j+IvKn6AngfwD8y5LOAqXxu3It4actyfPBH5Yt7d1AAhKnAeg3XvBN7Y67Q+La2HVP
 23s5s4D+YWp0aBROcbn+j9Lezinb7KpRts20UMU4kdI+3HPQyzvabTZxVU2ArAR3dgKB
 hkoVmmPtW60EleMvNHWNVXqGnwVBOrC2Cv5s+QpGZ1lAfsN0VTEGsqp4/itbru/vQwdK
 mtLU5l/4szWeE+BALZHyRty5XtpXZVZ/tPPv2343YhrcaMD8mdIxvIt8Qt7SzhCA7aPm
 UKAU/+1HaHcR5rvYZBk55tnu6aMFLXMdskC2VJL8Fd1IGnE19OdaI2nXglos0LOrTb2+
 7pOA==
X-Gm-Message-State: AOJu0Yw6q55YJssCMY1Dz7nn/TSphMTQwuEI1+Sg6QOY/b7jDEJRwdhq
 trNOYv4Jqf1ktRSZ7ZIrmGu+SGk3TuUD2q4LHl5R+ecji4gg/eSTVmVwSkaWrXTpfAHaQXCA5tc
 tT5na
X-Gm-Gg: AR+sD12S1ftpk9BSdTTzEZ2DGqtqbkY5RAaelg1o07uxrIM4EbtDFIqtMFOlN1NWXzu
 hB1zLx9jx1IJV4L80cJgQvWkTxcvnizKef1juv2okIMky9FO2LGVVTewXCxCGnD4O7O5RMv4Zta
 NfWexNM8akd2buCK7Ka/rxNvryuB7/Y9E0jcxB7RGkwY5ts+At6wVmlsnjLxjlb7nH4GNFNJ5p7
 1lrQJ+BUu3Mo2Gjp4PHaFSrgYuhQxR5r/sc1/Y9lzpMHMFms8ASnL6GK1vOMG+eFn6IUr2odviZ
 cKVdijswvGrX0gqesOHWjqBkQQo0jylR2WJWWQccQjS3y6xgvJH26iIJ1Xg5jDDnexsnyPtDEbh
 Qk4TGZD2C9/FHLp23E/YHJuARKBA5gWUWAncxK5uiCmJOOi8whr7XNqjFcM7PSIbD/O1/BP9iZA
 cuUCDAln9XO2CwtWy6yi9ocVXwcOMIbftgLQjWl/cY53GtSiB/zTuVswKSwbMn/g==
X-Received: by 2002:a17:90b:554d:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-38e4b479fb3mr23667127a91.19.1784745679564; 
 Wed, 22 Jul 2026 11:41:19 -0700 (PDT)
Received: from stoup.. (162-198-231-97.lightspeed.wlfrct.sbcglobal.net.
 [162.198.231.97]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13015052sm8559298c88.5.2026.07.22.11.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-11.2 0/3] accel/tcg: Add infrastructure for atomic 64-byte
 load/store
Date: Wed, 22 Jul 2026 11:41:14 -0700
Message-ID: <20260722184117.11937-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Prepare to implement FEAT_LS64 for AArch64 with some tcg infrastructure.

r~

Richard Henderson (3):
  accel/tcg: Add infrastructure for atomic 64-byte load/store
  host/x86_64: Implement atomic64_set with MOVDIR64B
  host/aarch64: Implement atomic64_{read,set} with FEAT_LS64

 host/include/aarch64/host/cpuinfo.h           |  1 +
 host/include/x86_64/host/cpuinfo.h            |  1 +
 include/accel/tcg/cpu-ldst-common.h           |  6 ++++
 include/qemu/atomic512.h                      | 12 +++++++
 include/qemu/cpuid.h                          |  3 ++
 include/qemu/value64.h                        | 21 +++++++++++
 accel/tcg/cputlb.c                            | 30 ++++++++++++++++
 accel/tcg/user-exec.c                         | 33 +++++++++++++++++
 util/cpuinfo-aarch64.c                        | 14 ++++++--
 util/cpuinfo-i386.c                           |  1 +
 accel/tcg/ldst_common.c.inc                   | 31 ++++++++++++++++
 .../include/aarch64/host/atomic512-ldst.h.inc | 36 +++++++++++++++++++
 .../include/generic/host/atomic512-ldst.h.inc | 16 +++++++++
 host/include/x86_64/host/atomic512-ldst.h.inc | 21 +++++++++++
 meson.build                                   |  8 +++++
 15 files changed, 231 insertions(+), 3 deletions(-)
 create mode 100644 include/qemu/atomic512.h
 create mode 100644 include/qemu/value64.h
 create mode 100644 host/include/aarch64/host/atomic512-ldst.h.inc
 create mode 100644 host/include/generic/host/atomic512-ldst.h.inc
 create mode 100644 host/include/x86_64/host/atomic512-ldst.h.inc

-- 
2.43.0


