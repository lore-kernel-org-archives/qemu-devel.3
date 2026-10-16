Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A271CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhCQ-0001Ds-8J; Fri, 16 Oct 2026 08:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCN-00019E-9N
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCK-0002qy-V9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792154288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKmKgMlZApsWKcc9hg4+3tc9ELpN6tg2AkDxth/Mr0Q=;
 b=MIqU8Am2nZeJ+k+yw2rE/ogRv5ae867oqsGqr96BbCsWQxCHmIEaoiLr/s1GzQmJ91CZP4
 MeYaULQg9yjqCqxkChNpbRFof6sdi9IKtomZ7UbAleFhR2mmPGnP5k6enQhWYtlADZvt8e
 3ywLFglyqllYBD7sskPsW8bBo9X8c6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-l8x4oIIxOPCG5OwN3Jp5xw-1; Fri, 16 Oct 2026 12:38:04 +0000
X-MC-Unique: l8x4oIIxOPCG5OwN3Jp5xw-1
X-Mimecast-MFC-AGG-ID: l8x4oIIxOPCG5OwN3Jp5xw_1792154284
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so594443f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792154283; x=1792759083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EKmKgMlZApsWKcc9hg4+3tc9ELpN6tg2AkDxth/Mr0Q=;
 b=RAob65rcruNgaobPbxHC64XffhM6hDyg4uZmMmDeWqCkqBxoLszqa0R8wj1OiGs6Yk
 3NXBavh0aq4suSdmJenENI3k2bi0rzk85NhuuMjJz7/2SrIVjHGAk7rDwKIcs/0/XXWa
 KndsIuYOoCAxjtRfqu3fblNrUw4AQrKJLWQWDL8/4v6TmdQvbJZHB5PZX8XqunwglZoO
 vEAaaI8G2Y9pKxei07qmqyeh4O7YgSZw8bOxBnq4u3qzXc4zjMC0QoSuuIMAvjlrt0Wp
 3T0M/c5ePkmmMbqpLK7lG/KBpHCSxYAtjp8Vb+6A+QU4t4v2M8pJO/DSza5gB08+waa4
 lRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154283; x=1792759083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKmKgMlZApsWKcc9hg4+3tc9ELpN6tg2AkDxth/Mr0Q=;
 b=DkkqvML3mtnfsKCmnhn1XsOT/OOW51WdSrp3x1xW7RhLDniAD4+40m8Ex0k77mgqKL
 i5Q6Uf1RK3YKHhMzvQhwk25o7loo3LO3QhdnwHrJE7z3WTXxr2BGBRBfR1echTCc6Ihe
 NjukK2zrUccNzjuobIlI3xkzYxuYvkebjw6qSoMo0ZyudnGd75sBc+5HCzoSFfVccT8u
 rqbhr+r3nYD1GhXU5/5ZiKuq7wQwch9R2al9sEuo17W5lF6DYgCvzK5JCOAu/dJrzBcB
 y5deAGBtUsmYvLB7v/d3zElSCNFUFPvbMMdGs3C3UbNvLJPHN6D4xNVNJHc/p3Agsf1f
 g0Sg==
X-Gm-Message-State: AFq9FYLs1nux/vrghi5p2vyAdDgjOvdQNb1OG+DyhPRoMWCiYFJ5tRcQ
 pomATu1xC5gWzb7bBzkIbona538T+iZkVYScsVhLiOOW90bxT7X2Nc63rjqflVLYegfGDFmNv33
 Ya48NTCjLR/ZquX49NlLVQoMbNXuXh3l1WYia/yCFDQLVCbDKEOHKg3gt+hqdHzNjbg6KiLAqlD
 QPYIjDz9N74ihMDxyIV58OEZFQvw6OK8KALf9w9iwU
X-Gm-Gg: AYBFou2dMIc2cA0WP14mrk7zGoD0IRddrafsQ/Phy3rAZF1lXXT2YBW+zxR3g+d4y4Z
 d6tXdwKJcA+HqayLoFKkMGW+7PF84uOStfJx0EvF5i88RGpHJ4iS0RxmxGHeSEKTt0jih5hJqP/
 /ZQMdEFNgKPvBPJ8WgFV66xtpSkagYff+KoWtSBjL+Oq2cNaSBOA96njqVgrFQDfHBdpQ6cV54N
 iEYOdjAAQ5HNTAI/hNYbuyt27a2SRxMFTlUUDHybNbjdnlE2S1+sHgdqRfvmPzF//rjPyr7nBdW
 iWI8VkGt8ndDwB5KGxg85XJLX2/OvyZoAcV3ALjKOypovhK3jLzkwl3PSPonfNT5UsZZB7f7Pfy
 L0q3ZzWwOq8TaiLZJUSaPURR8AN+coa3boDib94AZ99nVIv428XCVT7HY6HRasdHdhgkVZLi1Xw
 o7Bqq7gdNa5ylWgmtIbT+uWxpPMKsr12G6
X-Received: by 2002:a5d:64eb:0:b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-48dfae7f70emr7039054f8f.22.1792154283604; 
 Fri, 16 Oct 2026 05:38:03 -0700 (PDT)
X-Received: by 2002:a5d:64eb:0:b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-48dfae7f70emr7038998f8f.22.1792154283239; 
 Fri, 16 Oct 2026 05:38:03 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm4730097f8f.24.2026.10.16.05.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:38:02 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v3 1/3] block/vmdk: align stream optimized data grains on 512
 byte chunks
Date: Fri, 16 Oct 2026 14:37:48 +0200
Message-ID: <20261016123750.94769-2-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016123750.94769-1-sraymaek@redhat.com>
References: <20261016123750.94769-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For stream optimized disks the spec notes: "Each marker and its
associated block begin on a sector or 512‐byte boundary... There are
five types of markers: compressed grain markers,..." [^1]

This means that instead of aligning grains on their typical size (64K),
in stream optimized disks, grains should be aligned on 512 byte chunks.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c8..7ca030c5fe 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1730,16 +1730,25 @@ get_cluster_offset(BlockDriverState *bs, VmdkExtent *extent,
         cluster_sector = extent->next_cluster_sector;
         extent->next_cluster_sector += extent->cluster_sectors;
 
-        /* First of all we write grain itself, to avoid race condition
-         * that may to corrupt the image.
-         * This problem may occur because of insufficient space on host disk
-         * or inappropriate VM shutdown.
+        /*
+         * Stream optimized (compressed) extents do not have to be
+         * pre-allocated, as compressed writes always cover the whole
+         * cluster, and will align on 512 byte chunks.
          */
-        ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes,
-                                zeroed);
-        if (ret) {
-            return ret;
+        if (!extent->compressed) {
+            /*
+             * First of all we write grain itself, to avoid race condition
+             * that may to corrupt the image.
+             * This problem may occur because of insufficient space on host disk
+             * or inappropriate VM shutdown.
+             */
+            ret = get_whole_cluster(bs, extent,
+                                    cluster_sector * BDRV_SECTOR_SIZE,
+                                    offset, skip_start_bytes, skip_end_bytes,
+                                    zeroed);
+            if (ret) {
+                return ret;
+            }
         }
         if (m_data) {
             m_data->new_allocation = true;
-- 
2.55.0


