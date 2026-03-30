Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB65D10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B0E-0005LV-DN; Mon, 30 Mar 2026 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axu-0003uD-C5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axr-0003Yp-Nh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774870762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Kl2QNqUkqVsIFA+KbG8OvMYBLCj/RG5LGqEkMcQuTo=;
 b=g0ZcF9V2+yw4rle/QuPUAG8AsiQbDe+P3GegJxBToo/TO1p2SyopDDfbVHkh6kcXJzvc8l
 cugKv2EUYA9DYQ65ew+Md3V8L4tLIC1SalRFUCJe/tCXz4vmnDEBNgmcWwKHmlt+eofBxE
 YcWeLxF/WqIVu45f0isQq1j0GZ4nkog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-0NwQ1hb6OsSikxXHumlQ_A-1; Mon,
 30 Mar 2026 07:39:18 -0400
X-MC-Unique: 0NwQ1hb6OsSikxXHumlQ_A-1
X-Mimecast-MFC-AGG-ID: 0NwQ1hb6OsSikxXHumlQ_A_1774870758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8A818005B6; Mon, 30 Mar 2026 11:39:17 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B067180036E; Mon, 30 Mar 2026 11:39:16 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 3/7] qga/meson: Use windows.compile_resources instead of
 custom_target
Date: Mon, 30 Mar 2026 14:39:02 +0300
Message-ID: <20260330113906.168002-4-kkostiuk@redhat.com>
In-Reply-To: <20260330113906.168002-1-kkostiuk@redhat.com>
References: <20260330113906.168002-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

windows.compile_resources supports more compiles and works
in both MinGW and MSVC environment. While 'windres' is a
MinGW specific tool.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/meson.build | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 1c6433ef25..85bdacf7e2 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -105,16 +105,14 @@ endif
 qga_objs = []
 if host_os == 'windows'
   windmc = find_program('windmc', required: true)
-  windres = find_program('windres', required: true)
 
   msgrc = custom_target('messages-win32.rc',
                         input: 'messages-win32.mc',
                         output: ['messages-win32.rc', 'MSG00409.bin', 'messages-win32.h'],
                         command: [windmc, '-h', '@OUTDIR@', '-r', '@OUTDIR@', '@INPUT@'])
-  msgobj = custom_target('messages-win32.o',
-                         input: msgrc[0],
-                         output: 'messages-win32.o',
-                         command: [windres, '-I', '@OUTDIR@', '-o', '@OUTPUT@', '@INPUT@'])
+
+  windows = import('windows')
+  msgobj = windows.compile_resources(msgrc[0])
 
   qga_objs = [msgobj]
 endif
-- 
2.52.0


