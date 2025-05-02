Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE092C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh8Q-0005Kx-V3; Thu, 01 May 2025 23:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8N-00059c-IJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh8L-0001Kj-US
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:32:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso1785829b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156736; x=1746761536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HVBXIr+NBzPaHLCzg4OvS7X3MwM/imJu6rPVdSQDDI=;
 b=Srr/AOkdD/Yd0U0rnXvqDkgENBIuUF4AY0B2r6U+QJpdelONWMP2+z+UWimPh4KeKh
 9JHahpukseh5fz5kLpCDRKIXodSo1eAJkQYpN/jXNZPr+24avXfqBdI6QUPGOZ/DxkGi
 K0S1artHzbvCtpDtvrKBmzkKoUjj7+sgSWmdH60iSzKD4EPyoVs327M+0PdTefKZmsts
 JixS6xhoaV1TXgMYE39w/1l2Ywo7fsXH0B1N4b/EKy+M9cl5lZwGdF8ZMaWhDf7tjxmz
 VSD4t5jFGuh0DMHzFCPKsTaBIcnt8G3MCs+8DINpKX40rxIb3qIML3GpxgATPRtynamO
 Bgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156736; x=1746761536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HVBXIr+NBzPaHLCzg4OvS7X3MwM/imJu6rPVdSQDDI=;
 b=G2dmwXbqQ6wvk751NLoPttYQOmoEJKzxaEjcvuDY9f0BmAxWNa7lWiDOZ28jtKLnWP
 TlV3NUnNTTl0PD959y6TMbe9kjdfskVLSkyeoqE1G3E195MFsmiIfe1S9xKLnWsXHfZh
 w6tU4YvpbSfDsJroR1i1CpCGch9xDSvQqk72GsWBV5t6mvZGOz4XVvnE6xbSAxrR54Ba
 HiaTz2C+qwBS760uo8uhTocUomVU4h0gS7b6O2UV7FVpx29JvnBGNH+uVpIaT7DFDJ0P
 Ea+VHhVUih/oAoh6ZNNuFHMQ1AVGOcdzeonSIm8liT+S7FrRbWygdvxlgSyTYceK8CGF
 y1xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyktOzlCxavq0r+5j0Q3kCO1rI69h4pEy4N1rxHGqvQUZr/iPz8yTev52+VG4y6pCZP7nGvz6b6Cnd@nongnu.org
X-Gm-Message-State: AOJu0YzoA2x61057cxVHn8TOOuBai96/u6EzN38CE4p8Xdn6zzvuefWL
 wRntj5dt70P75dM4yPprKNjVVasW9PwtUp73Y5pLA+zSWRXKnqkY
X-Gm-Gg: ASbGncvI/GLlgfxhvX80iTJnmNdGy3pwIIAx6M4UYLX54NKv+U2PyoSYtiT2F+01917
 CvfoOZxYUWRo0NSMz+dH1Neu2ZVlxX41iXslchGCfMXROdHD++hPXHwYtkE+MHBj+W1i56uVAEG
 RbFgKv1PHbdwTfAVt0iMBwOI2g6+xOkKaHa1Lx1spaiiHyO+FuKLVsqjW9mrf4ABzHmlBBoXoMF
 7bNBits1VhuZxn3GdVnibOd22urpREtSpbm1M3S5+PPsD9P3/CwCVYJFtY2J+B8ohxT/9TPRjM0
 psi5+dnxfCdlog7hDlFC1z1qKDtVic4sSkzgpcSMn955EMTowqOG0Fw=
X-Google-Smtp-Source: AGHT+IGyAtPi4xyXYIHGt+OQHSSh5M5SnuMk2PEz/T6JNNt51QeQv3YslSZv1gOpro1A+NTdiRommw==
X-Received: by 2002:a05:6a00:3774:b0:732:56a7:a935 with SMTP id
 d2e1a72fcca58-74049265f69mr7089525b3a.12.1746156736358; 
 Thu, 01 May 2025 20:32:16 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:32:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 15/22] usb/msd: Allow CBW packet size greater than 31
Date: Fri,  2 May 2025 13:30:39 +1000
Message-ID: <20250502033047.102465-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

The CBW structure is 31 bytes, so CBW DATAOUT packets must be at least
31 bytes. QEMU enforces exactly 31 bytes, but this is inconsistent with
how it handles CSW packets (where it allows greater than or equal to 13
bytes) despite wording in the spec[*] being similar for both packet
types: "shall end as a short packet with exactly 31 bytes transferred".

  [*] USB MSD Bulk-Only Transport 1.0

For consistency, and on the principle of being tolerant in accepting
input, relax the CBW size check.

Alternatively, both checks could be tightened to exact. Or a message
could be printed warning of possible guest error if size is not exact,
but still accept the packets.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 7bc2f7664b2..fe8955bf212 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -407,7 +407,7 @@ static bool try_get_valid_cbw(USBPacket *p, struct usb_msd_cbw *cbw)
 {
     uint32_t sig;
 
-    if (p->iov.size != CBW_SIZE) {
+    if (p->iov.size < CBW_SIZE) {
         qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CBW size %zu\n",
                                        p->iov.size);
         return false;
-- 
2.47.1


