Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13502C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 01:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbsBM-0000iN-0S; Wed, 07 Aug 2024 21:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBK-0000hn-7z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbsBI-00082W-Cg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 21:43:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so4927935ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723081386; x=1723686186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PPmca8GZOh2DRlKRsEt2B1Y76Ks/t/nrpX+Hn8Stafk=;
 b=QrRDrzWJyBiJ6j168gxosxhDfB4crRmF74WQilAiITkLOkwBxcDprF/IsrYTgphFnE
 dkCfszMUURqGa0H0ulYlCLWKUEOi+TYJU8DeDD+jK2t85ASanoYBONiWQpub4bKtnROR
 WENzY1Zy2PPI4o38H0eVFWhikTNY9SEEW5mIC7b4UkgtIq4beTUSD38lqeRyauX+Q5lg
 eaxQrlWgNfv1QYcRf2F+BJVibaPV87wBl5QXSfKS24Yb6qSyBdIJIHqOkpw6Rhd65WI8
 slKK/Jab/ZtNZ6/+EEgzt0PYkLZ8U5JWGtlytGxjc71ee0ux5XXj8oMpzOnVcNLm8A82
 VbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723081386; x=1723686186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPmca8GZOh2DRlKRsEt2B1Y76Ks/t/nrpX+Hn8Stafk=;
 b=F9KEgR4zfTdYxjLRt0bKW1CTqZ49JpwhlTHdMAprrThAD2TsDecdFsJrDOI/YFokww
 bed30XY9hoUa23WVEojKQvknKVRDoW1ViTVkjpDNzKtwrNkOGyMSJ7gj+NgrA3p5fsKA
 Czd0zf9b0w1kQRYb231W0Pw1ZABIsdt1mp0QmIuJgDOUa8BKy8tniWUvdJjTJCwmJDG6
 T3/z2al3eclfS89Vb3hJ9S3sgTwCfuY1OkD+XHyCsYUU3cUQ6AfBXgnRbIUUdwQwWAM3
 MsICdwQAhBOu/lp1vBRXAA8nqRkNRtamGunM+SxW5HSA3io3Zf/eaC6Lb6mb7EEJ8pDB
 vdRw==
X-Gm-Message-State: AOJu0YzdaO35mH+k65t6OiHVFikMQb0K9yDy3kszfQ/tm/g2G8JgQ4hO
 hB9pzXSj1SZeqLIl/J2ac9A1hNtUhoDzZwkvm9CYeY/niIxuMgOql9gF2o4a5F+PRP3yHTGrSUk
 MB9I=
X-Google-Smtp-Source: AGHT+IEx+xzRXLlEM9oIwBUGXP/mzjveIkwjD75SwcxLbq6EEVoRp+zwKa2pl1u3133WO3urywXGVw==
X-Received: by 2002:a17:903:2287:b0:1fd:6677:69b4 with SMTP id
 d9443c01a7336-200952bf93dmr5919535ad.49.1723081386355; 
 Wed, 07 Aug 2024 18:43:06 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929abd1sm112724035ad.271.2024.08.07.18.43.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:43:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] tcg patch queue
Date: Thu,  8 Aug 2024 11:42:59 +1000
Message-ID: <20240808014300.65269-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The following changes since commit 6d00c6f982562222adbd0613966285792125abe5:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2024-08-07 07:09:37 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240808

for you to fetch changes up to 682a05280504d2fab32e16096b58d7ea068435c2:

  tcg/ppc: Sync tcg_out_test and constraints (2024-08-08 09:03:35 +1000)

----------------------------------------------------------------
tcg/ppc: Sync tcg_out_test and constraints

----------------------------------------------------------------
Richard Henderson (1):
      tcg/ppc: Sync tcg_out_test and constraints

 tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

