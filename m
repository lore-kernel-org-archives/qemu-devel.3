Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D2CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8r0-00033B-HY; Thu, 06 Mar 2025 05:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tq8qy-00032V-Mh
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:53:24 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tq8qw-00025x-Dl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:53:24 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so103002566b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741258400; x=1741863200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KMyM3cZrNGMxoAl8/n5RyGFZlZ3H6fPrLVt28eFC07o=;
 b=wTyN28e5gI1tVIFEKNo9MFNg4IONjcZKflzmKKfZsLaI5Gx1UDqi7mhwQCTIFW/LDT
 xxyrJ/Tv37DoegLvPUScDzbdLo8+uL0dM/WTMzhOmGtMGbhLR9AwEfQjEAJBOt70Dovi
 C8pEwj+pBjyVGLfRWSs6zta25SOfZ3qBMw6hnxuxSrX0sUHw1K9zTZkd3gqpJyvIeCyp
 5i35BgnoxYZv3Vz1WnHZLUimXnwZTMgGfhJm2JRwevuE7IekRb6N+UcjRw/EXf+cmk7K
 uTRlq57hWRWSD7u/sn4oDBgDRjFsNuOai040uUv3NlDuNSjqg5XPZhi2ttBN9hXyGaSc
 XIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741258400; x=1741863200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMyM3cZrNGMxoAl8/n5RyGFZlZ3H6fPrLVt28eFC07o=;
 b=jd97gdYJOlVoW1eIOa660QYlnqvep6+HRzHO+B/zAgFOBR99bnhDjIBoGqX2Ev+Ver
 2prSahuJqT7IGM8DrU6+qVcvOiuXZ33iMLwAotqPDEvOqcMxm9Yj1uvtXNZePRfzWrPR
 bfgfZmG3RMvk3TxsTjQK+D4WsPjygbo5OayAB2RB2yCHoBz5pSMQ+42Wnch53uvXMT38
 +qmqROJA33/fn5XKyhvi1yV9FZKe4SOFzMgsy7OrA83+qj2RnukXuUqUVCnPsdYQXwJa
 fSrUWkGUm0v/xN7sqfAs1hch5V5/b5K9XnUXggQQRMX23em7BPfpDDPzE75Lwuc+zQzw
 Gqkw==
X-Gm-Message-State: AOJu0YwHuiRYvyXLXMeyGPWrAs64rGU48HZ8NUgFSetzkRvFDWbPeLaQ
 m4aBuJAed7asWq6IoW+FcIRmUJH2D4c7W3e6avvIMIG1fGcVkVkCIHMnltRfNzo=
X-Gm-Gg: ASbGncuMQ5Gu6u7gnfTmFk+E+iHWrbU2DHOdRTTcRFsfFS8eaFkBrmSv6WMj/UvDnOT
 P/QjnjnOX9TGIgnUuQbM5cG6aYb26YbvB0gC3Tp7nVxtIGEQKSyBteWzBPiCzS+cCq9IzTJE3NW
 IylnzoeYssqd/U9Ndn6o8Ird9Wl6f7sDh3i++LaGFLdMcrrG2vS8zGYcPyxjpdykJ9iBrr6dkYD
 wD2vXWpeCvZlvze5rFqCNBmdA2fp20G9NJfn9eqFWtfwYqR8OjPvZnjlKamrTNtY2LRV5a42ul6
 2nZlRhanSQ8XCFEzpqWgToh/b+AinKSlB8iKfUEHfpwZ6gI=
X-Google-Smtp-Source: AGHT+IGInNkTkpWvR6UCe9SpUaQ/wIQ167GNIRga4wh+W7UIkkLD+e9chUjgUG9Jth5XvPebOJ70GA==
X-Received: by 2002:a17:907:6d1c:b0:ab7:1012:3ccb with SMTP id
 a640c23a62f3a-ac20d8bc9eemr591503066b.14.1741258399956; 
 Thu, 06 Mar 2025 02:53:19 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239485bf3sm76704766b.63.2025.03.06.02.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 02:53:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 648B95F9CF;
 Thu,  6 Mar 2025 10:53:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] meson.build: default to -gsplit-dwarf for debug info
Date: Thu,  6 Mar 2025 10:53:06 +0000
Message-Id: <20250306105306.2064458-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to 3.9G.

The --disable-split-debug option allows distros to keep all the info
together for ease of packaging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - add --disable/enable-split-debug
  - move to option_cflags
v2
  - removed unneeded []'s
  - fix stray whitespace
---
 meson.build                   | 5 ++++-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8d0abe7f12..09e34a6d63 100644
--- a/meson.build
+++ b/meson.build
@@ -4589,7 +4589,10 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
-option_cflags = (get_option('debug') ? ['-g'] : [])
+option_cflags = []
+if get_option('debug')
+  option_cflags += get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']
+endif
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..3432123fee 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
+option('split_debug', type: 'boolean', value: true,
+       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..aca6e68830 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,6 +504,8 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
+    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
+    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.39.5


