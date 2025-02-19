Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C94C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJO-0001mj-Hh; Wed, 19 Feb 2025 16:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJM-0001mC-NV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJL-0008Ud-66
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:52 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43996e95114so1159785e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999329; x=1740604129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnDfQ0pDNHjagyoidO1nQy0wbrzE23spPhP9nSEJCp0=;
 b=vBLZ1eD/MQanhYw83jq+bbRduIN0Y7xLqD3aOhQJ1ImC+yS3pj021HFrUecMntM1Av
 A/CAXJPfP/a4jw0T5hAgJ6MJeKnITnQFKTR8mf0cmQH7SvR+yqStu49QwSqTN49hiKzg
 43GI2hdohHoAfuoTe8zQL+uKj+pCsrQ6SCbqo+5z+pqQUB+9zrxJ4kkkvW9CVykjl53D
 cAxbuz+O00rYnjMBv8s45r9ujrtfDtRgV8Z+Nc2+aJd3I9NFuxAYag0tR4ACB0LBq8IN
 5u8Sohkc2sqOugSBHzhWrYtOFnuQGuEd/yVdx9qbVwx+nmNZpABDRr9FBO14aVgWgFlu
 U7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999329; x=1740604129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnDfQ0pDNHjagyoidO1nQy0wbrzE23spPhP9nSEJCp0=;
 b=mojrPp37fns/+ScsEHQHTzhcDioCnUkhVI+kS35Qj+FtVA170psXrsFhEN7ABjZXoP
 f1FQooNzYMsyBorPhzj1rV7iVN7ITLuz5XDa78cnn5eFLuSHu5PeTHSwwIIvgGqC7tQV
 oeCfvciYqrFqJHBX4xeHQQqi376/9A8h3Y0P5zNNbM42ViyEa6SghGjx+wQWpg9ZJSDw
 cgV4/P01dYjqoIc0zK3YRPliex2PQGd2iUc1L3Wq5frzwvTBEqDRWAnoxcspguaRQxRA
 bFPVIwHa+fIxE0x02pYicj+Xt5HvkpX+REM2HyufYGHtL7emUxoiJYT2+n6OuM0amMoE
 u1mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrnggGxvQ40jCD1nHpePnElgVfMWe8kphafn/iJLvYl+MUfbgDbqH43/wvj+XGU5BlisMAzdyAjBye@nongnu.org
X-Gm-Message-State: AOJu0YwtVSgSCaUt3EYgEL7K7EXjpkUsDGdAUfzxLzyiGF6sIvpRC+Kg
 SpgAFtqQgqwyQHYn64coAW69t8RlmUJQ+dwu2Nmcc0N2baRYyqlm8uopLIWwGLU=
X-Gm-Gg: ASbGncsuzTyG/VwmJ3IVwfSEmMexlEoxYXUPpoynZWXs7I+HVGAHV8LJRi9bC9qiZmR
 SoVzrgEiJMkwYHreChvEua/ypHv8WH4JkN4gCWWfB8XxeSTyNAex2Iuk5+p47uGyiFY/f1mV0jn
 0a9srhGNLWtEiTxkavYvw/rnwShdDdNFXb6sOYpC2J1gDbCxLwY0TdyQD1JL9jMajahO6ytXk04
 V6AhJZ5ESgWcP3V0U1E9XJ6oDFSRjakkR6V+uWHQsqA3p5S0/qtFafRsoqQf7dwxjbe4AWYBnr2
 tWb76VlQK225XePhPXcumItLg8iT9V12uEXBQ5E84A/CNnimYaX4eVEIv6MAcE9hfg==
X-Google-Smtp-Source: AGHT+IFkA47+n1j1DG2COTtp0KDSYC++hjSRKaos4pqLnwlps7JbruZUJquCqI0DxmNT/FpiZUB9lQ==
X-Received: by 2002:a05:600c:1ca8:b0:439:8a44:1e65 with SMTP id
 5b1f17b1804b1-4398a441f98mr114220365e9.7.1739999329390; 
 Wed, 19 Feb 2025 13:08:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399b430912sm30933125e9.0.2025.02.19.13.08.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:08:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/9] hw/char/pl011: Warn when using disabled receiver
Date: Wed, 19 Feb 2025 22:08:33 +0100
Message-ID: <20250219210841.94797-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


