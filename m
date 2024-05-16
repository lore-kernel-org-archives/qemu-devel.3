Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0955DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7W1b-0006yv-MK; Thu, 16 May 2024 03:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7W1Z-0006yQ-Mp
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:59:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7W1X-0000hm-5f
 for qemu-devel@nongnu.org; Thu, 16 May 2024 03:59:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so2956852a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715846373; x=1716451173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OzQhlf4AQwEvoMnzIqlhn8uie5k7bDBC1GlZIPy6CoA=;
 b=f7QjOkmTA+FXi+uNT3zgq0sYd3sOfR1X3kjBMoolcyFHELXi1Vhswi0TUUifa5RgfK
 FPdBXqwv8YxznI4BK+300/R9r+PEzoV4cobYCwqKtdw1/a9E/M0COQO4FiBEiL29K8w8
 xe1EGrKEbvzoxVaOrgY9jC1t75gH9zHLce7rR2Z8YqFiEtIStnuYrDc8F94ZiSBjTg/v
 NIWNhUR8MLPoXH3qsweVwLt2ftJKgjgUpwPcHUXh28a/ea5P7Gd7QzKJ21twVwfDt8Vo
 khuyJ2f9EpAR3xS52tO/AjSTLHwC0CEpMuSJTtAsjQPeuwDSjC8rwAvU9pRRhke4JaFP
 8dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715846373; x=1716451173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OzQhlf4AQwEvoMnzIqlhn8uie5k7bDBC1GlZIPy6CoA=;
 b=NFMxlJmT99I6YiZzuKlMdlMZ4joWXog2bSPFiFsr0KG3mCJIlmAgPd1pb+HLN5qDCk
 8XxTaawZv8w0DDdMCO9JvmQgkbMF+BbwybLwAzlsBSXYcypUB577aJ1x8JzkjlN9zzyc
 mdVr48GM/F9qu4Lla/WjmQfsvnoqMykV19aUuTtPdBkA5wwr2z0lEoZOZbJld0SI5fSK
 4gHcwjlkkObW5cpzwYzO41G4OY0ccM3jIqvhsyivYCKjgAFLd4mWiMUtO/6l+HXUPu/T
 hnMOdJlt6HIm0z+URWtixco0qOFmQ3VwyTANxQUVseosc5k0Wb5Nn+rlblzsgCit7Ft2
 a5rQ==
X-Gm-Message-State: AOJu0YzyNfzG2rDuzAqpEYOzq+9loYvZ79AriZhGekA8PUTMnzMfYfYN
 OyfuX4FgWYU70E5wTsM5Iu47JR82uVUJeX17RGwG2Toy5tZ7v3inP0C2U8We5NxgS8i0Vb9C8jd
 a+8o=
X-Google-Smtp-Source: AGHT+IG7K9dXnrx/v1fxQVPeSiMKmKSpJIJlO1TkzX5O1ROR4OscQIpeYz/ieZI33eAFtyry5TUAXA==
X-Received: by 2002:a50:cc48:0:b0:573:5c4c:a87a with SMTP id
 4fb4d7f45d1cf-5735c4ca8b7mr10664532a12.27.1715846372970; 
 Thu, 16 May 2024 00:59:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bed2059sm10228140a12.56.2024.05.16.00.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 00:59:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DEC145F75F;
 Thu, 16 May 2024 08:59:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/11] testing and plugin updates
Date: Thu, 16 May 2024 08:59:31 +0100
Message-Id: <20240516075931.868035-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

The following changes since commit 922582ace2df59572a671f5c0c5c6c5c706995e5:

  Merge tag 'pull-hppa-20240515' of https://gitlab.com/rth7680/qemu into staging (2024-05-15 11:46:58 +0200)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-may24-160524-2

for you to fetch changes up to 09afe9677e6aeb7629eeeab5abccc17f67cb4875:

  plugins: remove op from qemu_plugin_inline_cb (2024-05-16 08:55:23 +0100)

----------------------------------------------------------------
plugin and testing updates

 - don't duplicate options for microbit test
 - don't spam the linux source tree when importing headers
 - add STORE_U64 inline op to TCG plugins
 - add conditional callback op to TCG plugins

----------------------------------------------------------------
Alex Bennée (2):
      tests/tcg: don't append QEMU_OPTS for armv6m-undef test
      scripts/update-linux-header.sh: be more src tree friendly

Pierrick Bouvier (9):
      plugins: prepare introduction of new inline ops
      plugins: extract generate ptr for qemu_plugin_u64
      plugins: add new inline op STORE_U64
      tests/plugin/inline: add test for STORE_U64 inline op
      plugins: conditional callbacks
      tests/plugin/inline: add test for conditional callback
      plugins: distinct types for callbacks
      plugins: extract cpu_index generate
      plugins: remove op from qemu_plugin_inline_cb

 include/qemu/plugin.h                 |  42 +++++++----
 include/qemu/qemu-plugin.h            |  80 +++++++++++++++++++-
 plugins/plugin.h                      |  12 ++-
 accel/tcg/plugin-gen.c                | 136 ++++++++++++++++++++++++++--------
 plugins/api.c                         |  39 ++++++++++
 plugins/core.c                        | 109 +++++++++++++++++++--------
 tests/plugin/inline.c                 | 130 ++++++++++++++++++++++++++++++--
 plugins/qemu-plugins.symbols          |   2 +
 scripts/update-linux-headers.sh       |  80 ++++++++++----------
 tests/tcg/arm/Makefile.softmmu-target |   2 +-
 10 files changed, 508 insertions(+), 124 deletions(-)

-- 
2.39.2


