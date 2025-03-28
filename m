Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE5C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 09:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty5qU-0005kK-Bs; Fri, 28 Mar 2025 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty5qO-0005jx-RW
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 05:17:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty5qN-0007uI-8g
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 05:17:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227cf12df27so29214745ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743153457; x=1743758257; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Jkf1wnHzIYgOcqhVQazDfY9OsS6DGkW1u4r8iKDdy4c=;
 b=QEnUh1hHbhYMuUSwvsJ5mH9ep2ShmyHnnavW8wStIHnwdsN5gz129hAV5QtiwKrVDS
 xw1OD1imxUFena5+4kotnWCo67/+Ot+9g4xjdHdWHV3qyVEqA1S0t/FXJhLLm4/HYhH7
 6Gxjy+8PhR1dhz27ThCl5EdRtzjf2kk1BoL3+lnxXNYcsDzJO7iBPsvFPgCn4QkvVxb1
 6iKhpC2OJ/RfiGhMzJUZop1Ww7GPfcGoI/dFreP9e19jZHZnRvm5AiuIFZuXLfPRD/J7
 zCp5Fz5VFJRTcEqtv50emB10KvZLg5sY8HfdwVyJPN4MOa9aNXPC+vItaTgY36+H7TO3
 kw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743153457; x=1743758257;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Jkf1wnHzIYgOcqhVQazDfY9OsS6DGkW1u4r8iKDdy4c=;
 b=QPhdrinmIN4GmZnnJfsqCGUoXE6zv9rfsK+aAcIgBMGxiLOwYlxRzX4nglJXIqeICI
 LoTQJSe/D3dC8KD405HMH6RN84+2u982cu2KgJOkOfeTKsF3ggwhNdGueAbF41nVtXmv
 Ama2U4JB4q8aCqswKwwbXvHSPdPmC4vCdp3SBFLhrQgp9eEwsPJnFjGoqe4R7uqoU/u1
 zraGAVQjr1wkXsM0Ag68E0+a1SoBsk0ZcMOGxCTRlpbwT60JUfInh6SfeRHfoLFFJ/An
 4Q5S1zIcKgjbZgsiZ1u1vwAKDbcrXm1uDrJyAnhGHMRnJTaE09EAgSO77TX4FmBIhn6/
 y4rA==
X-Gm-Message-State: AOJu0YyMsXBOcWrhc2BlX+iN8GpWJekrpaBi6W1yEvy/atyVXBnP48bg
 k8yfIIEJN8fgWi2qpmNFwbepHxRRj1T18P/pt+iG6SrSEHrZa+afgkhP3g==
X-Gm-Gg: ASbGncuCDfOo0KKYwCBYXDoCayhMbfRlbrE7AkwBIGn6MatXs+4eNJPEpxk1xdjSLKo
 KQXp8C3JvqnE/Iwk3anOnOGWPf3f0LSDPqro6YxfRTYPlMyxs8AeSPoN+fC5tx+Rk/E/8bv4nLr
 uw9XA1z7ZhFm3+dhAfWz6jUf4tAD/cxiqlcZd21n6Z2pXLlIvGeXjkzyG6JIoid03agZOWATbHW
 Hi5TUf7C0IALEoSGzJljO/lYQOAkWhXXQIuEf5xnhnKrorq3Xgf9byjMUFRUCb1LEwyVcAUBq1v
 JovkyfKyhSGNqOpYyHuSmEWnPb73GHoLryICzIQ/uTwjcqzsOwr9N8WqFGtpJF5I79kju6/r7No
 =
X-Google-Smtp-Source: AGHT+IF/lfZc7KSFDIM7MDCRCtckwpOkUEf//RQzxlfXsqK72o2jz7ruG6/bdwZZFRof8M6qaQF4Tw==
X-Received: by 2002:a17:902:d505:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-22921edaa54mr36567555ad.13.1743153456768; 
 Fri, 28 Mar 2025 02:17:36 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee20fesm13410365ad.82.2025.03.28.02.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 02:17:36 -0700 (PDT)
Message-ID: <264c0cc9-c228-4690-bdec-99a65645c5db@gmail.com>
Date: Fri, 28 Mar 2025 17:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/net/rocker: fix assertion error while hotunplugging
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

This patch fixes assertion error `vector < dev->msix_entries_nr` while 
hot-unplugging rocker device. In `rocker_msix_uninit()`, `msix_uninit()`
will clear the field `msix_entries_nr` and free the `msix_entry_used`,
which are used later in `rocker_msix_vectors_unuse()` for msix clearing.
Swapping this two calls will fix the issue.

Relative codes:

>// Clearing
>@@ void msix_uninit(PCIDevice *dev, MemoryRegion *table_bar, MemoryRegion *pba_bar)
>dev->msix_entries_nr = 0;
>// ...
>g_free(dev->msix_entry_used);
>
>// Using
>@@ void msix_vector_unuse(PCIDevice *dev, unsigned vector)
>{
>    assert(vector < dev->msix_entries_nr);
>    if (!dev->msix_entry_used[vector]) {
>    // ...
>    msix_clr_pending(dev, vector);
>}


Signed-off-by: Zheng Huang <hz1624917200@gmail.com>

---
 hw/net/rocker/rocker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index aa5d87fbc5..8752ea4aec 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1241,8 +1241,8 @@ static void rocker_msix_uninit(Rocker *r)
 {
     PCIDevice *dev = PCI_DEVICE(r);
 
-    msix_uninit(dev, &r->msix_bar, &r->msix_bar);
     rocker_msix_vectors_unuse(r, ROCKER_MSIX_VEC_COUNT(r->fp_ports));
+    msix_uninit(dev, &r->msix_bar, &r->msix_bar);
 }
 
 static World *rocker_world_type_by_name(Rocker *r, const char *name)
-- 
2.34.1


