Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A61C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Kff-0001pp-Cb; Wed, 09 Sep 2026 11:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4Kfb-0001od-IT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfZ-0002sk-UC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=fp8zYajLhFs6RoU/1r5rzgUBZqOcpMxqa6ZRchM+5F0364XwInVTYspguKYR4dpjNJGrWn
 HcedwF4xhssHgPe6deuZlJLFDP1n9LcTpZ5OzMlvjq+iMMLB78Zf7ee8bCfYQTZhb+KY3j
 6GGsNx7YBRsHyQczn6Jjhxw/KDlZbVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-jZ1gxX4ZMt6FzM2fNb9_cw-1; Wed, 09 Sep 2026 11:57:01 -0400
X-MC-Unique: jZ1gxX4ZMt6FzM2fNb9_cw-1
X-Mimecast-MFC-AGG-ID: jZ1gxX4ZMt6FzM2fNb9_cw_1788969420
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-484362cb000so4366f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969420; x=1789574220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=IZZF0pm0lJ4kc7wNo+6gThFDWAGOwtjNPZ8CSsPgsNQGtKY58Cdvkw/hKx33tr1bxF
 AOkg46af2euROZbgse8hrMC2HIgilMIMnFFaWfmMcJFd8QqP5Lj2WLgR/DJLFNSVta0F
 0UyQbu7EOh91UE8ooYNK120jkE52wZpeXLMYlfqKn66LfJoSh2oAANJNgnGcl6IDQcL3
 v32B0d2pcd5yVDkiDtGG1qy03bCgJzwz3G2b+g4jZt6clxwGvejL7GIAdYge2zov7c4B
 BEVrooq+GRVKJT2KwnYgiWmyI9sYNuOZ7W0NwxKq0BoyjSsiPCasO7/mCr8WEYgyW5Sd
 1dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969420; x=1789574220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UxwWpvJuIx7L+pTUhfla9Ag14gUSdLkdhZoScBOjn4c=;
 b=pZ0AU3lAt51fH1yhYY54raZYUIKa14xP7UPVs5jFgolQhgKj0zcTRUFkSEOJCZFXoU
 pMufta5gvTfB6hj9KsWVCx23MUsFzLI1H0RuuZK5149RbI7Ei/BMBiz8+iD/UJEjThk2
 cbWAUt0fVzdtYd3g/8c1Cs74IILZLVEKR0SDIJ936Ax6OLjLpTtbP6ZQtzkNAQyqyU+0
 HB3shLcu1uRTF82HDPbxAFWz+tU/wD7HHOhf3eMGQHR2cNeHyTCCuRqLukAnEuYcd0Uc
 /aX6cvdi6Po4Rz/dI1zrtXMWhRuebCZnQaIaw+EM1GHRV7La+7Yc7QWgf7f/JrBWTuc9
 eJyA==
X-Gm-Message-State: AFuF++miUKR+YTPpQPG03jeQuEiKzC86fiPQyNDUeNirC0trMAOhs58J
 HTxWhW1Zciobk81vmsTPe/h011atIZgeyKB/XpGA6tdUwt0tTNUUgfsLm2ZhbVUnQ2ZiteqZp25
 A5PAvgzPzv226aREvdHsCAnr2x37PEyQrgv5J7KgBYd63sbtufH3YeJxpClR5gabgYYVrKvdRgm
 rUWFir8JjfeSiKdlZqL+oSKHRzHMNjkz6CM3Q8w04L
X-Gm-Gg: AYBFou3nfKmiguVcrF9lu5tFYIAOKsftIa1xiHDcxNl1IoPlnfX8RjaXA6SF8QbpsND
 BEUquAfNE83sZ2UiCGUDvxwnCtKG0/POYyXu7qCtRxOin96o7hUTgHIH/x3gco1JrYc0nKDi/09
 L2OzX2JfqYhXxVQ9sYfAaU3QnZeuXfJAPixpiLmVQyntNaNHYFjKzzD4KilfPcos/SflwYjrhVa
 TeCUHv2nMjGqvbD0D2Bz63IROYiwXJUlow4dnUqiMaHI2VBHUQhz4A7wLkLxm3ck7Rg+7QorL4Q
 mXQ0GLUF9KZIcuRQQftCSwB03XP/qZT97I7c3ajGi4EE+3wq1GnOieNhRUt4w0APMEFdtAZG/Ft
 iXy9X0iFavMoIW0w4VVt04JIdZO/a08GIaKXuOgrqUihNbi34mhiYe3OjLauo4NljVy5yShaFb4
 UEuMcc
X-Received: by 2002:a05:6000:4918:b0:485:ad72:cd65 with SMTP id
 ffacd0b85a97d-485ad72cf0fmr5391305f8f.2.1788969420168; 
 Wed, 09 Sep 2026 08:57:00 -0700 (PDT)
X-Received: by 2002:a05:6000:4918:b0:485:ad72:cd65 with SMTP id
 ffacd0b85a97d-485ad72cf0fmr5391272f8f.2.1788969419712; 
 Wed, 09 Sep 2026 08:56:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c074asm43864543f8f.23.2026.09.09.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/12] rust: bindings: disable more clippy warnings
Date: Wed,  9 Sep 2026 17:56:24 +0200
Message-ID: <20260909155624.1082893-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


