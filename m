Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C0BCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ8S-0004bB-9U; Tue, 16 Jun 2026 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7W-0004T2-Oj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7T-0000qd-Or
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso26127695e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636802; x=1782241602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wiFN8tnkC1oJh00H2lpTvlEfTpjEPheg7d6EAAdG9AA=;
 b=fjliTDgpLPTTIqiYsFic4sCk56lkF6bwnwQwtui0A2TOVzhMTg+enZ3GR0IoDGpKtl
 i+DIWk/FA8+cq6gKy7/zSluG+PY/9/16NZIqn8kbbldU27LJ4i+Ch+yFhpbUDyUCg4/A
 z3zfchZdXaj1SA0fePIsJcOdWKAG8+o3sn0Tu476I3ArZPibtFGWTN3NrQYVGWVueRPh
 /BFwSFgV5DgRCmATw021jRqLl1cne4NYCuoFZF5tykiJxetkPPTjUCLZTaWdchNbsEzR
 C9bnKK0mkapc6VuGpwRpOp+3pxdVfm8zbMZkcr1YDhzPWPFWgkB9nIvnCHoAUKJvd/30
 tqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636802; x=1782241602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wiFN8tnkC1oJh00H2lpTvlEfTpjEPheg7d6EAAdG9AA=;
 b=cAHj8FxicOFQxwOVew3L7sWBN38CeBWaXBeMqLfRKGLjh+H+Sz0JveaHySOSt9rkJ0
 SCnrTqtNfZ65NPS/3AK2E2iUlYErmhqJ0vyumpfVGoqPAwmXGBeEA+gu3RAZ+xGLImLW
 0nCVqYnlvngZnNBKAdwoYUCMPxLpnNdYM52NSchZF8de/NqmM4CK7Ghv8UpcH6XVfmW0
 v+v7nfzrHmx/mBnU3VQGxU+/zGngu3AVo+z39feLfv8JE5baI66PoEcMG+zcqPNWWE2G
 kPo7TTQsgB6Yeb3eRoQ+fq35aHkchsDpUmrPYc0rcE4dwUdRjWpeNe7eXqPcsJpHP+oU
 95xg==
X-Gm-Message-State: AOJu0Yy4KUQEIhlsIJReHRktE4+lnbsr91Dm+4chU3sAtpeDxRwMJQ10
 gw6LO5RM9ZjpivXOnDDdotGzJgg6Na33AE0pUESRXA21iGYWKD6y+GHpUQ2EIa5gC16AwmGRy3H
 srJm1
X-Gm-Gg: Acq92OEJpK21XFIZHGbFIc8pVre3ljmLkLC5ZKrsDIaDuJiJXpSBikTVP4XJHrtUBmf
 p+4/hCslfMX3wOIPyxQwfoeJVh3zAzhW5zQS189mFFDiTog2Fa6YH2GMUnAO3QepGq+J5mOO386
 jT9Aq+ZA/DQpc5n3sMMqOIBXkGzDvajMMBDp7PWRy5OWDCdSKkQifg3+Jc7i63kKm+GkCr3f308
 RNmCwqzlLWJxMIyHLYWQcWmHe4qMbXvnp6IdoaUxQYyE1mpaI2jcJdcHIIQ/NXygNP6+peQ4+j5
 0LTmNZ+XO1F6YUVIK7E15Uq478mfENyzvSpbiGfJLiQwl1+wRNRM+ESqfc0YdZFqdy3VGYSnSq9
 S1zQ1bwQJoKYJtFmv6XXq7ybtML1wJsIpneh8zm1m03+DTFiublsL6++WHo0L//pvSUtzWSO8ay
 5VKb3LAI/w8iJv1Q454AzKF+gdJ42R7B9uJobf1oEDtFR+/GQYJKLHF73kDUIq3VyZn1DgP5HBF
 kHJYETw9Auen2XUHx35oz6F1HFoCbkZ
X-Received: by 2002:a05:600c:608d:b0:490:53b0:9e53 with SMTP id
 5b1f17b1804b1-492333a1556mr17206605e9.1.1781636801968; 
 Tue, 16 Jun 2026 12:06:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/61] hw/arm/smmuv3: Update ATC invalidation check
Date: Tue, 16 Jun 2026 20:05:38 +0100
Message-ID: <20260616190639.3462006-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
guest when handling an ATC invalidation command, as setting the ATS
property value to 'auto' will resolve to ATS being detected as
enabled in the ATC invalidation check otherwise.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-2-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5c2855c377..0c65dc8c91 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1528,7 +1528,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
         {
             SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
 
-            if (!sdev || !s->ats) {
+            if (!sdev || !smmuv3_ats_enabled(s)) {
                 trace_smmuv3_unhandled_cmd(type);
                 break;
             }
-- 
2.43.0


