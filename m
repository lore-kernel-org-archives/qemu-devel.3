Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOyCw-00052y-2X; Mon, 18 May 2026 09:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOyCu-00052d-9b
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOyCs-0007hi-Q6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779111629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3tOi+raTHMXceLcF0R8H4MmXYsLEwkQ1WQprPeDxA98=;
 b=VSxFD9AR62smxXewxP9q3iWStIDULQ+3I0E+RJkuOYBnhOqsDIFiDT0222HiX8EJQ9eRdL
 FyXMfSNdYdrEgSHApPQMG0Q3uzPA15ughSYxZLPOw08TlU2Xbqqw8v52oEC0QcNPxPT3bH
 k5VBHU4hb8PDrMC99oUmJq0z06Flb5M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-WuBgSzOPM0uXekokzzTMZQ-1; Mon,
 18 May 2026 09:40:25 -0400
X-MC-Unique: WuBgSzOPM0uXekokzzTMZQ-1
X-Mimecast-MFC-AGG-ID: WuBgSzOPM0uXekokzzTMZQ_1779111625
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E82718002D0; Mon, 18 May 2026 13:40:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E16F19560A2; Mon, 18 May 2026 13:40:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH] system/qtest: Fix length parameter in the b64write code
Date: Mon, 18 May 2026 15:40:20 +0200
Message-ID: <20260518134020.1420932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The b64write code has a sanity check that the given lengths matches
the real length of the given data, and calculates the minimum of the
two values to be on the safe side. However, the address_space_write()
then uses the original value and ignores the calculated minimum. Use
out_len here to fix the problem.

Fixes: 70da30483e7 ("qtest: Use cpu address space instead of system memory")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 system/qtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/qtest.c b/system/qtest.c
index a79d10d1361..d6db057b0a2 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -698,7 +698,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         }
 
         address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+                            out_len);
 
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-- 
2.54.0


