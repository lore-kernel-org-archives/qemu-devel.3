Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A6C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLO-0003oz-66; Tue, 30 Jul 2024 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0003fW-Mf
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLJ-0000Z2-Aj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so15413695e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332428; x=1722937228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6/3KP82EfN4i2J5+6pe3rVQ72AJnXOfkdmQBvmdb3yU=;
 b=R2Zve7nP4fw3rYQjKqgcHxi9Fmgu3AzYtnWU1G+ImKs1LvLe6My0Jl6PBQVlHHH1oR
 o1+FKBIfOpA8jDhU0YvNY4PgseTwEKeTL5kQE1tCf1/DSNBXB3+U2a576HHy1g+fhExZ
 RKvBufPd7xBofARuH92M6Y+WfriYv1s5EgFHmy8U72PNPNIubHUMXpltSHXzBeNrnZQn
 1TU+an9dqygOdaP84Xyqv/c6oXCkPI2GFHvZ2tLCtfIH8dmcrYJJGsAS7Iz821dl+TD3
 5sMfLWMooc0qkZRIhE85Ol7hQ7TpADcehq9xml+MgqnbyG5sU9uqy/EMRZgTDXoi+rNQ
 GCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332428; x=1722937228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/3KP82EfN4i2J5+6pe3rVQ72AJnXOfkdmQBvmdb3yU=;
 b=A2C7VL+Z+HaEuL3/2Lhe6ZCJHqKgsrCihKM3GUeuZs74lN/QXkvPCIKq+L0ak/IiVr
 VDp3rHKq3R1RhrPXj1OIZ0Ut/wae4QJ2gTyBBSaDsuLhzoE5SsRam7Omy5rAR4+ufiqA
 m+aAHaFwOGJNEYrDxSje6zMltMrKsJhoM3Z26m7OFOq1EEWpAthcBFkOQMXId563e58o
 aKEcziOHpiWIcN1lyRYq6B3glzZdiYv9uqPLaq7f4b/jE11LP0WStVlbwdRNULXhw/eC
 4gd/xhFuHQX7a3u+ojYHiWu9Si1pnUlKX4BAXP0EphWoQyOCJ3wQGo55UIejpezsLaH9
 lLiA==
X-Gm-Message-State: AOJu0YxXwDTBKOE8SrNJyi7QtY3RrtjCQSqhai2ZjcS3pKyd59N5j6BR
 S2DgaJhS6hgHZFoT21zRVVfwKzrhSUkiNPOcFVY0XECVzqxH2IMZcj8YptN+BweZq2dWYYg9aAB
 d
X-Google-Smtp-Source: AGHT+IGYVooqxJ+G45vtZ1YU2jFN7xRAVkA1EhPZyw1n5kkPYosg2ArjqAevuKqaZvL9jRIkc0vSWw==
X-Received: by 2002:adf:f8ca:0:b0:367:8e52:3bb9 with SMTP id
 ffacd0b85a97d-36b8c8e9a69mr873598f8f.22.1722332427858; 
 Tue, 30 Jul 2024 02:40:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] hw/misc/bcm2835_property: Avoid overflow in OTP access
 properties
Date: Tue, 30 Jul 2024 10:40:08 +0100
Message-Id: <20240730094020.2758637-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-3-peter.maydell@linaro.org
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


