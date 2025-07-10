Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01C7C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuC8-000558-K8; Thu, 10 Jul 2025 12:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZtwG-0008Q4-6o
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:16:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZtwD-0000ax-LR
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:15:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-454b1d0a115so4475565e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752164155; x=1752768955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7QvCTXDiPU+t2Q+zwwTwj1QNbnhI7JBdN1hjNvSyLg=;
 b=UZDKtZv8tnfmaj5uQg3m/TnkwG7TOX9Y6wD1VXmzmQshJcpOM4KO8h4jbdIHCKbc0U
 PPuqNYtDqWJ2ZR6Q5YUoyEc04vldsvHIjYS1cN7ulCGnM4Gsp6KQMVrDigcj/jfTOtJ+
 Ud/OGFt2aOEehchTjrQgudLRjiuf+1+ltjHVFzdZ6YpJnF3QEdASxZ0h1N1pC69CdvLF
 wx1uPNbcMZKd+fYGbTgWd/2Xdu/s9Dny5tXP5URMSjVJNRRSw6Gu9WnHFNhNwCiKMVdV
 9VXn8WKaDq43snLuXOEVS5Ti6x4z6BUqhFJcIfmkWLkifrwuC6A2VupPkiELDXNI83FQ
 GZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752164155; x=1752768955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7QvCTXDiPU+t2Q+zwwTwj1QNbnhI7JBdN1hjNvSyLg=;
 b=gR5jUuMfCXbxuuVp4Gj3wDOwibDUF3bgknJrXEUprqzbU2HtT4/eroxz/GOKSBr2aH
 zmYX9OzTIxgCm32F466cV9XndzoZA5qWBY7B4/eVb1fTuL6TyqsoqxF0XWzHfDIL27Ev
 OAetUFV/bNqSitRx9VTPyQ1zg2SuVTp+CpodmyR3KULlegm9c16Gom1s6JLwr8xO1q4S
 AP6EPRfxG31K2EwtSdeYec7PkbOX+Z43jCk+qRw7vyNnYdyl4JjQpnIY8+MNG6WX0V21
 r9v/5qT2TLwNZfczA1w/4sveR1oYm6xbajZWmrO5ikld0djC7du96cuVrNcCi2T44K2e
 fBtg==
X-Gm-Message-State: AOJu0YyNclGlweF/fvFHSf3KW2XAyFxjpro8sxSGzUBZCLxxxA5yc8Rf
 81RX56StwOMmxX+o8X7mCWBET0b6bgWd3A0Gsfxaxx5DmxAZDT1bMTyI7Y+y6TuDZ5NZc+yY39g
 ZhJcd
X-Gm-Gg: ASbGncvLiDZ8w5XnDwUePnKghKEGHFGO+ho6zWV2q6yMi/7Sn4PNcmQpMrzzbeMGrrG
 TVkNObFW8Ra6QD9AKFVyeD0WXdmg/c1xjoqqs30/1UQ2O+SQPtVH1L/mBEKJnmK5t5OshNU1muN
 kAFeBCP72Qhz7rYidd2Eyn44lcIW3QPJmhml9Tjpa/7Ano3d9LwqhXk/9WA7fJIQ6A0dDy4jqPG
 U4m2HlpeeAovkh0AeOjcpnLdORzTrjHilndCWgdr2EsCY14alXIbqu6Epnglc4n4p4dOpmuGJNt
 H9uAxTgkP3SW17cRq2qT3Hmp6CbW3TyvH9QvWyzJUDH/rifTjd5zdFiCzQHmyeUpV2M5
X-Google-Smtp-Source: AGHT+IEGlYQZCpXUSzH4wV1McXURVUTumKrl+Xb5jQGwATHmAOqNi/OOs3FvF6le2qLiUDbB3qva4g==
X-Received: by 2002:a05:600c:1c8f:b0:453:62e9:125a with SMTP id
 5b1f17b1804b1-454dd292bcfmr36776355e9.18.1752164154502; 
 Thu, 10 Jul 2025 09:15:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd54115bsm24417145e9.31.2025.07.10.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:15:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in
 functions taking an ett
Date: Thu, 10 Jul 2025 17:15:52 +0100
Message-ID: <20250710161552.1287399-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The s390-pci-bus.c code, Coverity complains about a possible overflow
because get_table_index() can return -1 if the ett value passed in is
not one of the three permitted ZPCI_ETT_PT, ZPCI_ETT_ST, ZPCI_ETT_RT,
but the caller in table_translate() doesn't check this and instead
uses the return value directly in a calculation of the guest address
to read from.

In fact this case cannot happen, because:
 * get_table_index() is called only from table_translate()
 * the only caller of table_translate() loops through the ett values
   in the order RT, ST, PT until table_translate() returns 0
 * table_translate() will return 0 for the error cases and when
   translate_iscomplete() returns true
 * translate_iscomplete() is always true for ZPCI_ETT_PT

So table_translate() is always called with a valid ett value.

Instead of having the various functions called from table_translate()
return a default or dummy value when the ett argument is out of range,
use g_assert_not_reached() to indicate that this is impossible.

Coverity: CID 1547609
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: only tested with 'make check/make check-functional'

 hw/s390x/s390-pci-bus.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e6aa44531f6..f87d2748b63 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -384,9 +384,9 @@ static uint64_t get_table_index(uint64_t iova, int8_t ett)
         return calc_sx(iova);
     case ZPCI_ETT_RT:
         return calc_rtx(iova);
+    default:
+        g_assert_not_reached();
     }
-
-    return -1;
 }
 
 static bool entry_isvalid(uint64_t entry, int8_t ett)
@@ -397,22 +397,24 @@ static bool entry_isvalid(uint64_t entry, int8_t ett)
     case ZPCI_ETT_ST:
     case ZPCI_ETT_RT:
         return rt_entry_isvalid(entry);
+    default:
+        g_assert_not_reached();
     }
-
-    return false;
 }
 
 /* Return true if address translation is done */
 static bool translate_iscomplete(uint64_t entry, int8_t ett)
 {
     switch (ett) {
-    case 0:
+    case ZPCI_ETT_ST:
         return (entry & ZPCI_TABLE_FC) ? true : false;
-    case 1:
+    case ZPCI_ETT_RT:
         return false;
+    case ZPCI_ETT_PT:
+        return true;
+    default:
+        g_assert_not_reached();
     }
-
-    return true;
 }
 
 static uint64_t get_frame_size(int8_t ett)
@@ -424,9 +426,9 @@ static uint64_t get_frame_size(int8_t ett)
         return 1ULL << 20;
     case ZPCI_ETT_RT:
         return 1ULL << 31;
+    default:
+        g_assert_not_reached();
     }
-
-    return 0;
 }
 
 static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
@@ -438,9 +440,9 @@ static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
         return get_st_pto(entry);
     case ZPCI_ETT_RT:
         return get_rt_sto(entry);
+    default:
+        g_assert_not_reached();
     }
-
-    return 0;
 }
 
 /**
-- 
2.43.0


