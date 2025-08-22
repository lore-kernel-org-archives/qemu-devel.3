Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39741CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrW-0004pL-Cx; Fri, 22 Aug 2025 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrQ-0004n6-D5
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrN-0002OZ-LW
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlzoW6M/0aXbQfw1PTP04J7KpMpVHxRdNHZMfZSstto=;
 b=eLMKYSarSZCZykP2NqgqlM2cZnFITBp/yCDZdRYfUQFJzId05vZ9FYyep1d/8ZVyrE3GDq
 bEC5x6qMVXa2HOICN2jMAoXIWVRjaMzeQW+FF5I1U5/a7nC5SpdY4V0uu/Snrrl3MVIU40
 UTnZ98k+5yxpy1YJU0+oG4DJj5sclK8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-ubauZtstNLaomhqzrDYPdg-1; Fri, 22 Aug 2025 08:27:05 -0400
X-MC-Unique: ubauZtstNLaomhqzrDYPdg-1
X-Mimecast-MFC-AGG-ID: ubauZtstNLaomhqzrDYPdg_1755865624
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e19dso117659f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865623; x=1756470423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZlzoW6M/0aXbQfw1PTP04J7KpMpVHxRdNHZMfZSstto=;
 b=dfci7mnLwFMPsoYb3CtqGfaq53afRetsO2lQzMYdvuydP6fMNbUqsWmZ24c+5W6/lv
 0Rf0A3lGX5yki95bMiJHMRq0tN6Y4whDV5cs2Ztw16CIpxwNS0jmhjRhJh8O38eQDfXj
 I/ie2euT9X3K1ID/vyEU/GXFY6UUAoyypmHKi/GhpCWisb3qk3G3E4ucznxq9lAqOGUz
 N03kYz4FIkNPhewyNPtSXi1BdiApOJC98Lrc/Gf9mM7j10YUmGxD57vZ+KW41I1k6cBv
 7AZnEognFEsjRLHjqVjG0kw+jVr72lsht91+t0eqDn4uYXB+xj/NQgozwIcuCnymhO8O
 Ai9Q==
X-Gm-Message-State: AOJu0Ywxxg8ogpZXuAGr2dCyafFlJkjBG/d6qXUcgeJIQWil3ZcqwF5u
 DHQNslXLpdk5Pf46lB6NgeQWQ2hbrxJlkmIf1gYy94sh5a8tHIMihaYuuJ2+lvNvVWWKNXtbtR9
 UD5TsKtjph0yC2NUdZnftvKA0EupSD3y9DkFDibnN2GzNc6gqjNRmzEfNmS+oZTQN/qVMsYTisz
 v+WNzOvhACu3GW4NylwHSyUoNkqNy+l5mBhVMh4LIX
X-Gm-Gg: ASbGncuGSbkwOIY/5tdoAuBW9YtDHUeOKroEfKEOLoH8aL1VRtZtrivZZ1KchI0mKKk
 k1MhULPGoL178XKtYmZ6m44mrcnHbZjMYmM9jQ7Kj+obc9DmKKZZM4TZnffVAmevjgMlwvbXAgQ
 rdrbqtkeET+byFN9gInJfg26Y/atiG9gaDwjvRfaXPDntGNjtjQw1eb98vrHbIYLWTGeTuwigPo
 uURmCbbrOr/HOCZnxA3VoEvIA5MgZzFcxfCNkalcZEnV9fGQf0W4Xn7eVR6otemKVCYL/7CwcTa
 aJUsjdBFyUZ3ZrF4//SkTn+s5w+MyE0GIDdElWoSK/RAIJGLfwqc+GVD6ACyHvUMXZ398n9oLNr
 xAynejvURsX5a/B0aYFJz/zoeSvU4wm4AxA/41QzReQ==
X-Received: by 2002:a05:6000:2387:b0:3b7:8d70:e0ad with SMTP id
 ffacd0b85a97d-3c5dc7351d2mr1890659f8f.32.1755865623287; 
 Fri, 22 Aug 2025 05:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF+U0k3mY07gVFgLSeWkZwcd5Dg76g+mSinldGirnhMC2X33FZX8Aj+kMJxAmQRhAuJKvGdQ==
X-Received: by 2002:a05:6000:2387:b0:3b7:8d70:e0ad with SMTP id
 ffacd0b85a97d-3c5dc7351d2mr1890637f8f.32.1755865622763; 
 Fri, 22 Aug 2025 05:27:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0748797acsm14717254f8f.10.2025.08.22.05.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 02/14] rust: move dependencies to rust/Cargo.toml
Date: Fri, 22 Aug 2025 14:26:43 +0200
Message-ID: <20250822122655.1353197-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As more crates start using the same dependencies, it's better to not
repeat the versions and move the dependency declarations to the workspace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml          | 5 +++++
 rust/qemu-api/Cargo.toml | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 682184cb158..99c275f2d9f 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -15,6 +15,11 @@ license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
 rust-version = "1.83.0"
 
+[workspace.dependencies]
+anyhow = "~1.0"
+foreign = "~0.3.1"
+libc = "0.2.162"
+
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db7000dee44..c07a17a28b0 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,9 +15,9 @@ rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-anyhow = "~1.0"
-libc = "0.2.162"
-foreign = "~0.3.1"
+anyhow = { workspace = true }
+foreign = { workspace = true }
+libc = { workspace = true }
 
 [features]
 default = ["debug_cell"]
-- 
2.50.1


