Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9FCD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwW-0003mg-BU; Fri, 08 Nov 2024 12:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwT-0003iw-TW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwR-0007Zz-T2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FEw/rc7U9Vlye58DTGc4xMtHppOyq8SKZzrgZebteU=;
 b=evLeXj/XzCFjI1m1z1bOTUwMeJ8kajOlMZSW9qxETf5PI0Hm7jqJFq9NZcCJOjm2xMtJF7
 7Q/W8y63CiY8Oo0wNL6ZaWwr7agPolvVI7BE8mclSQ9ZLW4DN/eoscS38cJNsKJbMvQ7jR
 ztjmiZ+h7Kq822B7oBMAaYe0kxg19ZY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-FO0D2lANM-e391cq94mnHQ-1; Fri, 08 Nov 2024 12:38:37 -0500
X-MC-Unique: FO0D2lANM-e391cq94mnHQ-1
X-Mimecast-MFC-AGG-ID: FO0D2lANM-e391cq94mnHQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so1287375f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087516; x=1731692316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FEw/rc7U9Vlye58DTGc4xMtHppOyq8SKZzrgZebteU=;
 b=E3SDC3tZw/vnJlkXjDqlbUfeYK6/4gxh0cx/4wukJ1In/AQVONpbiQfcXm3X2A9wWN
 MUXmXlH0pcPN1Kd3RVbfAh1Fb5g3kiyF7ZEx83Tz5Yl634gPS/y521+SB0Jts/tLb8hd
 81z67YdO0OliBbhEebd9a+rTXdg0ZiIa/KZsN5IEspmW1lJu7SB9+nU3adG+5eZj1t1T
 rf2kexAu9jnspSvAHYd9nmxr2V4IcIm/yxwV8KDbDYaeGGoE7mWy4+1hpMcD2KFXfy8d
 zu5tiN2QtrjxUN+MrB/qTA2iSFrrkQYXjlXHnNm9FkzPIO08xYQO+d++HinaaJXklsFg
 q+0g==
X-Gm-Message-State: AOJu0YxvvuoAirs74DhwzwRWmyXJdZk/fW+3DPh6NN3XBAMmUYWi/hp0
 9QJwUgqsLMQyVdLu+nmdLmld8kfpY0zcRGtAPA/8oVH7lVdnxQEVBkb3m1eg4mlzqaBZJhU4mvf
 DlRxpaQfT3LRpgQwrD2FOVeKyWR8WHbtms9r8M7VYH/Aw+N3YAbQYg3RPzoxXIvPAvJge9WS20H
 LF38y92SPyZGoW52Qe3M2EtbmulEMTcLIRbR/yPgY=
X-Received: by 2002:a05:6000:1a8b:b0:37d:4e74:68a with SMTP id
 ffacd0b85a97d-381f18855e1mr3189006f8f.46.1731087515996; 
 Fri, 08 Nov 2024 09:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHn7IyWRWnMQlLY99BNeQuztgkFLKcxLcZI0WDNpyd5t+AsWeDf2/Hl0RKv6dN97I6RYuVIw==
X-Received: by 2002:a05:6000:1a8b:b0:37d:4e74:68a with SMTP id
 ffacd0b85a97d-381f18855e1mr3188981f8f.46.1731087515553; 
 Fri, 08 Nov 2024 09:38:35 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97ce0fsm5535552f8f.33.2024.11.08.09.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/13] rust: add meson_version to all subprojects
Date: Fri,  8 Nov 2024 18:38:18 +0100
Message-ID: <20241108173828.111454-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Otherwise, newer releases of meson complain.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build         | 1 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build               | 1 +
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build          | 1 +
 subprojects/packagefiles/either-1-rs/meson.build                | 1 +
 subprojects/packagefiles/itertools-0.11-rs/meson.build          | 1 +
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build      | 1 +
 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build | 1 +
 subprojects/packagefiles/proc-macro2-1-rs/meson.build           | 1 +
 subprojects/packagefiles/quote-1-rs/meson.build                 | 1 +
 subprojects/packagefiles/syn-2-rs/meson.build                   | 1 +
 subprojects/packagefiles/unicode-ident-1-rs/meson.build         | 1 +
 11 files changed, 11 insertions(+)

diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 34a189cbaec..cff3f62ce74 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('arbitrary-int-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.2.7',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index a6ed4a8f0cd..e69bac91b40 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -1,6 +1,7 @@
 project(
   'bilge-0.2-rs',
   'rust',
+  meson_version: '>=1.5.0',
   version : '0.2.0',
   license : 'MIT or Apache-2.0',
 )
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 80243c7024d..f8f3486fc08 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -1,4 +1,5 @@
 project('bilge-impl-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index a5842eb3a6a..608e64e31fc 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('either-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 13d2d27019d..30982a4ee76 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -1,4 +1,5 @@
 project('itertools-0.11-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '0.11.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 38ea7b89d39..ae27a696862 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro-error-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.4',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index d900c54cfd1..3281b264333 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro-error-attr-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 8e601b50ccc..f9c8675ebad 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro2-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.84',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index d36609bd3c8..7f7792569b9 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('quote-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index 9f56ce1c24d..2c62cf7e1b0 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,4 +1,5 @@
 project('syn-2-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '2.0.66',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 54f23768545..9d76ebbd1ad 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('unicode-ident-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.12',
   license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
   default_options: [])
-- 
2.47.0


