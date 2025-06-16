Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450A8C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUa-0001G2-Pk; Mon, 16 Jun 2025 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATx-00015I-5w
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATt-0003zQ-Gb
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so25427295e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082796; x=1750687596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eEpF1bq+uDdit1cKP/leNUs+euxU/so4YJjiIr0qDj4=;
 b=NPUCeFx4cu/XBxquoEVqhnA+yB/3EIOjxPyjge1/28Mb0eZ7pM0kx+LkvOVzsbDie5
 zNNn5yuQFcSkSH/M8LOFx/v6f8TM3rQAjdffBiJgsST5UdMEuwDdXqQywZJi9twccVuy
 yE3w6BVAr6wJDw1GhAdSCG+lEB3iyqIra4yGZne9LVJVMwaWDMcBf6IMH6fzUjbZkRT2
 5/5BbGQ3L7EOx9I9a7ky8Cw0Dzx/TlFpbtqah5a28fvEb02hzAgryLQx/okKaYcn4Qvd
 e4oRlVo1BkS6TIvQujcJxzLbngz0MNoXavpK7gwvLR4Tjk83LBeNLvdxsItNdi6vvtOV
 S1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082796; x=1750687596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEpF1bq+uDdit1cKP/leNUs+euxU/so4YJjiIr0qDj4=;
 b=jZEOXTMeSClQ0sH82swju+YV7r7iA8L9aqzhx0Uj6cmOncmE4pPM1AVnDtRGPlVjQE
 /u/8Lb39bS7KtFtN+Gh+zDLt/aV572+3TU3E58QRmjDUINeBT3tQJnpD6mo9ZpUYYiE3
 wZ9crJSTBnuoK3xMV0hacB+Dc+LYCzqEz68FkKFC8dU+hQaYMAp+x72B4iQlnwzAKp/l
 ParvNkbtpQQoZC5+l3gx4JMYFV+LswXJ6yGJqqHwC56JTWXCiSn9wZINT8Dht4/SIV5N
 cVdQoZRxTLD4uOzSBUMyzgV5i3PqGuVNt/jlCityrfxmp7veD3WDO2CDw+wg6mYFQRMj
 3LSw==
X-Gm-Message-State: AOJu0Yy1MEAbd7jK/Rri3o0mqlCQsF5WjPmQJhprGKgP2N0yoHSxb31F
 YOyTadFmt3PihMsYQCM5DqaIxRwLs7gWiUnvTLXi7up4dAZutnTVsJ3oJilRuysnElYncmP90lp
 pjjR9
X-Gm-Gg: ASbGnctxcIdd+wfO9fi97SEjKBZ1RZMr7YgT3Ya0G4F//z0SQfe6KXvvo2xpzv++6dW
 7zsOSQUPMnXrLhrcZK4Gv4UdNjV5wdCgaY1RPRpbfe6fv0iRGqGft1xasiVLZj8cdBviFcFd05B
 scR+BLhuNpFpueuu1RZaUx4Zao5oRWYYgjQ0Ol1A7upj61oDaVCMkKOZnGEuzK5wnIXQYMh7/hO
 Dww0qHZBK6g2uMYyB1aj0IqnF1u5ORugIv6KUdhPYfaRz+3//lBm842ej60n92saaykwe9t7joc
 io3/mxQgPuCqokBEnTcXuczg6RDAGimnVBiWzS2YLjXFrmwh+YW8kcG28KCvW+g3jao6
X-Google-Smtp-Source: AGHT+IFBV9QrT7/m9A1qn2l+wg6q9aE01Bro8S6YJvl4+Ce8N7zE3G9uR25qy4/y2qqBsLzZWvukoQ==
X-Received: by 2002:a05:600c:34c4:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-4533ca55a90mr96773125e9.13.1750082795560; 
 Mon, 16 Jun 2025 07:06:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] qemu-options.hx: Fix reversed description of icount sleep
 behavior
Date: Mon, 16 Jun 2025 15:06:24 +0100
Message-ID: <20250616140630.2273870-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Ethan Chen <ethan84@andestech.com>

The documentation for the -icount option incorrectly describes the behavior
of the sleep suboption. Based on the actual implementation and system
behavior, the effects of sleep=on and sleep=off were inadvertently reversed.
This commit updates the description to reflect their intended functionality.

Cc: qemu-stable@nongnu.org
Fixes: fa647905e6ba ("qemu-options.hx: Fix minor issues in icount documentation")
Signed-off-by: Ethan Chen <ethan84@andestech.com>
Message-id: 20250606095728.3672832-1-ethan84@andestech.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7eb8e02b4b9..1f862b19a67 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4936,13 +4936,13 @@ SRST
     with actual performance.
 
     When the virtual cpu is sleeping, the virtual time will advance at
-    default speed unless ``sleep=on`` is specified. With
-    ``sleep=on``, the virtual time will jump to the next timer
+    default speed unless ``sleep=off`` is specified. With
+    ``sleep=off``, the virtual time will jump to the next timer
     deadline instantly whenever the virtual cpu goes to sleep mode and
     will not advance if no timer is enabled. This behavior gives
     deterministic execution times from the guest point of view.
-    The default if icount is enabled is ``sleep=off``.
-    ``sleep=on`` cannot be used together with either ``shift=auto``
+    The default if icount is enabled is ``sleep=on``.
+    ``sleep=off`` cannot be used together with either ``shift=auto``
     or ``align=on``.
 
     ``align=on`` will activate the delay algorithm which will try to
-- 
2.43.0


