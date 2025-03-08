Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD47DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr275-0003K8-4j; Sat, 08 Mar 2025 16:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr271-0003IJ-Ky
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr270-0000wS-4Q
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so2265273f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470816; x=1742075616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfHWVPwLX0M3htfvlA6ICcgJ+5w8LQYjiCmFTnr8X+A=;
 b=zSQmffyYijWtaJfGGjc9VtBAsagKTViDvmvlcXqk1NqNHy6Grz8x8aJOMXkLLayNFL
 K6rfdJJvtRdpILEj6aiQws3k34CK/WWj9HhrSPDIn/rV8RiXZ/adBYgGnE3MpnmrlMTT
 bHU5KfPP1xLvYIrJYwoZgWIulrtgRJT6xpM76vDlu+XIY5jBPFzQ5zwg/OevsH+Z3Tri
 3OQ7SSVQh+viTKj0sExHi94q39X81cp98Ey8qtHwWwDmAoC2CpMDd7DM4SZFATIS3AOo
 sMlSTHKwFF4X6wl8NXJ3/tUiNlTcQVxg9HRpXTgHXpLwksU7L8J9XdPh3FR/VpkgHwRl
 6hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470816; x=1742075616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfHWVPwLX0M3htfvlA6ICcgJ+5w8LQYjiCmFTnr8X+A=;
 b=XRtpaLbHg4ZKnUlNheCeEUYDotq1TTsD/x6zk5aXukBfsXth9mx74ip2+NNmz5Acz6
 cxk48tObwZQu+HuKLl616hpm5R/NmSCzJLaISRdecfUzC4hZ6COBAIbK/PpziG9RJSDb
 mEM8yOjg3LfSnVeS3f8AValq942WbxtjuiSTC8ypmKPwqeg2UAzDraZu1PUD0C0D75W+
 4CXg7lhy0U5/t1xiz49EX8EOJDGVFqpM7lnxh2fVkDILIi3VBqqZfBYlJ1jCj4F5+e5U
 ywHgTtn/3Pv4467rweQWKy4AedEpIE56PMqgSi/HXySw5zJPzhT0hoAJpLr6petW7+dB
 RzIQ==
X-Gm-Message-State: AOJu0YyKRvDEA9wz/O3IXcBbsJ5KPQnx5HMHOugjt8FMlhhkgh/v5qnV
 qGx7tcCdxD5SPcFrQNyxMdtQjAG6ozqKP8LqbU5U5zFUNhexTsun0lfeFbODYG8=
X-Gm-Gg: ASbGncvghDHDz4Kx2BhhF7n4/Vu5d0ehdfinBKjqmvVQ4UKHkGKqJuBjZgrZQFhRKQT
 zY63vQH0OyQ4Q2xgGP+gbha3uKdSdoTdmSLmuI54+vlaAvua5rLzdGlFCNx0OKZ5yl3BvjrWWzk
 ONtjA/I8MyT1dq6G8JTZRieEccEfiQJpngrQbIXFppFLFGUkE4O8WF29wW3j7O+EWV7mS42l30M
 aroGwUOSZoJrHdjmfx2VpEDXnMAClKkQ9UHJ53wPlEpyNZTnOUVTu0qneSatfuCTfIowBBFFhrj
 Oh++QLPBAU5R49hgaFb9JVjiqytFJc3RCM+16FeTZO7mAqc=
X-Google-Smtp-Source: AGHT+IHBbsBk8/zPJQt1yPcMKKU/lz6KhJrt7yaxyAsZ8x/0kPK2iE8NcRBoTSVVjgGOIRLnECEb7w==
X-Received: by 2002:a05:6000:18a3:b0:391:ccf:2d17 with SMTP id
 ffacd0b85a97d-39132b75751mr6149456f8f.0.1741470816516; 
 Sat, 08 Mar 2025 13:53:36 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103aa5sm10055169f8f.94.2025.03.08.13.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 805A2611EA;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 30/31] plugins/core: make a single build unit
Date: Sat,  8 Mar 2025 21:53:25 +0000
Message-Id: <20250308215326.2907828-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Trim through the includes and remove everything not needed for the
core. Only include tcg-op-common.h to remove the need to
TARGET_LONG_BITS and move the build unit into the common set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-31-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e68..eb9281fe54 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,22 +12,14 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "qemu/config-file.h"
-#include "qapi/error.h"
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
-#include "qemu/xxhash.h"
 #include "qemu/rcu.h"
-#include "hw/core/cpu.h"
-
-#include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "plugin.h"
 
 struct qemu_plugin_cb {
diff --git a/plugins/meson.build b/plugins/meson.build
index d27220d5ff..3be8245a69 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,8 +61,5 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c'))
+common_ss.add(files('loader.c', 'api.c', 'core.c'))
 
-specific_ss.add(files(
-  'core.c',
-))
-- 
2.39.5


