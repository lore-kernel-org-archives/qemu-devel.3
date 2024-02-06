Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F42AC4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIvu-0006tP-4I; Tue, 06 Feb 2024 05:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvl-0006sJ-P7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvj-00039B-8H
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+uzC8Z4gSLL8Q72zuWcwUQ+UBRU55ra9QewclI0m2c=;
 b=VmT+cnpBu5VpABTwyD84HjHOIug7atBTOy+ddiUXMZneIr+v6iCEks2sQ8MkD1f4O1+0bc
 UcvdYn6RfMqLTYw5NsrN8zWLjNOAvGKuEZwLZgjuo86tUpTdrZvsIwFZPQ/9W8PyyVjo0X
 UFNABzoQQW0u28u2ieJQPvOTL6p5vVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-MMOe4FHBPdiGnpUHFO_f2A-1; Tue, 06 Feb 2024 05:43:51 -0500
X-MC-Unique: MMOe4FHBPdiGnpUHFO_f2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F20785A589;
 Tue,  6 Feb 2024 10:43:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA6BA492BF0;
 Tue,  6 Feb 2024 10:43:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>
Subject: [PULL 01/12] hw/scsi/lsi53c895a: add missing decrement of reentrancy
 counter
Date: Tue,  6 Feb 2024 11:43:36 +0100
Message-ID: <20240206104347.238825-2-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sven Schnelle <svens@stackframe.org>

When the maximum count of SCRIPTS instructions is reached, the code
stops execution and returns, but fails to decrement the reentrancy
counter. This effectively renders the SCSI controller unusable
because on next entry the reentrancy counter is still above the limit.

This bug was seen on HP-UX 10.20 which seems to trigger SCRIPTS
loops.

Fixes: b987718bbb ("hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330)")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-ID: <20240128202214.2644768-1-svens@stackframe.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/lsi53c895a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 34e3b89287..d607a5f9fb 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1159,6 +1159,7 @@ again:
         lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
         lsi_disconnect(s);
         trace_lsi_execute_script_stop();
+        reentrancy_level--;
         return;
     }
     insn = read_dword(s, s->dsp);
-- 
2.43.0


