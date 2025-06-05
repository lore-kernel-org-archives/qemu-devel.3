Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E17C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQm-000723-9r; Thu, 05 Jun 2025 12:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0006z6-Cq
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQg-0007wL-8E
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-adb5cb6d8f1so191091866b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140816; x=1749745616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVGmIQVUI71LwqjcHS0gv4sLRbpZFyoXIdxBn+SQNA0=;
 b=pTIgbQV0hf2+QNSUHOkWunGAd0+j2E7csHqiWeR/mHtV5QUcP2n2s4pBv/OVkjpBVa
 egr6f0E6tIMbB7vS+Wdk1+X/NoXtUgDEsAsbDbCHLLjjIIMbJ3W5zhlLVApQZCRSUdlh
 qDC2oJPKouhCF7gpzFPqY2i845wHc3+yapeXE6qCciZZo20oyiYmGs8SWGeaKE4QtXkN
 dMeHJUB4tcCUAqlu3duMbRjgex/CpaeAyJ/gx+IxrdG5LG23CX6i3BRFwA4nebNxPhfz
 +baim/IAtIX5tgcETH4kyxC+pGKeX/m4ce5DFUILk+cO6XXnqII8fpClUmMP3UCdD8uD
 bJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140816; x=1749745616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVGmIQVUI71LwqjcHS0gv4sLRbpZFyoXIdxBn+SQNA0=;
 b=ZVt2be+Q/l7KfRnH482/qvzSgMp5WdFUXrCPA5PlS+RRFK6GU6yTEueRmwN+M7LrsZ
 3WKC/oqcpZGAb5R75tvXvvT6lIxlWYl+M3nHCVzRhbGI5Lm+0QIDhqFoqSTthRC3AAgf
 xoQVmTtOcZRfDc5bv85kQDNyOs1LPt/N7btQRbcmWLxDQafNx4jrgBG3St47wrytfFXi
 JHrwAAqtjkokHghA2j2FGmdppV6S4y0DDVnAYRIWLFWf7qfNXOKVRsKYb783DJViSaO4
 TS8FbifQMYgAgsqjxkcMI7tbNodle4lmnDJ70U88mDEyQWMnyoD+dc/MamnxyDe+V9f5
 WxtA==
X-Gm-Message-State: AOJu0YziPDZ6W91bboHkbfcx0ORalwcrj/421MldnBzYOylI8D+taReV
 AKYVcipTkGpGXa7ZUmsZF1Qk2M5Eqhp+l9YyoDlJDCfupBJX3ZfJdqn9gwd9IF+LT60=
X-Gm-Gg: ASbGnctYUnt8q1tXQSH/Pf7Bz2QB+bNYzWiKt299kD/8YXFMUo/IquRw6yI/KEaO4ok
 yYBSBHETHu8T+Warg5BfLRoLx4qw4vaWXx97LwbHN5uJ0fS+nUE8Aq0q6tfayZob5k4oi5TFdmi
 zRBYpFkXatyIwKXfyJkzAe8EydL69zwEKtSkTCTweypQ9HeWPZPcLVRLIvWjeGVB2a/9fRPjq5/
 2o6LrhbKNn3c/JdWBUvu7LvBFw3tS8GQbQUg9jfXQI9EI3dmF5tWuj+c9nuJ6PPxuUh0TwAZNIm
 6nWbCVVHAn49tP7qA0MRuTV5cJ1QKzjKtH/rSz8ebT5jCqt10qIa
X-Google-Smtp-Source: AGHT+IFFZqOxHLX0Ju5AyBlTOlkaVs0ym2oYyDBqBWhCEUja6Z/vfIiHnkCMTsKRC9vp4p0rUvidPg==
X-Received: by 2002:a17:906:9fc8:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-addf8caa33fmr708579166b.2.1749140816551; 
 Thu, 05 Jun 2025 09:26:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82ccf8sm1266512566b.44.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 211EE5F829;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/17] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Thu,  5 Jun 2025 17:26:41 +0100
Message-ID: <20250605162651.2614401-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-9-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7718199979..194695c881 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2669,6 +2669,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.47.2


