Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9073DC36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVXM-0000R7-9t; Tue, 17 Sep 2024 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVx-0006BI-B7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVv-0006mz-6K
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UUhaiQXzIvprq7xcvOrSmnVdqtyNaGsgzXjK0jOJ0E=;
 b=AbeT4852xeXvoz+LNWs7+SAegqLS5REcYnMesTBPCX0NR1FPsl+VHjaAnREns0WQL+2LHx
 T0mESdTNL2bg6FXPMIbuCqHqAmWKnZQsuaAdgDgGgicfKCzBviCVb/XwyhADSgbezANTdR
 T/yEh4qimlWAyfYjYF/TlcfiYrkGSDA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-PLdSC4ZgOx6rnMj1CHMMEg-1; Tue,
 17 Sep 2024 06:32:51 -0400
X-MC-Unique: PLdSC4ZgOx6rnMj1CHMMEg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20A301955F43; Tue, 17 Sep 2024 10:32:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABE8819560AA; Tue, 17 Sep 2024 10:32:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PULL 8/8] vfio/igd: correctly calculate stolen memory size for gen 9
 and later
Date: Tue, 17 Sep 2024 12:32:29 +0200
Message-ID: <20240917103229.876515-9-clg@redhat.com>
In-Reply-To: <20240917103229.876515-1-clg@redhat.com>
References: <20240917103229.876515-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Corvin Köhne <corvin.koehne@gmail.com>

We have to update the calculation of the stolen memory size because
we've seen devices using values of 0xf0 and above for the graphics mode
select field. The new calculation was taken from the linux kernel [1].

[1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71af30450ba/arch/x86/kernel/early-quirks.c#L455-L460

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/igd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0751c43eae04aac5152c627af648319151ee1e39..a95d441f68661c23eee976be5d74b2da354f9498 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -488,11 +488,18 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
         gms = (gmch >> 8) & 0xff;
     }
 
-    if (gms > 0x10) {
-        error_report("Unsupported IGD GMS value 0x%x", gms);
-        return 0;
+    if (gen < 9) {
+        if (gms > 0x10) {
+            error_report("Unsupported IGD GMS value 0x%x", gms);
+            return 0;
+        }
+        return gms * 32;
+    } else {
+        if (gms < 0xf0)
+            return gms * 32;
+        else
+            return gms * 4 + 4;
     }
-    return gms * 32;
 }
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
-- 
2.46.0


