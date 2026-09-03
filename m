Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D10C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CRj-0006Nq-Np; Thu, 03 Sep 2026 14:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRg-0006Ms-UW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2CRb-0005jV-6z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:45:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48584dc164fso207559f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788461147; x=1789065947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UrbIZEyCzw4xzy+Cmj1PuqYkVIXKglAm7vgn5QsXkZ0=;
 b=GFB9L6Oovc1WYcOSXtn1+I4AEGmHD+ZcipCsRjWpMbzD4x6MdrORIktWc1Y4ZkXIeT
 4rGGgMopryG0uuK6DEtvCTMMNqjXXhHueiiZs7Ibw+T68wLXKxD9FsN96yN1FjeJVan3
 lsTB7jujeENTKxZfur7pfH7b6yGQLtR4oB5/QaQqhGOCdxlnxanzqP4FHxwANj6hKHQ5
 QubrPdXWZih+qx04oWjeP39haBBRZIpLVHC5CNzfDe8myUvMfkP6XWltJjQ94ZPviuKV
 fxQZ6emljIQ3ZvkMm+nSTDAjI779UvSMmbyW9yt1VACw7+7QEfR3s3Q1q9a8wMs97u4m
 jS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461147; x=1789065947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UrbIZEyCzw4xzy+Cmj1PuqYkVIXKglAm7vgn5QsXkZ0=;
 b=JLC+RB8CYl+UhkrABGxhpoSTQ2Ep9UU1w/+kJ+cNtn6JwtOGrFZ4+mEB8iZ3muJmqo
 RVSLUtK8gdC+oiUuknPgwluRCYLX0mRU4hZ+KniZMu8MNVnZrUd8D5Q71LVebabOKnOT
 d3kl8d/3X3bzJ/C+DGsWClocvZKI6qRgOWqBLFfScFqlKYnHRgOVVE2oenD2vqez8H6v
 KCKQIUBAMjrblEy7AY54lWeziAbR7wvVZJPWFCngSRaaAv4J0shvojbO7KgJh8pY3y+a
 XdGCwikPbw+vfB6X3KkbQYEeDpH5D/5S+/X+vRUzO/GOCAc6DjuaeAF0+vVs3+EaSMQ4
 FuFg==
X-Gm-Message-State: AFuF++knMTV5iUy82M3HG9t7gv+5omDaK0MKqnP2uat7j+/L6x2giWCn
 CrmUyaTBdi7hnU5TWAM8BtgzGE0lWG06P60UN9RF4wrHCCKybxmREtxGQ/vDNH8yHJuLMQImDIg
 Yn2vF
X-Gm-Gg: AYBFou28mG5kUFpW5SEtFcheKvuDaYPTlrhykmcPxUJu87jDHzb16mn4ROYmX0eIZug
 m9T1gFJqtDAMyFiC3vSDepG0iv1bEYHI1aRCEOU3JTMMFHtj+EGZ5qCWz4y4J/682PEBp7lSKQ2
 NswqWCyUiLhMqwbqaJHWc5Ilk8L/DfyVAUbTy3b7JAGklb9xMWvCGF1iI64RBcE/l1R1BZRr9Aq
 odWm0K6nX2ekFchc9FtRsmUcNo0lw4mCUAAI1FQDc7UKjQvVqNzFDziHiOp3MuSOxhTZzonRiKP
 wQc6sWduxMQKKgICIh+Wfdn5/OnD9QYBWVpR91GxzGS0hAq/XvpdQtuiI2WrUnZlfizw19RZ4kc
 xV3fWOZ1u/HZlAGnVZEeDCKWkl6HeQUaNhrHGkD2cNXNRseQz0RAhuqSfSGS8lwsCvtUWBOubqi
 KubWLRMA7bRo7bcg/r9neDxCV8geMkIWGpWY75Hw+AYIDuZ+H4xYf+2/tkn7G9ITeL4+A=
X-Received: by 2002:a05:6000:46c8:b0:485:847f:fd8b with SMTP id
 ffacd0b85a97d-48587091978mr1779561f8f.5.1788461147124; 
 Thu, 03 Sep 2026 11:45:47 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm395557f8f.13.2026.09.03.11.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:45:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 1/2] pci: batch BAR remapping into one memory transaction
Date: Thu,  3 Sep 2026 20:45:41 +0200
Message-ID: <20260903184542.2629976-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184542.2629976-1-den@openvz.org>
References: <20260903184542.2629976-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

pci_update_mappings() deletes and re-adds a subregion for each BAR
whose address changed, and both of those commit their own transaction,
so one BAR move costs two full flatview rebuilds.

Nothing between the delete and the add touches an address space, so
the walk can run inside a single transaction. pci_bridge_update_mappings()
already does this for the bridge windows.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
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
2.53.0


