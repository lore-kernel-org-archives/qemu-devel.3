Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B63CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMHv-0003RA-QK; Wed, 27 May 2026 17:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7f592f8cdeeea8b91998363ad9599dfb1f2b3108@kylie.crudebyte.com>)
 id 1wSMHu-0003Qb-5H; Wed, 27 May 2026 17:59:42 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7f592f8cdeeea8b91998363ad9599dfb1f2b3108@kylie.crudebyte.com>)
 id 1wSMHr-0004C7-L6; Wed, 27 May 2026 17:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=NXO+pno9d5vJplIMrM3yQuKgvCZqdLjcNNpfrihShns=; b=fdFV2
 MPi4NTNBHVfayq+q+hqq1UPrhCKeCVPzHEghKcroEvjNK1Ft4hqNfyVMeNoE2C3Ce9XNbXPznmO+p
 xXfhzm0EvW5Rb7XM6Ex746fRjroVv61QUk5EkdEOH0HXRSJwXDbzC3LJCBlAjuxo0Xme4ahNxWYUc
 z318GyasI3hmMuiCQFJQ6VSh4IzGyxUxyjazVhi3KvJ3tHIybR784r/2txkvmkD6VmwezYFbFnpRw
 3GnI+dwA4X/6eFBEHpAzl4qQDB1cWCdkYJPiLygdMVE9jJhSVn5BcLdAPvN67MThWVVJZiB4lYZGT
 QuYdxHq/1zTKOIaphdzoQwydJWJR0NJ+RgkmoXucfsMRU3xdHS84hCUPQw1rwqmFLEkoUmP3xCGoB
 Eb5lHcK53ip4U2DDXVqvaYbWwu1PCcQuR2/xWKRpeXyPKVyM97xUFntalAs6VxjE2YdNmRIri1INb
 18zZbdFtEP5aDT7IJk9aTSrjbyqeL8/G3KX709Dud7FzUnIjVbNmjteOk6wrhs6Ekm9vL0ET4el8q
 bsTxf7+My3d6vVfsM6QlcJ+nujWyGkROPo0IOONjtCk/TiDfsEmoM4ELpN2eeaWnnShRdr+M6o53R
 fjc8sfWuZMyLxaQA6SqOg77UiuqfvLCy8aqYawavfaKW7iqyvjY5Q9YWOLikA4=;
Message-ID: <7f592f8cdeeea8b91998363ad9599dfb1f2b3108.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:25 +0200
Subject: [PATCH 3/8] 9pfs/xen: implement msize_limit callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7f592f8cdeeea8b91998363ad9599dfb1f2b3108@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add and implement the msize_limit callback for the Xen transport.

The limit is calculated using XEN_FLEX_RING_SIZE() based on the
negotiated ring_order. For the theoretical maximum ring_order of 9,
this results in a maximum 'msize' of 1048576 bytes (1 MiB).

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/xen-9p-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index ca0fff5fa9..94654022fe 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -250,12 +250,19 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
     qemu_bh_schedule(ring->bh);
 }
 
+static size_t xen_9p_msize_limit(V9fsState *s)
+{
+    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
+    return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
+}
+
 static const V9fsTransport xen_9p_transport = {
     .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
     .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
     .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
     .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
     .push_and_notify = xen_9pfs_push_and_notify,
+    .msize_limit = xen_9p_msize_limit,
 };
 
 static int xen_9pfs_init(struct XenLegacyDevice *xendev)
-- 
2.47.3


