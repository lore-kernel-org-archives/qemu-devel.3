Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F3C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKD-0007MB-JL; Wed, 26 Feb 2025 02:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKB-0007IT-Dx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:23 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCK9-0007g9-Gg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:23 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so1081745166b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556760; x=1741161560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSJ5Qdws0UG7tOHwHMA/CtMtB3b08dFPMK/T2yNcD94=;
 b=FJesK+VmL54mLyX1xasiCaovg52o95qOFSMEJHExRGwWO/PDIk6lmbiWJzcII6OQHg
 bX35qRPmI9a9Mc7rWUZLAMVUl0KIu/+nlIohdOolG6H5hNbbEONvomE0lI/pV6C3WNHA
 llGpHkmqHEkz4x2g2TsqMHNrSd9b33d6+0AWyKlrw5qSXyh25aWNgfwAvBpzFsDEVhFO
 ulQcwTFI3faPgOy/ws8kZYp0JAQbxOrTgjJjEOzI/aT9vagJPrH4M3bdNCciBQsGuRSy
 KqFYvb9cLhv8nxZurVupgzrsU5VVM8uog+LZgpv2VlQ1m4sgRxL9+F91JCqYi+Yj+rpx
 7WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556760; x=1741161560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSJ5Qdws0UG7tOHwHMA/CtMtB3b08dFPMK/T2yNcD94=;
 b=v3Ize7VQ/+4947GsyAZzOEHIeQp2RSBFiNTE88uIVZod++mVofoBy8hgjJ9+RXOVB5
 YIax7ZqwFlTHoR4lTOgcGLZ8fzXkiRgHyZXo5yI8JWKc+hawa0XtT3JWV92NFbwUroG5
 fK7vtwPYKmKdAbM3o8td8qy9ZhfvIDcU0ICO7dFoGDKJdxnew3Ey7bgzJbgC4q5m61fS
 btOvQ96s1qxUXenQjXAmAp7XHeZKNJx8OMfTb4TgpRbP02FFKMS4DRdjCNMuk1CIpJHG
 Uz2yG8PRi65dxbmFo3g5xikLcutnB+UFky0H19FMDF/9vAhYUNq/rWoyXOiseJAgO81d
 5/Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLaWoHSXEYziFeb3B+mQFx1An7MKQTct02ChYnE+fm/RmuAy0K+nIgKfu4Kti+dY547g3TGaa6Hc2B@nongnu.org
X-Gm-Message-State: AOJu0Ywynx2qXrr5r/2luQN6b8fKPkWb02JzSIFkxBANOnAR/er7gZYq
 1JigalhjZo5ND3B6XUe/8Fig3akARQzkqcfaRe7vLz6iTNfGn2IhRmvm+w==
X-Gm-Gg: ASbGncu1MV/vKFpRwRBUxfCCJNCTXkVymXLKcCIMmYx83ZMX5GK1yAfLC3NVk0/LBfs
 uS5BM1ts0JnmYGjlnOH+LWx2wiI4K/bxLtHq/PleX0QF4Xhnw4dPi0TxG+hK53SOtJBi2oRpHhj
 vrC9HyX4CCo02QTREaZu1gPqlY85M0iAMdkCntZ55ZGMOyhdP2jIsRrKrYVwol1qURJNHElh1wn
 BjApb/KNxuaVOzeGuIrmVY9OIG8C67EKEKKpaMn6w8TB127C8nOnz8SnS7IPiuVns0wthC2cwnM
 5qth7SO+0ihH/j2slq2AnMUKnoEYUG2KV7I=
X-Google-Smtp-Source: AGHT+IEeaMN92comtl+sPf3175ewhNSPKmK+znHdmzN+rV5Gp+RVIQ0u//9ED09/vnpJYbGWN5NtLg==
X-Received: by 2002:a17:907:6d05:b0:aba:598b:dbde with SMTP id
 a640c23a62f3a-abc0d97e504mr2147887566b.8.1740556759709; 
 Tue, 25 Feb 2025 23:59:19 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:19 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] ui/console-vc: report to the application instead of
 screen rendering
Date: Wed, 26 Feb 2025 08:59:08 +0100
Message-ID: <20250226075913.353676-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
References: <20250226075913.353676-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x634.google.com
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

Terminal Device Status Report (DSR) [1] should be sent to an
application, not rendered to the screen. This patch fixes rendering of
terminal report, which appear only on the graphical screen of the
terminal (console "vc") and can be reproduced by the following
command:

     echo -en '\e[6n'; IFS='[;' read -sdR _ row col; echo $row:$col

Command requests cursor position and waits for terminal response, but
instead, the response is rendered to the graphical screen and never
sent to an application.

Why bother? Busybox shell (ash) in Alpine distribution requests cursor
position on each shell prompt (once <ENTER> is pressed), which makes a
prompt on a graphical screen corrupted with repeating Cursor Position
Report (CPR) [2]:

   [root@alpine ~]# \033[57;1R]

Which is very annoying and incorrect.

[1] https://vt100.net/docs/vt100-ug/chapter3.html#DSR
[2] https://vt100.net/docs/vt100-ug/chapter3.html#CPR

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 90ff0ffda8c5..d512f57e10a9 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -617,10 +617,9 @@ static void vc_put_one(VCChardev *vc, int ch)
 
 static void vc_respond_str(VCChardev *vc, const char *buf)
 {
-    while (*buf) {
-        vc_put_one(vc, *buf);
-        buf++;
-    }
+    QemuTextConsole *s = vc->console;
+
+    qemu_chr_be_write(s->chr, (const uint8_t *)buf, strlen(buf));
 }
 
 /* set cursor, checking bounds */
-- 
2.43.0


