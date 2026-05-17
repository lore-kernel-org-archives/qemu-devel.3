Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AFDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKh-0001fr-EY; Sat, 16 May 2026 20:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKP-0001cq-UN
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:25:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKN-0002MC-0m
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:25:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso476320b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977552; x=1779582352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rp5lxwUe/DjaF0YkhYa6qFtUMF5LJkJoMFBAnol4ZDE=;
 b=ebBFzgJ+2Jx8xxUnOJlXhpFFUJkXjf4rtaHF3/N+qiCvqdJ8M8FpzrWJ4AxQAXG1nH
 xYYakq+lTfUK1aeHboOa/XvAxxUfAiZ3IEYxiprsVF3Jty5xCloM3w1MbNXucae0AgC1
 T3S4wqBIXEa50TtKIS6ia2jR/FKbjGKxhXrfgucwyb8IHrKoIYJMkmRKkGfixHEWAyaP
 XFm32HSzmyasxur7tIZMvFjBl1i49H6CBwjcRE8mdwSsGQow20g6ldlcR7iadm25GWxe
 wcnF7yfLmDg6LGK54RnNlM+g9QOyvjiphUD1ifi2yFpO2nX0INb0u7YyU1RFEpDDSfkl
 qsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977552; x=1779582352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rp5lxwUe/DjaF0YkhYa6qFtUMF5LJkJoMFBAnol4ZDE=;
 b=jcV06ICliVPHnL7mgzlZ3NN/QTtw1+CIh1P+4Q7KZ3a21P0yKaHTsnGPMiK3HvmjsM
 ICHgtt3PKeoaZC5ySER+l5e3rqN+/qdDn9DLJn8SxLYRB/Aq5W34Dp844jXX1kKCPdrt
 LxAefQoCXSNQ1S2irC/pOSSrNCVBzdGy4eIMefgpdyESsPKI8Tje8XnnUEO1r4yK4cLS
 dEYtW1+plk6onNSKDGhlDzF5b5/q4Ee/+njRNWlM1clzgh7jsX321A6Ob5UuQ2h5Q20e
 0mWba6NtpJKUq35ExngcxQx/d1bXzaIge3bHjuwfVQhRJV3GaUBNk1cRDuuriW9DtvkS
 kOow==
X-Gm-Message-State: AOJu0Yw+tdB5y9JQuOzv6izUoiVQyaVSQE1tF+CcMz8A2Fo+974TXgk4
 FdkJLUnuVSjXyN56k57NOJS5tXrUDs0GJrhphIAN/bZi3Bt6lpMMwXN147wUkEPaa9nzcv/uHU+
 K9vc0
X-Gm-Gg: Acq92OHzV+nN9rxxKiCy/cQ4sRyaNcNFhSOovpY6eUsBDGv0v/jLcGBiH6HFBJx0v3k
 Lt4/vJzKfe9yQ66Q3pVQqfPbmFKDz4Vcsskb+j6XZZHZ4wFduaDei2S24seOg32KXP3DlCiaq4C
 TfpACF/OzuA712ymP6D/w5RBgNraz6rORwZu6AQmLG2g539rZvKUWs+Vv5bulBDzuvPDi2skhLT
 NeX4Y/gEr67jEVXYX+oDFyt1Ul5io2WQciFhclvfabb0l/Y5p5N7fSb1Zc41QEp41F9IOXyfFnu
 egT83WND+quvY/dDAVFKjSMscf+DtPv3mN2SQqY/4fRsXbxGWJP9gFZOEZhE87qMldLlzoshY4C
 I742HTQDRBwyemtToZexEk+eV1lSwyMix+cR7GIikkCWzq5MJRl9t4Xxo9h2GMk5fxNwKUINmCE
 JZNbQOZ+66dFjQ0wGxC9pcG2wEp4h/
X-Received: by 2002:a05:6a00:138f:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-83f33de542dmr9945145b3a.39.1778977552219; 
 Sat, 16 May 2026 17:25:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:25:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/12] fpu: Export some internals for targets
Date: Sat, 16 May 2026 17:25:37 -0700
Message-ID: <20260517002550.321291-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Fixes for scalbn and muladd.

r~

Richard Henderson (12):
  fpu: Return struct from parts{64,128}_scalbn
  fpu: Reorganize partsN(muladd)
  fpu: Return struct from parts{64,128}_muladd
  fpu: Hoist nan check in partsN_addsub
  fpu: Simplify 0 +/- N case in parts_addsub
  fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
  target/s390x: Move float{32,64}_s390_divide_to_integer
  target/arm: Use FloatParts64 in bfdotadd_ebf
  target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
  target/arm: Use FloatParts64 in f16_dotadd
  fpu: Saturate the exponent in uncanon_normal
  fpu: Introduce exp_scalbn

 include/fpu/softfloat-parts.h |  12 ++
 include/fpu/softfloat.h       |  11 --
 target/arm/tcg/vec_internal.h |  12 +-
 fpu/softfloat.c               | 236 ++++++++--------------------------
 target/arm/tcg/sme_helper.c   | 102 +++++++--------
 target/arm/tcg/vec_helper.c   | 127 +++++++++---------
 target/s390x/tcg/fpu_helper.c | 135 +++++++++++++++++++
 fpu/softfloat-parts.c.inc     | 236 ++++++++++++++++------------------
 8 files changed, 424 insertions(+), 447 deletions(-)

-- 
2.43.0


