Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C0AC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA97-0000pJ-8T; Fri, 11 Jul 2025 05:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8m-0000k3-A5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA8k-00073x-Cu
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pSu3CoNT0iMxPLfLo8zoxuE/uI04rY3P4g6LTMpEQM=;
 b=YHVgrh89qo8dWG8N3MIh5xg+gWwPnvSMJNf2oAdwJYUA4upMiXNcg+7OEV+UlEh//x9K+d
 WXgFE0TOakfFIOHhKYQ9NQIWjowesNK3NzyGJt2xcGHaaWtXPKFuQl8bNVglOrqQoQgiYj
 68hTwOFzvrTQCyuQQGlo7HPoAPSe4Ak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-x73Ktt7yOJGSDA6gllk-cA-1; Fri,
 11 Jul 2025 05:33:53 -0400
X-MC-Unique: x73Ktt7yOJGSDA6gllk-cA-1
X-Mimecast-MFC-AGG-ID: x73Ktt7yOJGSDA6gllk-cA_1752226432
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 981FF1800268; Fri, 11 Jul 2025 09:33:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBEBF19560A3; Fri, 11 Jul 2025 09:33:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PULL 03/15] hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in
 functions taking an ett
Date: Fri, 11 Jul 2025 11:33:28 +0200
Message-ID: <20250711093340.608485-4-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The s390-pci-bus.c code, Coverity complains about a possible overflow
because get_table_index() can return -1 if the ett value passed in is
not one of the three permitted ZPCI_ETT_PT, ZPCI_ETT_ST, ZPCI_ETT_RT,
but the caller in table_translate() doesn't check this and instead
uses the return value directly in a calculation of the guest address
to read from.

In fact this case cannot happen, because:
 * get_table_index() is called only from table_translate()
 * the only caller of table_translate() loops through the ett values
   in the order RT, ST, PT until table_translate() returns 0
 * table_translate() will return 0 for the error cases and when
   translate_iscomplete() returns true
 * translate_iscomplete() is always true for ZPCI_ETT_PT

So table_translate() is always called with a valid ett value.

Instead of having the various functions called from table_translate()
return a default or dummy value when the ett argument is out of range,
use g_assert_not_reached() to indicate that this is impossible.

Coverity: CID 1547609
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20250710161552.1287399-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e6aa44531f6..f87d2748b63 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -384,9 +384,9 @@ static uint64_t get_table_index(uint64_t iova, int8_t ett)
         return calc_sx(iova);
     case ZPCI_ETT_RT:
         return calc_rtx(iova);
+    default:
+        g_assert_not_reached();
     }
-
-    return -1;
 }
 
 static bool entry_isvalid(uint64_t entry, int8_t ett)
@@ -397,22 +397,24 @@ static bool entry_isvalid(uint64_t entry, int8_t ett)
     case ZPCI_ETT_ST:
     case ZPCI_ETT_RT:
         return rt_entry_isvalid(entry);
+    default:
+        g_assert_not_reached();
     }
-
-    return false;
 }
 
 /* Return true if address translation is done */
 static bool translate_iscomplete(uint64_t entry, int8_t ett)
 {
     switch (ett) {
-    case 0:
+    case ZPCI_ETT_ST:
         return (entry & ZPCI_TABLE_FC) ? true : false;
-    case 1:
+    case ZPCI_ETT_RT:
         return false;
+    case ZPCI_ETT_PT:
+        return true;
+    default:
+        g_assert_not_reached();
     }
-
-    return true;
 }
 
 static uint64_t get_frame_size(int8_t ett)
@@ -424,9 +426,9 @@ static uint64_t get_frame_size(int8_t ett)
         return 1ULL << 20;
     case ZPCI_ETT_RT:
         return 1ULL << 31;
+    default:
+        g_assert_not_reached();
     }
-
-    return 0;
 }
 
 static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
@@ -438,9 +440,9 @@ static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
         return get_st_pto(entry);
     case ZPCI_ETT_RT:
         return get_rt_sto(entry);
+    default:
+        g_assert_not_reached();
     }
-
-    return 0;
 }
 
 /**
-- 
2.50.0


