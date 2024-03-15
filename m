Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28400C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TV-0001E1-8K; Fri, 15 Mar 2024 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TD-0000yX-6i
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TB-0006wG-C1
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GzpX5M/vVosor6mOKBg/wyW648ebLEyIpXtehNEt5E=;
 b=EXF98c4ntQaXovtwh2RfHC9RkRo2pnrmzmWtaZQ2dr6ikuYFCUJuq9D1/4vVFSEiTa8nGW
 3jabb70b9E2P+8kIRLaTBUq8+HB44d6/MAp3W76455m5TCz3//zjjrLVR388sz1Pt1ojdt
 euBrSbweO0oVzx9DIXLX2NwSkCa5+UI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-VGCPr6nKNAGgqb-0diPpgg-1; Fri,
 15 Mar 2024 07:11:22 -0400
X-MC-Unique: VGCPr6nKNAGgqb-0diPpgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 961B81C02164;
 Fri, 15 Mar 2024 11:11:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67F7C2024517;
 Fri, 15 Mar 2024 11:11:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 7/9] tests/qemu-iotests: Restrict tests that use --image-opts
 to the 'file' protocol
Date: Fri, 15 Mar 2024 12:11:06 +0100
Message-ID: <20240315111108.153201-8-thuth@redhat.com>
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

These tests 188, 189 and 198 use qemu-io with --image-opts with additional
hard-coded parameters for the file protocol, so they cannot work for other
protocols. Thus we have to limit these tests to the file protocol only.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/188 | 2 +-
 tests/qemu-iotests/189 | 2 +-
 tests/qemu-iotests/198 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index ce087d1873..2950b1dc31 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 _supported_os Linux
 _require_working_luks
 
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 801494c6b9..008f73b07d 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 _supported_os Linux
 _require_working_luks
 
diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 1c93dea1f7..6ddeffddd2 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 _supported_os Linux
 _require_working_luks
 
-- 
2.44.0


