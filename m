Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A27C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgi-000239-HU; Tue, 18 Aug 2026 19:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgg-00022q-QB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:46 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgf-0005EC-AL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:46 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b1be215736so382619b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097464; x=1787702264;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vI7tk3K2idiX1yRleH44e/nv4o2lsTH7+NN+3NLrZU=;
 b=LTJJi6vxxCRjlxJTV1GcObucP+rHYChAdaSkd4oMsIJVwcjz7fBTEuIJL8gzNkoGz1
 XgyjEZmw6FJJsO9NO54ivertvX8dVSfOzx9M8ILKkNc5u2tSgmwa93xCtZWX+5QhhTdM
 ASFJyA7UGEaUxSlmES2l8ytDvPXVMR7EG2zcwaKn9FETkn88Mu+n1VeSVYLD0kbCnYVI
 3/LVa8wUbd3mDX5piB9EBMIr+0r9PCEWGstZGdAxfQHHZ8OS2RCPcQoDKus+cO3HuFjN
 kSGmM3LuFXDK/jb7cv/NZdqTHbtfc4Xx5Yjg2YDTF5dYwYzUb4BD5Es+C4HAwnyWD4jY
 ajtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097464; x=1787702264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vI7tk3K2idiX1yRleH44e/nv4o2lsTH7+NN+3NLrZU=;
 b=APsy/hpq3jkeeQjZ6jx9WOR3KBtU6jM2GkPXrKW+DQVvAC4v2VRMto9kY5bT33Iah/
 R+EY9wzgs8WdXJyzGmSqK4AQ+OrpYmxbKOWbW+DaKWSVFvi9MYN52LgbgpZ71XVDOeD6
 zxvFZdBIU8LkvC4qyEeZLGhvn/Hv/uRjpubzLc2rnqleEoU7n+EaFntwl2wB/Yh1weSq
 4QvN6zIEpGTz8CQHKyyRzo5bIPU7sqTxlbFgqfeG0f6w9iCwBMVXo1qk4W6M8j3YrEbI
 0js1nLFGq+E2HOJZZFCGoTkL5G+pgPfmJfXkLBLzZ1TAFpuPSawb1gaQvkBS0HfD771Z
 Xdyw==
X-Gm-Message-State: AOJu0YwG1bB8ZeRhrhoIH4qMJH7wVRL00ibn5kDaH/XGYS094ZpDtCrB
 iUUxRL0aqPOYsuLudDP7JXeac1QSKnUzVVoSS7k6nWSGcDXkVWpjOdAIsoxKaV+9Ats=
X-Gm-Gg: AR+sD13ptj3qWCLyrShHdm0znRVx69xg5uy80B1JHdMk9VS+RKCf0g6MdWeS7L22g0Y
 iFWCmRm1UxchOD6mB1MLtgyw7e+v1K476ui7IVlWv3LzE+9euyEfHaRqpN+2bnPssK/uIETlWHi
 OB2Z44G0wRnWkWUczt4b5QvcSPlkqSI4m6qW/6yk0SKGmXthvd85YNEi5ZUNlYOMiqI0++ZdQFV
 oUGPEA4+MaNogfBjgzOWo9MtFZ3dM8IPfBVx2u4WjqBhG2t3V4OM6kuTIaS0+Bd+Q3iyWVY7GRl
 3slYtMzTTNeK/+uJxhQFr6S/69/Q4qFReg8LnxzvGPPtSSJIhbi/YHNlcysMctsCdCglvXm50sL
 vLNPGcnWVUOQQYAWPz4Ci3xnY0RQWGm7F0VE2nmo142SNfhqkpfb2bPAG/fFScRvQcZh343CkMv
 eQFmD+S65ZiaLa7WoQOlJm41G8H3nxCw9dGKLEl/1p5McKS3E=
X-Received: by 2002:a05:6808:2383:b0:4b2:8da4:9577 with SMTP id
 5614622812f47-4b2bcac884emr331675b6e.15.1787097464195; 
 Tue, 18 Aug 2026 16:57:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:02 -0600
Subject: [PATCH v4 09/40] bsd-user: Move sys/uuid.h defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-9-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=DodGlBOZ7iJZoKoXq53E+MNPjKiMlrQx96TcTy5RKE8=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEsjbH4+QRBevPcpsOgwFeC3PIslm3AFT+1X
 BADdx+vmdKJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxLBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBH8hAAwQkWu59pdThhstO4gFB4EwTY6oiBR2H
 Yjd9nFK4KxzpWFzKoRaYfBQ1P08rKXabtK7SXSjp+bhQvA659yfEPWTN1kC+JEdnVi0Q/PmLVFO
 48jVILaWF4eW9/FqYlD9RX1w2aacN3SBXW1iPnWM3DrXoEqccodgHkyo+XPNZXFasIZn1k6qGUk
 /XEIEbhelya9+EBqVZOdBmqfzOHb9WoeWOAJZDCD23HC3PMkRYwVRII3uXIzo7YcguKM19sxsT4
 H7kRb38hCs6I624HT+DP8JH1nfbF9iioATEnJKji3SgN3kH+Hp0kBL1TFZSjSB6lkb03srPqGB3
 spN9Xl3ELd2coWXdlNhl9+gBghqxIvbZ7PhZTI+R5a4ioaz1dcQI2qI7ezols856h12LPXw6/nR
 Vmi5RHtAFU9ujWEKm5P5HU7Do6MubE2CEPDMsvwAlAqptAx3LpTZH60ksKJyythTFmeOHqpx664
 v/cs2c49q+20OCKvSzYszirGoP96RcWZNKjnyZvxYNVfyt8gadjKCIwuXzgGMcmitif/OHPAeAn
 ABXsHRcut1IeNkCrplDkYndzFTpXvdmuamYnpCgh51cDJrLkcRI8MVMGaHsfgP7Gl9qvHGFmN9L
 o4MnLM/xyuOt4d4Wugq1Ky0eK9JJbeBXUGtma990ZSb8g4VyixGs=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Diff reduction to blitz. Move sys/uuid.h to the location in the blitz
branch.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4af79669e2..47aa01fbb5 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -418,6 +418,21 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/*
+ *  sys/uuid.h
+ */
+
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 /*
  * from sys/procctl.h
  */
@@ -459,21 +474,6 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
-/*
- * sys/uuid.h
- */
-#define TARGET_UUID_NODE_LEN    6
-
-struct target_uuid {
-    uint32_t    time_low;
-    uint16_t    time_mid;
-    uint16_t    time_hi_and_version;
-    uint8_t     clock_seq_hi_and_reserved;
-    uint8_t     clock_seq_low;
-    uint8_t     node[TARGET_UUID_NODE_LEN];
-};
-
-
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \

-- 
2.55.0


