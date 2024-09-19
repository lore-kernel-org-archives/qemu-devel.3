Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECB8CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwn-0006NQ-01; Thu, 19 Sep 2024 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwX-0005Wq-Mv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwU-00015p-SS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so6929605e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751489; x=1727356289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2kJBVTVE3hu5xqrb4mWZcjRn/GfkKIqvu4GFHzWSmhk=;
 b=etH4A9JUNJzVvD86qbiEcWGjCnQ4n5eGTaZuw29ctxWERJ0NNaM5JtFTic/y/MhFQj
 PD3WME6ZitxA/Ag+YIEVKwy/2nONoGiQnRHrgZ0U5POii1jlHpLBPH7cWibhXtsLItwW
 o0nt7dbhgVisFo8Xw83aBFp8g9UQ85dlmSi9UvNr/2jJAPqOuA2lP9f+SfWsuqiVU6cN
 dSflwu0T7AY+PtmnkwhrSyUkA7cGT7O/iZeBXPkwKA8EwCRBYMlsPpIiSsnMjVh2uXAR
 RtBkLk3kGMh8wirBg0bSYYVAMB1iObP1WbzGyNQ9V5Jkf4XhUj6OYzkGmgBdB9ZA0B4J
 ACnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751489; x=1727356289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kJBVTVE3hu5xqrb4mWZcjRn/GfkKIqvu4GFHzWSmhk=;
 b=AhU5NZaO2Ma/tQbPDfMSuwAJuqGa1ucfpSQiIB2LdZnppyYUkUKQDUSio/f5ibO6yw
 NvrGnQd9N2Qtio2IoZHBonVmDwGTCr+0EctsDJdrqjalX7kHdl6v7orc97hgY5csum5a
 2rb0NaDe53zKazQmqoSwZjv5GBvGx9Mr/G9cK2+Tz6VZeWPTj+AKbiDubIpoxhf4H25/
 HJZC6E01DiNfeZQxHHW4dAXn3+azPur+/3cNNej4mfHH3YT9q2tNAfp5Yo1sdrDLHujy
 0Jo51q2+GIQ843w7ilkQ2sY7NiaVljURU2WKlXcEJ4cMwuOdwZxHXxdOVuJ45ZJkaqS/
 J6Gg==
X-Gm-Message-State: AOJu0Yw8BGgRrq+j/a69PjC0CmL+IJ+m3+8zDsUZC8eojklVYYYmxNP9
 9SZTFpa8WH5tjswT7bkOUXDKEX87po5vGzTqHA7rMPIEvo5pJQyesl3mZhoAt07kUBR1/qiTHfJ
 n
X-Google-Smtp-Source: AGHT+IECwEh/qkofVwg1XdzLI2LdG7u+H0EnErGFD8OfoEQO++RDocbpAbhsfoqR3p1tPMHnMb4mNw==
X-Received: by 2002:a05:600c:4e94:b0:42c:a574:6362 with SMTP id
 5b1f17b1804b1-42cdb522c74mr170364475e9.11.1726751489023; 
 Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/38] kvm: Remove unreachable code in
 kvm_dirty_ring_reaper_thread()
Date: Thu, 19 Sep 2024 14:11:04 +0100
Message-Id: <20240919131106.3362543-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The code at the tail end of the loop in kvm_dirty_ring_reaper_thread()
is unreachable, because there is no way for execution to leave the
loop. Replace it with a g_assert_not_reached().

(The code has always been unreachable, right from the start
when the function was added in commit b4420f198dd8.)

Resolves: Coverity CID 1547687
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240815131206.3231819-3-peter.maydell@linaro.org
---
 accel/kvm/kvm-all.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6c4cb263ba3..fe4cd721d9b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1525,11 +1525,7 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
         r->reaper_iteration++;
     }
 
-    trace_kvm_dirty_ring_reaper("exit");
-
-    rcu_unregister_thread();
-
-    return NULL;
+    g_assert_not_reached();
 }
 
 static void kvm_dirty_ring_reaper_init(KVMState *s)
-- 
2.34.1


