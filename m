Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609F1C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 10:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u10Pv-00078W-5w; Sat, 05 Apr 2025 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pr-00077H-9l
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pp-0005sJ-HV
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743847576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHssbMwpp04AcS81wEaBlM+7BT95pXZcAectm5uN2H0=;
 b=QUCajXy6o0xNs+/gkpdJGbwnVe2jWeopXn7uRcY8NwVkePere0Br/+PwXFEsajtnuhqF4i
 yjBBO40H2r9bzVzhmD3GWC4DrMNojOOoXJ82qhAqPRgp7ezm4JvFzdleFS0u3ohi6YQD0e
 8yC97ZDPstbHZWXdwlMBs9kDsEaFIqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aU8-pweFO36z5sozbvWJqQ-1; Sat, 05 Apr 2025 06:06:13 -0400
X-MC-Unique: aU8-pweFO36z5sozbvWJqQ-1
X-Mimecast-MFC-AGG-ID: aU8-pweFO36z5sozbvWJqQ_1743847572
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso17305055e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 03:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743847571; x=1744452371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHssbMwpp04AcS81wEaBlM+7BT95pXZcAectm5uN2H0=;
 b=RBhXXK9aeW4jBvHAtIyE+kZ0YTQNvYwiOSmYl44HrKikCfH/+sz8cQbfSA+yCn0n8D
 LKv8g5cgQ27ZptXpkMmk+FomfXufr5EC99oNrMin8/V3+01jGUF5OtwPLyHW5zXZAllr
 tS7nUAoX/AB085OGgn+yovuaeh4idF+OCqR1uldSuwqXIk+okQTgQs2rlBqVEvJkoHxR
 xpidwjzAVDAEk8WbNDRIu9804P8YfOyQigv3rZF8kAVv1Ry0HcYzgUT41wBJfdDyzsDg
 7+i2ti19pQYf0NF9qkbuQSpzauRFoPXu8nGHvlxSCx9R8mIO8WaNxcuKHqeAfrmy58Zr
 sPPw==
X-Gm-Message-State: AOJu0Yy4htSBCnpjJlTabxjrNN4B+HOH05lOsZN5rwWv84tf9fd6EXws
 FeZddO/YK5gIar0ETUpWxe+wtzyZMeCxl1mRlnSUtfFCuIXss7LPT7I/yBB/+O3CnAhAa6izyyv
 CxpTiOZruUkiZOXub9copOSsU59MNlW2VSwjSrufxw0AvDz34dgBtLidvm/y8Ui8NnZnXjxrtVD
 OOMfFJkW29UUub3iZp2ePwS+qDFMeQODWnOvBR
X-Gm-Gg: ASbGncuBXCjOCKhiqdae32LtIh45akEcWdmem/Hz1lrJ3MaR5cSIenki+NRyno2xwfh
 K6pOE/BXRz5ZzPK9luC4khLDeH3/7Xxhny1mZBZCXd6eI4N/ppcss3EXWqpnHZcm3VNy97SlWsw
 IonwPVnoZpc1mSYpzQZXCWlABVodUelJmmoq4KKZlG+F6MfHGcdU5U4j/j6VkSIuCBGUzD2fSQ3
 7a02kFi3oVUDfAi3u8PLV1C5xiwY4iroMzOdghusuKbm9lF3FHZy15y81bmvi5SIpeZinX70SAm
 8SxKhjFpH0w7VDeIFQ==
X-Received: by 2002:a05:600c:1c92:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43ecfa05104mr46700045e9.29.1743847571118; 
 Sat, 05 Apr 2025 03:06:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxf0T+zpLzJT8Lr0bxjY4zTHmYO+ogOfR9E8xOSSG+22v7Jm8V9b72TYJiVtRUcrLydxtU9Q==
X-Received: by 2002:a05:600c:1c92:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43ecfa05104mr46699865e9.29.1743847570744; 
 Sat, 05 Apr 2025 03:06:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0dbesm71991405e9.33.2025.04.05.03.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 03:06:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/3] rust: add qemu-api doctests to "meson test"
Date: Sat,  5 Apr 2025 12:06:02 +0200
Message-ID: <20250405100603.253421-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Doctest are weird.  They are essentially integration tests, but they're
"ran" by executing rustdoc --test, which takes a compiler-ish
command line.  This is supported by Meson 1.8.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml |  5 -----
 rust/qemu-api/meson.build | 11 +++++++++++
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 00f4bfcd9f3..088d5683c88 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -131,12 +131,7 @@ build-system-fedora-rust-nightly:
     IMAGE: fedora-rust-nightly
     CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
     TARGETS: aarch64-softmmu
-    MAKE_CHECK_ARGS: check-build
-  after_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start test "Running Rust doctests"
-    - cd build
-    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} test --doc -p qemu_api
+    MAKE_CHECK_ARGS: check-build check-doc
 
   allow_failure: true
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 8fa41c0a95e..ede6e14e5e0 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -53,6 +53,17 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
 qemu_api = declare_dependency(link_with: [_qemu_api_rs],
   dependencies: [qemuutil_rs, qemu_api_macros, qom, hwcore, chardev, migration])
 
+# Doctests are essentially integration tests, so they need the same "depends" as
+# below and cannot be run with "cargo test --doc".  Developer tools are only
+# supported for versions 1.74.0 or newer of Rust.
+if rustc.version().version_compare('>=1.74.0')
+  rust.doctest('rust-qemu-api-doctests',
+       _qemu_api_rs,
+       protocol: 'rust',
+       dependencies: qemu_api,
+       suite: ['doc', 'rust'])
+endif
+
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-- 
2.49.0


