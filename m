Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C6BC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJT-0001o2-I8; Wed, 19 Feb 2025 16:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJR-0001nB-Dm
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJP-0008VB-So
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:08:57 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so114627f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999334; x=1740604134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+Molro6lB3lK8nnwO97GajMQTSCSuF9fx6fEvtnGg8=;
 b=Nny2HWAtohv/y3AB5m1ASstm3LKEyS3Ln8Sm30xNYPCtUWnDd8AYAhpuJfLXNM3sOd
 kJfb7DR3D3EPgqF+/PzQlZzFeXKDBzHWbR/5q3Z0xiAoG+5ZVpbVxdrSzeGpAph9P1HB
 J1aKXqgRWizEjSTMtxGH3tpVMX4cIYMg5uwubUtsAAM+yr6PmzgdyRz3teUo4aKyPf9s
 RfPp0EEZwIcbk6LO+DfdwZDtDqtCbzjFCQ7b12hFuRyRJy6SKEuJuH3+LxvfqfNvQUUX
 2SFgxm3HoDVNffJBw00HcQdUhfjcAjKRM6YgBQYuZu5lYq7ugEURbvoB3UDeUcO/vlgO
 JzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999334; x=1740604134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+Molro6lB3lK8nnwO97GajMQTSCSuF9fx6fEvtnGg8=;
 b=jvG+O3TNpCs9OAeIyV3sepZbKPDr8Jk9K1rdlIKBxB7CJ1I3bMdqGxgmTj0y2gXOSH
 18tgHH3Nf+ElId+KX0P/eHyNBn70ETmnOBWdniJ5BY9xxYU7EhGOvTTinsSBonpPhQEw
 Y2GH+84cViRyHB6d9iln5VbNHzgl9MM/mVBPfntGEJTZLr74K9tg/FoltFVOoeHXD9/X
 EgEMZIooFXPIHWpDuICOG2HQMfQ/Ac/6/5u0AvnS5njzaTqVoQL4WWeTS1NY+k5cfHig
 iBwiPMElAeWdBqnVHuGiotRQwXP7mvUJn2ZBF6rwbx2AOl68QcILtj+nSAapK0XydEHS
 vcDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv0x9RbXqpSln29HjjKCaMg3rPrMDuOXYbi2fnkGc9T3sU69zVfxWFsvHwVbGMl/x4HhlLnD6jnabU@nongnu.org
X-Gm-Message-State: AOJu0YyvrlBwItmoZVcJgl+A6VhXzpCXo38l2/zCT1QJp07QKdWf96gj
 4FRc2euQ+d47It1BTN4o6VVu1L658n6JJpcy0rXCJSQRCvLk1Ziy/CVCV/Cvqu4=
X-Gm-Gg: ASbGncsTAkciy2bYDa6U/8PasHBcP/BsEjqkR1uTq6TFxISq6B2Vr4I/jXSYoo97qEf
 Hw2/7RU7dr61hEgYp0ksw87EcVRZZ3Asavh+80L9yeKmXxGfPzsuDJPHKoyGKVcPrehVDJ3hyy+
 D7Ahaymm2jNT4ifqbKNoObNLtQF9vhtWBffvVG5m/pcOzHZKTBZhC3GKSvaE2tRNUyi+zDwx5fo
 1+pSZEi3oicsF9ITaQogTWOQ7XTiSZSuZ2iNSh/3hb9+WBhRbpk597OYxdvsdKWKZPTmHj5/aX2
 P+ZHt9Z/gMkr0MP4Kbi/+g1oAnI5KHmAMbQ/drn6/JUBhg2F1FMMCtnY0oa2stprjw==
X-Google-Smtp-Source: AGHT+IGwngY8yxWMhLwq/KgWntpSf7HRF5XmQjKuJRImATuaSWrYG1I+/eCKEZFC6hsjO91u0/Tffw==
X-Received: by 2002:a5d:47ac:0:b0:38d:e15e:17e9 with SMTP id
 ffacd0b85a97d-38f587e4e64mr5506069f8f.35.1739999334316; 
 Wed, 19 Feb 2025 13:08:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5655sm18812959f8f.77.2025.02.19.13.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:08:53 -0800 (PST)
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
 qemu-arm@nongnu.org
Subject: [PATCH 2/9] hw/char/pl011: Simplify a bit pl011_can_receive()
Date: Wed, 19 Feb 2025 22:08:34 +0100
Message-ID: <20250219210841.94797-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Introduce 'fifo_depth' and 'fifo_available' local variables
to better express the 'r' variable use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 60cea1d9a16..bcd516d682d 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -486,7 +486,9 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    unsigned fifo_depth = pl011_get_fifo_depth(s);
+    unsigned fifo_available = fifo_depth - s->read_count;
+    int r = fifo_available ? 1 : 0;
 
     if (!(s->cr & CR_UARTEN)) {
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled UART\n");
@@ -494,7 +496,6 @@ static int pl011_can_receive(void *opaque)
     if (!(s->cr & CR_RXE)) {
         qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
     }
-    r = s->read_count < pl011_get_fifo_depth(s);
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.47.1


