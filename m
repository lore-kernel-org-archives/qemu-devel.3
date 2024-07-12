Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C2EC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSE36-0000NK-FB; Fri, 12 Jul 2024 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE31-00007v-Vm
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:44 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2z-0003b2-AB
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:43 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52e99060b41so1982023e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720782159; x=1721386959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87DPAAbyBmLAKm4ynt726DGnnWSE+Fbpy4sTffFQKUw=;
 b=HqEhfnTAquJF3CqI5KBIEdJRWEv7wLgZI2pP2jfoIoef9AcQTyTxNExmzjjBYCFExM
 JyJbovX09wdxbtlswPaWm8ulSqh3Q2LsahaJs0AzS3WvLlId+7cbLY0xoG6eL+u1uQxw
 B5k9gvjLDP+s1bW8vgbdBTtOEkuPqPpGKAtMwtwJ6ozqpUmHhjAwt+ntXeI5lfzk3FQz
 ALO5ALH18FnqDMouWUgXO0kaWM6ORN0WszgeAF6Mxnx8ZaQMB+dS1evEoRjYXtBBsX6Y
 wjI/DLB4ypSuo1E0h+6GzNmFqyfPwPsNAxFHI13sD7hC0ZmgUaYXJgnE1BqkTPPHMiYA
 OdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720782159; x=1721386959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87DPAAbyBmLAKm4ynt726DGnnWSE+Fbpy4sTffFQKUw=;
 b=vJuK7y9kZgjVQrTBaLq19BRj+7M9U/vISMTHbGGHkJctlyPR54AwIW/Ba6p+lTMCKf
 wajkQgZNbqQ/RRy/F6mStVEo96Ec7t28YC0cw0Q5kjYgPm3pzLz6YoqpXIw9SXYDyZcV
 909aXlGOFw5h01lGBXOXegtQCWAw50oS6P6n5uZRyUBMd0G2qvRh+sN+9C63EIRu1e0W
 470rG7aASRI45IJpd3TRqMEBnU972qmKssqua63vOjufpJtkP7bpMoNI+wA0iAR5uwmM
 Ub9ZZ0tB7vvOtk+INHHcJua8VQNsVz9aVutT0BvDPvq1HFOdbMwZMQ2SphYDIIuedMNE
 EIkQ==
X-Gm-Message-State: AOJu0Yybw6MIWYMy/ZwQ8uiDeYlzPQSNHSwpL95aCMvhnFpcVnF5M5SP
 ytgrFFG9fs9a3PggOxIyZQEs3lzZ6oXna2eEkrS3g2HfG0gyepmn08kqfCm4
X-Google-Smtp-Source: AGHT+IHoNb9jo3zc5r2b5ZN1+E6PEQXJq2jaR175xDg5jGcIkz9qmG3zee/NjIb1VzoUbFJp/vxmXw==
X-Received: by 2002:ac2:5f99:0:b0:52c:86de:cb61 with SMTP id
 2adb3069b0e04-52eb9990fedmr6120031e87.10.1720782158364; 
 Fri, 12 Jul 2024 04:02:38 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52eb9077a9asm1235370e87.297.2024.07.12.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:02:37 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, edgar.iglesias@amd.com,
 Anthony PERARD <anthony.perard@vates.tech>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 3/3] xen: mapcache: Fix unmapping of first entries in buckets
Date: Fri, 12 Jul 2024 13:02:30 +0200
Message-ID: <20240712110230.4098056-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
References: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
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
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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


