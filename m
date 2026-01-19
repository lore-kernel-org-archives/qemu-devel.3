Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D8D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhucN-0002Dj-2E; Mon, 19 Jan 2026 14:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucJ-0002Bq-Jf
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucI-0000vt-7r
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwZfVhIWIVz+4atlC56uUtVZJ/PaIRcfoFiobmlE1bY=;
 b=dji8v7UUCGUHDjpUZ1oxqOsMX2n0UWajEKtGok8M8eVlsfyvgAyjggoOyFShKISRIZPzNb
 nz40iIPcGi7bMYIaKJv+xy43gWtGnT2jcuLTqCbUMaREzyV7r0IbrReSb8xRs6KtD27uR/
 F19uSTYIZ1soqwzi6zsxl6uR1wdIhOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-1T_2VTp3OHy2e8bezsIaHQ-1; Mon,
 19 Jan 2026 14:08:41 -0500
X-MC-Unique: 1T_2VTp3OHy2e8bezsIaHQ-1
X-Mimecast-MFC-AGG-ID: 1T_2VTp3OHy2e8bezsIaHQ_1768849720
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CE51195605F; Mon, 19 Jan 2026 19:08:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF782180049F; Mon, 19 Jan 2026 19:08:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Richard Henderson <rth@twiddle.net>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 8/8] tests/tracetool: Honor the Python interpreter that
 "configure" detected
Date: Mon, 19 Jan 2026 14:08:23 -0500
Message-ID: <20260119190823.867761-9-stefanha@redhat.com>
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The tracetool tests currently fail if the host installation does not
have a "python3" binary (and you compiled QEMU by selecting a different
one during the "configure" step). This happens because tracetool-test.py
executes scripts/tracetool.py directly, so that this script is run via
its shebang line. To fix the issue, use the same Python interpreter to
run scripts/tracetool.py as we are using to run the tracetool-test.py
script.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20260115155318.37823-1-thuth@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/tracetool-test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 10e362a407..b99a0cd6d2 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -39,7 +39,8 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
     actual_file = Path(build_dir, rel_filename)
     expect_file = Path(src_dir, rel_filename)
 
-    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+    args = [sys.executable, tracetool,
+            f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
 
     if fmt.find("stap") != -1:
         args += ["--binary=qemu", "--probe-prefix=qemu"]
-- 
2.52.0


