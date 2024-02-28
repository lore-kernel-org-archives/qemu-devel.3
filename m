Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A93BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQUZ-0007yU-5M; Wed, 28 Feb 2024 15:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUW-0007yD-TU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:24 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUV-0007Lu-3O
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29a6dcfdd30so83043a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709151921; x=1709756721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R78jNI3rLibNEjtOaGTlNz6g97kDn+JovIEvILiHK7Q=;
 b=znQ3y1csU6bp5A6J6DJ6lfTQ1vGHq/7rb5IbeOC9TzZhEGP9W67tXAiMX+btAeIdLY
 rcxO6/aNEvtYR090yVf3YO3iU6/hdiGZfP0+6SHQEVmEjQUsPXbPQO8hfHZa1whvLNco
 5PqUoovA3GVDESkratc9QZuE+EmxIsqGBQUZh7+2vL3/S8wWPZa0yxo/0GNfsbV1cs4p
 7miNzf0daRUeYEsLECdBza9hpGV6CDj4gU9PqNTHquN1DqNzVUnLzR8J/p2lZUxqF3gu
 ckp5wWIUuOLWbVgw1C6YnNzD4z7TXrkBpQEtAyjeuQ4hpLkIo8BuIt9hJWxs6kxWpU+Q
 N8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151921; x=1709756721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R78jNI3rLibNEjtOaGTlNz6g97kDn+JovIEvILiHK7Q=;
 b=sVNWFPRaOmtNSP1Prdu6so/49bCjUSJykeNQ1UN7cuh17Jjmpc+5+hCrb6oB3ij0UV
 QBGzPvhiyLlUEDEZVJETPw7LgCRZT3zQPBM+3rQRot3v/1qewQL0ZOoHRjyC9dzNnV9Z
 NqsCxjxc8v0pxjlIDjNcBD0v3nFqEVfkYMt1wGlNcXnx0XVFmCGyWA1e177wR9RjXSxG
 d7ElcYiE+N/vJqsrkw6sVP6Ffh/B5JQ8740WZIum5/65kiku34E6rhgo8qi86mkqac8V
 4pPRpCFS6fZCSqbxj1R228sOw9UHKBjWZlGNFclnZb9sr4QGzWhhHiLWj9KVr2Om+fJw
 FAqQ==
X-Gm-Message-State: AOJu0YwzNR8Ezn9Pr8hvy4Q34l5xurbpwiL1RT8Lzu5oShrSHaNffSWV
 5aro89anKR80b+8hhhCakQ/fHsDyCM3d6HWol1w6QDtwyWiHLrucLzMDvXdFG/QYmx6dJ7rkR73
 d
X-Google-Smtp-Source: AGHT+IFDtD4q2TNroYCoH1ZL2WxskTVsT9xdRh5x+Y0L2T0KAov688azsH4QT79rHRYh9HGIzhDdlg==
X-Received: by 2002:a17:90a:9315:b0:29a:68ad:b77e with SMTP id
 p21-20020a17090a931500b0029a68adb77emr232425pjo.19.1709151921247; 
 Wed, 28 Feb 2024 12:25:21 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm2118499pjb.38.2024.02.28.12.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 12:25:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
Subject: [PATCH v2 0/5] linux-user: Rewrite target_shmat
Date: Wed, 28 Feb 2024 10:25:13 -1000
Message-Id: <20240228202518.33180-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

There are multiple issues with the implementation of shmat().

(1) With reserved_va, which is the default for 32-on-64-bit, we mmap the
    entire guest address space.  Unlike mmap, shmat refuses to replace an
    existing mapping without setting SHM_REMAP.  This is the original
    subject of issue #115, though it quicky gets distracted by
    something else.

(2) With target page size > host page size, and a shm area
    that is not a multiple of the target page size, we leave
    an unmapped hole that the target expects to be mapped.
    This is the subject of 

	https://lore.kernel.org/qemu-devel/2no4imvz2zrar5kchz2l3oddqbgpj77jgwcuf7aritkn2ok763@i2mvpcihztho/

    wherein qemu itself expects a mapping to exist, and
    dies in open_self_maps_2.

So: reimplement the thing.

Changes for v2:
  - Include Ilya's test case, which caught extra errors: Yay!
  - Include x86_64 /proc/self/maps fix, which the test triggers.
  - Dropped r-b for the shmat rewrite due to number of changes.


r~


Based-on: <20240222204323.268539-1-richard.henderson@linaro.org>
("[PULL 00/39] tcg and linux-user patch queue")
(Which is technically now out of date, waiting on the coredump
rewrite to solve -Wvla werrors.)




Ilya Leoshkevich (1):
  tests/tcg: Check that shmat() does not break /proc/self/maps

Richard Henderson (4):
  linux-user/x86_64: Handle the vsyscall page in open_self_maps_{2,4}
  linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
  linux-user: Add strace for shmat
  linux-user: Rewrite target_shmat

 linux-user/loongarch64/target_syscall.h      |   7 -
 linux-user/mmap.c                            | 172 +++++++++++++++----
 linux-user/strace.c                          |  23 +++
 linux-user/syscall.c                         |  16 ++
 tests/tcg/multiarch/linux/linux-shmat-maps.c |  55 ++++++
 linux-user/strace.list                       |   2 +-
 6 files changed, 231 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c

-- 
2.34.1


