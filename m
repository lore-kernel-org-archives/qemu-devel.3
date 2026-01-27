Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D6AD2F003
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTH-0000sZ-Sf; Tue, 27 Jan 2026 06:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTD-0000mj-7N
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wl-Qd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so43943155e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514168; x=1770118968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFMK76OhI5WV2zTduMXr4TLJjZWnWpeCni/ztYEsoKQ=;
 b=U5boZ/VYcYOYi8DA/U+aNTx0cDv8DtRU5GsKhyTFSln5T1EDNf5AwcYxdogtc++W9Q
 oES6vQMyPZd8wvVg8iZtEtfOBdy7MSFbPeyVRw4pwUllC/YO52dOcB4qZpt3xi+6FQro
 aere9FL/2K3HmswL6xlgBifGoKgadnAQH9EPCNpq0ysyJ23b8/Ig56HC0Aja/R5akWQo
 Cxa6Nrbkm4jA6BwmKvJdS5Z6XtYNk+6IjZ1RQFfjBw/3UkAMY1q9yb+cayKZKphsd7GQ
 HQ+O1y55lcwvGwBjuztpxo4qEBI+XRB33issX65+YK64q/WOTq8rbwG7Q6vZCIGaO3aF
 F7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514168; x=1770118968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFMK76OhI5WV2zTduMXr4TLJjZWnWpeCni/ztYEsoKQ=;
 b=nDYmMEfFXVO8iFsJECtA3KwEpqQSP6bX8HwqM/s6UFYJWS9XDSl54KTQZbp/Wzn2Ci
 kXwpQ6p/7mwPHt0JVCWTVh9rDCKXYcDNKc4GeVveJSv7svR14GbmRq18hAm4uVLrHPPQ
 /DLaX0+nFz1HvMh6FDH5lTF/luJwTOf5rM7BVIOAxuf4/Zwijn+iYaRjUUY0EfqiASJb
 CfoWu1Dd5pcIvjvR2rV5ClhVs6wVHtV28PSzntWGsApfqXIw32Lof7a/JVzGrP8KgGkj
 AHW89PmlX6WWTNhwL5OAahV/r0EEjbjm09ycjPnFrKBc86/bAsxd/5dzaQindk0SuxLx
 tYnA==
X-Gm-Message-State: AOJu0YzRukFY1IGcuXEj14rq0uIka+yagQVBbE1PojM5TocIsmG6wI8Q
 FquAhpAXLviHiPeROO/fk0rIHKhX/sTPlkBr3pwibucpNy7Ie3sFhq2g6bQtF9M55/0=
X-Gm-Gg: AZuq6aJVX1iBircEN2vcMiNJpDIim6tgCb3rYlgLCIytN/CuH7EtSrgDni//Ie7Lo2b
 Le5mF547O8iTXPPbZlN+evycLk8bGLQu4HjbDzGQHBXEfnGzKluZkLK3edNOJ1/6VYUQpXBnHbB
 wmQLk4Up7yv+Xx8Yv7Ed/8W7B/cQv9Uha7KaEngkB6PfKSoZjSADIiDQZ0ZlT8QSzx6U7VxQDvV
 7s+l/mWMSacnRLMWbzHPd04bS4l9yJsRr3rNdGQ1pfPish7rjfUpl0JaJ3iGWDRZzrIR8Llnyko
 M6kJSjEeKDp1IVKbKrS5ga2tMXOg5GbmX9RvGZgQfc11oTXAHdWWVOHYJdaUJQReu6o9uKo56xt
 ehfulD40v0+HNVtE21zJazTvlVfYZCbhVcdGYZ/LwbV6OVR5FWvUOzKD+3BPOdjG1eNNuiBm8kC
 5MDbSh3KwMk/k=
X-Received: by 2002:a05:600c:4f41:b0:480:53ce:45d3 with SMTP id
 5b1f17b1804b1-48069c47cd3mr21839425e9.18.1769514168293; 
 Tue, 27 Jan 2026 03:42:48 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bf7ae8sm56317795e9.7.2026.01.27.03.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED2555F91F;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/9] MAINTAINERS: update Arm to Supported status
Date: Tue, 27 Jan 2026 11:42:36 +0000
Message-ID: <20260127114240.3009791-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127114240.3009791-1-alex.bennee@linaro.org>
References: <20260127114240.3009791-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

We are involved in lots of areas of the QEMU code base but as I'm sure
most developers will realise we are actively funded to support the Arm
ecosystem for both emulation and virtualisation use-cases. Lets make
that clear in MAINTAINERS to keep parity with the other Supported
architectures.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260123145750.1200879-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c1da08a34e..49507340e3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -200,7 +200,7 @@ F: disas/alpha.c
 ARM TCG CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: target/arm/
 F: target/arm/tcg/
 F: tests/functional/aarch64/meson.build
@@ -462,7 +462,7 @@ F: scripts/kvm/kvm_flightrecorder
 ARM KVM CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: target/arm/kvm.c
 F: tests/functional/aarch64/test_kvm.py
 
@@ -1102,7 +1102,7 @@ F: docs/system/arm/versatile.rst
 Virt
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Supported
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
-- 
2.47.3


