Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DB2CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GU-0004BM-Ge; Tue, 26 Mar 2024 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GS-0004A2-NT
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GR-0001P6-F9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6B4HgbA6C/O5RdIwngaUbFY9RBnEDvKUfUK5RdUtZHQ=;
 b=QHWT1ZsLxp5UvrQu7aNfYfAX65gQf0Pbw/dWM9CVbkKM5uU5TAhjWFn+PTjN1ibRld4taA
 EW+gW5kq9OKWXDRSFRx5P0rX2MhnmyhVkmOWbqBb1YxsmkUjfRIKKdCv2eFhylYwZ/HqL3
 knoZtzXGHmtHJLEc5X9Ix9q5U9tVONc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-uJBrldiINKqgVBpeIM3HJA-1; Tue, 26 Mar 2024 09:54:48 -0400
X-MC-Unique: uJBrldiINKqgVBpeIM3HJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E438007A3;
 Tue, 26 Mar 2024 13:54:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7AA112132A;
 Tue, 26 Mar 2024 13:54:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 1/6] tests/qemu-iotests: Test 157 and 227 require virtio-blk
Date: Tue, 26 Mar 2024 14:54:35 +0100
Message-ID: <20240326135440.421609-2-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Tests 157 and 227 use the virtio-blk device, so we have to mark these
tests accordingly to be skipped if this devices is not available (e.g.
when running the tests with qemu-system-avr only).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240325154737.1305063-1-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/157 | 2 ++
 tests/qemu-iotests/227 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 0dc9ba68d2..aa2ebbfb4b 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 
+_require_devices virtio-blk
+
 do_run_qemu()
 {
     (
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 7e45a47ac6..eddaad679e 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 
+_require_devices virtio-blk
+
 do_run_qemu()
 {
     echo Testing: "$@"
-- 
2.44.0


