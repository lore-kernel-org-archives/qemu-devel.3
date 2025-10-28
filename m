Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB3CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbK-0006Gb-Sk; Tue, 28 Oct 2025 13:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbG-0006Cs-DJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbB-0004cy-LN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReFN2kqAPL8IsCVhHHHqifymfPF4VTb9U8rKSLGrHj8=;
 b=hHaL+yKQcC2yCQ534HO2pWQJhiTREKkNxYsqQ81WKlI4AF09xL/mKiDnkx4sCDxbS1A2gP
 orLJMRsRkS9O4bl6jEgZ6MeR31Fl0sIy9BpUbG1X435RSn0cVnItOkWoT1bhOYAU3x9AlF
 XE+pYdh7yiLGJ0Vnb6TFgp2ih0b8/y0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-FyajIfH6PaCC0txMZ6sTuQ-1; Tue, 28 Oct 2025 13:35:04 -0400
X-MC-Unique: FyajIfH6PaCC0txMZ6sTuQ-1
X-Mimecast-MFC-AGG-ID: FyajIfH6PaCC0txMZ6sTuQ_1761672903
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso4001804f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672902; x=1762277702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReFN2kqAPL8IsCVhHHHqifymfPF4VTb9U8rKSLGrHj8=;
 b=qw5e6/S1c2DQlZx/yRbg/vGkZqifMdvgpVl4kAuwMTe8uSXfYeJvfL/tsspix+rg+D
 jwCfNn9lw48sTHiguBXFfxC+phYFpuDF9FxTm+rVg0x2kkpNWQclxmCoOCrvLxSQ6Wmc
 5jPvJT+8gIH8jHnAL97lUXi1MLdNVRaKmy2AWwLxrqZw5dWx3HUGEDOSw2CduSB6iORY
 moWxITrcKmWFH0HJrgu3AIubKl1dnSdLiC/f0HCHfV5IPrzGvSJYF6iOEZ9oWKDdeXCL
 wZQytC3NqsXXL5gEsqyAz59ksK/bOuQhLXdwT8ffcQqGSB8Fo0KPuQ0+vMFSknFywDig
 ChHQ==
X-Gm-Message-State: AOJu0YwM8mdmZNY7knwf3mK3hFp4S9B5dXKgadBeo5aQwHAU0afR2ZWe
 4woAINfx+uRTTre2iHqwrBP/rcbueJmRP4xgZifMgvQ4G7tpcxiGfxKyKwAD0YgWvR9LKgdmjeN
 HsV4e14z7nYYgAo0QNL2dL7VuMJp6KWocJjkL70k4U9ZQHyPCLSl8pBmlS60mnOoSz3z+xb/+hb
 GTzYYF8ConauAWlablIvzJrzbdILxYVedDySb+Xx33
X-Gm-Gg: ASbGncuKXrybtpiEVxtXJ2mZCHFnJaLAzDuYJA0BEFXdhALaNfugCE3UMCHAf7g7Vu9
 L/Ft5vAS4nKqjQ49SCgQCKV8RS/6c4Uh+Wo50KnbfE5JPXHOJDnmN8M2MX3bfoWzub8NasEkLkB
 8FVb28CtGhoJJNSh/6VOVmYViTBfJLMA/ae3LCxIMQ7wgbsePdJrkzivrbgfZJL+P8YsAzwNRqR
 dFiRLRiOokGJ6dFmDkLMcUGgblKCyNgbippB9ygVyYBMnx33+Anog52Hv0tKfIxhCohTNnW4ho1
 y7xAx2pukCEb0mLkd+s6wWp/ylcgnAE+UmHZW1CPf3ZPsH+zIQny0HsTHwkFMT11XcMbOb2lqpD
 78pZjaybdEjWNlikAqtUtXN29VfCKL4anskeUc4qbTgzvvHNiP1KMPNG3jD6MGmiRTfW8FaJs/8
 wWVfY=
X-Received: by 2002:a05:6000:4387:b0:427:1ba4:de9f with SMTP id
 ffacd0b85a97d-429a7e7343amr3814802f8f.31.1761672902334; 
 Tue, 28 Oct 2025 10:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT2RLj2fWL1AzF73jaY63KL9yuaOhB1rBsQWgDfIzoAohEvvic+cHuNoODIb6MckxK8TyQig==
X-Received: by 2002:a05:6000:4387:b0:427:1ba4:de9f with SMTP id
 ffacd0b85a97d-429a7e7343amr3814777f8f.31.1761672901823; 
 Tue, 28 Oct 2025 10:35:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b6fsm21553274f8f.1.2025.10.28.10.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/18] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
Date: Tue, 28 Oct 2025 18:34:22 +0100
Message-ID: <20251028173430.2180057-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The original calculation in commit 3cc70889a3 ("esp.c: prevent cmdfifo overflow
in esp_cdb_ready()") subtracted cmdfifo_cdb_offset from fifo8_num_used() to
calculate the outstanding cmdfifo length, but this is incorrect because
fifo8_num_used() can also include wraparound data.

Instead calculate the maximum offset used by scsi_cdb_length() which is just
the first byte after cmdfifo_cdb_offset, and then peek the entire content
of the cmdfifo. The fifo8_peek_bufptr() result will then return the maximum
length of remaining data up to the end of the internal cmdfifo array, which
can then be used for the overflow check.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 3cc70889a3 ("esp.c: prevent cmdfifo overflow in esp_cdb_ready()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3082
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250925122846.527615-2-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1d264c40e57..2809fcdee09 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -447,7 +447,9 @@ static void write_response(ESPState *s)
 
 static bool esp_cdb_ready(ESPState *s)
 {
-    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
+    /* scsi_cdb_length() only reads the first byte */
+    int limit = s->cmdfifo_cdb_offset + 1;
+    int len = fifo8_num_used(&s->cmdfifo);
     const uint8_t *pbuf;
     uint32_t n;
     int cdblen;
@@ -457,7 +459,7 @@ static bool esp_cdb_ready(ESPState *s)
     }
 
     pbuf = fifo8_peek_bufptr(&s->cmdfifo, len, &n);
-    if (n < len) {
+    if (n < limit) {
         /*
          * In normal use the cmdfifo should never wrap, but include this check
          * to prevent a malicious guest from reading past the end of the
-- 
2.51.1


