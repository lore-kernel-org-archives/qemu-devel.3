Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1FD49231
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3cv-0002nR-3N; Mon, 18 Nov 2024 10:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3cs-0002n0-RU; Mon, 18 Nov 2024 10:25:19 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tD3cr-0004Zx-7O; Mon, 18 Nov 2024 10:25:18 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso4602573e87.2; 
 Mon, 18 Nov 2024 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731943515; x=1732548315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A5fhFMgZnByAqf9qWevaZUnbhepJEewH1JWBq/obBJI=;
 b=DdPrVoto2W+gHvsEHZRq/aA0XS6FIntra2fKKQGFraSomRQVk55dxJ8Nf+71sYi0I1
 Zsm6onp7W54/pfNacWXrLSbnw/7QvJkVKv2pQdSHkiuT/pM1zufLzyolPaH5Nj3A5wPt
 Em6RuGhbODWCXcFVYxZL9kcJNZvd8JThNfH9tfeKW0i8YQoKXWBrRdotzQtedAWH+DvT
 JoC7r/ftQ6c7Ve5wNkDVkDBMP4Q5onHxy23AWsdMOxKiErhlDD0Ym2xz3uw+VhqxqL7q
 ORDDjXuM5tpC68FM1vylTi/rbiDEPA7/P9O4TamuOqbGwof39tThdAn2yQEy5YPauAKW
 +HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943515; x=1732548315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A5fhFMgZnByAqf9qWevaZUnbhepJEewH1JWBq/obBJI=;
 b=aBY1m83kA0XiR6bhIxeoOz65kxYwXrMkVwsWvwa1MkYPvodu0lDlGbpRnamp4YGZa9
 OQPqk9o7038MvBSXNbzG5Vg1Mu2OnsKOU+BcOuI8F1ctf0eb+npcrBCYA+S3Wsh8bq/T
 Tcr/pYBY5/AT1htdv7siqYQbo9f65NTvn8K1sl5xmdUic/xBtMOSjR7t5Y+nqc1ZNMbm
 I8cEFxsN7H0X/j0Ad4KM+83smlgidcSW1wvmNBT8UkbjyAM4QLXpMFUbnC/2eU3lJx/o
 hSI85sZz9FgQg2aETA/yhWBr63rE/d6ySeRGmOar80/AQm+LW4w58Mp5U9nin3K2mVfo
 D55w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJAjIZ40mIy6e+HDqOellMdDsCXr7SW8WhsoakmUHiUQzn3Qp7R8aNPgFpnOBW8dzR2UsBnm6i6kvH@nongnu.org
X-Gm-Message-State: AOJu0YzgIsQQRGMnezwVIZv98OVh/hFrbWtHpK7LCltYQtw9b5H7/T00
 K3N5fpvpmAu4Qf4BRVgpiugdyCIususaj4+IOev0S0Kh08zwD8vh
X-Google-Smtp-Source: AGHT+IE2s9QeAKdprwbxW4YWWG6gcZ0YBIF8B9GGOshoQiZrF05azayMUE2ZP15d9sYgqMYJpyxkIA==
X-Received: by 2002:a05:6512:3d0f:b0:536:54d6:e6d6 with SMTP id
 2adb3069b0e04-53dab29dc2cmr6333324e87.17.1731943514330; 
 Mon, 18 Nov 2024 07:25:14 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:d00f:257f:ffb:ac70])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da65009f1sm1654740e87.80.2024.11.18.07.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:25:12 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 0/2] arm/ptw: fix missing sctlr.{u}wxn handling in
 get_phys_addr_v6
Date: Mon, 18 Nov 2024 10:25:07 -0500
Message-ID: <20241118152507.45046-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

We observed failing WXN tests in our OS which we tracked down to missing
WXN handling in qemu.

The problem was in that short descriptor format walker did not respect WXN
bit. To fix it, make it possible to call get_S1prot() from
get_phys_addr_v6().

Tested localy that all permission-related tests in our OS passed on
following platforms:

- arm64-virt
- arm-vexpress (v7)
- arm-virt     (v7)

Changes from v2:
  - Fix naming
  - Fix too early ap decoding in get_phys_addr_lpae
  - Refactor a bit security-space related code in get_phys_addr_v6()

Changes from v1:
  - Fix style errors
  - Add cover letter
  - Use get_S1prot() instead of open-coded checks

v2: https://lore.kernel.org/qemu-devel/20241117134931.37249-1-paskripkin@gmail.com/
v1: https://lore.kernel.org/qemu-devel/20241114165900.6399-1-paskripkin@gmail.com/

Pavel Skripkin (2):
  arm/ptw: make get_S1prot accept decoded AP
  arm/ptw: use get_S1prot in get_phys_addr_v6

 target/arm/ptw.c | 69 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

-- 
2.47.0


