Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBCF8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrf-0005q9-B6; Thu, 16 Apr 2026 05:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqR-0005Ae-BF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqN-0007k0-Dd
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso47252545e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331021; x=1776935821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3P+MdSPVfslvZifQWiu4R3g2d2y93hKFSIOz1JRIrh4=;
 b=bFC1hOgOw6qiW0QjZaEcaDbgqb1YyHGlLsD0+iSUeqVfbJy521pYFU//UtKsqMd1cB
 RUGhUIZMhvudWfNTQFjj84bZziHZzVO2FzAs7YLM3Vgy3PgbGm/ugNOEmDsqdGWtP/ep
 kp9rB0lGCgtsNWYlW+pAu9JHUv1R3C8jpqFawpCSRhxogx3BXXAcPAUryMJtIKjJRjnJ
 HdJZZ4ehZbnKkDY6vHpUo/kOGPNpcSA2scT7xMRO4DF/RwHffiOzKDBfmrkDGrQH12z3
 DIzw+VPoVG/isMze89Z5iSuCKYWZJThlKSdqXNAOi5JMnprwkssEpjUiAENZZo8KcSg2
 S6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331021; x=1776935821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3P+MdSPVfslvZifQWiu4R3g2d2y93hKFSIOz1JRIrh4=;
 b=rkUJeB88FM69y3ulV/Lxt1Ndx84KBhf7jZvsLhpuLBfcCgHmwfsdvS2pwRFFgNtVBB
 pnv/WF26e95ud0wvyndGkQJgoPN8WzKDLvp+GjAyPGY8pYCKCb8G2VrBpDUl/tGPCR+5
 8K/XCpvECtETZo6Jamwpb3ApCdHagYxfnvZPBf0FOMlyP00i7SSNfbTTTXttZ+DFLpj9
 xVjOfvNuTsur5rWepTLuaIeHzUJmsYdXqjW+564V/FliwfbaUbwzIe2rzWNWzMMwe3NU
 P2K5wVUX4lX6D+hJKLEtBdjbmaFT4/Nd+8VJfBpx+0HA21pBEnP/HZRlG9X/0uL6f1Ai
 mEFg==
X-Gm-Message-State: AOJu0Yzlt5cRvDlsUjoP7e/F5qcBnQi9IZXKwD+Ys4GnHEcEhYWk8IBb
 /svxwnG44sXtjKDfX3WSG1w1rP1H01+RIC0pj5o07YDIhgRI0GRnMQfc+HgDD16vM+sXLDbNH2+
 DKxNsZ9I=
X-Gm-Gg: AeBDietgpLS7eKQvfsCu4r/UJT61Saf8CZmqBrrvrOZaMAmpsXNJ01zvS0W0GnDGaKx
 oUuHLOiykwD2YDfekRB/N3pnBPAoIQKrGFJZqYsiq1FyE6j8f64NFpckC2VOn9JiGJn65gkZZ/k
 KJV/DzG/0tyI589G8wYE6qWMuV3ufQiezyUEkZ9AdF5y3Y1pxV6McB1qdcpeNdzzQb3DphvLarG
 IM8zTQEXohMWG4WpSVfx7x7lrYxe6oHyvMtsh98541q3FoQHmw6oELxROdWNpvZg57yY1/9f9/7
 qy1+BaRljJUvwO5gnbasHeCCBSyZypO9LUSRA2TvnqDtN2rvWXNR802U9LyNhuXfbePKwLK1xaZ
 ZXuqOmHVMDH20K7H99PALGWKPOibm4CCPIc14UceLdDgfcQt6a1qUKRkXkk+D+6m9ss/fJqxLqx
 fNp3d2EHr4zeiALfiR2avbLdJkAX9DReHuR94f4rD3fWMCh3IWAFLKGOgoaCNMm/i1OGQVWgzdX
 /93M3sN5T0dp6zEOTWz8BMYSFGScCRE+ti881aHAA==
X-Received: by 2002:a05:600c:a010:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-488d68af20cmr337156315e9.25.1776331021008; 
 Thu, 16 Apr 2026 02:17:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/28] MAINTAINERS: Remove Coiby Xu
Date: Thu, 16 Apr 2026 10:16:31 +0100
Message-ID: <20260416091654.316158-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Coiby Xu has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Vhost-user block device backend server" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c57ad7661..341b86519b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4380,8 +4380,7 @@ S: Supported
 F: tests/image-fuzzer/
 
 Vhost-user block device backend server
-M: Coiby Xu <Coiby.Xu@gmail.com>
-S: Maintained
+S: Orphan
 F: block/export/vhost-user-blk-server.c
 F: block/export/vhost-user-blk-server.h
 F: block/export/virtio-blk-handler.c
-- 
2.43.0


