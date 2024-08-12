Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E617C531DA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJBJ-0003cg-Q3; Sun, 11 Aug 2024 20:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBH-0003TI-3O
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdJBF-0001eX-4M
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 20:45:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-200aa78d35aso12554535ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723423499; x=1724028299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u47FnAda6gSQy1TJPew4WmYrmGo8lcQrSgewPMLMudI=;
 b=Sp8Ywk/KDsY1h5pR/9eoz6dckkdsfGBG49D34XOhuRz5IhCUzvnix9sKN6RdizKgDK
 RFV4u+ErYulK0rtVp4xLD+q4LCqDnMnRktjmrT7O8b8ZDfbcVqWeMK+U1JRU19RkOlsD
 Eu+gtiNM8glX6Stj9pF9CVDjjuji3PfOgdwdb12CNvKlrOijY0ySLlfaqIw6OQ5hqbkS
 Qam0cegTUmDGYC4O0Vs1+vRiZ6EEYxxb63VgyB4lNQTkRVzUpt5DAeMlfd531UgC+QCU
 xyWGT45NjdJ09fYy7DhLLgDM0nz2n3oI7KWG3wJIyWsNX0nNInApa4CuS86KopCcBlLe
 I6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423499; x=1724028299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u47FnAda6gSQy1TJPew4WmYrmGo8lcQrSgewPMLMudI=;
 b=DySdy5LKzgjUdikcleI/zPObPA8jx+U89bJDiwxsr0rCB9RX7ZPqRHgF+dxLAa4Xw8
 FR5HMDRN4KoEdI7d7f4X4FKrM8YlVnauWCFORW0D9e73tU1lQr+gzIogQRNwoRsSJbXQ
 NujugLCC0FfDm2Bs/fSMIACDKdBFIIAn8H+cGUkHyga1LQGHeod8abJg6cqCibodaJ2c
 QyqQPCz0LD+K4/Fhxp+qL4etbawXx/I14Xu+q05BLlquZkI7r0XSZe4t4RxGHLJD+p/r
 l/e58vRmZEi3Y9ScCODmdB9R6w32umEl5vP+RkD3CrNzNWYrzudPStIG3NpeM+S+TuBK
 LmVg==
X-Gm-Message-State: AOJu0YxHTusfgyISMxyXG39B7xFoo19pfk8eBxvNIuZG4v1+lVtKosQB
 RbDxezxgmIcMxiGmncwFCQf6V6OCyNbcrw51Gh7Go6FQ2YSgICy0C3SLt3Mp1y2JpKBi3RnzIBn
 hn3c=
X-Google-Smtp-Source: AGHT+IEOBwIx/abZVDzRkOS1uWRaWizsCt4iVxR1/v4tLCjwySZaFEz7yDiB8K1jPklhPw6IQsNEQQ==
X-Received: by 2002:a17:903:2a8d:b0:1fb:5e1f:f5e1 with SMTP id
 d9443c01a7336-200ae5975famr56969505ad.26.1723423499232; 
 Sun, 11 Aug 2024 17:44:59 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bbb3b758sm27089435ad.257.2024.08.11.17.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 17:44:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH for-9.2 v2 0/4] target/m68k: Implement fmove.p
Date: Mon, 12 Aug 2024 10:44:47 +1000
Message-ID: <20240812004451.13711-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Implement packed decimal real conversions.

Changes for v2:
  * Generate the complete set of powers of 10 for floatx80.
    This was enough to get 9.9999999999999999e999 properly rounded.


r~


Richard Henderson (4):
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Implement packed decimal real loads
  target/m68k: Implement packed decimal real stores
  tests/tcg/m68k: Add packed decimal tests

 target/m68k/cpu.h                |    2 +
 target/m68k/helper.h             |    3 +
 target/m68k/cpu.c                |    2 +
 target/m68k/fpu_helper.c         |  201 ++
 target/m68k/gen-floatx80-pow10.c |   30 +
 target/m68k/translate.c          |   49 +-
 tests/tcg/m68k/packeddecimal-1.c |   41 +
 tests/tcg/m68k/packeddecimal-2.c |   42 +
 target/m68k/floatx80-pow10.c.inc | 4933 ++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |    4 +-
 10 files changed, 5293 insertions(+), 14 deletions(-)
 create mode 100644 target/m68k/gen-floatx80-pow10.c
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c
 create mode 100644 target/m68k/floatx80-pow10.c.inc

-- 
2.43.0


