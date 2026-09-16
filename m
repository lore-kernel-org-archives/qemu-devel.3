Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD12C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kKB-00056X-3O; Wed, 16 Sep 2026 03:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kK9-00055f-GN; Wed, 16 Sep 2026 03:44:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kK7-00050y-67; Wed, 16 Sep 2026 03:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=WqzG8TiPC3fEAK89x5zr4kLKdh9Bk6lltBT/55ith4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rGGeZGdp9wEP021IbfqgezHxXJzr3mqW3X1FPUxlI17ngfM3WKEMmXm6aYB9JriMo
 L8EJrTvwYCodANGwtECVxW8VM0QugNUUUjHvLgYjtAYWntgcQ8PxQNa0iYLOCIYPD6
 LFtATMQe6hXk7uju8ap7hm+DznbKGlQs8++fxSM0IDxIkRMIAkAtt4v2DKNDxpyI4N
 EqOwd53g8ic+HgmK0JF7NIZzWUtl80ESe7QreGb4faSyPsSENAaZmdrZTCZWDYf+H5
 7XXxPZ5ACzQ+q3259giyt0OxNEJC70gJGFCzDchvqRiAoOVAqYDIERUaiF14J2Cl6H
 W1tFwxpnqlx0g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 59F5C1D559A;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DDBDB429B2F;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B9E8A5A6DF; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 15/49] s390x/sclp: pv: only copy the original SCCB
 buffer
Date: Wed, 16 Sep 2026 10:42:33 +0300
Message-ID: <20260916074346.671467-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
change the length field. For example read SCP info might write a new
length into the SCCB header. We must not use that new length for the
buffer copy, since the buffer was allocated with the original length.
Only the length field in the work SCCB is changed, to indicate the
"necessary" size. Using the new length reads past the allocation, so
tools like ASAN might detect a buffer overrun.

Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
and sanitizes the length field, so no qemu heap contents are exposed to
the guest and the non pv-path already has the same header.length.

Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260814125857.1729543-1-borntraeger@de.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit d7913fac774706a02faef0dc1c4c19df65a5a379)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index ea5362771cf..977b8f59078 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -291,7 +291,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
-                          be16_to_cpu(work_sccb->h.length));
+                          be16_to_cpu(header.length));
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.47.3


