Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1352CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4F-0000s1-Dj; Fri, 08 May 2026 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4E-0000ro-Hn
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4C-0005Tn-M3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso14981265e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253879; x=1778858679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmVzQFlWNEh8GGzpOcq2P8ujtw5hKOEqHq9S42InccQ=;
 b=fjK55Td17X9a8jC/cpZ2A8ZoKl4uj1D8qLEE3wlXqWWtdbA5Ze6enu2EFZaJnJDD2R
 zVyY5unlO6vPyyidipYCXPWp/svvU8o4Suq4r7SLMsbAEGXmOudw+OApodVK+G7aZwBj
 LMmu2bpyfUMmj9fqffGKjHC8F7Coam7he1xWK7nbxBFAX8GzfgF8Ys6fpCKc3ysyCHbj
 YyliS7lmPNsIa+gf1rvwSarLKhMlmwUctWrYt3f2E3g3hDWJDeM9239faMVbiObSGxrm
 /f4wTYUc0MhjJn6bFjSM7F2/USzVTVgv5YcxwXrKaWBz5yP9mpLlz9P7ofaMoRdi5g1u
 /llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253879; x=1778858679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BmVzQFlWNEh8GGzpOcq2P8ujtw5hKOEqHq9S42InccQ=;
 b=pCxq0oCk/ZzVePqL+f11QAxZq3CU5zSLFuK+FBkVVuAPnNFVyPjWSw9EFaSO6f+YQW
 TSqvw7Ti84sXV1RoY85jY3JmgB7KG5fUQVjqRbGm30YVwddRbDohKXkveieBs9fnEdrN
 5r8pGYb3U+9+oi4IwTY00WMslu2pyhQalUxT4hpJWXJqnPOcf2Q03abkwPBg2xiyfUfh
 tts2iqHueLlVo34RzqeejpJeFek6Gh1FVW3tyX3ZN/DpCPAlro8Qr46c2MiqG3kAGW4O
 mnSarzydG+61tPSSS5BGFCvIPIAUEdrGU0qnxFPy0d5p+jruhKQ9DZGAde3lqcYgPh4L
 P/+Q==
X-Gm-Message-State: AOJu0YwsjH3/XN31V8+Okyt4lAw3CxLudmG/gEsYwAGjCn8juca2TOGR
 pjf1NAbwcOee/E/Ft+A2zQ9Hf5ZP/4iTq0HBc+vdco46NIdB8vx4K3TPH8G9YlC8mkaUwx8KIpw
 iDeko
X-Gm-Gg: Acq92OHivfEhq5Md4spIY+7QkJnLCnk9W6OLOzt0c2GgJFKqmthBGwVUN0QTrsoFvfc
 nXZ/AqDgI4rBlXcTDZCHtBbHt4PEnd4gPiBO7J1h2CHOG46mpjF4hrC8ykiLvgxLSvwjmwGHfnX
 vjGOjPQJ8VU/z17gjzZ+weVMfKacVTJNXOIlS54/tHQ6VBiuFKCZqz9FYpw+2hzZejGhnpXlotK
 1agu5SNh4mKR+3Uv4eNEZ43VYDt8cKlejze58Z+36KGV6vh98LehU8gnd9G4jEC73KvRynrVEuT
 iplw6iJYcKHMBcFPOe2E72JYfa9gxRNdcD+YXWSkM8T371LywQJ8SaEdYUz0Lo44x2rVunu6YuA
 FDhKQrQ8UMzP/rmDZL80/M2CdJ8mzAI94JWuHYWYJqHOweIsrYAF+tnQKWNIrqPLpGx7TnoVJ4D
 6vti82cMrzyUnPMxMdQfA6J3ea1rNwHZujRe9I7M8gyHIZ1l4t2G/7I92WoqjxIEJrktZL8BmJv
 Byxj+HHdCfp3jszJKwNP5CjrPS8xrE=
X-Received: by 2002:a05:6000:4312:b0:43d:7d24:b4ff with SMTP id
 ffacd0b85a97d-4515da967a5mr21639508f8f.40.1778253878589; 
 Fri, 08 May 2026 08:24:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:38 -0700 (PDT)
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
Subject: [PATCH 8/9] tools: Move qemu-vmsr-helper up a directory level
Date: Fri,  8 May 2026 16:24:27 +0100
Message-ID: <20260508152428.2648560-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

We currently have exactly one subdirectory of tools, i386, which has
the qemu-vmsr-helper sources in it.  An entire subdirectory isn't
really necessary here as we have only one i386-specific tool binary
and no expectation that we will have many more.  Move it up a
directory level so it's in tools/ with all the other tools sources.

This was previously covered by the "X86 general architecture support"
section of MAINTAINERS under the tools/i386/ path; add both the
source file and the docs file to that section.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                         | 3 ++-
 meson.build                         | 2 +-
 tools/{i386 => }/qemu-vmsr-helper.c | 0
 tools/{i386 => }/rapl-msr-index.h   | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename tools/{i386 => }/qemu-vmsr-helper.c (100%)
 rename tools/{i386 => }/rapl-msr-index.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2c66d7cc3..88cc1516d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -153,7 +153,8 @@ F: stubs/hmp-cmds-target-i386.c
 F: target/i386/*.[ch]
 F: target/i386/Kconfig
 F: target/i386/meson.build
-F: tools/i386/
+F: tools/qemu-vmsr-helper.c
+F: docs/tools/qemu-vmsr-helper.rst
 F: tests/functional/i386/
 F: tests/functional/x86_64/
 
diff --git a/meson.build b/meson.build
index 8164458eea..1dad3a2462 100644
--- a/meson.build
+++ b/meson.build
@@ -4569,7 +4569,7 @@ if have_tools
                install: true)
 
     if cpu == 'x86_64'
-      executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
+      executable('qemu-vmsr-helper', files('tools/qemu-vmsr-helper.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
                               libcap_ng, mpathpersist],
                install: true)
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/qemu-vmsr-helper.c
similarity index 100%
rename from tools/i386/qemu-vmsr-helper.c
rename to tools/qemu-vmsr-helper.c
diff --git a/tools/i386/rapl-msr-index.h b/tools/rapl-msr-index.h
similarity index 100%
rename from tools/i386/rapl-msr-index.h
rename to tools/rapl-msr-index.h
-- 
2.43.0


