Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30526C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzary-0002sR-Pk; Thu, 27 Aug 2026 10:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarw-0002oU-RT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzaro-0005sn-O2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=ULKOOnUzMTfMvbZwS1Zh3ElW0DS+BtZN7flBgc2eQ2jaNO5+b8sfpNX6S56p8rZRvbs2VC
 j7auO1v4TpJRBK7S433i1GWYhDDpJt9Lj+zDgJox4KR2GG2zuNZUbg0YWtjM1CbkWUzYNy
 bZnAUfQoMzyh8oFi5V8IoKBO6t7mbyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-dWEIATXePYCjbQnNuE_pPA-1; Thu, 27 Aug 2026 10:14:05 -0400
X-MC-Unique: dWEIATXePYCjbQnNuE_pPA-1
X-Mimecast-MFC-AGG-ID: dWEIATXePYCjbQnNuE_pPA_1787840044
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso19560465e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840044; x=1788444844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=SmQ5ScOE8TPqATfTwr6tX1QJL42BpU/YAourRE5/+WShYXbmwgHJcrOCIgE2sgYrLD
 5ZzpQi6RoaMSAbEpH6BSgCeJm0d60NBHNUWT0Mg/2955qZSMkHbNHj7tc6ytjwM3UKkZ
 q2FP5IIj507O6DejITyMktFj40rKYwmfx7K3j78MvnH/piWhnxIKqKW/Oy2wsPyCHeaI
 Ngxz38C91S7xJjyRjzTgtgCg+2yZQi/aBk2XL8uOcvXF3VzLhs0UUjyUtxXdWl2pmz98
 +b44yufxPXTBiv7rVgVo0s3ZwrFwLMpgyFt+74EkrA65AbqPIfXISeCzTk9RegqQOfLl
 KXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840044; x=1788444844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eE17Ge5pQll+CKBZcZE4tJbV0rcAbPkHpSAYrj5d3UE=;
 b=iXvqgsdwkzCOHouKhvOvd54eYbOgMiqhB/yIWfXhKZ8zVo6rVfZfRxkX0ZVI0UTlPE
 GAN0Ax/kkr1OaFNIYBWEQCP0/iKCtu1+ZpvtlzEbPCPsvWv3KjMFrHHzWkV0zjVGM5Qq
 U/CGII7n7Un7hEN+8hrpQfzsATqlrUx+By6t5t4uZgdiYlrRyPadLbdCCROO3KQcmkfz
 ReduBhMnhzaLaLYAwRBjCoiAzwM3oXXAYKTNAl7+V3S72CdWEaMY8oPzNEaG13XQJKu4
 ikog7B+5uzHEmmnGbPW+7NS+ReWZT7NxDbuaJeiDX12ZbzNIPSZLExmp1VRMyyNvDBVN
 Sllg==
X-Gm-Message-State: AFuF++lFmW06Kx1HEkuFVgYLcj6TSH32zYgiSgrjqt1oJiron6QxN2RS
 lR/jxSuqWsydFKmHqIrDBsPrV4nvMnxDlA50zwJm6t/fwJFWGjjDcz7Dwndf48ivrXbjNXZ87e/
 9H22SPl2Xf0Byva6+OxCJZC21DVBOvqPSgRtl0h0jStuPQ2Yr4E8QKQUyAuOnNc1RggpNVXvRTO
 nZnSV3h/XYT4Wy4VKSkDLjYDjcbLLE/XhKDHM4g0Vf
X-Gm-Gg: AR+sD12w7w1B7aA008n0Q94SOkUh1zM8KHEWTbbErEdopLQr40O9BvKeQv8tnsFbEOz
 V0H5fzjDRzkeSkayBvVvTI6u15zjvBFU9PRyhKY3vSXqvJwGnFKXDSYdRoevnTjQ6OMZ+2vfZcv
 VXUubzmQkt/m1G6YAd/mylh53UEt/WNy+OtrtEKGcqPs6vlutY+cqv+yVkXfbWT+lp93+tqBlDj
 rM9fGf6QL8Ru1ZHk0VPw8LU/uu/Dw+DvvAuz1nWuz83fZ2K+pg+S9zZwFena1eL3rwMbpdV7AHM
 cKEfKZnyy1uEc79E++Yr+qiAFKVoa5I0JcI1bZe3lUXz0PwKpdV/AMV7kH22bDmtC7onYNvUIbo
 RVT2q69rRT+aW0J92V0weJ9jlqiCozsiBBqJ4mlXI01+8OZo/9Blo8+HcKTOUxeNYOI2K+27979
 hx1x4=
X-Received: by 2002:a05:600c:4592:b0:499:b402:6c0 with SMTP id
 5b1f17b1804b1-499dc6eac3bmr180539125e9.3.1787840044312; 
 Thu, 27 Aug 2026 07:14:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:499:b402:6c0 with SMTP id
 5b1f17b1804b1-499dc6eac3bmr180538165e9.3.1787840043819; 
 Thu, 27 Aug 2026 07:14:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e81besm9132720f8f.25.2026.08.27.07.14.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] target/i386/tcg: move check bits out of validate_vex
Date: Thu, 27 Aug 2026 16:13:04 +0200
Message-ID: <20260827141314.1099352-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

JMPABS will need the W0 check; move all of these checks
together with the others in disas_insn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 9c429e113de..47bc30a22fc 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2723,24 +2723,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
-
-    if (e->check) {
-        if (e->check & X86_CHECK_VEX128) {
-            if (s->vex_l) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W0) {
-            if (s->vex_w) {
-                goto illegal;
-            }
-        }
-        if (e->check & X86_CHECK_W1) {
-            if (!s->vex_w) {
-                goto illegal;
-            }
-        }
-    }
     return true;
 
 nm_exception:
@@ -3000,6 +2982,15 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
+        if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W0) && s->vex_w) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
+            goto illegal_op;
+        }
     }
 
     switch (decode.e.special) {
-- 
2.55.0


