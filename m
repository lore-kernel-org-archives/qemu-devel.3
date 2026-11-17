Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9A606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.a=rsa-sha256 header.s=default header.b=WnUJO7U0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT8KG-0002q4-F6; Mon, 16 Nov 2026 20:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1xT8K6-0002pP-3p
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:49:26 -0500
Received: from [115.124.28.134] (helo=out28-134.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaochengbo@bosc.ac.cn>)
 id 1xT8Jz-0001uY-IS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosc.ac.cn; s=default;
 t=1794880023; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=h6ofA8JUec8qMFJVW6h5bRC1GcQsQ4BdCmXle6c4ShU=;
 b=WnUJO7U0J8rDfioW/9nKrJdX9rJDDkdE8N6jcUJUq+NOWQeFqdhOYdE1Hf8uze2p1yabnKHBaJ1zE0Iurtk6PXdjx4DVzL8twgaAtATQtv1q6bWN/vOemNcmgq3hHahSlGIeKJJrasIQtPGndaogyhQnP/8aPaa2Ebd7R1g/PT5WtznTe75aMpux5Myfu2fX+UosjaRlc1Neb5GKC8LuLa9vpMxQ2zVkDoLmYpoDoGu/dp8j8K9q516CkqRSfwAbJ/+kFjO319DYiv4CMKNEtqkcyAcsIBtMaC0tO2GLyvS+9iKiM1iOUsDotM9sSYFc4cXgTeE6zEeYt8Jzu073LA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07685246|-1;
 BR=01201311R451S51rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0171391-5.84713e-05-0.982802;
 FP=13178133005994650843|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033045166233; MF=gaochengbo@bosc.ac.cn; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.k3S66sB_1794879698; 
Received: from ubuntu-Precision-3680..(mailfrom:gaochengbo@bosc.ac.cn
 fp:SMTPD_---.k3S66sB_1794879698 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Nov 2026 09:41:44 +0800
From: Chengbo Gao <gaochengbo@bosc.ac.cn>
To: dmitry.fleytman@gmail.com
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, jasowangio@gmail.com, qemu-devel@nongnu.org,
 guoyaxing@bosc.ac.cn, wangran@bosc.ac.cn, majiuyue@bosc.ac.cn,
 Chengbo Gao <gaochengbo@bosc.ac.cn>
Subject: [PATCH v1] hw/net/e1000e: Account for current descriptor data when
 appending FCS
Date: Tue, 17 Nov 2026 09:41:28 +0800
Message-ID: <20261117014128.600675-1-gaochengbo@bosc.ac.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.134 (deferred)
Received-SPF: pass client-ip=115.124.28.134;
 envelope-from=gaochengbo@bosc.ac.cn; helo=out28-134.mail.aliyun.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FCS append condition checks desc_offset before it is updated with
the payload copied into the current descriptor. This causes FCS bytes
to be placed in a separate descriptor even when the current buffer has
enough space.

With KEEP_CRC enabled, the DPDK em non-scattered receive path subtracts
four bytes from the first descriptor's length, truncating a 98-byte
ICMP frame to 94 bytes.

Include desc_size in both the FCS append condition and the remaining
length calculation so that FCS is appended to the current descriptor
when space permits.

Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
---
 hw/net/e1000e_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index b87a9f167a..6a01481e22 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1601,7 +1601,8 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
             }
 
             if (rx_desc_buf_size &&
-                desc_offset >= size && desc_offset < total_size) {
+                desc_offset + desc_size >= size &&
+                desc_offset + desc_size < total_size) {
                 /*
                  * We are in the last 4 bytes corresponding to the FCS checksum.
                  * We only ever write zeroes here (unlike the hardware).
@@ -1609,7 +1610,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
                 static const uint32_t fcs_pad;
                 /* Amount of space for the trailing checksum */
                 size_t fcs_len = MIN(rx_desc_buf_size,
-                                     total_size - desc_offset);
+                                    total_size - (desc_offset + desc_size));
                 e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
                                                         (const char *)&fcs_pad,
                                                         fcs_len);
-- 
2.43.0


