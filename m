Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00D2C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylmw-00082r-Or; Tue, 25 Aug 2026 03:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wylmv-00082P-7Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wylmt-0004d8-RI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787643697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IOi70uux/BqULb7Vghr5NKB2A0Y3WbNrEV4lYYLSrMQ=;
 b=RYQd5gzOHR85v5sltNw2KNASHZZuYJHX5e9QR/uhb5jV5kIpv4FaxGoy1EiBo5+BerCNS2
 /OZIao6iNZe4OCF86Vtt1xcpTOEbU9iVsSrKZFUx5lV2H1wp0rTSOl2RGXrvsCwnC6Oo0P
 BugrrmxvHYGoHjkngC3Ht+0qFeSC4ns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-nVkoYhWiOkGUuZVsJRmzNA-1; Tue,
 25 Aug 2026 03:41:35 -0400
X-MC-Unique: nVkoYhWiOkGUuZVsJRmzNA-1
X-Mimecast-MFC-AGG-ID: nVkoYhWiOkGUuZVsJRmzNA_1787643694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B3FF187CC6F; Tue, 25 Aug 2026 07:41:34 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23288195608A; Tue, 25 Aug 2026 07:41:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/misc: fix trace-events
Date: Tue, 25 Aug 2026 11:41:14 +0400
Message-ID: <20260825074114.853069-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
trace events.

Fixes: 8041d1730871 ("tests/qtest: add test for K230 gsdma")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/trace-events | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 16db4ba0cc17..0b8be3d0f226 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -446,3 +446,9 @@ iommu_testdev_dma_armed(bool armed) "armed=%d"
 # k230_decomp_gzip.c
 k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
 k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
+
+# vmlaunchupdate.c
+launch_update_write(void) ""
+vmlaunch_reset_enter(void) ""
+vm_launchupdate_finalize(void) ""
+restore_host_x86_igvm(void) ""
-- 
2.55.0.543.g5ebe2ebe4ea8


