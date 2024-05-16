Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0655EC25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Wfv-00046x-4q; Thu, 16 May 2024 04:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7Wfm-0003qj-4z
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7Wfk-0003fu-Cu
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715848866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQF2aYqnBQoGrZDv7vPqt+Lr8TeKY9BGj4Jld5NnGQ8=;
 b=ioLP7+it+9wcIWsXXb2R6lnCULMi0gxEJuFILKNS/skr6j/+kDzneisv9m4NSgbs2Tlo/K
 hxyKw3L4Hqe+ZLq51sck0uvTBGAGUB5dTSGcpbjnTy7LhSENo04hLiH29OporoFtH2++G8
 gCdCEA9XH1MZFSVjRu3Yj8MCiunao4o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-KlZefxhkP36nfLSpgaO5ww-1; Thu,
 16 May 2024 04:41:02 -0400
X-MC-Unique: KlZefxhkP36nfLSpgaO5ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58DB63C11C66;
 Thu, 16 May 2024 08:41:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71DAA2026D68;
 Thu, 16 May 2024 08:41:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] tests/lcitool/refresh: Treat the output of lcitool as
 text, not as bytes
Date: Thu, 16 May 2024 10:40:55 +0200
Message-ID: <20240516084059.511463-2-thuth@redhat.com>
In-Reply-To: <20240516084059.511463-1-thuth@redhat.com>
References: <20240516084059.511463-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In case lcitool fails (e.g. with a python backtrace), this makes
the output  of lcitool much more readable.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/refresh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 24a735a3f2..174818d9c9 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -43,12 +43,12 @@ def atomic_write(filename, content):
 
 def generate(filename, cmd, trailer):
     print("Generate %s" % filename)
-    lcitool = subprocess.run(cmd, capture_output=True)
+    lcitool = subprocess.run(cmd, capture_output=True, encoding='utf8')
 
     if lcitool.returncode != 0:
         raise Exception("Failed to generate %s: %s" % (filename, lcitool.stderr))
 
-    content = lcitool.stdout.decode("utf8")
+    content = lcitool.stdout
     if trailer is not None:
         content += trailer
     atomic_write(filename, content)
-- 
2.45.0


