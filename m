Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F2606A885
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PUoqG7i6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRT0I-0007LX-42; Thu, 12 Nov 2026 06:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRT0G-0007Ku-Al
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:30:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRT0E-0002bB-SK
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794483001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ncPW2vMhDh4K7aC6fP7yT//tCYy2p98o6i5SEpKz2cc=;
 b=PUoqG7i66umkW1Ve2rks0StKadaXRIWxFuDHASEJy9J0aX1ECbSOaTukk7tWLIgeEj33m1
 017jcd+DntHzJ220KjUB7jYXSOIX7h+jumlc8ZFPFudB58mjrBoW+MD9XS8nTEgXVuZfdG
 YzUremUWHOYUNs/DXmQh9KmBfdqFNmo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-FMRh_UipNu6TsoJrv7JdUw-1; Thu,
 12 Nov 2026 06:30:00 -0500
X-MC-Unique: FMRh_UipNu6TsoJrv7JdUw-1
X-Mimecast-MFC-AGG-ID: FMRh_UipNu6TsoJrv7JdUw_1794482999
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76A7E180250B; Thu, 12 Nov 2026 11:29:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78EA630000E5; Thu, 12 Nov 2026 11:29:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH] python/qemu: fix accelerator detection with annotated -accel
 help
Date: Thu, 12 Nov 2026 15:29:56 +0400
Message-ID: <20261112112956.361209-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

QEMU annotates the accelerator names in "-accel help" with their
security status, eg "kvm (secure)". kvm_available() compares the
entries with the plain accelerator name, so the check fails and
functional tests using require_accelerator('kvm') are silently
skipped.

Keep only the accelerator name of each line.

fwiw, I am surprised we don't seem to have a CI that exercice functional
kvm tests, or compare against a baseline to avoid this kind of
regression.

Fixes: d3b770fc6342 ("system: report acclerator security status in help output")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 python/qemu/utils/accel.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index f915b646692e..7e3f43d6b489 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -47,8 +47,9 @@ def list_accel(qemu_bin: str) -> List[str]:
     except:
         LOG.debug("Failed to get the list of accelerators in %s", qemu_bin)
         raise
-    # Skip the first line which is the header.
-    return [acc.strip() for acc in out.splitlines()[1:]]
+    # Skip the first line which is the header, and drop annotations
+    # such as " (secure)" from the accelerator names.
+    return [acc.split(' ')[0] for acc in out.splitlines()[1:]]
 
 
 def kvm_available(target_arch: Optional[str] = None,
-- 
2.56.0.116.g6de20f6092dc


