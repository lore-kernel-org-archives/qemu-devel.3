Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77294C3065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 22:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOPlC-0005VA-4b; Mon, 01 Jul 2024 18:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPl8-0005Ui-Tq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:30 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sOPl7-00031r-DL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 18:44:30 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso4045475e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719873866; x=1720478666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7pJOgWYTohoN9bNh+FuLDvV+CzujybNoWiwTHb5R5U=;
 b=TSYZSTAOhQgkqZ/GGxqmvBa+A4nkCZ0XDXOcL/F2AxH/3QNeGXVoird6W7oDSXrYRu
 t8sQGvM8C9x0y19DskurF+CWL67P95Bwfw0L5S9HbQuNeqUFvt0zLWAXdqUvC+es+aw+
 xBdsT2wbgGQTQvnoTl9TZzsmqV/pZvUMXAfWfex0rkiQW/JKFILk5B6lmf85vjQ5RyjO
 TqjjMu9OdFAakdSeXWDl2CjPe7VTbebXryX/7Cmm009EKCJ3u9GxV3PAxOx+Xa2w3Ooq
 Bg4kAH1yNPHan6pv/6PaeHWaVY0EgUvEu22L5osDd4O8aGs2GLV1egx2J3M9WDxUrI8L
 NEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719873866; x=1720478666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7pJOgWYTohoN9bNh+FuLDvV+CzujybNoWiwTHb5R5U=;
 b=GH8whKFO8bkottmyimBvJjymV2DCgttIWapgR4rMXvze2hVZy+IZBpUkZ/vGs7VYHg
 /3aVha+JzOTlMLaTabG46t3xIUnIlytkl8y1dlF0d3G3DPdITma79lX+rQ2V3vR/7lYS
 eXfYsdESvBC9k1PPk8CmkYnQJcHJ3YntzZW8Ijv0rSujPJACL2WZ2EJNAwHiliA9qFv0
 +L9QZonmR5C7HdjnF/YHoV6NK7IXAcNEESrDUeglS/OQBCaHwCNLnG2iAnSBxl9VvoRw
 eNOjyCOKrmLWrFY9UmmE4vLC+Fv8kcOd7SUHXYywqzSH4x3FunWORsDb9akJv/tbfH88
 WzUQ==
X-Gm-Message-State: AOJu0YxAiLcHZsE6xsJdPXpnzsSMR5aeqRYvWzQQflnmtkRpAodARYzz
 vhLte7gr/Z+VyQFJX85b2iVp0CxS9SaU1oaXsqtpC5R2kdDLrR6tHJTXkfQ4
X-Google-Smtp-Source: AGHT+IEVWqn6yL477AvOLH/6tDs+0UcgfhXgHVrF+nz3cT7y9bdDM7hCDuZsRYNQLIieDX2+ijBF8Q==
X-Received: by 2002:a05:6512:3b29:b0:52c:d9f8:b033 with SMTP id
 2adb3069b0e04-52e8264bcb5mr4335217e87.3.1719873865019; 
 Mon, 01 Jul 2024 15:44:25 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab2776bsm1553637e87.175.2024.07.01.15.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 15:44:24 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 1/2] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
Date: Tue,  2 Jul 2024 00:44:20 +0200
Message-ID: <20240701224421.1432654-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
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

Bail out in qemu_ram_block_from_host() when
xen_ram_addr_from_mapcache() does not find an existing
mapping.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 system/physmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 33d09f7571..59d1576c2b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
         ram_addr_t ram_addr;
         RCU_READ_LOCK_GUARD();
         ram_addr = xen_ram_addr_from_mapcache(ptr);
+        if (ram_addr == RAM_ADDR_INVALID) {
+            return NULL;
+        }
+
         block = qemu_get_ram_block(ram_addr);
         if (block) {
             *offset = ram_addr - block->offset;
-- 
2.43.0


