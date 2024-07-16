Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EE9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbu-0005uW-DI; Tue, 16 Jul 2024 03:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbs-0005kF-3g
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:29 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbf-0006T5-Ts
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:27 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-70847d0cb1fso2856702a34.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114893; x=1721719693;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jnVBgXlsSgyb7y1XOm3dq34QzfGRm0o7Ff/hpdF16J0=;
 b=QXnppr9lz8/5+suwzwNl+y5+hsFmBsroRgb8D/8Br+6+fwQVlLjEIhApEP46VpX/H3
 Bgy6icK+eRkmV6NI1t3b68Sh6q6hfkHRX0eYmW/53IV1rbeWhAs+Ealakfw47WvVY8lp
 vI29u6cr3THcH7uwnCHXcadVH6y05NLray4JEyBuxwaI53JwKgLH/K+Bx5Jpj+1rsJHf
 njIFf8memrmol0X/zNrY6rzmUA5jUgPSUgAbbJsgf4TPf3LsZ17hgmF2uLzomefUTaA0
 lhkF7NMh4uDiu1tozFEe9N6i8wImPLRPtjrgIX99r4l8xl5xW7BqPLxv0YWzYVTC4t84
 85rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114893; x=1721719693;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnVBgXlsSgyb7y1XOm3dq34QzfGRm0o7Ff/hpdF16J0=;
 b=tQBPEkf5dn5pVNTcf8Ge4Uk/VqNUFQMLBGE19W/jhWAjWYC2/qsRRLSVkvxQqXWaWD
 FuvVd26ZRdU0EV2GnUesLkItmnBy7ZdgbM3G4WI3/UY4z6sVR2Wb6kh/VupC4hT7kOtK
 Ir/xHtNZEGFlQYmcO7f+PZ95wy3a54+4h6FWCHuKhKVBvSjujUjM3u9oPO070M7omSFF
 TCcMQPpXzG9TkKZIEUo8VliLyFFAso5fZ9jazLv0h70+cNLoeA8XIUZRvsKg75xNJ9gY
 pNNzo/ZEUgITrQqgJBsAxceqOjkfgB8QZ6jGy1E6DRNJ7+IaC8GHsWgbHVf/3jBLynd/
 9U0A==
X-Gm-Message-State: AOJu0Ywn1uTvYu23FYTfrmX4KcO9XFbEYJcHsXcbPAqS1W2oIMqYDYmh
 oSTgm+FGmgnIES9SnrEFiKBYZ/Lii5CTo48u7GNAbzsSvJ7NMCxYFV/xmoAUEbw=
X-Google-Smtp-Source: AGHT+IHW1fxpD7iS5EiceIdlR+QbMGGGRt3QLC9qgdLLAe9827VTS3pptlwm3plRMMRY7flf/OHYow==
X-Received: by 2002:a05:6830:6d16:b0:708:d84d:f628 with SMTP id
 46e09a7af769-708d99bc4cbmr1778311a34.31.1721114892924; 
 Tue, 16 Jul 2024 00:28:12 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ec7c5b9sm5628994b3a.120.2024.07.16.00.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:33 +0900
Subject: [PATCH v4 3/7] qga: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-3-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default state directory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-5-akihiko.odaki@daynix.com>
---
 qga/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index f4d5f15bb3d5..4bb6f7e27b66 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -45,12 +45,11 @@
 #define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.0"
 #endif /* CONFIG_BSD */
 #define QGA_SERIAL_PATH_DEFAULT "/dev/ttyS0"
-#define QGA_STATE_RELATIVE_DIR  "run"
 #else
 #define QGA_VIRTIO_PATH_DEFAULT "\\\\.\\Global\\org.qemu.guest_agent.0"
-#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
 #define QGA_SERIAL_PATH_DEFAULT "COM1"
 #endif
+#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
 #ifdef CONFIG_FSFREEZE
 #define QGA_FSFREEZE_HOOK_DEFAULT CONFIG_QEMU_CONFDIR "/fsfreeze-hook"
 #endif
@@ -129,12 +128,12 @@ static void stop_agent(GAState *s, bool requested);
 static void
 init_dfl_pathnames(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
     g_assert(dfl_pathnames.state_dir == NULL);
     g_assert(dfl_pathnames.pidfile == NULL);
-    dfl_pathnames.state_dir = g_build_filename(state, QGA_STATE_RELATIVE_DIR, NULL);
-    dfl_pathnames.pidfile = g_build_filename(state, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
+    dfl_pathnames.state_dir = g_build_filename(run, QGA_STATE_RELATIVE_DIR, NULL);
+    dfl_pathnames.pidfile = g_build_filename(run, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
 }
 
 static void quit_handler(int sig)

-- 
2.45.2


