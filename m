Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2655C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G5z-0005Bp-MX; Wed, 15 May 2024 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5z-0005Bh-0R
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5w-00075T-Vo
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41fe54cb0e3so43355985e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785142; x=1716389942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ty7BmC8B8GeFcYZSk01dT7MdrNLqF8VJeahlXLQms/o=;
 b=bOrHcBEOpkJPYXRagNH7SvQuuDVIb6RvZ0XVsYzNxF1ENpYLBSv70aJ2YQ4hNsKmmD
 cGm7beBpWB8HsL4PmO315nIQf8ILehzdKuUu5MkGadCjcbPtTD2t2nynJeT22RoEApcU
 /eZmJe6KXP+YGG/FRGsZ0ZBRYgZuOqVNqkMZljDXaU8NXYT04k3gA7s1llWNW7EJzhTp
 7h0iRatggPMZu4/VkuftwwHgyZ7wNsh6resskSDlOl7byfhXANPmwgedMQPjeifzXQUp
 XL8F8ARMcTp/VV1kG/HeUAJ+NCRbr51rHvRz6cloaRTkUhOLnNHdoyv2Yi37hQmqStmo
 zHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785142; x=1716389942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ty7BmC8B8GeFcYZSk01dT7MdrNLqF8VJeahlXLQms/o=;
 b=JlrneZqHJDz9GwoT2Yc/PbNN6+5kKN7Q57Ks0GjmK5uEMyVyTQ5zkJn7y0nRjav05M
 /Hr2enGi4g7v4atM/UjcaQAQOmfBOvogsnfiWRhhcmQjWKKZqVgaWs7sPL+IN26L+vdA
 fPsZ7uv/i4vgW+ZP3WO0JBu5GCNCuFwSHC8Wg9+9Y2JXTeF4DEOKzIXW0vrKiIvmC5jc
 sndkmXeMx6WPDAMMYBW27H/UQjFvUc/p4Nk2oiM8o0BWNpf2FVm8GQ/fX18qWkfsswjZ
 y2sXI6CMR6c4IH7tKf6eCXwQHkzGd54dqLlyJ3M47AaFp1JxqU1FWLZNH++fTwWbcvSr
 pejQ==
X-Gm-Message-State: AOJu0Yz1kJXAhr95GPtz/j69YsC6trXc6BYGjfX4Nb3g82MgBdtEcK2V
 PO3MZX47rhv5OTRSMY8t+7Y3lzbCrNh2TJV0uRg6CW3vdPHRfgRWxH0LVlT30gmyG8xHvnOjx+f
 NEUg=
X-Google-Smtp-Source: AGHT+IEcozDJIvRdkH2wcTtsO2IQvBG0LS3Y9U7/TUrSmr4I7lIvXaqHnZL+DVMQJ2rsr0lm+pTXXw==
X-Received: by 2002:a05:600c:190c:b0:41f:e10f:889a with SMTP id
 5b1f17b1804b1-41fea93a0d7mr106339995e9.7.1715785141759; 
 Wed, 15 May 2024 07:59:01 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/5] tcg: Support TCG_COND_TST* for vectors
Date: Wed, 15 May 2024 16:58:55 +0200
Message-Id: <20240515145900.252870-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

It would be weird if some TCG_COND_* codes are supported
in only restricted cases.  Let's go ahead and fill this out.

Based-on: 20240506010403.6204-1-richard.henderson@linaro.org
("[PATCH 00/57] target/arm: Convert a64 advsimd to decodetree (part 1)")

I will inject the target/arm patch as 45.5 in the above,
and route the rest through tcg-next.


r~


Richard Henderson (4):
  tcg: Introduce TCG_TARGET_HAS_tst_vec
  tcg: Expand TCG_COND_TST* if not TCG_TARGET_HAS_tst_vec
  tcg/aarch64: Support TCG_TARGET_HAS_tst_vec
  tcg/arm: Support TCG_TARGET_HAS_tst_vec
  target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec

 include/tcg/tcg.h            |  1 +
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/arm/tcg-target.h         |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/loongarch64/tcg-target.h |  1 +
 tcg/ppc/tcg-target.h         |  1 +
 tcg/s390x/tcg-target.h       |  1 +
 tcg/tcg-op-vec.c             | 18 ++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc | 26 ++++++++++++++++++++++++--
 tcg/arm/tcg-target.c.inc     | 23 ++++++++++++++++++++---
 10 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.34.1


