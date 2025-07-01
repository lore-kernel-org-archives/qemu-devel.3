Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF16C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYI8-0004SM-0W; Tue, 01 Jul 2025 06:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYHy-0004Nf-Lf; Tue, 01 Jul 2025 06:32:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYHq-0002Co-Vq; Tue, 01 Jul 2025 06:32:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so3668539b3a.0; 
 Tue, 01 Jul 2025 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365942; x=1751970742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QoIVN/xkFbmjb8YH/F1wK8KcMj+smYpegVeMJ4/WZ7I=;
 b=PaMZNgdGDlNj71EQxMWEAn5g5diE4awEvHswNvr3PhQsDPQ4jyxxTqV110X86K3Jol
 gQNUB6ovKHZhfAypd0kUPHG6QJ7qfV63NmT06ZJ6rAIroltxvQvPe+HuILoxVH/VlXtz
 urC+GxapvZ0w7o02/EMP8fsinEFKjZWh468iY6UWDVcDarjHdOOTlDwc9HTsfviGNxUF
 FaC6/A9s8TH0/bmI/gKLOEG2sAvMQgorOYssu/usX8Vruc2/E0q0rUse06Sska7zBH09
 n0bkR4NZlreMLD5DubjZ+7sMqK1kMPHalPhGZC7qQWHA6MEW669Cn+d+nhqqK70NT7KC
 RL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365942; x=1751970742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QoIVN/xkFbmjb8YH/F1wK8KcMj+smYpegVeMJ4/WZ7I=;
 b=LKQ7nXKbmFvdkyh2JzmctNTenvtZNYSVcKoGSxOG2hi6bC56E5hyvxURYgicx2oWdP
 nWn67Ajn2/2AnCdD2dLsUn7J5USHyM0jeQW1eY6GFAZki74MOv7V7GOLZOIZ1/Wi5H3t
 KfLY+6wN4yuhIgDV2pW5D1912HnfkXLLlCT90Yg+pDrk0P/LB7pjvPyECyW+/hwM63wf
 8hafTsG5//YlYTR3i6xGo4vLXBSBpy5+vOssFREcsFmNA4kwhISTC1EBrpg/96KHgyzp
 inQ2WqWV8E8j/48zzdQhGjuoiRJQt7rpJ3l/LFsZyGfFGkhA87lE0tkU9sfrrx6s7Xbc
 OKXQ==
X-Gm-Message-State: AOJu0YzyzE5UhAu7wF8ffpNTd8BSlN74INCnpn0oAHTQgOMhGVl3nXRK
 GQaxtFUeJ+dQ5G5GzQ31OpKD5gbV5MJ9EpGU1UdJg1qJl4yxyf+DfYkJX8X/gZyjb9o=
X-Gm-Gg: ASbGnctq0QekLll8BCkZRgRH93LHlyRyx3NPrJ6E2azOh54F+4VmxwQevrH+CO6o+es
 9KUkSW+LWDZXBYTCaYIJ4sdNbsdb6mpI8NWDRY5U28blQc2xuvKuqNepwH0aCp2ktVcnkemBluI
 2CvFtbclZWtdzOI43nCffds8EBAcOmW36LIImVvZwD7TwBo/tqDQQ7Pdas6JrGm0JK5DiFSiYrU
 XOMYVWKLGCzrJiyk1QHXkr6lNRXZfyktcuTb9r59vsMOhMYIOkUc4pPvufCAJkDtYt/LLkgxHhi
 jvnmiJknIduHuH4tf5BPYQ44wlewtnL28CrMQSTK/uwnBjUwlpFit4NJewOt+eOJHyAFTM8dkiG
 BZhGuYL0rBIZSpf9RD97VlCekqhnWn/ZRUzvASHapiUM=
X-Google-Smtp-Source: AGHT+IEYS+Yk8faDatvALe2vF/sWnKDycmFjJ9vGnfmsTpHyf9fWyrn0H+SlLwXAsKSutJs2Nwk0mA==
X-Received: by 2002:a05:6a00:23d1:b0:748:3385:a4a with SMTP id
 d2e1a72fcca58-74af70ab3a2mr24873194b3a.23.1751365942271; 
 Tue, 01 Jul 2025 03:32:22 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af541beb1sm11652955b3a.51.2025.07.01.03.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:32:21 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 00/12] target/arm: Fix M-profile helper loads/stores
 alignment checks
Date: Tue,  1 Jul 2025 20:01:47 +0930
Message-ID: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Historically, M-profile helper functions in m_helper.c and mve_helper.c
used the unaligned cpu_*_data_ra() routines to perform guest memory
accesses. This meant we had no way to enforce alignment constraints
when executing helper-based loads/stores. With the addition of the
cpu_*_mmu() APIs, we can now combine the current MMU state with MO_ALIGN
flags to build a MemOpIdx that enforces alignment at the helper level.

This patch series:
- Replaces all calls to cpu_ld*_data_ra(), cpu_st*_data_ra()
  in the M-profile helpers (m_helper.c) and the MVE helpers
  (mve_helper.c) with their cpu_*_mmu() equivalents.
- Leaves SME and SVE helper code untouched, as those extensions
  support unaligned accesses by design.

With this change, all M-profile and MVE helper-based loads and stores
will now correctly honor their alignment requirements.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>

William Kosasih (12):
  target/arm: Fix VLSTM/VLLDM helper load/store alignment checks
  target/arm: Fix BLXNS helper store alignment checks
  target/arm: Fix function_return helper load alignment checks
  target/arm: Fix VLDR helper load alignment checks
  target/arm: Fix VSTR helper store alignment checks
  target/arm: Fix VLDR_SG helper load alignment checks
  target/arm: Fix VSTR_SG helper store alignment checks
  target/arm: Fix VLD4 helper load alignment checks
  target/arm: Fix VLD2 helper load alignment checks
  target/arm: Fix VST4 helper store alignment checks
  target/arm: Fix VST2 helper store alignment checks
  target/arm: Fix helper macros indentation in mve_helper.c

 target/arm/tcg/m_helper.c   |  33 +--
 target/arm/tcg/mve_helper.c | 408 ++++++++++++++++++++----------------
 2 files changed, 254 insertions(+), 187 deletions(-)

-- 
2.48.1


