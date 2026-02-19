Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62894E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e6-0002GX-MP; Thu, 19 Feb 2026 14:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dn-0000qB-TA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dm-0000LD-3A
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-480706554beso14663035e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529083; x=1772133883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W95W3WfsG+O6Ranwv7RoGgpQEkRHcfUe5LncHrGF5P0=;
 b=mlL+aRXgH720OKq1cMOui9jVwiQjtC0MlDedMynnOJ6qvaYOzvQaCCU5GZVKR0JpPd
 Tsd+GWqo+T4d+At5mBgFuhu5iyIpYg6VQSirQdjsTOmYsuOh1kFfz4iq4m5C27MPhJnI
 qYjhFFyMsKjbABVZzqQttH4qQ0tWdGMlbmsKImbP0dhMFqbf7o71uLTXRosI59JKunEH
 99e5xgJ7VVgcqAQFFE4XIflhBGu3Y/bPJpGxZYXFrfk5ONvOQvzgD+wHSp7fhJe37fch
 QqTmPeu10yu8rSjcbvYqpKVpJQgENxDKUwjA8m+2zBYSxlBVpiHGxYKwFARZ8P+vGmfm
 PJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529083; x=1772133883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W95W3WfsG+O6Ranwv7RoGgpQEkRHcfUe5LncHrGF5P0=;
 b=hlSq+iensLRg7S+3XdAyn954JVcfqbi6bZGArT0z23x0O9Rh/2ZWk3l5eyojRwY7hM
 A+4cj3iATejRXzhFcK4eoNhwdB2IA2D3iKfS7sWJGvcbFmmL4vTJItX4adT48j0K8XKp
 4Tkuyy7pS2yRnPwxKrNWpfCmMw9hlqArKTuhIi09PBOGmrK92AVsqkiPFpaBYs/W6eRu
 bpjMd4iqG5EcpV0wM790zZq98+uLiNd8ZX+n9qLRp/VHyyRmBmbNsVvZYyAnYRdwgb1k
 t5gWrgMxelSaM+2hHiWIsqDM+OHfBnc/gD55FeahsIBYgtnpwee7HsXgX9Lc8lIBsDUY
 uNMw==
X-Gm-Message-State: AOJu0YzvqWAj3cUgz45B+gvoe7Otjn1tOl6RzVIzhfWMv2AwhIGmkoO2
 brmR61VGPAJVuBCbf8Hexx1OTvAtARpNGJ9KwY6A5QIXiRTQt6sPnfHVDvJyIYvS4Mdpv2smMdb
 h2nTkyBY7PA==
X-Gm-Gg: AZuq6aJh0c+UpE/1Ly6UGroxNcEqLQHZcO4ddgSQ4KGXnE/izRx0Z9taUcD+G99SYoU
 /TXAtaF5uUPj4p32KLQOJNni097YRYf+L9n0+BSD4aUstmsl6QWRGJzMNVX5nqq4V+TScT+wTac
 o79zR7LE4gPEviEbDZx9TtVrWj1SVi8T7hR9EjS+hmxw92eydvThY1RdR50ZW/VWyQBWXBkPjfG
 FSTtsj94dXWhi5WOwPElgEoMhkkvzIzPECgn1qbulzITgcDidaCsVyz5YGC0BRI/zCjrDx6Ieod
 AJgQEfSZdgeMa5HVq9GolHka6Lp1rhUpG2Qda+e42HuDPi+t+bYyPcDZteOu2touf4SYcSzAHKD
 tDVgER/fA1PMHad6SQ9IMWGaH2q/AZLHl2poUSu82JB20jGj/60EJYx1HsuCMDEGk6kLaRKJwgq
 JGigEdy1+Ns6DESKQgXeOW0pvsuEbF3d0GLDqRC8l9eMRfxQPz0kOA2kQLDlkb5B3pgTCRZt+a
X-Received: by 2002:a05:600c:37cc:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-48379b93370mr319095965e9.5.1771529083000; 
 Thu, 19 Feb 2026 11:24:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bfef4sm34313975e9.7.2026.02.19.11.24.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 40/50] target/sh4: Build 'gdbstub.c' once for system
 binaries
Date: Thu, 19 Feb 2026 20:19:42 +0100
Message-ID: <20260219191955.83815-41-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

'gdbstub.c' can now be built once for all qemu-system-sh4*
binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index 1327507dfc8..3861d9b194a 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -1,7 +1,6 @@
 sh4_ss = ss.source_set()
 sh4_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'translate.c',
@@ -9,8 +8,13 @@ sh4_ss.add(files(
 
 sh4_common_system_ss = ss.source_set()
 sh4_common_system_ss.add(files(
+  'gdbstub.c',
   'monitor.c',
 ))
 
+sh4_user_ss = ss.source_set()
+sh4_user_ss.add(files('gdbstub.c'))
+
 target_arch += {'sh4': sh4_ss}
+target_user_arch += {'sh4': sh4_user_ss}
 target_common_system_arch += {'sh4': sh4_common_system_ss}
-- 
2.52.0


