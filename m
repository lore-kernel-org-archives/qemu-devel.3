Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2AACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0c-0005C1-4U; Mon, 28 Sep 2026 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0O-00059Z-Sg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0M-0004LU-JP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STs0haowdBQJueYUhznxr/dKCwcME8Z2BlXxf0P/cyY=;
 b=N7K6tAmk+3n7dNL0Uk0ocZ0stXWVdAm/giuY2KwA2lFVuv5JpGYkCaNXIre8elJhtiTrmo
 U5zTFIefCnM8uLrdlynFTT3bcQHVjpV2sbYrrenaMw4XMsXVxkZS0a7T4JYx43Uk+Amzdi
 MNSjU6P+20wl7py4Km/R45ZY1F6HDJk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-KXtKC38lMfm4WgYuq_4Jig-1; Mon, 28 Sep 2026 09:02:47 -0400
X-MC-Unique: KXtKC38lMfm4WgYuq_4Jig-1
X-Mimecast-MFC-AGG-ID: KXtKC38lMfm4WgYuq_4Jig_1790600566
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c2d93b92937so131803866b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600566; x=1791205366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=STs0haowdBQJueYUhznxr/dKCwcME8Z2BlXxf0P/cyY=;
 b=oGJpwODNhmGo9Af5KUwLVm8Z6JIy055T7zX9sp33sFZcPV8yxb58sMa6+1kuFZyvx9
 m/qnxXuYdIU4/zl5fkXBDTXj5HiVMt565anp5X3p8rbUg4HZMClGPEtTI0NcsXq2Pvo2
 06pa5k56r6a+tHMEYduw5p5f1WwuMwHnxO+ZrUs0DxuFpH/eTF9/CpdOm/wUuPscSZDJ
 lh9rhCin7oeZXQfeFq2eKXfzUCDdii548uNCvicbiB6e177OcAg0PhiNbaIXxyWS+OBa
 CMfLhlgWrTxt/ajkoGHzYSmD5/SPAyjM9kyv+u9owlrvYZRnByFENbY6Qaa8cpZTsc5q
 Bc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600566; x=1791205366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=STs0haowdBQJueYUhznxr/dKCwcME8Z2BlXxf0P/cyY=;
 b=jtVDRQa6ZHeRAdCtbEF9qSoDcg8Ds0hxRWx2TEh6h0Rn+OZO86Qr5EUCZK2AGN+8v6
 qD3HJBObU3uHoIqbcPtgSBRluHq8k+XdsOjE/zBov55VTgy/fb6AlP7XXzeepsm95Yye
 dqZ1sv++aaOuMfVLz6M4ubwzKL/yeo0aNa3wDhkdAMECVZclXNgi5eDRK2sHx0z+jNPk
 UX4Mzm0izxzLq414qJ4FQaJ/VjY7Ufz2qb4RzhoLocG+ar7ybBpiz0xhVhExl1O2PjIs
 CVfT6lVHWHr7Vjhq36oIblLGksk+w7PuVfOF0eymf1w+pL12QOD5CvjSaXGAcqPttAXW
 zQ5g==
X-Gm-Message-State: AFuF++lncp7OSHnxHwsf/5za1n30JjLolgKbYz2xtUbwWh0PtcyMY49P
 uVaF34sTRoRwGGglLdS6DO+mESIhx7Lpcs5v7jgTEaDBQiyt3luKxo8+JcccCXQ/ZB2st/rxePF
 Z805SD6AHaoSnVc98qN+DtrPzz1ns7+8QFuxzvYhsx6gCHdQVcBNtIKCZlwZXWn11aZxujyTjdw
 wMbio42bVKK63NXekj2QpipygESRVMoRiy4BljBU84
X-Gm-Gg: AYBFou2YcMVUWXilVtAmiNT7tvvX6uWne3j6KpwvUuAyXlMrL2bqHkhBfyRkO5GhGmA
 LRhTqIIwRnqgcuJYPOqWGPwi+rXT/RwL7z6Iaj37VGxnbDJb9j/Bef3dB3Ub2Tcy0OhiylFKQGE
 /3hHRxxcRNZC+uF5TtO+fI8WLlQzAcFgGzpSZNBWAWMW3pRVIyemuNeIQkBfweWmEk9K0+Bd/21
 jnNvweyhq0MuTGf7p5R2tH3KtzR8xR56G0pESz3/jmNVIJ24k8m9DnlXJ5NyrG4nEmQdY7hvRRy
 9BdeIE1j0jl0GOtdrIt0ro/ATxLE4Lw/hvzYW9w4oWbdvFzuWu2b5qPG0cv/g6OZLvrrhD+YcA9
 S8U0KYPR7Vd5cZwmnnIcpkG7Y6d7Ujo784X8+nmlWnyr2H9VMDTRvSQJdIvZBkzoDACZFPMHoX0
 nLSYC1
X-Received: by 2002:a17:907:c70c:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c2ac230b0camr1100924966b.12.1790600566198; 
 Mon, 28 Sep 2026 06:02:46 -0700 (PDT)
X-Received: by 2002:a17:907:c70c:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c2ac230b0camr1100920766b.12.1790600565678; 
 Mon, 28 Sep 2026 06:02:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dcee527ccsm200566266b.41.2026.09.28.06.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Simon Scherer <scherer.simon89@gmail.com>
Subject: [PULL 05/30] target/i386: Don't clear C1 for
 FCOMI/FCOMIP/FUCOMI/FUCOMIP
Date: Mon, 28 Sep 2026 15:02:03 +0200
Message-ID: <20260928130228.877003-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

From: Simon Scherer <scherer.simon89@gmail.com>

Commit 6802a4b23919 ("target/i386: clear C1 for all x87 compare
instructions") added an unconditional C1 clear to helper_fcomi_ST0_FT0()
and helper_fucomi_ST0_FT0(), based on the SDM listing "C1 Set to 0" under
FPU Flags Affected for FCOMI/FCOMIP/FUCOMI/FUCOMIP.

Testing on real x86-64 Intel and AMD hardware shows these instructions leave
C1 unchanged, unlike FCOM/FUCOM/FICOM. The SDM text appears to have been
carried over from the FCOM/FUCOM description.

Revert that part of the commit. The FCOM/FUCOM/FICOM changes are kept.

Fixes: 6802a4b23919 ("target/i386: clear C1 for all x87 compare instructions")
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260911105811.16854-1-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 54ff4fe3131..56d093da8c9 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -565,8 +565,6 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -579,8 +577,6 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
-    /* C1 is unconditionally cleared to 0 */
-    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.55.0


