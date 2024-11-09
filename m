Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B7D2E9FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAV4w-0001nH-5r; Mon, 11 Nov 2024 09:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1tAV4r-0001mu-96
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1tAV4p-0005sL-JJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731334050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R4A7LnVN8nShOWsZ/3tQfyajfBFCH/UTE3ow0+2HLKU=;
 b=LsYydFh31D7j1HNQE2j/6v+jO7ffFqW0E9BqP8TcEde/CLmhtABeM/dGHGhJ4XfsMIUc1Q
 T26ol1TidQMwAjcOYaWuXTTml/ZsRnfAVy+MRd8mY7vxwJlRECrXv0JrA5LFc1J3Ce9yMt
 XKNKQ2hwNyfRLb1L9jfWOSAPH6QZ+Jg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-K0p11xppPPGqmhBLCqA87Q-1; Mon,
 11 Nov 2024 09:07:27 -0500
X-MC-Unique: K0p11xppPPGqmhBLCqA87Q-1
X-Mimecast-MFC-AGG-ID: K0p11xppPPGqmhBLCqA87Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD3E71955F44; Mon, 11 Nov 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.39.194.92])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F11891956054; Mon, 11 Nov 2024 14:07:21 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/i386/elfboot: allocate "header" in heap
Date: Sat,  9 Nov 2024 06:37:48 +0100
Message-ID: <20241109053748.13183-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In x86_load_linux(), we were using a stack-allocated array as data for
fw_cfg_add_bytes(). Since the latter just takes a reference to the
pointer instead of copying the data, it can happen that the contents
have been overridden by the time the guest attempts to access them.

Instead of using the stack-allocated array, allocate some memory from
the heap, copy the contents of the array, and use it for fw_cfg.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---

v2:
- Use g_memdup2 (thanks Philippe).
- Collect reviews.
---
 hw/i386/x86-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index bc360a9ea4..dc031af662 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -697,9 +697,11 @@ void x86_load_linux(X86MachineState *x86ms,
                 strlen(kernel_cmdline) + 1);
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
 
+            setup = g_memdup2(header, sizeof(header));
+
             fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
             fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
-                             header, sizeof(header));
+                             setup, sizeof(header));
 
             /* load initrd */
             if (initrd_filename) {
-- 
2.45.2


