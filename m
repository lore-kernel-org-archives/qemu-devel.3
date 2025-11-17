Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0694CEBF92
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1V7-0003st-6v; Mon, 17 Nov 2025 10:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UL-0003cF-1d
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UI-0007x6-8s
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so24735695e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394593; x=1763999393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKwFkurM9Nyilz3I4Z/N79loPlVXRQglRORlSVi/F+4=;
 b=rFTAAR82P/eoyueM33c7t+NlRUe81SjNBtWnYFpJQ6SNqugzyjQgUSYl20g6EdLaqM
 2AAMb6Z8OCxPuq0R8LFXREc+YwHhml19trtSmsD+2mOdWeg39NnckCpPlCKejpzjTk9u
 fIuGE+Os+6u7KTyHEY0XpDLBgruRyOj5d7W9SnJqIjNw9Un+vLKw5vT4gKALagcJJVWz
 AWIEqo+bEmDnZFQx/oPV9W6gAxeK+EAnsSmsZXQdoBaW8GT6mMcAFsFhfVQlQguqB0Q6
 0m0ALuzjQ4iKDNr6R0JuPJUnMt13DU8yY+JeZXu+qe6jIwbm1SmmzY7GkOdpQ7AutIIB
 wYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394593; x=1763999393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AKwFkurM9Nyilz3I4Z/N79loPlVXRQglRORlSVi/F+4=;
 b=Um5/TM7w4qxjmbfz4+83GhYPrH30TP3O+cIfrrhXaGJgVmw5G/pmkT8WTBrRC9UyAv
 FUVjDSKiZhTUuim6fIpfm7cZjvr1Qjeai6bT8ujFoJX4asaWAt6IuPv0bHoDDdrChVh9
 CHvxQBfUHpHmOrK4mAkkecfCcFAXntuDOf98wShbZ4+M7KEchW7tCmcI9DD8Figap1xz
 HnjzPwxElJVu2hQrRnO5oIahHi0tXEBVmV5UHxhtp+pSJPYodFcjPbMMY8UAyNAVmLZ8
 dlgPdoICtgqG6SB87jPM+Ux9qkTjpNi+lEhZ44DtRosXqoiz+oRa6+OD6nO7QqZLfFxc
 j3cw==
X-Gm-Message-State: AOJu0YyNk4jdwr9J1+egNwN/WRoMFzf8CwN8pWp+sEiooNKTgjUjhFfD
 t3qijJGONIRw4UTQSXp9B3Ho7WXkU668Rhl68GYVKNjnGlxr2zcSBRqn4Vr82hsESPE=
X-Gm-Gg: ASbGncvBvbT5lcYLhImMe9LvIahRkxp2dI1++DMyft2Q89DDyxTAMZy8ySk0oGnNj6H
 6kXoKolGb6NNKfn2AH8t4PUKl1NutsLyuGgcFvEVrrpKYqc2jfA7Lu2+twWuEHpKMeoZ2rmQa3I
 twYpOOWzE6yfJjctEfkM/FsFfXwr+wx0T8eRykAVoc93S0vJHuH5f9VikY9Rm17AqJz+ir2oRw5
 yhBhaowpzWYW5RJ5dTUDYVCcOZCDc8XTXF3xgKEchW8S2gvncmz+Z67oOedA9bVH/MBqytuuEMy
 cp0EyWPtq0XxhPu2wY7naxXsjuFf6EDT4rdq+IVtHXQGZm8B8O88y+2u5+ImOG4EIoaf0EGvVih
 vx1ETu6v7U1gCvZXcgq2EU/67y3XqsCxTRB1rxptyJ/yUT6DtkFaDbZXLCKZtksZU5kRZThjM2H
 lfzHz8h3kyjik=
X-Google-Smtp-Source: AGHT+IEhAu+3NKP/J5u8AOmXVh9iBPXiq0+tIqcW4R5SL3ZC+aVXuwonnp++dx1WL1M995f/iXwkGQ==
X-Received: by 2002:a05:600c:354c:b0:475:daa7:ec60 with SMTP id
 5b1f17b1804b1-4778fe95f49mr117084445e9.21.1763394592747; 
 Mon, 17 Nov 2025 07:49:52 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e43c2fsm300090815e9.6.2025.11.17.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0418A5F929;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
Subject: [PULL 06/18] tests: move test_xen assets to share.linaro.org
Date: Mon, 17 Nov 2025 15:49:35 +0000
Message-ID: <20251117154948.4122164-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251117115523.3993105-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_xen.py b/tests/functional/aarch64/test_xen.py
index 261d796540d..d90595cad35 100755
--- a/tests/functional/aarch64/test_xen.py
+++ b/tests/functional/aarch64/test_xen.py
@@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        'https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd',
         '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
@@ -55,8 +54,7 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     ASSET_XEN_4_11 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO',
         'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
 
     def test_arm64_xen_411_and_dom0(self):
@@ -66,8 +64,7 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_14 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX',
         'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
 
     def test_arm64_xen_414_and_dom0(self):
@@ -77,8 +74,7 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_15 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-upstream-4.15-unstable.deb'),
+        'https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks',
         '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
     def test_arm64_xen_415_and_dom0(self):
-- 
2.47.3


