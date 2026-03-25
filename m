Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EC2109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMK-0004us-Qj; Wed, 25 Mar 2026 12:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM7-0004tq-NG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM5-0004eL-Vl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxYFYP7I8/UmLBT4u89F6moDzoIJLHvVc253l2LtIz0=;
 b=Tm+u6u9hHhu1YVyE2ni1KaRDGiRXbu8kX+Hjk4XXxmvDnEo0TU7GmQhsUWDvWz6yHg8vZf
 9o0J+IpEpPEcDmsmDSe1NCLvquE5+ynvlI+pS8H4GP3mhRQYZOpgQH6rWVKcWMIZ4/RLIm
 sve+mJwMHYCW8f/HpUPI8tkGZnN4A/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-HeWQe6J3PkqffxAFfQjOxA-1; Wed, 25 Mar 2026 12:45:15 -0400
X-MC-Unique: HeWQe6J3PkqffxAFfQjOxA-1
X-Mimecast-MFC-AGG-ID: HeWQe6J3PkqffxAFfQjOxA_1774457114
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so557925e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457113; x=1775061913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxYFYP7I8/UmLBT4u89F6moDzoIJLHvVc253l2LtIz0=;
 b=BDI/m8VAK7152fQfGarQMhWzOOaVtmQgWuSvK/9LErt2wFwU4H6ZFDju7JquUUkJb7
 AwR0lY63BEQm3Vyi4aZ7gxhzmZi8CjhpYcNi4978WnwEewIiKlqToKUtucgwj1HNeN+p
 mPp9YXWYIDhO22m2sYWg/b8aPKz8rPuEWouj2cogWLnaQktdG1H3GU/w24yCiiKSdCy/
 ntCNu8i26lFSkJsm6hrty96SL8aDquVos+/BBOZHs1lruf6O7PUziykuImGDx5ys2bAE
 5SyRgutCCs5xGbSCPOfXGSl82yyeclM9BmXX8jYtaRVNBIrUDqnbAcOZ9IdYGajN8boB
 Wlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457113; x=1775061913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxYFYP7I8/UmLBT4u89F6moDzoIJLHvVc253l2LtIz0=;
 b=AX0U/MV5/W4j1Pi0FWuzL+rAxXKmxi45LZaZeEjAflEiFh4Bq5/BOvo+XeAoB5RE4T
 rPvLKy+EqRUYHXBMi8ZsCIbZXr579h3F34DORGv7CTHIc/m8Ewz+74pqbgL+77Ilc9kH
 pbA6jBTja3si2mZ2R6Ap3lGcKJGVDagyspABMX9CvVPpmrEedg3RP8TnFJE2GbAgyibb
 FG+gZYMNUZ/2wBzP+UW5WQFL6GSNoBx5WMCmlm8cTF7f7ZDs6Q77chdqDpoMNxooVCc5
 eGedEIpkE/OPjmxW3i6uXoguAAebjEkr5Lfn7iVGuioeU6qKLtLDENOWE4NCs817Iv4K
 v/Ag==
X-Gm-Message-State: AOJu0Ywcghz5YBVMF1BlZj61Zu/X0vNFuocIvSIqGgBEuF9rsCsqInFA
 CMDvcafmCBTtPZ31lC/mYbQB9OaBx+0UWOy0t/IYRuFeUe5avx/RA4W8v9ANyGn9pz6jkWTweBI
 5ncYf/M5+OK3+Mtz3nZYHjhTul7PswPtd3ZSWxRHlFUZKg3FaNHKQIwBaUc3+QL+glPOV0Xk/44
 WsEIFDCnYMZg/ae1Dslkl0vRdAqerPXo9DbZ+UL/+I
X-Gm-Gg: ATEYQzzyeyx48nWuKHZnKp/Cl7BIjB5hW5n+xJc3bh+yaMbbuEmB4HmuT9r0C/dop6J
 YWSBi1n9xrcWTSjLTXobGOXMTHFWEVHRejU1d9uw9eWeLq5+4MSot7F6N8cMTq9kp5KEIT2dkLd
 GIp47pTNdYFpT4EOg1iPQEJ96oz+wNnx67X6ccoA51qdqTk5Iha2U3tofOgoYeGR3PjGQzbQH5N
 DaGP18zjFeneinBPS3ajkUCtuOxD+d3eNFXxUQdaND+k6XL3VklzjXs+qcy2CoiLjiTZQSyQEuR
 K80+CmKLJFxEbalMTa7IZxkHgHedstjdglOM3vHVKIO3z34nJYb/NLPTYVeQwLOih3sb2Nt7Aga
 9DgMkvMojqQx5pboDasjNH256r5EXBcpXaTfA/gSCG9F3pfTL2NL3HbfsMpFm7c5+6isj5tBJVD
 CIPEHXqho5uYEN9TE18qv5UfNY
X-Received: by 2002:a05:600c:1f86:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48715fef87fmr66013445e9.13.1774457112842; 
 Wed, 25 Mar 2026 09:45:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48715fef87fmr66012985e9.13.1774457112316; 
 Wed, 25 Mar 2026 09:45:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711701804sm144417675e9.4.2026.03.25.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 10/19] whpx: i386: add implementation of new x86_emul_ops
Date: Wed, 25 Mar 2026 17:44:44 +0100
Message-ID: <20260325164453.72127-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

target/i386/emulate now has new ops for fetching whether the guest is in
protected mode, long mode or user mode without fetching control
registers.

Use those for faster vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-8-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 69d141e7cce..b97dc9fd514 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -885,10 +885,32 @@ static void read_segment_descriptor(CPUState *cpu,
     }
 }
 
+static bool is_protected_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cr0Pe == 1;
+}
+
+static bool is_long_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+
+    return vcpu->exit_ctx.VpContext.ExecutionState.EferLma == 1;
+}
+
+static bool is_user_mode(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
+}
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
-    .handle_io = handle_io
+    .handle_io = handle_io,
+    .is_protected_mode = is_protected_mode,
+    .is_long_mode = is_long_mode,
+    .is_user_mode = is_user_mode
 };
 
 static void whpx_init_emu(void)
-- 
2.53.0


