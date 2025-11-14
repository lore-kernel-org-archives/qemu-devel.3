Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0D5CE8D40
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJviP-0003lP-Rm; Fri, 14 Nov 2025 10:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc6-0006Vi-85
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc4-0003vl-D6
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:25 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so1559483f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133683; x=1763738483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QIw9GgzRpa5cDAQSM5pDHi3MBoCBEr8BPmj9kJq1ADY=;
 b=q9z5e0vFaMGs4C0gAVVntIPkslRVd33oawZ/86EpSviVh2MpM2BT2bMRf/QJ2cswuZ
 GUNinbmJk2RVFDIJ8/0qYJa8x/abg++nrBw/ttUzErrjm/5EazQle+X74DgcED/cKph+
 83IhKuX/RBqGY0JQuSv6PiDAGY3qBAYiu6h3kvJ3BXR3GaiRFG0Ja26dulnIpqrzwSEy
 3VjzD/Rox4Mye3/aEXhsal2E5WaEbMtRotm6Oz3afM616OWJ9d4Lmj/xpUevKCelm72x
 OHT4Gcpmja4HYC9yucHbDS7dNifxglDSbNhyRhEIYhDgHcL4GruG85onYuL4bLQFOCkk
 j/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133683; x=1763738483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QIw9GgzRpa5cDAQSM5pDHi3MBoCBEr8BPmj9kJq1ADY=;
 b=CMhLsI/DAiA17qmyN4nY/brfg0zDVUquL7yDB3N4NCfx/gPMS+PS+T2wjspjwo1506
 gTm+fG1wooiIpEhickG/Grl7Y7HYp2D6nfpwYCNgB/+JmLNlR8EDAQ79B/du07kUzbGx
 DCaPEEAbB6Vg9Z5Z5knGASD3mZiSklFygjFqS2PrUH7EuOOUM1lRd0xT36Ofak5gNsBL
 5M+8RMN/QH9qb8husQIg7QyjdS59EoqIs8Jg8b0peGpLBjvr0h3eieTNxF+lzGYR4lCw
 kIpZL6t2G7Z8UTNnNt05mu/nhq/wRKlSc4DZMVPq3Q0QduOlGYjgPMFAYiQ+RB1VO9Lt
 aigQ==
X-Gm-Message-State: AOJu0YzKoZrt42d5VmkSIpF/HskUgi2qiVMuyC5STgCAOwl7E8ByGvaf
 KiLch/cYpka9s+PUYVkeidmOUdsaegCL2mLLxJqFSalz1vOZNBvbpr55O0JpG+yWQkIAOlJPczv
 4HoiT
X-Gm-Gg: ASbGnctrDaZWAG413ALI5J8u1buqJ70RriMDyqToNoAFSaVeDYAh11BPHO4Bi+SPYDk
 Sm/C8cp78/mCGjtT8tpDezioS4bp1U7bdaaJyuzV5B1mTzO/0uda3+7NGYWbsZiAUrNkYS6Ps2E
 48bjogAIp1metZ9VRER5+uSTpLw9+h4+zUx3M6UFAQOjW/0UNBtqc3nmQQlyUOkqbbuvIWU5tCs
 bKegF1gZriLxf7mPZ60Er0zFyAp/vW4+u9iseE6x3bRVdrKyrUzfMtArs28288fhK+CXxEw2d3V
 egkBpxc8ovH/xFJr86hAw/3j50e4oZh+mcWEF9qIEd4xyU65WZW/LHwZw3ecJOTIFGRf0U+ndEA
 bdBCfolfBTNCyjF5N7YXJj5gUHxepOJkvIPyOKfojOkiHWfO/Q9c7Q8K2/iXLPplayD7jKU2rzA
 mkmne2rnUafZ77PaQ5
X-Google-Smtp-Source: AGHT+IG9xi1AR6Nm6zyk0u5503J4BrXXpaUvcN0hZUNht7BBXmA2SM63cqX7IKiGkfBb9jjtmxY2XA==
X-Received: by 2002:a05:6000:24c7:b0:428:52c7:feae with SMTP id
 ffacd0b85a97d-42b593869b1mr3320488f8f.32.1763133682600; 
 Fri, 14 Nov 2025 07:21:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] hw/audio/lm4549: Don't try to open a zero-frequency
 audio voice
Date: Fri, 14 Nov 2025 15:21:10 +0000
Message-ID: <20251114152110.2547285-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
range for the freqency is 4000 to 48000 Hz; we choose to log the
guest error and ignore an attempt to change the DAC rate to something
outside the valid range.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251107154116.1396769-1-peter.maydell@linaro.org
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


