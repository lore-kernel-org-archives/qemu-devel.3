Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08244E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJan8-0007ie-B5; Fri, 06 Dec 2024 11:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJan3-0007fz-0a
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:49 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJamz-0006V5-Og
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:48 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-382610c7116so1269299f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500963; x=1734105763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpWlHsnEATKQd9doFDeJag8Oztk1AQr7X7UO5Wk5+f0=;
 b=o8xRMdq63cHXP4SFy2/tGuweni+SH/3QtFzJaXubUQ3D8SnycWxfUSBv9TIXI8ztjA
 zL9RZL4zl8XkzMvTEqtQmhY5Gxw6+eLIuXXmzV/O1WjzWBzKB3TKSu+zyQNXtQEjt6V/
 jwKGa/gmWMWH/Bh4NNbllOCW8JDl1hxZBzKiY2GEW677PEDv+OC6tfwkzRykTPTmm5GC
 J6l/hGysP+7ChMHzpzR6on83Ing24LTWIpzBxnN6f++UPlVxyAvRsWRMKu3N5HTX4C0e
 a+PEdj1mEyhoMA6G/WfSNp2WOHRHXYgR2jcxR2epbH8/XyuRKnmcl54WpsI1CVhIwjyY
 Finw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500963; x=1734105763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpWlHsnEATKQd9doFDeJag8Oztk1AQr7X7UO5Wk5+f0=;
 b=MusCMzfLDVbrLMGgfmmfB1a1IMIxIJdX0KRgCjeGyofbfn3amJbYeOTEJm07dA3Ado
 zlJw2ox73/bVgkkEA3flhgsJlh+DMc+4MaB1H44dZctPgcfLyPh1Slya+/rbTgPNe3vO
 VJqiAmCQmUYVv2P+IjJvym58PA0YLXeW38cz39kYxBnHRebNzIHx1hWG98YSfzFuKOPR
 1vaOiPAywajtMG5VyL0KvrX4N2wORqQgNPanvfO6VSI80YdpbDK0G16lCqXJcFfewazX
 ilF5F8feVZ+ekXIppE9b3OEdd3FDwKHVflRXctdMWEwMkBH3hjSTpMLOG7J7Sica5f7y
 Mgcg==
X-Gm-Message-State: AOJu0YwZgxLnkYxQverGRBBnCewl4Ew4o1CY06wICjp2FCji6+qP3d1A
 DHQasi4DALyHWKIQP2JCXQ+y1OjCLZvclMHyxpfjiF28H1yjdO0CipFckMH0VFY=
X-Gm-Gg: ASbGnctZo4GBIF74uXIc0MmzqS0YmU1wqYKgBKn3Ud+WgSAVD5YyfFRSqNA5Q/7/Bzo
 HJ2PzAX+IIbqct/G+ok8KqUy/XYnD0+FWVmTDDQ1eCmupunOfzy/CcCgaGZTtZTE823l1nyMhgv
 2EaEyLaVKUgzPGvpX2Hum98GKG0AZ3DT/Ral81ypHnWn59WxbyvDobg/9/zmt5BWeq158yC0KRX
 H+K3ReJ5XnPBXmZnnU2Z7eYkRhWiA7gqT031ynQlA2JOn5e
X-Google-Smtp-Source: AGHT+IFVZGBTa5Z1qwOnpZldqlOnenQhLqz8xmZ893wfxRQRx2GxqQsYVk8dDXz3InGqsXB4tIxt1Q==
X-Received: by 2002:a05:6000:470d:b0:385:f38e:c0d3 with SMTP id
 ffacd0b85a97d-3862b3f0cabmr2461963f8f.58.1733500962931; 
 Fri, 06 Dec 2024 08:02:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da1134b9sm59273725e9.33.2024.12.06.08.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:02:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C3695F9FA;
 Fri,  6 Dec 2024 16:02:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] target/arm: ensure cntvoff_el2 also used for EL2 virt
 timer
Date: Fri,  6 Dec 2024 16:02:38 +0000
Message-Id: <20241206160239.3229094-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206160239.3229094-1-alex.bennee@linaro.org>
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index f38eb054c0..cd147b717a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2732,16 +2732,27 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
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


