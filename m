Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE3DC27C5F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLj-0005nG-OT; Wed, 05 Jun 2024 13:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLi-0005n3-SV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:22:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLg-0003mq-Sz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:22:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c27bc473d9so46755a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608175; x=1718212975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qXHj0iQ2oJBrk1YDnqjMeFBDSIs5C90YwA47GJbDi80=;
 b=DC7HJbq2btlHLNbA3mqlC+3Wm/AVmLDiV5lmUdDPN6k0+vsPpNKcXRmk5iiyphm9kt
 OD2EUY4MQYdiuR67/JCxbkqwW8Nr7BWl7HxyehuwmdIfYRI2z7pT74STlIB3wvgVzGLU
 zbPxCw2sOlXD5csPfekf0ewxFSU848++ta85w0nVynZTOzFz7c010gNRr8eA+mOQZ+0/
 JGWolBa0uepAmGWxF5uuD7QG3jfYZTxRoMdofvLm+1Z+KfIAvrXdlDzMtNqK+vP0NSiT
 CqPhjNV84wa821CJg2pgL6Dz0wmCMoIPnZ3aoHZA19yd0GF9R1ApPRgVYXR5CSREGVMM
 DIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608175; x=1718212975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qXHj0iQ2oJBrk1YDnqjMeFBDSIs5C90YwA47GJbDi80=;
 b=LuJr7PaIcGjL7dCxF1K5wkHxsEtnafwpCQgQtYSwj5Mp367Erzmb5Fjfb/7LhuM1ZY
 FCQj/KHs9VJWBfL2WauQpIMjPB4jX+6skohX82fI1NcjBZybfMNQ5invv3IzfKiWUDam
 Jv3z1nYdMvFsSh2EZgFPAvRvuvIte4im0RPvYZuCFcmmmbbg7Wu0nB6SJGMxUszzKHxz
 SXS/snqI/4aFVia9jXTOVD43ifB3bw+fDVpNsk+7aat/o77GGkq0Utg6TsPH69UVuNNT
 xtQDGT5lkJ+U701dy1D6HU1GTU/tC/bqjit0jy07C2E8sO0OTHMEGkwEQvEuL+xoQrGR
 dyFw==
X-Gm-Message-State: AOJu0YzVa7lD/9Mf1l3L4luV/L30FdxYui/0csx9xuJyPx/7sHPse1vg
 YjzS4+fRTcrp6uBdCq9CeUE2EVx6hucQ2npBOkStYR8/mUEQFon9r99NmrJkL27w44Js58WAunN
 8
X-Google-Smtp-Source: AGHT+IFPe7+DWLhpWFZH0ykS3ms449IstxYRWsXzsqRXH4/UXqnwbb20rFMKCpWZQxe9qveMn3c+cg==
X-Received: by 2002:a17:90b:11cc:b0:2bf:8fbf:e4c7 with SMTP id
 98e67ed59e1d1-2c27db11918mr2937024a91.16.1717608175099; 
 Wed, 05 Jun 2024 10:22:55 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.22.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:22:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] sparc + linux-user patch queue
Date: Wed,  5 Jun 2024 10:22:15 -0700
Message-Id: <20240605172253.356302-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


The following changes since commit d16cab541ab9217977e2a39abf3d79f914146741:

  Merge tag 'hw-misc-accel-20240604' of https://github.com/philmd/qemu into staging (2024-06-04 14:53:05 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-sp-20240605

for you to fetch changes up to b12b72274320ce3ee516d963efd48766163cb240:

  target/sparc: Enable VIS4 feature bit (2024-06-05 09:11:17 -0700)

----------------------------------------------------------------
target/sparc: Implement FMAF, IMA, VIS3 and VIS4 extensions
linux-user: Add ioctl for BLKBSZSET

----------------------------------------------------------------
Michael Vogt (1):
      linux-user: Add ioctl for BLKBSZSET

Richard Henderson (37):
      target/sparc: Fix ARRAY8
      target/sparc: Rewrite gen_edge
      target/sparc: Fix do_dc
      target/sparc: Fix helper_fmul8ulx16
      target/sparc: Perform DFPREG/QFPREG in decodetree
      target/sparc: Remove gen_dest_fpr_D
      target/sparc: Remove cpu_fpr[]
      target/sparc: Use gvec for VIS1 parallel add/sub
      target/sparc: Implement FMAf extension
      target/sparc: Add feature bits for VIS 3
      target/sparc: Implement ADDXC, ADDXCcc
      target/sparc: Implement CMASK instructions
      target/sparc: Implement FCHKSM16
      target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD, FNMUL
      target/sparc: Implement FLCMP
      target/sparc: Implement FMEAN16
      target/sparc: Implement FPADD64, FPSUB64
      target/sparc: Implement FPADDS, FPSUBS
      target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8, FPCMPUGT8
      target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
      target/sparc: Implement LDXEFSR
      target/sparc: Implement LZCNT
      target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs, MOVxTOd
      target/sparc: Implement PDISTN
      target/sparc: Implement UMULXHI
      target/sparc: Implement XMULX
      target/sparc: Enable VIS3 feature bit
      target/sparc: Implement IMA extension
      target/sparc: Add feature bit for VIS4
      target/sparc: Implement FALIGNDATAi
      target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
      target/sparc: Implement VIS4 comparisons
      target/sparc: Implement FPMIN, FPMAX
      target/sparc: Implement SUBXC, SUBXCcc
      target/sparc: Implement MWAIT
      target/sparc: Implement monitor ASIs
      target/sparc: Enable VIS4 feature bit

 linux-user/ioctls.h            |   1 +
 target/sparc/asi.h             |   4 +
 target/sparc/helper.h          |  27 +-
 target/sparc/cpu-feature.h.inc |   4 +
 target/sparc/insns.decode      | 338 +++++++++++----
 linux-user/elfload.c           |   3 +
 target/sparc/cpu.c             |  12 +
 target/sparc/fop_helper.c      | 136 ++++++
 target/sparc/ldst_helper.c     |   4 +
 target/sparc/translate.c       | 942 +++++++++++++++++++++++++++++++++--------
 target/sparc/vis_helper.c      | 392 ++++++++++++++---
 fpu/softfloat-specialize.c.inc |  31 ++
 12 files changed, 1563 insertions(+), 331 deletions(-)

