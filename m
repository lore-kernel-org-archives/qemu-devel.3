Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ABBD2F02F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjLj-0005D6-Oi; Tue, 27 Jan 2026 08:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkjKm-0004lm-2o
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:42:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkjKk-0001gh-Ik
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:42:19 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so50754945e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769521336; x=1770126136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qD1o95f9Pf/bA89G/Xn3Rzf0rKWrglB6Q/kB7+Zjl7Y=;
 b=j0s1/W7v3tu73KVXJLR/wRkJhjHsr0tToAKxde/nIOrjBbnAqet1X5gIVUrmW+uyAQ
 Ls4IwHvEBCwDak5VQqsMjPu2dGoVNJlXKIFKHtsnyM+3oAeiiUvt3dSrrs0vfVwbtdet
 vRGR8WKQPskX5x6QXZuKKdEpT8PRFHG311Upc/Mg9Qr9W6W+lXqTEmhFcGzIImrovsBR
 DgxYVuhhDupjyDqqLyf0vZ8ai920eiuKiVrKXlg6bYeB6wcRm24zLm56/Rabh0Aoh2v9
 fdZ/pql1nY17Eb5TT1Nw/MEmzwZtEyQvo1Y3cgjCX1F57u0jrkb6xKm0vGNCdZeiIp3+
 cfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769521336; x=1770126136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qD1o95f9Pf/bA89G/Xn3Rzf0rKWrglB6Q/kB7+Zjl7Y=;
 b=KJIX0BJxoIvmSRk+jShlcDm5Whj2NTvgp4QI6QbCyHBVzJa5nwvlFDp1PSeuBcY7su
 VKxJwDjSsG6NNGSUQMJ3f3irFz7xala44ggRdw0l6uHX1uaDWfgHcKdaK9C0WfuSBjLs
 ZFrDE365Bpr9C6Qkeeh+hxHZc6w4Mn2Lr+34quW7tymQzidtcJ1NQkdbFGmNdoSQ5SQE
 s4r9XZOGkGLaCGamW4SC7td6zO1mWtigQN/Tna9a5doTksWJGnl3RBU/SYBNYZ/Iow9Q
 tBh0ogsWgbgHSVuDjrAIeRouJTbMvL/Wmjrv0gvj0vmLKugwl5SNdhByQJE9flKhyN9Y
 Tt6w==
X-Gm-Message-State: AOJu0Yy1Ml20eo4c3WehyHCVAfrggTEEMVuwen2AkKp5hGZrCw52S4Ln
 G4DXFBQkZJ95O/2Q3wbGUchReEXqUhjfsTqgAaDkfDjeccFh0Au1lGmnTnlZ7gH99MY=
X-Gm-Gg: AZuq6aIdcmwauorbVsVIfZBUeky0onpOwFMPuJ7RS+EBWBSPIb72gtsM7YQA+al0Aua
 A9I3XLxBbPFCGjMklKH8nxjFJsViATc+a6iWBD6uB/CcAq1KSEWUqrjpgYEiFInS0owXB3FfOQa
 EvMs55xe2O62dmmoBYDBGyhilPfh1yHpT8TyfQRokxa9b6Sqd7MuOX3oACvDgX2yYhucWVX4HKM
 yS3xqmwh/l/1Kx+JSP+tN24IPFWYsjgzNWgrlmUJ3xvMkGVke70ZJYmIOnbOdq6uhtfNvV92rbE
 CinJAFAEf3OgnGnPUgo5gJo2LAkOvNAaT5FmqMHtHI78nEVegaCc2+bqsPJ2aO4CSmmh2nF8/Yz
 sILn11uIdX1S28uzk2sef7ebEajaCCi/M2VdbQ83lmX+RFjjjJMo0odM/JRaL7xzi5Hhl6odtE8
 GaJ5gTAwutWzY=
X-Received: by 2002:a05:600c:3e06:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-4806c00c0d5mr10903845e9.2.1769521335528; 
 Tue, 27 Jan 2026 05:42:15 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7404sm67190435e9.1.2026.01.27.05.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 05:42:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F23645F7F6;
 Tue, 27 Jan 2026 13:42:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] docs/system: update FEAT_BBML[12] references
Date: Tue, 27 Jan 2026 13:42:07 +0000
Message-ID: <20260127134207.3043703-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
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

It looks like the features were renamed to include the levels at some
point. To make it easier to match features up to the Arm ARM update to
use the full name.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3f30ea5a30e..22b5b659aaf 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -26,7 +26,8 @@ the following architecture extensions:
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
-- FEAT_BBM at level 2 (Translation table break-before-make levels)
+- FEAT_BBML1 at level 1 (Translation table break-before-make levels)
+- FEAT_BBML2 at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
-- 
2.47.3


