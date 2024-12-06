Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B709FE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOlc-0006lC-1n; Thu, 05 Dec 2024 22:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlb-0006kt-4d
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:31 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlZ-0004QA-Nc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:30 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f205c4625dso455319eaf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454748; x=1734059548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P+kwPXUXhBd7tlX6IIB4yH2oiMxaqbT5fblYS9xF7QM=;
 b=uhnDGe9QuiQ2Ru6gG+EiHR9R9VW5El11VoJHGY5h8QcoWculspITmnJavwJ5Pkxj33
 XlRWUuRB4sKfdN+aKdxQbjwOvqPnFWdzjtTQtnvCGqY/Ip5CEpjnu8W8qlnjEAqqoJLA
 uXWKkYBG3V1FnnYIiyqDCRyJvhqHHkvqLFrxwbRS/nVVkl/C74I79anaU7fuglFywXP2
 dn6VhIHHZcCKAvDchvc2GglShE9OFifnEgB+upwulTb2pjC4kx7JN3aYggPL9AYSLezz
 On4uE3dAhXHX5NtvizBwlm3AKR2gultJBgtHXaM12YEpm83+7dacZCyZGXM8Jjb2tPxm
 bOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454748; x=1734059548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+kwPXUXhBd7tlX6IIB4yH2oiMxaqbT5fblYS9xF7QM=;
 b=Cu+Yu23vXOf3rutU6nr0O1yjZC2VTh5m4jFBY41IFfc+86GKoQUKweROgpncqB9T4+
 2u0DrnHf8My6Z47c/4CBwxyMnjM+XlywrLV9hArEFOTmlPZONvlPo5gxIgF5Uwre2g/z
 ITUtC46A9BhOs1QhdLx4gpLCYUqrBssf2vXUqk8futiXXR10VNs7ewOVxkNj9ETzBi6p
 rkp8jqbT8CeurNpArlr7j+8m9PgBN/2IWt08lj+ZPgPaQfZQF8QDderMjDo3TaO+Cmt3
 It5rGr7FFnMWygPxX7yYAZ1KATSun1no10BZpZAJD7f8/Cd8K13nJLg5Sy2+LJ4NL+qC
 4LFw==
X-Gm-Message-State: AOJu0YxMnAjA1qRtSOcSpKDxpxDRghrAT3oNRT0PNt+lZUzJA7u9j/8n
 scKmmY8CS8p4NHZhvTWR1Afdkyp19gB1HguqhNX9sSjtroWaUO40J3GCuRSXv+MA8M/nhkZdO7B
 G3qIQBJPc
X-Gm-Gg: ASbGncv2DuGQl+Fp0cfKcjlrMHIkI/ycDyCOijeujLLxF7UTTeF8+LkmLDPk+RFVtt2
 Uj83NmJHy8FtHQnFGMZIXTF9ATk9wI7ZA4O/ag9jVhjlPdsZrHPFejRQbx8goW/ZxBtAp7QTJ05
 98TdJlsNv0oX//wDL8z40zOYZbl5sss5AjFrOWe41HurEOPw0CG+r1uXO3CQjHXUFMzEtHt8dYB
 fIGKGlEEbMmu+sA4aKyXJKQ5Lm6DK3IB9ecCNkLfDXQ27K9KMVkGcKUPdyUO+Tnf9FQOgI6ezw2
 3yC8CNVXBao1qeK3kKoaT91bb7T2cX652J+5
X-Google-Smtp-Source: AGHT+IGscDvObt/mFjke0FeJtBWXRtYWi+u45hPiRe7/2wHHKnqdXfXA3MWHrD0S6P8YhOXC1QxLcQ==
X-Received: by 2002:a05:6830:6e98:b0:710:fef4:3c92 with SMTP id
 46e09a7af769-71dcf5c2d9fmr853089a34.21.1733454748065; 
 Thu, 05 Dec 2024 19:12:28 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/9] target/arm: Helper type cleanups
Date: Thu,  5 Dec 2024 21:12:15 -0600
Message-ID: <20241206031224.78525-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

Add macros such that "fpst" can be used with DEF_HELPER to
indicate float_status* instead of "ptr" for void*.
In addition, fix a few uses of "ptr" that should be "env".

r~

Richard Henderson (9):
  target/arm: Introduce fpst alias for helper.h
  target/arm: Convert vfp_helper.c to fpst alias
  target/arm: Convert helper-a64.c to fpst alias
  target/arm: Convert vec_helper.c to fpst alias
  target/arm: Convert neon_helper.c to fpst alias
  target/arm: Convert sve_helper.c to fpst alias
  target/arm: Convert sme_helper.c to fpst alias
  target/arm: Convert vec_helper.c to use env alias
  target/arm: Convert neon_helper.c to use env alias

 target/arm/helper.h          | 638 ++++++++++++++++++-----------------
 target/arm/tcg/helper-a64.h  | 114 +++----
 target/arm/tcg/helper-sme.h  |   4 +-
 target/arm/tcg/helper-sve.h  | 426 +++++++++++------------
 target/arm/tcg/helper-a64.c  |  98 ++----
 target/arm/tcg/neon_helper.c |  27 +-
 target/arm/tcg/sme_helper.c  |   8 +-
 target/arm/tcg/sve_helper.c  |  96 +++---
 target/arm/tcg/vec_helper.c  |  81 ++---
 target/arm/vfp_helper.c      | 120 +++----
 10 files changed, 775 insertions(+), 837 deletions(-)

-- 
2.43.0


