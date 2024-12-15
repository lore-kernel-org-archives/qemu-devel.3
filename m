Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F02EE77184
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaS-0004cK-4b; Sun, 15 Dec 2024 04:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaQ-0004bU-KD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaP-0006zD-3z
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ln+83d/zkp6fFGfT0f7BeAfE0lUk0lgGm7eEEbWaZJc=;
 b=PISNlKUeGpEHRv/faO5ntE8GfYWB+1FG+ZroZz6HwXZ43JBtzjGItzQHvkVY3m7fSowfHB
 5XvqmJznYovMRoHSrkj3ivmQOEtTv500PK5xQOOo/IZOtzm4mmLceMDFrMJuPYRBDADO7O
 TdaSPt+hfvQAgOErlOtznNoOaJjZGGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-f4I0jET3OJKWjSqSJn4A6Q-1; Sun, 15 Dec 2024 04:06:44 -0500
X-MC-Unique: f4I0jET3OJKWjSqSJn4A6Q-1
X-Mimecast-MFC-AGG-ID: f4I0jET3OJKWjSqSJn4A6Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso17281315e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253602; x=1734858402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ln+83d/zkp6fFGfT0f7BeAfE0lUk0lgGm7eEEbWaZJc=;
 b=j87zspTes1E0a0UzaZKlbEcKrCzUgfWzXejEgrIQ4NaFIdi9+In895AxeaaQ0RhRwo
 gAhhyi1wUghuNGrWrsWXbI4rj6YouC0Vy92jxplnsqiPtx6GNFlFke8dqpGOpKFUwrf0
 1MLE/PZabw9/9KhljN9setepOS/OWvX5I7zkGWHDrO4Yl7o2WlMxx2r2iQ5GFYbm2Fbf
 vD4y2eITuVK5VXrnNVYRWSv2bse0itkQrC0c0WM4OPK10+C5S133qEuywLghJUk7YOU0
 9N1Z6Z/s9jOHVhgN3jcdNGEOtDfYLUpn2D+Jw+eYfxQRIH1LstRq3jdw0mZIkoGfP8iF
 rFIQ==
X-Gm-Message-State: AOJu0YwfBAKH6RHVAkBEdQQw9n0Dk9K7DF3NYpAsyy3tLJrsP2uNjwd9
 Atz5v05vO8ryCAbtfpBMJkbPoNtJmX6MOzWManTKKIgypRFqMKP1Ubvi7sxSVy5R6MsSkX99Wu5
 Pe+cdoi8oSs3LW/mQy/iri2KUW2NIUx0jGG8PIrMUMBx0OaWQKcrcxpYy7E7qQlxUac+OxiU+w9
 mAucrtAaYT3Z7LZt8SL7jMDxLX+Mrbh4ue41XB
X-Gm-Gg: ASbGnctnpJrjQkwgfhiBmxU5e+A1E9A/c6S4QdHRLlYewO/3fsNgfvOa3JxWdNHOTov
 j8RT+BpG2/xw+3OXNyrv6cr3RYE4SgRyL6iFnNX1f08kQQyFJ0LA7OJzMWNvUvDJRrVLyKGn3JW
 xQf71JCipZVpNmtkFppGRuBZ2YDfKifrB97kCRFyUHdNUirdVvDh4n3cUt79NFhyXZUyDx+eXnV
 UXOqvCKWSPE/E9yeINhMytJQOxvklcat5R/L/028jc4/KgWnMDp8BzxU9w=
X-Received: by 2002:a05:600c:3491:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-4362aa66f9fmr83696035e9.18.1734253602131; 
 Sun, 15 Dec 2024 01:06:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFJ5BR7dc4oAYyQreVT3zYJuA/hsO/26W/PF8wDJ8c/kNRR2uejhec11Q8ymUB3ibKDc279g==
X-Received: by 2002:a05:600c:3491:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-4362aa66f9fmr83695755e9.18.1734253601681; 
 Sun, 15 Dec 2024 01:06:41 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257177c5sm103082705e9.43.2024.12.15.01.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 09/13] target/i386: do not use gen_op_jz_ecx for repeated
 string operations
Date: Sun, 15 Dec 2024 10:06:08 +0100
Message-ID: <20241215090613.89588-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Explicitly generate a TSTEQ branch (which is optimized to NE x,0 if possible).
This does not make much sense yet, but later we will add more checks and some
will use a temporary to check on the decremented value of CX/ECX/RCX; it will
be clearer for all checks to share the same logic using TSTEQ(reg, cx_mask).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4b53a47000e..8ef938372d5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1336,6 +1336,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        bool is_repz_nz)
 {
     TCGLabel *done = gen_new_label();
+    target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
     bool had_rf = s->flags & HF_RF_MASK;
 
     /*
@@ -1358,7 +1359,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     tcg_set_insn_start_param(s->base.insn_start, 1, CC_OP_DYNAMIC);
 
     /* Any iteration at all?  */
-    gen_op_jz_ecx(s, done);
+    tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ECX], cx_mask, done);
 
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-- 
2.47.1


