Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDE2C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWO7-00041o-Pe; Wed, 22 Jul 2026 08:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWME-0002lG-5n; Wed, 22 Jul 2026 08:47:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMB-0001dw-Jf; Wed, 22 Jul 2026 08:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=YcrhrvRe6bgu/eosWGv78+Uh4KtUuKbE2yRgKxfdOHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rYtEvUX9tUlyKvjlZBQtR+MQmKGTm0n9Dvo8Xf6bqKHv0gXyZkQTf2ecpMCLJBzlt
 W2HqMZR7OdDSArz+bFEWFBBUPgbhJDrp4N++hiSKZLIThXTm3IZRLLomMnos2Z+NMz
 Tly4ENDJVZJnwknX5+7aenBeY3eEWkKC3E+TrW6YYvw1VjaaLQYwX7Qz6bQYO+6ufg
 b7fILMXT+2ZEfV9axHm2RLn+lOHK/qzZ0p3AEQu3jFTO4AwFD7m7mzdUjLPon4goAZ
 Q7YiDz28limioA32DAjSk0nedrqdbUYFzHLgu2OHA5Zq6xuLT4byqlabwO8VmiD4dQ
 k4Knv368YX6RQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68C451C3B00;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B08933F375A;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 51D6717EE9; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 087/122] s390x/sclp: prevent re-reading the sclp
 header
Date: Wed, 22 Jul 2026 15:45:36 +0300
Message-ID: <20260722124622.31034-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

We verify the sccb length and then allocate based on that length. The
following access re-reads the sccb again. This can race against other
vCPUs overwriting the length field.

sclp_service_call_protected does not need a change as the ultravisor
provides a consistent snapshot.

Fixes: c1db53a5910f ("s390/sclp: read sccb from mem based on provided length")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Message-ID: <20260709142906.197474-2-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 20701190e023216d0213a107a491402ce2cc501e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 3a7302f760c..ea5362771cf 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -333,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     /*
      * we want to work on a private copy of the sccb, to prevent guests
      * from playing dirty tricks by modifying the memory content after
-     * the host has checked the values
+     * the host has checked the values.
+     * Reuse the previously fetched header
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     ret = address_space_read(as, sccb, attrs,
@@ -341,6 +342,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (ret != MEMTX_OK) {
         return -PGM_ADDRESSING;
     }
+    work_sccb->h = header;
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-- 
2.47.3


