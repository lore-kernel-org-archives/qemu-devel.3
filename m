Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56961C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVq6-00026s-1f; Thu, 15 May 2025 06:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0005PF-Eb
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnW-0008Fy-Uy
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso5770015e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304801; x=1747909601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ab5pp6BZoHOVPbJgDowtlvgwNNGVrCIgmepaEE9nqb0=;
 b=xlIFU9Kt+QFf1AHQ5HmOT0dPbicVtkJHjl5UZlf27lVo1az3jSP7cKMeKbokqVAbFb
 n55VRhWD+hRRXLefB3/s4FYxXGAgQXqh+nDBupaIDHzad+WTBQQN5C1r/LCcXVNj/9eX
 Zxc6XHZmHcLSxFZfrfSuPU+lxsAnECnouvWJfNZg44TKKCkkZb56HbgeaBqgU3yTQxml
 OLiKmWJZYM4b70ReBdwGcgrjCyoej7n8i5HMTMD22CBJOWAWQR+unhR74XI3sx7CdRkb
 rlRiL3fvg4SqcQsOcBZF5NjG9uasM/+2ov84/ZQN03WPAXYn/fLRSZ5NqwyggpRwIcUp
 yCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304801; x=1747909601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ab5pp6BZoHOVPbJgDowtlvgwNNGVrCIgmepaEE9nqb0=;
 b=uJdvLfbL2Pyo9ej6+Wtmo3RHECieYJOMFttkURo8HS72pIWWgsBaT/fkIvdjMjuyl7
 cZDmLQUQyfDg85Lnn9QqiP6eYD7QBaYodn0KlhPxbczcKAsCWqWFaKxNrclVfvn1eNN2
 ydvf872llW7iZK7oczMsmr6yaWivCOrHia8jtCGD5WRxhldqce/wCeTUNP2fePkrtR99
 ac9DM2yOSggjGq+Is1024moN4ilK+gBaPU+zktiLfFd8jhFBatJfA8cM2+fbWAgkT+Ve
 HKlVHwKZ9CTtPDPvgvKM++U0gZ8t2inZvI99bXOcZVFzd2UIEotOtuboFkrlpzUxv+mR
 1yhg==
X-Gm-Message-State: AOJu0Yx0m4FoBvbe8mratK6GQhbXDtKVWjjts2in+MSCN5xv3n/6wpFN
 ATQqF6xdL9oeKojekqcFS9XXLYHhtLAL8u6g/tM+WBpTvh01vne1ATAPttJ9lkzb9bPnbxfi0DA
 Jt3E=
X-Gm-Gg: ASbGncuv6JHa60kCX04bUXzAwRhrBg1NZaelD9gE4L+DWXOwa5QXwffVWIKoqdVhUGP
 q+459SHuwgL9fZRx4M7Z1pTrSlagrF3LJCswl9WQ9jqXwcm7ClEfIjApsmsxmDLpFwV7sMNOKT8
 KBqKLwwUXWY0R9pQ3IeNKv6M6xuNefuWQjQjrvDKVw6qOVQLwhrF+54ZfRSqzcGD3WimONJwiBN
 cDrGkE/vDu9JL8GZ8RuyFUtn30/A50VWizVUuTCU0sLX1yu+Dlv8YwXVo6+aL8f+NPboLy13S6k
 sw/Dab2EHEl0IA4Vh9SyH9erMoC8n2rO/MZ7jScZOl7F+e6YcVaW4xShNQ==
X-Google-Smtp-Source: AGHT+IHzB2Pr0tIQc0jkPWYkwF1RMsVsA2r1AHpWRbxaGKBc/1negtw6tJYjcKwcsmo4WRXef94tag==
X-Received: by 2002:a05:600c:3b8d:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-442f971a49bmr17727825e9.32.1747304800683; 
 Thu, 15 May 2025 03:26:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/58] target/arm/ptw: compile file once (system)
Date: Thu, 15 May 2025 11:25:29 +0100
Message-ID: <20250515102546.2149601-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-32-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.43.0


