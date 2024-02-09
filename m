Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C6C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqe-0005WP-M9; Fri, 09 Feb 2024 14:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqa-0005U0-Kw
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqZ-0005Am-4N
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4106cf2e9e2so8214625e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508057; x=1708112857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5lqtHDdYR44xIv7ErGYBoC322q69wLbs7IK5BRXf84=;
 b=Xz+eznKxzreKL7z7UWuWRCrjvUM375gtYhSW67640n+lURYsJLrPyrctg70oal+1ic
 xaHGSaz0vL0XQ5Agb3DXMoUERDIRc8NOnpTB5qd3WtSfQo9j0QjL/LpU+GN12FUoEn51
 mzQwu+g5zhCM1je0GoVRLwKwUprDUNYeSXxpq1dw+vC7rA13qdjq58V/uD60wMc4f6eV
 Z0riGc1m+1uYBSfsFOKvBqa5HYpS5hhqeBy+DczzWK8uQpGXsZwfW8yUqhJMOYoVLH9E
 lhZGbw01xImReY+r9W6mrVE6ZfunBUUyN9zT05YyIDFBo0Or4B4sMMrANFBXofWQRebx
 5B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508057; x=1708112857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5lqtHDdYR44xIv7ErGYBoC322q69wLbs7IK5BRXf84=;
 b=M2BNMuzCgMaQ/7J2qzH5e7T72EJorAFo+zSVKjBtSPhGcbQuo0c0fgIX3PMKorjC3T
 zEQKmKFSEXTR9UB0e24fVtzMBYp/5VJQdyvi2NNA6l5eURStALWVUtkjj10q1ok5nI2R
 b+t79eKN+bhu+fLeCHFOLnvgv4VJGt2kMZKjVS8NC6xG6rXbowaLCbv+bvWUK9t+cE6w
 eNhBWRltWcjj/z3zvrRSgdGFpWKxsTrdVlyvzbq6NryRAAyjjJsxCTJzilUU8b17U+PE
 KCs/ONpDeWpxy4CnNl1ga0zvyBohz7uhcT/SXuoIovzojqwYR0SFdrb51nxh55nR3s85
 8yQQ==
X-Gm-Message-State: AOJu0Yy72MgeS1Id6chWFsyv/yD+r75lF25XMLKM7vCIDaygQQDRCUNn
 VbWDBwHMJWv7cozrcidbz8CFBrAQQeZyCHZ4RBLBezGWCgy2JDe9BD1TJ+IlP4Q=
X-Google-Smtp-Source: AGHT+IFje7lVZtZjN8SBqrZgNazEZ/sDzptKvZ4JKrU0uFEpppFJKzRe4ik+ZBmo3NU8s3m1wuXiag==
X-Received: by 2002:a05:600c:45ca:b0:410:3151:8025 with SMTP id
 s10-20020a05600c45ca00b0041031518025mr220718wmo.28.1707508057677; 
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUs0eCkbpSluA1CCUrNIwTKeZqP4GgMnyVvMy8kc8L0e24lThsCzgjrF0aJdV0t61LFB7yCljF7Z7l86B2kKW+VA6ZkHYLdlSzR7qDdwgR9aFtEbUeve8Ic
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jz15-20020a05600c580f00b004101f27737asm1469255wmb.29.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9E015F879;
 Fri,  9 Feb 2024 19:47:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/10] configure: run plugin TCG tests again
Date: Fri,  9 Feb 2024 19:47:27 +0000
Message-Id: <20240209194734.3424785-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
dropped the CONFIG_PLUGIN line from tests/tcg/config-host.mak, due to confusion
caused by the shadowing of $config_host_mak.  However, TCG tests were still
expecting it.  Oops.

Put it back, in the meanwhile the shadowing is gone so it's clear that it goes
in the tests/tcg configuration.

Cc:  <alex.bennee@linaro.org>
Fixes: 39fb3cfc28b ("configure: clean up plugin option handling", 2023-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240124115332.612162-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-4-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 3d8e24ae011..ff058d6c486 100755
--- a/configure
+++ b/configure
@@ -1644,6 +1644,9 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
 echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
+if test "$plugins" = "yes" ; then
+    echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
+fi
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.39.2


