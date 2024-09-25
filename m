Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A86C369CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPxq-0003lS-7H; Wed, 25 Sep 2024 07:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwJ-0004ui-Lu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPwH-0003s6-Se
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JiBT728skRmdm88rj1Bi2KyJhTYibecJXAT1gwEUtJE=;
 b=SpwYuMJdxhOoQJKrmAMF7qqN9YN6GvbNyk1fwJ2YPzjJXlEbEv+ZDYEii2+h9ZbX3mb1AN
 oJwqR59WfBqMGbYBjMbVDGjfVz+oH+NW7wd2KSsGTlwofSA1G/ZWYngCBZBYWdPs733TRw
 Jh9/z1r5lkVgZkhqNPjzrLkWNrNGKJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-mGe3v-JZNtyMHyZc5yM9OA-1; Wed,
 25 Sep 2024 07:12:07 -0400
X-MC-Unique: mGe3v-JZNtyMHyZc5yM9OA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84593197701F; Wed, 25 Sep 2024 11:12:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F25E31956094; Wed, 25 Sep 2024 11:12:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 35/44] hw/net: remove return after g_assert_not_reached()
Date: Wed, 25 Sep 2024 13:10:16 +0200
Message-ID: <20240925111029.24082-36-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240919044641.386068-28-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/e1000e_core.c | 2 --
 hw/net/igb_core.c    | 2 --
 hw/net/vmxnet3.c     | 1 -
 3 files changed, 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 248381f976..2e4c50ddba 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -562,7 +562,6 @@ e1000e_rss_calc_hash(E1000ECore *core,
         break;
     default:
         g_assert_not_reached();
-        return 0;
     }
 
     return net_rx_pkt_calc_rss_hash(pkt, type, (uint8_t *) &core->mac[RSSRK]);
@@ -841,7 +840,6 @@ e1000e_ring_free_descr_num(E1000ECore *core, const E1000ERingInfo *r)
     }
 
     g_assert_not_reached();
-    return 0;
 }
 
 static inline bool
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 6be6140771..5dffa12c64 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -398,7 +398,6 @@ igb_rss_calc_hash(IGBCore *core, struct NetRxPkt *pkt, E1000E_RSSInfo *info)
         break;
     default:
         g_assert_not_reached();
-        return 0;
     }
 
     return net_rx_pkt_calc_rss_hash(pkt, type, (uint8_t *) &core->mac[RSSRK]);
@@ -747,7 +746,6 @@ igb_ring_free_descr_num(IGBCore *core, const E1000ERingInfo *r)
     }
 
     g_assert_not_reached();
-    return 0;
 }
 
 static inline bool
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index bb8583c7ab..8aa8c46228 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -456,7 +456,6 @@ vmxnet3_setup_tx_offloads(VMXNET3State *s)
 
     default:
         g_assert_not_reached();
-        return false;
     }
 
     return true;
-- 
2.46.0


