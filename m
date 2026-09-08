Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A2EC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3zmK-0006Nc-RF; Tue, 08 Sep 2026 13:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3zmI-0006N6-9r
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 13:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3zmE-0000e5-7l
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 13:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788889112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=IZAGdprwirf9Wpcw4bLH8/sdBK3hwdfa7g88a/togcmV2leixS+Oqk0salEnsqMaBOGi8A
 Dib8IoRXXii1Pykh+TZtZxTDYyfhLSF32UivrQNUYaC9ZWKSTCuiLijr9uwGWfnb4yWz7q
 Q0gEv67ddfCSaZXBTwHHSTcThOy0uuw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-4OwHQSJJOqSMJaA8UrWpEA-1; Tue, 08 Sep 2026 13:38:30 -0400
X-MC-Unique: 4OwHQSJJOqSMJaA8UrWpEA-1
X-Mimecast-MFC-AGG-ID: 4OwHQSJJOqSMJaA8UrWpEA_1788889109
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4843313047eso3084824f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788889109; x=1789493909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=K1juVPkFsUatmsAU6pvcXZZ3NUtl6y/x4Z8x8FwtNyYTVzWbXjvfAs6vgmMdJsy35c
 1s1wTMkJAgj7ITz2WTQovGlYoBp/NiyggSGrT13JMSrs9b7BUZtfmfCWnf4zt/P0n/O5
 nV8G16eEqC1rFn0GYGygiLctVkIJvfjgil31Dh/A3H8+M9lM4vxkfbk0qiqTFWAlbaNc
 1BoaF2vsstPlRwlJieur35hW8se79KxW+k5BPTRyffvbsTSrJoZ4roJlVKrzXp+PkSMZ
 pMUyZYjCoHUp6a1nBBh4D33p0a8VtNKZnDqXENvp0K7VsI03p08DZQWnkipAexS+RdHI
 uOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788889109; x=1789493909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=b5uGMpBEiJ/whqQPX2pm9tCzeLWITBahKwFS/BB7pUeKo7VwYr+UqZa8lfvY1E+/iU
 htMn9nxYCHzbd48QomTrrqhBQ243REV1RGVHzP6X04X/oGUg6PcEZvLvhpfwDcrlKJJe
 pUG6eKfNy2QwCUswb4RNqN+wwCcCOReB7ee6DsK4J0kqAJvjywl3sScX+E5vs5cpzPzl
 nI6AooIfA15+yEQLslgTbu9csd6eIIizffNrmH9t96hqD2n8icARUZtFEQpq5NzIUvJX
 2OpKq/YTw6lG1w6eccHPodR5C6SUDNtdKopTw5hh3g+kgWFvNmL31T82Z7WhM2U100I0
 NGqg==
X-Gm-Message-State: AFuF++lRmxyqib5Phe5OqO2xy0jp1/xyB/Pxvs2zAAfkieIOLf3A7jsc
 oFOnHFvVHs8CnI1/Tub7lnhTRxa7BG/9hcG0xQ7f+kifNND0vfufhUKOgUJrGL5z5Wqp4CPY7UH
 1lWNGJ6bRpiwy0csxhBp3f8t+f0fxBkYj2hrfeQbPrbQM+0Q2+yJZhdetLSYJRhIYKTZbgNxub3
 gfQyhRFG0ujUA9DZ0+ho3iDtOpdl4B1Q+slR4lcJux
X-Gm-Gg: AYBFou1VaPbOA/oxg6JbzX8LCtVP5Otsxhj1/x6dqyUNhJOvhzEShhHzZkOYDT+XiXe
 H8r1GwfOJUuLKqFoRIGGGrMXFPtQNffFl8yBMKSXOWqm7WDjMJBjPQ+9vKWArD3O70BW6M99OJh
 q91Il99mfTK0sD8rA1I+6jMv65szoV9ZjCjxgcXQ3OO0rWNgz9Auy+/E1KHXAYWmmiJJi1j7DoX
 TFmnGgEdZi/hhtH35R8HaQtRfrufT7l1a+LuN6HdxcXLHygZvDZpD2D/PxsvkGpfhuK0nbTf+ND
 flSfDXS6ibPmnVu97nc5NQlkE/BDPMHnV3ZVT3AGvPhCR+0JXu0x/iFFlZwo53p8C5Yk4L/cXWs
 7ozT+UrfuXYEEQ1uMk8P0+n/rytmTwV/LNkgODLFHWqT0t/3RDO6YBVq8D3ICtCNLmFEfDsFNUE
 Z4SUTf
