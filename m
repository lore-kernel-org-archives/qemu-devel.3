Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCEECCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHOaZ-00044w-Qh; Fri, 07 Nov 2025 10:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHOaY-00043R-5o
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:41:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHOaW-0006Z7-EA
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:41:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso9962885e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762530079; x=1763134879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nuGfmGIOi/f93VH0xYyt82y1wWGEqtuylmuk5z+5d64=;
 b=sUj0g+fH76cwXd8dPzEhtZie07CTmGR6I0rgv88ly16NyPvF2gM4TcSFkIC9GbETkL
 LGsAHglWR62OoNSDNzpn6WjoirM4BX7+4lFReqGKYgxbHc4CW2MyZmd6h0RVQhQx3dqD
 tPwA7jIo1Rr6dnZ0W7p+aglWXZBa+68yuFY9bruuI49aTcKJAPjFWyMFTMsUJ7Dmb8SV
 mcz/G8MzekddPAEoZkrsBri6XWy+ZYhdp2dapjhJKkiARxfC+E35aDJndeAccXzCDPh1
 /H5qNDihbOaeRdkTE3BcVIqwGcKXaCx72tOJ5x/5IllGgP+LyDgGiRrVvPmNlR2an/SH
 JwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762530079; x=1763134879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nuGfmGIOi/f93VH0xYyt82y1wWGEqtuylmuk5z+5d64=;
 b=gGtVXJkFIQk6lpWF4npSQeGBHc5km5GTzzgNDyxj7D1mSCaKz5HMO9PzXP/lFKDXj1
 0vHHhIN/jdkIB3FduXJFXwlKaCMmxnxqV6iiI1YV80Io0Emma/rTw1O2MdtF2+tXkZRC
 HyGLrYuVUAeFdfRATpwBxuSGb0Iy6HhBhuMJ0C4s1e3y06oI0GQD84dDPpor8iAEfqYM
 dUoZsvjHKji5M0f0fh70o0QE4v3Mubwod+P1+7+11JB6O0oOVb9Y2PfG9Qc10YBNdUfu
 WARtEgnEzuMdlANmcp7DY19i2Vm5f2CdLPFZzm13JiUeTfAlLfgmEN8L8UrFV6LzaBGX
 PQ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUylJSNVtsyc1OOgPCtzDCscLr3j3h8tyjtuTdFxfXLAtD1YAbAOvbA3ZVg013qho95xIMxaSErqgzU@nongnu.org
X-Gm-Message-State: AOJu0YxPkMVqDpfoUis/y6MWZiTOCZhORGa+JE98ARGTKlAl+vcDMU+Y
 a4AYYI2Zp46bY6iTq02YHr2t1kKfpoghYdFQD1o49IhDdW/PdZ8lvkSykmLLkUxzPaE=
X-Gm-Gg: ASbGncvN81I6Vz23v7oQSVsimaef3w0wIxAspD//GKhFLSe2wFhBhpbJctwjECtSCO4
 Si+OxbXIo8IYTyzEgFoEBMty3XeiNYdwgN2adULSKyGkSIazFOU+5nx1PQP6tLfXaR8sVVwnC54
 Rs5MByTfo65UqFUfmhm1pZ/dbs7Zf0p/QbmxmzvWHJ4ISQbcjsFCE914M5w6iUSb59xpVcpCi7c
 YOas1eIH6PAGaF5XufNk5kwAvd8nk6KX4PpTfGVoXjNVG7r/W+Ham2zcsJ5hyYiS28rhQQYiApq
 KHfitPCI6AnypCM9qcslJJhz0NAj5V372+7Wl0AClFB0sDKjNgHLgXxoS+fAHcg7Tkn5SV/CHzx
 bEClbOmFctJF8WIkQb6vZLIk7qeGwoGBfy6XLl+/KSGYW+qEk9diLCGxp7iBUoyqtVaUStXTMEm
 IML46SYw==
X-Google-Smtp-Source: AGHT+IGTO6MM+4/pcJXcmdcWMDyIfir1doeK09Gqd5ZqunId5b2R7YiLxJKTNeC50LXvXnrNXcAcHg==
X-Received: by 2002:a05:600c:4fcb:b0:477:59e8:507d with SMTP id
 5b1f17b1804b1-4776bcc537amr30259395e9.31.1762530078536; 
 Fri, 07 Nov 2025 07:41:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67845ccsm5779183f8f.36.2025.11.07.07.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:41:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/audio/lm4549: Don't try to open a zero-frequency audio
 voice
Date: Fri,  7 Nov 2025 15:41:16 +0000
Message-ID: <20251107154116.1396769-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

If the guest incorrectly programs the lm4549 audio chip with a zero
frequency, we will pass this to AUD_open_out(), which will complain:

   A bug was just triggered in AUD_open_out
   Save all your work and restart without audio
   I am sorry
   Context:
   audio: frequency=0 nchannels=2 fmt=S16 endianness=little

The datasheet doesn't say what we should do here, only that the valid
range for the freqency is 8000 to 48000 Hz; we choose to log the
guest error and ignore an attempt to change the DAC rate to something
outside the valid range.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This bug has been around for so long and is a weird edge case whose
only effect is to print a debug message, so it doesn't really seem
worth cc'ing stable on.
---
 hw/audio/lm4549.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 745441bd790..bf711c49c04 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "qemu/log.h"
 #include "qemu/audio.h"
 #include "lm4549.h"
 #include "migration/vmstate.h"
@@ -179,9 +180,23 @@ void lm4549_write(lm4549_state *s,
         break;
 
     case LM4549_PCM_Front_DAC_Rate:
-        regfile[LM4549_PCM_Front_DAC_Rate] = value;
         DPRINTF("DAC rate change = %i\n", value);
 
+        /*
+         * Valid sample rates are 4kHz to 48kHz.
+         * The datasheet doesn't say what happens if you try to
+         * set the frequency to zero. AUD_open_out() will print
+         * a bug message if we pass it a zero frequency, so just
+         * ignore attempts to set the DAC frequency to zero.
+         */
+        if (value < 4000 || value > 48000) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: DAC sample rate %d Hz is invalid, ignoring it\n",
+                          __func__, value);
+            break;
+        }
+        regfile[LM4549_PCM_Front_DAC_Rate] = value;
+
         /* Re-open a voice with the new sample rate */
         struct audsettings as;
         as.freq = value;
-- 
2.43.0


