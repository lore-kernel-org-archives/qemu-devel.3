Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B8CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cTl-0002NJ-1G; Tue, 14 Oct 2025 06:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8cTi-0002MM-D2
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8cTc-0003Ro-0W
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760438513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO30Hprwf0HWqbmbRb2yRt5fRN89ZOJKV5kgz254Fl0=;
 b=G/qxjs/4jAk2tVN9j2vuTQ36nq9fgfj9tuH6wtALV4ptdOvWfq+3Nb/VylQU2l0uQq3XSP
 c53BDJ1EeRDcWCqfihPOtSvnLFhKK2pSYVrlwMISTG5G6Pb0AkWS1obcr6hHn/uf7+KtCg
 mhPDKMS0nrNuL7Rj7VmjZ+te3NmFRMs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-57C0TX0YPvuzGQ7_IXoW3A-1; Tue,
 14 Oct 2025 06:41:50 -0400
X-MC-Unique: 57C0TX0YPvuzGQ7_IXoW3A-1
X-Mimecast-MFC-AGG-ID: 57C0TX0YPvuzGQ7_IXoW3A_1760438508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 406F41956096; Tue, 14 Oct 2025 10:41:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3323330002D0; Tue, 14 Oct 2025 10:41:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] tests/qemu-iotests/184: Fix skip message for qemu-img
 without throttle
Date: Tue, 14 Oct 2025 12:41:40 +0200
Message-ID: <20251014104142.1281028-2-thuth@redhat.com>
In-Reply-To: <20251014104142.1281028-1-thuth@redhat.com>
References: <20251014104142.1281028-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

If qemu-img does not support throttling, test 184 currently skips
with the message:

  not suitable for this image format: raw

But that's wrong, it's not about the image format, it's about the
throttling not being available in qemu-img. Thus fix this by using
_notrun with a proper message instead.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/184 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index e4cbcd86345..f7fcedacfb5 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -50,7 +50,7 @@ run_qemu()
 }
 
 test_throttle=$($QEMU_IMG --help|grep throttle)
-[ "$test_throttle" = "" ] && _supported_fmt throttle
+[ "$test_throttle" = "" ] && _notrun "qemu-img does not support throttle"
 
 echo
 echo "== checking interface =="
-- 
2.51.0


