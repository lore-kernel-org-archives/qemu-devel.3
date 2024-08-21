Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671B3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgktm-0006c3-40; Wed, 21 Aug 2024 08:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgktk-0006Mt-6B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:57:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgkti-00056Q-8t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:57:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281c164408so53154185e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724245027; x=1724849827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gA4g8NREBw11Sneps3qOndtgnps8d4Lb3G4SjsHUUOM=;
 b=t1eVr3/zQb93P989jsZbUrV7r+pFVUxkEthmrYRatdIo2TxrWTo5jBj+WfPxPR94Pu
 VjZluxScbyKM9KU1w/64dbr+gyaNvWw/48u2UvS/nizx04kwkmZzZAyVXqmmC65hFbmh
 DcmZQueATPqfqyEZ8MVcORnzL5YEIOsw9NTKg6jXAEiM9xQk5ICBo/PD+TfmFnodoDIG
 1f9VV6JWYVwG35OCJFAppg6YUvu+3/qkhZjFtbNUvvFclXARij4f1mh607mVrJ8zChKk
 7Ue/j0yXayOLlvkIftCJ4XxagrUkIGObw+6/x6/Fy6SsRNGAOG9y1Ldwu/PgIrhhap/4
 eRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724245027; x=1724849827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gA4g8NREBw11Sneps3qOndtgnps8d4Lb3G4SjsHUUOM=;
 b=BcbDqD/SB0xe6nf/JWGIOM92YtULVVL8YaJPPAe6DgILttf3Loj18MVFPdi4yjU1xJ
 8LYJ4NrQvrXPfYXMFBpv6TOcTN51URnZsd6zMzWW81bQYWmMMajjIkuCTtadNZtrN7VQ
 G/BVuKKnuTGwrUC1PqTQ8m55LyKgC8Exnp0cu2108yyVNXU2Xa9jqng8jIaMokWIEz+Y
 sLR7iHpiJT58dIifzrhq81PzzA6rpV03xv/1LV6yg9LgnPjW4H+AmHn62kC3Y8B+TAEn
 HHwzGy7PNyHWvdT+wdZt/uhIoo7G1OgtiSXPKTiS/7oicrUAS0OhHcoVAnvTjbcPFiHn
 p53Q==
X-Gm-Message-State: AOJu0YxxmSgLsnDTowMTbfqoL8KOTi1hjgLnUvOAyIllnPGpum1sgNJj
 emP/PE5dwIksrkoDh4YvSmLgfwxb+JpvHLqPrtFo32eKN1TlJIWWEK1xsVRh8X651y9KpvGZeyF
 XuI0=
X-Google-Smtp-Source: AGHT+IFE9oZoLaNgyoZ0jwQRNvQWws6pByS8FI5iYOOfQymwMiQR6EM7Cs843F+3Re7Y9uOyibRjiA==
X-Received: by 2002:a05:600c:35c2:b0:426:5dd0:a1e4 with SMTP id
 5b1f17b1804b1-42abd111aa5mr17698275e9.8.1724245026994; 
 Wed, 21 Aug 2024 05:57:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefcb674sm24566255e9.32.2024.08.21.05.57.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Aug 2024 05:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Beraldo Leal <bleal@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 0/2] tests/functional: Convert MIPS Malta avocado tests
Date: Wed, 21 Aug 2024 14:56:59 +0200
Message-ID: <20240821125701.63042-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Based-on: <20240821082748.65853-1-thuth@redhat.com>

Philippe Mathieu-Daudé (2):
  tests/functional: Convert mips64el Malta I6400 avocado tests
  tests/functional: Convert mipsel Malta YAMON avocado test

 MAINTAINERS                                   |  3 +-
 tests/functional/meson.build                  |  5 +
 .../test_mips64el_malta.py}                   | 98 +++++--------------
 tests/functional/test_mipsel_malta.py         | 46 +++++++++
 4 files changed, 78 insertions(+), 74 deletions(-)
 rename tests/{avocado/machine_mips_malta.py => functional/test_mips64el_malta.py} (53%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_mipsel_malta.py

-- 
2.45.2


