Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDB6CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwugz-0006zX-0E; Thu, 11 Sep 2025 23:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugv-0006yq-MQ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugn-0007vR-1i
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45df656889cso8877195e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648585; x=1758253385; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5YCH2MJb2HNjjmB077MawQlihvASAC8bJ66TeNL3grc=;
 b=Kd+fwUZrLiX1spY3REzBz5AqUtQcHdKd/5nH/it79vf7AfiTIsCIz/b2nXue/tV0Bh
 xlrw6jOnsZE6zO78Q6zGJDdgj0Fp1yQo01OMhB0LZu33t9TbwsAQRjCuTr4/kkCZc/e+
 CIyeebVAcH5BU8pK/qXSdNJWe9fLxTJwVK92LiLBT6/ysXJXwbCiGQkayhfuttnHRIR+
 Dv0vr4lxYXVmgKcTe3ZT5IMApkkbWmjdMS01hx16WJ2+Fn8lqrYNKvkEth3+cAXBBi7D
 YzVru2slZ/iWE/AexXEdonIGAqDRDPda6uNQnltUqzzmtNHRowRCuUift8MqeSU4FE0k
 aTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648585; x=1758253385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YCH2MJb2HNjjmB077MawQlihvASAC8bJ66TeNL3grc=;
 b=XU4FZrNHOFfn9+nKLnfU6I3cVxr/Suj4s14tIRhdpGNpsTYeZJoi6NeuG4QBgkl4y8
 klEwcIwh+KfnvoAH4G7y0UEXzkMq1i55iu6nh/NkdSJVe0hxNnFw84Flju2CweJO8ROS
 Vo9OPaVD3LeYIE3DGE926qNB+VsazmCvyyq8BOd+nCvK+qWDERG9tGlZ5rCGqpIZ1/0w
 N5n94Oi8rB/W3GVR6OS1uOo5ixWzdue01lzH0NvtyWkmxwVG4G/3Cq8ZPhuL6ubdCDNP
 m6ju7IOF4PhgU9N/11wv2dEThZ2HJ304xUkV6iS2gJTX2MLofaQh/qdUuqJw7adV6+ND
 p1JQ==
X-Gm-Message-State: AOJu0YwfyKPx1tW40cDwvMBiWDQbJKlAwK1sORal0iARyLeVq9x+x89h
 GrVGccgX6qkMgZmW0QOlR2UWu/CYWSI4YhuAgNwuu/dwa2mON36Z8Nmw
X-Gm-Gg: ASbGnct+GOZF/X8vaQXEULYB1JIn2QnY6QbUfByANT4tjCmMHzrJ7DM8SJ+EwFl8SLa
 B+ITH7Kpks0s56GTPAMvbudG4Fs2qofFD51oKfp57QfYqOvcaUwKlV2N3Fcc33WkN+t3wzBhIIL
 sePXEDu2Q/DBpHaP/7SrRT4szOynal7cGEr9iW2VmNX+PZV104pAZl3xA5diSXNQAct27iF/wLX
 n5WtL+t6u62rGsVomuRTV+42HY4nD8eL9863RXBvHXJ5jpNerc/8kq8emmZvklMOWppsgwHMI2N
 S51zQwtLGG7lNLENIPP1ByiQcrvUVRzl6+WO2nsXDy2D4fFJiM+m90n1SUVxArNSgSyLd88tPxW
 rEJsCSZ79VA8h7D1SovsKQWPXhdnKGzpGN8Q4oauUKbrhW1sgC8yd
X-Google-Smtp-Source: AGHT+IFZgM6gRGFMjnsNt2Wjx2UqwjEFcJDQdu+gF+EgRIXnGB6oQmwO28TrguiiFVQfI0QRWy0qow==
X-Received: by 2002:a05:600c:2113:b0:45d:d5c6:97b4 with SMTP id
 5b1f17b1804b1-45f211d4efamr10498955e9.9.1757648585008; 
 Thu, 11 Sep 2025 20:43:05 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e0157cc84sm25487685e9.7.2025.09.11.20.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:04 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:49 +0200
Subject: [PATCH v4 04/10] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-4-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648576; l=1685;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=xWLqzrI5CVC6QjCdUZ5ooEgobp0TTI9162H88qJO6sE=;
 b=M22PFxG0FARaajdQXS3e5mX1aFfQQP+k/PrxNoq+B2onO7BND5wb9M9pcf6j+GAnNHNiBQ9D3
 jOtbH5uY3bOCep8E9BKvilB5NU5PVF/CdDMu+d81aNoctK14yLRU8/i
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

The terminal size of a mux chardev should be the same as the real
chardev, so listen for CHR_EVENT_RESIZE to be up to date.

We forward CHR_EVENT_RESIZE only to the focused frontend. This means
frontends should probably update their view of the terminal size on
receiving CHR_EVENT_MUX_IN.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-mux.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6b36290e2c49f579580d2abb5aa552806f019d4a..4d3d05b82f13e002c766142f9d9c24977b8b9bd2 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
+static void mux_update_winsize(Chardev *chr)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+    uint16_t cols, rows;
+
+    qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
+    qemu_chr_resize(chr, cols, rows);
+}
+
 static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
-    mux_chr_send_all_event(CHARDEV(opaque), event);
+    Chardev *chr = CHARDEV(opaque);
+
+    if (event == CHR_EVENT_RESIZE) {
+        mux_update_winsize(chr);
+    } else {
+        mux_chr_send_all_event(chr, event);
+    }
 }
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
@@ -382,6 +397,7 @@ static void qemu_chr_open_mux(Chardev *chr,
      */
     *be_opened = muxes_opened;
     qemu_chr_fe_init(&d->chr, drv, errp);
+    mux_update_winsize(chr);
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,

-- 
2.51.0


