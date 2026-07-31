Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7784C55171
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppyK-0004m3-SN; Fri, 31 Jul 2026 12:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyJ-0004id-KS
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyH-0000Qs-1a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so603644f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785514827; x=1786119627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XIE9UjjwFGhZGjJOFIEL3lpvQZnJ8c0ha5NWbAPzVxI=;
 b=kYr23a7w3Gm5LHsUShssXCwI8ItvgaCFEkQ+tvlrJz8wp7ElTyD/exoX4xP2WRrnQF
 3ZtziR2ARTQ/j+eCyPpb82cOaDJX03grN9+hxWuN6x9XCnlysh/6boTVo90nBe4APiJt
 ES4D1oxV7cR3C8XnJHZ1ZhqMKqRFI8pkgB8SZUdfG6Mc/JY43Ta8QKpcZ5SDQ0z/cBWF
 Cx7IlzCf/ZZuZWXNSlZTtGS9Z2om2k54a6c3WK8B4rLyLR5Dd5RXbaoAxUzZ/fCUhCsu
 6ZHbDsPr/K9ojMfi9dzB118sT4nf4c0Cw2tQJAzSj6kPpprLvR9j5BvuDSvwpGyvdlWX
 YXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514827; x=1786119627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XIE9UjjwFGhZGjJOFIEL3lpvQZnJ8c0ha5NWbAPzVxI=;
 b=mmGnLfpRNkqX3yyVmuNiv9wkDfhY90C4St4p06jM9qYEzH3/SeJpQycKn3Guq7YKyD
 HadDYvhjm2W4zd5iawf6jjZehvSgtsFzKWpPXkGr4tkBoi6jzwKiw6jDNkLhD4RKMd7I
 MPZcQ8jFHyVb97SEUHtBBv2FvCsevvAtTuMclIeagR3rI+HOhN4PhPQ759EInYsr8zQG
 Yuo9hBGNIlc3DfIQJTrp8IqPT9Aswg/HYIgUY55B2EjkZ4y0JpyX/7IuetIMCQ6DoJSd
 DwmGT3eRcvcfbY9adg0k+LLIcoxF7mTsR2VAX5keRyBGPujI2OChtjYup54THYGxrf6O
 aLzw==
X-Gm-Message-State: AOJu0YwPD6gvSyG7iNMDX93+7uyUrtqr4DgUU7GwvuEOA/hLK3A6yJ3p
 /GKwAoujt2yUeEdBRIS7k1OBZLogsZmF71/pxoqtlxGALWTaHOb+QMUjRUO6IcKVxrbDJmre9q0
 8XQWe
X-Gm-Gg: AR+sD13tCHIloqoXEnCzwOyS5Y3EdJZNPS7utsNnlCB631yFjp4DF+/N5XkECVYVFH/
 lyJsUttMLaiRpvAnqDa6kuiVANvnDuNALN4pl80s/c4nkBiTvHnuTUMy1Ug39RhcmgogZ3PdDts
 JWejlG7LdSnh00sCxugmASOWGWpvj9dQ/AWNpmxT0LZYaEmipAuzB+V06ezgQG9bdTyxWrKqIY6
 ckK88mmiM+3JBV0mWt90BXKvdwEMFhSXGKaPfCEwVA2Nyy7N+I+oAI6hwKUOAGw+ksiqZIj6UGL
 vJ8LjPI+e+btsUVRoTrsvTG07X8guYapeWLRZu7DwnciCytotCexGwaND9AOyBBhd8TcGs73gsk
 ZjQrSaAms54HfC32J8B8fKGTxZ3Htb+zouBQTEXH02K9WQNmQTXCJePd/mjnhcZJH1FAt4EAgfO
 4WbFoOpjy5JixijTYKchqTouMbQqw04GUjGG9/I7U/Ze34JmPq1JfYd4drGuYtub3WoNW6Z6uWE
 lpMntgZn/vgpsffvDJWcG5ssuU/tPlLwnUkmAXOMmjkZKD2CQGJsIOmQCCd8j5D9MjbVQ==
X-Received: by 2002:a5d:5f51:0:b0:475:f0f0:9ec8 with SMTP id
 ffacd0b85a97d-47fd7328eb4mr508024f8f.51.1785514826601; 
 Fri, 31 Jul 2026 09:20:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm6328593f8f.34.2026.07.31.09.20.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:20:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Fri, 31 Jul 2026 17:20:20 +0100
Message-ID: <20260731162024.3097467-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Hi; this is what I hope will be the last arm pullreq for 11.1.
This has four patches, which are all bugfixes of the form
"we didn't check the right CPU feature flag for some instruction".
The SEV/WFE ones are the most important, as they fix a
regression since 11.0.

thanks
-- PMM

The following changes since commit 0345ef676befc1a180d2f63bceaf3fca1d07ee88:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-07-30 10:52:26 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260731

for you to fetch changes up to c490037c1349f503d7986391b24db47362a204eb:

  target/arm: Remove stale comment about WFE/SEV implementation (2026-07-31 11:24:27 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN
 * target/arm: Fix feature tests for AArch32 SEV, WFI, WFE, YIELD

----------------------------------------------------------------
Peter Maydell (3):
      target/arm: Don't NOP the SEV insn on v6K CPUs
      target/arm: Make YIELD, WFI and WFE be NOPs on pre-v6K
      target/arm: Remove stale comment about WFE/SEV implementation

Richard Henderson (1):
      target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN

 target/arm/cpu.h               |  1 -
 target/arm/tcg/translate-sme.c |  6 +++---
 target/arm/tcg/translate.c     | 48 +++++++++++++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 16 deletions(-)

