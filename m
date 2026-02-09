Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25862E81BCF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWn-00079z-1w; Mon, 09 Feb 2026 09:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVx-00071t-Q1
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVv-0005if-RB
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAJlrW5rbnYqCFr0QHW62xnPlGP4iWM3E2YRk1GV5eQ=;
 b=YoqwlV5OK67hUE2GctbFl50fmQ0WwsPq6B4MGzTttT3P1gK8CREMtMH9B/ATh5yDIB4U7H
 716ggsDQuxIKhpww0COulGMUCUQf7YTyq99e5LUbEnUndJuBGtvCRwYnp631cn5pRTYs6x
 MZIXnhL/IzuyNIgtklpWGIbYLAAhvNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-Y-8Ok3kLMXaFtWPbZFBWeA-1; Mon,
 09 Feb 2026 09:45:19 -0500
X-MC-Unique: Y-8Ok3kLMXaFtWPbZFBWeA-1
X-Mimecast-MFC-AGG-ID: Y-8Ok3kLMXaFtWPbZFBWeA_1770648312
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577111956094; Mon,  9 Feb 2026 14:45:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CBF018003F5; Mon,  9 Feb 2026 14:45:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/9] scripts/qemugdb: mtree: Fix OverflowError in mtree with
 128-bit addresses
Date: Mon,  9 Feb 2026 09:44:59 -0500
Message-ID: <20260209144508.45268-2-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The 'qemu mtree' command fails with "OverflowError: int too big to
convert" when memory regions have 128-bit addresses.

Fix by changing conversion base from 16 to 0 (automatic detection based
on string prefix).  This works more reliably in GDB's embedded
Python.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20251204105019.455060-2-andrey.drobyshev@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/mtree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 8fe42c3c12..77603c04b1 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -25,7 +25,7 @@ def int128(p):
     if p.type.code == gdb.TYPE_CODE_STRUCT:
         return int(p['lo']) + (int(p['hi']) << 64)
     else:
-        return int(("%s" % p), 16)
+        return int(("%s" % p), 0)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
-- 
2.52.0


