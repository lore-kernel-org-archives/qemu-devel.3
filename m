Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ADFC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lsv-0003Zs-Rr; Thu, 10 Sep 2026 17:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lF1-0000Td-8n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lEu-00079c-F1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=E0Knp96H5ECHfEKEl/DKfMMSnXknYpoiv0hFDiVerIVigvznsiHP76/A+bAgWDMH6EGiza
 e22YD+XiU6wDKyiNQjfPZcyl2ySEAR2unPOgjmILcOB6IcyVC5EsaSkIUsM5kGc5yBy2pe
 2bQX51lyBB8h/CDz6JlBfvg4URc+M/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-SSBe9grrPPmrL0wtm6cZ5Q-1; Thu, 10 Sep 2026 16:14:39 -0400
X-MC-Unique: SSBe9grrPPmrL0wtm6cZ5Q-1
X-Mimecast-MFC-AGG-ID: SSBe9grrPPmrL0wtm6cZ5Q_1789071278
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994cf6cdb9so1579775e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071278; x=1789676078; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=r4ZtCwRyk0Jy/wAn+qNowFu4bDq4kHILiigEHEx5PlbvLjXWJU+O6HpD4sp13jQSCm
 wnv3lxs/j2odot4SlLpCGVSZed9qO794IO49qo2krs2vGq7z81mWyKCXGlEMeN54oRYY
 A/kASRU+gYnVpByz7t7xqT2JCy2xJNxKsFudWie7QZ1sqO3/MmJ14p7JlCb5qdlcEc78
 op6RPyz59xLF94di7Ca1+EbFl66I5AV7//GCJj/t3n45A9YBcW7qZxfXtAdg8OjG+tcf
 Oc5pyxvGmfcIkW8A3aggO1w3YhNVtK3YqUQbRp1O/wg3w8ACOeLup8Z17B14XOakYDaS
 jhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071278; x=1789676078;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=cQlfuQxv6EsXnq0VN9BCBJ6HEAih9wLv1BowASGjYzM58TiQk+VJ1Jx7wKmkv2jVeg
 +ncmykJtDDXJBtbGdWj6QxgafeBoohOzpFDY4kc0swz7j6KbHEs35YrZF/+7025OOwim
 VLK9hczVorMWrv2pEqOXU+B1b0ActOWHNk753B4ETo9vzjdSodG8dtZrnlhwqsTDSdXZ
 CM+TZtrySiUshdFrHMmyBOCwd+/FkQHBpku+J1NyYqA+ZL2fV+cERW4Be0jO+BAkP9/0
 Cdq6zjzw7xnqvI5eHI4VCc7BxWXlXDt4r0pIpxxw0XpUL2/UIN/jhFG0rMbqXX/kAuNd
 fVXA==
X-Gm-Message-State: AFuF++kyKZoA2gjcYe9h54XzHnAMwgym2ZQk1674jdo8GOc66EJIzj9b
 jwUrp6Sis3wFO15RV0J8rIGgVfiGvglRgxoeZajzxYrAalNNrBDxNCmX3cv1UqUT3Z5i8BBSD0/
 9QArN3nWuGe1NistAIuiarevHbxYYkKVyZqLM95rPW46JZdp+HxSYagv9CsRpWj4v8r0PgFsR0n
 bIWDsosc76AVfz3FZ9GyIwooQcu/fKYqO3OQ==
X-Gm-Gg: AYBFou0gMAb0BdCxPhP1JaBmdSvzTXoesI6K22hdJw8vzT/58x34WGti6Cbi8PcDyYb
 9KOzuG5RbBuC4CPmGrq2SpmSsABAqvWtb+XvMyzkgLvK4XySXHjm07DZKNxlk+1vFgJa997qDAB
 UoHDSR68Y+tOgfFsOyZ7Roih2HVwHSJtpCoy4Z7QWgF8QX01Z2NLAUZEB6nJTEAreBMINJUInKl
 bYyO6MRvJr8ODau4mfOUFBCO5DWebS4ua8J8OafHSsdTHYDcVv5YpaC1tQ6Ktx0xVh82rE7rpbW
 uM+Ab4QBF3CyhZELO663v6ocYgOsjGwInrRggCoUPFjKyNnaI5JQKL21YsXniwY3aLKPR/wJy6l
 wLsq8vqC8MVaJmCw3m/PczhU=
X-Received: by 2002:a05:600c:3ba2:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49e619881e3mr10082575e9.9.1789071278066; 
 Thu, 10 Sep 2026 13:14:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49e619881e3mr10082045e9.9.1789071277549; 
 Thu, 10 Sep 2026 13:14:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm6043655e9.1.2026.09.10.13.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PULL 75/90] pci: batch BAR remapping into one memory transaction
Message-ID: <bfe98905f8152d81eb3993c6756c3881dc9ab193.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

pci_update_mappings() deletes and re-adds a subregion for each BAR
whose address changed, and both of those commit their own transaction,
so one BAR move costs two full flatview rebuilds.

Nothing between the delete and the add touches an address space, so
the walk can run inside a single transaction. pci_bridge_update_mappings()
already does this for the bridge windows.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903184542.2629976-2-den@openvz.org>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c15f2b9f08..14c78e3c62 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1742,6 +1742,8 @@ static void pci_update_mappings(PCIDevice *d)
     int i;
     pcibus_t new_addr;
 
+    memory_region_transaction_begin();
+
     for(i = 0; i < PCI_NUM_REGIONS; i++) {
         r = &d->io_regions[i];
 
@@ -1778,6 +1780,8 @@ static void pci_update_mappings(PCIDevice *d)
     }
 
     pci_update_vga(d);
+
+    memory_region_transaction_commit();
 }
 
 int pci_irq_disabled(PCIDevice *d)
-- 
MST


