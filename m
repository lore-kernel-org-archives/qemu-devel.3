Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A2EF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKb-0000pv-Ro; Thu, 23 Apr 2026 06:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJU-0000Vv-6F
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJO-0005HP-Ui
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLxexF+6kBYyQWr2xc6HvpRiGk0E/Hk77bvEsEzd9Xo=;
 b=FZzSXdwunZru/7UAR32X6cr3eYfYqbQgrN2R7+eXo0mmPk8NJIzJexoV1h+Jap8vZ73OHT
 yKeN3JiQg2GJKdm5yYa3vqOZ2qWvDonKEwtYtK+A43LR0kelAlsncCrXeIzstMW9i8+xSt
 AAQa+VqED9kUJFEXM6jKNsFHUHYgv1U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-ijUCVcYZOJiVQ6Q3aRJdEw-1; Thu, 23 Apr 2026 06:29:33 -0400
X-MC-Unique: ijUCVcYZOJiVQ6Q3aRJdEw-1
X-Mimecast-MFC-AGG-ID: ijUCVcYZOJiVQ6Q3aRJdEw_1776940172
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a55d82e0eso21134625e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940171; x=1777544971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLxexF+6kBYyQWr2xc6HvpRiGk0E/Hk77bvEsEzd9Xo=;
 b=PVpJxZsjKop5CN3bVaLOQ/t/nYfcjUmS1Bt1x3R9kxkH7xsdjiEAJg4ZM9+nSl5HDr
 z3A9GeALTo1xv5UrAf5Ra8Emzs+bSkeH8gx78qXEA/43Pb5RvGlOOtxzL5Ay3rajePC/
 uQP0Pl4wLFc4vW3t29w5lFluimidw208eYpL9nrzqCmLaG/hAeG/G325TOCj/6Yac/MK
 p+dMXfskX5Vrdl83vZnFllkp879JGESentqSELs8ak/WX5D2UyLsRaXEBKUWrUoTw/ai
 b758i7sD/Fr3dUIVlLdSpxk0C0kHcA1ZJm7SmVy5Zyrx3UzgP8a95Xp2UuXJwB1uoQKp
 muBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940171; x=1777544971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLxexF+6kBYyQWr2xc6HvpRiGk0E/Hk77bvEsEzd9Xo=;
 b=lX11/Zk5e6R3/gHKIkhl66SAp6SRk22vFyZ+bVOHw0zhQQtBIGrpTu9czcGxWegsT5
 3VbNXB+rwWXBIGQ1FpPeTlNLosHPStmyaPsXdGzCxWne0YLx1VOz4xut3egEar/HA4Vr
 X/PMYHmsOulzVuyawZUK7pqXOdG8BIuC8/N/FE60ShNjdf3yqyhZIB3Rom+cWDlFZEUC
 Lv9zulMKeAbocvW5Xl0WECipuqi3XN4CfFUkA3y4aWz4ktwNRK5CUEKv8j+RrB54pV6r
 sGADiGjWcvK7tWF2I1vjJEFTR63V1k06JDvoyS88o2Sla22Z5WQLnr5JV/8Rkg5k5gSh
 dkig==
X-Gm-Message-State: AOJu0Yx+17GYcOBOT24wWE0NMX6CDFFCyVhJfAuP+Dr/eHVlqx8Y0Oel
 XgBbAJU8NSE/hU9KGGMnI9edePic+ay9ZDhFSGRNxIuyS5FfG08lySoQSjBxlKXWUTn+hxIXqTo
 AkWEp+QwJtIgDnU/MDQAif+lHPvPhQ0EAIya4XxQxGN1x9ZyMPuF04T8/cusH62WX0rNAvmrazq
 wHvm9MsspOHnIlN/tzQQYA2DehiMkj95xXkm1y1j9X
X-Gm-Gg: AeBDieuPH4/5yY5obbNjh0W/6VRT6Bz9/9HnUNcY4j8Rt3K9AHfHv3gAE+7Z1updolN
 t5TlQfPjAkGSl5bS4vrhuhE15Xc/hnuUswsE4fhPlUIDybZ6b+dyZJu+TDQidcHlXHKXUUML6RH
 pzE4OFKHopPZ/NLHlPd+XjFMPa5ACMPZ3drdaWx2X9iwmEJSgsKm1IUf9btTHOk9bW7RpOq0H7l
 Fk8RVljnwm+8hxUK4ag8xqddDkEfVLziK0ZhTlvBu0E8GOU4o4KFuc9QTfqmgwgFN+T3V9v+iiY
 WuKxxgcswW1XMClutSqH9OtWD6KVmolnSj7I/F4bqoTwDTEu1WCm3RlPFHIndH5fLYp77CwbN+2
 lTECvZvpRMutIWgj/FJG2Tk1HHzdYtnp9SyGkborIeaRlDLLJqW37caM26MPdaw01n4/L8JmF8n
 Z064qBWmrw5Qb8DVNPZ4tFxoECJpJezdavDYg=
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488fb750a2bmr261298475e9.10.1776940170704; 
 Thu, 23 Apr 2026 03:29:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488fb750a2bmr261298145e9.10.1776940170234; 
 Thu, 23 Apr 2026 03:29:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm875435925e9.3.2026.04.23.03.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rickgcn <rickgcn@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 03/25] hw: i386: vapic: restore IRQ polling for non-kernel
 irqchip backends
Date: Thu, 23 Apr 2026 12:29:00 +0200
Message-ID: <20260423102922.443639-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: rickgcn <rickgcn@gmail.com>

69dfc078 extended vAPIC handling for WHPX with user-mode irqchip, but it
also changed vapic_write() case 4 in a way that excludes TCG from
apic_poll_irq().

Before that change, IRQ polling happened whenever no in-kernel irqchip
was active. After the change, it only happened for KVM or WHPX with a
user-mode irqchip. Under TCG, both kvm_enabled() and whpx_enabled() are
false, so the poll never happens.

This regresses 32-bit Windows XP guests on a Windows host with
-machine pc-i440fx-10.0,accel=tcg, causing a STOP 0x0000000A during boot.

Fix it by making the decision depend on whether KVM or WHPX is using an
in-kernel irqchip, instead of whether either accelerator is enabled.

Fixes: 69dfc078a6f0 ("hw: i386: vapic: enable on WHPX with user-mode irqchip")

Signed-off-by: rickgcn <rickgcn@gmail.com>
Link: https://lore.kernel.org/r/20260418061429.16898-1-rickgcn@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 41e5ca26dfd..1acb9f91b2a 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -716,8 +716,7 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
-          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
+        if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.53.0


