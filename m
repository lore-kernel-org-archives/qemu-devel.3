Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A1C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuk-0002yO-Kn; Tue, 04 Jun 2024 02:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENui-0002x5-Az
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENug-0007Hi-SG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HiB4Hw6azSkFPrbk6MCCFjkMKXK9lBPN9bXi9w7Jn5M=;
 b=UWy8mcsZ0hto8fJ4op0RHn7KvM4C/oU2zloG1kBdrx4a7pw77Q7EDnmDtby4udtwNgVTSp
 edjhBHomN9xi1ejLcCUR775Q9wSY9iQtuqfl/lXXCbxVn9XB8+sw6BaSnDQNdCR384nU9X
 AfblNHPKLA/v9RtUESzh6X2VjHMcDio=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-JURd1l2hNYi9o6xEnsCSLw-1; Tue, 04 Jun 2024 02:44:47 -0400
X-MC-Unique: JURd1l2hNYi9o6xEnsCSLw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68e0faf0e6so124981366b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483485; x=1718088285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HiB4Hw6azSkFPrbk6MCCFjkMKXK9lBPN9bXi9w7Jn5M=;
 b=d6N32xT3lOcgwqYeD1QQ/PZUZ8mYjiAOrI6QCwUL7QWQOLnPmxQxGsBQ+fWlHItb/T
 53OCJhl5n9AB9alM/uwJY+J0csXwl8uDH7Wn1BB4YT2GgTlhr9gTgInDC/heGQadGCZ3
 xRc1Zq1cg8ZZgRgQ+qUDIoeOmu6O3JN320YpBzXvgcukKLldDrVNhPI4tQlmE3ohU2uy
 Ht0vfG8N0bug+FtXVcLgUCA49sOPQd3QdsbnCicZP18FHeU4UL6lGxnpDqiC9haD4FWr
 uM+LW9pN0/aFPVRkDPCkfU2PJKTaTSjWWV5mVOQhDZVxTAsJNJIFm8QiyCfws5El9tqN
 YkyA==
X-Gm-Message-State: AOJu0YytYsz6sw4dDsq6rJ8VkXtFfecon9SVn1Xr5CtMoJeYz8z/8AA3
 +p4eMuuAtwBS4PThY4YSWaS20ds2qLM/8aA5bToD6MOdAfAs9o0OfjKehOyOuD0XEeDY1QpViaZ
 DkymNG+68PxJylRK6Mqgkx5DEqEJZ4BH8YInUQ1pX89w48M6Av0Yyg2+up4Iv7QqZjRj1EWd0rB
 nJlvx0KJzggbiyh2JZmG7zleDogujf45bZuqUj
X-Received: by 2002:a17:906:f144:b0:a68:c3fe:c8ff with SMTP id
 a640c23a62f3a-a68c3fecacamr563210866b.17.1717483485284; 
 Mon, 03 Jun 2024 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Sdld/MdeyvJ55F9HYttwz3opkQ2TbPOPX+0uPM4gufad4nGXugqtr1AFaiT0wzK0e0INRw==
X-Received: by 2002:a17:906:f144:b0:a68:c3fe:c8ff with SMTP id
 a640c23a62f3a-a68c3fecacamr563209766b.17.1717483484866; 
 Mon, 03 Jun 2024 23:44:44 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f76cd1fbsm319301766b.223.2024.06.03.23.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 11/45] target/i386: fix xsave.flat from kvm-unit-tests
Date: Tue,  4 Jun 2024 08:43:35 +0200
Message-ID: <20240604064409.957105-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

xsave.flat checks that "executing the XSETBV instruction causes a general-
protection fault (#GP) if ECX = 0 and EAX[2:1] has the value 10b".  QEMU allows
that option, so the test fails.  Add the condition.

Cc: qemu-stable@nongnu.org
Fixes: 892544317fe ("target/i386: implement XSAVE and XRSTOR of AVX registers", 2022-10-18)
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e322293371c..e1b850f3fc2 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3142,6 +3142,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
         goto do_gpf;
     }
 
+    /* SSE can be disabled, but only if AVX is disabled too.  */
+    if ((mask & (XSTATE_SSE_MASK | XSTATE_YMM_MASK)) == XSTATE_YMM_MASK) {
+        goto do_gpf;
+    }
+
     /* Disallow enabling unimplemented features.  */
     cpu_x86_cpuid(env, 0x0d, 0, &ena_lo, &dummy, &dummy, &ena_hi);
     ena = ((uint64_t)ena_hi << 32) | ena_lo;
-- 
2.45.1


