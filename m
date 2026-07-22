Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9C3C44533
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRYg-0005Oq-DQ; Wed, 22 Jul 2026 03:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYd-0005NC-DS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYa-0000SK-B7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784705995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0++QkczzracjaGvTNYRjSenA7oXvFOCAJoayCG6dao=;
 b=fQkPPvmsMrHoPOITjp0oaybYafwKfp7YUJ817tPsD01E+vRO2Hn1QWGMYa50cbIFb4bWjQ
 1dK5DVQMMOAhLpJj2Go58qapOyEZgWOBvGpOn0P18eqgj0RAayOCrO+DGG8IG6odht4Vi+
 XzvI/weFMXc6xqZOaM5EQ4yQCyVMDQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-nC55yGiyMsGEkG-WOjjdAQ-1; Wed, 22 Jul 2026 03:39:53 -0400
X-MC-Unique: nC55yGiyMsGEkG-WOjjdAQ-1
X-Mimecast-MFC-AGG-ID: nC55yGiyMsGEkG-WOjjdAQ_1784705992
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so114355895e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784705992; x=1785310792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h0++QkczzracjaGvTNYRjSenA7oXvFOCAJoayCG6dao=;
 b=hCoaOQRAWYhOPSbPzNa5m/UHSrtGo4tetGdNICXBAch97Ylw7gZxH1wfhtR35pm01J
 AuMqnwqrR5INhN6gbM8fqzcDTAbidE72O9C6EKtE+GAKPQ0plqU8g6QnI+BW0v9BVCld
 cClsSv+dtZv01AYg87l9ScV2Cy0FH+tP9asJ/4SSS7OeYegv8xUxX9rIe+gFyWTFe+A6
 NJ9a28+NwmVhH+mLwFIoMvdYNhjufAOc6Jo5upfkS8azXcGrNUBsvN+G7R3sqM6DIYhh
 y41/1wgYkvUy80jgBjdTqzWL73BEXiKSP5VmA7YebU7guXd+OotWH+npqsaNIVKYokez
 9i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705992; x=1785310792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h0++QkczzracjaGvTNYRjSenA7oXvFOCAJoayCG6dao=;
 b=T++soyApaUjN28w8mUrOe6YuSpmblntmucWb9K23EAihJwVBnBusV1folNf9mYGglm
 lmrFUY6GQiBLgU0vAQMRa3I3SOznqohq7ZpqZCcEZ/VLrkJLM01vKGJLVQGAJiD4daNe
 RLAj2x9fsP3AJZm2q0stveJZLAT4x5xW3sYICzSt6LygDawb/3tQfH/mdZ1YHt5wFHla
 QY/Z7N58NXwuVi6FDMRHy0zwsGxxyCDmhIs3D0TrPvpHvDe8cKV8pBct3VA1zo1NCMt9
 c6qf+0QmXpPl/610a9/Ithe+dSiH1iqOzUCezKIqTyU4TkYfrX5vlJthH30CEhxqQbml
 4kdQ==
X-Gm-Message-State: AOJu0Yx4/aXTH4xg5ComxDQKagLvFmrzCGV+yJUWQ6DdViUNH99w/GyC
 rL54NFTbRcoL5OxQS9PzThysPCB4MKT23OZCh1ElHIveO3UJcw8ivj7CarXAcCqniJ86Sm8S9XE
 eVoAgwWGfYm4iMNXnzwO2I3ClL3fNHgID5EzR4kykezHWAbsbI/kk526TavSo7xFpiYZlxB/8mE
 Dgm0asmvgyUr6XrfUibOBr2Gy7q/xLygfteVScZ782
X-Gm-Gg: AR+sD10ysSIT1cMgwTtlk1mQauFZkQAeK5t7MrNaFjgEs/ijH9PgySI40Gol5Vhrjrv
 2SfywUvCLq+uaQfLWR3r754jnSzch1/B2nuzVHNieHRItcsXinbYQE3KTkVaikw5d9QPXdDJ3iJ
 F4VSWbkVmC2jm7lUZM7k+XofWzaXkCji8ZrhF8/T889afSxGv9OBj1y35bTF6WQWJyTG+POZzFh
 y1R9ioKHmqtpwf6Dj+GTMyBTtQM8Nd6StGmSXEikuC5K+sGX8EByNUbauHWlrHyeR+e5nDe7zFb
 GeVIvD2AePFN8L57Ol2mFlwtOwG8IWePxY1lHgffDhRQl9o9Xd+L3/u1RuDwqj3r9yieaksSNnH
 HS+Rggs6qS9RVnuXipj+YMgE7fM2XfaAT7QSTL+99PnODKx1FTHqeSeN5AKTmlvEeRI8LIe05Vp
 lV2USI
X-Received: by 2002:a05:6000:4a12:b0:472:fe1a:1ee9 with SMTP id
 ffacd0b85a97d-47f62303929mr25218405f8f.20.1784705992292; 
 Wed, 22 Jul 2026 00:39:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4a12:b0:472:fe1a:1ee9 with SMTP id
 ffacd0b85a97d-47f62303929mr25218383f8f.20.1784705991878; 
 Wed, 22 Jul 2026 00:39:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm3782380f8f.3.2026.07.22.00.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:39:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] target/i386: tcg: remove FIXME
Date: Wed, 22 Jul 2026 09:39:39 +0200
Message-ID: <20260722073943.396872-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073943.396872-1-pbonzini@redhat.com>
References: <20260722073943.396872-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 83c889cc3b2..e4ef5a87580 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3424,7 +3424,9 @@ static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
 /*
  * RCx operations are invariant modulo 8*operand_size+1.  For 8 and 16-bit operands,
  * this is less than 0x1f (the mask applied by gen_shift_count) so reduce further.
- * FIXME: are flags updated if the count is nonzero, but a multiple of (8 << op) + 1?
+ * A count that is a nonzero multiple of (8 << op) + 1 reduces to 0 and leaves
+ * CF and OF unmodified (confirmed against hardware that rcl $9,%al behaves
+ * exactly like rcl $0,%al).
  */
 static MemOp gen_rotc_count(DisasContext *s, X86DecodedInsn *decode,
                             bool *can_be_zero, TCGv *count, int unit)
-- 
2.55.0


