Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C9C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRZ-0000O0-CE; Mon, 30 Jun 2025 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0000MZ-PR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRJ-0008Bd-1G
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:05 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c47631b4cso1665830a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297337; x=1751902137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XL/mdNizZIwOu4mSHKySJ3dwzcYFR6qVTSZAyGpfXsE=;
 b=KDQ1YuPc5ZHahVLbYB4JTWoZfqKBuJ7RdLSAvGm97BZCjIEJHJ6UoISNb01MIlF+c+
 l7wK9IfmNgS98HofyiV29JRMh5/MzxEvLIo/bMIHUwx2M7dgmAfh8FoAm0JqYIRfEfv1
 f5/gjJSh3hp2C3NBZcZSzs2xxhezb8YbI0FVeo8ifjEBYIaeP3d9vIv3AGM7W4lvhMCh
 kS4/BVz+xGpS/UvU1RmfSs8UOmKSroxYq0gpv8MVBU8qEWG+L2jL8k83HvjYWermE9ZU
 PypC2tX2oGigVgQxOMbgWEfBFyD2T6kp6+2yqz6ojFsJ1QwtfwzPnlq6ku1FvN0AGxXv
 usBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297337; x=1751902137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XL/mdNizZIwOu4mSHKySJ3dwzcYFR6qVTSZAyGpfXsE=;
 b=Z2sm6inhD12bscGe54xAjYvYuYy1znvFGnUuCt2TkX98P16Dec/H4UKKftkuIhg7eC
 eBmpD7f4CEnKCEs6tcr8jL/XAGlzjIhn2iTcK9PhDGr1N1cEFYrSdGE4TIbrU4pqYUyh
 VLkR8f+NK8M1dVldtFujZCCQ8Z3vngJVqvOYK5K4ZIizTldFdTKgNslbblfJuGRMbBEM
 y7wiqch/oDEQcFk33KSLrq6mf1SJvaW3/8t9MiZ6L1v48EC0h7l43UHQ69AmCZuDRlvZ
 4AJvcyy0200k5RgM0kisE2Cgi4ePjQYLoBxVOPLuQ9OO7ESgKMIEz0vm9I7pv2eSdgB2
 yIBw==
X-Gm-Message-State: AOJu0Ywlkd9n48DP8RgkxgKE5rVUZUX2Kg7Tu11v/2OwDGNeadJqMNOt
 aYauq4i4s8/rb7+D9k5SMt9Pd6U1R4saUD8+aZGFtdFQTRj98yD4+XlEoDH/6TUuVObx3+WeE59
 yOlkL
X-Gm-Gg: ASbGnctPRqJnm6QFqitjVvOGNViBYOEUsm+5NHoL/rH6vMYcFVrCfm5wNnIGBdQUhpR
 ak7ZdTr6ezQ6lPXoBJaCdIpcGsgvGDPqD6uDqqBqvDYNsNZS+7G330TlR/Ey5g/ZkqKl/LUTzSQ
 y4Uo/ncwzoPwkqlNAOnfvCjFBb+vmRTCbYLVzi91F4iUTxieTNOWnGfX4LjJgYB1PPj6WSNcwGp
 6+hZUow/yR5m7hUd6Q7dGTCcw4Hh6CUZN3rxXYZUqbUiXd/RApbrX0FEdVtQPR4i370CVj/P7hC
 ixSWtBXP0Gu2j8nR1ut40MH2jbEDvdBqPZlGfGilICaYFAQ5+ygosNFwehtrQNTCxVT1KQ==
X-Google-Smtp-Source: AGHT+IGtyeUd5zQ8x9zMOhoX4kqXbXNo/aQM/EJ1ohgAQj1FhvN524N/0NvZZa6QvlN/8oka9+QJaQ==
X-Received: by 2002:a05:6830:6381:b0:73a:8a8a:5157 with SMTP id
 46e09a7af769-73afc5afc41mr9139100a34.19.1751297337136; 
 Mon, 30 Jun 2025 08:28:57 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:28:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] tcg patch queue
Date: Mon, 30 Jun 2025 09:28:26 -0600
Message-ID: <20250630152855.148018-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

The following changes since commit aec6836c73403cffa56b9a4c5556451ee16071fe:

  Merge tag 'pull-vfio-20250626' of https://github.com/legoater/qemu into staging (2025-06-26 10:25:01 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250630

for you to fetch changes up to 0d0fc3f4658937fb81fcc16a89738e83bd8d4795:

  tcg: Fix constant propagation in tcg_reg_alloc_dup (2025-06-30 07:42:56 -0600)

----------------------------------------------------------------
tcg/optimize: Build and use one's mask in logical operations
tcg/optimize: Use fold_and in do_constant_folding_cond[12]
tcg/optimize: Fold and to extract during optimize
tcg/optimize: Simplify some fold constant checks
tcg/riscv: Fix typo in tgen_extract
tcg: Fix constant propagation in tcg_reg_alloc_dup

----------------------------------------------------------------
Richard Henderson (29):
      tcg/optimize: Introduce arg_const_val
      tcg/optimize: Add one's mask to TempOptInfo
      tcg/optimize: Introduce fold_masks_zosa
      tcg/optimize: Build and use o_bits in fold_and
      tcg/optimize: Build and use o_bits in fold_andc
      tcg/optimize: Build and use z_bits and o_bits in fold_eqv
      tcg/optimize: Build and use z_bits and o_bits in fold_nand
      tcg/optimize: Build and use z_bits and o_bits in fold_nor
      tcg/optimize: Build and use z_bits and o_bits in fold_not
      tcg/optimize: Build and use one and affected bits in fold_or
      tcg/optimize: Build and use zero, one and affected bits in fold_orc
      tcg/optimize: Build and use o_bits in fold_xor
      tcg/optimize: Build and use o_bits in fold_bswap
      tcg/optimize: Build and use o_bits in fold_deposit
      tcg/optimize: Build and use o_bits in fold_extract
      tcg/optimize: Build and use z_bits and o_bits in fold_extract2
      tcg/optimize: Build and use o_bits in fold_exts
      tcg/optimize: Build and use o_bits in fold_extu
      tcg/optimize: Build and use o_bits in fold_movcond
      tcg/optimize: Build and use o_bits in fold_sextract
      tcg/optimize: Build and use o_bits in fold_shift
      tcg/optimize: Use fold_and in do_constant_folding_cond[12]
      tcg/optimize: Fold and to extract during optimize
      tcg/optimize: Simplify fold_and constant checks
      tcg/optimize: Simplify fold_andc constant checks
      tcg/optimize: Simplify fold_orc constant checks
      tcg/optimize: Simplify fold_eqv constant checks
      tcg/riscv: Fix typo in tgen_extract
      tcg: Fix constant propagation in tcg_reg_alloc_dup

 tcg/optimize.c             | 456 +++++++++++++++++++++++++++------------------
 tcg/tcg.c                  |   2 +-
 tcg/riscv/tcg-target.c.inc |   2 +-
 3 files changed, 276 insertions(+), 184 deletions(-)

