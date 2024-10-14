Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31962D18129
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxk-0006Fn-AT; Mon, 14 Oct 2024 11:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxj-0006FF-8y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:23 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxb-0000vM-Nw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:17 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539e1543ab8so4276286e87.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919573; x=1729524373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKeU6Sst3mOvcdt2OZL+D4LtHqpR806Hah+uBtunjhM=;
 b=iXwL8QzXU653ORChLABm6U8ob9MLpPYcGPdYao4B6txAVd9WYJ4b/DfqCHLmTRTh1e
 l3ryTbB7IkgURb8cU1cb1FCXulP06pTRYgJNY0lug4UQcLB2trV2Vib5frueg1WKI3Fe
 eyMm1w/aEC8YPz+btBxtuH4IDJz9NuQie7EsRWXco2SFKnxFMWRTGlzxmAiGrWDWXxHl
 EhmpEsrZEJmJfvvgT4hSpgXk+qEJJNR+Nuwzo4XAbBzG0G5bYb/Hcf5DdDHWijXm81kS
 iANyu1IaLXbfLqOrfJUsCspzRrqG69n/9EHUm5PLVpX5jAyuaHyZzplfYPyU9Spl/X+C
 xKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919573; x=1729524373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKeU6Sst3mOvcdt2OZL+D4LtHqpR806Hah+uBtunjhM=;
 b=a7igiki5qNmHMoIECMPkmdxRNCw9814EyqVYh1bT/Qg69fQkC8fYwDkJw66mUDBGoX
 MJtE/WxRCmQV2VSQh0pVFhri5xslHiNZoCF+cpuAt9E+Lr9k95nRSXIVdarpirXS+bMm
 +9cxEKov/jsS1+QCqMyUPh0grUOYJg2aL8HVVcN3AcG7Zcu4o/65Oq6cew9Q7fyyNjft
 Fehd0cWjr5KdgrTM4viuPTw3vl05QnlmWK2Vg5dxCNLXwxGSjwEXIae8Rg+VNj/ShKm3
 D/ee5lKNlZOg5n4NELQw6a46PXAnuPYhxG/aAPDBPMQ/hoBFoW+OMThXaZSFCpSw9FbY
 5S0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQlA7uuSxtcszXjAgmN3UKIMvE8JZXD9SKcxo6odqNyUeaGJaX7HZI19Z/et2oKyXDVXf7MKg5IZHz@nongnu.org
X-Gm-Message-State: AOJu0Ywd03wN+PvSex8v3Y2iFQG/8F3MDyPZoX9ITOdljZWFWeFIvKu+
 WzNmu01UzH0vzLA62CFh9zZFMVTeRBnfY8DeB2AEEYDV6mc/jjQN
X-Google-Smtp-Source: AGHT+IE4ciKO/NO3MojLJ1CjA0IiED4eFypqBKo96jGXOkBCU95BAuF/yVtTjSpONmh7THlS58IcwA==
X-Received: by 2002:a05:6512:33cd:b0:538:96ce:f2ed with SMTP id
 2adb3069b0e04-539e54d7759mr4127106e87.10.1728919572324; 
 Mon, 14 Oct 2024 08:26:12 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:11 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] chardev/mux: use bool type for `linestart` and
 `term_got_escape`
Date: Mon, 14 Oct 2024 17:24:03 +0200
Message-Id: <20241014152408.427700-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12f.google.com
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

Those are boolean variables, not signed integers.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c         | 10 +++++-----
 chardev/chardev-internal.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b20d9b..728596c6f346 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -73,11 +73,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
                  * qemu_chr_fe_write and background I/O callbacks */
                 qemu_chr_fe_write_all(&d->chr,
                                       (uint8_t *)buf1, strlen(buf1));
-                d->linestart = 0;
+                d->linestart = false;
             }
             ret += qemu_chr_fe_write(&d->chr, buf + i, 1);
             if (buf[i] == '\n') {
-                d->linestart = 1;
+                d->linestart = true;
             }
         }
     }
@@ -145,7 +145,7 @@ static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
-        d->term_got_escape = 0;
+        d->term_got_escape = false;
         if (ch == term_escape_char) {
             goto send_char;
         }
@@ -175,11 +175,11 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
         case 't':
             d->timestamps = !d->timestamps;
             d->timestamps_start = -1;
-            d->linestart = 0;
+            d->linestart = false;
             break;
         }
     } else if (ch == term_escape_char) {
-        d->term_got_escape = 1;
+        d->term_got_escape = true;
     } else {
     send_char:
         return 1;
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index c3024b51fdda..975c16de803e 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -39,7 +39,7 @@ struct MuxChardev {
     CharBackend chr;
     int focus;
     int mux_cnt;
-    int term_got_escape;
+    bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
@@ -49,7 +49,7 @@ struct MuxChardev {
     int timestamps;
 
     /* Protected by the Chardev chr_write_lock.  */
-    int linestart;
+    bool linestart;
     int64_t timestamps_start;
 };
 typedef struct MuxChardev MuxChardev;
-- 
2.34.1


