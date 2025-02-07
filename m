Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F02C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPWX-0004ih-RI; Fri, 07 Feb 2025 09:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPWV-0004fg-QH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgPWU-0004ij-7E
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V4vYN424Zst0W94i5JbD8fyChMDv/Dgup2Y4cOwoh0g=;
 b=UuBTZ2tCzuKPF/4DhLQyHzGWoB26uvcc3seTmN/+420KY1YGgq90bTJQ9RsaZXPx+Y0FBd
 CT9prboE03VjWFjTg52ccL6W5lWBOuVppT4T/A7oaPPt/q90i/sdhMT1i7cCxBKEL/X6lk
 inyI5OJcmYOXFhvVGgzsRi6vzD+h10M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-v5KpEZ_jMHKZLKmD_XlubQ-1; Fri, 07 Feb 2025 09:39:58 -0500
X-MC-Unique: v5KpEZ_jMHKZLKmD_XlubQ-1
X-Mimecast-MFC-AGG-ID: v5KpEZ_jMHKZLKmD_XlubQ
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dcd3120b24so2478264a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 06:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939196; x=1739543996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V4vYN424Zst0W94i5JbD8fyChMDv/Dgup2Y4cOwoh0g=;
 b=Dh8B8zO303DKs8WqMg6x8BASldV3Dj0d+SgIbunf50V46BZD2vhzCicAyKfwvtWXvt
 2Z3WTAUWu7ZdIq4/A98o9vskND+opo51spU3NjesjuwWJpJKt8UDfuj6hhAm7a0ZnFyK
 hJeaJb55/NuX/M8pHX85WNyc8PaE42qW6HcjmsWfCyW6qyX9sU5400/oX5d9NX0tUc9N
 ehvBh3wkwLk44N3HWRSJNqvDCF1rQrUqtm/9s65gHppHjANJ2lifuVXeA5oF6TtefpCb
 dmLhpxYgrPBXz/fi5joylxzCaO2vvB0j7jngQmNE9Rx6NWLi6vcIU0p5DEoB9HHqD79o
 khHg==
X-Gm-Message-State: AOJu0YxDuhySjNTUOxEcpAs1beJ0iQLVZfOp/vvxWvYM0XRogLYEcNFK
 0bWvrDO6alWC5PGY6NlXEy6LBDACFrSvrtV+/FXvUbk5zKKIAvqzySvlZ2oLX3kK7ExB8dzpu7k
 RjLJdx2uar6Z4Jr44zrB3R9UskT16NKAT85rVVWTouyyNOFz81ur4rEvtjhgQ+Ch8lQMD9GEFZ2
 j4OVEH0w3bsGjTWsORmmL8dOPd6/3MOff2qJY5IoM=
X-Gm-Gg: ASbGncsBAzANtfI46qmRlhLhzroJadSfOWctFhDijr6t64I4etiWS0y35dFHrvPyH50
 SE2mWzAeTd8gwndRIV5u1rNPFAtu176cMKk8WDnCb/yHwNXw9cjIJBJAbEjC4EEMU9Mki2OIcbP
 iofOJS+f+pwR4OsREyE/2a4pwboQsp27sLruqLyoFOZRlwY/AcYJJGbESQfG+QT7pQhd4yyQEUw
 cmpg3qABk05ZPP5pdNZaVDl05p09UeIBgeAY78QqeD+/S5/tYvCUXBOb/DAsw7HsHA61JHav1S/
 0/ABDw==
X-Received: by 2002:a05:6402:e8a:b0:5dc:a44f:6ec4 with SMTP id
 4fb4d7f45d1cf-5de45018934mr4660815a12.13.1738939196228; 
 Fri, 07 Feb 2025 06:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt8z6hhClcKw+IkdWrfCzLuzskC5ay1gUIrxBvWYM48W9IW9cCggo44xDh4DzYCVksEsc9MA==
X-Received: by 2002:a05:6402:e8a:b0:5dc:a44f:6ec4 with SMTP id
 4fb4d7f45d1cf-5de45018934mr4660768a12.13.1738939195756; 
 Fri, 07 Feb 2025 06:39:55 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7ae65sm2549015a12.17.2025.02.07.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 06:39:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH] rust: restrict missing_const_for_fn to qemu_api crate
Date: Fri,  7 Feb 2025 15:39:52 +0100
Message-ID: <20250207143952.2486587-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

missing_const_for_fn is not necessarily useful or good.  For example in
a private API you can always add const later, and in a public API
it can be unnecessarily restrictive to annotate everything with const
(blocking further improvements to the API).

Nevertheless, QEMU turns it on because qemu_api uses const quite
aggressively and therefore it can be handy to have as much as possible
annotated with const.  Outside qemu_api though, not so much: devices
are self contained consumers and if there is nothing that could use
their functions in const contexts that were not anticipated.

Since missing_const_for_fn can be a bit noisy and trigger on trivial
functions that no one would ever call in const context, do not
turn it on everywhere and only keep it in qemu_api as a special case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml          | 1 -
 rust/qemu-api/src/lib.rs | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5b6b6ca4382..5b0cb559286 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -52,7 +52,6 @@ empty_structs_with_brackets = "deny"
 ignored_unit_patterns = "deny"
 implicit_clone = "deny"
 macro_use_imports = "deny"
-missing_const_for_fn = "deny"
 missing_safety_doc = "deny"
 multiple_crate_versions = "deny"
 mut_mut = "deny"
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index bfb6c6d6e42..20134d75ce5 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -4,6 +4,8 @@
 
 #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
 
+#![deny(clippy::missing_const_for_fn)]
+
 #[rustfmt::skip]
 pub mod bindings;
 
-- 
2.48.1


