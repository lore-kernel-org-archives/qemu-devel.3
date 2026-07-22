Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F136C531C9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWRo-0002wt-4J; Wed, 22 Jul 2026 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQs-0002Xo-3h; Wed, 22 Jul 2026 08:52:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQp-0002Ob-OK; Wed, 22 Jul 2026 08:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=0XGVl2YA0qhTkdDUkLRvXBmhGpmQzcC6RBKE1kIU8VU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hKxgcd8+yrVCAoCB8zFGB8zzUZtWFLEVuC9xKZiYkfgq25ZpVdYE7re40I4YJgIHJ
 nhY2KL/lWxf7x/Ml2ZrsYvllTnDBunGSRyoSVaVnp3TYdeepCHQNTwFPKQvQF4THMd
 vQfDR0Tg+KcjjoH/oHfx3D/mCaO0QZfLflW4OSSjPSljUSfnaQRz4aFyk5hk/a8TJ1
 j3fXHRckPT2q7YjBsUqlHER60o3MMftCBv+8VlgaeyPDyk2GVFAqx4NtN0f68wfDpq
 XwhRpUZBGYC+3Wlyw2YkHpVJKl94xGzLIlGKxD/xOsmIv33UlOw6lsk1R2PhBedsT8
 bjTJ4GFJNSimQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0F0C1C3B38;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 060AC3F3788;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A9D4F17F45; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 091/127] s390x/sclpcpi: check event length field
 before reading from buffer
Date: Wed, 22 Jul 2026 15:48:16 +0300
Message-ID: <20260722124859.32371-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

A guest might send a too short SCCB with SCLP_EVENT_CTRL_PGM_ID. QEMU
would fill its data structures with garbage data. Check for the precise
length of the CBI data structure and reject otherwise.

Fixes: f345978f24be ("hw/s390x: add Control-Program Identification to QOM")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260709142906.197474-3-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 8a116a28535c34b001e68b52f85d6be3acb75350)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 68fc1b809bf..ec4bdf23509 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -97,6 +97,11 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
                                              ebh);
     SCLPEventCPI *e = SCLP_EVENT_CPI(event);
 
+    /* Caller checks sccb length, buffer header checking is our duty */
+    if (be16_to_cpu(evt_buf_hdr->length) != sizeof(ControlProgramIdMsg)) {
+        return SCLP_RC_INCONSISTENT_LENGTHS;
+    }
+
     ascii_put(e->system_type, (char *)cpim->data.system_type,
               sizeof(cpim->data.system_type));
     ascii_put(e->system_name, (char *)cpim->data.system_name,
-- 
2.47.3


