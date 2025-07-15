Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0235C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublY0-00016l-JF; Tue, 15 Jul 2025 15:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwu-00043Y-VZ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkws-0001La-VD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxPwS5k1fgHunb7JjvPEMs/scwHUrbhiJcxBC3V/Kcw=;
 b=dw3dCIkzUz+K0l/SyvsLY8iDEjRwTPZm/UBKaXeUxNdWA0hN3x3eZnVsgBPu+rT22toQ9L
 nz82EwDIguI2nBoOu/ghVniO2V5rIE3uG5oGFgL4MX4xoReBsEXiyo3w7aD7UEnR2w2IIn
 aoTP1E6AR7EON5q77zQ63TbfZ5r1fzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-bCGQO3ogOEK2kg7QdbKvzw-1; Tue,
 15 Jul 2025 15:04:14 -0400
X-MC-Unique: bCGQO3ogOEK2kg7QdbKvzw-1
X-Mimecast-MFC-AGG-ID: bCGQO3ogOEK2kg7QdbKvzw_1752606253
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8BCF18002A9; Tue, 15 Jul 2025 19:04:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FDE4197702C; Tue, 15 Jul 2025 19:04:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/57] block-backend: mark blk_io_limits_disable() as
 GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:50 +0200
Message-ID: <20250715190330.378764-18-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

The function blk_io_limits_disable() calls bdrv_drained_begin(), which
must be called with the graph unlocked.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-40-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/block-backend-global-state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index f6ec1174e6..c3849640df 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -109,7 +109,7 @@ int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz);
 int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
 
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
-void blk_io_limits_disable(BlockBackend *blk);
+void GRAPH_UNLOCKED blk_io_limits_disable(BlockBackend *blk);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 void blk_set_force_allow_inactivate(BlockBackend *blk);
-- 
2.50.1


