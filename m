Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44735C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCdV-00039u-SM; Mon, 18 Mar 2024 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcg-0002V7-Up
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcc-0007fQ-Aa
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkaVGFyeD96Nrgdo28H32d4UGIc8Q50cP9hwtp8Oo/E=;
 b=Tz3lIcP1R0OzEAHP3Rcrwtl27HxKQ4OSUwpPfJxzSN1L6T9mpUaPz5P8GykguWqLkwzUky
 GYWD4bybD2XwJmwyqRJOKYaNJWZL2VssX0HkkSsJ/Pf1ERRMjE9LhtwXI9LX8sT2yq9zbf
 tU21dYdPUMaN9MP9N41uAUztEeaRKec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-eRx0-9aQP_GcdTUoA6v0og-1; Mon, 18 Mar 2024 09:01:31 -0400
X-MC-Unique: eRx0-9aQP_GcdTUoA6v0og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D22758007B0;
 Mon, 18 Mar 2024 13:01:30 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4541A2166AE9;
 Mon, 18 Mar 2024 13:01:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/15] tests/qemu-iotests: Fix test 033 for running with
 non-file protocols
Date: Mon, 18 Mar 2024 14:01:09 +0100
Message-ID: <20240318130118.358920-7-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
References: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-ID: <20240315111108.153201-2-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


