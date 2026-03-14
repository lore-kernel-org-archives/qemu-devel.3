Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53585107BCFE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Jq5-0007rm-Fa; Sat, 14 Mar 2026 03:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w1Jq3-0007rP-N9
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 03:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w1Jq0-00070Y-D6
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 03:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773474906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqTVzb498TkVnC9aLaQQjICK5+qBmbLPUoLpPxKrTlA=;
 b=eYSvixzJjy+awr9bWMsq7IL6D9RWD0JmcoA2KMNNxuKrXjNiiodNF3tH/NztDxJp2c6bbi
 BNG/Pl83Xr1Re/laZ6rDbYGwX4Re9Txm1TZDvFq/G7/zMpkFZljLMP8ydzfxKWe8tZPkPl
 oANsQ44ewDpQkJPMQpk2W60tlqY2jss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-eURO-aI6O02a9YCiMTMiUQ-1; Sat, 14 Mar 2026 03:55:04 -0400
X-MC-Unique: eURO-aI6O02a9YCiMTMiUQ-1
X-Mimecast-MFC-AGG-ID: eURO-aI6O02a9YCiMTMiUQ_1773474903
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c112b1a4so1971435f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773474902; x=1774079702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TqTVzb498TkVnC9aLaQQjICK5+qBmbLPUoLpPxKrTlA=;
 b=VPme5Op4aCX0tG/1HvmJj8mWdtsHoKLMGT5QJKctiialDh4+IuX0T7BU1RuFTnoB68
 tGlXBwGoNqfaqbWtRjNGvcRmitS2N5lFFHe+YsWYT5WuXBsOewNoEHYLQu5Xmz5TT2vu
 N9qHuzNEx+m26EHpko1qpgkSSH6DyyHjMQK85T87jupOREb+ptCdu6dff6l6fPv7aZnO
 G1nGEKtf0QrvZdxF4Gwd3X9UMn7+4G96a4ad10Oal5/xu6chzOGkVtpoUVK02JWZ9z7R
 5vYH+iLwuFrPs4uf6yY2GPsrH2ne6OZNWLIyvsdaTvGjJ/qv2arZHMzeSXdofzMuhz6e
 8xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773474902; x=1774079702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqTVzb498TkVnC9aLaQQjICK5+qBmbLPUoLpPxKrTlA=;
 b=hDTVBQtFzYozqv5Ng3WF8n/fV63iX6MVfFRUNi59tIg+pUt/Au7Ae4oGo8w6xqx2OX
 xkABfmV5Lf7DfLRlc1jo5wkzYYddMdzmEGkM9v3Qrizk73fL+tCt4CUJfUiN8ugJot3h
 gDamRYTZl9QeE2cGesBkO6zN/S6Lc1ORvVKg0Kn635AokdNTj6QI2p5JzRzWlBFG4AU6
 WgYtjY1nULVW7u3HLKw36wfVD7bCwCsSFwSwCfbqz356qyqBZVemkpT9mEvHbfuHBdKM
 /vm2ZmHqDTG5c+lz4na34DsnplhvwdjNUpWK0/A/nvJBipQNwLoGckwO1doa1koNYgYr
 nNDQ==
X-Gm-Message-State: AOJu0YwWd80d7yJsYYvtWE83Pm8zrpbphbDD8WjVDP5PIb+b2CfIw3Fp
 /hzb1agr2HGGGldoEaHcyuLMOPG9deP0tqwv/F5BHfKNk9z6esLRD+nSFrAXDorZY4+iLVdRfoc
 kLhCK3o9JfPBCUE9bxebqIAAuK/sK/usFtyix0M0ZcB5z9OOqUH7DuYTxvFFQPULKVFrWvYP4XE
 v0a8RkmLtIaRWsw+d9CbnY7D0Wayt/v04wVhX3IOdr
X-Gm-Gg: ATEYQzzhb4/qr5cJ4MdrPPYVUIfVhnBCs1bqtKeibWIjuINZRz0eO2VOHHEP5udZ8vR
 ZtEgLtYdrVjeIDhsECT4FiJBP7mLFM06zu9u7+l8I7rg6jYtpSltbW8RTlV8slHb/yc0nnPLdG+
 bTOXWtlQjfJqbWzvXhjluL1t4wDCXnniW1DIjSKEZPoAdDWkFDfAtXaq2Mf4IsU2cc1KRybl044
 82UJkl5XVMg0sZ7G9h2kNrWE3xnV680iVkqQ0Q9otOJpO3AQPd6vqtVSjrd1vviKAcWKC3QJ9Ls
 UAuyrRbV1IshLzFIjajBNJ5kE8/AFvswFMvYvH/Xamk3pfarDur59ZpavB1XSIUUMSP0qunj4F+
 EeEWI7dzkcuCG8PccV/Vh+d3JUoJL9Ief0DsQeuNjQ2BpaYhZxIExAf2kEySb6nvkCeS1C9jpYS
 549zWY0G6Nu/swP5XBlFPFlxB5lGs=
X-Received: by 2002:a05:600c:4f54:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-485567052b8mr96359345e9.26.1773474901958; 
 Sat, 14 Mar 2026 00:55:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-485567052b8mr96358965e9.26.1773474901403; 
 Sat, 14 Mar 2026 00:55:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19abbasm22765168f8f.6.2026.03.14.00.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 00:55:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2] rust: fix build when --disable-rust and meson < 1.9
Date: Sat, 14 Mar 2026 08:55:00 +0100
Message-ID: <20260314075500.215628-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit e65030ed50ee moved rust_std and build.rust_std from per-target
override_options into the project's default_options, in order to avoid
repetition.  However, default_options are validated unconditionally at
project initialization, even when Rust is disabled.  This breaks builds
with meson < 1.9.0 which does not know about "build.rust_std":

  meson.build:1:0: ERROR: Unknown option: "build.rust_std".

Make the options conditional on the meson version, since Rust only
supports new versions of Meson anyway.

Fixes: e65030ed50ee ("rust: remove unnecessary repetitive options")
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 11139f540b0..00f482d3fa6 100644
--- a/meson.build
+++ b/meson.build
@@ -1,7 +1,11 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
-                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
-                          'rust_std=2021', 'build.rust_std=2021'],
+                          'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
+
+                          # build.rust_std breaks with older meson, but Rust does not
+                          # support old meson anyway
+                          (meson.version().version_compare('>= 1.9') ? ['rust_std=2021', 'build.rust_std=2021'] : ''),
+
         version: files('VERSION'))
 
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
-- 
2.53.0


