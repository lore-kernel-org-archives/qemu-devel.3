Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD2EC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Di-000239-Dp; Sat, 08 Mar 2025 17:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DX-0001rW-9S
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DT-0001wD-M3
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bdf0cbb6bso16879845e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471218; x=1742076018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1ycO4lAb6M0knljUEP2EqCvsgM+Qn8R4EP0BEZ8fo0=;
 b=fn7gWa2J8hKJ7AqNjvx9IvfBT6PQJPf1ZmQpGj9t0S9+RkvcZp6OrpVBpDsY55Pj3Y
 gnzQhP/2AosQrPH4FjHED7fmOXRhc7auFZowkwoo51DisXQWk4Oggq52EMqJYHP54fMc
 rYvH0cEILnrZmzrKRwVwC31gj1qQv4dlsV1hlDlwcxu0hKlNxlKHW0Bb73IpFWFmLlqh
 lgSYM8BnrwFoEVS57+QUUpVazpPEe+wJa/d7hfaJgRk2QP2oIBCPDuNitQD/q+o0TAIm
 fGOgBznLeB+Q679UyqhkdLin+E/XFH5CB52kDiN7/8pDs3flNVvbx2QTuzUXjxaWCaro
 ABZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471218; x=1742076018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1ycO4lAb6M0knljUEP2EqCvsgM+Qn8R4EP0BEZ8fo0=;
 b=hCKXjIhqC6AICKW8PNakbt6VbjLpkbhb0eesTXtrq5VjuyD4WMP8M3bXHL5CfTwsSs
 dCrbtqcyJ9UShOAlu64QXFujZ0RgIudw/JFhQTjX7qI0FurKNgneP9xriQRJQlV0zp0v
 oC7uqwoXx3I+Xx3Rpid5Uj8EAIxd9DL9uksTUEGEcaaUUBdUY5JB7WDhlq63i0OS+Qqc
 P4D+hvqax77HUSRKeSR6gt8aMnaPG4YmfX/8SxD6w9Mb//xXw4zaWIaVzc+WwWKScSuw
 hH4epdh7FQ7pS9LPgeV9Nz/kRIockGT4hRUSvA1zBJyV7mDupmlotmt/hVOZSkldh77J
 4Bvg==
X-Gm-Message-State: AOJu0YygZAAbmzJpGAhThWVvnxBcIRlZ3hx2i2nPTY2Prng5Ahd6EN4O
 XSAYpBQAWz3Mndc5LUtnzInzjgHYC07fC7rEOUGF+qDH0UMuDpbPwChuASsLdTpRQyeq4ZlLXTO
 P
X-Gm-Gg: ASbGnctbg5yghEFz3/FaCW1oiVGSmBx932EoJoSnql58HGUrb99WEoj4XLAbixgNf/3
 hpfmSv8Ick7VobYdl4spK8QjLuQNh4q+WHeuOH+ctVAQaO+VQLc+4GvQllLlUhiXlwz/NxY5NMr
 NLNgdQDe/PDZdFo73E6mPqw/APCUUM85SieuzeYZmRnZR9P69KP2b+R8qi97q3oxOcj+WgDxasu
 d38wgSyN9ZMtCYu8sBs1YgG29DoJ8EDofjz0V8n44Je4ZE04l3JujHp4GOHWe4PPrzLbu7eh3su
 lnhhqDxcnN01y7kh0KLwnEo5tUvbY9rWDFszr5zsdM4hjQM=
X-Google-Smtp-Source: AGHT+IEWGbSKTyr4nGf6rtYMK/Q5/btvlXaBvHneeJwVhrVkz9W5md5HIuUas+gcUv+7nogeh2DroQ==
X-Received: by 2002:a5d:5f93:0:b0:38f:37f3:5ca9 with SMTP id
 ffacd0b85a97d-39132dd9435mr5547955f8f.50.1741471217944; 
 Sat, 08 Mar 2025 14:00:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c3d61sm93478095e9.15.2025.03.08.14.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A71585FA77;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/31] include/qemu: plugin-memory.h doesn't need cpu-defs.h
Date: Sat,  8 Mar 2025 21:53:17 +0000
Message-Id: <20250308215326.2907828-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

hwaddr is a fixed size on all builds.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-23-alex.bennee@linaro.org>

diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 71c1123308..6065ec7aaf 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -9,7 +9,6 @@
 #ifndef PLUGIN_MEMORY_H
 #define PLUGIN_MEMORY_H
 
-#include "exec/cpu-defs.h"
 #include "exec/hwaddr.h"
 
 struct qemu_plugin_hwaddr {
-- 
2.39.5


