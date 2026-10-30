Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+wWwrVJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtvo-0007IH-Sp; Fri, 30 Oct 2026 17:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvm-0007HQ-Tn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMtvl-0007p4-9y
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793394872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1rRxT56qhWjBPKCUFfdn82LiE3Ywe2GVQ9EAzEVryw=;
 b=P+wWwrVJmOuRyj8qIgKSYXKjDKL0wJeYgcw8wyoIrGnWp8bocUTY1JvFDWfb4NcfjfnmHX
 u8y5ZBJt3zs9CO1gt0wN9mbYtOZAY2w/r73Q8kikiCZBGyPkd6mIJlcMh3ul2KB+RHWe0w
 qVzAyqyhYLyqtiAEGdcAAHEYuKumOrk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-MEwcWYJUPqCFsazLstud2g-1; Fri,
 30 Oct 2026 17:14:31 -0400
X-MC-Unique: MEwcWYJUPqCFsazLstud2g-1
X-Mimecast-MFC-AGG-ID: MEwcWYJUPqCFsazLstud2g_1793394870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 281FD19541B0; Fri, 30 Oct 2026 21:14:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0897618004D2; Fri, 30 Oct 2026 21:14:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 31 Oct 2026 01:14:08 +0400
Subject: [GIT PULL 05/10] migration: tolerate NULL ram_block in
 vmstate_unregister_ram()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261031-nohmp-next-v1-5-9a9fb205cf3f@redhat.com>
References: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
In-Reply-To: <20261031-nohmp-next-v1-0-9a9fb205cf3f@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=865;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QMl3NPN50HRk7T+xkN/CUGSRTrerSQFMJMxkd6bNROs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5QigeY6AbDUzCdyzslzRtoxsRDPRWclBQRcCl
 jKtnHKbhaWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauUIoAAKCRDa6OEJdZac
 5UmvD/4zJWvcwje4GRLyCJWuNRpO+FqZHEEwfYj0WfCDnSRaMLezmye/d4A3/Uhcx9Gth1pbceN
 EgTgUh0o6Qy0YKi07j1jqUMiBDQSIKZSZdpPyYes+XSyH+gwDjQPJxZDjxU+YClJvqaymrGBhW2
 oRdX1jFPPTJYQ/Qhpuy/BN3AjSDxgAWsRr0zEdvA02zgTS0muJcSqpCdUNgXnmpE+QhCBA7zQFy
 IUd/Rn4XDetB4V8/X+URzJ94RpNiaN4BQXxUOQsvP+cImbpVPEV/AI0yFUeq/hAy0vIe8qlbnCl
 xjLJB7kgAx9vtLIKajDVZ74bi98hyCi6nU7CjxfGxXCI4LNw2mvrahCVlrTGdpMQ1oAfpLN2gkE
 SECtd94CWBLpKKLTn3+ZRvTMnZpKxIclWt0lypIrbWm5drJ+qwmo5L229fVv/IkRv4MnBGlXtvu
 W+5+dNZ09/7KgmSbupC9bynLZbLOdpggzskHKu9472jQ4Cr2bTKPL0Mc2CppBaznzaLWYvqIiEO
 1IVWNpVShWrjwou26uBW0qbBg/ZCFsbVIYMaEd4HgE2snXMg393faqhBQlmYwa0O+me98DfJ3te
 8E4ZGKNY9N/hobDTn/CZZ43A21aUKt2dSERY7sZ3lDWWMy1tnJFZ7SLIWfNVb02b9p/m3+0KYVQ
 cQMXD9mExWa7qKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Treat a missing RAMBlock as nothing to unregister.
qemu_ram_unset_idstr() already accepts a NULL block.

Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/savevm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4b590ea672d2..fe94ba96e432 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3610,6 +3610,9 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
+    if (!mr->ram_block) {
+        return;
+    }
     qemu_ram_unset_idstr(mr->ram_block);
     qemu_ram_unset_migratable(mr->ram_block);
     ram_block_del_cpr_blocker(mr->ram_block);

-- 
2.56.0.116.g6de20f6092dc


