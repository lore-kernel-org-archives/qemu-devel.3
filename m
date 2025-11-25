Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AA6D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0u2-0001ko-Az; Tue, 25 Nov 2025 16:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tq-0001dB-9S
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0to-0005G3-TF
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso1987045e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107315; x=1764712115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2IIA1n/JeVNTSE3MnCSqO40c5B5NHTi2Pu8G8dVM3fg=;
 b=DK9gyFtYGUptN5JIlTsiglym8aQelzQop5CrgGaODWG1JJ8WlDTSigICrKHxOvVdaE
 fdc40mRjW21rsZ+YhzALSue36K5CD7wSxAZeH0IV/ru2Q/Azk5JAbdBfYfzMl1N2sqLe
 8a2cNB1uDHGahv7c3weDXvHxxmKGB8fuhWthvJdl2WKSAQHVIyKtOMgrRN6Gb6hZfOSF
 9Af8kqg927LIVtUcx1gxERzBdXSG7ZBvkyz/nSgDJUlftizknevLjxt6q6U5ijecIIOx
 v+l1zct4Ngtopzk32VVwvcekGARMh5S0UUl1TZl57h0LkF51pm9X32SoaNoRRVXdtmlk
 o/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107315; x=1764712115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2IIA1n/JeVNTSE3MnCSqO40c5B5NHTi2Pu8G8dVM3fg=;
 b=IQ4wdt/jsgdbAMu32Lf8XjrROF9t2LHSlSyjlLSaVgJEnLzMcmPNJOXslVAC71UE9o
 muBJ/eMcpTOu+7R5RE1mWnWJxs00AOupJYSspQIdcoPZKdMtmaNZjBwDVVjzTYv+9qLA
 Y0dpr7yOpFCXszRrEmjJhKBEYiGw6EM/2QZKqyq/LBzNCYzfLIsy95kxqmYJ2UdBm4AZ
 elabZpwh/UqrVp6kIy8RYKMU1lrCWWWOHY0i+PlZGBPLokOuThtncYbKLCOW8caMqHbw
 tYfdQ2oMNJjLJpVlxen/PXmrpvQs5joZzlj48EAqsFrJ+iqZEsF9vzaxrYVfSo6YZfnh
 9b8Q==
X-Gm-Message-State: AOJu0YybXEetY0oZjr4cPscqqGx5JD+wp5CHHLe/SSwkCyRQmR6gCqwV
 lrsUJ3ANkBdbUSyFMyttBoziNLaqAXlg/Bu/JCNDJ6PBOHef1mD1TKEMT/8ikzpbiYARybCRZam
 r9fIfgc21KQ==
X-Gm-Gg: ASbGncuzLdUjkVLOHA4TAe5X8vTbLW2zxfXpyXt9Tu7wd+nWOsgiMMHLHSdUQ7UCoNd
 FZdeZYiFlti7K8txls6p+xCwPbhUtMGTyreNm8oW4sECcbMCVF+MHiG12SHSI9uXzgdVxOKgfFc
 I6Cwg6xPniPGzR0mUuQJPgZcnk5BN7Pizoaz/hiXqQd3J1B9POwXoiNpuROKvtccLbYLJ0QmyxY
 tt2Oa2CtRWXc00fKqJfx2VYJs/5kzYG9290ve96kz3TEYxyZBM39/jY3ioON3F7KA2D9KRpjSy3
 XhuVY0PqiluZBuK9lRsNoOQU34jZvDT/dwobYFS7k1FYXPS3m+lXVIjvXJEx1UN/tBRv8Qlmv1U
 Epk0I11lWAEt31MnDhDwrLldQ6961eyVzBOn/I8REWKFoYQIGcvuzlJPoSmn8VQoa8oHV1QjU6Q
 Whcv8BWo0atT8m13+3/iXll3jqHj0qjNMwBoDxIhNo1I0IYsZv+WCcdfVHhPfu
X-Google-Smtp-Source: AGHT+IEfVTUvQhtQTuSC2MmzPnYvCRU03lW+LIg6HIWrEAfrr1QSJC0shvbZkCh2K+RIDvxIGRGy6A==
X-Received: by 2002:a05:600c:4eca:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-477c0540a68mr186355435e9.16.1764107315126; 
 Tue, 25 Nov 2025 13:48:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f3635bsm37135940f8f.17.2025.11.25.13.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] hw/usb: Convert to qemu_create() for a better error message
Date: Tue, 25 Nov 2025 22:47:56 +0100
Message-ID: <20251125214802.1929-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Markus Armbruster <armbru@redhat.com>

The error message changes from

    open FILENAME failed

to

    Could not create 'FILENAME': REASON

where REASON is the value of strerror(errno).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251121121438.1249498-3-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 8dd2ce415eb..714e33989f4 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -259,10 +259,9 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     if (dev->pcap_filename) {
-        int fd = qemu_open_old(dev->pcap_filename,
-                               O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
+        int fd = qemu_create(dev->pcap_filename,
+                             O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
         if (fd < 0) {
-            error_setg(errp, "open %s failed", dev->pcap_filename);
             usb_qdev_unrealize(qdev);
             return;
         }
-- 
2.51.0


