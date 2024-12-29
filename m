Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD1DE7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRniJ-0007gf-25; Sun, 29 Dec 2024 02:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRni1-0006ng-K3
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:36 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhx-0002DA-LM
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:32 -0500
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso10066204a12.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457248; x=1736062048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AM4uNV/hC87i9UJ4aHzCgzM3ZV+ooGFBQ58b2dkPsnk=;
 b=FXsNs7O/HC66T97ARFRsQfdHjWoBduj5p/5E9mHO7dXZyp34ytzXQRl9EI47eeWwkA
 hoC+yQ6jtvgOx9JxWW2Q52wsU7+Ni7coALUJZ8gh0FJ4EmfYyoOsUh/Vh3TY2M6ESPvg
 iWL4MQ1uDcGZ86vhHn4hA6qkI96rDue9VPYSRDAsIPUJYfg3Z4wxSCPRmZ1IIxySEUsJ
 2oX09JVdsXxyCIhPo5p+4mnwC23miKCcDtrzwAAtss6P1xYnN+Q+ffMKdERKIG4kd6fV
 t/iVoZKPx76H3x7MNz0gcO7RTrN0YobLRsSCj0DQIF1NjynDA/diGCBnNxFgmc3lpi01
 AEow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvpesSQU7REPit0PaFZjmXg5jbsSRAn5oDq4L85bqjD8Fd0mlpomVpZMOjbtwyvj5YcSy4tKI4t2Wi@nongnu.org
X-Gm-Message-State: AOJu0YyXf0BgVfgEvELXt8bZ4XAJW8qkXxeNL7El10FSQNWJy8IisXFc
 Qk+StGtXcNsoYMlz1HqRDRmDBJCWEbothnEUqQ7BnUQ97Qwlidfa
X-Gm-Gg: ASbGnct5D5Rrhn7OtrNYAfBaRYlKJYQO7fzh2hNXUwcPrKTE2HU/cg6ROBUYGeqkl7C
 SHR/wtffHyVYxwqGTKHvkGWF+RLIjqZymmSnuq3uTxcMuaplRN3yulHc7IZXak/9OF/lQsRg0VD
 ZLeEzlk9yD54mU30NmvXQ1I6a0146GihV1i4jF8GVsrbCAdZX7v/ibYZVSuWbimni0DtY7lYC13
 esQQcvb8S0t3nSpHax38CJ7JfctqZFqgxnD18FcRzfTrji4DzbLLz9KTVePe1h0oGEw4R7LRg97
 tVE=
X-Google-Smtp-Source: AGHT+IHn0GS6r0K0Za+0S5OXdSsjMJSsfhNYo3t7E+ktRiWgsphoq7ME3UeTeLjMGkYnvHhLfAJL8Q==
X-Received: by 2002:a05:6402:270d:b0:5d6:66cf:2a3a with SMTP id
 4fb4d7f45d1cf-5d81dda7e79mr27146740a12.17.1735457247704; 
 Sat, 28 Dec 2024 23:27:27 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:26 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 26/35] next-cube: don't use rtc phase value of -1
Date: Sun, 29 Dec 2024 08:25:17 +0100
Message-ID: <20241229072526.166555-27-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.48; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f48.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The rtc phase value of -1 is directly equivalent to using a phase value of 0 so
simplify the logic to use an initial rtc phase of 0.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-25-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0f24905525..3ca70e376e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -265,9 +265,6 @@ static void next_scr2_rtc_update(NeXTPC *s)
 
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
-        if (rtc->phase == -1) {
-            rtc->phase = 0;
-        }
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
@@ -282,7 +279,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
         }
     } else {
         /* else end or abort */
-        rtc->phase = -1;
+        rtc->phase = 0;
         rtc->command = 0;
         rtc->value = 0;
     }
-- 
2.47.1


