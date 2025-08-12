Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A44CA0EDB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 20:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulvA6-0001ou-Hi; Tue, 12 Aug 2025 15:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulv9b-0001j2-EK
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulv9U-0006Mi-V7
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755028758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2VUZ+nh2NtJdEI9eHm6LB42MjUND7gUqhbN3IVfnPQ=;
 b=KF8s+lGNnrdyUEB5/dqbqw/u7Q3uJKqZOsEvWRsTx4sbMluMfSicnRyEY+z3bS9y9az6lT
 uU7jhLdUbzF+KZQww3fPT6KjIgbjbQYdSntJa8oQm5SM0SWApWR1oHCXk6kbalAWoF/1Hj
 c0DwIDIN4v9fXReQRxhM2aAQn9Up2Kk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-EBJArJkENQqwBlkjfq8ufw-1; Tue,
 12 Aug 2025 15:59:16 -0400
X-MC-Unique: EBJArJkENQqwBlkjfq8ufw-1
X-Mimecast-MFC-AGG-ID: EBJArJkENQqwBlkjfq8ufw_1755028748
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 098811956095; Tue, 12 Aug 2025 19:59:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.181])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6117D180028A; Tue, 12 Aug 2025 19:59:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/3] configure: Don't disable Rust for too old meson version
Date: Tue, 12 Aug 2025 21:58:59 +0200
Message-ID: <20250812195901.305895-2-kwolf@redhat.com>
In-Reply-To: <20250812195901.305895-1-kwolf@redhat.com>
References: <20250812195901.305895-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Message-ID: <20250811142923.89983-1-kwolf@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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


