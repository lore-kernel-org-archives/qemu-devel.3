Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38AED2A530
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16zL-0004Xb-7c; Wed, 16 Oct 2024 12:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t16zI-0004W1-LJ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:35:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t16zG-0008DF-EM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:35:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c78a10eb3so16655ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729096499; x=1729701299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ueXERm8qa+oV16S1lDZ0M2cDjKlpQLfHFv5FFoXam0Q=;
 b=F2vo9JUpgj/k9MLj/pFMaMSpLOQjsqbIYB4AxSGjgI3/4kVX/EOc+FLSuyLyET0+co
 WBf/Y0JKVVAhMoMAtUunCpVProGRmS2S+o1Z6y8nbGHZFRbZt0SEkxUCrOF5BjkBXIZ0
 9vTX0Zb9g259kG25VO+a+Y9WaTVIXW16U+Vb/o1oGYanflJ4inJ5rEuS2MJESvJF9Ae4
 o+g0etKHdIeXYBsmIQN2CrdKvH5El7xH6lfuDJEkvBIogx8BVR1aji+85qo4rCPC5QjE
 uJQwToerQC552tmDNJi1f7+lFicxoClpRAz001Bfw9R0MgyTYpaBu9prYUTRndpuDb4y
 ZAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729096499; x=1729701299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueXERm8qa+oV16S1lDZ0M2cDjKlpQLfHFv5FFoXam0Q=;
 b=Kdkua8E0MqXrITD/NE34lzOGWqJns7vMkWOcL6JNumQsYmDDuaEahq405WrvV4qGJs
 l7+7rSV68DIiuhtUtWWizOqC15JiOWRNcE1XIdjdpInYLkXo92V9f4SlcMB+BNEWy3bU
 j3JHygYseop1YLDDapHIw9mGfMYqQyJiMzhSCmkkxTU/93RT7vWAmvg1eL0LXffbLsnr
 RZyub8MDcJTsrelSqljAvFArl+Bnem7+qdHPzKu0e+2VXEKRvDRlhj9GACrdcm4NJqPE
 zgg1he561rSDFzxKLr7wb+/lxUkY74AK3o46wx+zeS0FOFkUzlpf/PCghaNTCDXF1JZB
 d3yg==
X-Gm-Message-State: AOJu0YwXQea/hXq4ru5p1wDP/LEVR/8JjqPFpBn6LWGuJ1ejXIQFyLZv
 D3epwjcNbFAte6Cswy+QYlGtC8IpyiBDbzFBn7D8jYdbuHysOMwZJ7wo7Uiz
X-Google-Smtp-Source: AGHT+IEJW0CMOV/mbC1n0mIs9O8gQrnWoQrel0WqZNSel9Y6tp2GJ6ghY6KOeUffI0TfCdoqkcSkuw==
X-Received: by 2002:a17:903:230d:b0:20b:709d:768b with SMTP id
 d9443c01a7336-20d2fe52e8dmr19629325ad.14.1729096499562; 
 Wed, 16 Oct 2024 09:34:59 -0700 (PDT)
Received: from ubuntu.hitronhub.home ([2804:14c:43:29c4:2cae:c0ff:fe0e:9152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84d8fsm30613485ad.20.2024.10.16.09.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 09:34:59 -0700 (PDT)
From: htafr <htafreit@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	htafr <htafreit@gmail.com>
Subject: [PATCH 0/1] Insert LibSPDM in QEMU enabling in-tree compilation
Date: Wed, 16 Oct 2024 13:34:38 -0300
Message-ID: <20241016163439.1130168-1-htafreit@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=htafreit@gmail.com; helo=mail-pl1-x62c.google.com
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

(I) Summary
===========================================================================

This patch is the beginning of the support of the Security Protocol and 
Data Model (SPDM). There are some known issues (see II), but it's
usable and not many users are going to use this functionality for now,
but for those who will it may facilitate the development.

There are some people working with LibSPDM to implement the SPDM on 
emulated devices, however current works that use QEMU compile LibSPDM
out-of-tree [1][2][3]. This patch enables the compilation of LibSPDM when 
user pass the parameter '--enable-libspdm' to configure file, this option 
is disabled by default. The following parameters were also added:

  --libspdm-crypto=CHOICE  set LibSPDM crypto algorithm [mbedtls] (choices:
                           mbedtls/openssl)
  --libspdm-toolchain=VALUE
                           toolchain to use for LibSPDM compilation [GCC]

In order to facilitate future code development using LibSPDM API, this
patch also provides the definition of the macro 'CONFIG_LIBSPDM'.


(II) Known Limitations
===========================================================================

1. This patch enables LibSPDM in-tree compilation for Linux systems only.
2. LibSPDM compilation uses CMake, so meson build system is making use
   of the CMake module [4].
3. Some problems may occur when compiling LibSPDM with MbedTls such as:
    error: "_GNU_SOURCE" redefined [-Werror]
      10 | #define _GNU_SOURCE

   It's possible to compile using --disable-werror.

(III) Sample configuration
===========================================================================

../configure \
  --disable-werror \
  --enable-libspdm \
  --libspdm-crypto=mbedtls \
  --enable-gcov

References:
[1] riscv-spdm 
  Link: https://github.com/htafr/riscv-spdm
[2] spdm-benchmark 
  Link: https://github.com/rcaalves/spdm-benchmark
[3] qemu-spdm-emulation-guide
  Link: https://github.com/twilfredo/qemu-spdm-emulation-guide
[4] The Meson Build System: CMake module
  Link: https://mesonbuild.com/CMake-module.html

htafr (1):
  libspdm: insert LibSPDM as subproject

 .gitmodules                   |  3 ++
 Kconfig.host                  |  3 ++
 meson.build                   | 84 +++++++++++++++++++++++++++++++++++
 meson_options.txt             |  8 ++++
 scripts/make-config-poison.sh | 19 ++++----
 scripts/meson-buildoptions.sh |  9 ++++
 6 files changed, 117 insertions(+), 9 deletions(-)

-- 
2.43.0


