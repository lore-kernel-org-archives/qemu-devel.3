Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A7DC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFHu-0006Cg-8q; Tue, 23 Jul 2024 09:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHr-00061h-Pt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHm-0000IU-Km
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso2853560f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721740233; x=1722345033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDjhGJy1uudDNK18CuZuB7KjPJkSAemQ7/iwEkdj0Zo=;
 b=RrdPzu6+30zuIbQp484MFe5pJaqtTFWPHwaXfTnw1C+2Hn20rGby5L2eqDOtMF7O8G
 HRvWeyC2FMlRuH/g7dlcVdTNO2oHn25oilBXnnwAekgvm9gN9Tsoe5kVOK/SRoOJkQFq
 kuJ0MGlBSDKxuYfndb6slv2Mmv1itYPa5d8FJbOS66HUCr3cQcbsiZ7pcpYE1dBvngGZ
 CBE3DQ77DuLnsPnZeVNu2hY7yL75pIf7TVKWLqnr8o0rbdO9bNaESTe2tc5KQsow9Q3x
 ay9Ws4vGDQ0qioVod2CYj0YoqXFzXX3GYRWqHT4KN6Folw1oX8VsWCVCAxW0uPMF/fil
 P0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740233; x=1722345033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDjhGJy1uudDNK18CuZuB7KjPJkSAemQ7/iwEkdj0Zo=;
 b=L+d9bWlUDV80ycfh+zUy0hf2sBeZCcb4qQGXnirIUQAbdEtsJkTbV6jgdl+G5aNeAm
 XGP4IMcs+fVJmFS42z1XskwVXQZAXmRF8M4lGWGLFnxgGNIJYNPPQOFHatJZ2jcY073c
 scZKmGoeEoX8JslUthuAIqsrTqmm+ELD3ObbJvsmrNmvcQotq5yQpiWWRfHliXm7s8KP
 EP4vfnPewUYmTvG5thQGrD15nc48812YJizS4KljdW5Rwy4n6fQZEtDlLq3DnaixUdWI
 dYat9ZIonyv+zVgCMxZRuYVXVjL2l6/lJsbpp3aoKlHg+5aphAavu1uXb9gA/r3wwdLN
 UyXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkQq7g/xoZ7dqa3AdRad0nAHwnLvQiBPmEgRnSdjAH8iigHqOv/5i5IYnsUuIcJ2pXapd0Eg+lNLJr2XRdQiUGu25oHOo=
X-Gm-Message-State: AOJu0Yxly8Y46FYIGgKzYxisprC7hghdaRmvrfjaxSSx4Hjmri1yL+46
 2XNIxqS//RueVDrI1zQH4m3OnsHSvugNi7KPXlS8ND1Tac6CA7fltT9djBozB94=
X-Google-Smtp-Source: AGHT+IEAfENa1RvpqhWOb4/+XNcHH9raZ152OHoY68lNbEjmwiQBJsPG68tqnK5n228J0dthsPFLbw==
X-Received: by 2002:a05:6000:44:b0:369:b849:61b0 with SMTP id
 ffacd0b85a97d-369bbc69874mr6079499f8f.43.1721740232571; 
 Tue, 23 Jul 2024 06:10:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm11560157f8f.7.2024.07.23.06.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:10:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/4] hw/misc/bcm2835_property: Avoid overflow in OTP access
 properties
Date: Tue, 23 Jul 2024 14:10:27 +0100
Message-Id: <20240723131029.1159908-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723131029.1159908-1-peter.maydell@linaro.org>
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Coverity points out that in our handling of the property
RPI_FWREQ_SET_CUSTOMER_OTP we have a potential overflow.  This
happens because we read start_num and number from the guest as
unsigned 32 bit integers, but then the variable 'n' we use as a loop
counter as we iterate from start_num to start_num + number is only an
"int".  That means that if the guest passes us a very large start_num
we will interpret it as negative.  This will result in an assertion
failure inside bcm2835_otp_set_row(), which checks that we didn't
pass it an invalid row number.

A similar issue applies to all the properties for accessing OTP rows
where we are iterating through with a start and length read from the
guest.

Use uint32_t for the loop counter to avoid this problem. Because in
all cases 'n' is only used as a loop counter, we can do this as
part of the for(), restricting its scope to exactly where we need it.

Resolves: Coverity CID 1549401
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_property.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index e28fdca9846..7eb623b4e90 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -30,7 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tot_len;
     size_t resplen;
     uint32_t tmp;
-    int n;
     uint32_t start_num, number, otp_row;
 
     /*
@@ -337,7 +336,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
             resplen = 8 + 4 * number;
 
-            for (n = start_num; n < start_num + number &&
+            for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
                 otp_row = bcm2835_otp_get_row(s->otp,
                                               BCM2835_OTP_CUSTOMER_OTP + n);
@@ -366,7 +365,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                 break;
             }
 
-            for (n = start_num; n < start_num + number &&
+            for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
                 otp_row = ldl_le_phys(&s->dma_as,
                                       value + 20 + ((n - start_num) << 2));
@@ -383,7 +382,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
             resplen = 8 + 4 * number;
 
-            for (n = start_num; n < start_num + number &&
+            for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
                 otp_row = bcm2835_otp_get_row(s->otp,
                                               BCM2835_OTP_PRIVATE_KEY + n);
@@ -403,7 +402,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                 break;
             }
 
-            for (n = start_num; n < start_num + number &&
+            for (uint32_t n = start_num; n < start_num + number &&
                  n < BCM2835_OTP_PRIVATE_KEY_LEN; n++) {
                 otp_row = ldl_le_phys(&s->dma_as,
                                       value + 20 + ((n - start_num) << 2));
-- 
2.34.1


