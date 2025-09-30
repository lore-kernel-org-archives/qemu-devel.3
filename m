Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A37CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cRV-0008Ky-CD; Tue, 30 Sep 2025 11:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRS-0008J9-Gx
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cRM-0004Ly-Di
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlKkwYQZuythXF5SkYF9/V+KhexejJOrTJiJWX7b/fg=;
 b=XB46KJzUYGNHBasAEMPNi0eokSslyVKLHTcLC/WoPFxpDFM0V4uii8T+IkG6dzkd6urE61
 DWsuaphH4xP10Y7MnVi+/1z49VMwFkoMqnDCO38BKFWfDP3F80/VBJj40cWpWkBIjauOzj
 3vVog9iRQagKLG8FT6zfxaGkSpa2IVg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-UDDU3SdvNkKzLh2Q-sAO1w-1; Tue,
 30 Sep 2025 11:38:46 -0400
X-MC-Unique: UDDU3SdvNkKzLh2Q-sAO1w-1
X-Mimecast-MFC-AGG-ID: UDDU3SdvNkKzLh2Q-sAO1w_1759246725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19B4519560AF; Tue, 30 Sep 2025 15:38:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E3111800452; Tue, 30 Sep 2025 15:38:43 +0000 (UTC)
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
Subject: [PULL 09/23] tests/docker: use fully qualified image name for emsdk
Date: Tue, 30 Sep 2025 19:37:30 +0400
Message-ID: <20250930153746.573875-10-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Without it, at least it fails with podman on fc42:

[1/6] STEP 1/15: FROM emscripten/emsdk:3.1.50 AS build-base
Error: creating build container: short-name resolution enforced but cannot prompt without a TTY

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Message-ID: <20250924120426.2158655-10-marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/emsdk-wasm32-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
index 60a7d02f56..6b1642a207 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
@@ -8,7 +8,7 @@ ARG PIXMAN_VERSION=0.44.2
 ARG FFI_VERSION=v3.4.7
 ARG MESON_VERSION=1.5.0
 
-FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
 ARG MESON_VERSION
 ENV TARGET=/builddeps/target
 ENV CPATH="$TARGET/include"
-- 
2.51.0


