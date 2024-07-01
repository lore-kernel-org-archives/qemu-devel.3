Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB92C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 22:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOPlE-0005Vj-0Y; Mon, 01 Jul 2024 18:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPlC-0005VX-Mc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:34 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPlA-00032J-7D
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:34 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52caebc6137so2912202e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719873869; x=1720478669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf82CyGT2KHh8k/j9sWHzVKPUD8ck5NskBySCFiD0JQ=;
 b=ZwZYyXMuZJyECHZZQHJkyx+TxTRaLB3tyYswD4Zi9CS49hcYPMOiXieV1salitprpY
 9tT8lC1L1EtQAAKRrQvhPaPvihxDRxy+RSPnjIKWp0+JcC9OAZrmvjoUftFBGrdQzUHc
 +MulOrTo10rnVu+NuDy2a5a40Zq542pjk5gkrqeZI02Hi/M7B/TUd/ZTNtu99E64RPNZ
 YK8zuRCHtrY/QzPF8gfqNEtsBOO35A5WJIg92TL+fkclde0dW/zkfHqjhSFEJCZkuf6h
 g/1KZb8jdg57SalIDM6OG1EzlIrj417E0bASWi/aVUeHXC+VK3F7u3/ehj8zTBgQtO9+
 2OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719873869; x=1720478669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf82CyGT2KHh8k/j9sWHzVKPUD8ck5NskBySCFiD0JQ=;
 b=vsN6HpfpGGAw6Hu6Bnt1MNGyhwp/1zSsTEk+3Vm0utP7hv1FHk2/QGP+NxUAVsC/pf
 Ue5TyseydybnEkyPfotugXF/7dl2sLHvN8zE3pqVq2CjGNhAyuqD4ILghFHhZWSrZRVX
 ZTrxqGM9dmFpLyJHhYa4VoyfA4ovN9tjJavBsEfGytJhB/rT55W1vkVHubsKnkC6ytLp
 4tYN4UiR6zjUlEeyYjtCpqJXJhpjYOIeqY9AueeEJbllY+xZ2mCkeoWVprqoAyJ+I8Be
 1Ho9q4Nlo29X8Gce+fNqVXQ1oVaxsquy7A6G0XlodqIraFJdv2PLwDg4ilwEaVcSZXuX
 f2zQ==
X-Gm-Message-State: AOJu0YyiLyJeWTbVFG6h0cPOB1hA+usnYdmyq0Yt3odX6hmuUf3lEyYd
 aXom3ows5BHW27m+Hoek+JRIxL1/+Za1SLbNoCAsS6qPwU7XmW7At6hmBQWY
X-Google-Smtp-Source: AGHT+IHWKetgrLPhxdzv9x0e7HCZWLzAzA+Cb1d+CG0m2IxNg7Q00FAe96b6YrkGhExYpUzmQX4I4Q==
X-Received: by 2002:a05:6512:3b2c:b0:52e:7f16:96b6 with SMTP id
 2adb3069b0e04-52e82687e16mr4837805e87.37.1719873867477; 
 Mon, 01 Jul 2024 15:44:27 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab27b8csm1586825e87.139.2024.07.01.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 15:44:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PATCH v1 2/2] xen: mapcache: Fix unmapping of first entries in
 buckets
Date: Tue,  2 Jul 2024 00:44:21 +0200
Message-ID: <20240701224421.1432654-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This fixes the clobbering of the entry->next pointer when
unmapping the first entry in a bucket of a mapcache.

Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
Reported-by: Anthony PERARD <anthony.perard@vates.tech>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 5f23b0adbe..18ba7b1d8f 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         pentry->next = entry->next;
         g_free(entry);
     } else {
-        memset(entry, 0, sizeof *entry);
+        /*
+         * Invalidate mapping but keep entry->next pointing to the rest
+         * of the list.
+         *
+         * Note that lock is already zero here, otherwise we don't unmap.
+         */
+        entry->paddr_index = 0;
+        entry->vaddr_base = NULL;
+        entry->valid_mapping = NULL;
+        entry->flags = 0;
+        entry->size = 0;
     }
 }
 
-- 
2.43.0


