Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13F7D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84K3-0000Is-C1; Mon, 04 Nov 2024 16:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K0-0008Sz-Ql
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jz-0005WO-7w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Qw3Qe8wV0ZOH6ROfQpES8yW2OtudwZHXLHI9Pq75U4=;
 b=cjW3YhJo4eMYJc8dhjFEeSxnYITevv6zkIid2w++6xNDT7t3VC1cOZdJpv2pV/RDJh3LFQ
 S4pHJ+f7FHFz3Xt0Q2oRxJ1IjDXHtv4k0PsYh2Ju1p9uTvXyAEGaH5fdS63BVYYYausly8
 +LGYwglQ6ouLntTmpqUtJwTrUZGV4F8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-lyK73HrcNHmClx3GtGYq0A-1; Mon, 04 Nov 2024 16:09:09 -0500
X-MC-Unique: lyK73HrcNHmClx3GtGYq0A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4cf04bcfso2340520f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754547; x=1731359347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Qw3Qe8wV0ZOH6ROfQpES8yW2OtudwZHXLHI9Pq75U4=;
 b=iibHN5/cfwrUMU6mnczy6VWdOXmDApVDOkOqOwxKm0A54q22tFpbmgOYK5tW5ozitA
 TBzidQklelrZmvaQr84sXSUnI/l8jF52jon7MutHI3U/qpKf23FM5CfY2SmQ/BiMKjzl
 zBjdZF825jr3em0HOxzbM5zhkei4FtDmlH/pQlqFJ4ZmCv3AGaTM92KxcpAjs1uM2rxq
 14RJOGA0Opp11ZmGucCCK52P8AXBFRb+9cLDMcG5HeRUREPFZnyQHJLUdj5RSU2wBs6S
 8+6smxJ2GPdHukaXuAehGd6BHaiX1me+jOEo/8Xt838b3H6woViyqv6fHaCMYHu0px5Y
 OjOg==
X-Gm-Message-State: AOJu0YwxM7gACGtTvPtDSifDJDGDNud5cXr37ELSBG3t3VX5ga0aoJZ9
 k68NjbQRzqZOBQJWqTZUd28gK9uIxG6VpFbTtb/UY9UwtKXeAt/yH3ES5tvbyWB3U0Ec0/v4mN7
 CcqKM9xLU0nZH2jFVus9OCkSbmeb7izam9vmAPMh2C5WXHS1nTPH2C/fWtPwr2gapPDKY9yI3Fb
 FkMCUiNGtLaZ1KVKbcDfAzutP2Isr8YQ==
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id
 ffacd0b85a97d-381c7a5e9d5mr10879861f8f.24.1730754547277; 
 Mon, 04 Nov 2024 13:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo6Rpo8Gsz0VvSJGu4BEwEmEsgBRwuTYZz22CLisHkg0ZRK6VwkjSrwpkk48lweqKCbpSQ2g==
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id
 ffacd0b85a97d-381c7a5e9d5mr10879838f8f.24.1730754546785; 
 Mon, 04 Nov 2024 13:09:06 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7392sm14121373f8f.55.2024.11.04.13.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:06 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 54/65] hw/cxl: Check that writes do not go beyond end of
 target attributes
Message-ID: <c1c4d6b38b13952b0a9e2d7393e1ccc70b2615a4.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In cmd_features_set_feature() the an offset + data size schemed
is used to allow for large features.  Ensure this does not write
beyond the end fo the buffers used to accumulate the full feature
attribute set.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a40d81219c..078782e8b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ps_set_feature = (void *)payload_in;
         ps_write_attrs = &ps_set_feature->feat_data;
+
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->patrol_scrub_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
                ps_write_attrs,
                bytes_to_copy);
@@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ecs_set_feature = (void *)payload_in;
         ecs_write_attrs = ecs_set_feature->feat_data;
+
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->ecs_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
-- 
MST


