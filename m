Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51878E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtr-0004fh-ID; Sun, 01 Feb 2026 18:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtX-00049t-Ls
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtV-0003C5-8s
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:30:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso28142745e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988615; x=1770593415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJ2uWCeP8pV22XPIuG+XMR/jSRA5vjFNUShUwB++kLM=;
 b=Bc3UPe15C4jwv163KA2VoeHtwBG5rmZtZ/acFQN9MOQIb9d42B7ShTRjPT9xvfp2Ca
 Gg4vj8vwZFHPGe4BNBm0YMjBTBd7dv6+McwNNiueyRLV2veg1Es642JRpevk6uwVujy6
 Q5U0OOFqb38R9west5RivY2xTGMjGWi6VvyEx/TdJc3zIzOkaErLyEPjvKhrIHsBEctC
 JOBRGqzPP7SQugaxMS3puQ/Z6DpwUdbkDI/9JsXw3n7JKZAXf8W9GQWR09h+0bdfJxqE
 FvGiQgKHIGGpaIdrWiPJooZYnIPjfhp+/m1qIADfe0mw4yVHXnL37lYMct5YoxIMDHzr
 aTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988615; x=1770593415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJ2uWCeP8pV22XPIuG+XMR/jSRA5vjFNUShUwB++kLM=;
 b=YizuhlhAaoYivA0ksyWSibnhvzkrN/wggvUF+mQk5SQTQoAYJ4mSyT+fdlBYKZhiSv
 0QR9LS0S4RUrbjLV+aPh80QckCcB/xHTyTIZXPXOeRo153y635zb9QeQ/60ykWAtnFf/
 DYYZHqePxZ4fXULgQkenhQXfHA+0wXW9Jod8M7pJTLhmGpHMXPpMm4z7MZMc+VyOSsik
 kZQ7jct18+UPw16222nJ+0ajAOL0lsSfBmsw4ftiTIgxb0dxT7ukYb4xvlj4VUOVxtp/
 0PZi7zXW2i0RxgoY9s4jkPCVV4RovnwlweKwiixHjToVNnl1ra/uAjaH9tIbZANDjLJs
 xdfg==
X-Gm-Message-State: AOJu0YytCevOuTHGBXRlb+m0XubXptxrfyjnHdqq1q7LAcmaMKzhBv/0
 BcxLSxsMVC3Lg5UMFmqEzT6tdkh8Mt2aui5exI31CPREuWp9ZngloKXcrwflX6aA7cKcmHcyKoM
 8fV/b0b8=
X-Gm-Gg: AZuq6aIRTu+7XdHpzdVkrqd+xGVQb1JWd2poOR4NVwH7xcAqk0gcpnUk+DLy3oNg/6j
 3B61sgqtUxQONOyxLOMWAGa6J5mXml0KGYq4I254drwBvBogWNmywplNVuVcsGunz78Xa6/NtxQ
 992DvlpfcYGBEJPZU+R+LYq13YX95wYKvrNlH0lsTMH/X3aS1GjgrkW09NBjzI7HJD2ovFlusha
 k/vERrg0sbAVLPIAHHtM1rO4QsfYvY99i1un+vx6VVAYS8/HFeUMY8f5WOP28nzN3Cv7q0z5t8S
 7wcRbB5QBwpO9dimsQ8yWCBfiEEkHacI1hqRIb/HQKlPYh5mLbQ5J+xZvgALMlc5WXrLw4yP9dq
 sMbsWfD/5wMiDBTT749jF94A1e3mS84ohSQUZq7i30u4SVTxxYnz6n9951nzbyOJcZpL+Au0PEz
 sk+vGTNoOUprmzKBXuey5CmU5FsIf2ktKNeVIPft8xt8Wwmh6jsIQsR94+0G47
X-Received: by 2002:a05:600c:474f:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-482db4576b0mr147823285e9.4.1769988615470; 
 Sun, 01 Feb 2026 15:30:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e256f639sm73915185e9.13.2026.02.01.15.30.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:30:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 07/11] hw/virtio: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Mon,  2 Feb 2026 00:29:19 +0100
Message-ID: <20260201232924.93399-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d64ecc29a89..9c5563f9bec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3243,15 +3243,14 @@ static bool virtio_access_is_big_endian(const VirtIODevice *vdev)
     if (target_is_legacy_virtio_biendian()) {
         return virtio_is_big_endian(vdev);
     }
-#if TARGET_BIG_ENDIAN
+    if (!target_big_endian()) {
+        return false;
+    }
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
         return false;
     }
     return true;
-#else
-    return false;
-#endif
 }
 
 void virtio_reset(VirtIODevice *vdev)
-- 
2.52.0


