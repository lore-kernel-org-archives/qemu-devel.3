Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27478D10386
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAI8-0000Ng-Cg; Wed, 26 Nov 2025 02:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAI2-0008R4-Qw
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:15 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAHz-0003MG-GI
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so4212574f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143406; x=1764748206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qNK7II+ob1aAAffPP5gg9nQ3Itex8KQvb/+OIAOBaqQ=;
 b=RbJAG10sudqw77zL75jX4a/6fUF/+mt/m7ztm0q96XN1aXopXbtzknEtshhxLRCNtC
 5O6sTvCr4oSll0rE2+GEs7vDFtDmaIv8aT49WkwKBecCAzJ6kemkYBQVs5OiTg4vEBe2
 7KEqFYJJsBZoB4hYaOwfVUWKa9VjoGTDwz6TOiGempkILex6KxHf9d3QyvSxDCIGsVLm
 TLffg0F8Ztt39vSxmCnDpkId+0ce4MSmX/n21qd4XFZfrqy9KCW5tJpCJ1I6a2l8bU8O
 QVvnOSut0oR7nFfpczvjpMZ9vDBuNetGMC4qFiDf7WOsabIBBrMFT0vvvkSyeWxPiQVE
 RyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143406; x=1764748206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNK7II+ob1aAAffPP5gg9nQ3Itex8KQvb/+OIAOBaqQ=;
 b=ViXyryP9tbVPhoie4aecdVr47zNLJpYi/zUHBoQWak77Dg+jeWhXBZByrxi5erZkM+
 a4n2WH5LoyMcIkbaLXut8H83Df9ZT4bYmt9la466QM0J9X785xGeYwyIC9mvOtmSj4SW
 UJHjKFGwtwqieE9wYef45rVwASVP8DZkkqzLTI5NnuDoQ2aumARtv1BA4OUmDU59dssX
 Bc793M+YIAIs4qPaaKZ9XbdeNynoC87wXfguJCLCJ+WX9aM8iI14snMUfkcXfuZGJpNQ
 M7d10MJQDw6TM5arZARLVsasnwO45kcg881Mz15k/Fy9D3P5175ptrFupg2GesigI2V9
 MDYw==
X-Gm-Message-State: AOJu0YxsyucB9bOvU9SVqGQzow4qHuUHLD2ppL/+ZhshkZujzXQrVQih
 8BrwYlm6WmrRgRFP9XV945vGgs4Py2vTc25L+awo8DsdndByYLyDAkyI5QywvTcFEVPot4U23Yv
 OGQVz2CK36U2T
X-Gm-Gg: ASbGncsxa/0fmydnn0+Nuu4DL+2AxS5v+OFSsa8uHy+iDlsP8jFmOztl/MAAwVa5Wbt
 +PwSADGRn4C/RA0vw0MxCMzo9TYX2eZyPFpPAzWpp8KJtFlaUg1sHsBMN5tOeDFtBno4tWxR85U
 9bcn5pTtDwoYZ+IkfChWhgHajwh7WGrh2ZCiTCqqfeK3E5KeMsuQQR7wkTqr+X5vFuq/wSGnrx/
 n/QRrwiNUWT6Qap49TOKX9d6bu9p435BOpdBOu6RK6xe3NhvKgZmXrgLLF3MvPW11mEORASNl99
 OVyeUJHb28+X2YQ7v+yCjmravySXYx6ih4LVvLSxCpHIRyqE2ARpyj2RPhLaJf1rabWrquyvKB9
 nQGuYSjdmGhRxGufOvHHEGrCrTSeRUarlbsOsO+I6Z3M0F9q+o3T9nLSWUTqP2h783YKqYTSsRk
 7Yf5aT6SYIkSAbX14CCFs0ENIPDk+opODrDE6fV/ojxE0oVzCI+broIhw/eK/V
X-Google-Smtp-Source: AGHT+IGTpHekWxMMN5uwaFczo3mIeZsr16LulI5B5OjaGhkohE5hbwzooesEPj01O+nr8egTmKuPtA==
X-Received: by 2002:a5d:588c:0:b0:42b:3131:5438 with SMTP id
 ffacd0b85a97d-42cc1d22f29mr21399485f8f.54.1764143405673; 
 Tue, 25 Nov 2025 23:50:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa7affsm38955316f8f.23.2025.11.25.23.50.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:50:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 v2 00/12] accel/tcg: Remove most MO_TE uses in
 cpu_ld/st_data()
Date: Wed, 26 Nov 2025 08:49:51 +0100
Message-ID: <20251126075003.4826-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- Fixed s/little/big/ typo (thuth)

Still trying to remove MO_TE uses, here looking at cpu_ld/st_data()
in fixed-endianness targets.

Series split of bigger one [*] where Richard made a comment on
*_code() patches. Since not related to *_data() uses, post separetely
since almost ready (still few PPC/MIPS paths to update, but I'd rather
check if this is heading in the correct direction before looking at
them).

[*] https://lore.kernel.org/qemu-devel/20251121134503.30914-1-philmd@linaro.org/

Philippe Mathieu-Daudé (12):
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  target/hppa: Use little-endian variant of cpu_ld/st_data*()
  target/i386: Use little-endian variant of cpu_ld/st_data*()
  target/riscv: Use little-endian variant of cpu_ld/st_data*() for
    vector
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/m68k: Use big-endian variant of cpu_ld/st_data*()
  target/s390x: Use big-endian variant of cpu_ld/st_data*()
  target/sparc: Use big-endian variant of cpu_ld/st_data*()
  target/sh4: Replace cpu_stl_data() by explicit endianness variants
  target/mips: Use big-endian variant of cpu_ld/st_data*() for MSA
    opcode
  accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers

 include/accel/tcg/cpu-ldst.h         |  46 --------
 target/hexagon/macros.h              |   6 +-
 target/i386/ops_sse.h                |  12 +--
 target/i386/tcg/seg_helper.h         |  12 +--
 linux-user/vm86.c                    |   4 +-
 target/hexagon/op_helper.c           |   6 +-
 target/hppa/op_helper.c              |  44 ++++----
 target/i386/tcg/mem_helper.c         |   8 +-
 target/i386/tcg/mpx_helper.c         |  28 ++---
 target/i386/tcg/seg_helper.c         |  16 +--
 target/i386/tcg/system/excp_helper.c |   8 +-
 target/i386/tcg/system/svm_helper.c  |  69 ++++++------
 target/m68k/fpu_helper.c             |  12 +--
 target/m68k/op_helper.c              |  91 ++++++++--------
 target/mips/tcg/msa_helper.c         |  51 +++++----
 target/riscv/vector_helper.c         |  12 +--
 target/rx/helper.c                   |  14 +--
 target/rx/op_helper.c                |   6 +-
 target/s390x/tcg/mem_helper.c        |  48 ++++-----
 target/s390x/tcg/vec_helper.c        |   8 +-
 target/sh4/op_helper.c               |   6 +-
 target/sparc/ldst_helper.c           |   6 +-
 target/tricore/op_helper.c           | 152 +++++++++++++--------------
 23 files changed, 319 insertions(+), 346 deletions(-)

-- 
2.51.0