X-Received: by 2002:a05:6000:4694:b0:482:f724:f4ba with SMTP id
 ffacd0b85a97d-485872a6449mr25997546f8f.19.1788889109018; 
 Tue, 08 Sep 2026 10:38:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4694:b0:482:f724:f4ba with SMTP id
 ffacd0b85a97d-485872a6449mr25997491f8f.19.1788889108411; 
 Tue, 08 Sep 2026 10:38:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm26186486f8f.37.2026.09.08.10.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:38:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust: bindings: disable more clippy warnings
Date: Tue,  8 Sep 2026 19:38:26 +0200
Message-ID: <20260908173826.867616-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
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

The clippy::complexity category includes manual_div_ceil, which triggers
with e.g. bindgen 0.73.2.  It is not really relevant to automatically
generated code so drop it from all bindgen crates, but keep it
enabled on purpose for other code.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Cargo.toml                         | 1 +
 rust/bindings/chardev-sys/lib.rs   | 1 +
 rust/bindings/hwcore-sys/lib.rs    | 1 +
 rust/bindings/migration-sys/lib.rs | 1 +
 rust/bindings/qom-sys/lib.rs       | 1 +
 rust/bindings/system-sys/lib.rs    | 1 +
 rust/bindings/util-sys/lib.rs      | 1 +
 7 files changed, 7 insertions(+)

diff --git a/Cargo.toml b/Cargo.toml
index 397a64ea99b..b6b6d97dfec 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -47,6 +47,7 @@ redundant_explicit_links = "deny"
 # default-warn lints
 result_unit_err = "allow"
 manual_checked_ops = "deny"
+manual_div_ceil = "deny"
 should_implement_trait = "deny"
 # can be for a reason, e.g. in callbacks
 unused_self = "allow"
diff --git a/rust/bindings/chardev-sys/lib.rs b/rust/bindings/chardev-sys/lib.rs
index 903f6fc492a..61c19412b07 100644
--- a/rust/bindings/chardev-sys/lib.rs
+++ b/rust/bindings/chardev-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
index 8cef4a79619..cecbf808dd0 100644
--- a/rust/bindings/hwcore-sys/lib.rs
+++ b/rust/bindings/hwcore-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
diff --git a/rust/bindings/migration-sys/lib.rs b/rust/bindings/migration-sys/lib.rs
index c8397dc8974..4d13dc3cb2b 100644
--- a/rust/bindings/migration-sys/lib.rs
+++ b/rust/bindings/migration-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
diff --git a/rust/bindings/qom-sys/lib.rs b/rust/bindings/qom-sys/lib.rs
index 21b996aeaa4..6b5c562951d 100644
--- a/rust/bindings/qom-sys/lib.rs
+++ b/rust/bindings/qom-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
diff --git a/rust/bindings/system-sys/lib.rs b/rust/bindings/system-sys/lib.rs
index 30adf683c35..2dd5c7fc926 100644
--- a/rust/bindings/system-sys/lib.rs
+++ b/rust/bindings/system-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
diff --git a/rust/bindings/util-sys/lib.rs b/rust/bindings/util-sys/lib.rs
index 0212e941843..f78064e52cd 100644
--- a/rust/bindings/util-sys/lib.rs
+++ b/rust/bindings/util-sys/lib.rs
@@ -8,6 +8,7 @@
     non_upper_case_globals,
     unnecessary_transmutes,
     unsafe_op_in_unsafe_fn,
+    clippy::complexity,
     clippy::pedantic,
     clippy::restriction,
     clippy::style,
-- 
2.55.0


