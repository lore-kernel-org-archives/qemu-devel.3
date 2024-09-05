Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A9CD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC72-0001Nr-NV; Thu, 05 Sep 2024 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6w-00013r-QA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001kF-7v
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so6745335e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541271; x=1726146071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZoG15XuyK+nNVT8u07KHJfMp82Qf5wSGYe2aZmTEF0s=;
 b=MPJ0bSV02OtKWgDWnG5RZK5r2nCmmr1nPUmF24yVP5VWbush+9lFT4ZtrXjQK3tmuj
 8M4t5EpJx5P2igW77/hbIevbPP+0TWd6vzzUG6fHdPFREuERey8rdW6Oho9El1ct4cYK
 mAb6TvFI3sbghjBkmyJEf4LeKZ03Pdz32c7dd1H0+djkR5+H+MYzxTYRZtd12mKH2CNu
 x7FbZ/OhF8/PU+yETQQfMt2RVb4BriqJWrrFa0v3hxLSAn0MNBllaU4HYdVYOP8T21Id
 rgVVXs7p1Sl2o0kivn/5SQYLpiCG+57vQJWSHw2P9vfzQ4gEXo9GSgVDWMjnA086QVXn
 AETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541271; x=1726146071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoG15XuyK+nNVT8u07KHJfMp82Qf5wSGYe2aZmTEF0s=;
 b=OZa1W5F1w6NVhD4IHARDY/L3/j4TvDnZT08Nm5XwALPubXW70Sewch1c6yuL79wQB/
 ty+PS3m7o3fLplC7VLflxvWCrUGbH1upoWtUK0XnVvD57x0zxuN927WIVZQsqSnRgtuX
 BH4H2npoPVhe79vHtdZ6PCDfxmFrZTSssjqlSk05mR5fc7CIhM3BBaQKBqch+1zDsFUs
 71tu9KWVLvtT5hWtptuYgw3h6o38xwJtADvOBFDiFfkiQ34PjpJXa+XabAl7kC2AVlgd
 IGAjohN2+a07O8b04C0cZe18NPIXB493Ey/w0PS4tegLYzplYiO/36SYNAD0GizG4ktr
 Ig8g==
X-Gm-Message-State: AOJu0YxdpxWntAETVz7/JArQNzFL+L4tTtHBxx2GwiLIb1u0LkXY3wjC
 jLjR3M5wLD+BqTsUtCgjzwKd5q0MIx0eOy4pF1Jz/fGoJ9G2sqrbWvXSncwsKTA4I5V/ziaeQqT
 U
X-Google-Smtp-Source: AGHT+IFC8nkVGAhPpb1d5BZJ/PZUbAeoNyuou81qC7R+xylxdVa59BifJ5daN1AAk6hd/avyjqZkmg==
X-Received: by 2002:a05:600c:4f8e:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-42c881085ecmr68611195e9.35.1725541270777; 
 Thu, 05 Sep 2024 06:01:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] hw/arm/smmuv3: Update comment documenting "stage"
 property
Date: Thu,  5 Sep 2024 14:00:46 +0100
Message-Id: <20240905130100.298768-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

When we added support for nested (stage 1 + stage 2) translation
to the SMMU in commit 58377c363291d we forgot to update the
comment that documents the valid values of the "stage" property.
Add the new "nested" value to it.

Fixes: 58377c363291d ("hw/arm/smmuv3: Support and advertise nesting")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240816161350.3706332-3-peter.maydell@linaro.org
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 39719763897..4c49b5a885f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1981,6 +1981,7 @@ static Property smmuv3_properties[] = {
      * Stages of translation advertised.
      * "1": Stage 1
      * "2": Stage 2
+     * "nested": Both stage 1 and stage 2
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
-- 
2.34.1


