Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D21C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarh-0002gw-8w; Thu, 27 Aug 2026 10:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarg-0002gS-2Z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarV-0005k2-NO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/O6x+kgw6s99eEjinNaj/p2rgga36nR4TA3pRTnHMs=;
 b=O21+amT9xqmgS0V1cwZwbGXL4VntO0oMsyBC7s02PxhjxNF7RPDpwoK1iRcjnG6EPDabsm
 j25UHXozreDoEe44C+7s1ADhSTrXikOm7gXVSpa+hEaYiawrRESk8R0olfaMEmg4Qk5yFc
 FtQMhIXnvRGUl/DnIw6NDQbtDNpOFwU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-AWMbcodzPZiOuii7elywjA-1; Thu, 27 Aug 2026 10:13:45 -0400
X-MC-Unique: AWMbcodzPZiOuii7elywjA-1
X-Mimecast-MFC-AGG-ID: AWMbcodzPZiOuii7elywjA_1787840024
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a5d7e3ac13so653363a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840024; x=1788444824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M/O6x+kgw6s99eEjinNaj/p2rgga36nR4TA3pRTnHMs=;
 b=RGhLLyIo8+DSC1cftE2TMQCV3t0Cy+qqlJuzBb0KaA5mZIJhfB91Yr159KKjbk/8Mc
 5wQbQBKmQMTGRYyTBfXYEFM3LGHwQiffEfK+3/0xij2uBDNJ8a2qY0JJjUEfNcrGNvQZ
 z3hZvDz3sbnWKsVC7AhhRD6aJ4kAaSbKSg3tz5ASOqagJAD6rFNtwECatrkerH9B/6rx
 c8lpEsUl+4CiF66UNbc2onjjd6MnGBcRCYYkUOQGTK7sr+VyppRV7mTikdbU+GmhPvWt
 vltrOyEAemi17k6CKRyvK9JB/vnqWK15GlG9moTFP/tayeA0Q+otrYyGEU3bvhUI+1yW
 G3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840024; x=1788444824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M/O6x+kgw6s99eEjinNaj/p2rgga36nR4TA3pRTnHMs=;
 b=az1Z0ysqwXvI6cUMN6N+0BVA62CaGBXbnljNeUW0U75RI5d3zC3GcjLIwZNobq8sjL
 Qqq70kMPl0Go8XbY+pW2+QvwYY0vwrV6CKVgZCHgLTuaKWAsQR3NuA7PFPCwvHLk5AIg
 2k0jZTThfhUPeyuK2TWWos4fK0U/Z3+AtGQbhCjC2o+cIzlyuarUXAD6pMMDZvBTDcOT
 DCXnf63GA+1wF3iYiVfSoLY0sWOcW9dCCNZGQ5wyacyqZv+2yLolQ8/OSFCLmcKfGFP0
 G4zE9JjxpMwp1dptmeB9RxIMNVJFp7b/clvPM5U72G+a48tLCTy8iJ1S6Sh9AGZY6cb2
 uITg==
X-Gm-Message-State: AFuF++kxWKX0ZwqasJpBsDuOlutfiZ9h9pwfQwa1+2aKEGz0F2oPnuAr
 PV/kHQrARn4+twYO1k2aYwNLg7fiz6O+rwq8oMJAgYW62NcFP8sGnLgS77P9yB7GZ6SL0mPdemS
 QkPKFTBvCrnHNAYrhmGgc/WvO4GplNoPQ1/lZpJY2YdQuvpMdqpyk91Ls164u+k0ENzTVvl9eem
 PImg8Y8/XqBF9SqAAfU3dBqWVzEKCrup2sMyeREjC3
X-Gm-Gg: AR+sD12YR0acBwGQdi2yTIYUE2iacJ+W5S7b1+bgHV1GUX4ySEAbQlI1O9Mty3RwBPC
 2yV+Leb6/DOQPPXhpCXqKnLMnMAcIJyJsMGiwWkCtNEyqHnmQTa08aY9IfHDKxLhwztcyRWVjUr
 pcNdFXM6jBU3fnrl74ka5w5VLYfyNLHJGyjhQwuuBlwONhxHyKh7nUAqiIDCBIDFGemz3d/eqLY
 APq0KRLWIGEUC+CgilqLe+CeViEcD+izLTGw7N+sxnrJzmjun5hImmZDu6u5ZC0tHfqA9T2S87+
 xYJIRd2U4Dm9zc/UvnWEM12P6PjduTYy/Gx3IiC24w42PJwTWFlRnlUtwVWxuH3gcZBd7U0lQMj
 Z/u04NtbwmD2PzeC5Wml5RY8WacTd28se7L4nW04mkZ/sDs4EBxxXLjlRE/OJPBVxjoBHYY1OuN
 /zxqw=
X-Received: by 2002:a05:6402:1912:b0:6a3:ee5c:8800 with SMTP id
 4fb4d7f45d1cf-6a5df61fe9cmr18595180a12.8.1787840024053; 
 Thu, 27 Aug 2026 07:13:44 -0700 (PDT)
X-Received: by 2002:a05:6402:1912:b0:6a3:ee5c:8800 with SMTP id
 4fb4d7f45d1cf-6a5df61fe9cmr18595113a12.8.1787840023542; 
 Thu, 27 Aug 2026 07:13:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa786csm6533587a12.20.2026.08.27.07.13.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] scripts: rename get-wraps-from-cargo-registry.py
Date: Thu, 27 Aug 2026 16:12:57 +0200
Message-ID: <20260827141314.1099352-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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

It does more than that now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                                     | 2 +-
 docs/about/build-platforms.rst                                  | 2 +-
 .../{get-wraps-from-cargo-registry.py => update-cargo-wraps.py} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename scripts/{get-wraps-from-cargo-registry.py => update-cargo-wraps.py} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac8e73bb24f..a8d7566e06a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3764,7 +3764,7 @@ F: rust/rustfmt.toml
 F: rust/system/
 F: rust/tests/
 F: rust/util/
-F: scripts/get-wraps-from-cargo-registry.py
+F: scripts/update-cargo-wraps.py
 
 Rust-related patches CC here
 L: qemu-rust@nongnu.org
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 3d23dfbd779..676f6901acc 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -128,7 +128,7 @@ Rust build dependencies
 
   Some distros prefer to avoid vendored crate sources, and instead use
   local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes a
-  script, ``scripts/get-wraps-from-cargo-registry.py``, that automatically
+  script, ``scripts/update-cargo-wraps.py``, that automatically
   performs this task.  The script is meant to be invoked after unpacking
   the QEMU tarball.  QEMU also includes ``rust/Cargo.toml`` and
   ``rust/Cargo.lock`` files that can be used to compute QEMU's build
diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/update-cargo-wraps.py
similarity index 99%
rename from scripts/get-wraps-from-cargo-registry.py
rename to scripts/update-cargo-wraps.py
index a26fe135eb9..b66a60ebad8 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/update-cargo-wraps.py
@@ -3,7 +3,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 """
-get-wraps-from-cargo-registry.py - Update Meson subprojects from a Cargo
+update-cargo-wraps.py - Update Meson subprojects from a Cargo
 registry or from the versions pinned in Cargo.lock.
 """
 
-- 
2.55.0


