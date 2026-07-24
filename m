Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBACC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFke-0002s3-Co; Fri, 24 Jul 2026 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFkX-0002gJ-DF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFkV-0004WI-0C
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZuySbtyKrFtxDwSCUtULESYPTcIpzGd0ANSqVmD+qiE=;
 b=E1Zabe6TsOYM/amSis3k1VEUmzsXi9TIHLFRcBZQJFfqX/78XtvDlVQNP4DKDr47pvMHas
 2QGYmqd7Pdn9HgKFl9+8Oe+cSLWCoYHP+p4Yff3gh9TiL6PKXNScdZa0Hfq6ldbUJ5nhi/
 zzXI20BPjf38bsl4oZRHevHz0YHtgjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-IfnPpJA4MJmuoUYJWXL2Mw-1; Fri, 24 Jul 2026 09:15:32 -0400
X-MC-Unique: IfnPpJA4MJmuoUYJWXL2Mw-1
X-Mimecast-MFC-AGG-ID: IfnPpJA4MJmuoUYJWXL2Mw_1784898931
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954fe32d6eso2735865e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898931; x=1785503731; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZuySbtyKrFtxDwSCUtULESYPTcIpzGd0ANSqVmD+qiE=;
 b=JJnRuj6GR+RkhvbeMN7XUxKCqTAiaatBYRRhALZwDizf4u/iR8dO9j7ru7BgoHtHJW
 PNAMBi4qya6aF3d0ZpAShoSG2Q4tHJiACoegIr1451uyu/o1wKiXAFfQzFO4gkxhE+4x
 VeIWxE5KmtPQpAvEEoH/yf86U4CgB+RlIpEdshJRvjkV4hdGFebvP1SqiFZJGddOawvl
 vdUgy2kehkV/K163wrOC3A/l5XyQE08fGhmLVovLZBdgbe2HKrT5wYrwZFhlfmRynaxV
 0l+cZUrQaEHfgy9iiP6hd/Mh6kWRuAxxRJ0gpUash4XwxDvvmimExgoGg5YhP1QOBUtm
 TdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898931; x=1785503731;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuySbtyKrFtxDwSCUtULESYPTcIpzGd0ANSqVmD+qiE=;
 b=A4VDfXugeMorR1Kc39fnE/BU271ZHuYKF4FVg2kcC80mK7zfw58gIrNMaZi5efdoij
 NL7IuLnXXZyKl0nphbwGqeOjfG/ncivjGk45gIs7UI94/HCmaTtlIYGW9lQXBX9od7Ky
 nfCFTtXWWneG/gm6+pn0V26sCWGU579awmUxP7y/mmJV2KHBsx95QE38EZBAA4C4qVe0
 WeAH+2mgEpFE2swATuesbvsawB+Oc/7/SxA5CpB8JXRKGpT5JiHVKAVBXYYXOFT/HFTm
 1ZJpDJNo7UtkOaWY794kfhQ0RRYQFj2e1JxdfRdk47NrkVkW/OxC8b4jS1Ez/RjSO6IP
 Dwwg==
X-Gm-Message-State: AOJu0Yxldyz5BPAME906d2tqaxcb67A/CUlpTReu3T64QYdWvvdReUa2
 R9HKSBbMf5CpYbYXbhDZD/s28kO6CQzh0PCcp8yFTW+dYQzUyEYl5ASHhvSV+GP8l1dbbZJGM1K
 oktuCbGX9pikegd3hlwIaoAq5WDbigRjch0tA9rmHJry7qRftlQ0dERdLQJIoX2Af06YCxVdJOY
 nsyUScl8h1rAuoQtsjuho5SFzCvSZM0yVf6A==
X-Gm-Gg: AR+sD133z7pbiy11DjtsPFKuBhcgyL4gJCzdQRyq7uj7ksrFbL9fU8XOVczLADmgiAF
 5X0UC+nxW28M0vdvpyVmV8szavZnsMHqK5SrOSQCuSJ3cGkSXxbJeJNIUweefN8NWtacbqEGIX4
 4+6qiOAiL7/hOAbvXAtZRArsE/OL6ryuZGb28NJULNy29PLByozWFpgTy/cdwwVZ/Xhs4dBH5n4
 J9HbcVbztIRM83dkD88AiF3d8tOG1HUXCEls9CnvJ1CWS+eEXYbAns5/GKR22ttkq7Xv+n5pKYe
 ci04ufusdygk9GmUAfrMof7KCqg178WZONOXN51z6Pemnm4ax2NFl/w0KXqhuTvNO+hFsF5tcvE
 pcpkyF+d+NEwyl567kMqQkA==
X-Received: by 2002:a05:600c:1c28:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-49573cc2f2cmr86181615e9.8.1784898930998; 
 Fri, 24 Jul 2026 06:15:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c28:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-49573cc2f2cmr86180925e9.8.1784898930274; 
 Fri, 24 Jul 2026 06:15:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9928fdsm30584525e9.1.2026.07.24.06.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:15:29 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:15:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] virtio: fail early on bad config_len in migration
Message-ID: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_load() attempts to load config_len bytes from the migration
stream. If that's huge (e.g. 4g) this will uselessly spin
beyond the end of the stream for seconds. Not nice.
Check qemu_file_get_error() and bail out early, instead.

Also note that config_len is int32_t but is coerced to unsigned when
used. Switch it to uint32_t to make this clearer.

Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8add4d5d99..72d828d33f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3516,7 +3516,7 @@ int coroutine_mixed_fn
 virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
-    int32_t config_len;
+    uint32_t config_len;
     uint32_t num;
     uint32_t features;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3564,6 +3564,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
 
     while (config_len > vdev->config_len) {
+        if (qemu_file_get_error(f)) {
+            return -1;
+        }
         qemu_get_byte(f);
         config_len--;
     }
-- 
MST


