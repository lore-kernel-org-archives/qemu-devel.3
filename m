Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B3E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyaq-0001KZ-VG; Wed, 18 Dec 2024 13:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNya2-0001BD-Js
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:30 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNyZy-0007Vc-Bl
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:28 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so9375904a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734545715; x=1735150515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kN/ZYXoIAzuNuSPL620rsLxZYj3p6quBDyJTtx4PN0=;
 b=qR3VP4VtC82gaa/mOQQ5md1aRaSB3uy8pb6jAUlo59qovSG/6rTcudADLLUmg2X3lm
 k0UvemaAg6upaw6UzB+y23qdWgn9PYqJPyrqF8o6lRnB0nEN3GmYNraat+ZoNPL2EGvW
 BfvrwZzXlq3yGztVPl65AF5YkRlZkPESAhq2+zsXd/7xmw7oZpuk2v4+ukI65VMbzs6o
 rzMpQkUjkbkwIONABlsQsfL9/4nVyuphu/JuLirHEP1ciAJbzB/ru97qAnsyITvAfxGa
 OU8aRUDEvUTm1XajnOWXHo7BFL8nxPiRRiyHXvlCqLl6KwGtdhH4xCO0exams0Nxkwk0
 xbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734545715; x=1735150515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kN/ZYXoIAzuNuSPL620rsLxZYj3p6quBDyJTtx4PN0=;
 b=LhmqSgRslf4pNzILmlnM+gvzMtGu7fyAMeTmGjGPtXJHIHAJuK1yPSz8DmhhvffIsr
 jfFhK9R2Bgzt65+NyCbCfrzvDP9vk4/lx2KoktgdqPN1EFIxn0l3MTnnXXPbWWdrOMxb
 xzxcjyitpVrWwEt8iywY5Csj35IOQ/wjzfSzANSo2b6bJ5OmhA8qQOEwRsArn9NSaztj
 9vERMTiCu4rzT/Zp6CnDA6MsxLI4QNubIM56V5gEu54nzPQX7jceqJcHgk3ChEMXiqOl
 Q1SwuwJFvU/Yu2pZPp3AeyHZKDpfNWClANKBAEtxvODaT1KNgqaz2q2fw8e/YW0WAsXW
 JHmA==
X-Gm-Message-State: AOJu0YxmvR9TQF+z6M0gqIPWtjc19PxdSdhexAcpQJENHzCEsUKHpZTV
 3KXcINHDyktkSdmrNFqLQrxwQNdb61rnXnjmojPvDIit/YutbloZCYnE/OqdIxk=
X-Gm-Gg: ASbGncsqp2UJdA8PvUlmQmOl2ctUIbDE51ob8jxXT+RrHU9/7Dw1/w4lMIZNDMGJo6b
 wMpfePU18A9XHlrGMvmOD/E+XuP9ospGcOc2+iUyg9DxLE5zLsqF+aS483SAPP5KbrLW78VVeVP
 9tHVuWG5WtqfCIwvELgmZk9cshnXWMCoqrD1f2DWmRhbr61upjpKGhSbif1rEzAIYxDy1BR+Lp0
 6yvykqAVEXrQaPSPYcwaKCRPo7LonJx/1UT13vsHYiWBxixC8Ty4gQ=
X-Google-Smtp-Source: AGHT+IHsI0Co9EhYUpBJrUuYBCdI+5ypIA6xtjjr4rxw6ykwwDq+P173riTxy0yOlEgy4uqPxlyrtQ==
X-Received: by 2002:a05:6402:43c4:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d7ee41e7fdmr3678720a12.28.1734545715136; 
 Wed, 18 Dec 2024 10:15:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ae10a7sm5564454a12.38.2024.12.18.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 10:15:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FF175FB2E;
 Wed, 18 Dec 2024 18:15:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 2/5] target/arm: ensure cntvoff_el2 also used for EL2 virt
 timer
Date: Wed, 18 Dec 2024 18:15:08 +0000
Message-Id: <20241218181511.3575613-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218181511.3575613-1-alex.bennee@linaro.org>
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

We were missing this case and will shortly be adding another.
Re-arrange the code and use a switch statement to group the virtual
timers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 target/arm/helper.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 910ae62c47..5a1b416e18 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2465,16 +2465,27 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
 
     if (gt->ctl & 1) {
+        uint64_t count = gt_get_countervalue(&cpu->env);
+        uint64_t offset;
+        uint64_t nexttick;
+        int istatus;
+
         /*
          * Timer enabled: calculate and set current ISTATUS, irq, and
          * reset timer to when ISTATUS next has to change
          */
-        uint64_t offset = timeridx == GTIMER_VIRT ?
-            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
-        uint64_t count = gt_get_countervalue(&cpu->env);
+        switch (timeridx) {
+        case GTIMER_VIRT:
+        case GTIMER_HYPVIRT:
+            offset = cpu->env.cp15.cntvoff_el2;
+            break;
+        default:
+            offset =gt_phys_raw_cnt_offset(&cpu->env);
+            break;
+        }
+
         /* Note that this must be unsigned 64 bit arithmetic: */
-        int istatus = count - offset >= gt->cval;
-        uint64_t nexttick;
+        istatus = count - offset >= gt->cval;
 
         gt->ctl = deposit32(gt->ctl, 2, 1, istatus);
 
-- 
2.39.5


