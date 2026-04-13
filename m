Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE39EBFD30
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEg6-0000Z3-Lg; Mon, 13 Apr 2026 06:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCEg4-0000YW-I6
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:38:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCEg1-0001mv-5h
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:37:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so40117035e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776076675; x=1776681475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/gRv9RLfF/F+lj385yyoTJLt207V/mbUmBgkzmiVuuw=;
 b=LNt2gAR/dlr21TUCevbumLhYgrg4sk+C2jLRYKumROvX1b40Asz/XVUNYg8Enk480x
 HRzhCg9cIejpdgxwslkGPSwHGIj9Ou/XQE4JYIeed4TQv1wiHZCNzuwjBoNCmYNqqO8j
 Aa//y5DE4eAhhIqruOO7oc13whBUaX61Uqe2FjBUo45Qlewg2JQVRb+b4c4rUEO9xjmu
 NkIMPuidp8sBzgtqBGZyF5aII1EBIaYcbwtb0et/krHakhzOiDzBQuNRBAEKIZpe/pHk
 0p+w1LU0mfRcwxMSlctJS/XQ32L0pi8ucH28H5Oqc6bTP+gCiMkl7rxpDYSoE7wopGyR
 1AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776076675; x=1776681475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gRv9RLfF/F+lj385yyoTJLt207V/mbUmBgkzmiVuuw=;
 b=K3p1b7yCx7+ijEhRtsTXBim2WNCJ9/3v+Xs6aDDYVMKL9JPpKLHDiTQLNbEKkrIyh4
 rLsX3mq1ekOnHc3O4xvbd96ngdLW7P6JjLAPis3qrsHqp5x/bi1uMP4CW5VcxT1ZXxWQ
 OdDgaKJYsuqqh+AXPyemBdzVnCA26LgrQrl6L2KMHLrMdp+TqWug93kZ6R/rldilngfC
 F93VGLQQ+7Waqc4BaO4XOqqKek+L9DZN9Rgsqh/uzTVlzXwZjbOzQTx4Kv3gTEgX3FH8
 B+0YDrqrEMc0WhOuAd1HR5TDcx3bV9Rmz3BVfeY9IWtpVwVADJ+YIM5sHglIsP1B28aC
 ZIIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QjiubEg2bYrnCCAWZFvmFAgZ7Zhv8TU3v9sGvGSY7yn5smXRWZXMfhdqP2CSdBRFBWjK98eyD9zCd@nongnu.org
X-Gm-Message-State: AOJu0YzP4rMVdIWjnN4axVCbWXwzjhuigZ0Jcqs1dyx4CaUiJgpRnLg9
 lYug+xViC2gJvKsiHmhdDRa9m4Olwcrr7TqiHEu6yEx33MlwmT5frCDwzbWaLvUPWyI=
X-Gm-Gg: AeBDieua70ZcBiq7MPpcxfJMQrnJsOyTA1XHWf5t/8sKXUzMyNG/kquu4BTNK0oIASa
 LgKD+f9LbeQmIHJtpYcrne4CGLtTo5t01FjC3bucgjokqvZNaa5AbybyX/vwLbJo9OiHt19owDS
 24n85mQZpG90GpXXAS+kkRhjuq/H6NVOLSIivKDGdAyw0DKTnjcFzuMi6B29yodUmcAZBV1hAZl
 H8TCc9YMSOB0LfIC6Y69F828DhGkjKgrGn8R3g2HVLXsWCYy83FuBSJNAlRPmVirUr9ssaJQoMh
 oqigjYVlThsNAmx9qVQX8R+UOVMYN3jTwOKYTca8I+hgXvt24WpK4MnlkwKzL6kH3ll/6JigLsa
 bzLYu9NUE8fP9n9tfbQYM9CLMSJ/waSjorb46rIUMXq7adcSRtMMuhr/1j7l5jOv50O8NfT1aLP
 QAh1gBybh0yhjzjwZGWt/pq8uwGC3fklFTp3SHoFEsQeP7umbxn6yGy1xTC0KJy8UEpRpgX5QIB
 rfpKKC0J9ywe9uivbKfl/1sVyub7XIK7x1VX17r2Q==
X-Received: by 2002:a05:600c:440f:b0:488:84b1:b216 with SMTP id
 5b1f17b1804b1-488cd58011dmr160933685e9.9.1776076675363; 
 Mon, 13 Apr 2026 03:37:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46713sm32893051f8f.21.2026.04.13.03.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 03:37:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-11.0 ?] docs: Deprecate Arm OABI and NWFPE support
Date: Mon, 13 Apr 2026 11:37:54 +0100
Message-ID: <20260413103754.45745-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Linux for 32-bit Arm has had two major ABIs: the original OABI and
the more modern EABI.  OABI support was marked as obsolete in GCC 4.7
and dropped in GCC 4.8.  In the Linux kernel, compatibility handling
for OABI (OABI_COMPAT) is not generally enabled by default and is not
compatible with building a Thumb2 kernel.  Distros dropped OABI
support fifteen years or more ago.

NWFPE floating-point emulation handles the ancient FPA11 coprocessor,
which is only needed/supported with OABI.  Our implementation is old,
untested and not thread-safe.

Mark OABI and NWFPE support as deprecated so we can remove it in a
future release.  Our main motivation here is to be able to drop the
2500+ lines of NWFPE emulation code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This just came up today; it's tempting to squeeze the deprecation
notice into 11.0 so we don't have an extra three months before
we can delete it, but we could just deprecate in 11.1 instead.

 docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6d6a71326..10de10dc23 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -452,6 +452,31 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+linux-user mode CPUs
+--------------------
+
+OABI and NWFPE support for Arm CPUs
+'''''''''''''''''''''''''''''''''''
+
+Linux for 32-bit Arm has had two major ABIs: the original OABI and the
+more modern EABI. OABI support was marked as obsolete in GCC 4.7 and
+dropped in GCC 4.8 (released in 2013). In the Linux kernel,
+compatibility handling for OABI (OABI_COMPAT) is not generally enabled
+by default and is not compatible with building a Thumb2
+kernel. Distros dropped OABI support fifteen years or more ago.
+
+The original floating-point coprocessor for 32-bit Arm was the
+FPA11. This was not present in many CPUs but did get baked into the
+OABI for how to pass floating point arguments, and so the Linux kernel
+has support for emulating it via the config option FPE_NWFPE; QEMU
+follows that. FPA11 support was also removed from GCC in GCC 4.8.
+
+QEMU's NWFPE code is old and untested and not thread-safe; the OABI
+ABI is long-obsolete. We are therefore deprecating both OABI support
+and NWFPE emulation, and they will be removed in a future QEMU
+release.
+
+
 Backwards compatibility
 -----------------------
 
-- 
2.43.0


