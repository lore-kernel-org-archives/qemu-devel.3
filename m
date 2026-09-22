Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DB5C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yw-0006HV-NF; Tue, 22 Sep 2026 16:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yL-0004zr-CE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yJ-0008Aj-RD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKvhBpJpZS5ZhCDI8kLKWLJbP/lCAKUoJKR82ZuccS8=;
 b=HQMwSZ1aqGVicRtZ9SrRVRzVc2ER8ei5piWgumfQ1BY7CSVgPFEkpay//6lnB/LPyT6GcM
 rKFx9WMLxcrLn6kvgcZ+lhsG7I5dGKBFAzfD4m+NWdEQ4zKmIf9tg2hurNZSONK3C4cN7Z
 n3vo/aKKeyXwefmgZLXzZHJBUWIyfrM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-eoPdrLgoOuCAS5wjW6STzg-1; Tue,
 22 Sep 2026 16:20:07 -0400
X-MC-Unique: eoPdrLgoOuCAS5wjW6STzg-1
X-Mimecast-MFC-AGG-ID: eoPdrLgoOuCAS5wjW6STzg_1790108406
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD0261955EAF; Tue, 22 Sep 2026 20:20:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95D70427; Tue, 22 Sep 2026 20:20:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:23 +0400
Subject: [PATCH 16/88] qemu-iotests/reopen-file: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-16-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Njh8uCzUxbmSD+8h/bjdMoOcXhbpPrw5kgwgHaSNEYw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvCZ0rwnW8wt2i8JCGYIcPoyxYUTgyE9kOt
 LV5EX+brMuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5dH9D/0aIlNE9fDFXdWkpySfsLKT0OnNxTB7wZgxs/PeiWVaiWK3OB69JCqUXSzCk8yszGElMzK
 /p+m912b1s/Ws+9TfH0JvTjhuq3BVjp73EAYQbNIZmpv3JyGvyjixy1jvzOcYTm2Jxc3dZpE4cA
 miForgaqLUyYnM+J2C6YFFI0G4UpEYvAY3CxBL9cghfFNUjzgnVswpgVFFnMY9If3wqORg7Ydtv
 IyUg85oiaYiwZSHVkRsaoYsM8ZM0rXdQPUVUn3swKfw2aYUvMxNkIa5JkI9qdHWaGiq7IezjCpo
 Hsl/1gXZcKv9Fc0jGPVszx7SUIvCTUIrNQ64hYLnfKQLZsFpW/H4M3LSeIHQkBYlgNEGmrK9sAy
 oiSWd0+77kSk2LDkkV+QH3sydGLuTmEgaHdVn9v/bL6MRVkTxHItJwXwdSMebm1mFRUtRr+l06C
 Bi20c6vETAfOLskeR/lwbGdcHXXb7ebv25aq9EWG5770Bhxev/3oV3J3MQq+hCDl6Tfd8PqMjyI
 69I3td2xrmOwvgX5PJq/DxjNneOyUITAz3JtYNjOlCIQ95woZdBpmDAuLTYQlmrQTvPCqP8dxy+
 MNJaIrenEQNg4ho8u3SlE2ls1Pl1yVWLbT/Kp51Q9oq+xZ1n1Wjm00QzB+QRc9Gj47Gx/eQWQsN
 iJHW6bkj4LE1kYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/reopen-file | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/tests/reopen-file b/tests/qemu-iotests/tests/reopen-file
index f8812320ea8f..98b0f9e98e73 100755
--- a/tests/qemu-iotests/tests/reopen-file
+++ b/tests/qemu-iotests/tests/reopen-file
@@ -72,18 +72,12 @@ class TestReopenFile(QMPTestCase):
 
         # Do some I/O to the image to see whether it still works
         # (Pattern verification will be checked by tearDown())
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io format "write -P 42 0 64k"')
-        self.assert_qmp(result, 'return', '')
-
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io format "read -P 42 0 64k"')
-        self.assert_qmp(result, 'return', '')
+        self.vm.qmp_qemu_io('format', 'write -P 42 0 64k')
+        self.vm.qmp_qemu_io('format', 'read -P 42 0 64k')
 
 
 if __name__ == '__main__':
     # Must support creating images and reopen
     iotests.main(supported_fmts=['qcow', 'qcow2', 'qed', 'raw', 'vdi', 'vhdx',
                                  'vmdk', 'vpc'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


