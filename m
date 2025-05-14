Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45917C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeL-0007B8-Bc; Wed, 14 May 2025 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdv-0006Pu-1h
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdp-0006Ly-9I
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VpE5v8x1WSNUUa3q9Dyat/dXaWkUdr2tXgzrQ6PW/w=;
 b=DEjqAODvt7vBUPMWJa7fYn4HsM6kdaWPkCRmvDz7QORNjNbgTgd097Hji+P1H/0rpKbvzk
 JRRp3wmssm0Fn88yZPLS4D7k2xQX3UH3KYNT1WhnCfcRoarubZbZCCS79nPNTDp8ZBbSAs
 jCdU89nx1ElJuueESQp9oyUMBlIRjyI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-xTCMgYiYPIKR5HYsF_zLZw-1; Wed, 14 May 2025 07:51:14 -0400
X-MC-Unique: xTCMgYiYPIKR5HYsF_zLZw-1
X-Mimecast-MFC-AGG-ID: xTCMgYiYPIKR5HYsF_zLZw_1747223473
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b2e56da1so2718690f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223473; x=1747828273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VpE5v8x1WSNUUa3q9Dyat/dXaWkUdr2tXgzrQ6PW/w=;
 b=qHX/jKIUeqzR+bY15H+vjCgwa5upwKlZy1VLJlTDsmgFlfWsS7Fjgg7Rjb3dsq8NgE
 Ub5qfRVOMrf+DcD7F48g5B5fmBS35o4jlgUs1ESsCpvUuGozzyRCZiLLf2+b65GtYJUr
 QgjOh3Awmaj2JZASDDUQVSMN8+A3GMf8vijRjXjOYJgrZGc8AZME1AqzqRBg1PQ9Q7H2
 XgE5N3M6CvZAQ4udX/AZUeH/xiT8cDk7IC0M93tirmsjCEdF3IRis2ZYrapJvY/L6EJ1
 Z4UGGMU7iq8COv/BZPVLQRlgI4vaCzX1OmxAuuWHM/uwt8ZzhdiruOQYvx404l8C+yLf
 s1mg==
X-Gm-Message-State: AOJu0YzntqsaLCqjGllVaeg2egiKKU2SyZgoVC881q4Z9ni6Jr3PM7RZ
 npNjIOVQAexy5SJjzXkghMwXNYfhr6zwxz0HIIw+b/pjNSJ6br0C9674lT/O62cF6dYSehceSU7
 gRBbusVOnhi11a2SaJw7X69apmrrwHgr+iY+qldbrLMHzmYHe9lSAefsgWqwwpEN4+0FKnK2t1P
 X7QiXJyGovSwRce/NE/vjPlUgaQHWgJQ==
X-Gm-Gg: ASbGnctf5GF5Ao+eRoeM0r6r0G5SjwDubOBGsAnjLxofE9W2Ajfl1txdXbBPbs8F5YI
 1LQjxIY9ycMpy4XhlsfGSo0Aw5qVr27lGIWzP0kKjUcrzhhwhPMZkgQfXEcXTuiLfk54hz/2/av
 HM7aMvagk0jzRkOncdgDOGf6P+t8QLEz6NkrvWEIm4t3wm3JycwroBVv8bLXba1arBKQL/E7NmT
 UxbiuDjvSK8kIcdiJ0e6jz0qZZU4WnTIW2KYg0qwIEmEPeHlcXo3D0SBg6d4md+pVSJ3nw1C5b9
 aHJmgA==
X-Received: by 2002:a05:6000:250d:b0:3a2:133:b17d with SMTP id
 ffacd0b85a97d-3a3496b8037mr2806757f8f.14.1747223472933; 
 Wed, 14 May 2025 04:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHMK6CNR+qN/CC8Ucqz6A1RFqXkZxY+7bWCEMqfng3/PthwwaXydgehbqN/ZCFis/YsPonEg==
X-Received: by 2002:a05:6000:250d:b0:3a2:133:b17d with SMTP id
 ffacd0b85a97d-3a3496b8037mr2806725f8f.14.1747223472462; 
 Wed, 14 May 2025 04:51:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf43sm19497814f8f.70.2025.05.14.04.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:12 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 21/27] vhost-scsi: support VIRTIO_SCSI_F_HOTPLUG
Message-ID: <1a5a2629eab94297a37e4adcc5fb69beb7bb0b0c.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongli Zhang <dongli.zhang@oracle.com>

So far there isn't way to test host kernel vhost-scsi event queue path,
because VIRTIO_SCSI_F_HOTPLUG isn't supported by QEMU.

virtio-scsi.c and vhost-user-scsi.c already support VIRTIO_SCSI_F_HOTPLUG
as property "hotplug".

Add support to vhost-scsi.c to help evaluate and test event queue.

To test the feature:

1. Create vhost-scsi target with targetcli.

targetcli /backstores/fileio create name=storage file_or_dev=disk01.raw
targetcli /vhost create naa.1123451234512345
targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage

2. Create QEMU instance with vhost-scsi.

-device vhost-scsi-pci,wwpn=naa.1123451234512345,hotplug=true

3. Once guest bootup, hotplug a new LUN from host.

targetcli /backstores/fileio create name=storage02 file_or_dev=disk02.raw
targetcli /vhost/naa.1123451234512345/tpg1/luns create /backstores/fileio/storage02

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Message-Id: <20250203005215.1502-1-dongli.zhang@oracle.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/scsi/vhost-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index dd4250ebe8..cdf405b0f8 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -359,6 +359,9 @@ static const Property vhost_scsi_properties[] = {
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
+    DEFINE_PROP_BIT64("hotplug", VHostSCSICommon, host_features,
+                                                  VIRTIO_SCSI_F_HOTPLUG,
+                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
     DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
                      conf.worker_per_virtqueue, false),
-- 
MST


