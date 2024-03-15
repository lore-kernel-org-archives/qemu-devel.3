Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6DCC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TG-0000ya-Gp; Fri, 15 Mar 2024 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T5-0000vk-DZ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T3-0006qE-Kw
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXK1gONvmEboZ1YKHKYslRUL1tiV9A90eD4rfpt0x5I=;
 b=gkP1QaXS32HqdhdcI5d22AUXTsDAjD6ANKJrJX1DWbdErZ5Yd00ZeISz5qc2ee/IANMsme
 mQu0TczHRf4LW+p7qa1h0KWrdXFNULkZWap40o/Yu5zYWWAstHs3d1GRVeqlOUL9PY9bTN
 h8bnLW91UowntuI5q2LsimilybyTSPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-EaQwTSdENJCgPwj9YLa0NQ-1; Fri, 15 Mar 2024 07:11:12 -0400
X-MC-Unique: EaQwTSdENJCgPwj9YLa0NQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25BEB8007A1;
 Fri, 15 Mar 2024 11:11:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45CCF2024517;
 Fri, 15 Mar 2024 11:11:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/9] tests/qemu-iotests: Fix test 033 for running with
 non-file protocols
Date: Fri, 15 Mar 2024 12:11:00 +0100
Message-ID: <20240315111108.153201-2-thuth@redhat.com>
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When running iotest 033 with the ssh protocol, it fails with:

 033   fail       [14:48:31] [14:48:41]   10.2s                output mismatch
 --- /.../tests/qemu-iotests/033.out
 +++ /.../tests/qemu-iotests/scratch/qcow2-ssh-033/033.out.bad
 @@ -174,6 +174,7 @@
  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  wrote 512/512 bytes at offset 2097152
  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 +qemu-io: warning: Failed to truncate the tail of the image: ssh driver does not support shrinking files
  read 512/512 bytes at offset 0
  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

We already check for the qcow2 format here, so let's simply also
add a check for the protocol here, too, to only test the truncation
with the file protocol.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/033 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index da9133c44b..4bc7a071bd 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -123,9 +123,9 @@ do_test 512 "write -P 1 0 0x200" "$TEST_IMG" | _filter_qemu_io
 # next L2 table
 do_test 512 "write -P 1 $L2_COVERAGE 0x200" "$TEST_IMG" | _filter_qemu_io
 
-# only interested in qcow2 here; also other formats might respond with
-#  "not supported" error message
-if [ $IMGFMT = "qcow2" ]; then
+# only interested in qcow2 with file protocol here; also other formats
+# might respond with "not supported" error message
+if [ $IMGFMT = "qcow2" ] && [ $IMGPROTO = "file" ]; then
     do_test 512 "truncate $L2_COVERAGE" "$TEST_IMG" | _filter_qemu_io
 fi
 
-- 
2.44.0


