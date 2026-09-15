Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ACBC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdV-0005Vj-Kk; Tue, 15 Sep 2026 13:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdQ-0005Rl-99
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:57 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdO-0003Ww-Dv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:55 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so1563044f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492073; x=1790096873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+XedOOJVOPP5UYhOG5X1jLQ/MXsSMJTkd/7CNPXyMm0=;
 b=mep3TpKQOy4UiJn5n0TrVwux6uU6zyk0ApoWhfxmnDDefm2yZuDnB1NkqWL/HscfNY
 GmIbjJngJPnESbYVZAcUWct4ATbDbhE7ZUm3vHoZDhRQg79tDeVSkEKsqtfPRuhREqXn
 XxtHuk03ZeCNQKSz7paEAQIVG1s3vgXHz5AfehOBsdOWYDwVeGHNsnWkqg+xW31Cp+Q5
 8sHOyyD70RnnqsnkDYyh3nv3YRgS7sYyw91VefEEofvVN29Z6eP6+nzW7jAvwyf0xbzQ
 EsjOFSpgihvO1WcvmDcslY4IK+zwcn7G8sZxmUNgMzfOzN91JfgmxyNC4n3xhVgTx77D
 3VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492073; x=1790096873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+XedOOJVOPP5UYhOG5X1jLQ/MXsSMJTkd/7CNPXyMm0=;
 b=F8Y02eTNUMtu0p9FCLqhaS5Bym8AKGtWUI+uMehiPmvA1rrsJxA49oz2QiMF/A8FQr
 D5cMPXxnbVDega6MyOO3yZKmYuPwN6SxXtl/QExCOuI/bU34sofx8XhydIvLHr+d46Yf
 /+o48ig3PpGqcrCN3EYBat0c+zIvJWMo90sG/UmhylArIdu9eh6maO7IFINyqiCgilpO
 193s53wEp6Jm02eid2D0oCj+qc8mPPLHjOcQ1OKTE1CevPdWfFDfj9JpjRFVCrzu9oNw
 ab9TlHQhTU18e+C3AuBY9Q+05UO/gxsxN+JtNICnDIgSTn1xw465jHk6Yyuffd33XtrQ
 8aHw==
X-Gm-Message-State: AFuF++mtYUWMK5sGt6GGpuZfXnA6Uu1JjkSQZ31BqaLomtq9hk4q7oVp
 X9VjHtwHgy+6GSL7xsbaDa7CvewGFkKcxlkIbqe5XaGf8lJTekV+oFDeHkoCetJ29qRU/X7CjFB
 NvZqDzh0=
X-Gm-Gg: AYBFou1lMG8/QjOdwEiSP7bgqdMdFJ6+yNiUljvqbFsyCf/fJcpfin4jB+EBaHkqyUG
 m9WZUSrFe31nlxGBQQ/j4jjDcAahxe8uVUcqfGOsKwEnssyEqTTqG0q+cwLln2p8mmWAsujFy5d
 6lUx9d8bro7y/dvwfvw3InUpOVfgsoQNsxNwyZlrt9mI/lwuZZ9hslpCdb1kH+S/LvhC00XJppJ
 al8B8GTbcmurCWMzKzt9CHaPDrhzcHAiGcEhJlgwDBpR9IPSSTvMAcsVy31ilLK7HWIu6cB88Kq
 iUtPVp5N+dJPysxvyfWwFvMoIi8fO2w67nQj73yYpNzXNz+p4G+oM3oMmqrgdhJ4u23EQvFH2Zk
 QMEwRMd1xyxdaU5goJqGf68AvTWS3r9BETahRgKJOuRmRA6LmWanB1/4OwygkCt6pYXBFyCGK4l
 I1vFkZwjOkao5Ih/oUyAQVI9Jd1n/ucJrpvP1G5HAVNlu/PMtAXVXm0sYDFotqxIgwiagzn0Hve
 NqR6kTAnxkRoa4ggiYSN6VjfIYZtnUAEExx4L2XGdXwKhro1c06xQ/8Tw+oEQuagP2MTY8CrJXu
 xJ2c
X-Received: by 2002:a05:6000:2204:b0:487:802:84e5 with SMTP id
 ffacd0b85a97d-48708028682mr4092077f8f.25.1789492073040; 
 Tue, 15 Sep 2026 10:07:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] MAINTAINERS: Update email address for Vikram Garhwal
Date: Tue, 15 Sep 2026 18:07:28 +0100
Message-ID: <20260915170735.425445-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Vikram Garhwal <vgarhw@gmail.com>

Signed-off-by: Vikram Garhwal <vgarhw@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf895732c2..9012bf476da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2177,7 +2177,7 @@ F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
 M: Francisco Iglesias <francisco.iglesias@amd.com>
-M: Vikram Garhwal <vikram.garhwal@bytedance.com>
+M: Vikram Garhwal <vgarhw@gmail.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
@@ -3047,7 +3047,7 @@ F: include/hw/rx/
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
-M: Vikram Garhwal <vikram.garhwal@bytedance.com>
+M: Vikram Garhwal <vgarhw@gmail.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.43.0


