Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D52BC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lbL-0007RR-F4; Thu, 10 Sep 2026 16:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lEl-0000Nh-G6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lEU-0007Dv-VV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=gQlalLo5RoKDirYY8HWG1umvOutKoBgNHbOmlxHGJWR1xNHRJbisQ39kMYc2PEZ+ofI6KN
 YVR/DHUlAPBcOvdjILrg70AKmiznDnT0JRTQM4SJUvVhg1dxwS+PBMIFmnSjqS8GqZaMGa
 HwtxzjGlu9iBUAJJsdEigT3mN+WEQF8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-uSB1YJqHM7iiEfc8BB5xZw-1; Thu, 10 Sep 2026 16:15:14 -0400
X-MC-Unique: uSB1YJqHM7iiEfc8BB5xZw-1
X-Mimecast-MFC-AGG-ID: uSB1YJqHM7iiEfc8BB5xZw_1789071313
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4855e47d062so61590f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071313; x=1789676113; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=ISW4dHJ6f8FkGgqunxev/T7CrcqA2fA8mlEnVED3fbJ/t3MFRODhR1oEb1KhSyfQz1
 7Y48Sz+IaBYpgReFOX5BbXl7iaHTeCT9R1XWLt3+Iw1YwkM8ZPdA9UpkJ+cARR5ZWixS
 Cr1W8tEZb0lKvBhdFBFYM4YoiHGZ+dq4kbvuNySB0zJ0Z+8/BJw2kw+LpFW4sv/ohVY7
 tHbQXtVOCMgzIMxraGqx59CMPlpXwylTLDpkCOBeqQ1HsW91CLnG6DrcqckerMc1wbYj
 XSA55eJJkalrzPtJKRHOAgNeRTBvMbGyhb9oj9Uh9dY7CYUD/R0+9c5pE3ADT94uEPji
 BTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071313; x=1789676113;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=NdTuUjNk6JQeZjIuRB1vJonyM1dxiFO4wEAQ3HlrkJ57v7PeyFfvQ4yrIl0YS/Yr2e
 LztaqYeLF1WVxqCk7zQBpbPoAwsQwc5UnTSMoXByPNGJ+85MCqaIVfX3UofFuBD1vSOB
 HQkqec7BJ0WhAASMy42QqHE1d+yAL4AwI5G1IuOvyvUNcnKXW68YgOOhOFy4Y3moyZdY
 94swut6wN/xqyY6ijYKARUpwfxxAuv9WUd6nupFGUS3iQuC3K2YbZWB9P0egEdrbUnHM
 +68j+LE4KT5OU9LWdOKDSVc61I30IVV5Uxi/6Qmtoe9E4j7+6ToLk0vVg6RMLa6WBu9u
 zHHg==
X-Gm-Message-State: AFuF++lzfcjxlghLsSWIkg311+xB/xT21u02sDLq6J1u9zHxFRGY59O0
 erg60KBfjP7daXIanrI5/98iXJ8tyBUXqjGog++H/rAyUhWLnrfujibjmVqxTgQgg3B6PD/J+I2
 kviRo3dMVfDaFP0CAbmMbBXAVoCwHYCZYqFyXP3mpmwIpy/qOmuL5jxp2blhguKyitYqP6C70Nt
 7qF7qoKKHukeenE1tHVQeWl8uQ04UYJfWL/Q==
X-Gm-Gg: AYBFou2R0d1JUqjZEZBZkMEPqh3yFSa+vYAvod8PaNiAlMk37T2uwkvW6zHMdERtUfh
 fQ+lDWTk41yspFuAiJYVvFNT1sh8qEvCcc+T9tLCPRLClORJ+wh0nMPp3Z5BR2eeCvFav5dxsWI
 2kzpI5T0HYA6S1rFBBG4lFJfzy1YfbABAcSQzl7YiDlHyhJE475g1Prfp6X03GKO1OpnUIZiVlD
 rjDcDUa4NF5tFKnYqZ/xPQZg6Tm0sYwSsk1cTYMk4NzH/pAPeEsM2rnjRT0eTrAUVihamIspP2s
 ZMgfTQyam3f0rnz+JqfxiKtUIKoT1SrjmJpVST6wtMkZy6vmx6MsukxiA5v/4THtqBUnTioQP+m
 Tc+73b0PQjfJqCoMSf5S90pw=
X-Received: by 2002:a05:6000:608:b0:486:414:e3d5 with SMTP id
 ffacd0b85a97d-486eb2d9912mr779047f8f.8.1789071312933; 
 Thu, 10 Sep 2026 13:15:12 -0700 (PDT)
X-Received: by 2002:a05:6000:608:b0:486:414:e3d5 with SMTP id
 ffacd0b85a97d-486eb2d9912mr779006f8f.8.1789071312345; 
 Thu, 10 Sep 2026 13:15:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e74esm793113f8f.25.2026.09.10.13.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:40 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PULL 76/90] pci: load a device's config inside one memory transaction
Message-ID: <fbd92ad9a0028937ac5081efa2662eb2030ffa10.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: "Denis V. Lunev" <den@openvz.org>

Restoring config space remaps the BARs, updates the bridge windows when
the device is a bridge, and toggles the bus master region. Each of those
commits a transaction of its own, so one device costs several flatview
rebuilds where one would do, and the cost of a rebuild grows with the
number of regions in the machine.

Nothing between them touches an address space, so the three can share a
transaction. The saving scales with the number of PCI devices.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903184542.2629976-3-den@openvz.org>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 14c78e3c62..0efb4eb4bb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -840,6 +840,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
     }
     memcpy(s->config, config, size);
 
+    memory_region_transaction_begin();
+
     pci_update_mappings(s);
     if (IS_PCI_BRIDGE(s)) {
         pci_bridge_update_mappings(PCI_BRIDGE(s));
@@ -848,6 +850,8 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
     pci_set_master(s, pci_get_word(s->config + PCI_COMMAND)
                       & PCI_COMMAND_MASTER);
 
+    memory_region_transaction_commit();
+
     g_free(config);
     return 0;
 }
-- 
MST


