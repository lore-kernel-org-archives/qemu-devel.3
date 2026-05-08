Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43315CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4E-0000rp-Mj; Fri, 08 May 2026 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4A-0000qQ-2A
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN48-0005QL-Bm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso20490525e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253874; x=1778858674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK5ez33lVuPxUlgcUB4M6u/BjlmFJ+0FTK3XgrLB+B8=;
 b=JRkZeR9AkH1uB6ZfrUP30ZaY2eUInsuplolDCGrHxkB8/B2VSkED/VXQmPPqFxYH3+
 Rt2IDhwAJL1wvcBXDsL6csDyA4sUdOowaRQ8JznX/Ybd/+ICAYuXnxQWm6TK607JuWzd
 JKZYjxdhJFiJilZA+s2/NB/o3sZnkA6vslOuBpnq5idQ3vLtpt0wjNZrP820YW1+iu60
 wEucHRppmY2kS8x0v5+fx+YUWw1hibqTOnvq2Ag7AOcDxL8F7iD7XU579ZcIBw6oH0I5
 92+SVkBDZzyb1kgQWRzdVD6qQnnZJshNu3ahBLj7QQXI6kgMVcWNbxc3Y7gCCDYPJod/
 cB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253874; x=1778858674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mK5ez33lVuPxUlgcUB4M6u/BjlmFJ+0FTK3XgrLB+B8=;
 b=AdwL7SYGmBcAT8SjlrC3ZhiObrPG56UWwJIJNkl8Cti69PFu8j55niPEVUAwDeXssx
 aAzpnDdZ3NUeq8GzNx6sJyz/HaBg9LtJV/p0x5hKOnJ74j45SU7qT/pKwlfgdmPUKTjp
 QbNIkwZISmYnmPnR47c0sJlG7blogHMQiKr/n1KIWRhFeQCzPRi3gCWzNJxVD9BF+7zG
 cMyOtkrdb0TVuyVLIZSa2stxWsOQ0vOKFUrnSDzG2wJFYZ3I5e8Q4h+/3xvzm3jUcXm9
 2Xyicu1R5eYTEsWKGhk9QG4D+U+kf3AS3hxeV93qSMmTdd3X4T9uz9675j/HWBYEcSvM
 MyAg==
X-Gm-Message-State: AOJu0YxMsbNrFB9uj8Qb3KsxQNJ2wiZTM9Db5GG6j20RdCYkFHjeiCh7
 jVDsk2CHcPar0OwR0pygdFYbdfIVEEr2Nqa6zMG+ONvczVSaNTHvxNjBJeJS9dnsuxbKLxMte4g
 nxrDB
X-Gm-Gg: AeBDieublQoljnRw5poG7JeAIEKon0Sq/WPm177HLZTq8LTE5LkECzWSSvvH2xXV+2j
 oCvaJ3L0S6npUQXtehsaJMCqd0Le5q7WjBwYeWJr6O6AZQLWNtuLqV8fC5JMsKwPTAqFWzkTEFu
 Os5zeGDVXSPeTd0o9N18hf3F7CCm0ipzTlgvHtOU80ZdaCSbD8Zm7X41eLYj+HtSH4qH7hsFsgV
 cIXx7s57giw8smY+ESu3PTSdCD9taJhFl87GQ4M59t8C+TUGgXYQuPLJiWkDQwXzwktEgKvlYTp
 Li+zQag88UNc5nToaSKJa1huOAUn6YAUiCk8ElV7k+C9TLTE21+ZVaD2KrioU+kPOdJiQzxqd+v
 SEoti0XcwxPaYRcPiIAXDY7HKdbAtMUHDIiS0ApMB80lbH8pBBhAL3knrgmanCmGT8vyovQNUgt
 2RqKawT3qJrcztXSt/0S9+ItuPljEKsk0Z53VHtC/1QpE01KGUzrXgO/p1OleGtG1Mx26M1j9FI
 tr1q4+86sBUr3v+
X-Received: by 2002:a05:600c:8485:b0:48a:58ae:9933 with SMTP id
 5b1f17b1804b1-48e51f32806mr208463295e9.18.1778253874565; 
 Fri, 08 May 2026 08:24:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:33 -0700 (PDT)
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
Subject: [PATCH 4/9] tools: Move qemu-img sources to tools/ directory
Date: Fri,  8 May 2026 16:24:23 +0100
Message-ID: <20260508152428.2648560-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Move the qemu-img source files into the tools subdirectory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                | 2 +-
 docs/tools/qemu-img.rst                    | 2 +-
 meson.build                                | 4 ++--
 qemu-img-cmds.hx => tools/qemu-img-cmds.hx | 0
 qemu-img.c => tools/qemu-img.c             | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename qemu-img-cmds.hx => tools/qemu-img-cmds.hx (100%)
 rename qemu-img.c => tools/qemu-img.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd53604f92..2ef9655c94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3106,7 +3106,7 @@ F: qapi/block*.json
 F: qapi/transaction.json
 F: include/block/
 F: include/system/block-*.h
-F: qemu-img*
+F: tools/qemu-img*
 F: docs/tools/qemu-img.rst
 F: qemu-io*
 F: tests/qemu-iotests/
diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 558b0eb84d..52466759d2 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -39,7 +39,7 @@ Standard options:
 
 The following commands are supported:
 
-.. hxtool-doc:: qemu-img-cmds.hx
+.. hxtool-doc:: tools/qemu-img-cmds.hx
 
 Command parameters:
 
diff --git a/meson.build b/meson.build
index d4c16b394e..5d34ea39ed 100644
--- a/meson.build
+++ b/meson.build
@@ -3561,7 +3561,7 @@ genh += qemu_version
 hxdep = []
 hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
-  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
+  ['tools/qemu-img-cmds.hx', 'qemu-img-cmds.h'],
 ]
 if have_system
   hx_headers += [
@@ -4523,7 +4523,7 @@ endif
 
 if have_tools
   tools_link_args = enable_modules ? ['@block.syms'] : []
-  qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+  qemu_img = executable('qemu-img', [files('tools/qemu-img.c'), hxdep],
              link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
diff --git a/qemu-img-cmds.hx b/tools/qemu-img-cmds.hx
similarity index 100%
rename from qemu-img-cmds.hx
rename to tools/qemu-img-cmds.hx
diff --git a/qemu-img.c b/tools/qemu-img.c
similarity index 100%
rename from qemu-img.c
rename to tools/qemu-img.c
-- 
2.43.0


