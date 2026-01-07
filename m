Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326EBCEFD1A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJn-0003vP-NR; Wed, 07 Jan 2026 07:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJe-0003tG-2N
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJV-00029S-V3
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5FUPAk7KBRGCLMsDuqEMMRS0cIW7/6U2fO5FVujIUo=;
 b=DuqCtukTdwTOyaFJzPb/WZ0RBrla2taeybRIj2bnrdeUr013JJPOutn+PcVcclc79rStlC
 ecTKyK7kOvVGI8y8h2nRhVRC4F6lh82UPoqe+zJ0fiWtkTUZu3KyvdDRvNvR0BdvVlDJnL
 f8noKz1QjBK3C5hd9g1QFIZOpPfmDio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-QSqqh49_PFCCs9bXWZMGug-1; Wed,
 07 Jan 2026 07:06:51 -0500
X-MC-Unique: QSqqh49_PFCCs9bXWZMGug-1
X-Mimecast-MFC-AGG-ID: QSqqh49_PFCCs9bXWZMGug_1767787610
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E6A719560B2; Wed,  7 Jan 2026 12:06:50 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 033D61956048; Wed,  7 Jan 2026 12:06:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/14] hw/s390x: Use explicit big-endian LD/ST API
Date: Wed,  7 Jan 2026 13:06:30 +0100
Message-ID: <20260107120638.56735-7-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The S390x architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/s390x/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/css.c          | 24 +++++++++++-------------
 hw/s390x/s390-pci-bus.c |  4 ++--
 hw/s390x/virtio-ccw.c   | 24 ++++++++++++------------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ccc9c1c243b..04ce3178a0b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1583,27 +1583,25 @@ static void css_update_chnmon(SubchDev *sch)
         /* Format 1, per-subchannel area. */
         uint32_t count;
 
-        count = address_space_ldl(&address_space_memory,
-                                  sch->curr_status.mba,
-                                  MEMTXATTRS_UNSPECIFIED,
-                                  NULL);
+        count = address_space_ldl_be(&address_space_memory,
+                                     sch->curr_status.mba,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
         count++;
-        address_space_stl(&address_space_memory, sch->curr_status.mba, count,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stl_be(&address_space_memory, sch->curr_status.mba, count,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     } else {
         /* Format 0, global area. */
         uint32_t offset;
         uint16_t count;
 
         offset = sch->curr_status.pmcw.mbi << 5;
-        count = address_space_lduw(&address_space_memory,
-                                   channel_subsys.chnmon_area + offset,
-                                   MEMTXATTRS_UNSPECIFIED,
-                                   NULL);
+        count = address_space_lduw_be(&address_space_memory,
+                                      channel_subsys.chnmon_area + offset,
+                                      MEMTXATTRS_UNSPECIFIED, NULL);
         count++;
-        address_space_stw(&address_space_memory,
-                          channel_subsys.chnmon_area + offset, count,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stw_be(&address_space_memory,
+                             channel_subsys.chnmon_area + offset, count,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     }
 }
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 30fdca1e8a6..b438d63c444 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -462,8 +462,8 @@ static uint64_t table_translate(S390IOTLBEntry *entry, uint64_t to, int8_t ett,
     uint16_t err = 0;
 
     tx = get_table_index(entry->iova, ett);
-    te = address_space_ldq(&address_space_memory, to + tx * sizeof(uint64_t),
-                           MEMTXATTRS_UNSPECIFIED, NULL);
+    te = address_space_ldq_be(&address_space_memory, to + tx * sizeof(uint64_t),
+                              MEMTXATTRS_UNSPECIFIED, NULL);
 
     if (!te) {
         err = ERR_EVENT_INVALTE;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b4011c4049d..6855e20d09e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -890,26 +890,26 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
             }
         } else {
             assert(vector < NR_CLASSIC_INDICATOR_BITS);
-            indicators = address_space_ldq(&address_space_memory,
-                                           dev->indicators->addr,
-                                           MEMTXATTRS_UNSPECIFIED,
-                                           NULL);
+            indicators = address_space_ldq_be(&address_space_memory,
+                                              dev->indicators->addr,
+                                              MEMTXATTRS_UNSPECIFIED,
+                                              NULL);
             indicators |= 1ULL << vector;
-            address_space_stq(&address_space_memory, dev->indicators->addr,
-                              indicators, MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_be(&address_space_memory, dev->indicators->addr,
+                                 indicators, MEMTXATTRS_UNSPECIFIED, NULL);
             css_conditional_io_interrupt(sch);
         }
     } else {
         if (!dev->indicators2) {
             return;
         }
-        indicators = address_space_ldq(&address_space_memory,
-                                       dev->indicators2->addr,
-                                       MEMTXATTRS_UNSPECIFIED,
-                                       NULL);
+        indicators = address_space_ldq_be(&address_space_memory,
+                                          dev->indicators2->addr,
+                                          MEMTXATTRS_UNSPECIFIED,
+                                          NULL);
         indicators |= 1ULL;
-        address_space_stq(&address_space_memory, dev->indicators2->addr,
-                          indicators, MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stq_be(&address_space_memory, dev->indicators2->addr,
+                             indicators, MEMTXATTRS_UNSPECIFIED, NULL);
         css_conditional_io_interrupt(sch);
     }
 }
-- 
2.52.0


