Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafzr-0001CJ-NN; Thu, 15 Feb 2024 12:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafzq-0001AJ-J4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafzo-0001Pq-Sw
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41223e0777dso5675385e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019882; x=1708624682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+IRUZ5jWxcqPuMBnPz4ZPr8dlbjAv9aNyQYimjXdkc=;
 b=WUxqx0ZFvEEJ3erOLv7hFlEQMe6iGuRr1JjHhULd1hD64AyCifWg5fC8uvFO8er7b9
 oHza77w0dL92X57JPMALYVhIpBHSzQ/4CmCNQqahEemaJKhhKxuM+6HN8TqFn2sMmglh
 MKUfPrGq+nIx1koUY3Cdq2cnWDRd/lJ1r7N9z0BB58RM/dZOf1WBs4oMOsF7iBf6ZWX7
 OluZb6ucg+hnZX6/tMEOiEDbr14fW3L+hM7QCACmghjlPH6sCOwGg5NuHNyOe5GemdjO
 CrfvNZzegHwETp27HIXefOWYuuOpRZO22lPjo3+rqo/C0CMkJm8e8ENBIi4FHfdE1gFf
 d44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019882; x=1708624682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+IRUZ5jWxcqPuMBnPz4ZPr8dlbjAv9aNyQYimjXdkc=;
 b=R4WeXUeWpNjzlvuFtxKuflcE7d/T4//WHgScLkxpEcLfIbz4Ad5LwJVTuUqY4+kJ1Q
 EMnlKXJki3zykIFV1jtyw1R0Jd+AAONEFXovBdkR+pc6hLY+YKKHbNqXR0sObdX7liUV
 sNz4/Oq0s1JS7bqRCPdixtgL50A6e/p5Cz8tAaKwAe63FhdggU46qZ3h9GkAws1okTOw
 CIZzTSfbOLQUkJJT1cOIjxHol2IrRrnks7KdAZlYXCzUzwmFni4lWeb1M3ar7GCStzAy
 uZcbO2+UW4mvBkf/mvLJ2D4dQ2H0kfJWbgsVG/bLUKNjHqDKxUU0rzBIJ5e+q5Eob6gC
 oNgQ==
X-Gm-Message-State: AOJu0YxqApgfqANE3paCgY+X+F1dGAuhXGJMmw4GjbhtX9QBNKYcc1ch
 xWLCScTNL+VtrgYKTuhsAxjg3we7NMsv94g6zy2UYTmp/gucrW5CLtEB2gNJPAgFCMlpsd0m8Pw
 TZRc=
X-Google-Smtp-Source: AGHT+IEo/r7nzbH8BmIlhi5mTe+NeSsVhJI7MNENkuol/wgiPkkgeQ1r1Wc4mvp14QTgpAze7VRk8A==
X-Received: by 2002:a05:600c:45c8:b0:412:2b7a:67fa with SMTP id
 s8-20020a05600c45c800b004122b7a67famr968825wmo.0.1708019882504; 
 Thu, 15 Feb 2024 09:58:02 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a1c4c0b000000b0040d5ae2906esm5644695wmf.30.2024.02.15.09.58.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 01/56] hw/block/tc58128: Don't emit deprecation warning under
 qtest
Date: Thu, 15 Feb 2024 18:56:55 +0100
Message-ID: <20240215175752.82828-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Suppress the deprecation warning when we're running under qtest,
to avoid "make check" including warning messages in its output.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240206154151.155620-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/tc58128.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 6944cf58fa..0984e37417 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -202,7 +202,9 @@ static sh7750_io_device tc58128 = {
 
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
 {
-    warn_report_once("The TC58128 flash device is deprecated");
+    if (!qtest_enabled()) {
+        warn_report_once("The TC58128 flash device is deprecated");
+    }
     init_dev(&tc58128_devs[0], zone1);
     init_dev(&tc58128_devs[1], zone2);
     return sh7750_register_io_device(s, &tc58128);
-- 
2.41.0


