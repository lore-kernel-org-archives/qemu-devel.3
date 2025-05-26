Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F7C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYly-0003OG-FB; Mon, 26 May 2025 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlg-00032H-TT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYld-0007sg-7g
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvZyFdDkuLWp6FY5Epn837HgIKSyXbzfGWIif8TNWJE=;
 b=EO6yadI5ENJIIir5ihQmhQxdTOfM2RtKXOhX5CTWgxQSgoEUrwfo+vGjKa3UkZaFCRyjHb
 3AXv3N+tKtEfC7s4p7LfjsE2Idc3E36nZLE15Ku1lo/Q/jxMRRNllCOtWQrQMP5+JEFLfD
 +AagCMcdKbsD7QPsoJzqbWG9KerVJXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ZwVFfIeYMlC-YfQGc-PDrg-1; Mon, 26 May 2025 10:25:21 -0400
X-MC-Unique: ZwVFfIeYMlC-YfQGc-PDrg-1
X-Mimecast-MFC-AGG-ID: ZwVFfIeYMlC-YfQGc-PDrg_1748269520
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so11217445e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269519; x=1748874319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvZyFdDkuLWp6FY5Epn837HgIKSyXbzfGWIif8TNWJE=;
 b=BbldnEMfkvOrP/VGgt5iFgrP23b6+jRGRIHHVygCdE7/olcmIfSSpgdpAa5bUA5UPB
 QkluydlNQI1bQRvDCniAe1x2n1smwPQqz06bT1kAh0TlMoO25lFDAxYc7iimYXhrnZW6
 eQAmAgjCkdffag5Mvc4mMrRJUVlWmeLo6Le2PUDtXE/Ir11kJE+Cfon1M8Cus3uTpn2/
 Z6ZJ5dsrB3RFkPTQAq505G5a10Zft2qjuQySBdYvwfcyT64tJHbtjZ8ZtUAGbghBP5BF
 +YSFxguXzgRtPakjFvAYny2reBDlC/Hol6qmi0j0u0NHv+hKF/ZBRyYDFLj0UrtF6z+K
 Mwfw==
X-Gm-Message-State: AOJu0Yzr0CHLP+Q6ypgEg13Y+lpBMszwOtvDtpRhXLTj8qqYVJT6lOAV
 vuLtgRrASxLmL15L/w5+03pyBMVqDzwcamQYCaA+PaGdNpalaw6YuFAPPIKpupPdfNzp7BKfl8h
 4+sCYpfyvIuiFwHr9TOnksETA7ozQIkkJ7ilV6YkNQ34Skydd3vs+MrQ8XfuApmIsYgA+/iGYxA
 mzSobM20P+hB8j5EqHj3ioG0grkKm8ChgbJ3Q/Rtyv
X-Gm-Gg: ASbGncumjwseceeAbAMxgX2JrgOdhvKhhocMBWOmw0YMmXgH5sFGhDSB8kKSxcgsG7h
 CsjxO6v/ACf8q2Wgqusby+bpSOSrSzjQw3WGg67V/ff6xVnrBuUZ2zUxcaHuAaG6YlJ9HoO2bJS
 vixcJAomb5k2Sw6XP0pW1+3uI3QmZ5pbsp1h//K6VO30qCnNF5XiFN8cwbzGzOtGZC5xkno7RqN
 Lejz76IEVd/NwYbmG7o/W/8zwlByCWBeLlwNapdChdpIJ1Hw2jjK5xX/jKc9S/h6+TxYPs9sQwX
 QIX0igLVSPMEDg==
X-Received: by 2002:a5d:4b0a:0:b0:3a4:d0c7:3129 with SMTP id
 ffacd0b85a97d-3a4d0c73965mr5407731f8f.14.1748269519348; 
 Mon, 26 May 2025 07:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDeFahvOPqy2waJ/Pycb38J675xYr5da0aKZ9K1bKkU48AJTjv4Abz7rBZUhS7IgDqU9MYrg==
X-Received: by 2002:a5d:4b0a:0:b0:3a4:d0c7:3129 with SMTP id
 ffacd0b85a97d-3a4d0c73965mr5407699f8f.14.1748269518921; 
 Mon, 26 May 2025 07:25:18 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebd6fe86sm321161945e9.0.2025.05.26.07.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 10/12] hpet: return errors from realize if properties are
 incorrect
Date: Mon, 26 May 2025 16:24:53 +0200
Message-ID: <20250526142455.1061519-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not silently adjust num_timers, and fail if intcap is 0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index d1b7bc52b7b..d78aba04bcd 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -689,8 +689,14 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     int i;
     HPETTimer *timer;
 
+    if (s->num_timers < HPET_MIN_TIMERS || s->num_timers > HPET_MAX_TIMERS) {
+        error_setg(errp, "hpet.num_timers must be between %d and %d",
+                   HPET_MIN_TIMERS, HPET_MAX_TIMERS);
+        return;
+    }
     if (!s->intcap) {
-        warn_report("Hpet's intcap not initialized");
+        error_setg(errp, "hpet.hpet-intcap not initialized");
+        return;
     }
     if (hpet_fw_cfg.count == UINT8_MAX) {
         /* first instance */
@@ -698,7 +704,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     }
 
     if (hpet_fw_cfg.count == 8) {
-        error_setg(errp, "Only 8 instances of HPET is allowed");
+        error_setg(errp, "Only 8 instances of HPET are allowed");
         return;
     }
 
@@ -708,11 +714,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->irqs[i]);
     }
 
-    if (s->num_timers < HPET_MIN_TIMERS) {
-        s->num_timers = HPET_MIN_TIMERS;
-    } else if (s->num_timers > HPET_MAX_TIMERS) {
-        s->num_timers = HPET_MAX_TIMERS;
-    }
     for (i = 0; i < HPET_MAX_TIMERS; i++) {
         timer = &s->timer[i];
         timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);
-- 
2.49.0


