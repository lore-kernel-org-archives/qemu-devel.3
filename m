Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE9EC5DF8A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yQ-0003zH-6W; Thu, 20 Aug 2026 12:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yO-0003xE-TZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yK-0005Qg-JD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiJl2dNtWQnuX8TF6d6ROEUtSKSgJ9L0QfU3Y8MrLVg=;
 b=LOdaXGxBCs8kDATGvSeIaU3P2fIgDiKiC6Dyqo2lHtHM1MGFW3tRCZP0B8sACBW1KIMKmQ
 68dBUspHIob1u9EC5ZQpCEcEPIwODTy0apsj1OGNxb+3kjMovADBdqbfx5buxVI4l0aQko
 EPvyvgGIZCLBAX/nJpiSiubRjNi/ooE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-9GM82UjuP_Cgsqz9jGNA4A-1; Thu, 20 Aug 2026 12:50:29 -0400
X-MC-Unique: 9GM82UjuP_Cgsqz9jGNA4A-1
X-Mimecast-MFC-AGG-ID: 9GM82UjuP_Cgsqz9jGNA4A_1787244628
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83416551so82202f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244628; x=1787849428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WiJl2dNtWQnuX8TF6d6ROEUtSKSgJ9L0QfU3Y8MrLVg=;
 b=ZJ++ag7IhLdaPwluwR6hNdLkjMqJY2Y1ebPYT9S7tInstCRGTgEhB+FjhfZ6K+lAQG
 bgd+2Mn/nWafMutpm4/7tM6Jz7SkwxGEgUcPmZSwo6aaeVhOjP9cN3GV2qKrakaUUGPw
 zEzFZCv3L8JRksYGnoBoKtiNbAMZwN7NgIfeE1uFBploQEBXWTSzl+USnKUIVcJM7yLR
 HR0UtCP1WBdhOeP6c+3e51VfNMNsyD4N8WFRpIJcBq7ZaW07c0olhACplGl7yDm2y9Ca
 pr0t3+6CrEwu3K9jfUeywPIP7mpD3XgJb1e517zI23rNNZplhfRIC8FLOx4SMydZdNMW
 SCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244628; x=1787849428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WiJl2dNtWQnuX8TF6d6ROEUtSKSgJ9L0QfU3Y8MrLVg=;
 b=Psn6UP1mvMtmx8JnFdOmZXR+eGAB0trw0rmIW8bn6SfzjoH3xbMT02SBz4NQuh27iz
 xVDdiOQqYs5u0lpE2TC20cyKrM8ujkQU02uq8gCfsCaJp4PZ06apvU6F5A76drS0WVJL
 Y+1pQn5PAYP01ZkpMWpAjcqw4/z9IQ8eIZFj9StbwDeifSDRSADWVNpZFFD7tEupMNFp
 yYtMsLBfVDhYVLKg4ywR6H6OdpV1UrD2LMt325sks/RHQnw4phX868M5g3p3hgj/sDLz
 pqIlMaooQtqA8pIYrSVmSxYY0m04OgB39TXUxmVqQM42WDUACds2Rc+IZfdkd6ZJkO7W
 2a/Q==
X-Gm-Message-State: AFuF++li74/qgY4w5f9MwMWxjZLn6POe1ASrYhagexqH2ikXW4leeLUn
 AnZwDLAXFYDiH2EqllxlYmYuoDLSxIs/1I1tOgHyqq742DqgxCuiA2aLEVlX3KsF50ltTmTSGD3
 F2AGd8NdWYsGotjPa9pcroxv4BJtcflSsbXa+8BxGt1Wfxwwa8lvzr1PTI8xJhABEIwAmDQA2NP
 7nuTxX/VOA3JCtA2lEN5/rWKXvBTEXC6/m7NcXqHzG
X-Gm-Gg: AR+sD11M4F4q6rPR5T0fq89j5QnGdOY9chWv43Z9SkUNgrWpDvE/ag/t1NtFCLyhQGz
 FvGXZx3FlpuPWAvU362tXeIVKXkQqKI546a29Ah189mfjair88nMVajYye5x7rH983f30Va5djU
 C/ukIPd8WO+bU0J2z7GZsKcpUtoExBMj8R83IpGZR2MWsdpdgKgDZRNVThwNugSRui1tnrFXGb/
 vXPB3qJOVvIoBBfdmYdSUhOlfROrhVjhmG11q28cvdHgW8hA7G8RiDJn9Mzifl21AsrVK1Gkgdt
 MpgYXX8b1RvVBIIPounEA/TOl7Ag3XxZAQXaVPWomevp5iNNxRJYlf+YkhJ7toUmTkPvpvOZqeh
 jnHGE18ZjWWatXud7mdcPP1FdVpzUoADIGveBk5vC9TvFTxkycSXpTCfaRRZlC2talVnIqDSb80
 CdqNA=
X-Received: by 2002:a5d:6f18:0:b0:482:ac0f:707f with SMTP id
 ffacd0b85a97d-482c0b55e10mr12476f8f.1.1787244628204; 
 Thu, 20 Aug 2026 09:50:28 -0700 (PDT)
X-Received: by 2002:a5d:6f18:0:b0:482:ac0f:707f with SMTP id
 ffacd0b85a97d-482c0b55e10mr12352f8f.1.1787244627790; 
 Thu, 20 Aug 2026 09:50:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d055dsm14255332f8f.34.2026.08.20.09.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 09/53] target/i386/mshv: toggle fpu/xsave migration
Date: Thu, 20 Aug 2026 18:49:12 +0200
Message-ID: <20260820164957.1895963-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

MSHV exposes overlapping legacy FP/SSE state through two paths:
explicit Hyper-V FPU/XMM + registers and VP XSAVE state. There can
be subtle inconsistencies across migrations when XSAVE is written after
FPU state.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-12-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 8eca01a8fae..fa15e399cb8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -950,7 +950,7 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
-    ret = get_fpu(cpu);
+    ret = get_xsave_state(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -960,7 +960,7 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
-    ret = get_xsave_state(cpu);
+    ret = get_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1506,7 +1506,7 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
-    ret = set_fpu(cpu);
+    ret = set_xsave_state(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1516,7 +1516,8 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
-    ret = set_xsave_state(cpu);
+    /* INVARIANT: legacy FPU state must be restored after XSAVE */
+    ret = set_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
-- 
2.55.0


