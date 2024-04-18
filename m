Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5A2C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUKg-0000jk-Ba; Thu, 18 Apr 2024 12:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKf-0000jV-2c
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:09:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxUKd-0006WL-1y
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:09:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-418a02562b3so8304905e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713456586; x=1714061386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=93hTUdpdVQVz2mwhRuR30HtwAJmbmwEUW0z1fU9NWLE=;
 b=c+z0uM8e9IC1HZJYkImTkryyNVqBnwLe9dyM6v35Jk0SvpRcky0/cdb9a+oUIJXLXo
 WFnZMYxoCq3BCPJnJdkuSWYKvuz7KjMMrjAdWqxV8dvvX+iiNebKs1MyxrXB9+V7Z5VO
 MeotOmkuNT8aBUAKMVY04iqJZAwBICwpGqwWBp21TcmdIxdahRPTfyqQA+66dDGzGzse
 W9fW4n8rMMcx+UsaH3PDzAUmGWPGS2DbmSKs6v/WtYpC1i0awjYsJxkJZy2d/KMsk9Ej
 ka+QGy/qjMAM+sSEQYbbbLVPj8M7qSR9tBtDOSn+ExfCBcR7G/05XeemO/3Aapd6iDjw
 Cp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713456586; x=1714061386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=93hTUdpdVQVz2mwhRuR30HtwAJmbmwEUW0z1fU9NWLE=;
 b=BJxQcRdqMF0dGF2JGRtXx/MbXZROYmY03nHKFRzrXDhfRGAS6EPYZeiyIM/ZSjm12d
 ylLeksOiErmvA3fNzGO0uCiv3SN0qXGbAOr9MB63eS/NheLDVkjtsxW2zdhzCGXLEyK3
 ak/vftWrLNyB2fFek0vw5L2ky9txW/SN48ErZktu/FxobjXhfp2k+LJ5FvwhwPdkbe+X
 RV53qpDjB7+Q11ghWpoVAt+dgB32ph5hsZezw2Od1ZpUha0aV0ir1KHbz3wBykpda9bI
 4Ej9r0DonVeSYSNFYbUetFG8blzFnH1bHOg3Ynrnhq3/I3i7sdywQyzDPC3gRq0lFLPo
 l+mA==
X-Gm-Message-State: AOJu0YwNYjSYoYGFJ6E8zrJK9UgUW6cMoV58HJ9bUJslDQUTDe/1pgmN
 mmLALD5E8bdImt/dy/ipreofeEvfrx0IQXm3gDnJWLk2XFFKXGRd0JhPox9RTo8z2gHP4pJhwCd
 t
X-Google-Smtp-Source: AGHT+IEG/bFvqOODWpVwK2MENVO6DgQgYo0mEPwdC9DCeoEMQGOc08gZMzy3vx/dhUqbkBDfhbERWw==
X-Received: by 2002:a05:600c:444a:b0:418:49ad:6fd3 with SMTP id
 v10-20020a05600c444a00b0041849ad6fd3mr2226857wmn.19.1713456586220; 
 Thu, 18 Apr 2024 09:09:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a05600c3b1900b0041816c3049csm3138163wms.11.2024.04.18.09.09.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 09:09:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] include: Rename some expanded headers using '.h.inc'
 suffix
Date: Thu, 18 Apr 2024 18:09:41 +0200
Message-ID: <20240418160943.95047-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Per our Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Rename elf_ops.h and host/load-extract/store-insert headers.

Philippe Mathieu-Daudé (2):
  hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
  accel/tcg: Rename load-extract/store-insert headers using .h.inc
    suffix

 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 .../host/{store-insert-al16.h => store-insert-al16.h.inc}     | 0
 .../{load-extract-al16-al8.h => load-extract-al16-al8.h.inc}  | 0
 include/hw/{elf_ops.h => elf_ops.h.inc}                       | 0
 bsd-user/elfload.c                                            | 2 +-
 hw/core/loader.c                                              | 4 ++--
 linux-user/elfload.c                                          | 2 +-
 accel/tcg/ldst_atomicity.c.inc                                | 4 ++--
 12 files changed, 6 insertions(+), 6 deletions(-)
 rename host/include/aarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/aarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/generic/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/generic/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/loongarch64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename host/include/loongarch64/host/{store-insert-al16.h => store-insert-al16.h.inc} (100%)
 rename host/include/x86_64/host/{load-extract-al16-al8.h => load-extract-al16-al8.h.inc} (100%)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)

-- 
2.41.0


