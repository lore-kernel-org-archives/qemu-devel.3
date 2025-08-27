Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsL-0006CH-R2; Wed, 27 Aug 2025 14:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKr1-00053A-0s
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqn-0005rp-Vc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqIeVURvVhFpKx9yALalCb1OCfJUyviImaNss7BoRAE=;
 b=HcFMG6ElGazhRdiAfJj8Rj44+XKvwFEjwPD65+6a6aFiow9EwxNvIEUq6RkGbaYwhrok0a
 4rJK8+0a9FiGYXPaPTe5cKP4/nUH32EtYCT+GLu+p/SCHgrFE4ORlYi4a3Y8gxd2SAWOOH
 n2nK5HhyvKjQH5ZBf+9COTudOd5xFco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-YW-EoqUjP_mZtx3FTvtALg-1; Wed, 27 Aug 2025 14:26:19 -0400
X-MC-Unique: YW-EoqUjP_mZtx3FTvtALg-1
X-Mimecast-MFC-AGG-ID: YW-EoqUjP_mZtx3FTvtALg_1756319178
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c6ae25997cso69804f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319177; x=1756923977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqIeVURvVhFpKx9yALalCb1OCfJUyviImaNss7BoRAE=;
 b=II+CSVfSNdR070xGjoNovuOT4HvH8Im+N4yJoY6/w0ExOhJWk2O2pnVboO0DIASZjg
 e0msoV1LZc2c5YSCSzPVG5a4eA5QsiYDCHx64y5epXBSFmOPahDYjYnwTXHxmQMMxK/m
 UZzeY+IeB3Q69l4wCbHvbjrrHwi/PphoqBeGX96fIpqVYcpJxBKriaBM3v9ddYol0uCD
 PsOaeb1WmvbuVn191watFiEsbboM85SdpUI9HY5BVDjHM27STZlvSg6UWOjPARPIw9Bm
 zPb9dCM/Y/WDcmSmnxRhldXVNEnSg8l1LJfeIv8I3+lxmsV6wSXkB5IwqeK2PVOPBh/Q
 I1vg==
X-Gm-Message-State: AOJu0Yxy/qj4LKTfd/5jWp7SWddk0Nlk0z3Ny58FuPImluKgilH2l39e
 I0bcXuYrJv2MhRTUT0WnOm6vXPTsmTwkrVFO6cYJlqtlo3AdZ4RLPRevljwQVy6xxH7DBP005Mz
 ngXRN+5mOjMj9dbrIJaWGolUIqmR/WfIHavJrDyVymkDPPSuKOq9wEA7YETulYFFWbNn20oCxOL
 Kn3GR4sF/vYgRImGobVVTXL1o1oiC5uO4IAesjqcGV
X-Gm-Gg: ASbGncuxEqDZfc0pJ307kWvA9yHPjCiT5gqbB6z7ZfTwPtkqjEmI8zLF9OULgFH1k2W
 f4XRwZLglI8o3CiqSWfC2MDMWEj23GH/TFtoTU8NQVaD48KAKNz2NmJxDGIJ+O71dkDoRxFBifg
 T78qKSlcQcZrxWWAtjQOh6mjvFCnGd4q/jtT5Qmhev5YgJdC6unvkz90IN4Ba6utXmRVjUgL+bb
 ZXTEwaFUVs62/QpAEP8Un1vi/xxPM6PPVm/hI5MsgC9534TkWkt8xVuvvNOHY1/KWeiSked/jfv
 47RXm0BbETfBJCWUVQJ91wO6Aapm+onQvMz7Vcoe5fEY8mBjiCvJ01o4fuOGHEgM5/XQ3VvrKl+
 +a1ev77hzMzMWqA3jXjEAuhdqOF4ORlpeZDCNJVBje4Y=
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id
 ffacd0b85a97d-3c5dcefd13fmr18140301f8f.54.1756319177276; 
 Wed, 27 Aug 2025 11:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcS3xcqJP5TgaPPjoj7fi2m+h8xAzP99U6+/XHtpv1URlC5oxxwNLVb8VHv6si18MzBJYTcA==
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id
 ffacd0b85a97d-3c5dcefd13fmr18140284f8f.54.1756319176753; 
 Wed, 27 Aug 2025 11:26:16 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211bd7sm22034086f8f.38.2025.08.27.11.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] subprojects: update proc-macro2 and syn
Date: Wed, 27 Aug 2025 20:25:29 +0200
Message-ID: <20250827182533.854476-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

syn 2.0.69 adds Punctuated::get().  The serde and attrs crate also need
a newer version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                                       | 8 ++++----
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build         | 2 +-
 subprojects/proc-macro2-1-rs.wrap                     | 8 ++++----
 subprojects/syn-2-rs.wrap                             | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b785c718f31..4baf6ba663c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -118,9 +118,9 @@ dependencies = [
 
 [[package]]
 name = "proc-macro2"
-version = "1.0.84"
+version = "1.0.95"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+checksum = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
 dependencies = [
  "unicode-ident",
 ]
@@ -155,9 +155,9 @@ dependencies = [
 
 [[package]]
 name = "syn"
-version = "2.0.66"
+version = "2.0.104"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+checksum = "17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40"
 dependencies = [
  "proc-macro2",
  "quote",
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 5759df3ecc9..ba7de070292 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,6 +1,6 @@
 project('proc-macro2-1-rs', 'rust',
   meson_version: '>=1.5.0',
-  version: '1.0.84',
+  version: '1.0.95',
   license: 'MIT OR Apache-2.0',
   default_options: [])
 
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a0094174084..3e6dc318a9c 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,6 +1,6 @@
 project('syn-2-rs', 'rust',
   meson_version: '>=1.5.0',
-  version: '2.0.66',
+  version: '2.0.104',
   license: 'MIT OR Apache-2.0',
   default_options: [])
 
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 6c9369f0df3..0f06cd8e111 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -1,8 +1,8 @@
 [wrap-file]
-directory = proc-macro2-1.0.84
-source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
-source_filename = proc-macro2-1.0.84.0.tar.gz
-source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
+directory = proc-macro2-1.0.95
+source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.95/download
+source_filename = proc-macro2-1.0.95.0.tar.gz
+source_hash = 02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778
 #method = cargo
 patch_directory = proc-macro2-1-rs
 
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index d79cf750fb4..1e5e9d9fb6e 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -1,8 +1,8 @@
 [wrap-file]
-directory = syn-2.0.66
-source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
-source_filename = syn-2.0.66.0.tar.gz
-source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+directory = syn-2.0.104
+source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
+source_filename = syn-2.0.104.0.tar.gz
+source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
 #method = cargo
 patch_directory = syn-2-rs
 
-- 
2.51.0


