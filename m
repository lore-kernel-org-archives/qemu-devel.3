Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8715CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN49-0000qC-Or; Fri, 08 May 2026 11:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN48-0000pB-8f
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN46-0005O5-4w
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so1315013f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253872; x=1778858672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33q0W4XDXe2Cr2peL1NjSTCwZvQTzp4D7QhlQt44I38=;
 b=N5JoQX3qQPXLisAuEvbG58BirMzkeRnb8nC8EV0HXjbqRLcwvR74rW7IyG4ODKyFaH
 oDB8RRKmFYvJzM5zVbcsKvpkAknVlCNb4RZRvZI72rn28kry4mGiBV1uurbTyvEeeSd3
 QlsfXlQnrFvXKYL5jFj6yVM+uiG3hAfXSNsEF8qS8hOt2rTEypcL9ojo9iVMVEHoIviC
 +m3LDHMsh103Vt8jTqABVET97nwfg+j/+fldpz2618eWZVHADj91tBUik/avEnbD/Rds
 NDHWI9bx7er4y5J0W6lVq+/Kf6p++gNKcXmw3DXUb7IzyRvqWS2gJEkeuwLMnZZv713v
 sPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253872; x=1778858672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33q0W4XDXe2Cr2peL1NjSTCwZvQTzp4D7QhlQt44I38=;
 b=fWmpxpP2eQh61PrL2acLYDiDMdYoQXe2Fzak3XFlyoePO0hcNKlveC/z2efKI/b0wb
 8HQAsxgrnUJ2BlX29C6gz26km6lB6cW+fJ49X8hLiYuwBYdWJJRx2kJVoZ0OcrYVUcfa
 XJo9iV+96RCfMvHgDJq2B/1nq+mW9o/L390sRf+59P5k0W7hLpG4ulEpe+PipLBqaJoC
 +0tKzbkPJgbgW+T+I0p0Ijh7333rJA4ahJcWFNyJy1/+AfhCraFYihcP2RZLrD7+M9/r
 uXI+A2bk3g54BMFp/ON/ybCu/6QXTdnxNlp9eOQMkMmShq5Lrr/J5H5n+WT8ijn0FsMU
 l6MQ==
X-Gm-Message-State: AOJu0YyBodGEXKtCN3BiOuzja4DL7T2qSq/5DpOPRnvY+H0oIgH8EOMn
 Enj2nI8t1U+BPMrvdDe7qZ8rRjcLPVTpqIl95PVaSNZw0AB/r8iIL4N1QbNNxMTbyjDcKK7cytg
 kG9OF
X-Gm-Gg: Acq92OGXj+lQlvyGJh5ryRe4Bi7oKcWaVMJLltc3CH9RobwclLrjirusIwCkuxFqB1U
 5F33VTr6s9/KGztIKGQiQ1m3aHHSOa7PlfVQNLDz86QPEGa//AO+6tsYL8s6tNU6CMTA0LSPW6T
 Tkp8aCZ2038KFo1gJpMVOi1f1c+ZuvJzDWQ2xijyktPquIZQdhEmfDjr5DTUu+XKHv6ndXjRJGY
 mTMZRUF5A+G7Vv6y+69nqFiETXX2wF/qY+x+7OrlRIwkjiyRGAr+Lq7brASdSxJjnegGCYmPXhH
 10Qy2nbJYeOWGmk6GZf4m2ymWZiSVT4OMb4fesEvlM5dg9cqUORlnBW7l6wIpQDFa0bshy6kMJU
 asciIDXiM9shTCp2aqb8mUbtYp8VKG5wwH7bBNqwMtXz8anu4F/0asW1yJgXvATJTvUfFOxbAp6
 wl3BbDFrZwfP3u9SteVEmSIisYe6emJe1G2p/LknknfQmw13O7+Gno3Lu2DluPOrFXGQtMcecKZ
 pMRkW87qOM59J/gEZTeumLvafzea30=
X-Received: by 2002:a05:6000:24ca:b0:44a:fe14:3738 with SMTP id
 ffacd0b85a97d-4515b52404emr20856767f8f.10.1778253872455; 
 Fri, 08 May 2026 08:24:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/9] tools: Move qemu-bridge-helper sources to tools/ directory
Date: Fri,  8 May 2026 16:24:21 +0100
Message-ID: <20260508152428.2648560-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the qemu-bridge-helper sources to the tools/ directory.

Note that we have to keep the meson.build rule for building the
executable in the top-level meson.build file rather than putting it
in tools/meson.build, because meson has no way to say "build
executable foo in the top level of the build directory" using
"executable()" in the meson.build file in a subdirectory.  We don't
want to have the tools executables themselves built to tools/foo,
because developers and test-harness code all assumes they are in the
root of the build tree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                        | 2 +-
 meson.build                                        | 2 +-
 qemu-bridge-helper.c => tools/qemu-bridge-helper.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename qemu-bridge-helper.c => tools/qemu-bridge-helper.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..06d703d422 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3430,7 +3430,7 @@ M: Jason Wang <jasowang@redhat.com>
 S: Maintained
 F: net/
 F: include/net/
-F: qemu-bridge-helper.c
+F: tools/qemu-bridge-helper.c
 T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
 
diff --git a/meson.build b/meson.build
index 5fbdc75a0f..b7b260e40c 100644
--- a/meson.build
+++ b/meson.build
@@ -4558,7 +4558,7 @@ if have_tools
   endif
 
   if host_os == 'linux'
-    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
+    executable('qemu-bridge-helper', files('tools/qemu-bridge-helper.c'),
                dependencies: [qemuutil, libcap_ng],
                install: true,
                install_dir: get_option('libexecdir'))
diff --git a/qemu-bridge-helper.c b/tools/qemu-bridge-helper.c
similarity index 100%
rename from qemu-bridge-helper.c
rename to tools/qemu-bridge-helper.c
-- 
2.43.0


