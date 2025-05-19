Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C6EC54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3L-0000bm-Cq; Mon, 19 May 2025 00:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnH-00055k-Cf; Mon, 19 May 2025 00:08:04 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnF-0004BT-Ej; Mon, 19 May 2025 00:08:02 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso3032599a12.1; 
 Sun, 18 May 2025 21:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627679; x=1748232479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qi58OsTABBr981B/8AZV6yobLaS4vDssxw7naPBl2U=;
 b=F6O7KY7C9mvLbeDWQuHISTwjJAVVEXuF54dh+ghqzGP5kGxZKsbWV0zdbccrSSHdwh
 XYNobNzp6IMLzn3iHGnawrvlW6rcq2ucIKpdgR8S14rmmXTjjLDc+swYlu2KidPtj1ng
 DfQgk2U0TBl7V5Yn7TXXzIkyQCXtY6gg9goxo5keFNl1v/xp491v2un1w3rMhxJExXKZ
 1Ck5ftpVIxHynit+JfLta1vnD4nFQPINxnf4Q+dC4qdHyuhk58Mvn8UptmEfsVz26Nyt
 FDENhRZYHyVAVNRko8/fgNWE6KEujLf+niK8Lol7GygAn9AGndSMtoRihw+mm3x5zTjy
 Xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627679; x=1748232479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qi58OsTABBr981B/8AZV6yobLaS4vDssxw7naPBl2U=;
 b=Z9udmPdRo5y64wBai/Ym6dcY2x23iabt4N9T8uryEnF4UFepP2jinoc39EzJgPE2Kv
 LXRO8j7ml+qpQW02tZIJfV/KlFAGhWCjVTd+iWA+bVkDbkhWx2JQ9M2rULgXaLbSOq5E
 94+ltEbnGE62EbVmVAiqZGz1QfTKWl7qgcfLJx5nXHyATXhh/oJJ1mzDMScdCF4/ie7h
 gj4tnxPXTITAX02cqmOcU0/w8XrhwYRciEeAiZSuPxEsQJPvrgwPKH/fXpIsfLFC3FZJ
 xVlwbYakio2f2sDP/NN2bbjHqx8qDWyrKeKbxiIlMlZ3CyKpsYSlfHCSi7Z+v3gPbrhL
 t9Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXpuiLPIY8qWIANdSQTmmyC2TdFdltLZVtlG09cZ0Pe4UcMMvIJ7rG4ob61xpGOWMUo5LNuBXbMIiNJg==@nongnu.org
X-Gm-Message-State: AOJu0YzHMrPpJIxGoFouavMvw2xCqyBWEbT2J7C1mAUDM93oNeZnjNLr
 KWOB43C7qluhCaciWAyGRZVFZVX5HeMfONYWDhm/zkl/NTT1fZCM4/pmAWsiZA==
X-Gm-Gg: ASbGnctM5wXxsFjZ7Tv/u/0D++GfDgH6t6eh6StqC8Vuc3JxJ54fWqWNhnq5ZhNIgs5
 0YT34oeXPbSaGNiNdelvgCI+BfpXjEjYfbP8G5Vt0DTlLu36dutDCHZEkGXwAMPBfwRSGP1sKE0
 r614sf0XrBvSfxiiEMexR4C8752WXwkhaiJvaMhmfwq/EgjIDjhgnop7lRGwz+zNWyIDuUEhyYK
 mr4gn8xyU6kanPIbVbAO1u0tyYzugUVsN/tdgNyvteZq++qoI0PqerLm4zvVoZbH/WFTQFkYJUq
 AuYozWGCQ/Hs5pka7qVk/7YHgsrASpSH3YzR4qn29bNOZf6fdoDBxkKa3ReuyJzPVLjwyCMH9ZR
 0xHIRTWikl6cN9+ZUMAhxH4gK9SJURzJUwIAJlnz/zsZZLotCq7vJJeIx
X-Google-Smtp-Source: AGHT+IHKmb4D0nfIS1CHukiUDBdgupwm+w1qzLJ7ucRLuKxzcuVW6pNInR8p3PeBQwGpqEb7XLqr5w==
X-Received: by 2002:a17:902:c202:b0:231:c89f:4e94 with SMTP id
 d9443c01a7336-231c89f4f9amr147373365ad.21.1747627678692; 
 Sun, 18 May 2025 21:07:58 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 17/56] hw/riscv: Fix type conflict of GLib function pointers
Date: Mon, 19 May 2025 14:05:14 +1000
Message-ID: <20250519040555.3797167-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

qtest_set_command_cb passed to g_once should match GThreadFunc,
which it does not.  But using g_once is actually unnecessary,
because the function is called by riscv_harts_realize() under
the Big QEMU Lock.

Reported-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250410161722.595634-1-pbonzini@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 hw/riscv/riscv_hart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ac6539bd3e..333083a4f1 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -104,8 +104,11 @@ static bool csr_qtest_callback(CharBackend *chr, gchar **words)
 
 static void riscv_cpu_register_csr_qtest_callback(void)
 {
-    static GOnce once;
-    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
+    static bool first = true;
+    if (first) {
+        first = false;
+        qtest_set_command_cb(csr_qtest_callback);
+    }
 }
 #endif
 
-- 
2.49.0


