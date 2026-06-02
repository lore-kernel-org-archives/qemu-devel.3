Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B619CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURiK-0000o5-Rc; Tue, 02 Jun 2026 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajinkyaudgirkar@gmail.com>)
 id 1wUROV-0002m8-68
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:51:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajinkyaudgirkar@gmail.com>)
 id 1wUROT-00061s-QH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:51:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8422524cb38so1071177b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780415464; x=1781020264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EPgkZ7HBYYZmE75fClS/aa+EIZAOfW9QZxpiL3LdhoM=;
 b=ks+1EcbqMorReC21XxXNxaVDmj5GZ1f904Nu68XOdMhX0gdJeMZKARiPHRuRmo29D/
 NU3L7Rb7s4/iWXebqtsaFg7WTRKTWOMJsNw/QP7kUccMwsEZZ0TILQP0k2yOvVfEqDZ1
 B1hnhXNSEbir8gymYlXo2yrQ3XyQs1RO19aCZgIKx2Zz30L9di6ChH1g2g4u7XAjR6q2
 Kf1Iq5+lPCkyOERH3f3Ku76d13poOk8A5sy5hYSBvRQ5bIMlycqCu/5QFZX61hH4EqlP
 A5Y2zA8o68prOZauVX2zIhjBP9543Rl2xlWT8lg1pfBRSsjp/q43WoGvZvWQ/rd6+ndh
 nsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780415464; x=1781020264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPgkZ7HBYYZmE75fClS/aa+EIZAOfW9QZxpiL3LdhoM=;
 b=BdChRP/4CrTLNz0I9V+N2BAFH9MkCaYZMhAgAiZtU3+0qV27c2MwAV3h0NwpFUd2wf
 1DMtFawTQDmejDRF7BMsDD8PZMYcNldY+aCZyp77stKkIaFjIjOTGspgKzJ/VCV71Ya+
 eEYIamvg/hupQINZ0diQezniJhZmyDkHcKMjMPyNUED3DWPifcHE6g2sJib4pWuRQf0q
 EPxTeD4Yijs4CoFc87Ycx3+1t3FBbgssYOvlNXFvkaS+wrg3YhOQ0MnNoFGxedarLmrJ
 U5Yq6kVT/tX3tCxscX2BukyNgPghL/3x27fVO9LtKdZdYy062HL7BxmHBE/rHogKzpSG
 IT3w==
X-Gm-Message-State: AOJu0YxWlmyqSE/IlUfI7wNitnWPKU3XtiUxbQ+oPhJwagH1rfFiQvor
 y7utMc8kEEC3AYXkIp6UxsQ30ROqVND+SALjHFPIq9UEq1+7Xwf0JaOmXAQDSQ==
X-Gm-Gg: Acq92OHTWH1p8r7TYhNgeuAnpZ4LnJQPe3pEw6dxYut1CDFRkaKuKhhS5l7iUL5aU9z
 Qlz35GVC37bHg5iMKogqyxtjfu2nTQNR/V4I3RySmt9iTAH7eP+C2lGvO7k80LAms1eKrjUIx5s
 wEBH0t53MN6DQv9fT6INEd9PZrZqjaliogLM7fhRdxpwq9TctRUBgbpU6/43vXZuicnxOoNqP8X
 ocetP8m3DCJAKu4Vk2Z2JoYOEoj0KYc/SiLv2tE2xzHQHQb/33ryLxmkmtEwVllCfuOqTXMm4jH
 UAX9qvCp1B/HXpOSbL6DYx8zAqfJrhqdSPjtLukzg4bZdJxg+L/LSr3XYP2s4LDDlGdvEaHZI+8
 soOCEAT+4Zs5tDCW6n5/I8kgsn2BBFdKP2mr3IxAwNveBv5zqoZz5oNpoNB4w+kSOo5q9TYsyhO
 6+mpJAo6F8YXcAdKOIYVVUC35nS/7jmHaeRE3mbj/VgL1EpHV5OaW2K+E=
X-Received: by 2002:a05:6a00:391b:b0:837:a211:4ee2 with SMTP id
 d2e1a72fcca58-84282f9cdeemr114594b3a.38.1780415463453; 
 Tue, 02 Jun 2026 08:51:03 -0700 (PDT)
Received: from audgirka.redhat.corp ([171.50.203.65])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm34046b3a.34.2026.06.02.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 08:51:02 -0700 (PDT)
From: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>
X-Google-Original-From: Ajinkya Udgirkar <audgirka@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ajinkya Udgirkar <audgirka@redhat.com>,
	jcmvbkbc@gmail.com
Subject: [PATCH] hw/xtensa: replace calloc with g_new0 in mx_pic
Date: Tue,  2 Jun 2026 21:20:55 +0530
Message-ID: <20260602155058.392042-1-audgirka@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ajinkyaudgirkar@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2026 12:11:35 -0400
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

Replace libc calloc() with GLib g_new0() for consistency with the
rest of the QEMU codebase. g_new0() aborts on allocation failure
rather than returning NULL, which matches QEMU's allocation policy.

Signed-off-by: Ajinkya Udgirkar <audgirka@redhat.com>
---
 hw/xtensa/mx_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 098c1aa..8ded3bc 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -343,7 +343,7 @@ static void xtensa_mx_pic_set_irq(void *opaque, int irq, int active)
 
 XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
 {
-    XtensaMxPic *mx = calloc(1, sizeof(XtensaMxPic));
+    XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
 
     mx->n_irq = n_irq + 1;
     mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
-- 
2.54.0


