Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FAA1061B1A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HjM-0007i2-VQ; Mon, 30 Mar 2026 14:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjB-0007h4-Nb
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Hj9-00038d-7Y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so58652145e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896760; x=1775501560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ceVDVX8xD+d+HSxRibRQlzvG5AaZb0ZMAVIgjx6IF9o=;
 b=OUgWogsHpwlK8uE58Z5Z2lFcMGmKCP10c9NCnG0mkidx06bvODFZKm/60gjxM2ximn
 S4ybmnRDbXL9qroeLmkP+L1l0hA+mrAG8K5NFMO6FJGxM7vAIw0MgluvimEjNR8m0oKz
 2DwjDBuP5/PeWs5vSpO+NokXifS/qcAwO10Dp9H9raTvyOQWeffFeZqKbEOz83P/koD2
 v9VdB8zjkBwpk+kxIRDrgCXTdqwTaL/52YZM+XWkZi0FevAwEDhRBbq7RDk9vyg2QNLN
 dWPbmQsUiVOZSjOyS1DjTCkotOZ6zxNj1qpgK18MmI+OuMEK6dxzJHo92zdzkP6wU7Of
 eeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896760; x=1775501560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ceVDVX8xD+d+HSxRibRQlzvG5AaZb0ZMAVIgjx6IF9o=;
 b=p4hlluaJS3KvyTXGhWx+NzoO/3JuJPQZu56iBXVpCGLSxhPQ5SEofopFT3SJmxIytD
 Mt/6Y5f69r+c7L8d1UE+omZ14U4mqdFx0xcv2DOBSCOSQ8X1HqxsEK+OsfqdwgME52si
 x20YOOBQueGWe6tXID4E7hBNAeKDoGZBEizuzdRvaLPOz3KVYGnDBqeCIyhvwS+xtYvy
 detfBiS0+acG1873tD5xItd/oSpRNOra+7bqZ6WFwzIIgZiRUYsfH5WpBVd0wWM1k4y3
 QYt02vup2VRVjQVeVTrywcLuhwWQJx86QpRtNET0/22PMDNEa3Uzl0U1TVqW8T19h3Gu
 mw8A==
X-Gm-Message-State: AOJu0YxGNMObS6DwQi2JYjFtjt8JKD4cK5wFLoQaJ0glMmd+QQt0j7xS
 EtOIwyUqBT7Yb24VP/bJDtCsIEibjwRSboxFx5Ey5OzHAGu6j5wS22UHepYkl/K8HfY8MGVfs6w
 Fn4vGrT0=
X-Gm-Gg: ATEYQzz7JlPAUGB22Jm8CV2HE33GYRbIjwSLcApHm2G6F2i4zJkROunJEzaQeez+ziA
 yYz7jCBt+WcN9IcmcrBotpoqeVSQP+Mr8sMSJxGrSDCCF6KfZ8+DStUx0sFYzxXonZz1hmZZwxF
 Y48U8edImk9PIyy2JgMkbHMId6A3iHodEWTR8NPg8hObkaxWeL3b98KObJfD+V2gt8Mfc/GPgbG
 PpIAWen+T20ZgqczUK8Qu/ee1b7W5nvUoQp8v2Ve+XAckdugLYBW1B/xcUHju0Miff88fbQ4z5Q
 V4CoCvcFxNVsLWKzeFmYZ9heoy+5ZhCOlEGHEqJieIhECQeYPhAZlQNHexayUn/MFhmJx+xc5oB
 mz9prt+DRO1u5hSTLp+E4z4ew1xcSHjd+mRgqQdBjYWW2CFuturJJfY602AqqlGWVnnS0LLCtJU
 Drui6vZ8liGgmhs8SbCmHNGyEyJwk0dFJDFDspCE+l40po56dxdmnojioRxnlBKYYuK650V43xo
 VF4QmBAOH1X4AOnnHYoJttjbwKoEKE07eojLOd6LQ==
X-Received: by 2002:a05:600c:19cc:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-48727ee9ea9mr207332015e9.31.1774896759432; 
 Mon, 30 Mar 2026 11:52:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] target/arm: Don't skip access flag fault for AccessType_AT
Date: Mon, 30 Mar 2026 19:52:32 +0100
Message-ID: <20260330185236.1905636-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():

  // Check descriptor AF bit
  elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
          (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
           boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
      fault.statuscode = Fault_AccessFlag;

an access flag fault should be generated for AccessType_AT, if the AF bit
is 0 and !param.ha.

Besides, we should continue to not raise the access flag fault for
in_debug = true which is what we've been doing previously (before commit
efebeec13d07) for LPAE and is what intention of the debugger access
codepath is.

Cc: qemu-stable@nongnu.org
Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20260324160321.96347-1-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e289f88124..08a76bd3f1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2118,6 +2118,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
+    if (likely(!ptw->in_debug)) {
+        /* Check descriptor AF bit */
+        if (!(descriptor & (1 << 10)) && !param.ha) {
+            fi->type = ARMFault_AccessFlag;
+            goto do_fault;
+        }
+    }
+
     /*
      * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
      * and it is IMPLEMENTATION DEFINED whether AF is updated
@@ -2127,15 +2135,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
-         * Otherwise, pass the access fault on to software.
          */
-        if (!(descriptor & (1 << 10))) {
-            if (param.ha) {
-                new_descriptor |= 1 << 10; /* AF */
-            } else {
-                fi->type = ARMFault_AccessFlag;
-                goto do_fault;
-            }
+        if (!(descriptor & (1 << 10)) && param.ha) {
+            new_descriptor |= 1 << 10; /* AF */
         }
 
         /*
-- 
2.43.0


