Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC62C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApev-0002Jx-6K; Sat, 25 May 2024 07:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApet-0002JV-N9
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApes-00040J-5P
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xGlyA/FI5OW5CcwO6tDBjZeAqJPAIk1z3SFIw+wSBU=;
 b=NyHNDQ2fQ0vQaeh89O6yAHtKGZk99btgJYPNlxiJ6dCvcwAahENTYlmMqegirkArNCORPc
 RWrlED2TcFi2r3xVmki6URhJcr8AoV6nQVUkZVnlwtIVbl+4GYmGk3jSvm0ZmyntmptfWB
 A/bs/p134lE+oD8PoP1wqDTf7gJ2QoY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-BUXMfdYhOPGBNk1POMpYGw-1; Sat, 25 May 2024 07:33:52 -0400
X-MC-Unique: BUXMfdYhOPGBNk1POMpYGw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6265d3cb71so72914466b.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636830; x=1717241630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xGlyA/FI5OW5CcwO6tDBjZeAqJPAIk1z3SFIw+wSBU=;
 b=U8q8w5r5gRUuu0vU/jKQzh49PRdfjKacsWbjgMDfwcPZTEy/mgVtaahrLsTnbUTAk/
 +/RSJ5VSN5ipoM61eJXMWoUa6RR9f0I9oJGm2dAoGnpprqqPPq/J+FhrK9e8BiaA0OIX
 e3dat84d1Wx9zUeHSzE6BiD2iDvuWof4ckdGA38UEt9JuJ+Q4zaeiDlIGpZfC3SKxYIN
 E6rmLnL+wANw66fE3B+Mae6TaxwClotdz1z8CkcuEoAoEfj+tCVRzwN0/q9PYu/FbFj8
 FyGS2zJGSFUZcSp0OnDMTKC16nVJD5GwhiD5p6m+JOIwgmnn2EcBZoqmSNAyyEJa65mu
 NWEQ==
X-Gm-Message-State: AOJu0Ywbj9gmfo6WKDV6C3x6jxeFMHqN8b/m1VPYjd7nlo5oLBoH3GOB
 GDt3sKbUN1mAaUoZalqO8HZyF0Z9boldg/iZ13yhx+iXZmrmMCvuhg0h4yB2owK3qcsitxtxFAH
 +zrS+X1v5Wl4rAakiw+Vfpa8yovRkMu49waLIZeLUlxUM5Pol8VVbR2+lD4Ds2u8mvAnaTVAYrR
 B1gL1RggAuNK7FQE4ZWY+tjdX/1dvMz/AlzIz1
X-Received: by 2002:a17:907:82a5:b0:a5a:3da6:7712 with SMTP id
 a640c23a62f3a-a6265134c8fmr262099866b.71.1716636830210; 
 Sat, 25 May 2024 04:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECDFvnDg2OHd4yByoyYyCz2OQVGN6bni20WVtP/R+6pam4keYJEp8lByhIon+9DWzPprApBA==
X-Received: by 2002:a17:907:82a5:b0:a5a:3da6:7712 with SMTP id
 a640c23a62f3a-a6265134c8fmr262098666b.71.1716636829769; 
 Sat, 25 May 2024 04:33:49 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc5147dsm243608666b.124.2024.05.25.04.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/24] target/i386: cleanup eob handling of RSM
Date: Sat, 25 May 2024 13:33:12 +0200
Message-ID: <20240525113332.1404158-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

gen_helper_rsm cannot generate an exception, and reloads the flags.
So there's no need to spill cc_op and update cpu_eip, but on the
other hand cc_op must be reset to CC_OP_EFLAGS before returning.

It all works by chance, because by spilling cc_op before the call
to the helper, it becomes non-dirty and gen_eob will not overwrite
the CC_OP_EFLAGS value that is placed there by the helper.  But
let's clean it up.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9782250b20b..849864d1aa2 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4488,9 +4488,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         /* we should not be in SMM mode */
         g_assert_not_reached();
 #else
-        gen_update_cc_op(s);
-        gen_update_eip_next(s);
         gen_helper_rsm(tcg_env);
+        set_cc_op(s, CC_OP_EFLAGS);
 #endif /* CONFIG_USER_ONLY */
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
-- 
2.45.1


