Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AEFC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJX-0000Xy-D3; Mon, 23 Jun 2025 21:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJV-0000XO-0r
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJT-0005mx-Cg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-748da522e79so2464854b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727941; x=1751332741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xzDjZ2r02zX9OTr9OsE6Q0OPD/WGvdhKMjZd6icrakE=;
 b=XTtNxbumvC0A0re6whzQLFEGoOsXUXMVDwGiIwEwNiCzvYikFLIdxfaACklcv6UQBc
 oLTawSXAvJQkoahOGfGxKBYAyS+Rtn+nOyhS1mXVB1Po6EiJghdXXAhXfozj/umNqhhg
 KrLnUKZ/wAE8XUm6yyjPdxlr/c9/G6uHwOZEHII3sJLSRPYf4Taxb+Ub58QLItxUI5xK
 MbRQX+FyBoqVw46UywRImWMjGR8Q4OCCa04epk3B+cNDNV3/3e4e1/CLHgTS0hVEHaxZ
 2OzmsPUIyCxtqI1oRDauM3723Tuqgb91JRiyg6YrKKGQRFcDzapMIKWc3iAouPYteRot
 e5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727941; x=1751332741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzDjZ2r02zX9OTr9OsE6Q0OPD/WGvdhKMjZd6icrakE=;
 b=kEilC/S7R5FVcp4MZs8OoSQPE86Rqh5pMq6HSIqNwCxmylXZeTfsgHuw62BBwetbve
 TAPNT2+zAbiUQHSE67I4+MlDjPfh7YAiitf7qfbO8oeEfeL0eVf8kwXAETH5iv2TpC3Q
 y6zgrOiIbxK2hC86lwYdZVvC6mJgIduJkJ+qoigkSTMK0RcV20QmYjCus4MyC/eKZcEF
 SUBV9HRWyQaRcYlcQYzo+MXa4UmXU5Gf4KGm/fvquEpU0RUkWMQ+t03kHke1W2a//B/r
 c7UkGs0DenEDsZrULS5Po/LwSdeR9GpK7EnzDoM8938w/j3V1Jqg9/OjTIGcFQ0WMVfX
 E3hA==
X-Gm-Message-State: AOJu0YwloTVQFnq7yzugUj336U94R7xODee+he1NOEZZiEKpgu05lPRA
 HyxqVsRQk44Xwu6I/rbg/AV/VPY2xV4LpSpwNzpRUxufctY5sqjYbv+R8DCAPp6u1pjzhZPnIhX
 30p3b8lQ=
X-Gm-Gg: ASbGncu/zqS5s2aAl/oF4l+2ilgPIfeS8D71oE6yg/olTf5r9gJf9l27lmw+4sNnI+o
 JEM4J9gRRk+k/Gpyk/+j314yQJhAWV7jp2De3/2Ac+pwwfo4X8xQ7cJcM7uY0E2DDZl+bDY/mbs
 dmggaaNA0q5lQwoKgU9HR6wWEusjq4rzwbVLqjy340gMniqPLt6NwkeTIEsjugnHtmTs0LzwY/+
 +cxVtma4+rgR2lQsKuhU5XPIxlN2qnOyqHe4k7ysks1kvaB+OmDssQav8vhy9vjuyvEsxvEYGZk
 oT9ZeE6GqbitgHo9D3LqRxCsqDYNa64NCnxFc+a3/rgFIghRgLExMBMnEN8heSzMiCHYMLHEFSX
 wFaVI2Go2E8b5mg4x18VeE1aJgZdb5E4=
X-Google-Smtp-Source: AGHT+IHootsU4rErk2dsWyz3gHyi02NIZrRFdAG4vpF3H6mHaQ5qHm+8Gh3e7W+tmi399tWXMCPu1Q==
X-Received: by 2002:a05:6a21:108c:b0:220:6cf3:eef0 with SMTP id
 adf61e73a8af0-2206cf44281mr1254654637.37.1750727940626; 
 Mon, 23 Jun 2025 18:19:00 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] tcg patch queue
Date: Mon, 23 Jun 2025 18:18:48 -0700
Message-ID: <20250624011859.112010-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

The following changes since commit 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-06-21 10:00:46 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250623

for you to fetch changes up to 5171b794d4ac47efd81ef4da54137131e4ea550d:

  linux-user: fix resource leaks in gen-vdso (2025-06-23 11:46:33 -0700)

----------------------------------------------------------------
linux-user: fix resource leaks in gen-vdso
tcg: Add ptr+ofs alternatives to some gvec functions

----------------------------------------------------------------
Daniel P. Berrangé (1):
      linux-user: fix resource leaks in gen-vdso

Richard Henderson (10):
      tcg: Add dbase argument to do_dup_store
      tcg: Add dbase argument to do_dup
      tcg: Add dbase argument to expand_clr
      tcg: Add base arguments to check_overlap_[234]
      tcg: Split out tcg_gen_gvec_2_var
      tcg: Split out tcg_gen_gvec_3_var
      tcg: Split out tcg_gen_gvec_mov_var
      tcg: Split out tcg_gen_gvec_{add,sub}_var
      tcg: Split out tcg_gen_gvec_dup_imm_var
      linux-user/aarch64: Update hwcap bits from 6.14

 include/tcg/tcg-op-gvec-common.h |  63 ++++++-
 linux-user/elfload.c             |  75 +++++++-
 linux-user/gen-vdso.c            |  27 +--
 tcg/tcg-op-gvec.c                | 380 ++++++++++++++++++++++++---------------
 4 files changed, 383 insertions(+), 162 deletions(-)

