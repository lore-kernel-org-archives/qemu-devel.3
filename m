Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0563CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGh-0007Oz-MF; Sat, 30 Aug 2025 11:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiN-0001B9-4B
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiF-0008Cx-OX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtKc/6E/RbNiUG2cnBtKwsWzbtnSHz0rkgbelCKjpIE=;
 b=ZILVrag0nSG1Xdtq3PKyY8982HYqFLHF5ycpZ293zoKi7BKu6t5evgS/49VC/JaWKTwnD3
 b5+akFA+/nJscL+AWb8wCEOwncsjNVbPqdlf91fkgNCbfdnK1si6dVdK4ze2s30rYUJ+RB
 uzb+oRO+7+mmI2Md+w6TIWky8DRLA+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-rFtJkVNZOvCPV02F2a0cSg-1; Fri, 29 Aug 2025 09:00:12 -0400
X-MC-Unique: rFtJkVNZOvCPV02F2a0cSg-1
X-Mimecast-MFC-AGG-ID: rFtJkVNZOvCPV02F2a0cSg_1756472411
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7d485153so11514745e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472410; x=1757077210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtKc/6E/RbNiUG2cnBtKwsWzbtnSHz0rkgbelCKjpIE=;
 b=biKo3G75l29bBImq9aip44om+K1v1Nj0znij20npPjKiBThLBwYu30mPkq1MmuL0Zl
 5V1dhGfZPrP6+4gwdIQavFoK6EBcV82ZY1uSf6ZzWS/p86YTyv9mtuVgya1IsqsMAZFR
 1GV/8yZwoJ+W3XiX2EpROyOzuoITkBS11/q580VI+lqAM5EMSRhbdsruu00VkSCuQHIs
 q0Edn1iRMqpYTrD9iMjUA+5n2mDOYYHkF4e2lBywlDnKUweiVrpAqk89/UrN7i+y0Jb4
 XtR/XbT15MH/Y/M+inW7maXWMaN4eYcj/vB//8KASYyrWGlu9hMIYuXkGWVoAOmtjyiz
 30uw==
X-Gm-Message-State: AOJu0YxEEGaxkREhNuHlVt+sKsvdHCnWkXyf+LNIt2BXp+NzO0a1pTIj
 QhEqzy90urC2m3YoEZHrJLpWxv1AFsi2IeZKcOONgg11GKCKqSW9d8paAlmSz/LBcOXN61aeyi5
 Tv4lBKTpwd2yTKCkAZTxjvB0buoxMSGrEpmq+BD4//4glvG2btB7a5p9tmlwmE0Oi+3QaLM70Qy
 1yTyYG85sdif8unO7DrzNpz4JcsS/jovK780FNJerv
X-Gm-Gg: ASbGncuQoPO8PhXc5sqiqC/9J1/BT4MnHxhN1ckz4NWafLb64EVG76a2t4rOiEBSmzP
 81Xf0Ho+bgfDMsrUUAf97sIOW8/MHHMQkoVC/lN9TJS/4eWCaCsVHU+mdg7Ab92e2QQKRVHPQmk
 qV+CETZcNTOxbjX2D5PZbDlWcwT7SkhzWvCsoYJDvxkblvL8/d9zupIQxtz2KKflUoy+xJN/yQB
 waULK4gaQJg8U2K6R/U0NKppWUUZ4qMxJKm+yhp9AZlZkaUXsxjcpa2uLPJ9kCx+maX5vT2OiNp
 835PbJVaiEPUBhAuIaCxWB4QaUWY2mRmuqpqU3j8vBVHC5wcCTSvDmzpWDhRj6IXB3GT6arUQ0V
 jzXBOcn8uy9Y9R+75vg/58LIm3T1TkVsdQNcQWbr3w6Y=
X-Received: by 2002:a05:600c:4511:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45b517dd3admr225707805e9.28.1756472409802; 
 Fri, 29 Aug 2025 06:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX+JoRBf+P/lbVcUBADTBMTlEdHqi1xnX586DfxEksSoVDWPSvH7YGXB8suNz7FTMMm2eKqw==
X-Received: by 2002:a05:600c:4511:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45b517dd3admr225707315e9.28.1756472409190; 
 Fri, 29 Aug 2025 06:00:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm3388364f8f.27.2025.08.29.06.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 12/28] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:19 +0200
Message-ID: <20250829125935.1526984-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-13-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0bc033943ca..66dc4a5186e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,7 +445,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
@@ -499,7 +498,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.51.0


