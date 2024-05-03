Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DC6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uxh-0002fQ-Se; Fri, 03 May 2024 11:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxe-0002dJ-ON
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:34 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxU-0002gu-RM
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a598e483ad1so201169466b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750581; x=1715355381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qelxLGP2VCXMcEaYFfotFC/hB/WzQHtK8MoPoOxRZLk=;
 b=SWG7IwiF0hlbTzKfHggGbvPMrDm2eq+V2hDWynWlf71l1HEMpkjkvJZ953/WpJNqvl
 sE+oKstxVoAHqapwzYgfF4yy35JfgxAM3LTLHaeVxPLJ6syCh7fVxTE6oHzZtOporS21
 +vqts7ObvVFxBxmLmdUPI6Zx0fFrJ0IJdlI1OL4eRu2pGiIlg6Eczmc8WfELBedEKD16
 glE/aT8RtC2ShGjCsH8OcoTThwW9KP5fE4HHWH2VsWhN+YadhZETQ6YrurgrFEHudGVv
 rG/uYkRztR+pbXEAEN099Paga7O4psHbPkaA0QNnkDD+mQQVsA/rm+ZjRR8CdWGmId62
 jv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750581; x=1715355381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qelxLGP2VCXMcEaYFfotFC/hB/WzQHtK8MoPoOxRZLk=;
 b=xNAkCdHc2+wOHNwwXsDgPFeATVhp15bppO9Ay4cWChYBxXe8Kj1UyPAL1vq3DMhcQZ
 X70oMhAESt28ZMgB/DXkNclnk8/cz7AQUnAQazV+yT7RO5nDPbY2aPB8oCKbwJ1ey2rR
 AYK6tgG150te4143BdpqeIimboUC49fyhljrjWO3t8B0uu+dMSYLDYOjkUrEITE97vKa
 6p4IuSZyhcWXJwOKn3fMP6Yr3q9/g8NWKAtGOn6Ds4aW6XFmWt8iIEN/Vw81BAz2tx8j
 l5LKu6Jf24zePfxvHoiIOZk7Y9VcK8PldUL0PX9UenGH6f+3OVV+zq9c95TgCjmVs7JV
 8FuQ==
X-Gm-Message-State: AOJu0YwBEWSv+PWqH3RZikcaK4IwI5M5T9LD6RdTylTefGU3kI7dXfsD
 yttJcFkmnyjtS686CsYnsSlGNmoYa++ECoobAqF8WztJ2m3uzuVUJqSdt45q5H3GqIlOqsW4E65
 I
X-Google-Smtp-Source: AGHT+IHP8UgbbxZJkY2wPsKk10m+06Fv5PmLStsZ2jm39BEBjX6hxZnELZdZjJRlxNGSwgNNkwXtjQ==
X-Received: by 2002:a50:cccf:0:b0:56e:2cfc:1d3d with SMTP id
 b15-20020a50cccf000000b0056e2cfc1d3dmr1662067edj.16.1714750580994; 
 Fri, 03 May 2024 08:36:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a056402074400b00572b2ad900fsm1763494edy.46.2024.05.03.08.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/14] accel/nvmm: Fix NULL dereference in nvmm_init_vcpu()
Date: Fri,  3 May 2024 17:36:00 +0200
Message-ID: <20240503153613.38709-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When mechanically moving the @dirty field to AccelCPUState
in commit 79f1926b2d, we neglected cpu->accel is still NULL
when we want to dereference it.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Suggested-by: Volker Rümelin <vr_qemu@t-online.de>
Fixes: 79f1926b2d ("accel/nvmm: Use accel-specific per-vcpu @dirty field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429091918.27429-3-philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f9cced53b3..65768aca03 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -982,7 +982,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    cpu->accel->dirty = true;
+    qcpu->dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.41.0


