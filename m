Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C7CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4G-0000sZ-CQ; Fri, 08 May 2026 11:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4C-0000r9-75
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4A-0005RN-5k
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so1432229f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253876; x=1778858676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7twr+z2z0KaYotonpbDwicI80OO3y9bheTlSFPeNCc=;
 b=nrOac1GrsooKXLr3RiSdDOdN6qMqLO5WDsI/BhPxtbTVfABnHTUmEOY8BkLg7ItBDD
 kaboTaYAhyqU1VGXPYYaKlqfGgIkbHX/DY/yI4vxCSDrX+l1w5m1ZaI1hYnTlmJkigMu
 KlrRWthqqy0VXHhSMvEa788/4zvlJ/qBIksqZTN64x/o9/xXnL4kOR4LOL7agraS8q+W
 B00O5w/ocHft5WFMTzkn8Uaa72nuNtEGf9jnm+SdjUdYHFdmqi+7iBfDwR+0XKZvw+Yp
 ZSXxqXKWgm9ANLqFTp3Usn9l3I+Qt7MKaE4T8LCYnNYedhcJU5HbAMQVBNnXfU2Ldh/H
 RiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253876; x=1778858676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y7twr+z2z0KaYotonpbDwicI80OO3y9bheTlSFPeNCc=;
 b=h197T2RPh8gZbLJrRycgb7HAbxdiDpaqdJX4ABbAFS1e1vomvY73nUTGV5J66Iuxt4
 bK9RmzYU+mFTB6Yo/xCdBqeSOjs1/LWPj2po5DWu6R0ujqq82PE4Ff6i4bD9yExvTpYt
 LeRH22KVots4oU5XOSHW4jcc+KWZTV3U304/W9E/H7WCX6nC472O42Z5NU/73BtOKNAl
 SRbp02DOFOdNgrDV3wHClhxn0mWsMMUmpRloNyTXXLRjvwCJLlccqQUHIY0JAfOk6Dyp
 QZkRZw+jzLsdG3Iw+g6cUjJEQEkO9Y1LyOn6RQfRKoTIcXR7fCLGpJJJbcDw+Juvwjcf
 vX3Q==
X-Gm-Message-State: AOJu0YxdGIogGKcJhBX3Zx+O9LOSw1Rizb+KMtwXP/vOo/Po9QFY9Of/
 yF18tEjs82uCaQQI1HzmcPGgsVGdVnYgq8IOHMFeQ3UlsfIXczyOIjsT2G1g8NFgRLAmNKNcw05
 csmB4
X-Gm-Gg: Acq92OFsL3cKGv8r2kXdxs8iF3PUAdsSQ5ktsIAQHhZGZQXAhsG0ZP24amO2r66Qzyg
 CFc581Rki7qWKCDcnHhCm8gK0+HjGXTU3WRzbzCzCf2fPB/9OjQZkx9BRWInlfWC85FRr8KwhG+
 KEVJOHA4wxsKn2e7u0NWwZFCSJ4YVN3UAgLSeuU5iJiFJ4lPqhvRvOYjoGEv4q28Y0y5chGeLZp
 RTohIFdcT77W8rDll0mx3xmG8rjNwufLyMKT7WQKLTrUfU4qRdPw8opSDjaz9iomjnSGZ+jQGV1
 yO/J9V17KV8v6lbMTG//jXg2WHVLuTUBd9WLWC9tc5xc5Au+sCG5EQ9DLgcg/j9Ufne8fDmEj+g
 lXQj0ZsYFpwLo5io0r3rsQqSedGapGOf27LurbYfjLljqcD0emahifq5Z8LjZv5hxZB6PvXkxX+
 bTNnRGh373oeMJI/8G8LENVvylSufeJYLS3f1CdJpGBEz1Axv1wNUx6wNqr47F26LIGPhCW7oHO
 ol0Y7v1Y+3ta/3+pVI4yuZmTZ7BRE0=
X-Received: by 2002:a05:6000:ec7:b0:452:f380:5508 with SMTP id
 ffacd0b85a97d-452f38056f9mr8813568f8f.0.1778253876518; 
 Fri, 08 May 2026 08:24:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:35 -0700 (PDT)
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
Subject: [PATCH 6/9] tools: Move qemu-nbd sources to tools/ directory
Date: Fri,  8 May 2026 16:24:25 +0100
Message-ID: <20260508152428.2648560-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Move the qemu-nbd sources into the tools/ subdirectory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                    | 2 +-
 meson.build                    | 2 +-
 qemu-nbd.c => tools/qemu-nbd.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename qemu-nbd.c => tools/qemu-nbd.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f89bf2642..f2c66d7cc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4227,7 +4227,7 @@ S: Maintained
 F: block/nbd*
 F: nbd/
 F: include/block/nbd*
-F: qemu-nbd.*
+F: tools/qemu-nbd.*
 F: blockdev-nbd.c
 F: docs/interop/nbd.rst
 F: docs/tools/qemu-nbd.rst
diff --git a/meson.build b/meson.build
index 1f34ed71ab..63eb4031a4 100644
--- a/meson.build
+++ b/meson.build
@@ -4529,7 +4529,7 @@ if have_tools
   qemu_io = executable('qemu-io', files('tools/qemu-io.c'),
              link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
-  qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+  qemu_nbd = executable('qemu-nbd', files('tools/qemu-nbd.c'),
                link_args: tools_link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
diff --git a/qemu-nbd.c b/tools/qemu-nbd.c
similarity index 100%
rename from qemu-nbd.c
rename to tools/qemu-nbd.c
-- 
2.43.0


