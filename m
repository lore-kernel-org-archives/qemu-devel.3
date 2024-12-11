Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5282E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZL-0003cn-Hj; Wed, 11 Dec 2024 11:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZI-0003JE-Ke
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZG-0000P0-Qt
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqP+CF9Cn7KtMzYzo4JT11mnT2881O+4ObbCwnw7e7k=;
 b=GWTnYjpU3KkiBrJd1vHZr1UnT/RzJHcYyY2C+gDNIhVVRuOBI3zkBzwORteMdtSP650bqN
 mV4N4+zXHj49HgT8/JZFF3bcz6J/rlm7f8Q7l+sLEtI59J5URmgVWG81Se7rCggSVP9AmW
 UFBeS+izVSN6mRgZ9zmfL/D2YT5uiVM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4Y5l2xPTNQWCndCk76ZNsQ-1; Wed, 11 Dec 2024 11:28:03 -0500
X-MC-Unique: 4Y5l2xPTNQWCndCk76ZNsQ-1
X-Mimecast-MFC-AGG-ID: 4Y5l2xPTNQWCndCk76ZNsQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa61e72d68dso533991866b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934482; x=1734539282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqP+CF9Cn7KtMzYzo4JT11mnT2881O+4ObbCwnw7e7k=;
 b=nUBRN/vdI2kzFtC3gI+cQcoOCn5h6tv+cG4uyZbIgt5Fr/wIL4e2V0UTaR0jEdqzrt
 yjakzElEbcScU9ZduVts5mCSWb/y1Iexgj8Rtz98D1IdspdT6u0I70YE2jfSJZ8lm2Ql
 8/rWqBgEZJ/NfxpS53XwFE11bqtoWott0GxoGdWeptJcTXYBnYStKVgtIillB6Jl3JEK
 9+d/Uz3csnd/+uxSJNUXTk1Mb2Bfiiy/AIycRoxsVrjR6dVZZZMU0aUSfg/e6XqkIZUk
 3tmAEPIGQMFlw1/waubVPK5ZAx2LwN2J6lmon1MDAOd9eHPf0+gYGSjkU4NxndGjKVkh
 lshA==
X-Gm-Message-State: AOJu0YwOetpmFDuZqeQv2A5AENqVGuUYScGdQUYdKZZLNRXVGLAG67e/
 ZxYBOREiNUk3HmTcwvceA0Fwkd8Q98yIVxLpB2YoOong2cr0mJDPBK56KdRiVIW2xgqv6Rc9SLL
 N1lo/6JhzH8qiySb3cKypHdQ/4DGFhSI1zOmO4x2nrMrL2+S3HmyEww6qt1y2chYJAusuLVSln7
 HnxAOX4CN3ZKTB+s+rAIDLQp590r+xgtKUPcmX
X-Gm-Gg: ASbGncvyhLtfjZbNzsnSgFv7n7E1JH5B1m8iSyg+BR2dK9CUikjyDMjETqn1cMLrVkW
 PbcWewlp00geCLPTmpVG7/ryukFWy7BY4FuUQKXBOk6AEms3RzeRUv+wDuapTK1ErkQ+6FvUMH7
 2ikP2u1FwomR65Yfql/DZpPkOUvZMNE+7u4futDuFntisnco9R5Dm0XV+GJPZ5keC9jWezSW0rh
 vk/dcaKhcj7gVgFdzGCj7QC6AhTRZugSWDjyneh+3ClDHUtmobSElDu
X-Received: by 2002:a17:907:72cd:b0:aa6:b5e0:8c59 with SMTP id
 a640c23a62f3a-aa6b5e095bbmr284803866b.35.1733934481827; 
 Wed, 11 Dec 2024 08:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc6vl+2WSCOzXnfgV1+umZZeyGRF8tr8hut8ZDv9tjCDjucUv6J4ePnAKpf8+f+p/87DsWNw==
X-Received: by 2002:a17:907:72cd:b0:aa6:b5e0:8c59 with SMTP id
 a640c23a62f3a-aa6b5e095bbmr284800166b.35.1733934481352; 
 Wed, 11 Dec 2024 08:28:01 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa66c646defsm648486566b.181.2024.12.11.08.28.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/49] clock: clear callback on unparent
Date: Wed, 11 Dec 2024 17:26:45 +0100
Message-ID: <20241211162720.320070-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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
2.47.1


