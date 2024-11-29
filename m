Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1975D729F3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 18:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH5LB-00041l-E9; Fri, 29 Nov 2024 13:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5L6-000417-TL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5L5-0006NF-FR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732903414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojufsuB566tnZ5C6giuV7h4t8CKcRsp0Kt6yZG9sXHw=;
 b=WKykog2cHAff7ELF0NHQoQOENO1rb9C1jBxCOEKy8Lgm2YRFq3edXj6VGPxpYquTHy7S3F
 FCapG8DJnPXqjHb0TipycmoOvfllZjCQC2UGRKT8Mz1BEqlYVCIT0oRbpM74xGuULEu9UM
 CmpHFqceR9ie21vA1tYe+Ch1Gl2wDLU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-U5oLiCWPM1yGz7Fg7JOSHg-1; Fri, 29 Nov 2024 13:03:32 -0500
X-MC-Unique: U5oLiCWPM1yGz7Fg7JOSHg-1
X-Mimecast-MFC-AGG-ID: U5oLiCWPM1yGz7Fg7JOSHg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa5449e1d9cso132041366b.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 10:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732903411; x=1733508211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojufsuB566tnZ5C6giuV7h4t8CKcRsp0Kt6yZG9sXHw=;
 b=An1wzd/PQwt2Ggsc2MrreqnCUeWOidId6JQTDOZ7QzB02dLn/wPLF1YIeKmtG8lIvX
 XBpabUgM0phkq0UDidj778rYRW4SJIEStIyaBDcZydhPFdZMKFr8E3TrbrClsmBYdOhp
 MERnrCpx6lMuAwudtYqQ5DClGtxgHSU9tPZx94y2t29VgY9Ep0uBMgVfHTiH10Z27KEo
 q1YGJfHbMuelpJ/SxKypZmDxWQHX0RDZ5pBGMt5tHpwWDwJjtEq5YUViBD9CIGxgbQWu
 4CPd0fHlb1I/murgGYmbGj9aCyI+S0apI2F9zrtNY8J/WvWrnvVt5eMOmFFUxAQTrZJH
 +DGw==
X-Gm-Message-State: AOJu0Yx+VqM2S5bzbCNWnmqB2lN7kUSjJCxZ4+EYiTTOX9e6Ys8E/9IB
 zfeUlyRRH7N87IriZ55WRCU9YjU9zUxtdv19tlHS96Im31TiNCRBO35UuhfXFNoN0dKJwnU97OD
 tc22M76JOcst40RbRprnFnzS3Zf/QfcDyxRZqC7wTlHsNlC56PHISoz1If3J4lfm2TTibqMJIMP
 DHXRi8u85aHoyJF47xqlVoLgfQGbK3YVCXM6Uo
X-Gm-Gg: ASbGncuFD5fEL8eYQaP89LufPpgft/lL+irmwsSkhYdmXfREzcwAdF/KG8bWWa1A0rA
 6FJpFQZBsSgyIqUOv8/dYUM3e/Nghv5tUuWMxETGOw9kNgMTMfFRpvv4Y77LQLEYBRZWc2aPqNJ
 hQt0IQyGNBcf/O3g4HOuEXQzPgaS0dBhoqArSIvZLrHcU8Pty0TAB99IfxOQifnbozpc9HZ+uJn
 SC1X85SuMqCTvFzNahWZR6pPvwbLYV7T+47qdx3ciKdchzx4WOF
X-Received: by 2002:a17:907:93c1:b0:aa4:ce81:6d92 with SMTP id
 a640c23a62f3a-aa5810559abmr993052866b.38.1732903410946; 
 Fri, 29 Nov 2024 10:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcaH98g/aKOXkcSAzeimGrYvz9gdVa/ULmk9tzYCDKi+YAb46/bKejxaa6n1dzchG/qIy62A==
X-Received: by 2002:a17:907:93c1:b0:aa4:ce81:6d92 with SMTP id
 a640c23a62f3a-aa5810559abmr993043966b.38.1732903410235; 
 Fri, 29 Nov 2024 10:03:30 -0800 (PST)
Received: from [192.168.1.84] ([93.56.170.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997ff0d5sm194080466b.85.2024.11.29.10.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 10:03:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 1/3] clock: clear callback on unparent
Date: Fri, 29 Nov 2024 19:03:24 +0100
Message-ID: <20241129180326.722436-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129180326.722436-1-pbonzini@redhat.com>
References: <20241129180326.722436-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/clock.h   |  8 --------
 hw/core/clock.c      | 22 +++++++++++++++++-----
 hw/core/qdev-clock.c |  5 +----
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index eb58599131c..a279bd4ba5e 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -141,14 +141,6 @@ Clock *clock_new(Object *parent, const char *name);
 void clock_set_callback(Clock *clk, ClockCallback *cb,
                         void *opaque, unsigned int events);
 
-/**
- * clock_clear_callback:
- * @clk: the clock to delete the callback from
- *
- * Unregister the callback registered with clock_set_callback.
- */
-void clock_clear_callback(Clock *clk);
-
 /**
  * clock_set_source:
  * @clk: the clock.
diff --git a/hw/core/clock.c b/hw/core/clock.c
index cbe7b1bc469..391095eb4e5 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -44,16 +44,12 @@ Clock *clock_new(Object *parent, const char *name)
 void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque,
                         unsigned int events)
 {
+    assert(OBJECT(clk)->parent);
     clk->callback = cb;
     clk->callback_opaque = opaque;
     clk->callback_events = events;
 }
 
-void clock_clear_callback(Clock *clk)
-{
-    clock_set_callback(clk, NULL, NULL, 0);
-}
-
 bool clock_set(Clock *clk, uint64_t period)
 {
     if (clk->period == period) {
@@ -168,6 +164,16 @@ static void clock_period_prop_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &period, errp);
 }
 
+static void clock_unparent(Object *obj)
+{
+    /*
+     * Callback are registered by the parent, which might die anytime after
+     * it's unparented the children.  Avoid having a callback to a deleted
+     * object in case the clock is still referenced somewhere else (eg: by
+     * a clock output).
+     */
+    clock_set_callback(CLOCK(obj), NULL, NULL, 0);
+}
 
 static void clock_initfn(Object *obj)
 {
@@ -200,11 +206,17 @@ static void clock_finalizefn(Object *obj)
     g_free(clk->canonical_path);
 }
 
+static void clock_class_init(ObjectClass *klass, void *data)
+{
+    klass->unparent = clock_unparent;
+}
+
 static const TypeInfo clock_info = {
     .name              = TYPE_CLOCK,
     .parent            = TYPE_OBJECT,
     .instance_size     = sizeof(Clock),
     .instance_init     = clock_initfn,
+    .class_init        = clock_class_init,
     .instance_finalize = clock_finalizefn,
 };
 
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 82799577f3e..ca65685c04e 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -87,11 +87,8 @@ void qdev_finalize_clocklist(DeviceState *dev)
         if (!ncl->output && !ncl->alias) {
             /*
              * We kept a reference on the input clock to ensure it lives up to
-             * this point so we can safely remove the callback.
-             * It avoids having a callback to a deleted object if ncl->clock
-             * is still referenced somewhere else (eg: by a clock output).
+             * this point; it is used by the monitor to show the frequency.
              */
-            clock_clear_callback(ncl->clock);
             object_unref(OBJECT(ncl->clock));
         }
         g_free(ncl->name);
-- 
2.47.0


