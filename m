Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41714CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cRF-0008Ej-F2; Tue, 30 Sep 2025 11:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRD-0008Cw-Hx
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cR7-0004Hb-Tt
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7SIBgllnz6KmtZoaB98vFEfu3NyG7UL6U+A2rY+G0U=;
 b=YrjWKbSmSmTrGGiT7aSb2ZOX9aAGUfn2ru7znpxt0kAljOugHY1UAxsFnHc2/2mZ+pQCgo
 deg4VldIycf15uU9pFfg2ePOS8MPh7mqBEN5OeYHRsyGRm+4KDrwNjzMgoyKFqoTtA6wcZ
 Ea8SLXjFS+vTjrdkgJvEapYItFeMoaU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-JKJTufL9MreRhr7YD0yTig-1; Tue,
 30 Sep 2025 11:38:35 -0400
X-MC-Unique: JKJTufL9MreRhr7YD0yTig-1
X-Mimecast-MFC-AGG-ID: JKJTufL9MreRhr7YD0yTig_1759246714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B5AA1977309; Tue, 30 Sep 2025 15:38:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A91F01800452; Tue, 30 Sep 2025 15:38:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/23] configure: set the bindgen cross target
Date: Tue, 30 Sep 2025 19:37:28 +0400
Message-ID: <20250930153746.573875-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Implement a bash version of rust-bindgen rust_to_clang_target() to
convert from rust target to clang target.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20250924120426.2158655-8-marcandre.lureau@redhat.com>
---
 configure                            |  7 ++++
 scripts/rust-to-clang-target-test.sh | 43 ++++++++++++++++++++
 scripts/rust-to-clang-target.sh      | 60 ++++++++++++++++++++++++++++
 tests/lcitool/libvirt-ci             |  2 +-
 4 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100755 scripts/rust-to-clang-target-test.sh
 create mode 100644 scripts/rust-to-clang-target.sh

diff --git a/configure b/configure
index 66613f3f4c..bf964947b8 100755
--- a/configure
+++ b/configure
@@ -1878,6 +1878,13 @@ if test "$skip_meson" = no; then
       eval "c=\$devices_${a}"
       echo "${a}-softmmu = '$c'" >> $cross
   done
+  if test "$rust" != disabled; then
+      if test "$cross_compile" = "yes"; then
+          . "$source_path/scripts/rust-to-clang-target.sh"
+          clang_target=$(rust_to_clang_target "$rust_target_triple")
+          echo "bindgen_clang_arguments = [$(meson_quote --target="$clang_target")]" >> $cross
+      fi
+  fi
 
   echo "[built-in options]" >> $cross
   echo "c_args = [$(meson_quote $CFLAGS $EXTRA_CFLAGS)]" >> $cross
diff --git a/scripts/rust-to-clang-target-test.sh b/scripts/rust-to-clang-target-test.sh
new file mode 100755
index 0000000000..ff6f8fcdc5
--- /dev/null
+++ b/scripts/rust-to-clang-target-test.sh
@@ -0,0 +1,43 @@
+#!/usr/bin/env sh
+#
+# Copyright (C) 2025 Red Hat, Inc.
+#
+# Based on rust_to_clang_target() tests from rust-bindgen.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+scripts_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+. "$scripts_dir/rust-to-clang-target.sh"
+
+test_case() {
+    input="$1"
+    expected="$2"
+    result=$(rust_to_clang_target "$input")
+
+    if [ "$result" = "$expected" ]; then
+        echo " OK: '$input' -> '$result'"
+    else
+        echo " FAILED: '$input'"
+        echo "  Expected: '$expected'"
+        echo "  Got:      '$result'"
+        exit 1
+    fi
+}
+
+echo "Running tests..."
+
+test_case "aarch64-apple-ios" "arm64-apple-ios"
+test_case "riscv64gc-unknown-linux-gnu" "riscv64-unknown-linux-gnu"
+test_case "riscv64imac-unknown-none-elf" "riscv64-unknown-none-elf"
+test_case "riscv32imc-unknown-none-elf" "riscv32-unknown-none-elf"
+test_case "riscv32imac-unknown-none-elf" "riscv32-unknown-none-elf"
+test_case "riscv32imafc-unknown-none-elf" "riscv32-unknown-none-elf"
+test_case "riscv32i-unknown-none-elf" "riscv32-unknown-none-elf"
+test_case "riscv32imc-esp-espidf" "riscv32-esp-elf"
+test_case "xtensa-esp32-espidf" "xtensa-esp32-elf"
+test_case "aarch64-apple-ios-sim" "arm64-apple-ios-simulator"
+test_case "aarch64-apple-tvos-sim" "arm64-apple-tvos-simulator"
+test_case "aarch64-apple-watchos-sim" "arm64-apple-watchos-simulator"
+
+echo ""
+echo "All tests passed!"
diff --git a/scripts/rust-to-clang-target.sh b/scripts/rust-to-clang-target.sh
new file mode 100644
index 0000000000..72db7e1300
--- /dev/null
+++ b/scripts/rust-to-clang-target.sh
@@ -0,0 +1,60 @@
+# Copyright (C) 2025 Red Hat, Inc.
+#
+# Based on rust_to_clang_target() from rust-bindgen.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+rust_to_clang_target() {
+    rust_target="$1"
+
+    # Split the string by hyphens
+    triple_parts=""
+    old_IFS="$IFS"
+    IFS='-'
+    for part in $rust_target; do
+        triple_parts="$triple_parts $part"
+    done
+    IFS="$old_IFS"
+    set -- $triple_parts
+
+    # RISC-V
+    case "$1" in
+        riscv32*)
+            set -- "riscv32" "${2}" "${3}" "${4}"
+            ;;
+        riscv64*)
+            set -- "riscv64" "${2}" "${3}" "${4}"
+            ;;
+    esac
+
+    # Apple
+    if [ "$2" = "apple" ]; then
+        if [ "$1" = "aarch64" ]; then
+            set -- "arm64" "${2}" "${3}" "${4}"
+        fi
+        if [ "$4" = "sim" ]; then
+            set -- "${1}" "${2}" "${3}" "simulator"
+        fi
+    fi
+
+    # ESP-IDF
+    if [ "$3" = "espidf" ]; then
+        set -- "${1}" "${2}" "elf" "${4}"
+    fi
+
+    # Reassemble the string
+    new_triple=""
+    first=1
+    for part in "$@"; do
+        if [ -n "$part" ]; then
+            if [ "$first" -eq 1 ]; then
+                new_triple="$part"
+                first=0
+            else
+                new_triple="$new_triple-$part"
+            fi
+        fi
+    done
+
+    echo "$new_triple"
+}
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 18c4bfe02c..9da20ff7c3 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 18c4bfe02c467e5639bf9a687139735ccd7a3fff
+Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853
-- 
2.51.0


