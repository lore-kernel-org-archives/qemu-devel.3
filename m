Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A9FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJG-0004kL-Hh; Tue, 21 Oct 2025 16:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJ9-0004B1-8u
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJ1-0001Vg-Li
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso54893295e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079805; x=1761684605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SwD2kmxbJvpINdRgbF4ogIXx69W3XFLK5H26Co5VqzE=;
 b=vJfs5PjFZ1D9TNBGjrs4f2gd6FUU3kaphod9FhEIKeNcoDtkcl6ohPG142mmkoVDPb
 J8jKZwgY62FilnleNLDQWZEi+5i3zygB9kElQDY/7MadfnKox6SbAz2YlE0LUFqsQpD8
 5SZh5LZOj8HsSnWKbMAofBlOM7OGjgZRIwmOsZGXq4aEtmn7hYDWR6ViW+yZLrei6jZ2
 3LrPqd/A0+yeAys7513BNUj9btK/sqg+pOrVbaGpFtAu0WSyNqmBu47Gji0dLkoNDsJj
 grQNHdqhN++IbOI5uWxFqwkASl4r+uxZcl4FzRfLHAUfr+nx8kH5LedmKQ2FcXy4E4iN
 9UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079805; x=1761684605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwD2kmxbJvpINdRgbF4ogIXx69W3XFLK5H26Co5VqzE=;
 b=qYDNyqC38lua4tb3yqdcuxYxmTcI2BoCXhdRGnEqjWwXnPHrJn56oL/AdDzWKV8kp2
 zxnyDBarmZptf7jykMnBs6Xo1BcIidqEcrzMOOzX+tWql+R8+Oq7Nwa/7HZeTOH2C+n1
 /YCMZiBlxXhtWYwdAhNSUWQRUsCRQTRSdBN3A6vwPNe/+5Q7bqA12WP+bR4QtI7n/9Sg
 NbU3Ka5CEa15o+saoTdQrj34xqDerYyOxOxNqrVw2Jux6yhuOVHdTdztSj3jIh0ZcLAk
 +YM05V4VxTRSkUa6pge4kSFXZ9pa9h8+sbZCm23k3Y8AAY3IytNLz+EeB8IEivZ5JzIF
 f/FA==
X-Gm-Message-State: AOJu0YwvH4XqsPcxwJ2do8t0vc1Pj83i7yv9Wh+R6Hl0WRFO2joaOBDd
 1MYXZb+Mempn7lMKQDLgi24VIO1/d/f5280/5racIFd2oASueyv7KuWjHcDH2lqpZLmu0xI8dMC
 N5L46Peo=
X-Gm-Gg: ASbGncuxC4JFAs3k43J/T2eq1YsqueiY2sZ0eyIZ5FR8vhV8veXew9l/GA46aWxhF0n
 MRE7HBfi94EMCUW4+Ckj3zZiTN4E/CBXch590ZNP9OifXN7Bp5KVWpBv0SciqxPgAFpA+lb7VBV
 p+IZCG76yicPI0HZRFw2BL2MxSkjD3qfxqOHIS0N6j2k7TPjwGJBIeFDSQsOvDlXqpjulhebSXV
 x0fgt3Djp0iwZBBOmZLL+04RKz8KtfUWfMmaEC+g8AemIKAuyuNc7zmFyzzJSXeycdJd8jD2/az
 GaS66U2eQOZ61LaIOpH/EokpjVTzE47orVkOvKalhzYnnPOjfDLsz6uGJHAXMnaF2Ga0e4A8LwT
 sAjzsUp5jaiTX9CvRJiMSvMywaJj8Eh8CB4+KgZC+GalhMUL66cOSA7Bpm3RBqZCShHtXPy/erU
 aATKzzbx/M5fQskpaTX5v1JkPNgpCNln7C+CI++QttNAkDp3DYr19B7NzpDCHJ
X-Google-Smtp-Source: AGHT+IEN8N6cbZTmZ5+K3NeRYQfV2pXjzXbHHh3gQLJlaF4O8z1hqyW1LZccfvS4pLaT4KDYfeurng==
X-Received: by 2002:a05:600c:4507:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-4711787276dmr138738415e9.4.1761079805393; 
 Tue, 21 Oct 2025 13:50:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c2c9dasm23717925e9.4.2025.10.21.13.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/45] hw/pcspk: check the "pit" is set
Date: Tue, 21 Oct 2025 22:46:53 +0200
Message-ID: <20251021204700.56072-40-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

We don't let the user create a "isa-pcspk" via -device yet (in theory,
we could, and fallback on a lookup PIT), but we can add some safety
checks that the property was correctly set nonetheless.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021090317.425409-7-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/pcspk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 7b716c08efc..54fcf632e6a 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -189,6 +189,11 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     ISADevice *isadev = ISA_DEVICE(dev);
     PCSpkState *s = PC_SPEAKER(dev);
 
+    if (!s->pit) {
+        error_setg(errp, "pcspk: No \"pit\" set or available");
+        return;
+    }
+
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
     if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
-- 
2.51.0


