Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE2DCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEMR-0007Th-A1; Mon, 15 Sep 2025 14:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyEMM-0007TG-Fq
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:55:31 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyEMB-0005Qj-1A
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:55:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b54abd46747so3159757a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757962511; x=1758567311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hY4Kh7N0I8trIBDZa9aSCYLr3VeF8+jqFR+jQBwwPmM=;
 b=NM6hntp9NLJave9csGtrFSfO61PV+8haqnkGxix+ldBUffve7BdlNZH82FHCCaovRd
 FYwsuu8VK949DLk1FD11Eto8C7FqsyGCC3AUGajfNbvyrWxdhonAO85pNwvSU1oSAKKz
 QIH2mnibJSEUN8cWDIUgSZS1ZLHnQBB/gVUPh5egW2cTDfYJfUU3rVWWzhf+rX7Vzenb
 2eK2Dvau4Fu0Gsq3tMTNmMFT1A6YeAq5MMQJsuagApgUeQbfHnLUWBseS/e3Fm4k4Lqq
 ue2Af7ReCSBMxxVWIv+WD1DWK7HCGIBwP3ygkHVvNxftDntnAJv4UGEG5nEvrjCkOL+b
 zl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757962511; x=1758567311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hY4Kh7N0I8trIBDZa9aSCYLr3VeF8+jqFR+jQBwwPmM=;
 b=MrOoMGNCBFhwCZTeG6lx8DXqqmXL4EnfmFf5SeaeBaPnFgzNKs9zDJewKPq1/AwXe+
 UeM30nbxZPD2Mgabkd3YpC3p/C34jtKb2Ljfl+1IQrtZlIaq7F+voGLodjoZuHs4XMWf
 /W6HZoERJg8tOpRyDDZUD+07yiS7wtpHj3P/TwsmNHh87FGFvt2ablrLNCzsimWIMgWs
 05EbAfJ4ExOlAJeJ4wvrIKkPpGCCknF47Xfi+bhbDqruOoU3JrQRwvzeeC+igTaY3QB7
 mMll6SbqLiu1JRugZCRHtv9XRYO+sLzhrh9j/oLthltXRxCwQPqDkaQ8mvgZI1WOsnlI
 r8qg==
X-Gm-Message-State: AOJu0Yw3m/N0waiwfBvmUrTE8cgSZCB3WbGSGOfTnBzgO1d2Y0Syv4KQ
 JtJcszA61GH4/FBM2W53kjFJKkz7R/QLIh6JhWhaWGDK8WPcibEP0rk6XTVMVpL9+Rg1DtJspZX
 OcRB9
X-Gm-Gg: ASbGnctS3acPXVmidTBBEMT7wOpT+KykV7bTXG/S0Lm1Wx8nHUF8c5qAIgoJMxnAJ0J
 EkMWFxrupknE8+wy9d2OA8sgIagXGi77vQZHHWebH751GadDZieE+QbSLxmXLD02YTafbBs2Jvt
 cLAZ39aHCBpliP3Ve9eP31R1ACD/6Pfs6v/nRdJ2z3WQ8CCUcrGn2W5Q/4B+qHO6lRojlm3bIK9
 cN+fxvrtU+DvrxROIZySippvAxY4wi7U8EP1sO9DuHld9iLc46f8Yty2Kvig9ZzSB6HENJIgN0T
 FIM+mAE0/OAENIJq04fsbk5RuyPjrm8f4+06uzqg0db0wq2FjhWn1w1T7itlCK8vjAsZckhqOb/
 681zhR+1LFzYmfuJo0VTu/16+T07RZsLTFn4OokY=
X-Google-Smtp-Source: AGHT+IHp4OmsCCkNL9qWa2kr4u+j1x4dBsikNa3bUmIldxD52zaxFmqfgTwNHe2MTsm0L6kACSNW6g==
X-Received: by 2002:a05:6a20:3949:b0:262:af30:e4c with SMTP id
 adf61e73a8af0-262af303e80mr9401385637.53.1757962511527; 
 Mon, 15 Sep 2025 11:55:11 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54a35ca2basm12300378a12.12.2025.09.15.11.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 11:55:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
Date: Mon, 15 Sep 2025 11:55:09 -0700
Message-ID: <20250915185509.340022-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Startup of libgcrypt locks a small pool of pages -- by default 16k.
Testing for zero locked pages is isn't correct, while testing for
32k is a decent compromise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/functional/x86_64/test_memlock.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
index 2b515ff979..81bce80b0c 100755
--- a/tests/functional/x86_64/test_memlock.py
+++ b/tests/functional/x86_64/test_memlock.py
@@ -37,7 +37,8 @@ def test_memlock_off(self):
 
         status = self.get_process_status_values(self.vm.get_pid())
 
-        self.assertTrue(status['VmLck'] == 0)
+        # libgcrypt may mlock a few pages
+        self.assertTrue(status['VmLck'] < 32)
 
     def test_memlock_on(self):
         self.common_vm_setup_with_memlock('on')
-- 
2.43.0


