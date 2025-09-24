Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D05CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqJ-0006Y9-2T; Wed, 24 Sep 2025 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpP-0005t7-B1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpK-00055O-N9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfUywyyQC7TDO8J0Ge3oQBTlQoIjAPXNPeMkAMHIjcI=;
 b=KVSXPK06Mnkv1ZOk6LPJpIkV1cAuIwYeJBysJ1lJPrGrVO+Y6xoYAoCW6RGJJOCABrJA1E
 Go7ez7Ic3eRlNkhqUQpG9uGj6Av1P2hzExUOSxlWSJT+6mOi1G9ApFmvlDIXIvjSfktXYK
 ad/3djUZgipJp8U3cCgcVk70li/m4OA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-xU0Vth7rM3WXELJqcDuw6g-1; Wed, 24 Sep 2025 05:30:13 -0400
X-MC-Unique: xU0Vth7rM3WXELJqcDuw6g-1
X-Mimecast-MFC-AGG-ID: xU0Vth7rM3WXELJqcDuw6g_1758706212
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-634741fccc9so1067860a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706210; x=1759311010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfUywyyQC7TDO8J0Ge3oQBTlQoIjAPXNPeMkAMHIjcI=;
 b=VKSIHA40oLwgvAbNgLq0gkkYozod6ki6HZi49wPeWOHzZLS0+9VZXVMSTpDpiMW4yw
 Z+oBC7HR8feD6A3XpCmyhdMWa0k0PckpVLqocA4W63KMrqVdShda7z2+r7xX+jk5Ep72
 9+zBmyX0yHYHkQqMQu3DFbV3Xi64YJJ1Q+wHxanY2qMm27gPoWXtrqvC0gnft6QhRz2K
 YBisindncCgoi4y6M8gnOfbAjzPxX411GZ5P+nOKUuHCqI8XFiaWq+iJO8X3qKAaI/8E
 PqFoTqWKs5hTzRRqbC/NyZYnxw56qMZM3hED7giZeCVimHgJ287AvJ1iYORYeJpfecTr
 FiyA==
X-Gm-Message-State: AOJu0YxJWBS1Vz/hHhNcDsSN59EWDO3Ixl5TLmEdfyJwz8otGb0PjdkM
 fsatd0krjFFlWy9UGyaIzwZdj1VrWDtmSZnv2C4ahdNX87774Is7VYDHUzaCBBsFrhKMcnydBIx
 5lOEVmAjAQfpqIrbSyzzr8AXqcgolZFU+2U4YSKzd0gPZG6N/tATh0Zc98knQVpKShP9+M9c44W
 tCA0OyihMa/0qAcjGuNGE559PWxQdufm4mvSs3LL3O
X-Gm-Gg: ASbGncuG1rUaOb0764GhH40sdVfQH5m75llSO0BLnbpzGmSTr+dT80vdgzmvsZQHdGs
 kXTXRSWQiY3LmQL1qfn1/IQplQThJUjBLxpLc7DaBTWWu+deb/W+5k/dxj2LgnqCu4M9EnpG4ze
 BZuOTU86FWcEQ/bHZlcUSIxDC7uDi2LTmO78OWJ3CB33AKJmf/fpkbxvh3VuKb2qu9zmpEjs7Tm
 jv4QLnQTRQOJCuN/HrIY0YC+od9VMjy2JzULW+7ZQv6Wyfx+MeTddzV6X7Uzwz7bYRiAbBNu1ym
 pyNbX7mxCPy1l/7qd+jM4xciBNTW12JO5R7Ue6JueDWdzQAhFi/LNlMvLtLeTHCirgJYnTL2Gut
 +x+K1SQV9oAEdsakqw1NrOFDSG7Uj8ymJe0e42lFiEVJ/Yw==
X-Received: by 2002:a17:907:724b:b0:b04:7ef0:9dd6 with SMTP id
 a640c23a62f3a-b302b11e21bmr617135066b.55.1758706210487; 
 Wed, 24 Sep 2025 02:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBv26aG+WXqSnyMwmt2w/8kD3fCQw1qknKr1M/CZ0E3ooktbRHf4Sz/w8WyJm16upCEJgeEQ==
X-Received: by 2002:a17:907:724b:b0:b04:7ef0:9dd6 with SMTP id
 a640c23a62f3a-b302b11e21bmr617115066b.55.1758706207381; 
 Wed, 24 Sep 2025 02:30:07 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2e33da6226sm513053166b.110.2025.09.24.02.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 26/29] hw/xen: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:46 +0200
Message-ID: <20250924092850.42047-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-7-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/xen/xen_pt_msi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 09cca4eecb1..e9ba17317ab 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -637,14 +637,5 @@ void xen_pt_msix_unmap(XenPCIPassthroughState *s)
 
 void xen_pt_msix_delete(XenPCIPassthroughState *s)
 {
-    XenPTMSIX *msix = s->msix;
-
-    if (!msix) {
-        return;
-    }
-
-    object_unparent(OBJECT(&msix->mmio));
-
-    g_free(s->msix);
-    s->msix = NULL;
+    g_clear_pointer(&s->msix, g_free);
 }
-- 
2.51.0


