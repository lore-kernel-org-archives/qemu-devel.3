Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD89C79FBD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Kfd-0001ow-3g; Wed, 09 Sep 2026 11:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kfa-0001ng-5Y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfV-0002sY-5o
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=KBrDeg/sazZp3mbYf63k8SlhI2OK3x0BCzwrTcRgs2qEdLPIqK28eEwsnqePYXhZnIVfSp
 1p+TqTpYPNzqVyOS5cOyZtv+m5xL3N9eD/B3Nidjarxzl62/ZfB1BqJOSoIKzu4b8Iu1lF
 v75e2wtCbUjUk2El65rZcZmhFQQ5q14=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-vdUVcdajNDu5IvkZ4-jHdg-1; Wed, 09 Sep 2026 11:56:58 -0400
X-MC-Unique: vdUVcdajNDu5IvkZ4-jHdg-1
X-Mimecast-MFC-AGG-ID: vdUVcdajNDu5IvkZ4-jHdg_1788969418
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so89788985e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969417; x=1789574217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=oNBqoNvuIZbjVSR8Eb9TUKRmIe8w8e5w8bM59F1QXagLhDfqohh4wS5w1/z8Y6eUt7
 +/sm6lMQAZyy4ILwDfVZVcJBd6m3UMeI8++60trN5h80rP2oZywxZmoHEnyp9iZVqkZS
 xkrzkA+y85UZxw/Y7WOGYG7iskkIFPf1vhoHxAU4OTpX+HH5hi/Q8JXXeGazdser0f4S
 Q93F5TTRJkHtT30z2Gbyvi7Xtby7a2d4aI9YR84xrbgfErqUTRyLeNLVOpHbW6r4Or18
 I6d1RRukj/pi3E5tnHVO/nwlTyeD0qoVmviNgk2fqedfqUUpHMo8WDqWXROMaK5Oyg5p
 +vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969417; x=1789574217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lSllx6henKx+I8/uPcAW8ji7ADhy4lHNJbAj0EDO3vA=;
 b=cbR+GYncafesBlvjEZ84mc/4N+z7kbOQTpcP8Hw2SZmZQXIVooAC5CnPaed/kb4Ci9
 1YszOtQgV4FoOLcwJXN54xwdKoNEVvyzLpJgGBJ6kyh1sJKZqEx+PansuV5N5zEN1QNk
 rvmUrOMBfbxVdZnz8kq1mBX9vycXBtgMK446UiTD3qzLWnmTbIL966QUQX0tkW4Z0lOL
 AE61+1IjuykzyEwajfkRqxOPyaukdxDFM2vGluqILyJMl/R75tHRhzwmMdmDxp73tkHV
 Nuu3fe7iCw8XYI1TPbE9pQ9tT3kAnacD8t8xITXmd6OfxjxxcGVUcXDqHfpevZsrciaD
 SNag==
X-Gm-Message-State: AFuF++nQYZxejBtQMwVQ62Rvkr1P1Z0Gat37/AIfiAXFzRcDVj5VF0Dh
 eAeB5ucWhEIfKnHl0gHGJ0t7Vjcnamdm7EgVQ4HrXqCRT64oqIp2pN0HvFk+BjT1Q2+BmM5c9xs
 OjJBt70q6rTaLTXjfggV9gSnZbFvIiApauwokLGTnYJhEWdcGdCbM48hkXol2LPoU1QSQqLJtT0
 dwvAgRSKISf6fWUcEueDQle74zcl6+cZajzz22kZDs
X-Gm-Gg: AYBFou2cm1DYex7y/O1YYHunWXOmpr+zJuZo2jZsoL9eUewnxJuJAHvBHZ1hvvOXv7F
 vCyG5z7g5ghM0VxSxP3ovTTk2WXtWFtV4vTtwcMPK8gxPj0RjSkiGSqw3stMNgjSiSeL42InHPO
 KgDvm5/JDBlvulqbX33NHXWSjhhw9/tTgRVZ8AQMx3XEu4pnP/rj7y2fakUJR7YLp7uR14Ztp7D
 umEcd96VRwsTX61L1kAkliPKV3IqazEQxDJny6qefXURlH4ViUp1NGsu2S4eStNkayCd+BiYzfB
 5+WTcIXmxEgrq8lVIngedIFxX/leXGr2RQqkPgFQG0mypfMQ1CP0MwRiKTonlWHp6wohe8SkFk4
 Oz8aHju/af9LJzSH8hWB95Bm9U/+7j0xA/DuP1XwlkO/ZHNLsdpuFYECS4T/pW4QTiEabYRdKuB
 zjiQFW
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49d15f82becmr143416935e9.7.1788969417532; 
 Wed, 09 Sep 2026 08:56:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49d15f82becmr143416585e9.7.1788969417035; 
 Wed, 09 Sep 2026 08:56:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm138570905e9.4.2026.09.09.08.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/12] rust: qemu-macros: remove redundant clone()
Date: Wed,  9 Sep 2026 17:56:23 +0200
Message-ID: <20260909155624.1082893-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
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

This is reported by Clippy in the latest nightly builds.  Take
a reference instead of cloning.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/src/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index ee417bb4b4e..271125185ec 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -261,7 +261,7 @@ macro_rules! str_to_c_str {
                 }
             },
         )?;
-        let field_ty = field.ty.clone();
+        let field_ty = &field.ty;
         let (qdev_prop, bitval) = if let Some(bitval) = bitnr {
             (
                 quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO },
-- 
2.55.0


