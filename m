Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA8BC52D7B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 06:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd1fs-0001fQ-Se; Sun, 11 Aug 2024 02:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1fr-0001ew-KF
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1fp-0003Je-ON
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:27 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db14930a1aso2587634b6e.3
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723356204; x=1723961004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aMh7SrBzyjxfpO4dy9t8zpG2hXG3X/1bwLNhnQIwrfo=;
 b=HDxv9Sbz521XAq62dKyrWC9OMoAqnQhI7K6Oi2qyGNOHSuY2fLxi1K2P9ZyWENl12K
 A41+c8+Ip7hh8gWg1lemCeWUYrlCE0duH/7X3C/9aZMv4EVa1QsCUfW22wJImbzx76v6
 xFqKIiwMGuhgWDvVWjsGVJT7o3FtEqBeDK1unHBD4lwEa81TsLKC7QP/ZSnYh53byzbr
 7J5DYLtJ9zaLLBLdLn5kN2XGkPavKjchF7f40keOPzfj3i62yxzhXQg03y4vZGa9B2B1
 NJVEpmooWPb4Pltv2DkDjg5f20BLVkPf6469nBwTPUEridUOKZSsCNamv/cjHZHnufnc
 GGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723356204; x=1723961004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aMh7SrBzyjxfpO4dy9t8zpG2hXG3X/1bwLNhnQIwrfo=;
 b=BsJhK8GxVHb5SzBgZrn3pUEmxvkCUEIj7qLxSPK6xb31t08xYrsjp42VPJ7hsKL7hk
 /sPadWm+Ak5DkDj5prMsjNiARIQGH41tsNZglu9cbXkb2Je8VE90pWj6y3Qtd/pR/asJ
 WNkQ3a0NEerUDEFX1qAVWB/lYpRm9HzcuCnxXLsy0fC3qsPu7KVnukoIwqgOU/r4POqK
 TQCrdzUA5ywgbOAFX3scw4bOvfWCWijI/I3SgUI+XIr6/FPTx1S9ayub0ZrNwfPQ6a88
 XX2fl0RpVuH6HSEPX9Uiqpmdn4u5/N8zlExDAEA5M1jDQHP3a7RnmYHYqmrCbBfHm8Rj
 ZZQQ==
X-Gm-Message-State: AOJu0Yz6YjMdHuxBEvYnr2lGwu4Tn7u2GkNWxchaHtZdjUp+dV/UbSTa
 JF9qGk+bhvf82xYZRUApe5eJed9yT1iG3eMRRhhykU3wdmkzSZyq71TyroRbO8POg2Ca8fRo9q2
 X18ECfQ==
X-Google-Smtp-Source: AGHT+IGCrAGWu/yjznEEPQ8PtMfp+Zz+DPv2Y8v4j51R76fxfNw9/9Fvy/V1/qF8YcKdW1ZvdGOg3g==
X-Received: by 2002:a05:6808:f92:b0:3dc:15b9:3319 with SMTP id
 5614622812f47-3dc417149d6mr7059573b6e.51.1723356203766; 
 Sat, 10 Aug 2024 23:03:23 -0700 (PDT)
Received: from stoup.. ([172.58.106.160]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060b5388sm835591b6e.43.2024.08.10.23.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 23:03:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH for-9.2 0/4] target/m68k: Implement fmove.p
Date: Sun, 11 Aug 2024 16:03:09 +1000
Message-ID: <20240811060313.730410-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Implement packed decimal real conversions.

This is perhaps too trivial, as it does not produce correctly rounded
results compared to the compiler.  I'm not sure how else to implement
this without using gmp, which seems a bit heavy-weight.

Perhaps we could do better with a compile-time table of powers of 10,
rather that the pile of runtime roundings that I use in this patch set.
If the host libc supports float128, we could probably leverage scanf
to produce properly rounded results, but that ignores other hosts.


r~


Richard Henderson (4):
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Implement packed decimal real loads
  target/m68k: Implement packed decimal real stores
  tests/tcg/m68k: Add packed decimal tests

 target/m68k/cpu.h                |   2 +
 target/m68k/helper.h             |   3 +
 target/m68k/cpu.c                |   2 +
 target/m68k/fpu_helper.c         | 237 +++++++++++++++++++++++++++++++
 target/m68k/translate.c          |  49 +++++--
 tests/tcg/m68k/packeddecimal-1.c |  45 ++++++
 tests/tcg/m68k/packeddecimal-2.c |  42 ++++++
 tests/tcg/m68k/Makefile.target   |   2 +-
 8 files changed, 368 insertions(+), 14 deletions(-)
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c

-- 
2.43.0


