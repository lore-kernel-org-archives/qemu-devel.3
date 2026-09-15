Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C1C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qe3-0002fj-Q1; Tue, 15 Sep 2026 06:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Qe2-0002fb-Gm
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Qe0-0002pn-8G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pTZ1brC5Ck9O2OvmwzGurpwpkodMJ1+TN92PJ88VCAI=;
 b=I9d+xH0xc2Nhgy/RCklXCbOekUc1HMP/2qnNecqHZGJysAFnc5NC4J8eiwr/DMc4DTun93
 CrO3DOeMU3us1BlIVGRevmTdueetOdcoDf9Pydi+TqvKt4ipVVZYoJlywZlDPNyz9AMbIc
 YayEbwISny9RYe9vS1SyQufvmzB3Ogg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-3QBWYq4pPoix97kFmX9uRQ-1; Tue, 15 Sep 2026 06:44:04 -0400
X-MC-Unique: 3QBWYq4pPoix97kFmX9uRQ-1
X-Mimecast-MFC-AGG-ID: 3QBWYq4pPoix97kFmX9uRQ_1789469044
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e823c4868so1830625e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789469044; x=1790073844; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pTZ1brC5Ck9O2OvmwzGurpwpkodMJ1+TN92PJ88VCAI=;
 b=LC32/aah54YngaZbCUywpPYUE3fWZujGGZBuQn+no7wD6WG1Z8qIdRmy4RJQaNdpa+
 ZElksgVTK/OWYuXg2Zvyxcw4MLc0yLJYVAZIczc3CRCnpIaFGFkkSMDD4xSfV+rEC8N1
 IUEwExHguh+DZvqdOpr3kjaDulUGHbFEWMD6xHqYFbqQhJBVzEJ0HmaGPxc3chFsjk8D
 kIWtVVIplSk/PnuvVMHnw2Fd2ieJFalx5JO2EVDUCyKEGRfb7HWFjNiJPkqVcLy19kUL
 31SIzewljk5OpsQI49uiIKYB7KvqRHl3nQXa65VQ8nRu3m+1MzsBHyLDZsYCAlTXfVyM
 SuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469044; x=1790073844;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pTZ1brC5Ck9O2OvmwzGurpwpkodMJ1+TN92PJ88VCAI=;
 b=HL7/pWnyKdcC5Nr1AHXSAd5ZkxDKudw69Qn+aJv3y/iA16aqjokZxwySJhWLlZvXU1
 ACkJ7ltQI2V3wpYSI4zflAJxiRktF7FvDc0BW+qefRNr+xe9kH0rGmuAMQO3yRaTVj5d
 VJbw0VFCPxYfupnXdoJoVu5wNPrGnm+99ZDGQeFBzor9Aj6piNtTx2lI9UNKZ2ELYhta
 u8zyjazFknZyoKc1eRvJvLSx4ZV8EqMnrIt6IW7d6zhlY74ZCabQpvvhxukSFErMIXGz
 tNt46T4gNzG3dz9GCX/CQcIMK244AdNXm9olsvXfgC4nxEIQoR5PCjiCInUYBZpl49HL
 YKBQ==
X-Gm-Message-State: AFuF++nSUMKgwscbONmfnohXwxZqwyWyIKLvpW/ChSmVCN9Xxo7FFL/h
 yL7wT5z0JtfOTNDboasxgLJpG1Yk0DsDPUD1jgvYXsrlrFON4ijPUk6uxOJvqLse5V8uR+TceQ9
 wooBo8R3dZBR8PsDwtydzZKbFLin8A6MFD/xDW+ffVP9cq+NXYFWvvirOpwTTbbzrRpiwjCsyxy
 3XXicXb8yGGYdkM1OcJFp4rTRyDMPm/ROxgA==
X-Gm-Gg: AYBFou2DlGjP5gPU39c77/KM0ED+i2BQFD0uyIl+b+Pn8dqRnJXodwaIyslH1ChbZTh
 4EzfmWEd+Gx+ZPQaJT1JjQ3Uq06jVigdc/qSrjfEKRkt9Zl/VbyZpiSg6bA9UBXminSUv7jESv4
 DkZv5qjjdy1saLpD08Xyx69gkCm/igIGUZcyrmRWuLtanbuYDMA96RVE/21CGoTRGLITIp+5qBD
 m6amQNwCyAG25q4IYnpARWZYyXpQJLzdILRUoURm0HB4jNQrOuumTvrC+hueIuFQWaHZo3i+IKF
 qeVZ0lkOGOne6S+cN0Fta5aUOOgPp07TR+8LozUGT0zUmx3KUEpBWUgougfriRuc094fpFi0bbG
 QQjhQU5W2VrRPnfOZ67ufmU0=
X-Received: by 2002:a05:600c:5394:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49e7a68d7d5mr168299335e9.16.1789469043611; 
 Tue, 15 Sep 2026 03:44:03 -0700 (PDT)
X-Received: by 2002:a05:600c:5394:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49e7a68d7d5mr168298645e9.16.1789469043094; 
 Tue, 15 Sep 2026 03:44:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef8a7b1sm49801955e9.12.2026.09.15.03.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:44:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] vhost-user: fix SET_MEM_TABLE number of regions
Message-ID: <712e301bf7f815412fb264de8159cb3475bd237a.1789469028.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

vhost-user.rst says the legacy SET_MEM_TABLE contains 8 regions, but
this does not make sense - we have a num_regions field for this.
And it is not true in practice: if QEMU has less, it sends less.

The incorrect wording was introduced, without explanation, as
part of an editorial cleanup. Probably an oversight.

It's really "up to 8".

Fixes: 1958bb23b9 ("docs: fix vhost-user protocol doc")
Cc: luzhixing12345 <luzhixing12345@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index c1e02ff7e9..488214a306 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -248,7 +248,7 @@ Multiple Memory regions description
 
 :padding: 32-bit
 
-:regions: regions field contains 8 regions of type :ref:`Memory region description <memory_region_description>`.
+:regions: regions field contains up to 8 regions of type :ref:`Memory region description <memory_region_description>`.
 
 Log description
 ^^^^^^^^^^^^^^^
-- 
MST


