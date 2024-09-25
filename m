Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615A0CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYq-0001rC-Ao; Wed, 25 Sep 2024 13:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYR-0000Kw-HG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYN-0000cz-2x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so213495e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284309; x=1727889109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycFC3pmsoWssj1+GB+z++1OZtt6It3e2DUWkH7pV350=;
 b=DKWRlWdyfZAGyamN+6xxwTv4k99DBGWkdCA6jof+LeDkD0M4KtzF1WRL0rcf9ny6dJ
 vbaRqz6rZgFxJ2TcnQwTUq3XqfFhghvFo59NCfzzD6/OYzlKA8ADzcu6Zsep507VQAaT
 AIbT1qqF9iJNQ3dOhEuGzMRGatamjWL9rXiGULKUcd4N6LzUq8fe3c5bSruwsC5di42O
 QvlFEN3zrH2xU/hl51QSpSnwtpUgB3S7m5SdpfNYC62av/o6kf1VHGxwfymCXu0ZksRr
 8xSD8eKk4JhVeWb0ujohKpsNjBCPBBgknEkd0D9FTdUqqboxNFabPkLc6Lo3+l+yN37O
 UggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284309; x=1727889109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycFC3pmsoWssj1+GB+z++1OZtt6It3e2DUWkH7pV350=;
 b=vUYL9QMSAW8yFQQ9y5Lfjta0ctrcz2dw/Jd94bU04untW5U9wi258vY8vo8EXEk2sX
 HKHQp8fTCN63JbBUblsEg0bYcBVZmB3VbLtplH7E1JoHr3UdoGHqAkiqORWZjyxQlm3Z
 iR32HmvHiQ65PbcPUW3RfEx3BNND1ZLouoE5Pk0LKC+iZPhxyfzTz4vpHRZF9hfzytBe
 itNxkVE2zyHA2RmsWnBtm2FP+AoAt42LQr7ejvGwuB6ZdhltgyafYlWxQijpfYFbbnse
 nsLwdynBf02A9Us5Ky/XIvXhT+Kcyx/SslZfIie7p5QTn5yApsE/8iqW5XDiA6HndNDq
 useA==
X-Gm-Message-State: AOJu0YypqRCLiZXB/wZrI/TfKH6+2+HRjRbUuu1TvaQXf++7W7+sqPUn
 aVCGNLKpkyeW+cdPkvwCwl7xZKUIPi3Xj8qxtOwdV34SAtojb7SgtH8EhKKhiHc=
X-Google-Smtp-Source: AGHT+IFRxeZoSgBmmopQctlKDB9ApqhA+1oJ+LWS6CG6+0s5NaCxN5dtRqAGt/nMi5ztrLWq2e6P4w==
X-Received: by 2002:a05:600c:1c05:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-42e961445d3mr23154945e9.23.1727284309232; 
 Wed, 25 Sep 2024 10:11:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e902560cfsm56646345e9.0.2024.09.25.10.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA71C5FA36;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 05/10] meson: hide tsan related warnings
Date: Wed, 25 Sep 2024 18:11:35 +0100
Message-Id: <20240925171140.1307033-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When building with gcc-12 -fsanitize=thread, gcc reports some
constructions not supported with tsan.
Found on debian stable.

qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
   36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240910174013.1433331-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 10464466ff..ceee6b22c8 100644
--- a/meson.build
+++ b/meson.build
@@ -518,7 +518,15 @@ if get_option('tsan')
                          prefix: '#include <sanitizer/tsan_interface.h>')
     error('Cannot enable TSAN due to missing fiber annotation interface')
   endif
-  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
+  tsan_warn_suppress = []
+  # gcc (>=11) will report constructions not supported by tsan:
+  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
+  # https://gcc.gnu.org/gcc-11/changes.html
+  # However, clang does not support this warning and this triggers an error.
+  if cc.has_argument('-Wno-tsan')
+    tsan_warn_suppress = ['-Wno-tsan']
+  endif
+  qemu_cflags = ['-fsanitize=thread'] + tsan_warn_suppress + qemu_cflags
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-- 
2.39.5


