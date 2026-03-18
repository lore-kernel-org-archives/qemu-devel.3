Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B39DFCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mKq-0000t2-7x; Wed, 18 Mar 2026 04:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKj-0000rJ-Vu
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKh-0001nb-Lm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yXg02PKbcxyx2q4NMqNiblXBEJD/8+Y+6AIqb2Hxys=;
 b=NpKMimhF4HTn4XYKcOZ86P2cuzlStX4Y+Dvb5zfdgN2OFc2gJvlo3fhTszM3ArJ3XRTT+q
 K4uVAylU1LrPndlyRzK7m6+aXRmUWlpLDFEHp9qV2vt9wUA4vSq1EzzPiUnwo78Ezxyyad
 Jz7R0sWJGZ3pwP2yNKQQo7w9OUfl88A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pXjWDySCPkG3WbSMfJbjig-1; Wed, 18 Mar 2026 04:32:48 -0400
X-MC-Unique: pXjWDySCPkG3WbSMfJbjig-1
X-Mimecast-MFC-AGG-ID: pXjWDySCPkG3WbSMfJbjig_1773822767
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so6610780f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822766; x=1774427566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yXg02PKbcxyx2q4NMqNiblXBEJD/8+Y+6AIqb2Hxys=;
 b=mWx1+gYirY6f+yTXs0+hdlr/kEVPM3ygw80NZ6tc1Jz6IH16PKsyIUz9agnGoFVNkf
 o+r1rhYSenm/4HMmU3cOPhzvHjEgMOCQJNCGuLNYX//9FrUts44oKxU/SOUH7bdqHNa2
 0b3Y7r9+jZtP1dDcg0Yxgb7uaUFqXjelICLTwCmN2+FJDR7duh9TNlYX3F+vrPumr/WG
 AWn6gJWsi8LcilYx9rosLxQa9MS1utowH2d393PHl8rIp5FYmQdgaVOXpnac/eNvax5w
 gYD46pImbEBrGuwXJXTGeRSK64uOWgcY5TlhELJphyu8jIyPpnscHeefmkLP2g7iGC5m
 337g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822766; x=1774427566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+yXg02PKbcxyx2q4NMqNiblXBEJD/8+Y+6AIqb2Hxys=;
 b=Cs/wBTByLuff+ZS+b/YcKDOk6v58g1dNqUvxhEhffysOua85gxz0fXWfqYH1hsGfMl
 EVUMO/5UgPB6RA3iPMBbuFInBIrVUU5Np/j9EVUoUWdY+Z9rRGgUWYcYF74rvudUmAC4
 rRdhFn3xcsmovbzGnEbv0jZIkisiuWeyru7mxm+tZBR9rQR5rbMHEw65GN8FuwQuAo0J
 XH9vFeTJuN8xPBS5m3M9ch7lIVSkBmkmUd5wxEs4bWDydcDxg8JGa7W6NhlRSsm8EIML
 QvRJHNAhjrururSxuY0WNrXYcW/023gsTxJfSrp8mvAzXxmlseQ6dyy4tPPN5bFLv136
 Nu0g==
X-Gm-Message-State: AOJu0YzWVnteRKVHApHDIee95hKrKezPPLWVj212CSmqS87UhMieCxsJ
 BVusE+m1M3LvSgrmJTmW+eJSqcMVYe1A19q19wcKcWpPjKJW8g+EJn14iYe8+JTPZD+dvaJEORv
 OOGVj4o5ehL9E8Fk9HCLXkdvsVmgvwqt7pQsDVT8AerYiKIRw5BKsQy+ylbTccg15M43lql/Pra
 Ixe91Kybvc5UfgyLGOqFgbf8IZH5y8CxKbDoMYRhvx
X-Gm-Gg: ATEYQzxtEXGr5H78akhmzTUVg0nkAhIz5Tei+OJMtNrrcKsxPNJIIPkCTXiZ5etol6d
 0CRvl0Ib9trwoxixhPfZRJ91og4W+mpW2jo7XTV3tUY7DW+nIis1B1mnsw2AGLNNY4LRPK49pHu
 phGY/fBt4ssCoDW08EkXV2CruVyG/yf4Xj4PcJpmSx+moIiFGZw/FxMP2cA741yvEJs4WIs8Hxe
 if6cmhfru0obefV1KUwOnhKsS6NH3YYP1vlQDxFsHhuCKwrxpskoFt3BHXgtOboSc4hWIjAQ9uW
 2DgP8zbNiHgB6jmS3/y9GtpDB9dM/nkTNWj3cLIhxuL0SBwhcyHVPjFmeZXcwvxZ3qIggGXMhx9
 N1IDu7S/qzO4Ro/ctU079tal9r94Kmw5kCuJQ+D6VnJOlK2eqiRY+RLPgHNk21EBfIOXwGJc/Sv
 oiBBykYGbsO3ap2qkDyZOVfJMg4jY=
X-Received: by 2002:a5d:5f43:0:b0:439:b7c9:2ef1 with SMTP id
 ffacd0b85a97d-43b527a979bmr3841777f8f.20.1773822766217; 
 Wed, 18 Mar 2026 01:32:46 -0700 (PDT)
X-Received: by 2002:a5d:5f43:0:b0:439:b7c9:2ef1 with SMTP id
 ffacd0b85a97d-43b527a979bmr3841722f8f.20.1773822765676; 
 Wed, 18 Mar 2026 01:32:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51899622sm6628426f8f.28.2026.03.18.01.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:32:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/4] rust: fix build when --disable-rust and meson < 1.9
Date: Wed, 18 Mar 2026 09:32:37 +0100
Message-ID: <20260318083238.1132609-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318083238.1132609-1-pbonzini@redhat.com>
References: <20260318083238.1132609-1-pbonzini@redhat.com>
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
index de00fddb2db..d016482db1b 100644
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
+                          (meson.version().version_compare('>= 1.9') ? ['rust_std=2021', 'build.rust_std=2021'] : []),
+
         version: files('VERSION'))
 
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
-- 
2.53.0


