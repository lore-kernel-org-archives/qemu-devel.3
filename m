Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636BDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0V-0006FL-Pz; Fri, 21 Aug 2026 07:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0T-0006Ek-UG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0S-0007Iq-Es
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so528841f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310111; x=1787914911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zrktQ/0dpHx9300jI5Uru75k+7uPzo5vKp3KbeIlViU=;
 b=UDccqnXtIpojimn2EIRT0JWqpXL9HeAp4+dxM/F5oPzE6rrHUJ2cKJdu72brmEt0r9
 hDiEuXFek2vnKZx0bOykjNhSTijF+r0nFYvy4jkkkZf8W7+7YOzW3GIZzuSawQg++7Iy
 X0ii4ugdMG0BYxZJGsMrcPki9Jl3/ZQyuA6SOScqMqZWF/6dpfPnt9fnNSsnUooHlKUf
 vfg3WHwoWLmBcYRTHG6JNGZbyIiIM2Nehpb8RXCpAJR6EGbqXQXcRUVrqldNJ/ZsGZlq
 wbf2+SHuUXackQ45R+N2kP+JZZiKKQCVQ1BPiu3vyARCUoREaaOe8YRU1kPMhoFe8X/K
 KG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310111; x=1787914911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zrktQ/0dpHx9300jI5Uru75k+7uPzo5vKp3KbeIlViU=;
 b=EWJnLQZVnR8M69NQl8R1WejGMZNep5v/V8Jd/iXe71DpHaxDVUaevIcIVpckzeJheK
 kIMxFgAm58f+FGmDB6HLiVtA37TZS2rJJnhwqI4wnU7tYTHDJREG5M/S8JY5vLqAGGGe
 d9vHIGj/298q3IGS74/drZXwxGrLhuTSkHWfdk6UO2NK37RH3baoTDRC0KCFix4GNEmG
 2YBYBy6S9VMfq3pqeLk9E4bKY/tp/YGNwjXyxXaxNAP0vYn3Bq788IQOoS8nT369LSx3
 t0WLHlekDqgrfArbT5YHPqAlztgdJWKgJIQwGFeVZGt1CP4kS0YyhwDUoJIgBt0B9gwW
 KhRw==
X-Gm-Message-State: AOJu0Yy7BkwybMWh/8aeKaYaNIqllZ8mkZFrLeHoj22iCILOIpiW+NNw
 +0D5vzOD42HNEwTXWu1SLLXQfOHbDpVqNIrZUMCc6Lk6Dp2lz1gY13TRR7P7yz7PFqmuwbhfcMf
 B1ipI
X-Gm-Gg: AR+sD12oeYK4wWKp6Lv/CMkJ5r+PKj1zpQhwGgByLrpQ278ABe5/ptXJz2EXskPehS9
 Um3UFtsIU7cbu/aXwhufOJOnYqW9ot5Jp1YOZo4p84GZWS8DlqY0kibLYAuNqrdr5yr74OO1jaY
 T1k2WSAVKrPY89rFeOzWzd2zo2Hh7WC67Qbwne1QVqofktvC0nxjTr+cTf+qI9JT1X+alk6VeUT
 Gatm2yowg8pYIZtUX4eUSH7VhXYcLRAsFMvQQ6FAwDIsOaEiwz6U3IvPsRLiRkmXP6OJzLJPCJn
 4pAwOKQH52OJTW+TJGkmHGV5oV5H+RqxPaZXmjzltqR69VN5PWiUjrkZbT1U1bdl3QBoS4wp8a0
 +RixcnW5n8WV2sKYFy7wj8EhTQSOrCQ6xxc+NaCnOhgXYsdHhvwKCThUBrcUqa+Ac7JKxqaFnzV
 9zNFaoZkOilv/70A6JmFXpaorCvsWzr+AblHgJFGz/V6x3mEk9R2+fEjV5Uq1j11drnqi11hdEl
 V2QhEDY6tjW5dglU9dvZJjkXfxxmuDQyUiNPjWRM0qZS04EYxgBVOymBJJJYTeMxWudHg==
X-Received: by 2002:a05:600c:1d07:b0:496:c93d:e2f with SMTP id
 5b1f17b1804b1-499b857fa7bmr64677035e9.15.1787310110910; 
 Fri, 21 Aug 2026 04:01:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/43] hw/misc/iotkit-secctl.c: fix AHB secure read
Date: Fri, 21 Aug 2026 12:00:29 +0100
Message-ID: <20260821110101.3971391-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
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

From: Simon Xu <simonxhy0404@gmail.com>

Fix AHB secure privilege to read AHB instead of APB.

Fixes: b3717c23e1c0 ("hw/misc/iotkit-secctl: Add handling for PPCs")
Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 54bfe1ba597..93753c2ced2 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -195,7 +195,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_AHBSPPPCEXP1:
     case A_AHBSPPPCEXP2:
     case A_AHBSPPPCEXP3:
-        r = s->apbexp[offset_to_ppc_idx(offset)].sp;
+        r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
-- 
2.43.0


