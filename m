Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2D6C021A0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgnrX-00010f-OO; Sat, 08 Feb 2025 11:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrW-00010N-Cn
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgnrU-0008NL-TP
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:39:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43934d41730so4090305e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739032759; x=1739637559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnDfQ0pDNHjagyoidO1nQy0wbrzE23spPhP9nSEJCp0=;
 b=M2GYL5VJbm3fLpUbuaP+A2IqSlhhpa3F1nFe/LltDcWNRdRaBZsGyX8hOTWbzjTNZK
 Qwo375LO45k2qrXXu0t52+12WuMzhpAxxQ0GVCLC3lG4X7L6QZ7YNd/+tDwrrNTd65Xh
 Du5dCy9ADLHcTxybYGmguEWiRNwwa3k1P16Q6RppbGs6JF5X20jO9XAG6gMjd3h5cw4G
 Wn8litcw+1x+osRn9gV94MR8JB5annIC7pMQCULRJvcBARdfp1K6nQ4tokib6+pdwC5N
 PG9MOL4yKeM9mQoHaG2ilUJCKldwylOMfFnI/yeiFkLf4iRQj6UcyKhpUsoG+E2zjf/8
 /Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032759; x=1739637559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnDfQ0pDNHjagyoidO1nQy0wbrzE23spPhP9nSEJCp0=;
 b=NVFXsCt8J+hOp9pBDtovE/TFwvnruvthk+w7CFXORnYadNYTpzqTxUrj5oc+suXo6c
 YzjbTckdhLPmTqWBplW+hhJqIpxdvunWqy6zM1z6H5qRFGwMoVzmM2wtCrBSUuqZq3J/
 aqZ3K1ywCo+kXcwxjr8mbLslFsVDb62AhoBKFn1MHd9FUN/BPSqf9dWkuBBleg8trHvJ
 onZx7W+1gRBqc2LTy6OCbCyobp2Ml8wSCFuuX6j9TqbS9++PAk4v5h68HvpJy0pQvp1e
 cokhm/j22A2IfqlEiKDm2Z1OD5QjCv/enxKVz6uLpfojL1noV70ySu3Ua8gMv5kjMBuW
 EyOw==
X-Gm-Message-State: AOJu0Yy9MvDzp6zgctooD2m/TscsNhMKx073ErQWtEDtl/KwsRqFdjFE
 jZ41Fa4nk/5h6qJJKS7CpcZQ6ImQJ4JS0Is0d24aM5wv47HonMJnqfY2KIDfScFM1yTY1FnbPkw
 u0zY=
X-Gm-Gg: ASbGnctW3F143Wk8DbyAmnK8V8yDGsQptRBcFfXVGX5t+vGUVj43uIEArkX0OFMWs/Q
 TcH0LfJfrbzs6XEJ6Trjt7C8xlcL83OifXmk+kuaJ3nZN/LGw0mMa6ZjrzbCHHG4pfcUp4wXn3j
 usBngtPEfOgMug8eOCKvK0m8ff7mhACwmQ/O/A18DJO5vev1kaOQvhHaUSJKAxaSrlac1WSDc07
 e54vIPlHTS/Ha9tSjT9/e2BTQq9+lFC9r8oc5U8AWoNYaUrwpi0jbfP99pVmuc+v4WcNToOpVwq
 QydRahpBf8TSqeOrtVddqYbey3rTwXkHJZX3BLahUKbZskdxa5V+zvPYlGCoiaDNbA==
X-Google-Smtp-Source: AGHT+IGtem7OP/J+ciEP6t1sttj6uUucFHKFy2ilA0KO9IbGMYq37p+5gV+Q9tzUmRYGQPuY0zZLXQ==
X-Received: by 2002:a05:6000:1887:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-38dc90edfecmr5468949f8f.26.1739032758923; 
 Sat, 08 Feb 2025 08:39:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd54624sm7410071f8f.45.2025.02.08.08.39.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 08:39:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 1/7] hw/char/pl011: Warn when using disabled receiver
Date: Sat,  8 Feb 2025 17:39:05 +0100
Message-ID: <20250208163911.54522-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
References: <20250208163911.54522-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We shouldn't receive characters when the full UART or its
receiver is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 06ce851044d..60cea1d9a16 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -85,6 +85,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_OUT1     (1 << 12)
 #define CR_RTS      (1 << 11)
 #define CR_DTR      (1 << 10)
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_LBE      (1 << 7)
 #define CR_UARTEN   (1 << 0)
@@ -487,6 +488,12 @@ static int pl011_can_receive(void *opaque)
     PL011State *s = (PL011State *)opaque;
     int r;
 
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled UART\n");
+    }
+    if (!(s->cr & CR_RXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
+    }
     r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
-- 
2.47.1


