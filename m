Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE5D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0u7-00021w-P3; Tue, 25 Nov 2025 16:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0u5-0001tA-Jq
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0u4-0005Ip-1W
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso1525285e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107330; x=1764712130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TqZ00m1dp5ykFypA1defAPknRVwrY3XHn9VogXTLVOs=;
 b=PRfJAta9L3IP8sfsjDttSFZfseAhydNVBQcGjc1S9hUY+4myBpMpvI8xZdiwIb/lRT
 6cr/EYhgmqXA4/QFKvf9jfI7M4blvav3BDzIIkNUkmHmXW6ORxxOUwS/Wg2YFTlf/XVW
 As505wuHNTwAT0UUGXQegZ6ZvvlW9UCW4Gri4m/3Y8qIZGhMoOTY/5qxVd4tv/Yo41SH
 cFtFZSohVaCk6hhZTsf18/F/QU5Siwj9QRxjlxnybgwtOlNP1EpEnsrZObulc3985xxW
 bY+dtk8AYEVd4ZzzuEQd3ND9mFUUalHpenHk/VWgOLukR28cteCT9srp5WGdGlErrTzF
 YKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107330; x=1764712130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TqZ00m1dp5ykFypA1defAPknRVwrY3XHn9VogXTLVOs=;
 b=cgRPgZmLANdBODMXr418vItToM0/xrqMzx9zKtScuGnYbrr44/OB68B8I6Y1Pq2kwJ
 eFAHhdHLRsFv1EmO5tq3HhmBHp1zpQJzAkJ643ajCTpVRbA5P2O1sw3+Y767tiSbzDXa
 nVxexN5AB6WxIlD/mf9rs5x5MQ3oREAT+wSXNJxnmVhE2MncQ7pzttXCfHAjQ0EOgCSl
 KR4r/gE8mrL7lGOgdQUkaZVGjxym/Qex5f0x3EiWxrBtdtA3VX7wmQ0NnSLUnbRatpvH
 2ijeeejVdgr/uMP2qY9bWOoVHIrtdZN1GQvuSaUN2kHDMfIAFunTUSVCcoPDiTdy6pRM
 jnPA==
X-Gm-Message-State: AOJu0YzfmHdlOcFRTmmCYHKCtpjU5n+qC9gX4856dWG41iaRhIkEf9mC
 nPLidqclcbF0aHzU8X1ngqBHeFpnzbXs4T4ukdnuhL4lKdx6ygRFWBYLqhoKmlm/u9aBrpVJNzJ
 OfaLZsDHMhQ==
X-Gm-Gg: ASbGncsHiDs8WL+vfJKd+mjOMJeEG08mwbR6u4uw7ioUpy0deKF42KisZ/WOT0f1tIj
 +YcNEIxPIBey/9FDCiW2P1r6+Hq7XhRX5rP2AL2qxOdqKquQ8eG5iXH5P23r2EbtkO5elBxR+QU
 MpO9n+26mtN3UCw7+vjM9TavUlw+6aIf7PlXf4KhytedX8DRHp0NoxZ/R75wJ8/AphQGuQIGk2I
 54gx0T9Y3US/GtnAxlfifS0pkIQvZtN1ypDtXRkbNnMJuoIndNSKqK7925xFeNjqf/JED6h8gC3
 QWdmTf5wxeG7QHgPCXW2Z3yIVEd7RSL65Qt9WJf2Q2kyRkwR1iMgyKYkpVh2zCK522VogjN9+9B
 WM1UK6xmJKmlTChJ3Jurn8QXXaTo6vsBKelFG3IGaRMarUKw/uD4xX+kaAKAG4Wx1P/HxjGArga
 ZPBiIUrbOOcO1Ec8loP4e+1ejpfxVgLR2TVjfJnVG+hiz+fVG4qNUkatRt6v2B
X-Google-Smtp-Source: AGHT+IEB89Kx8FICGKk1uMdkc4zzO4l0fjvVDLf9NlDN32Z5tPSRKUFq2tDjKFtnqgnzAYNpILDq7Q==
X-Received: by 2002:a05:600c:b52:b0:475:d91d:28fb with SMTP id
 5b1f17b1804b1-477b9ea35fbmr143250905e9.4.1764107330113; 
 Tue, 25 Nov 2025 13:48:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790addeeaasm9836885e9.7.2025.11.25.13.48.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/virtio: Use error_setg_file_open() for a better error
 message
Date: Tue, 25 Nov 2025 22:47:58 +0100
Message-ID: <20251125214802.1929-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

    vhost-vsock: failed to open vhost device: REASON

to

    Could not open '/dev/vhost-vsock': REASON

I think the exact file name is more useful to know than the file's
purpose.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251121121438.1249498-8-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vsock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 107d88babea..7940b60d8a5 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -153,8 +153,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
-            error_setg_errno(errp, errno,
-                             "vhost-vsock: failed to open vhost device");
+            error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             return;
         }
 
-- 
2.51.0


