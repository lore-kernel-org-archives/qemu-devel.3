Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4979EC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zU-0007Vu-SJ; Thu, 20 Aug 2026 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zS-0007Jr-1O
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zQ-0005hf-A1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fJlPytlgaiUE+eQaKMwRmE6INF6QyKWPU9Lu5/h3MM=;
 b=fk6yRcdV8UZbKYRKUO37P/LSo/AJm6pn+UdxSNZoyR38vgHcmIYmry5pxF0J7qnPm6ChvO
 OuETBnNIOXHe2+jg7srv2cOEqPnMGoxSY9WTtcocR93knCLJTuFn4DK/9q+Gs9wWEDIpkc
 6FQNBZJBFZeSMA9fTQyQ+p4UYz6aPdM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-FjVnfsHXMbarAXgfL0PFKw-1; Thu, 20 Aug 2026 12:51:38 -0400
X-MC-Unique: FjVnfsHXMbarAXgfL0PFKw-1
X-Mimecast-MFC-AGG-ID: FjVnfsHXMbarAXgfL0PFKw_1787244697
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso92732f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244697; x=1787849497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9fJlPytlgaiUE+eQaKMwRmE6INF6QyKWPU9Lu5/h3MM=;
 b=suNPHJBZrZeAVVwjmd3V+eaeW0HreKdTv2hjQmT3/Jr5erl55R9ltVCfFM1mxIh2/P
 a8z2maZk0l5EuTR4yMyEW2KK78NNkKnMHxqXKojcx4jmf0L2dUG/VZ+03rat4irGAMoC
 8IsHaSoxGVnse7QXwnlta+7mEShEaUXYvShX0DbVUt1ttd51YR8xgsw1qUwly/rpOw/Q
 Cm3KZZuIT/wQxm/AirjGlbPQ67Fl+H+y56+WQ6peA1pE+mst/ABz8d64jDalR7E9+whS
 AXbeLGxVnsKPGgRj17SvGmJI1PINm8eVXOPmPVrjIaxTivy5d8aJTr1+809MBdkqegDO
 NHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244697; x=1787849497;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9fJlPytlgaiUE+eQaKMwRmE6INF6QyKWPU9Lu5/h3MM=;
 b=Mus/xNOV/L85LiZQ5GK1pi0tNiyCYbTfiAjwgA0R+O4yzS5+P5QvmNbvaFHhLkiZC0
 VfCCkE4ywAutSC8XrGCAJxXT+GYu+YQcBvbbQ+zWtsUzZVQ69kE/kgMdy9Be7NjYU477
 gaU585NeHGiG5i/J5pYos2lymgH2lwi+2s2fN4tAcwUV2NETl8FdA0tC/pYVGxweOz1T
 VyNYj3m4xTfoXDXLGBdsAK+MlRWVba83rm8jqtNRrPXb+dg3X9tZQaw055b1JkENt4M/
 GUiBqZrSdbYTzw8xwjZxF5z51NeMFB+usZVtuY/GLDXctxMLAG3TO8oPXWYQQv/KFYsD
 AUsQ==
X-Gm-Message-State: AFuF++lDedVSzA26ct3s2W6qIOwj3QPJp54LtZbOl8u9eQHThdnsMGFG
 8AgFgILL6ZXfFHYXmfmyH9MRw3HWU6wtC3Ih2p2Fygg/aOhRH2HAt0qQHERiuyjCdSai5zKreGL
 rQ6f1uiH0TkL4LIpajzOVkiTsRMsIkHMMKlqXXMPd1m5/BR+fG1YGcv4c0pCT6xwC9Uh+pvsUkb
 +g9ftBvp2/+5R7dUsyQUnmFFAAncJqPHXTpc2Dimt9
X-Gm-Gg: AR+sD110NgWEcPsTGf812HcCnoOrW0WiYJhULGaqf1CSqdPiQF4Zo8lvYo9FPrwWa6j
 QobkcPTLCjeipS8rz4j8LwdtOcUS1wd/clXvcWVO5rivl9v/DTBVZqWNVejwR05wk9b1NYRx2ml
 nYYYxyiviPKRb73fXjg609tY7docegos/nakSuPoAqEwXcLjYF6PqGAQwEWPGVLmBD3aEy7qJ0x
 46PefKM5k2Yh/EJwaiOhXDf6yur0FYo8Ng4REY1sKPfnXjll1bYTeDi0j/avtpkGK5gRG9CVbWq
 4dVuGVlHWn5ZwsH2zYkMYmYflu+VGew/rLiHoDlNJnrxRfTdIJzrHD25xrjxAS7GKeCGQ96pJUY
 MJXdB5GAaYvS0U/riE0mwLroz2KX9BahG4ImyCCuhY+/Er2oZ+1ba2q5yt9MpsqZVGcEEczOyDZ
 N1uMc=
X-Received: by 2002:a05:6000:4811:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-482c0b4ef34mr35997f8f.9.1787244696975; 
 Thu, 20 Aug 2026 09:51:36 -0700 (PDT)
X-Received: by 2002:a05:6000:4811:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-482c0b4ef34mr35898f8f.9.1787244696518; 
 Thu, 20 Aug 2026 09:51:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d23sm14711535f8f.22.2026.08.20.09.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 34/53] whpx: i386: synchronise PAT too
Date: Thu, 20 Aug 2026 18:49:37 +0200
Message-ID: <20260820164957.1895963-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

https://github.com/cmspam/winq-emu hints that this might be wanted for
some use-cases and it's a step towards full state sync:

> Linux uses PAT to mark virtio-gpu / Venus shared memory as
> Write-Combining. Previously the partition's PAT was not
> synchronised with the guest, so the guest's MTRR/PAT cache-type
> computation could fall back to UC for memory that should be WC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260812082814.27217-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 1800ba8eb19..2739a80da36 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -115,7 +115,7 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
 #endif
-    /* WHvX64RegisterPat, */
+    WHvX64RegisterPat,
     WHvX64RegisterSysenterCs,
     WHvX64RegisterSysenterEip,
     WHvX64RegisterSysenterEsp,
@@ -624,9 +624,8 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
         vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
-
-        /* WHvX64RegisterPat - Skipped */
-
+        assert(whpx_register_names[idx] == WHvX64RegisterPat);
+        vcxt.values[idx++].Reg64 = env->pat;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
         vcxt.values[idx++].Reg64 = env->sysenter_cs;
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
@@ -962,9 +961,8 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterKernelGsBase);
     env->kernelgsbase = vcxt.values[idx++].Reg64;
 #endif
-
-    /* WHvX64RegisterPat - Skipped */
-
+    assert(whpx_register_names[idx] == WHvX64RegisterPat);
+    env->pat = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
     env->sysenter_cs = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterEip);
-- 
2.55.0


