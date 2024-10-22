Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A6D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q4-0005w8-9L; Mon, 21 Oct 2024 22:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q2-0005vO-Nn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:46 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q1-0001Wq-49
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:46 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7eb0bc007edso30099a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563283; x=1730168083;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5MvZfZJ1w+4jWoKSy1g+C8Ivvk/AddqkyL7u9uzph4=;
 b=lPU5yoeQOO6zwtnLcmgOv6RGaNAHh0BrgtmkN3qJoKFw060w2rr12Nnlz2iNJebhFD
 6MKcEud4OgRtFZf24cwHSyor/7cAU57MOl48T2KTOigZidnCp4RmDSncRMXM9N3YFsSH
 jR1dO7goELGgB/KgCJ5GJPnCojdq/EPZtIAqK/zZo6pUvbFI5nauIX+2zc57nABtVKUK
 Wbnm0o+pRnKEFpj13AaT0pMicHnihoKCclMOM71WTGy/P4QlrtNQtzNNBXC0Eg2zt+8d
 sQ8HFrTJCdyt+Bnv4ixxDj4WA5ZTReWGmuypLe9qQ1uQlIOsVgTuMzNl783bb8kSlzIW
 n6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563283; x=1730168083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5MvZfZJ1w+4jWoKSy1g+C8Ivvk/AddqkyL7u9uzph4=;
 b=gEF5wky7X+l+b1GRS3obCtElceOS5FHk+lmEUBIB1jU73ariOSI+I57yXS+1npDUGB
 ne8YxzayQikbI/fY+7b923BK58ovCwh7DQQ+j2LvkKDSzeAHNbl2gVgdJi7D/Yc4Q1u+
 1/lvDjRKzqlitZWHyA5LdmPWhVQTvzi7HKb1Xfw3uQTijp1nYqxB1cnLllM12sZBRyVH
 sGXDVaBOvjoPj2GYfUejGYyUyvntn2HMz8hhjGjNmsNDcmTXIdOzkMWcpXgzBXDVFZBr
 xcW3316WJdVUzvv3MT87Yidz+Z+AIcdU849CIDH0IQegz6alzGePITWoFvjDkaZEkMGX
 kCLg==
X-Gm-Message-State: AOJu0YzLLLSmnQPxi9BzSL9D93WLitC7NXfuWQBC/ARxDIUFPLS2fI//
 nkcJAIQu8h1T/mimxOJI7XRqtfAWr9hq4TaqXewo9fFNNeEZuct9gWEQ8khd2fo5jP0PlI7Dvif
 FuMkTSA==
X-Google-Smtp-Source: AGHT+IENuVTNXjHICjhlAVrfJZrJ6dYjOmJ/DjzyWdC0koxZVln6NeZFXsl3SeQE82G6xu8LLtkFXw==
X-Received: by 2002:a05:6a20:d795:b0:1d9:252f:a063 with SMTP id
 adf61e73a8af0-1d96dece061mr1204868637.25.1729563282891; 
 Mon, 21 Oct 2024 19:14:42 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:42 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 2/5] tests/migration: Make initrd-stress.img built by
 default
Date: Tue, 22 Oct 2024 10:14:23 +0800
Message-Id: <712b58440ee6a2cfae925978276171553dbae1eb.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

The initrd-stress.img was compiled by specifying the target,
to make it easier for developers to play the guestperf tool,
make it built when dependencies suffices.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration/meson.build | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index a91aa61c65..e10acbe317 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -2,17 +2,21 @@ sysprof = dependency('sysprof-capture-4', method: 'pkg-config', required: false)
 glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
                          method: 'pkg-config', static: true)
 
-stress = executable(
-  'stress',
-  files('stress.c'),
-  dependencies: [glib_static, sysprof],
-  link_args: ['-static'],
-  build_by_default: false,
-)
 
-custom_target(
-  'initrd-stress.img',
-  output: 'initrd-stress.img',
-  input: stress,
-  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@']
-)
+if host_os == 'linux' and sysprof.found() and glib_static.found()
+    stress = executable(
+      'stress',
+      files('stress.c'),
+      dependencies: [glib_static, sysprof],
+      link_args: ['-static'],
+    )
+
+    custom_target(
+      'initrd-stress.img',
+      output: 'initrd-stress.img',
+      input: stress,
+      command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@'],
+      build_by_default: true,
+      depends: [stress],
+    )
+endif
-- 
2.27.0


