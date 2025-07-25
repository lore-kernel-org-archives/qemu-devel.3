Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B53C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHwn-0006lR-NV; Fri, 25 Jul 2025 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwO-0006IF-P9
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwN-0007w4-1X
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKZhYrhLklT7wy5r7XGVHBie6wvhRMRWF/tewAfL1Jk=;
 b=N+vuv0nl0uvwMJJA+R7MbDx9EPx36Ncqjgq1yJnIi31bUOWf/7QeAlu4tDRPt9gMQW/kCB
 cr8Rd6q52D1aSe1B32Ggg5gudpxIOA2lcoQ2EKwL2pQRZl86kEKiymR4dtnRjAK3o/Hgv/
 0Y7kI5oh99IohnVD7Qc8VvSZbmedVuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-d3CVZcplOK-8Hp3hU_6giw-1; Fri, 25 Jul 2025 08:54:19 -0400
X-MC-Unique: d3CVZcplOK-8Hp3hU_6giw-1
X-Mimecast-MFC-AGG-ID: d3CVZcplOK-8Hp3hU_6giw_1753448058
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso12768305e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448056; x=1754052856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKZhYrhLklT7wy5r7XGVHBie6wvhRMRWF/tewAfL1Jk=;
 b=kR1HnbjfMhRUCyegoliBtr3BY4V4pdh9UPWOmQeZQoIOSGtGvCYk4Z31pbYmtr9YdN
 VW3zVN5oKpLbgPrU/4gmMsSF5E0CViz8zoGfnlp2AFqVISbQP5SW0BZPUy4wa9x13nR0
 8KjLhx59dHnbSdJkl09WFULQxaBp5YF88rhgLecRwnUcxQS0mND3Lnv7RJN/DthKoLQs
 /TgriruxKRJZQD4vKNsoeN54GMCdUj0k8bEGNroH7v0j4J8oo/tCXjcgXKlN/C2kd2+X
 Y5gdLgo9CxZ9eUHGFHyVVdLcjVEp21fwsB5LRkBhl7egKjYssn6vyWALVpHLYVWMsSZ7
 /oMg==
X-Gm-Message-State: AOJu0Yyp3I5OfhvIKrSGgjY05/fuw+8qlhcAOuS/dvk5t0eeCs4bKRqK
 gOTC89q6VtmvRReC6YyKAfwsCv7H0vLJMfNgNSEHuL+LXIpA7bPbeGDHe+cHVi/Z9kNu6Qt/Aab
 z/L0DHSQ0qXZHvSJBPAaSjnRT8wiaHKy9Dh6GuRCFr0oTbFjpCnr7N69ETSaR08hxPUrlfH7iQu
 PpAnglyqUlsUVbPyyrRg1yOvwKGcx4NlLTDbU8kgi/
X-Gm-Gg: ASbGncvt10Xd/OzxGb13gNHhbm+BEBdG6AttdAZUVlwW3bwUYQSacO67YzbxjlSAMSU
 865NxdMLaZxDpuNUO8RlaixkA9//y4akf04pRazi3WMv+iaGnE4gReIQ/heqpITwDjpv1+rgSgo
 Zp/V0SZowOY8TBeNqwi07BzMPc+psOId+ry/u+JECMmoWqZUqcYsMIb5eUx86JIxfS8Unen0g3m
 yHKKZBoBmE7kt8g5iMTvE1/oi6fPSoo5RxLvX3WuSHr62bva4LqUDKEr58TtWDG7KS8AXSv8wTM
 Jbmi8u3uFUt8lH3E2Afdpk6kdDNsxrZ9sQ2b5093PIjs
X-Received: by 2002:a05:600c:529a:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-458763117f3mr20134055e9.10.1753448055736; 
 Fri, 25 Jul 2025 05:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrkZVgPj7areL+BjU/gsayfQGBhJmb4UEYKxaDz/IBcyEC8ujD8THpECqG8T2sHGP49H3xAg==
X-Received: by 2002:a05:600c:529a:b0:456:c48:491f with SMTP id
 5b1f17b1804b1-458763117f3mr20133725e9.10.1753448055225; 
 Fri, 25 Jul 2025 05:54:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532baesm53712305e9.1.2025.07.25.05.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:54:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] rust: devices are not staticlibs
Date: Fri, 25 Jul 2025 14:54:00 +0200
Message-ID: <20250725125412.1128617-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725125412.1128617-1-pbonzini@redhat.com>
References: <20250725125412.1128617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

This is only cosmetic for now, but hopefully later on Meson will parse more
of Cargo.toml.  Devices are linked into a staticlib but are not staticlibs
themselves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml | 3 ---
 rust/hw/timer/hpet/Cargo.toml | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 003ef9613d4..88ef110507d 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -12,9 +12,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[lib]
-crate-type = ["staticlib"]
-
 [dependencies]
 bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 6f075027843..ac5df23c1d0 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -10,9 +10,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[lib]
-crate-type = ["staticlib"]
-
 [dependencies]
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
-- 
2.50.1


