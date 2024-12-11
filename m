Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE74E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPT0-0002Jz-G6; Wed, 11 Dec 2024 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSr-0001h7-Jw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSp-0007vn-Qf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:29 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863703258fso522697f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934086; x=1734538886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ht1nZ84ts/9AMVIYYfAfz6P7yX4A1c2tCexcQoTh5N4=;
 b=aZMCrW3stth5tQ0wyh6z0J4LuE9aWBaDRpFESp5A3inu0MD4zlqKSK2erN9sJVPOrF
 1RjWZ9fE+luFqWCrQOekkspEiGZBo/if/iA/WjphajQHVLHZuLFEYu5U3mmjXeE4dNo8
 MYJulhTWUO05l9w92CvnKCXkHa4oApY8Y7TanWxQgB+oyXYS47OrUNNK34j3AR8mN5pV
 r2YsdzN8Z9ss5e60UQ4Z086KjOLKowm55lMEZFa3JeU1eGrx+YT5ydcgxm+2ra3CGJ/i
 DgXWnWZMzL24y/jbIlmOMGM3ub822IOZWsYWKTaQOgbp9auJm+9IEBFmdUypq1tE/zTQ
 dD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934086; x=1734538886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht1nZ84ts/9AMVIYYfAfz6P7yX4A1c2tCexcQoTh5N4=;
 b=q1TqEwLEulunE1ytCfiqpSObBn12LznOOD8OK+TRGaEi7uFbobO4aThEDX430j8Sh1
 j84Ffqg4bvQ8+oYix9sf1JfSltO+aCCIGCyCD63uiFM9Q/d6z/Xq7nJkXUPP2RgiTd87
 naeDgzmKMgt4SXy5JrAMulXjuBXerqWnul/IkfIYt960TBJG2LV7Haum+YlqrNmWrHWG
 9Wq/oDKMxlj9jiBRClsAxGZq10uLEIUL63/hcGMuS0vaYHZt4HWKktUMK/I1El7EaSMr
 HhbjJQKqjjcBLkH6XERSVr60YBLUKwAkisvRKIuofWKuJ9CZW93brSo5mnDCZgcCTd1d
 r3Ew==
X-Gm-Message-State: AOJu0YzvH5SMeT1+geE+K0g9bm8ZXPfVBLG9N2BIukfw4IKiSh4FUTCw
 g5la1kxG9bsTVkkWe7g91rLxpdYbZCvajG33zq6NdXPIIKIN4TUT5/KVE0oCZbxWdEtl02GFAyx
 S
X-Gm-Gg: ASbGncs3vfixMm5cFg2vG0G8iNx3FezDp/zdV0AcQcJ98gZpZa9/mKoA3wlhEle1c8d
 XdUGWI1sXBYyP1m4TLmrPm0LSkHju/3uxyv8yuQYADL0RyAD1fkcUDuEOn3UYakbVSql36PvQek
 vA5B/o0fN+3BQ+o2AFrRH9pfszdWy858ySeBC+S1MlFoAXaN2AhlmDOPLt8o/4do6GLFkP047t3
 2y/cHNeEVIIP6PDlgvhzzoNrMFFTPbrRMrwVKjd/Ac/z4n2zolBsuctN2oi
X-Google-Smtp-Source: AGHT+IGZSf7lVbD0dwuOtt/JRrKF1T3d3PVRZt8EufCiTHqETbuo9S0V3TSKEqW52tRdCYsxcHSKpg==
X-Received: by 2002:a5d:5f4a:0:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-3864de8eccdmr2861516f8f.4.1733934085978; 
 Wed, 11 Dec 2024 08:21:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 72/72] MAINTAINERS: Add correct email address for Vikram Garhwal
Date: Wed, 11 Dec 2024 16:20:04 +0000
Message-Id: <20241211162004.2795499-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Vikram Garhwal <vikram.garhwal@bytedance.com>

Previously, maintainer role was paused due to inactive email id. Commit id:
c009d715721861984c4987bcc78b7ee183e86d75.

Signed-off-by: Vikram Garhwal <vikram.garhwal@bytedance.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20241204184205.12952-1-vikram.garhwal@bytedance.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ae6a78ae9c..1d2003a9a1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1914,6 +1914,7 @@ F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
@@ -2673,6 +2674,7 @@ F: include/hw/rx/
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.34.1


