Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662BDEB48E6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSOS-0001aW-M1; Thu, 12 Feb 2026 03:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOR-0001a4-Ab
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOP-0001M2-R1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TD0Pg2vzQFX1D6MHJBg5f+fb46wxb1TLIVUwptVYGVg=;
 b=YiSnJR73CpY6CHmIbLAfpt9cWm/bwaKgR5EA4CoNaPlBy2REcVeQODimkGoAm+jASDJusU
 qw2YxL1EpGaLFBlLnmU3oLUdL7BsLyPfOBLh4KXOjFNp/5ckHzHGK6D+STkaRCmz4Zjx4F
 ifLDzGRzfHodtzX6YHjzNAEet0aiyJ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-jFqff7wrMOiEVFHgVfrPNA-1; Thu,
 12 Feb 2026 03:49:43 -0500
X-MC-Unique: jFqff7wrMOiEVFHgVfrPNA-1
X-Mimecast-MFC-AGG-ID: jFqff7wrMOiEVFHgVfrPNA_1770886182
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9159A1956048; Thu, 12 Feb 2026 08:49:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4EC330001B9; Thu, 12 Feb 2026 08:49:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PULL 03/14] tests/.../reverse_debugging: Remove unsatisfiable
 condition
Date: Thu, 12 Feb 2026 09:49:16 +0100
Message-ID: <20260212084927.258642-4-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

get_qemu_img() already skips the test if qemu-img is not found and does
not return None. Eliminate the check for None on its result, and the
unreachable skipTest() gated by it.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260203182153.75276-1-yodel.eldar@yodel.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/reverse_debugging.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 8e6f0b0e923..eaf178da496 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -73,9 +73,6 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
         self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
-        if qemu_img is None:
-            self.skipTest('Could not find "qemu-img", which is required to '
-                          'create the temporary qcow2 image')
         out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
                            encoding='utf8')
         self.log.info("qemu-img: %s" % out)
-- 
2.53.0


