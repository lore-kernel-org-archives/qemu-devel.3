Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97311CCA471
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cR3-0008BR-0Y; Tue, 30 Sep 2025 11:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cR1-0008Ab-3V
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cQx-0004DX-4g
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkopEzcMgre1oqPqOMOI0pY8SSCf0ly5kfTMun2HyVk=;
 b=M8eubEIPj1/vjpbx3qH/6KXZWPAF5og88ZJVuczvoPFVnOlEwXk7UlXOCUP376fN0Bcrrv
 +f6WeiJhfNopLty7vlTegxgmECnNekPSkfedPOQOCweWq5f4ccnKmPFhbT1FVaXJCe7hjc
 c12mFL4xhD9fk4fDvbJFfq89KA/PPy4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-xLwcWBTsNJ-ywGMm6wmhlg-1; Tue,
 30 Sep 2025 11:38:25 -0400
X-MC-Unique: xLwcWBTsNJ-ywGMm6wmhlg-1
X-Mimecast-MFC-AGG-ID: xLwcWBTsNJ-ywGMm6wmhlg_1759246702
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70FDB1800593; Tue, 30 Sep 2025 15:38:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ED361956095; Tue, 30 Sep 2025 15:38:20 +0000 (UTC)
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
Subject: [PULL 05/23] scripts/archive-source: use a bash array
Date: Tue, 30 Sep 2025 19:37:26 +0400
Message-ID: <20250930153746.573875-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250924120426.2158655-6-marcandre.lureau@redhat.com>
---
 scripts/archive-source.sh | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index b86e632161..a725dd923d 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,12 +26,27 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
-  berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
-  libc-0.2-rs proc-macro2-1-rs
-  proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+subprojects=(
+  anyhow-1-rs
+  arbitrary-int-1-rs
+  attrs-0.2-rs
+  berkeley-softfloat-3
+  berkeley-testfloat-3
+  bilge-0.2-rs
+  bilge-impl-0.2-rs
+  either-1-rs
+  foreign-0.3-rs
+  itertools-0.11-rs
+  keycodemapdb
+  libc-0.2-rs
+  libvfio-user
+  proc-macro-error-1-rs
+  proc-macro-error-attr-1-rs
+  proc-macro2-1-rs
+  quote-1-rs
+  syn-2-rs
+  unicode-ident-1-rs
+)
 sub_deinit=""
 
 function cleanup() {
@@ -77,10 +92,10 @@ function subproject_dir() {
 git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 
-meson subprojects download $subprojects >/dev/null
+meson subprojects download ${subprojects[@]} >/dev/null
 test $? -ne 0 && error "failed to download subprojects $subprojects"
 
-for sp in $subprojects; do
+for sp in "${subprojects[@]}"; do
     tar --append --file "$tar_file" --exclude=.git subprojects/"$(subproject_dir $sp)"
     test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
 done
-- 
2.51.0


