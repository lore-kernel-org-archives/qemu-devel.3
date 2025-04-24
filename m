Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE0C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rUc-0001J6-Ea; Thu, 24 Apr 2025 03:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7rUX-0001HB-NU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7rUU-0007XQ-Fo
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745481564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHfteXiEbJ/UnkcjEIKyYx7qjgvjyi/nDUEC2y7+Xz0=;
 b=HXVCOITwEEI1kUeohX2syUzZqwtC1u+xte8A7vfja/YToGSU8GpE1wdDQcAjxX5DCf5rfu
 hLE1XgOwkER5iZ2wXNXfHiGbYeOm0F2qEPmEYEytUmsYS0aZ4oZo4S6neXeDelkwNLFmZt
 IlsPb+YEvTdI33nlVGcnab0OTb9iF18=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-PvdjmhCyONymFaGdz77PZA-1; Thu,
 24 Apr 2025 03:59:21 -0400
X-MC-Unique: PvdjmhCyONymFaGdz77PZA-1
X-Mimecast-MFC-AGG-ID: PvdjmhCyONymFaGdz77PZA_1745481560
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0499019560AE; Thu, 24 Apr 2025 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F1EE180045B; Thu, 24 Apr 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F14C921E661A; Thu, 24 Apr 2025 09:59:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <cminyard@mvista.com>
Subject: [PULL 3/3] cleanup: Drop pointless label at end of function
Date: Thu, 24 Apr 2025 09:59:16 +0200
Message-ID: <20250424075916.1522767-4-armbru@redhat.com>
In-Reply-To: <20250424075916.1522767-1-armbru@redhat.com>
References: <20250424075916.1522767-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-ID: <20250407082643.2310002-4-armbru@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 4 +---
 hw/ipmi/ipmi_bmc_sim.c    | 7 ++-----
 hw/ipmi/ipmi_bt.c         | 7 +++----
 hw/ipmi/ipmi_kcs.c        | 3 +--
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 22cb9b590b..e563214390 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -213,7 +213,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         rsp[2] = err;
         ibe->waiting_rsp = false;
         k->handle_rsp(s, msg_id, rsp, 3);
-        goto out;
+        return;
     }
 
     addchar(ibe, msg_id);
@@ -228,8 +228,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
 
     /* Start the transmit */
     continue_send(ibe);
-
- out:
 }
 
 static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index c6a85e8cd1..41fe6835a7 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -465,13 +465,12 @@ void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log)
     }
 
     if (ibs->msg_flags & IPMI_BMC_MSG_FLAG_EVT_BUF_FULL) {
-        goto out;
+        return;
     }
 
     memcpy(ibs->evtbuf, evt, 16);
     ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
     k->set_atn(s, 1, attn_irq_enabled(ibs));
- out:
 }
 static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
                       uint8_t evd1, uint8_t evd2, uint8_t evd3)
@@ -996,7 +995,7 @@ static void get_msg(IPMIBmcSim *ibs,
 
     if (QTAILQ_EMPTY(&ibs->rcvbufs)) {
         rsp_buffer_set_error(rsp, 0x80); /* Queue empty */
-        goto out;
+        return;
     }
     rsp_buffer_push(rsp, 0); /* Channel 0 */
     msg = QTAILQ_FIRST(&ibs->rcvbufs);
@@ -1011,8 +1010,6 @@ static void get_msg(IPMIBmcSim *ibs,
         ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE;
         k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
     }
-
-out:
 }
 
 static unsigned char
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 5cf12c59a8..e01d02fe52 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -98,14 +98,14 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (ib->inlen < 4) {
-        goto out;
+        return;
     }
     /* Note that overruns are handled by handle_command */
     if (ib->inmsg[0] != (ib->inlen - 1)) {
         /* Length mismatch, just ignore. */
         IPMI_BT_SET_BBUSY(ib->control_reg, 1);
         ib->inlen = 0;
-        goto out;
+        return;
     }
     if ((ib->inmsg[1] == (IPMI_NETFN_APP << 2)) &&
                         (ib->inmsg[3] == IPMI_CMD_GET_BT_INTF_CAP)) {
@@ -136,7 +136,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
             IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
             ipmi_bt_raise_irq(ib);
         }
-        goto out;
+        return;
     }
     ib->waiting_seq = ib->inmsg[2];
     ib->inmsg[2] = ib->inmsg[1];
@@ -145,7 +145,6 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
         bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
                            sizeof(ib->inmsg), ib->waiting_rsp);
     }
- out:
 }
 
 static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index ae549fb864..d5cfe6c068 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -168,7 +168,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
             ik->outpos = 0;
             bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
                                ik->waiting_rsp);
-            goto out_noibf;
+            return;
         } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
             ik->cmd_reg = -1;
             ik->write_end = 1;
@@ -197,7 +197,6 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
     ik->cmd_reg = -1;
     ik->data_in_reg = -1;
     IPMI_KCS_SET_IBF(ik->status_reg, 0);
- out_noibf:
 }
 
 static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-- 
2.48.1


