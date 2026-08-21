Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC2C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKmr-0004tp-Id; Fri, 21 Aug 2026 04:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKmp-0004ra-Hp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKml-0008I3-IB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNT4gCVRYyaXj9erYrsb5EQE1LH/A5pl3a3ZixZaCBM=;
 b=GKFfDhDF46I8lHVvvwi9aIp+J9lVJZhQak5AB7TTbhavAvnFaTf60ACZre8PnUWkv72MlG
 Rb6FBRb7z4XxMWjxoo5ina/Jnu6haLofp+NZty3iOXIdhptkgdcaLSZCo9WCqmBVdHV1bK
 earWLUVTIQHQo4OPTtQRjD0w1aLAY+4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-6oC_kBwlM0CCCikV5gKxmg-1; Fri, 21 Aug 2026 04:39:28 -0400
X-MC-Unique: 6oC_kBwlM0CCCikV5gKxmg-1
X-Mimecast-MFC-AGG-ID: 6oC_kBwlM0CCCikV5gKxmg_1787301568
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c16740eb587so53634966b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301568; x=1787906368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNT4gCVRYyaXj9erYrsb5EQE1LH/A5pl3a3ZixZaCBM=;
 b=MJAI2L0Yzsu11sbzkhBz0Su02+ZePemeOgAASO5G7KoFqfR/1n5APvGwACdFQurd/a
 DBC9nfD67YcRhIQPlPYSE+hjckEldtMEBJHEHhEh9S6vW9sxRiWKXScyz/J7/7Dmvc4H
 Ug3/GJNrinNrKbXeM9q1FP/1L1NCgGz42+7sCVmbsXaob4wnEUBtLojAd9E/EjpXBJMv
 bKiKBlrmDkLSosPRHVjxPS45ouKjh9Wv0HdEyEPP59mFyLXP/YCf78In1sleFeMD39ua
 GCPY1O/jWgR1YTNQTEbzWGO0ESfTlSfJ/habRpLSJW48WXBWMldBFQ1ernz/b0a4mI1q
 2X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301568; x=1787906368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNT4gCVRYyaXj9erYrsb5EQE1LH/A5pl3a3ZixZaCBM=;
 b=pmMX0gWDjWsN83SLfmL3ehoNsQp+UmrE3mzXs8n49vMLsSlhH83yJSXpdOvq5BsVk4
 r34kVOAsDLU8NEW+SV/AHkORlPmspwQzNwP8DxBkKDEwkRKiQ/om+uOIxXKu8/BGjlwJ
 gEIjYkgllpkq9OQDhU1wH8iF+x3YWHvfuUWZC5fzMKolECo6hbNHf+/LQz4YJOwUHqEu
 zKtzS6fll0E52cuC2+S8ej26tA+ZTowFmmuIj85EuP0+9rPrpLrCmVx+GzbossZKGKOJ
 9Cs3oFCxGB0o1rh/lB1mS8GavmtplLkxcSo0EdRplSzqqF2uCK76V4bstSQAhX60fmGe
 euHg==
X-Gm-Message-State: AFuF++mVi7qphOk9mL4O3sZv6g/04707l4sdg2AJGeYc02VxZ+V7dqC3
 2owW70i0TT0voHZOPDQZx3Q5gdPhBbPB9S8wWKqzBulaDTl/DNROd5Egf7C0n/7pGK38mDTzHeo
 uZmVcv2mxcFzwZc4gJNZ+K8ioE558MuGVDNvF3E91tDQhk9VIrZwQnAlIhs/5fqXqYpcqe/JKR5
 5y4rTax629AqN3T2So6rwZSjB8y6wkLxUIwviwrU9L
X-Gm-Gg: AR+sD13BAl5tzGxQq8G/WP12IArdeMg8FDPmR7TxbRfVVS/PtPejwVALTxpT2aCShdR
 dLafhEvnR2FCHCxsr+hUK2lr3Dy+WhBYJ4XChGFDkU+JHBnDWIXj5XY5+sNV4pPqoQQe7oS5ErK
 0Pidq7MVvPXlgBg7epXuN+r3gNW6ZizJRHUqgif8Lhazyqkcd3J297bLx22Csd6ChjySmN9q8r7
 KPPulFkc/L7MCX72lbJkQ17qdK7SeyoccfU7qQbZAeHsl8Vk+lgEHhb01DCFbCUMjpoDOG3dOh5
 GvpMZXo/3ZGAhPOi3dcXqDKhuabknzVwEFSoR4WQadYBaMpsLMbrIMrtT3Ydp2bdjDuRMDelykj
 GVUlSo3mh1sqyFGtH+aTcRFVpkkDSJmD5N+yIdappVveKUA1XMIqiQEqiZmrSOFkCoI8h3F0Xy5
 n8nY0=
X-Received: by 2002:a17:907:a4a:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c246a36f311mr404133466b.8.1787301567702; 
 Fri, 21 Aug 2026 01:39:27 -0700 (PDT)
X-Received: by 2002:a17:907:a4a:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c246a36f311mr404129066b.8.1787301567194; 
 Fri, 21 Aug 2026 01:39:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459197cc9sm368635966b.31.2026.08.21.01.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/9] scripts: introduce script to update cargo .wrap files
Date: Fri, 21 Aug 2026 10:39:15 +0200
Message-ID: <20260821083925.2008135-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

Another small piece of the usability puzzle for Rust, this time
tackling dependency updates.

Extend the existing scripts/get-wraps-from-cargo-registry.py so
that it is also able to use the versions in Cargo.lock.  This
makes it much easier to update .wrap files after running
"cargo update", though manual work is (intentionally) still
needed when the semver of a crate changes.

It's possible that this functionality will be moved to Meson either
wholly or in part.  As usual, introduce the prototype in QEMU so that
it's clear what is needed.

Paolo


Paolo Bonzini (9):
  scripts: print build.rs diff
  scripts: rename variable in scripts/get-wraps-from-cargo-registry.py
  scripts: do not assume the new version of the crate is present
  scripts: prepare for introduction of CrateSource class
  scripts: introduce CrateSource abstract class
  scripts: add functionality to update wrap files from Cargo.lock
  scripts: add the possibility of a quick update of the pacakge
  scripts: rename get-wraps-from-cargo-registry.py
  rust: update crates

 Cargo.lock                                    |  48 ++---
 Cargo.toml                                    |   2 +-
 ...argo-registry.py => update-cargo-wraps.py} | 198 +++++++++++++-----
 subprojects/attrs-0.2-rs.wrap                 |   9 +-
 subprojects/foreign-0.3-rs.wrap               |   9 +-
 ...sys-0.21-rs.wrap => glib-sys-0.22-rs.wrap} |   9 +-
 subprojects/libc-0.2-rs.wrap                  |  10 +-
 .../libc-0.2-rs/meson/meson.build             |  20 +-
 subprojects/quote-1-rs.wrap                   |  10 +-
 subprojects/unicode-ident-1-rs.wrap           |  10 +-
 10 files changed, 207 insertions(+), 118 deletions(-)
 rename scripts/{get-wraps-from-cargo-registry.py => update-cargo-wraps.py} (38%)
 rename subprojects/{glib-sys-0.21-rs.wrap => glib-sys-0.22-rs.wrap} (13%)

-- 
2.55.0


