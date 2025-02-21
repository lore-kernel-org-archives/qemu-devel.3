Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613FCC021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 19:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYPV-0006Ht-KB; Fri, 21 Feb 2025 14:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPT-0006GQ-Mh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPR-00044l-KO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439a1e8ba83so23969945e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740164999; x=1740769799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9+rzFkAvq1fT8VWgYWTbYKbxozjg166B260cDEJsA2M=;
 b=vlyDM0fX++eZN7A76pAEBnCVdTWLarrZHG6RnVAGtnRZ2nFqlSlZlclS4CMRbEi8ww
 yx4QOH1rKDxEAOI5dz8F6ht8nWSb8YTomBun2YWg+uqsLDABHw4OReOsWAu0jWDUKAZ3
 1Yxir2d73mYd085+lkgCTlJWJyVPvM5wgI6NfXFUpLFvIpb9UxQkrJ92RjREwOGU2R6l
 lX2U3DnlcDMQzO2Wsn20a41DQ0Lxm6WrVlQ9ViuNDqlIjTJp09YD9IANyxtu9CqbhdDW
 eu1jzZMsc5t41fFdtOABRYnFR1rhYKWsVvmq3KzneixKMyCDBtSJ+qOT1srhXovsGeTg
 j8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740164999; x=1740769799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+rzFkAvq1fT8VWgYWTbYKbxozjg166B260cDEJsA2M=;
 b=m5iKisJkLm8qb6G8Ph1r3A9ACbHH8sdD8ol3mZQTmhN9dpzGrHPwENTdizO4mcILQD
 Il7G271P5wCLkKEzDdVB6gojRU1B3JiMYpQdETa9XBh9tTotRPYC49LLme7ovdNcpixU
 yx0pmuOJlkPIPXTsKj4ozEUwhagKje/P3lk9w4/ouL+tFFSuksCNooMJj/EU331U3e5f
 srtQ/n2KH4QWGsSZEL5J+DQNLdoX/+LkJm15MgmV+h3LvR6LFgx64DFieI6DDUWw+nOn
 TWCHXESIgu0A+mfJ4J302mDCiqQKSL0DMmq5LkTDYBg3hXuBBH1Nx7BZgxY8alK0V08g
 RqFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7hpVAjj9kBbqmIDu5iq+H8tQtrvgMQoQu/uEeAADcxF+QnJanu7PQEmSmUwazTzGm2+IMXknDg4nc@nongnu.org
X-Gm-Message-State: AOJu0YwB5BdoSdiMwg/ywsVae+4qitwLwwaEpqyL7msCwYOVIBZSno3Z
 xeQE0qd/EtVDOr9p6ZSbsI0pISOsgXtLZTJ/XAv56kROY/tEWoxRIiexSBEDNEw=
X-Gm-Gg: ASbGnctb9ApeFc5Mg6f/iJo8rOFobxhUApudBjds+cPXy1ru6GQa+Nmoxf2SrmJ+yoH
 V+yLN3xa8JZtFl4TE899hsLYKquatlUZVcepy3UBgBx1Ork0YV/HGk1tGvZNZ87KLq4tlkwEbV5
 vPT4bLiC4zVnJWl7nHE3k/XPus8UxP+v9xeyq14Tg8594ReyQvOJbn5yO/zneb7FFPoPDiCYXTP
 Z89TUwlfJGKKODtVlFe5dNuwVvzv/1naUEo7z8lVjPtsNVEFZ2cnIJ2IzjSaDyRnJUDvdHXTSEI
 Fc9HSrxO370nL1ZQM00mxyNZprPK6SPQ
X-Google-Smtp-Source: AGHT+IHEo3lQxi+8bnPYA3+ZyWZiA2sLXSCRLKEsA2TU9WhNuY5JbOtHhFQORDSqf6MeCAb73mNaSg==
X-Received: by 2002:a05:600c:450d:b0:439:9a43:dd62 with SMTP id
 5b1f17b1804b1-439aebb2d6fmr28356035e9.24.1740164999153; 
 Fri, 21 Feb 2025 11:09:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm24392478f8f.39.2025.02.21.11.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 11:09:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: Move vfp_helper.c TCG code into tcg/ subdir
Date: Fri, 21 Feb 2025 19:09:52 +0000
Message-ID: <20250221190957.811948-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

target/arm/vfp_helper.c is almost entirely TCG-specific code,
guarded by #ifdef CONFIG_TCG. The only parts that aren't
TCG-specific are the handling of the FPSCR/FPSR/FPCR registers.
(I noticed this while I was working on the FEAT_AFP code, and
it felt a bit awkward but I left it as-is at the time.)

This series moves all the TCG code into tcg/vfp_helper.c.
Once only the FPSCR etc code is left, we rename the old
file to vfp_fpscr.c.

Series structure:
 * move the easy stuff as copy-n-paste to create new file
 * move the FPSCR get/set helpers
 * move the softfloat-specific parts of FPSR/FPCR handling
 * rename

This was just a quick last-thing-Friday tidyup, so I'm not
strongly attached to it if people don't think it's worth the
churn. I do think at least the first patch or some variant
on it is worth doing, though.

thanks
-- PMM

Peter Maydell (4):
  target/arm: Move TCG-only VFP code into tcg/ subdir
  target/arm: Move FPSCR get/set helpers to tcg/vfp_helper.c
  target/arm: Move softfloat specific FPCR/FPSR handling to tcg/
  target/arm: Rename vfp_helper.c to vfp_fpscr.c

 target/arm/internals.h            |   9 ++
 target/arm/tcg-stubs.c            |  22 ++++
 target/arm/{ => tcg}/vfp_helper.c | 189 +++---------------------------
 target/arm/vfp_fpscr.c            | 155 ++++++++++++++++++++++++
 target/arm/meson.build            |   2 +-
 target/arm/tcg/meson.build        |   1 +
 6 files changed, 205 insertions(+), 173 deletions(-)
 rename target/arm/{ => tcg}/vfp_helper.c (90%)
 create mode 100644 target/arm/vfp_fpscr.c

-- 
2.43.0


