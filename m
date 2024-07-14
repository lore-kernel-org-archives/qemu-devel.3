Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F73BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8E-0004nJ-JX; Sun, 14 Jul 2024 07:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8C-0004fI-Ix
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx86-00022y-Np
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=ZMXy27Z9r2cbzNBvMq5uw51o7l1gUNw6CgGfW54UbPZ9FmS+0nTZnakb4VTQ5ziALhE8Kd
 i0zD5SXay0UsnLzJiHkrJEWViCrntbjnG2bU5XKHPLOCRig2fiSwk18jWke/AoegiV0MPB
 /ZJwN5OWTO2A8VNCB1xWdI+47nMWxQc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-mH1_8B5tMBCkrLuPWAwJtA-1; Sun, 14 Jul 2024 07:10:52 -0400
X-MC-Unique: mH1_8B5tMBCkrLuPWAwJtA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367f1dc92e3so2125655f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955451; x=1721560251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=WRlqI3NaLDc+33/k9Y6YmJVrRbU0MXYNcryUA/2z+DZb7KlcWMy7E+ecWq2iZviqVA
 fy2to6zLkFwRtV3qW9lX4poupDt+pQUcMEnlO6fUy/8WuF3gpdS7dfpwOUc4/Ha/E4dy
 t+4V0zUsXt6D9bU2Oj2gMbwMTADh5/xva3ktTsxM62qdw7Zxir2Ii0fMJBTc7n40ZPaf
 cb2mgnuNODNgi5f6QlZiQBpE/a4ar6RKHIr0dT3Vp0f7o3wIS3TQZCOgk6OiRaAfL/lh
 YNUvM1BLv22k3oPvcCMtheyAZotcB7c8vO/oOkleDpRL9Mww6qs0wlpvF5D1mrUW+8ba
 lWxg==
X-Gm-Message-State: AOJu0YzPKeWLOGXw3kddX1GriyHpK9OZoRU7H5nQpbQxEJNcC6cE/lVn
 tRLNXBzn3xm2ir9T1hxwmtIK8wjnEhWNqJfTHzb1YujmcsSfvnp1RioevGPdcvyODJjSqnLOZ6w
 T5GIqF2Q5hj7qEPuniHzMnZuqf/MvrduxRxW7TgvMXtmYH84lgTHwtFFaS828cYd1s9/EvmaP4v
 vWx1MknZgr5dBWS9EsFDMe/SJrbs80U2w7bIYm
X-Received: by 2002:a5d:4a42:0:b0:366:e2e5:c323 with SMTP id
 ffacd0b85a97d-367cea6bfb2mr9878886f8f.19.1720955451318; 
 Sun, 14 Jul 2024 04:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBbuSYADlJ2k+5vyFiZ9uQWMyodUyMY/4RvE273OcRMr8ZHgNfI7PVszmqkQ4rNOO4jMQMPQ==
X-Received: by 2002:a5d:4a42:0:b0:366:e2e5:c323 with SMTP id
 ffacd0b85a97d-367cea6bfb2mr9878879f8f.19.1720955451013; 
 Sun, 14 Jul 2024 04:10:51 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm3576031f8f.80.2024.07.14.04.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/13] target/i386/tcg: Remove SEG_ADDL
Date: Sun, 14 Jul 2024 13:10:32 +0200
Message-ID: <20240714111043.14132-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This truncation is now handled by MMU_*32_IDX.  The introduction of
MMU_*32_IDX in fact applied correct 32-bit wraparound to 16-bit accesses
with a high segment base (e.g.  big real mode or vm86 mode), which did
not use SEG_ADDL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240617161210.4639-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aee3d19f29b..19d6b41a589 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,10 +579,6 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* in 64-bit machines, this can overflow. So this segment addition macro
- * can be used to trim the value to 32-bit whenever needed */
-#define SEG_ADDL(ssp, sp, sp_mask) ((uint32_t)((ssp) + (sp & (sp_mask))))
-
 /* XXX: add a is_user flag to have proper security support */
 #define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
     {                                                            \
@@ -593,7 +589,7 @@ int exception_has_error_code(int intno)
 #define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
     {                                                                   \
         sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), (uint32_t)(val), ra); \
+        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
     }
 
 #define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
@@ -604,7 +600,7 @@ int exception_has_error_code(int intno)
 
 #define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
     {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), ra); \
+        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 4;                                                        \
     }
 
-- 
2.45.2


