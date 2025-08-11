Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2A9C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 14:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulTXS-0002Q5-P2; Mon, 11 Aug 2025 10:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulTX1-0002Iy-8S
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulTWw-0007N7-Pm
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754922578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TUk+oxQqP3+1Tw1ir7+gMc1fhS/zGQAqfeWjeuFoIrM=;
 b=axCj7e8iIpXoftDjgjbnmHv9Q1mNzKrbrpBdcrXtKnwyzoybbNxAxKIxzIi4v246gvT8b3
 mUewugGhjcQ1W5RoAIHyUr5bQIoUXmVwiwYjKOEB0FAOx06Rf8IbzrWbTi4G8gQREI41vC
 5Te+geaJcAee2jw1EGi8JLpwtSRzvA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-UZC_Oj-WPciD7xmtnY9mOw-1; Mon,
 11 Aug 2025 10:29:36 -0400
X-MC-Unique: UZC_Oj-WPciD7xmtnY9mOw-1
X-Mimecast-MFC-AGG-ID: UZC_Oj-WPciD7xmtnY9mOw_1754922576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92EED18002A0; Mon, 11 Aug 2025 14:29:35 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.151])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F7541955F24; Mon, 11 Aug 2025 14:29:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 qemu-rust@nongnu.org
Subject: [PATCH] configure: Don't disable Rust for too old meson version
Date: Mon, 11 Aug 2025 16:29:23 +0200
Message-ID: <20250811142923.89983-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If the user explicitly specified --enable-rust, don't just fail if meson
is too old for Rust support, but do the same thing as if meson was too
old for the C code: Just download a newer one.

In order to avoid the additional download for people who aren't
intentionally opting in to Rust, keep the automatic disabling based on
the meson version as the default if neither --enable-rust nor
--disable-rust were given.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 configure       | 8 +++++---
 pythondeps.toml | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 825057ebf1..274a778764 100755
--- a/configure
+++ b/configure
@@ -1186,10 +1186,12 @@ fi
 meson_version=$($meson --version)
 if test "$rust" != disabled && ! version_ge "$meson_version" 1.8.1; then
   if test "$rust" = enabled; then
-    error_exit "Rust support needs Meson 1.8.1 or newer"
+    $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
+         ${source_path}/pythondeps.toml meson-rust || exit 1
+  else
+    echo "Rust needs Meson 1.8.1, disabling" 2>&1
+    rust=disabled
   fi
-  echo "Rust needs Meson 1.8.1, disabling" 2>&1
-  rust=disabled
 fi
 if test "$rust" != disabled && has "$rustc" && $rustc -vV > "${TMPDIR1}/${TMPB}.out"; then
   rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
diff --git a/pythondeps.toml b/pythondeps.toml
index b2eec940ce..d0f52b14f7 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -22,6 +22,10 @@
 meson = { accepted = ">=1.5.0", installed = "1.8.1", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
+[meson-rust]
+# The install key should match the version in python/wheels/
+meson = { accepted = ">=1.8.1", installed = "1.8.1", canary = "meson" }
+
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
 sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
-- 
2.50.1


