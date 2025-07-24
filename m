Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3939C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevYB-0006j6-6a; Thu, 24 Jul 2025 08:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevY2-0006g4-1k
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevXz-0005wr-Ma
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753361982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iCS8UqUg7FhiKGH5FvzdZsjofDEB5Ctcx+kS5W67EY=;
 b=KX88THbv3TuVSsl8Gc15Wxlcw8Qqy+LetvITuC5wl1o5Dr3tUP0Q9bo8QceC7c2+AZsku3
 Q0/YfQbL/Lp2UaYogvf9RF2WIs4PZvA6byseWtsRoRVUgCaXMhd07bXSlb1jzdv3ybFg43
 XPoziSD8wWVYoGQjF73HUNtYWdE+mK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ENMRJWujOOq0yOyarpUm3g-1; Thu, 24 Jul 2025 08:59:41 -0400
X-MC-Unique: ENMRJWujOOq0yOyarpUm3g-1
X-Mimecast-MFC-AGG-ID: ENMRJWujOOq0yOyarpUm3g_1753361979
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so512829f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361978; x=1753966778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iCS8UqUg7FhiKGH5FvzdZsjofDEB5Ctcx+kS5W67EY=;
 b=bsOIyNO601/1IahxWoRGclrJEtVETFSh8Kf8cXtZPO2GyVHWvZEqYYTQZDr3dogcb4
 uLjxltAQDU4TcmYFOarxBeinRg46sWm//FiZyNqjWXStEOSynyuVk03XvOW5DvjP4H80
 4Fk/oZEyr7awMw43BmMw7QT1SDPrJc5BnHFYp+CbWRPKEmuFvg0lkxV4iDbozN6u27Of
 4xqDn0U1rFRf5Ebd5gCJHAcSYE1jPIT6MPxeTxE312qt0VAiiLTa+GD/WONf0MjR2Y2B
 sD8raoo9qeskLfrEW1w8FJiVCecMV11qdMyEL+lmHuib9DCMa1eYkvoN37ncdVa2kG2N
 OYgw==
X-Gm-Message-State: AOJu0Yx5BBzGoASfXOi7MI8M30PpERMxiDRGAbVj3uShpd8U3JJAzW20
 2BO0c1ZfPx+PcBu6AVQd8i0DitOmfgG+8hZheusmAUVRQtb/L4SGnAbDybfdrtxJhCU2SuE6BCD
 xDa0xJSw39iIofF7kJToDCL8VFp334ekmJKU0iO/pKaFe/X1exsbPRt0b9jX7ZK25zGItJROZTE
 J3weaWrLi1lDfLNpZ9sqrDIzpIa1wfKdJHCcmtnQ==
X-Gm-Gg: ASbGnctBOWVbkSxddbn3ceUuQcLdz2XrcgQNPvrIIIx0DRjUGRpmXZ2fJf6+ugjswEo
 M8IUkbms8QCDGaO8gW+4vc4OzK6jtAbFl6uqMTy/iCuJEB2XpPNreW1A32OhDK6Nh2SN3OD1wmu
 OH9U91zB8Vnys8gSRgmkqnGImZwTUryRs9ZhOUKg9UVSk9cSt4GIms1I2OrV/zARzIdfb63Izwp
 /EpLlIk+JwVGri8upFpWeGcvb0Sbk3kOawdp24b99zF/C1rCd87yCR11qG1OV/s3m4tJp6VDPHB
 KivOa8fDqWccGKmCD/44/nTMoZ4GIBxIdn6+IYxa535x5/euMevNx0RFcqHJ+ZVpl/0QkR3G96J
 L+4SLO3ONFe1xaMlNi+QpZw==
X-Received: by 2002:a05:6000:40db:b0:3b5:f93a:bcc with SMTP id
 ffacd0b85a97d-3b768ef9668mr7402162f8f.35.1753361978029; 
 Thu, 24 Jul 2025 05:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04iMQefOw7lpSeVNJxyYMP4QA6KNktgA7p7coh4c+Tfy9AeVNfh5uHgO7SMkLogoPKhiyLQ==
X-Received: by 2002:a05:6000:40db:b0:3b5:f93a:bcc with SMTP id
 ffacd0b85a97d-3b768ef9668mr7402132f8f.35.1753361977549; 
 Thu, 24 Jul 2025 05:59:37 -0700 (PDT)
Received: from localhost
 (p200300cfd706376dff28b03aa15f3cdf.dip0.t-ipconnect.de.
 [2003:cf:d706:376d:ff28:b03a:a15f:3cdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532af4sm20019985e9.4.2025.07.24.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:59:35 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] vhost: Do not abort on log-start error
Date: Thu, 24 Jul 2025 14:59:27 +0200
Message-ID: <20250724125928.61045-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724125928.61045-1-hreitz@redhat.com>
References: <20250724125928.61045-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
handler") enabled vhost_log_global_start() to return a proper error, but
did not change it to do so; instead, it still aborts the whole process
on error.

This crash can be reproduced by e.g. killing a virtiofsd daemon before
initiating migration.  In such a case, qemu should not crash, but just
make the attempted migration fail.

Buglink: https://issues.redhat.com/browse/RHEL-94534
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c30ea1156e..05ad5de629 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1110,7 +1110,8 @@ static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
 
     r = vhost_migration_log(listener, true);
     if (r < 0) {
-        abort();
+        error_setg_errno(errp, -r, "vhost: Failed to start logging");
+        return false;
     }
     return true;
 }
-- 
2.50.1


