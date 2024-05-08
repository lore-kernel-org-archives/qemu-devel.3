Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C105C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNG-00014V-BM; Wed, 08 May 2024 13:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMk-0000TL-Ec
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:14 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMi-0007Oz-SV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:06 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52006fbae67so6405735e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190363; x=1715795163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3iYL7NrK3YLqicig51htgd0NBJzLG9cU40QkiClpvo=;
 b=vBg/ihLUYONPmDIgZzQMVzAQWatOVPUNTqpDCGqFBwZ2RZ+F61dfyGFZV9KGrzoBja
 OdoHUc1+wXuW3nEEfMSzW3smCme2pvx3cM3H8AlhDQ2Az1w5gVDSyW8LPym9dBgD/iLT
 mUr+/627HjxB9g59xgx7evuN/iuI6ngoNOc8r1XbIwA2040kOXwWPRaPOCjteR9r+sgE
 ArGkNqZod35zY7QoJmaGjdqGw9SYKfGUGgE6e3vDQW6wPpyGquPN5dQzUIreLikDJA2f
 zEPMnujSzb9ADtWMcaN/1ZiTVC3oTCVxGKZnISTpKZ9sPHBapqDUEbpRwcACjmxwnz1n
 Z9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190363; x=1715795163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3iYL7NrK3YLqicig51htgd0NBJzLG9cU40QkiClpvo=;
 b=cwcFgi9bl/HU++Btnhs43vKsTbwD1FdfYVLzaRJS6WW3gRYijeVT3vgX5e7oyrJNtC
 MEFXWMibsNxQ9X50qZX/gV4b/tr5lyDzWCpv1g2TjfYnA0VgQEM82pHgNtahdUP+cwxR
 Swi+R6GXgJb10UGTPS+cVHjL63hIIdvbBDD/NAIM44QJGRHYSAxcTMUFvCo5dE8SuOMp
 o54xSHAZ4DhuQdbAxNDxU8WXzNKDYId7Wmkg6krejqZ5gYM8AoDmzRya7lNC8ZgcXy9B
 sH2fsQyC60uwL9p6uf977eBt+OsyiN8fB/qgdx5qQVKexAf/nS7v+jN/E9ji5EmD9ShI
 9CAg==
X-Gm-Message-State: AOJu0YxKhpcIlciPuhBIwLg/71AA1nw/YfLbqbhmfGY27pnkk72PgC54
 d1Vs7MmxP+/fnEhTUQya5onKU7gJR9z093LO/ynA3gWLTTkZXv472tbTYY4svlLEiU7H6hpMwDh
 C
X-Google-Smtp-Source: AGHT+IGgoFPgSuLdJzWWmK9z4ETnXQ6RpLzaJ6VUGGmiPZJTYJtmUOqfqGpI+sM4ujIoLfARASYHjA==
X-Received: by 2002:a05:6512:3f1a:b0:518:ae8f:b573 with SMTP id
 2adb3069b0e04-5217cf3cb59mr2189882e87.61.1715190362829; 
 Wed, 08 May 2024 10:46:02 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 oy6-20020a170907104600b00a59a86b85ecsm5747185ejb.78.2024.05.08.10.46.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/26] hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
Date: Wed,  8 May 2024 19:44:53 +0200
Message-ID: <20240508174510.60470-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Thomas Huth <thuth@redhat.com>

The q35 machine can work without FDC. But to be able to also link
a QEMU binary that does not include the FDC code, we have to make
it possible to disable the spots that call into the FDC code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240425184315.553329-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 46235466d7..505ea750f4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -440,16 +440,19 @@ static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
 
 static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
 {
-    int val, nb, i;
+    int val, nb;
     FloppyDriveType fd_type[2] = { FLOPPY_DRIVE_TYPE_NONE,
                                    FLOPPY_DRIVE_TYPE_NONE };
 
+#ifdef CONFIG_FDC_ISA
     /* floppy type */
     if (floppy) {
-        for (i = 0; i < 2; i++) {
+        for (int i = 0; i < 2; i++) {
             fd_type[i] = isa_fdc_get_drive_type(floppy, i);
         }
     }
+#endif
+
     val = (cmos_get_fd_drive_type(fd_type[0]) << 4) |
         cmos_get_fd_drive_type(fd_type[1]);
     mc146818rtc_set_cmos_data(rtc_state, 0x10, val);
@@ -1133,7 +1136,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *fdc, *i8042, *port92, *vmmouse;
+    ISADevice *i8042, *port92, *vmmouse;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1143,11 +1146,13 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
         create_fdctrl |= !!fd[i];
     }
     if (create_fdctrl) {
-        fdc = isa_new(TYPE_ISA_FDC);
+#ifdef CONFIG_FDC_ISA
+        ISADevice *fdc = isa_new(TYPE_ISA_FDC);
         if (fdc) {
             isa_realize_and_unref(fdc, isa_bus, &error_fatal);
             isa_fdc_init_drives(fdc, fd);
         }
+#endif
     }
 
     if (!create_i8042) {
-- 
2.41.0


