Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB41C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5TR-00012w-4j; Fri, 15 Mar 2024 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5TA-0000xE-2d
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T8-0006uC-FB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kzrx5m6uabqM1vhnSUueyKq+Jz89fLh5eBJkoIrCcfw=;
 b=FTWgMpk77GVDqLWQ7umNy/QKA57p2wjqxemnA/bmZY9DWcrfly9iPcycBLDdYE5TtVHjPT
 2fbinsN6l/BPsI6ER7jiZzv275cKXF8DgSwpTKNC/9s27orLVcH3WdasCLE42Rf4ugojf+
 shzN3J1WX6Pq63qYhoiKa2FivvpFYvs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-hNCGRyAtOAaDjX-T74uYpg-1; Fri,
 15 Mar 2024 07:11:18 -0400
X-MC-Unique: hNCGRyAtOAaDjX-T74uYpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36DCB38157BA;
 Fri, 15 Mar 2024 11:11:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CEB02024517;
 Fri, 15 Mar 2024 11:11:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/9] tests/qemu-iotests: Restrict test 134 and 158 to the
 'file' protocol
Date: Fri, 15 Mar 2024 12:11:04 +0100
Message-ID: <20240315111108.153201-6-thuth@redhat.com>
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

Commit b25b387fa592 updated the iotests 134 and 158 to use the --image-opts
parameter for qemu-io with file protocol related options, but forgot to
update the _supported_proto line accordingly. So let's do that now.

Fixes: b25b387fa5 ("qcow2: convert QCow2 to use QCryptoBlock for encryption")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/134 | 2 +-
 tests/qemu-iotests/158 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index ded153c0b9..b2c3c03f08 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow qcow2
-_supported_proto generic
+_supported_proto file
 
 
 size=128M
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index a95878e4ce..3a9ad7eed0 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow qcow2
-_supported_proto generic
+_supported_proto file
 
 
 size=128M
-- 
2.44.0


