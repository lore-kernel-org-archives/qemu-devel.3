Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519AFCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9l-0000gK-PN; Sat, 09 May 2026 01:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9j-0000fU-Jt
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9h-0007HN-Q0
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plpHRHrl9ewbt9bmKWd1qyedvODHuUTpEffj852qVy0=;
 b=ZgY1KimS0QYJoMdyqCEgtZm07VTGC4zy9WpLcTZzhseITJANuO6EmfgyqA+sZqFrmOXP1H
 ndTjZp92VCuiljdd07p88eMnzsJhUTwvpX18TH1tw48z/SYahS2Gmcn8QWGWLIn7ZQcvJd
 lUqz0PR1wHqgXksuCnJSd2UrG68Au9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-CjJijHhsOnKVG_RCNvu73A-1; Sat, 09 May 2026 01:23:11 -0400
X-MC-Unique: CjJijHhsOnKVG_RCNvu73A-1
X-Mimecast-MFC-AGG-ID: CjJijHhsOnKVG_RCNvu73A_1778304190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488c0120047so16403255e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304189; x=1778908989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plpHRHrl9ewbt9bmKWd1qyedvODHuUTpEffj852qVy0=;
 b=FGORE3F2lqJqS2jSPKyiTMRSh7ozuyMwGl0cDIVOaiuoBnJ2WKz/1CsDCBXMB1EMU+
 5VqPevP8J4xfLlU91JYiz/P4FA6FHPcgxiuKkNSuHrTSqgouPHZ2rVBwg56c4sDqaB5G
 yn/Lap+VPBOcsJvmKpvU272e2J6+Y2a9tfkgGF7Uiu3h+DMzVoTbOqGGUw3EE9Fa8OkE
 KnnJdf19A6T7WMh/lvlkFimkam7Eyfh9XVF5hpo3nUJx/jYwMWmQ308xnJU9QNLTVfk0
 chqhOEZyM/Y2CxU7FSBELVAj4sqFooJTYk/5EyfLZf5pmfG+YpYAMewTbWvsvyW4sLpF
 TO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304189; x=1778908989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plpHRHrl9ewbt9bmKWd1qyedvODHuUTpEffj852qVy0=;
 b=Et4SdqWqG9FdhPNhs+pNdLr84xE2bb5qNNU5p2BmXjoLIYjrU5NoE5XQkiGAWzglT9
 fUZNYVYsJjU3DcA+psLAs9lBnbPXmRpK3rqEoQNjL9vRuDCFunYunyr8OKgeBmLwQDv/
 q6TVX4/zHd6+nMu+QvRnsdeKwW8Zi79FX3qmsex9SUCgh1bId6Q4rHcXDx5XOA7TYFu/
 g3wEXhWQHRvibLbIx9ux6kaXzhzqXcCzKxq4cER6k11KgK1Trjk2j4ZaLh4KAEGX3R9d
 C74fhIMPHI8e66yriWKHb//WoweNLS2MwrK8XFzS4M0eg05uuPBCgVhZFeoLBmcilCR1
 xYpg==
X-Gm-Message-State: AOJu0Ywtg2Xpvd+auDpqWf4oPcww/g+FXnuoJlMOjueWwfWVZb7A3Pgk
 HLaNqfm9J3JYO4+aQxX1oPDvlLw6EudQb1i0KNNsaYJzrtvQTkExwzWtrjBw6tYS5JzT1qY24bs
 qMjdzZpudTzFIkhB9epnd3hPLPcmKSHwA2CNPClveB4iLHtaJiowPfNI9WpJHmhAvVwCdmxGmrM
 KvAM9ZfowT/FBBHHP1me59RItpPbRBBSL++GVk5b2X
X-Gm-Gg: Acq92OE10/+epoQ61DymM3psPUjj0iIn4XztROLUypwXjcrko06pSy5Ry3/TAKn8RxZ
 +GvOz3ng2W2my6VFzzGoE5YP4nywMaa/EtFmhS3Uq1KywtvjVuMt5oAR1vhkWgzaBfWWpvD4p9R
 FS7vxrSUYvZA56ItP/JPuhmmJwy/PvU+M5qeq0pt5a9TGGK9Hf7n1qJ91j9smszjZeus5sXTk1L
 2/zPNMiY+PDr36jPjv60uh+LsTA+5kpsuUh57GuSFfE7tTTHu4J914uL2yglSTLym6muvbIs3fh
 DigpiPs/a34H+1jeb16qUj7x42OvTsQxIZ8hoacvh5uiYujQOAOkySOK31nsKEJkKJEIctGMfP3
 iux0a8Qvz6wf/9o2EYc7Ku46QLpIAHkwoCU71cnlufBdPeHWPMLHaGSG8iUVaXqCaofpKEUNlJO
 PO5Ik/I1yaoBAmTCRxip/MvdhWa9xA
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48e51e0a60fmr231291425e9.2.1778304189157; 
 Fri, 08 May 2026 22:23:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-48e51e0a60fmr231291145e9.2.1778304188648; 
 Fri, 08 May 2026 22:23:08 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e7040a9a9sm38603875e9.9.2026.05.08.22.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/5] scsi: change buf_size to unsigned int in scsi_SG_IO()
Date: Sat,  9 May 2026 07:23:00 +0200
Message-ID: <20260509052304.2159829-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

SG_IO supports an unsigned int dxfer_len value. Existing callers use
less than 256 bytes, so scsi_SG_IO()'s uint8_t buf_size type was
sufficient. The next patch will use a larger value, so update the type.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260415232906.212349-2-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/scsi/scsi.h | 3 ++-
 hw/scsi/scsi-generic.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a3e246dbd92..5f83e58d1d0 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -247,7 +247,8 @@ void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd, uint8_t cmd_size,
-               uint8_t *buf, uint8_t buf_size, uint32_t timeout, Error **errp);
+               uint8_t *buf, unsigned int buf_size, uint32_t timeout,
+               Error **errp);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a2316a5266e..e629b1756b0 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -774,7 +774,7 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
 }
 
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
-               uint8_t cmd_size, uint8_t *buf, uint8_t buf_size,
+               uint8_t cmd_size, uint8_t *buf, unsigned int buf_size,
                uint32_t timeout, Error **errp)
 {
     sg_io_hdr_t io_header;
-- 
2.54.0


