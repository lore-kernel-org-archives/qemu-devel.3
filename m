Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E787AE7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyD-0008Be-E3; Wed, 08 Jan 2025 16:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdy6-0008Af-J8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdy4-0003za-Qf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso2327675e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373118; x=1736977918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8kBIg+Vh2qffo6+mMT7fZG068ZWy4o0/09mnBn8YkQ=;
 b=mf1Gncq4P3nGXMn1EkTM3CxNuKH12auikT5Vfu82OHLVB1yNwLkCGiqdpF7cUeudj7
 5+9aU9Ltygq8xI+kyzNglMbAhhn1VsrxGixOBrKjr1CgorUSDTzjCOQsqnL3GQDj9tpA
 f+vb7I7C8sY6zaUlyXSUrnu9H6guCWfi6F8Wk/00OHO2xn6CHNb4iq5DUVNfSNSG7PoV
 R0n6K/TBloE25x+p+xMdH0YhV+wq+P9pKiiCQkHJx22dgWaYF6QL3pYtDzS+Ln1rVEIJ
 r2M113Ugq9tOnB/Hiws/0lFf4vOrw13tSlHo+WB/0EeMDtJ6RAAm6sI14Lc+4mmSjURU
 x39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373118; x=1736977918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8kBIg+Vh2qffo6+mMT7fZG068ZWy4o0/09mnBn8YkQ=;
 b=xGJxaPZw3UDSihw7C5Z43IBbwqlIDocMs6vCCvReRRWFQDXfL4vJvFlLCngs1HQ1tC
 hntEmKGDaHFgK6m9I5qg07z32TyAGyPxVGufdih6krav67JygZVxeq8Ix4XcANFFvKiN
 CIaljQu1/6RoqXQW9xmTshkQiTYfWNeAqw5lA4R9e6jemvtJy8CIUrFkM6sfCVOQPAmA
 yY1nPxtSky8ZxrjVf9OK7h+czVsB9vVDpLOOXOsSk3wpRtGsDfLSeYEx+9cVxwGi5nxa
 dHDQfgtJR8zq0ukZHcq6IOnPeh/LDu9NLbnATW68YE7CAxGl20vyaLZJkNDOOmDJ1NLS
 uc6A==
X-Gm-Message-State: AOJu0YzpUxhN6e3G4HKqnAMpagBnloch5AtrVV7KRflFMFshj2EKZMxJ
 YGv+HdVRYpNA6nKDahJSyLsA/JE8j/JZ+6PXByUnUF8dY3CqXeXky1BXCRjSSgXTRGQi16kdBw/
 IAus=
X-Gm-Gg: ASbGncujwFYHLGnEAq5NBMEAtD6c45ljw0nJKRDiaHz/2XRpdLhP78VB3hJkFBxbe+U
 31M0DQMBvFeEIznIFPLi6pdtmI+SP3S+at9EChsPurF8MODJik29o2o1ty3NOJHrz21COjr8udr
 I6mTkiXk7ZB86bOrvBJwYWgxVsVxzDicxF0pBPSNaXO6HfXA8H/d+JKcIR6FwF9Ae9Pa3p//K8A
 kZmE7hcdUZP62Puivrn7T5WNGSUUyD5bhEXfwvSDCBCA+/zPWUCPEh/q/8dhtkrHMjX7T93RPdG
 WMDFwcjRPeYauxi7BjxPxZwLTZchwtQ=
X-Google-Smtp-Source: AGHT+IEl+nm4MYKW4/8QVLLmkLdi6YB5sTrNbdstkFLeuYC7seGD6wo7MRp81VrWDgLFjerB1NpDMA==
X-Received: by 2002:a05:6000:156c:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-38a8731007fmr3891689f8f.48.1736373118557; 
 Wed, 08 Jan 2025 13:51:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d01dsm8396f8f.9.2025.01.08.13.51.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:51:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/14] tcg: Split out tcg-target-has.h and tcg-has.h
Date: Wed,  8 Jan 2025 22:51:41 +0100
Message-ID: <20250108215156.8731-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107080112.1175095-19-richard.henderson@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Split of <20250107080112.1175095-19-richard.henderson@linaro.org>
patch in multiple ones simpler to review (in particular
using git-diff --color-moved=dimmed-zebra option).

Richard Henderson (14):
  tcg/ppc: Remove TCGPowerISA enum
  tcg: Extract default TCG_TARGET_HAS_foo definitions to 'tcg-has.h'
  tcg/aarch64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/arm: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/i386: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/loongarch64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/mips: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/ppc: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/riscv: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/s390x: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/sparc64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg/tci: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
  tcg: Include 'tcg-target-has.h' once in 'tcg-has.h'
  tcg: Only include 'tcg-has.h' when necessary

 include/tcg/tcg.h                | 105 -----------------------
 tcg/aarch64/tcg-target-has.h     | 119 ++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.h         | 109 ------------------------
 tcg/arm/tcg-target-has.h         |  85 +++++++++++++++++++
 tcg/arm/tcg-target.h             |  74 ----------------
 tcg/i386/tcg-target-has.h        | 139 +++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.h            | 129 ----------------------------
 tcg/loongarch64/tcg-target-has.h | 113 +++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     | 102 -----------------------
 tcg/mips/tcg-target-has.h        | 122 +++++++++++++++++++++++++++
 tcg/mips/tcg-target.h            | 112 -------------------------
 tcg/ppc/tcg-target-has.h         | 124 +++++++++++++++++++++++++++
 tcg/ppc/tcg-target.h             | 122 ---------------------------
 tcg/riscv/tcg-target-has.h       | 112 +++++++++++++++++++++++++
 tcg/riscv/tcg-target.h           | 102 -----------------------
 tcg/s390x/tcg-target-has.h       | 124 +++++++++++++++++++++++++++
 tcg/s390x/tcg-target.h           | 114 -------------------------
 tcg/sparc64/tcg-target-has.h     |  86 +++++++++++++++++++
 tcg/sparc64/tcg-target.h         |  76 -----------------
 tcg/tcg-has.h                    | 117 ++++++++++++++++++++++++++
 tcg/tci/tcg-target-has.h         |  83 ++++++++++++++++++
 tcg/tci/tcg-target.h             |  75 -----------------
 tcg/optimize.c                   |   1 +
 tcg/tcg-common.c                 |   1 +
 tcg/tcg-op-gvec.c                |   1 +
 tcg/tcg-op-ldst.c                |   2 +-
 tcg/tcg-op-vec.c                 |   1 +
 tcg/tcg-op.c                     |   2 +-
 tcg/tcg.c                        |   1 +
 tcg/tci.c                        |   1 +
 30 files changed, 1232 insertions(+), 1122 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h
 create mode 100644 tcg/arm/tcg-target-has.h
 create mode 100644 tcg/i386/tcg-target-has.h
 create mode 100644 tcg/loongarch64/tcg-target-has.h
 create mode 100644 tcg/mips/tcg-target-has.h
 create mode 100644 tcg/ppc/tcg-target-has.h
 create mode 100644 tcg/riscv/tcg-target-has.h
 create mode 100644 tcg/s390x/tcg-target-has.h
 create mode 100644 tcg/sparc64/tcg-target-has.h
 create mode 100644 tcg/tcg-has.h
 create mode 100644 tcg/tci/tcg-target-has.h

-- 
2.47.1


