Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F24CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo1x-0006oY-UY; Tue, 26 May 2026 05:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo1w-0006o4-Fn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo1u-0006Jk-Ll
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ns7RJ9JwSJNVTsaP8/dBpewtPCa20/S6GzvZ/AxjbA=;
 b=ekFgznq9InGD65QZ4h93AhSYDynXrQ9fDPX8mBMYYuykjOyUAzL9w/n3QaTeFahabB4KpK
 UVLIQ2q5def18HsfxnXWwsoJcV7r9pqNg+cdqudqna2c2WcfuWcmbcKmCCs6+3oFGc2cIa
 t3Sr3TMWVaqTVoqj0Zv47KTPuZtYsJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-5u-G68HPOKCANYj8hATT-Q-1; Tue, 26 May 2026 05:24:49 -0400
X-MC-Unique: 5u-G68HPOKCANYj8hATT-Q-1
X-Mimecast-MFC-AGG-ID: 5u-G68HPOKCANYj8hATT-Q_1779787488
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490402ae2c1so41617355e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787488; x=1780392288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ns7RJ9JwSJNVTsaP8/dBpewtPCa20/S6GzvZ/AxjbA=;
 b=DHafaXvYzwAy5MNn5zQtrhnvWjOSUWDyN82VFBah7t/Vr3m0Wqsx7v37BrxXt50h+/
 SoaWejUEzG1AZM/zRwpZmu2FYlDh3iMOHx8ek9qeTeJJ61Z6FbEJmZNoG9RzwrHujrJF
 HeWdcJQHFCLk9tOydC0q3sF9f2ZljJeOmqa2Nh/tnmY+gBNvc+90XwdbAZuTaJ6jZB9d
 SUrAPdqm9kUC6Ugf1YLCHMGLBGR20O0ofiExZb6pv3+7HNcnJB01rUSRXfbRHDF1WRqP
 dW8X+rjbFDbIvZ0gteVkh/CESwcvk2Tjdbg1GQ76nffY0sO9i8M0KHULKH+2ugADArBY
 aZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787488; x=1780392288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ns7RJ9JwSJNVTsaP8/dBpewtPCa20/S6GzvZ/AxjbA=;
 b=Jlxk249VGELbsR9ZXn8t9dag03hFILhVQoMsQkg+I5FlcW72mu13W9QKwxkUDesUY6
 pzwAbBfK/7fO4Fi/5cWitUngx1p/vWTru/Ls5RNBkTYznsE0m1MrRsp+zVOFcZIx3+5j
 p/T+kTByoqd/N+SLNJl5c26e0erYt/4TM6N/7Cm2X8bMmu4UuZOZUKK2X5f6LUYi8fmH
 UeQwslro1qfWjpau0qzfYHQZ248rBTu2XTX5+MCmM+ukFeTzoDkJJMwHXWZZv6RI8I7E
 vCzmFPE6ORFriOWexhYAeU3nn9Me9Za5BFcB6Ogv1fm3fXro+xhp0x2z0/FcSxXS0Gp6
 v7ow==
X-Gm-Message-State: AOJu0YwCT17XSrbofrHFjHgwaT3yP5KGI8Z+osij/vonh4lhTZ6dYf88
 ST4h5Ka8RbvblLY7YeosB+MZ6phtnTrnfO1RZnqgkmp+kPSGvunW2O4vkRvuoUjYtHDe7yZajrD
 LUsKh5uED8iTC6P4MBDaQgsYOv58AxsDY3NYa7nAaziLTE64lx3RvN+w8Iv37iigtAsO5Lft9qw
 gVHKwqvzcFxf1VsQbMQmZGlm+0iTI8MgRTbIuFY47x
X-Gm-Gg: Acq92OGi9nXLFL9SXccA/GBo82lcCkoW+Yw0EgvJNVX40yyNY96fSuRmxOYV+az5N6F
 +9PRZ0vlEF1Z6NxxT5/u5kMDiWvq/+DDcAt7CzFjMDE7ojmkNF3SgN6UvPFP7ROF6l6b6EPpGYO
 qMbpeyeCufkdF0kFbS502nD70eLTCQPsk5LN/OiWHbgISBjyvrgXamOWITK816umbS4NS3FZYGG
 mAr7Jvcbn2Ua/9gNnoiDxMNM6ipugmw5oVAGZSVZK6tuXys/YVXJPhuYJDtvuQqaNK+bzxPwrFJ
 0Gs+u+WgYZ6rfFZxrWimpml/hPwMv1G9x8dG/cSreMaicfVjy9DQtY2TYga4xP6uwDugsiJR97v
 O4j2D4AXx8GWOVjmcqpe1QwvnRTNMXtCvYoZIw1wWFevhnbCobOGKsi56NJX+qSHhhHS5yiWP5U
 E+glOi1wRwamcEioVkJIlIAup+BOE=
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-49050000ae6mr227991175e9.1.1779787488463; 
 Tue, 26 May 2026 02:24:48 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-49050000ae6mr227990725e9.1.1779787488088; 
 Tue, 26 May 2026 02:24:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490791a3f16sm15303615e9.9.2026.05.26.02.24.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:24:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: fix incorrect dependency in Cargo.toml
Date: Tue, 26 May 2026 11:24:46 +0200
Message-ID: <20260526092446.147924-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bindings/hwcore-sys/Cargo.toml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/bindings/hwcore-sys/Cargo.toml b/rust/bindings/hwcore-sys/Cargo.toml
index c20024e921a..b5ae33da8ed 100644
--- a/rust/bindings/hwcore-sys/Cargo.toml
+++ b/rust/bindings/hwcore-sys/Cargo.toml
@@ -21,7 +21,6 @@ chardev-sys = { path = "../chardev-sys" }
 qom-sys = { path = "../qom-sys" }
 migration-sys = { path = "../migration-sys" }
 util-sys = { path = "../util-sys" }
-system-sys = { path = "../system-sys" }
 
 [lints]
 workspace = true
-- 
2.54.0


