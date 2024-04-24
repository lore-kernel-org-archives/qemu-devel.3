Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A6C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7P-0001xb-LO; Wed, 24 Apr 2024 13:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7O-0001xD-Ap
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7M-0005Lu-LS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so1220785ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978551; x=1714583351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=I7t1gFcl5wjkEgXtae5fqCcFMtN5cGYEa/oHN0TDXx8=;
 b=dIrB4V2h2ZyXVNH7GGF7HLheOPgMiVSuNihZpgSaV/zTgDyeY54qMZpk+zO7yOe4k5
 chnKTsSn2OAyvphneuLlbMAiNxl4Y+tVpFU3lxqnBiCWGeRJwyyGx9EiRlevhJeXRn+7
 T50/RTVCeQ1JQL+VIHIHvhYzyFjMx1v2szMwtZ7+rxgPB5w2Obgw/tKRqzrZxt78UzRU
 HAWTLFrDwrYBIoDNzmELMyVDnUq9a1Gs2gpHhghYo9bfnmD30RbZM9YOKsSX0zDS6UQV
 eRGWieLg6Rc8jAkZHhUMPMpe8l9D9RTt3DAi6r/5M1drOUb3YcXSdc6bBlzFwIvbSMT3
 Bp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978551; x=1714583351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7t1gFcl5wjkEgXtae5fqCcFMtN5cGYEa/oHN0TDXx8=;
 b=neF83km3mTxRHuIn4i4TUgEl1i0GE3N4Y8CgpZrOcEFFDAUkD1pwGb8Gmuf544+XvY
 Vb1HOhvn0HQBQBQj7j3wpJTohtIfXyTgjFIMtpriIBOadjO7/Bvt1bVY1F9L7Rw9KvBl
 cqnijs6fffEgO2lEJOgSMdOG3ZL2MltvSis6KYSdCSkSA5H0KUHd0TxiwjjHdDB2faxR
 VSj7lBVM6Rijo4Rtl6obazR5ItoNYqSb5m1J1mJF+C3dYxFlzDl+PHd0dutU8nXEQZgH
 Wq7jSakUmfklLPylikC2JtxZz0gDbjm5FoyqjOd8Ic8M9EXoWSHe0+ojP3vQ+CjrH9oe
 /DnQ==
X-Gm-Message-State: AOJu0Yx9S4hiqAnanuIz/10R5Wbt/nbapnWtUouoG//iq7mtQ1bxe66L
 NpA8kramXkRq2fFDH5WMmvPFIl0VjU+q15q6za/8pI6vEGvg2AXHthuEwHlA4HE4pe5lpEBIHnB
 w
X-Google-Smtp-Source: AGHT+IE0cXxa4Jl02Zr5JVRVv2JHoH8BFXpj/NYh26lYMlu2aEU7VzEYPybLHAZkGVvvYOiTuCkN1w==
X-Received: by 2002:a17:902:cf05:b0:1e5:5760:a6c1 with SMTP id
 i5-20020a170902cf0500b001e55760a6c1mr384070plg.21.1713978551009; 
 Wed, 24 Apr 2024 10:09:11 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] tcg: Misc improvements
Date: Wed, 24 Apr 2024 10:09:02 -0700
Message-Id: <20240424170908.759043-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

One patch to allow two output operands from gvec expansion,
to be used by target/arm for updating QC.

One patch to record the result of the generic breakpoint
search so target translators do not need to repeat it.

Three small optimization patches.


r~


Richard Henderson (5):
  tcg: Add write_aofs to GVecGen3i
  tcg/i386: Simplify immediate 8-bit logical vector shifts
  tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
  tcg/optimize: Optimize setcond with zmask
  accel/tcg: Introduce CF_BP_PAGE

 include/exec/translation-block.h |   1 +
 include/tcg/tcg-op-gvec-common.h |   2 +
 accel/tcg/cpu-exec.c             |   2 +-
 tcg/optimize.c                   | 110 +++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c                |  30 ++++++---
 tcg/i386/tcg-target.c.inc        |  78 ++++++++--------------
 6 files changed, 165 insertions(+), 58 deletions(-)

-- 
2.34.1


