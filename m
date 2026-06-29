Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3AFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weH4A-00011i-PJ; Mon, 29 Jun 2026 14:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weH46-00011A-VB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:50:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weH44-0008GU-0i
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:50:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-46ee68c3b7aso3159901f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782759038; x=1783363838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sWfTUR43tvh42zicAoO0bljq6IhaKmFpO1b1DkpF2OM=;
 b=mejkmN33Q0LvnsTuc4nf4mxa6CmJIjRo5GOL4mYnkmk7Bj+fi1Omifcn+b8KXJH5cv
 OQv2/A8C4ll0+J73l/wnOkZ/7l3tA1aNHk0YFtgYjJqVlrJZREmiPJskrKFHG+o8oagu
 QuiNs6OIbX6sVc4eVTKWn7hVwKYohjvb1JgW8B4xfiZsDz0KCoYOht8EhINacsiOJCk6
 W22wP3o6Yti2d8NicwrSTWx33TzzI7jIkfP+RNpYrGSaFXG27eOP4eUVAmBr4ALeqiSe
 7INN6basKowWdyU1HZGHwVM93oc5UKi2BRrQ+Arzi5JJFiglPUo0GspEkXC3Sxg/4hii
 pHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759038; x=1783363838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWfTUR43tvh42zicAoO0bljq6IhaKmFpO1b1DkpF2OM=;
 b=rEpKOYyUILxglsmnJ4AsE5vcLoMmZBXqW15BeXEPNqD/ianJJiA6Z7LjpmJTK+CaTf
 h+cB3a+maUU+o3Dx8DrITZIMAW3omskv1rc6GQfMmXxIRq8xHf0/w6I940vfi3r9Ip9u
 5m+fetSxgUCXSCtLbfehGWpdc2CNY99/ngeHdkLqg+naop4obVT0pk7PaJ8a9z24AhYH
 WthPXqt5azkt7Bx2gXFrDU8Hk7IJpSNLOOn/Gz/AWm7nKSaHTt4QqhleRuLo5LzDk6T4
 +dkdYL4r/9NWMebL2ZVh9GKYn+wc3fefa7mxZfgqVTFyOLQTkEiLI+Gs7YRG7uiog6Di
 vobw==
X-Gm-Message-State: AOJu0Yxp/g7Z0SNPSTG91h69P/LYx9BfhtryGtmfORCRQkBlsXiTQHb8
 cnrPscCJJBtLejj44tgjBH7wJh5uJcm0vrgjYINbMFYV4OOgEuvNmXbWSIYEmeLqYZevi38mou0
 Oy0ft
X-Gm-Gg: AfdE7cmPQ2DIHUPYxlDnSe3yPB9Kld/8rHLIFNkCqztjCiQEiJUptdfJ2/Wjx/01E4F
 kM5d72frHJ/8krX6XQsTBR68zaKqGznJCID97sNxwWH7l2E8FQK8/Ot3lp3mbYRgvsFbt4DGWR6
 yR0ReDoX7tjB0e9sVpxsNSkv2gAAnvfmDTuxkN79/CMdjMvDVyF0qYXqPImot/MPZqUiy2YT0mT
 SoTOCW6j8kebnu1rTIBne6SM1FhZsM16g80ejFJrYZtkaI+ElF7T2dI7EiOvIyli74uz26ssUqg
 POKtDIZixw5XZNDIF1jixj2ykPr1LGNqLYWCfyDk9aEAPVrbemVmCss6+eCZWlYECFGnHUMKXVR
 fUEw9JVrQSqsE1JV0oPt+hdN8f1MCmVi7QL8AQ/5d/ht1P+ZKeSnVBADLZJPhozgWtE2xS2LwKV
 PbpBgmVVAaovVtzoSGqoWH6F7I5whsPVbH/d6y14NBvPQX5JsZvWru700IRHlPwpyrRo6Jf/ma4
 8hBmtkGwsbKNsD2rx1LKMnWl5OYl73S
X-Received: by 2002:a05:6000:24c7:b0:462:7add:607 with SMTP id
 ffacd0b85a97d-475523b35afmr541300f8f.25.1782759037143; 
 Mon, 29 Jun 2026 11:50:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cde2sm161316f8f.20.2026.06.29.11.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:50:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <fam@euphon.net>
Subject: [PATCH] hw/scsi/mptsas: Reset doorbell state on reset
Date: Mon, 29 Jun 2026 19:50:35 +0100
Message-ID: <20260629185035.2138238-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Currently the mptsas reset function clears intr_status, but it
doesn't reset the doorbell state machine.  This means that the state
machine and the interrupt state get out of sync, and the guest can
trigger an assertion failure in mptsas_doorbell_read() where
s->doorbell_state is still DOORBELL_READ but s->intr_status does not
have MPI_HIS_DOORBELL_INTERRUPT set.

Fix this by having reset also reset the doorbell state.  Strictly
speaking we don't need to also clear doorbell_reply_idx and
doorbell_reply_size, because those are only read when in
DOORBELL_READ state, and the code always sets them up before
transitioning into that state.  But it's less confusing to clear them
out on reset.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/304
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: this fixes the fuzzer repro case, and I have
run "make check" and "make check-functional", but I'm pretty
sure neither of those actually exercises the mptsas device...
---
 hw/scsi/mptsas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index e4a7b2fee4..5df124c0ce 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -811,6 +811,10 @@ static void mptsas_soft_reset(MPTSASState *s)
     s->intr_status = 0;
     s->intr_mask = save_mask;
 
+    s->doorbell_state = DOORBELL_NONE;
+    s->doorbell_reply_idx = 0;
+    s->doorbell_reply_size = 0;
+
     s->reply_free_tail = 0;
     s->reply_free_head = 0;
     s->reply_post_tail = 0;
-- 
2.43.0


