Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C97C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasy2-0007bC-D7; Thu, 23 Jan 2025 03:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasxz-0007an-B0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:35 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasxx-0000XQ-RZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:35 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so1321963a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737622412; x=1738227212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzRKVy23X6eiO9l+v9dWXa+pvd4BNlaJONdpbeQcmxA=;
 b=eH3o/01trXqWgWFbLT8U/o5mZJQW8Ym4nAoNNACNdgKKRMavG0KEulAA/M9Lu/tQ8N
 MERUwZ/EoQV1ILFQsHCF56m09J2bwpudoxgySFI4GZEk1N6heHT88stiodJBhWC5RbpR
 52I9xfLPuQzopCxhIgFePGg1psjreMfq62WGEPfCKZHH/9L3u8JaxJUf0aHGo8b2gt8j
 BGdgHRVU8Fpr0aEPCpeYH6sDjx5ciyxYBhzOjoaFT+eXMqTnJXKHsNZhVLB0A5c8jbfu
 ygDDtsOIf/5G+trfVt235qULoseXg8sRvldL3hUDsi1bOnn1hEIrLrh+qVtEyXMj89Gd
 jFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737622412; x=1738227212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzRKVy23X6eiO9l+v9dWXa+pvd4BNlaJONdpbeQcmxA=;
 b=lmPoTMMYbu5PXgVBVEIlc593Sg/LUl2pqhCxJ4NR3j4xHqLvmqmS+mbI/gXJjoIIaT
 CMNvoojgDvwsVvREJDSfDdEpZ7gWaREgEznUhuShR1BbC/3V3zmQHOx9zuUq7i1db8OP
 sJv204vvo2vkLDAWWNdLofGABHM7dCWBWPBXvAXzzHKUcUcepHiefWwXDUi8J78k83sU
 lXdRE7pAqRfBKt0cln22IPqe7d4TihIBxXKwMB+wKRJR5lTr5mhnKmsUCT9K9xlav5sZ
 Hqd+By0Cutm0fDxXS7X4nMrTtC7SOailv3E1TgbIKhGbR+SeAku0OJ6FJmnjMgbSLQg5
 ObEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxgulcYHgBHmnNQ7oG/OI5TOa66X9dki1wNDStyJM6QwMCC+STQ6q6yHp7GY/pUazOWQYnpkdqYbgA@nongnu.org
X-Gm-Message-State: AOJu0YzutUTuOF6mVeQ0wF5ErDNTljPwHu6m4NL5B9OkbYFt7bQ3HMQq
 Y78YC5uPWS6GVP7MNRpF7MlcEfH4NBnv02T/sM80543PEwQOU1u6
X-Gm-Gg: ASbGncvcE6B4AA4CGSbwUN/fCjUmIWCcYvk4g1id05DDBpDP5xIWyUl318265lNXele
 umuXSoc3ltkAZqjt/HN2RFic0Y/u05MrmktudShZxa+ZntqWg78OKQvxwC39v0VWb/uy8fU2FfT
 YLu5ZR6TTEUeCrrhuRepe1gYep8ly2lMMaXwQkwOY3lFo35szoAMu32euAeUy6zThFLePcUElR1
 6HxPIXmI3pKi4/C8CwO60wSo1fNNk9M8wLwf1HqL8cEU5ZeF0/6thASFLJkGLcTBwi9S5oImCV0
 JhtjouGI1q/k0Eazh7C/QOSRaReR
X-Google-Smtp-Source: AGHT+IF+1rfk7Rhk6Ahzkdt/YZjfObNNFHqN0F2VTkzYVIJnQ8rR9U36x04EbOxYgBG6EuWRs5Hhzw==
X-Received: by 2002:a05:6402:3510:b0:5d6:37e5:792a with SMTP id
 4fb4d7f45d1cf-5db7d2e86dbmr18842505a12.2.1737622411879; 
 Thu, 23 Jan 2025 00:53:31 -0800 (PST)
Received: from think.fkb.profitbricks.net
 ([2a02:8109:8384:1400:b763:14a0:8818:4012])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dbcfb8ff37sm4424676a12.72.2025.01.23.00.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 00:53:30 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v9 1/4] chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
Date: Thu, 23 Jan 2025 09:53:21 +0100
Message-ID: <20250123085327.965501-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123085327.965501-1-r.peniaev@gmail.com>
References: <20250123085327.965501-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x533.google.com
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

Change makes code symmetric to the code, which handles
the "connected" state, i.e. send CHR_EVENT_CLOSED when
state changes from "connected" to "disconnected".

This behavior is similar to char-socket, for example.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Reviewed-by: "Alex Bennée" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
---
 chardev/char-pty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index cbb21b76ae8d..6a2c1dc13a3f 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -181,6 +181,9 @@ static void pty_chr_state(Chardev *chr, int connected)
 
     if (!connected) {
         remove_fd_in_watch(chr);
+        if (s->connected) {
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+        }
         s->connected = 0;
         /* (re-)connect poll interval for idle guests: once per second.
          * We check more frequently in case the guests sends data to
@@ -215,7 +218,6 @@ static void char_pty_finalize(Object *obj)
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
     pty_chr_timer_cancel(s);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
 #if defined HAVE_PTY_H
-- 
2.43.0


