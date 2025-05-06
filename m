Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8D3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEq-0003ff-1U; Tue, 06 May 2025 11:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEm-0003do-Qu
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEj-0001w3-CS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwM1oEWk43LlqaBHqYihw1Opp9RLy2sGRAgJQW59A1I=;
 b=NovVNxL5Nb3IW0iwM2rN+tAAHt8/7mDArP6NzAqHzw2WZd2FCTBcslOMjwKaiI3yHvX8bS
 8XVm+U9zS7wndzyKmY4Aie10onQhS7qbzvp59dsluXsmmJaEkYi/jcOqOqwB5sFOWyJwaz
 QN3nwavwPsufwIgpS+SmbO99pebHNlQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574--I354rG-P-e_NJiI-0a_Gw-1; Tue, 06 May 2025 11:29:34 -0400
X-MC-Unique: -I354rG-P-e_NJiI-0a_Gw-1
X-Mimecast-MFC-AGG-ID: -I354rG-P-e_NJiI-0a_Gw_1746545373
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d917b105bso2931682f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545373; x=1747150173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwM1oEWk43LlqaBHqYihw1Opp9RLy2sGRAgJQW59A1I=;
 b=IKJAege8PbehxxbRa9wyxVvjeQgfHJZF88XhBVbvHHmh+1I22GxhmGR8FF1Bwd6j4c
 uz4O1VZ1BeP1LQrSTYunkyMHUk2V1Z6EjjIhPMPtDGwkjK3fXXfOCkxJitjjOSfH64Jr
 QxaQdYVagScbTSjNg5x/3biv8nngGarYAu/7omueDGb+qpQ4bY6Srv18NVel3Bb6luoJ
 e71xE5XmI270C0yiWdStgyb34h4aNLkkWYkzJk12ZsWqeXHAgYgVvKLN5JUdYXzJgQiT
 4UtN3F6SpuqSqJ3paAW3zqqVsAhLWv6Qx60foZz2fEbctOPXf7TMVvryDQt1lTFof5eV
 9+xQ==
X-Gm-Message-State: AOJu0Yy7T0jfyxzRu1wKinItdHF4dI9+eNjVbDQDSegm72f5zOqu/00i
 D0e/Gee7RCn5SqGt3TKyN/wSyBIwpGDf8dhVEqThwjrHaVa+LPmI5RaR69w4CRDjhyI+Wvo2HDR
 Jw7gIAiytTwSYJTe9hpWHXLAmKA/c2LTZYjen33xEi/wgmQzNWZFTnr42hKLd47NRe3e5UX6S+M
 yJdM25ykNH7iXH3Y1YXEq0jAqsfGOVaNEHwfjl
X-Gm-Gg: ASbGncvm0JPy+v09kzFfu9xycAnV0pSXHD64ilPZ3QEJg9nNHgmNoFkzfXG5/S5lsP/
 igdrCbvbY0q4HSMgM1yCax1LhY4nND8n4ArnxUmEwlKIIwHHbis81AArMNgEcGVu9ONZ+QF6FyF
 OuOW2r8dJngNm8ATuTBix1Rum73dCG6tO6xP8TXYbn1FehCjSRsQoALAJ/ihjOWFnTRqSvjylpg
 PJba0H+rP9oHq9/O5jWEISYsw+cZMqjFxyBsAkHsnV6JaOG9kUJcCna2diQQr7ks2s+8CV/UiYV
 jVVITK6UGVfn5II=
X-Received: by 2002:a05:6000:1a8d:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-3a0ac3eb321mr3231020f8f.55.1746545372777; 
 Tue, 06 May 2025 08:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiq7z7G0rDo/ouIyXRNGWACgrZQX9vZ4mYveYh2wgF+Gi5qKnlc0D+y6j2B/gw/w/hion7wA==
X-Received: by 2002:a05:6000:1a8d:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-3a0ac3eb321mr3230999f8f.55.1746545372315; 
 Tue, 06 May 2025 08:29:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7cc6sm14330532f8f.55.2025.05.06.08.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/30] meson, cargo: require Rust 1.77.0
Date: Tue,  6 May 2025 17:28:57 +0200
Message-ID: <20250506152927.222671-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build      | 6 +++---
 rust/Cargo.toml  | 2 +-
 rust/clippy.toml | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 6c61e1dcaec..8eb3de5d68d 100644
--- a/meson.build
+++ b/meson.build
@@ -94,12 +94,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.63.0')
+  if rustc.version().version_compare('<1.77.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.63.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.77.0')
     else
       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
-      message('Please upgrade to at least 1.63.0 to use Rust.')
+      message('Please upgrade to at least 1.77.0 to use Rust.')
       have_rust = false
     endif
   endif
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5ace47c69be..eda7980b31a 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -12,7 +12,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
diff --git a/rust/clippy.toml b/rust/clippy.toml
index 5d190f91dec..933e46a2ffb 100644
--- a/rust/clippy.toml
+++ b/rust/clippy.toml
@@ -1,2 +1,2 @@
 doc-valid-idents = ["PrimeCell", ".."]
-msrv = "1.63.0"
+msrv = "1.77.0"
-- 
2.49.0


