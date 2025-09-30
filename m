Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C3ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cT2-0001i6-3z; Tue, 30 Sep 2025 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cSU-0000zG-2C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cSJ-0004g8-G2
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byhNcqkmmzcg69xtJwhrKp8zvTNbZRsTRdq2ZQACTJw=;
 b=BFo6nD08PFotONrq3oOSiTldFFltelTMgysWW0lDxt2QsZzJQpDPOgu30uq48lk4x0saeT
 7pTuOd7tqsOoixrFVbHWavD7++i0tBrQKfg9TrhyKHacNFzytDnjm8MroBmhjqqUaqUtR0
 N1Jq0CC0djfEeOXjxGML4P+XzdvQSrQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-4M12VrQVO8axlMPAkzm8uw-1; Tue,
 30 Sep 2025 11:39:45 -0400
X-MC-Unique: 4M12VrQVO8axlMPAkzm8uw-1
X-Mimecast-MFC-AGG-ID: 4M12VrQVO8axlMPAkzm8uw_1759246783
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A624E19774F1; Tue, 30 Sep 2025 15:39:43 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81BDB195608E; Tue, 30 Sep 2025 15:39:42 +0000 (UTC)
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
Subject: [PULL 19/23] configure: set the meson executable suffix/ext
Date: Tue, 30 Sep 2025 19:37:40 +0400
Message-ID: <20250930153746.573875-20-marcandre.lureau@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'rustfmt' target runs meson: it needs the correct path with
extension on Windows.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250924120426.2158655-20-marcandre.lureau@redhat.com>
---
 configure | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index bf964947b8..78445cbb4b 100755
--- a/configure
+++ b/configure
@@ -1000,7 +1000,19 @@ $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
 # We ignore PATH completely here: we want to use the venv's Meson
 # *exclusively*.
 
-meson="$(cd pyvenv/bin; pwd)/meson"
+# for msys2
+get_pwd() {
+    if pwd -W >/dev/null 2>&1; then
+        pwd -W
+    else
+        pwd
+    fi
+}
+
+meson="$(cd pyvenv/bin; get_pwd)/meson"
+if [ -f "$meson$EXESUF" ]; then
+  meson="$meson$EXESUF"
+fi
 
 # Conditionally ensure Sphinx is installed.
 
-- 
2.51.0


