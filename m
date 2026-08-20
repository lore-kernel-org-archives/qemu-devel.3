Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1528C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5za-00089o-Kr; Thu, 20 Aug 2026 12:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zX-0007wY-QP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zV-0005if-Id
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRCNT+/JQDCjOh4l0Hq+K+wQMPbvvsIBEH35dnWfir4=;
 b=hiqMWSLUEHFPpp/fPWDEWGJUGP2H4WXEGT122bjtbhGeFxm5Vn+0p0EjcGU2mO0H4yCHSq
 fquGFRDJzE9Wrjqr3FijPiT+yOEIln9EJGenKubUjuNpwKF7hwU2xfVno6TxrtgEYRHkwR
 NoFD9fL+S3hvpnSGqJA2hdFgTLVe5O4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-7LmZIGgkNEm4vVxJ0e77qw-1; Thu, 20 Aug 2026 12:51:43 -0400
X-MC-Unique: 7LmZIGgkNEm4vVxJ0e77qw-1
X-Mimecast-MFC-AGG-ID: 7LmZIGgkNEm4vVxJ0e77qw_1787244702
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso230115e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244702; x=1787849502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRCNT+/JQDCjOh4l0Hq+K+wQMPbvvsIBEH35dnWfir4=;
 b=D0vrOeEcIixrUyl1l6OfK4vmp5mwhqoo/MMlQcxrfLRXshz5vf7Zjg1KYXUdlaJyPb
 iWA5k3Gu9gx6yL9KqbS1BjJHDTJU03bOdgNFfcSdPm49grYgqg4jnp3XIW8Y2PqoxGDL
 9VaGBJGF6i7EMk/GXt2o/K7fcL03dHoREXh+PSsB9dQDalgFjGlKlmUqiopccwjXWS3K
 S86Bd6HWWv/vbJEJypu7FkNivjkincNPdo78lXcnHQP4x6Z4Y6CJGTg05pK11nuvyHE/
 qeKDs+e74Q3dSgqlF189Z4YALMWzgMWUvKdaQFTxLK5v4h9RMPtHev7icKWaOLu3DGQ6
 NJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244702; x=1787849502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BRCNT+/JQDCjOh4l0Hq+K+wQMPbvvsIBEH35dnWfir4=;
 b=hqO2UZ0iXoVDdtPFTagaaWNHg0+seRRH0D2pxIteVgIwpa3aiomrqbfd6fYjVu2a/p
 BDcGUSdUl5cxg5Bo4HB7JedY0JIXm2w8OQc4wEBL9YFJH8+YG4yv/yTbQeymQvI5+8Mf
 J2plItRtYPD+2kB9rZjUMKpE/JY93j4HhlxiIIl9oatpSxTQTedQZQJz1Av1dvYf+vGf
 yRx2MknP3aUSJpZE03hyHfVfnH91E8exu0+HIao/mttN3By2+rcL6gvJnm+kIkizM6ii
 z6b+alHp8l67D6KlbcQXoiXELwsqFMjV4SzlbgkD/G/6n3HtRjKCkhpqvAQkIOMk94of
 QW4w==
X-Gm-Message-State: AOJu0YwP+JPWlGFvwm6AsI0FDDvQRX2kHmIZ7shtwU7zyimYWaB8tvok
 88e0FP/FKIxZujs1n5CmDxQlpOCuLmIa+r8fTN2PDQWffU2pjHEZYOVuu1oMw9hviQzkNxrtNQk
 q9kOnlmE/iQsRWyWhYT7TgBobdn+ag6ju0Dd78MhfY9s2hCyxf1aTzvm4LZSEJ2eD3Ik2y4r41N
 fzOp6z+8hFtIjJ5U3IOtaaip0zaUFLxwcFts7kaChp
X-Gm-Gg: AR+sD10YHEniP7caALiytMODgMO7Nb18uvinpKiBdXC1WVvdhGff0hHjGvnreTyt+a7
 Ddr49Ctu45jXbADKaf2tX/lCZO8lEu5jjQyMq4zK0pGvICr5OfJm2wOeHQ+WcLNAUnxpL46CamJ
 wgLf6qmQUvDBukFMeh1ol6R0pZedeNAlvxBwzRfH0X6gdPlEMwtMdCI6lNbBVeHkQb3aRq5XOPe
 gfQRdTzqIScipWyzR7Lh66Pj2+45sA9S5EGVaGXWUDbYjR8hGUqVj6V4endPYwwIEQU2hvgcKw4
 8hJ0VeSunpJu88uIilOz86Es29W/2aXoiW0NL08T0fkWx1lIVA2CyaoD+SjyYjgZx4iex4kXuxt
 eHQrOS2oGMyaQsZSeawCJYWgU4od0tbfYfDL8gpDBpXkLojPuucras9sw9Txfhnst3FhI4lvsES
 5Lt5s=
X-Received: by 2002:a05:600c:a44:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499b82f4158mr4354345e9.3.1787244702080; 
 Thu, 20 Aug 2026 09:51:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499b82f4158mr4353775e9.3.1787244701652; 
 Thu, 20 Aug 2026 09:51:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm94871775e9.4.2026.08.20.09.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 36/53] whpx: i386: inject back db
Date: Thu, 20 Aug 2026 18:49:39 +0200
Message-ID: <20260820164957.1895963-37-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When we get a debug exception other than int1,
inject it back to the guest.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 56a8b167497..113f79afb9a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1079,6 +1079,31 @@ static void whpx_inject_back_gpf(CPUState *cpu)
     whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
 }
 
+static void whpx_inject_back_db(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    WHV_REGISTER_VALUE reg = {};
+
+    if (ctx->ExceptionInfo.SoftwareException) {
+        /* TODO */
+        warn_report("Was asked to inject software exception.");
+        return;
+    }
+
+    if (ctx->ExceptionType != EXCP01_DB) {
+        warn_report("Was asked to inject exception other than debug.");
+        return;
+    }
+
+    reg.ExceptionEvent.EventPending = 1;
+    reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+    reg.ExceptionEvent.DeliverErrorCode = ctx->ExceptionInfo.ErrorCodeValid;
+    reg.ExceptionEvent.Vector = ctx->ExceptionType;
+    reg.ExceptionEvent.ErrorCode = ctx->ErrorCode;
+    reg.ExceptionEvent.ExceptionParameter = ctx->ExceptionParameter;
+    whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+}
+
 static void handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
@@ -2646,11 +2671,7 @@ int whpx_vcpu_run(CPUState *cpu)
             } else if ((vcpu->exit_ctx.VpException.ExceptionType ==
                         WHvX64ExceptionTypeDebugTrapOrFault) &&
                        !cpu_single_stepping(cpu)) {
-                /*
-                 * Just finished stepping over a breakpoint, but the
-                 * gdb does not expect us to do single-stepping.
-                 * Don't do anything special.
-                 */
+                whpx_inject_back_db(cpu);
                 cpu->exception_index = EXCP_INTERRUPT;
             } else {
                 /* Another exception or debug event. Report it to GDB. */
-- 
2.55.0


