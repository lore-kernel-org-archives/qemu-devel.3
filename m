Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB2CD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVAwe-0006ld-5b; Thu, 04 Jun 2026 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajinkyaudgirkar@gmail.com>)
 id 1wVAwX-0006ku-Ov
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:29:19 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajinkyaudgirkar@gmail.com>)
 id 1wVAwO-0001RX-Dd
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:29:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c858dc05ee3so667781a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780590543; x=1781195343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EPgkZ7HBYYZmE75fClS/aa+EIZAOfW9QZxpiL3LdhoM=;
 b=MZqarSMOjkbNnKe7/DNrOXcS9Cbpu/pZ4bxemJOZ5GvQWhPHhrbuflBVuxNfdA8Nr2
 pUOmr1C/VIgpa603I6IinysYHxwz5TE2I+TVpTfDIaYAgx1Wy6HEu70mutLElZajO5gC
 OS6CiWM+Fvw/1I8b+z2Oc5zlEGoN+kf01CjCJpQEZKxtlrH7uBt5Lg2WYLeVjVp+jZSq
 Rc9m4upIcyiGF3Iile9Sm2pS8WKfBWQXapbXRr2haAV9rava3Cu7tscDqDihcgyy1dbA
 7A9ZQNpGPZWl4aU4E9uax8FprOUFHW0rS3rLQlFvTNBjHK+vykFd7HSJUms2G5G4mzVU
 GR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780590543; x=1781195343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPgkZ7HBYYZmE75fClS/aa+EIZAOfW9QZxpiL3LdhoM=;
 b=Oxodf6A9E7nTvavP9Go+Ol/YGiapgGkTYUSBVfXEBo/4YCIUGeq80kFJkIMqBowmKF
 XhmNts19HSkYKzTjgyiluYIfzxLfEy2fBfMaJXcze3GzrtQFAwaka095gSmXqK4v4wx5
 xPfITfEVfmOOC78tsQbytvDwWgVIvhVd4nhtzD7vqsd+Z4lboJ2s1Q9+6yexqXDPrsAp
 osnRtVf75dsi+IXZkQZnhuHlcp3eyt6OG7srnnYBU+yNMnqOvnwCfOn9qkva89K+guPo
 aZlgGpqBvXHHF4mMVJdLUtHMCNOjqBcmI/Y79+o9Sejp/4rAYJxKoMI+jns9L7zEp771
 9mkA==
X-Gm-Message-State: AOJu0Yy0GEPbGc9z4JNSWGT34WboD4y3ut01lwjVacBA6lxc49jY5pjS
 tbKeZQtoaJhh9yWQEI72s2T4ip/C2szJLizxSf8jcwfJVrnr923B1YKmsOYpBg==
X-Gm-Gg: Acq92OEcDqDl8WLIlZKrelEF0u7aplpce5j1kkdTPIViJhg0qkKyR+PgJh7uek/6jbY
 S4bOhJgJP22vrxojSoKJJ27M7XzjvoopYO8T7pQvQLWh6TYkxXgOcLKGpco12NjKGmAcXaWlvCM
 /YQp4hZlhLw9vY0mfERJWb2wflYjKz/Zw91MZNIENtraIJr5Rhqx+mh1X7ikSECGM0mP78CYfVP
 NfAy8d/QnyIGOjPMUeMvLkr6zTSrolh2asO+Rbedu/x28N5SiFHh0E1U3WHlEQzq9I/0nJbvW2i
 ONCx2ZxdU+QheGTScQgqeBxFrVu0yDYg4DdfdqsaVzuDZQe8FBomSOhJe6LXZ60r+Edtl2N6KeC
 PDQSg1A+52XXVL6rmAhwtZEYpyz3m7if3Qmd+8t3BAV6wkOjsI1REz8VzPIYeOVMOACJxhhdPRO
 uX4cri+QMKbPPOsj2/CcZt0YTIi6YDX1NIy4z3W0i+E2N0
X-Received: by 2002:a05:6a21:6196:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3b4977f5e41mr10315429637.33.1780590543015; 
 Thu, 04 Jun 2026 09:29:03 -0700 (PDT)
Received: from audgirka.redhat.corp ([171.50.203.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df034ab9sm5330420a12.5.2026.06.04.09.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:29:02 -0700 (PDT)
From: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>
X-Google-Original-From: Ajinkya Udgirkar <audgirka@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ajinkya Udgirkar <audgirka@redhat.com>,
 jcmvbkbc@gmail.com
Subject: [PATCH] hw/xtensa: replace calloc with g_new0 in mx_pic
Date: Thu,  4 Jun 2026 21:58:49 +0530
Message-ID: <20260604162849.199541-1-audgirka@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ajinkyaudgirkar@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


