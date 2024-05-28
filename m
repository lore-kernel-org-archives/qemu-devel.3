Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90516C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUi-0001Vq-3K; Tue, 28 May 2024 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUg-0001Uk-F4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUe-000727-Tu
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-354f8a0cd08so769589f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905279; x=1717510079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8e50owdFjq3l9wuKAY7n7wmjEPbhSYGUt29AzUeGso=;
 b=SDr0s0QnY0bSwnJNzkvQlmeDvmanbs4nXXCX3Li2TTWoQyZgkPfnDf3Usituz52rHt
 ZTi5ooziShMQ1DLUmBLDIIpPqlYyV7Vx+Oqeb5dcZYe6+sefO+62uoj+RHedGCR6978+
 9dElUfQ7cIomDMw0mATMHrRWyLj6Efpp/YLSm1Jp5JlEJcu1OWH/gpNgqR4ZhW8cu21i
 mVWGMDLb4pLwfyUrBTRRciuFsAyP+n+x720jThuNNR3OC8/2wE+jKMRMyFlafWkfc2dd
 5t45/G5H0PNpgRl5j07eUlCPnYlHNQiZ2ScO+3NrmzPA4pAa4DHGHc+V9GPl/hdE0pzc
 0GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905279; x=1717510079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8e50owdFjq3l9wuKAY7n7wmjEPbhSYGUt29AzUeGso=;
 b=gCLgz++kgQDwvBcXZBOOJEN7dZiBZQ8mROb04Rvy1tbZgdvR2Dqtzrn6fZ6avDhTph
 dST9xagznzC2BC9ypFb9BLFVl3c/5MGpic5kvB6WfaxfMSNjG5YhZtwFHvQrfaL2ufwQ
 jFbNzZ/noM+vPZ5zBA4jhZwBodeudNMDQ3CDEjZaVgWU4NIgfIswaKg1pdv3NtveJxqU
 iZKa1H9WedRYTn6zM8runeB/n2c19HPAA9Y8KOHfNluozpJe5t0jak9q5nK85I3hLGil
 frksF475v8VhY0UVPOsWsKzQML0NNTrrQfTrNVXuapoYsoAnylaJ9TKt9i8ztQPbtsIR
 lHcA==
X-Gm-Message-State: AOJu0YzcvDXWPPvfh48ej6ewR+33Mih/ZNxgTp1JHvcVsZEnQcmwKv3K
 hC9KB8ZLLEp7mugHUv/oeJ8ctxb5BkPB0NLr4ZxfTt13k+b5z91m4qWgTQ0hU0FkJwUrjWgm2/2
 N
X-Google-Smtp-Source: AGHT+IHzgCn9KeWn5yOfrU9UhqD40L33XwCmFvZ6xrEK3Z+foDApdATE+cRMWPMoUeHDpLKRIVpquQ==
X-Received: by 2002:a5d:598b:0:b0:356:4bb7:b205 with SMTP id
 ffacd0b85a97d-3564bb7b370mr10008772f8f.1.1716905279499; 
 Tue, 28 May 2024 07:07:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/42] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
Date: Tue, 28 May 2024 15:07:17 +0100
Message-Id: <20240528140753.3620597-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Check the function index is in range and use an unsigned
variable to avoid the following warning with GCC 13.2.0:

  [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
  hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
  hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-Wchar-subscripts]
    416 |     s->dav |= mode_regs[s->function];
        |                         ~^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240508143513.44996-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed missing ')']
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/tsc2005.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 941f163d364..ac7f54eeafb 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -406,6 +406,9 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
 static void tsc2005_timer_tick(void *opaque)
 {
     TSC2005State *s = opaque;
+    unsigned int function = s->function;
+
+    assert(function < ARRAY_SIZE(mode_regs));
 
     /* Timer ticked -- a set of conversions has been finished.  */
 
@@ -413,7 +416,7 @@ static void tsc2005_timer_tick(void *opaque)
         return;
 
     s->busy = false;
-    s->dav |= mode_regs[s->function];
+    s->dav |= mode_regs[function];
     s->function = -1;
     tsc2005_pin_update(s);
 }
-- 
2.34.1


