Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5602CA5FAA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3L-0000EE-VP; Mon, 28 Sep 2026 09:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB16-0005YH-7Q
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB14-0004Pv-Nx
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i69OXjpAMQbeNl1jLTTDdTZdRTXUQxghW3OV3xelNO0=;
 b=NBaLiu/SVLNviCKsL1XGq2P9c95pCJCVjhcJLPnw/7+fS9bpcmQulx7UC2E4lJ3zPPgps1
 3iusK16b2MvE0EzKw1ioWC/P4JxqcPHf7acTMh0MworAlyPvbXjGjoy+xaDWwMKJE7C9wy
 peKN4ZwpL8yBsKgOcc8sssrZaS3sK7Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-HmFlx5NrMfyKE7sReWe6lQ-1; Mon, 28 Sep 2026 09:03:32 -0400
X-MC-Unique: HmFlx5NrMfyKE7sReWe6lQ-1
X-Mimecast-MFC-AGG-ID: HmFlx5NrMfyKE7sReWe6lQ_1790600611
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a64cb77b0aso3017866a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600611; x=1791205411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i69OXjpAMQbeNl1jLTTDdTZdRTXUQxghW3OV3xelNO0=;
 b=RlIhoJQaJJ4NuvfpeJSBbS3TUYlI6XLbPQnHz/1IMhYkrgksWziCfagXOVPB3jMkVz
 JWBm5asKer2oY1KUvds43ozn04EN/M3d1l2UonRmlWR8unqCQJ2x3mJMJ9l5Ns6hweU/
 l0QxlEbr/5+U3U3YsKLU6Tw2emNyFlAYN4/62j1Urk3m91XI/H2htC4aoAqQ8sgxGpjZ
 caumYUUxwOIGdTgqr6ZaTUaCSAVdzFKFKzlUF/6JfIKOvt8hyXH+8I3IX5xyV42Ztkzm
 bjncPqGr77RvArPXtveW7Gw9H6zwGTINYiGfZb4g0WO9eYTyuGpqe4HjfUTwXlJFvcmM
 /fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600611; x=1791205411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i69OXjpAMQbeNl1jLTTDdTZdRTXUQxghW3OV3xelNO0=;
 b=RrDaNSvkIV1jQeE9Hm1D4zPOnfsEa0p4c/E/9OvYI8+fdTl5cW6dGtv8BosZxibNjw
 jnIwwpsV1MBmEnu5nEb6J5Qvo8t4hMSBrirAdkeez5LgdkCRX4Gs5onVGOGK8a/0US8S
 vk2VxVeegr5GgCOsTJVq16SSn/L8tCJ/Pjk147h2GZJEoJLg6P6AK27C8nvewMpuag8Y
 4zZVWKCL1qB81U5xFe/CWwhtHtDdBaVoM0uWVc6H4dQZ74tog7PV6esQ2Fgo2EIfFCvm
 umXAQ3DFEvxqwofVEbVEBwvkmJGXKitRb8hSNoWuCUFU0SY2r1TIgeNczCKmngnQ2te0
 QzRw==
X-Gm-Message-State: AFq9FYLWDkcWsOOizC8YJskpAjssSHEhGRspNnNQ231qJD+sDU+ePAl1
 pIhqzqucw9uxO260sKrtGbldws49ddVp1LHegJm3W/SD5fAiqHVxqKxkt/QYe3VxCxDhtI4Rh4K
 FVRwJ/rdl8TkREoe5MQMg/bxKZgAazhEm+3OnGAvYsMAnVs6G4VRR7ZqyZuwUgorYnRPws0+sjE
 qpaEPyVayxFbbOkndv/eDLj/G6PhjInPDHvsoGGkke
X-Gm-Gg: AYBFou2u2n6U/0o5INWKj+yfF1ihd1xdk/psxEvmNrnsztSirmn3qt0BGpaDhkePJab
 ds/+bfRMGvDQ+VyxyBc8+tWUL1Blj5WiTwNkuc+wQcWz+DEgU9eu2LZ1V+lgYzHzh+9tbjpjB1Z
 FyTyUP3a3ObnJTRrHL1Ja7d8rvRNYyIlDKHDHi47vt+MfgKVk/LXEbGaIi2aI5euvgMFo1Op7ld
 9ztrvkMIhZlo8LaPk5u/6zEo1nXJWuzWBDOpQKPVxstWtMt/4a1QB4I3eAU5Ip+KHLXPS2bdAIk
 zs1JfyI1JcVmTzqXtnEV6u1vEcJMzFNJnOyP4iWZjFacfRJnz8Pc0gEhPw3GQ64ZPQz3ro/nWFK
 ADk3yLwVK2yvPZ6/4lrHdkq2DWRpWHlPQ6HXco5LB8y++n7PQHsHTmreaA2Gpuio2hOVFBhT0Uw
 f2zqvG
X-Received: by 2002:a05:6402:2112:b0:6ac:73f8:2e50 with SMTP id
 4fb4d7f45d1cf-6ac73f831eamr3149735a12.43.1790600611225; 
 Mon, 28 Sep 2026 06:03:31 -0700 (PDT)
X-Received: by 2002:a05:6402:2112:b0:6ac:73f8:2e50 with SMTP id
 4fb4d7f45d1cf-6ac73f831eamr3149693a12.43.1790600610497; 
 Mon, 28 Sep 2026 06:03:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ab5be60872sm2744971a12.34.2026.09.28.06.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/30] target/i386/tcg: treat 0x0F as a prefix
Date: Mon, 28 Sep 2026 15:02:17 +0200
Message-ID: <20260928130228.877003-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Because 0x0F cannot come after REX2, pick the 0F opcode map
during prefix decoding instead of doing so via the root opcode map.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 194a99a4753..546c6451ed1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1848,7 +1848,6 @@ static const X86OpEntry opcodes_root[256] = {
     [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
     [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
     [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
-    [0x0F] = X86_OP_GROUP0(0F),
 
     [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
     [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
@@ -2824,6 +2823,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Collect prefixes.  */
     switch (b) {
+    case 0x0f:
+        decode_func = decode_0F;
+        break;
     case 0xf3:
         s->prefix |= PREFIX_REPZ;
         s->prefix &= ~PREFIX_REPNZ;
-- 
2.55.0


