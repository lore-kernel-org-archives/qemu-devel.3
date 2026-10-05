Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AE1CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDk3C-0006Rt-Cv; Mon, 05 Oct 2026 10:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDirL-00029o-Lg
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDirK-0006AD-6x
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791207361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E15ep+8Mtfj5Tb7dPyiBvDUKhD4d7eBcdIb5m4qBDrA=;
 b=cclK2L2jhAX/b6ax6nMLxurJIbpFzdwqc5xdnEV0Q3hPgkVpsYIfuVjvibA+HIoquayw/a
 bsav0XCk+n+5W+OEitNcWtMlrgSUrwz3tlU5JPTEfIqcqdkpgphoQ5vaa4bspNfvACxIgO
 x75oeBjRtH3kuZgQpanBGXEA84tkXyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-W5-Uc4nwOuKaMmEZUNnhPw-1; Mon, 05 Oct 2026 09:34:00 -0400
X-MC-Unique: W5-Uc4nwOuKaMmEZUNnhPw-1
X-Mimecast-MFC-AGG-ID: W5-Uc4nwOuKaMmEZUNnhPw_1791207239
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a17574b5easo4788635e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791207239; x=1791812039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E15ep+8Mtfj5Tb7dPyiBvDUKhD4d7eBcdIb5m4qBDrA=;
 b=gVjpQrM21eWi0+wHrjNSQBqs6d36HEMmWIQQB0PiHo9a4wENeKhxmt0Ua7CPMldNUh
 GgpuEx6OBl1TXS3XsFrCf/hW/tymcDGcfG9+HXhDAxAmgOghCFkH3ujnrPcecY1WQVpC
 oN/rp5US3GXQGS5EJzVdJdYLeaR0fO2g/FlIn6/sAB5ij22pzg+Y4+6/P2Q9RkBfOB0v
 z3PbOiR79Xdk+libwPP28zbKlrIY3iZLCEHvRDLoPKzcJLpoUeAF5wZrVCgjp0bPb7F6
 xhnohlPQ/dDMaSK/b1cYV12zxXg/0EYuM3Cf5A51OPoxRRxVjBVT3nf+Zt51ZTxeTFFF
 IR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791207239; x=1791812039;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E15ep+8Mtfj5Tb7dPyiBvDUKhD4d7eBcdIb5m4qBDrA=;
 b=jNFxHNV1KgBWkffvXutgJ4vXlDTD5xnbkaui3YEyyM2SCqoNcmW/dZtQyNQJ3uumZz
 dzG1Sm1oWf49/Kk825DbL+8rE2dDzRKsRnewo+UUX+eQp7MMPiTgAiewxNr5ga537qmr
 eCAHQ4vYAjwmkod7/KL1q1kEdqGSDDYUbtnaa194lHpK7iXoOs19i7/Z12k/CVdR0Hgp
 khwGaCNNTxWu5iXbGuiB0ibApACp1WnN2eGvLshlL6kBQ+H7fdixBG1JsEAWSy63kxZv
 eMSbbMVGEMvD2bdQC+UAGA3F4cLovyudLkYhK8t6wWiTp/VeLsAcJ06lTkTpEJjlPMmd
 nkEg==
X-Gm-Message-State: AFuF++kIn3OmyzGJJy0bM4htOKPnzSvXHftxBmHgQ8eQYu/OSUg/Yd5g
 36/bCrt5DCHQaUFEZbmCH6nz9qRsgzil6d0t9jMoT57cs3eWf/jWeaX7i2nErRc4IHbfz82FMG5
 dSRhVQOg8itvT5QhsJhQfdwO7OwePizgq0wSeUm3UBatJZWUfKqJtiRiAKWZKPWQH9LtXud28p9
 ftWpAuG5AEsrCxmEsfHGzJ7tOZFGsWQWUYpYWVsUMX
X-Gm-Gg: AYBFou1oQm55XsBbTKJX7D3PE76BHCsVaYvcAsGSMJ2i9vdwqTxOYFOqkDCy5ruvsXG
 0i4JkmyeP98N00YbLjrXN0IIdwvfCx0UyNRum1+L/iFlb7ZSF13PtlL7hNhXIZVQsd1fA+tc2pZ
 gouGlJIcxctuRXsKVXxhUugTLfj77nJkid5IFAUGJdxc6x3X6vq7LHXA79UNrYM2vZax7m5r0+5
 +F7VoGs/ZF5veXwDIqJRXAtZZRM7ZsGx4Q5HfRm+wS2cm/SLfclkLDqmPXRU/I8FZ3GFUqhi9ZA
 yIlC1QrmFGbMsX26RFavei1a+5/4y+Imecza7ABTeXOpFuZMwjp+63iS/+PXYK+NPotDdTTud+G
 kbd/dA4v1A66Z3nhFZlloyEUR8kRzxUoijyvu1gvgUb9hRSL01k8pdBPUGilzuyOIlAnrLmRRNH
 Hcd9nAbDhUZe5fDKq15KMNYP9jGmL7RLA/
X-Received: by 2002:a05:600c:4f06:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-4a1680b469dmr151904735e9.4.1791207239191; 
 Mon, 05 Oct 2026 06:33:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-4a1680b469dmr151902995e9.4.1791207237934; 
 Mon, 05 Oct 2026 06:33:57 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm279730405e9.0.2026.10.05.06.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:33:56 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH 1/3] block/vmdk: align stream optimized data grains on 512
 byte chunks
Date: Mon,  5 Oct 2026 15:33:14 +0200
Message-ID: <20261005133316.198087-1-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 10:52:16 -0400
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

According to the spec: "Each marker and its associated block begin on a
sector or 512‐byte boundary... There are five types of markers:
compressed grain markers,..." [^1]

This means that instead of aligning grains on their typical size (64K),
in stream optimized disks, grains should be aligned on 512 byte chunks.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c8..3cdca06fff 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1460,9 +1460,11 @@ get_whole_cluster(BlockDriverState *bs, VmdkExtent *extent,
     int64_t cluster_bytes;
     uint8_t *whole_grain;
     bool copy_from_backing;
+    BDRVVmdkState *s = bs->opaque;
 
     /* For COW, align request sector_num to cluster start */
-    cluster_bytes = extent->cluster_sectors << BDRV_SECTOR_BITS;
+    cluster_bytes = strcmp(s->create_type, "streamOptimized") == 0 ? SECTOR_SIZE
+      : extent->cluster_sectors << BDRV_SECTOR_BITS;
     offset = QEMU_ALIGN_DOWN(offset, cluster_bytes);
     whole_grain = qemu_blockalign(bs, cluster_bytes);
     copy_from_backing = bs->backing && !zeroed;
-- 
2.55.0


