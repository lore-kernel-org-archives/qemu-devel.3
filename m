Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC402C88E54
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xB3-0006bK-Tn; Fri, 11 Sep 2026 05:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAj-0004ei-Ai
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAh-0008MO-QW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=LdeO+wk4RTpJo3/q3ggtPFtLjj/Ki5zW8ou+xfxofOrAPMGx4fDR9Tu0KYqLKg/kfyOGmI
 LF//HasPbN61Ve4UD1q0NZnHBe0s7YWMg4DmaJnLkDG1AR3tcQ2b/O56wDqTHBa0SeD6aG
 GF9KM8N1DanGRI5yVIHSI3ciz8DOXz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-KjsOjIxmPbC1nwHNeZ9l5A-1; Fri, 11 Sep 2026 05:03:46 -0400
X-MC-Unique: KjsOjIxmPbC1nwHNeZ9l5A-1
X-Mimecast-MFC-AGG-ID: KjsOjIxmPbC1nwHNeZ9l5A_1789117425
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso5386945e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117425; x=1789722225; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=R7iqxbSvIpiTpdOoNYCGRVvlErUgUWvFoA3R5ZFC68rGssHRPMlAQs1xhhq94PcZeG
 7lbuhLynP05Wt1MNkBxvxcfWFvUZcyIg8VUfTD6DE/pSz/l8sW41v2eTo0+wVQqAvaLP
 JaXn9uEMq3iRvy/UxWm5kHB6i36gb/q3ckFo0b+ftcNwHNaiMmEinV1j4SmAxUbHXyCb
 SsIFxgz9NpQnAYiSjikjHpPLrGL8yfAmkdY4D8eTZfYcZR4SNz/jXvfJ+fx8FYjCuZcH
 mLCQYVy+rn6HAxC5k3dsIPmEkY5TX35Q/LJedfGumz1orVeFmaSyQWdP3HDUd6YuVg71
 iNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117425; x=1789722225;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c093DEqy/fkrW/Lhh1nhHFo8QJoMiHWxFZZ8F2Ne0/E=;
 b=IfvyphmX3BZkyNrcOYpPkHpOG43mrsX8uaP1YM8jL/XlLf6S4GJzyI0LGg7xTwgUek
 6czJEzF/Too4VSB+eEaAq4Xf0Dx2mkId1H3cvKKuQ01lbQLGS2X+a8NgAII2vm17cScC
 PETgBBa6RTLENXjueSMiVT8YzpaZNszuBIsthLCSQUJIwKywLlz1Xafs3r63m7VTACNw
 uuhroOCGndqmEXlLBcXLl4e9vkKjIZgYLBGiannLD/ZVR1jlZIGLasbjTWhT/8thqXnx
 PdHFXis5ZZgtBXlEeaXJ3fZs7x536kV9H7QeMHoHQ8fBDkKZ8Wz3DqbEJvX+Gy1hjaD7
 FS2w==
X-Gm-Message-State: AFuF++n0S/97Jw0HcfljXhFYRDpZYoQ5HO3/NTzMUYwdROU19tSJBsvt
 GjQgkoJjkOHpb9f/EzOHMvLUozHbVrhI4lbxxp5V6A0JtEVGLVbsVrd5D6BftSraSQRz7shGym9
 /zJxPLWJFqW2XYKsnr1BEIbKw6P7Qp/x88+1nKAxevKH3kh+GIHOeKfZHLrcVgmd9H1ZXoddnCP
 BWuudaOOwQzCw8qs+LRZJZGZu7POPb+PgVUQ==
X-Gm-Gg: AYBFou3FDbQqBgH9M8o0FEhrJvO4/LPEFG7nipgOvz4cCuN9qH1hl6uD7kfnPA3Jqg/
 /BQ8W2B/hVX0HVlOHJfzPDIl3Dk1qFg+3ALr6iMJQDRxxxDwEVd3xRIWPF1hX7Ftnk1Tsb5upLn
 w9YpaNNHyOTC/t68rBcxCxqxuIXtzIjnoZHW/rXn3QbE5SsO7yecezDkR1rhJIJc9pUjOnZUphi
 rfKY9Oqu3dpNxSUZXfByBuT2jpR1VQ6TvNtI8H4S9DDlkbTC3vKnsWwnMREzcD41PJV7lP4cp+X
 bEBhtmbkUlOpOr7/1O200xcVnlVYdCWYQR1/Qt/zhjEZEdu4aj2yOkTeQbDQ8bHR7eQuHudbh7K
 z4W2qgGsfFB+wkEEZ9DBuK0I=
X-Received: by 2002:a05:600c:3d96:b0:49d:72d:9ba3 with SMTP id
 5b1f17b1804b1-49e619b5dddmr30878335e9.14.1789117424440; 
 Fri, 11 Sep 2026 02:03:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3d96:b0:49d:72d:9ba3 with SMTP id
 5b1f17b1804b1-49e619b5dddmr30877635e9.14.1789117423926; 
 Fri, 11 Sep 2026 02:03:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm29818345e9.4.2026.09.11.02.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:43 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PULL v2 61/75] pci: load a device's config inside one memory
 transaction
Message-ID: <c0aa1ba2193ac288f6710900b90ffb19c914d791.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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


