Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BE5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXtq-00035d-RT; Wed, 24 Jan 2024 02:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXtn-00035G-SR
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXtm-000347-DC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33929364bdaso3477181f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082132; x=1706686932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEohNbICE64fiWDiipXLr8WUwbdgtkPH1DVHZNt9exk=;
 b=DDoeCPLV3fFdSGskkVyIHmGNphkwkXsjo8m5f9RbvmH1ujm1tMDBaPxyEjJiycBHcn
 WW2WmuQ8vfySck3aHcc7zQReQYkaaLVxY77sw1NoF4jkAoYNXonlooH7YpezGpamod9c
 6aOAqaJOT4H1qVsH0s/O9DIQSW6h2OQleRY6GuKcQ4yavBHJTSlpBj4pHIkdnYldK4V4
 Mhu+UAf2NQDQZ2b2VlWjNKj+MltGGxLk1gBetlspNqP+yKbOg1wfjlZMz5H1WBU97oqd
 lv95mvGPo52b1bgYBkDS/HBsKnHSgFc8yFc0sgA+ZQNFg8j4GhIb1Nr/3TDN+ievcO2d
 VTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082132; x=1706686932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEohNbICE64fiWDiipXLr8WUwbdgtkPH1DVHZNt9exk=;
 b=hroMDtLdGaI+TeJ432ZKHXKyS87Zy7gb0zOjr/XnwkGYG1EMRicCCNuZekqb/dcc6Z
 /vgMoxJeAAKUrvruSXMoB5ZNCvit/kj4pfkXDIPPDnISsbUzHjbZk6RSM+evuUHje62r
 wyAPlXsvCoWMhouBtfgIssL18/6P2iG8OpzKZ46sGRg7N0p36GxBmpbGi42MtQYgEXib
 Edp2ArLoPPeMP73OCPbEBwIMS63IMbWwoDXqftqVY1Kz6mMc0PcJaGhzNmshC46/IW3A
 MR6AuQH0TiXxbinNFuFsFcC+/u+cE+B0Osf8AcDhVlJQ28YLQISWol5B2kpbOJTL7iCr
 0jig==
X-Gm-Message-State: AOJu0YxXC6k5aKtVazzfssk+h5AfkjzeMy0HEQffQ8Eufi0qxbfsu9Ho
 5TFbC2h1Y88faKqN51jP9nIAc6OdeP1W6mcpgraUROHANJIREMSvd/Nrf0l2jounrAAnjw37p9C
 I
X-Google-Smtp-Source: AGHT+IHrso0aJRBQ4AHG205wcbVar1gNDDJjgpVJ9YUvs31G9E16/Icy29W00MKEI9uqtyUfiMBSnQ==
X-Received: by 2002:adf:eace:0:b0:339:2c1a:5d79 with SMTP id
 o14-20020adfeace000000b003392c1a5d79mr267975wrn.6.1706082131894; 
 Tue, 23 Jan 2024 23:42:11 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 v27-20020adfa1db000000b0033946c0f9e7sm2977610wrv.17.2024.01.23.23.42.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] accel/tcg/cpu-exec: Use RCU_READ macro
Date: Wed, 24 Jan 2024 08:41:56 +0100
Message-ID: <20240124074201.8239-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074201.8239-1-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace the manual rcu_read_(un)lock calls by the
WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
"docs/style: call out the use of GUARD macros").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 67eda9865e..6b3f66930e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1070,21 +1070,21 @@ int cpu_exec(CPUState *cpu)
         return EXCP_HALTED;
     }
 
-    rcu_read_lock();
-    cpu_exec_enter(cpu);
+    WITH_RCU_READ_LOCK_GUARD() {
+        cpu_exec_enter(cpu);
 
-    /*
-     * Calculate difference between guest clock and host clock.
-     * This delay includes the delay of the last cycle, so
-     * what we have to do is sleep until it is 0. As for the
-     * advance/delay we gain here, we try to fix it next time.
-     */
-    init_delay_params(&sc, cpu);
+        /*
+         * Calculate difference between guest clock and host clock.
+         * This delay includes the delay of the last cycle, so
+         * what we have to do is sleep until it is 0. As for the
+         * advance/delay we gain here, we try to fix it next time.
+         */
+        init_delay_params(&sc, cpu);
 
-    ret = cpu_exec_setjmp(cpu, &sc);
+        ret = cpu_exec_setjmp(cpu, &sc);
 
-    cpu_exec_exit(cpu);
-    rcu_read_unlock();
+        cpu_exec_exit(cpu);
+    };
 
     return ret;
 }
-- 
2.41.0


