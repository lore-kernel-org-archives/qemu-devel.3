Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F81BFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHm7w-00041w-47; Tue, 28 Apr 2026 13:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7u-00041o-Ah
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7t-0002rB-0F
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so143358475e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777396894; x=1778001694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmGOYhAGLse9yeus0Owfrm0ZcexMp7LbBCY4UT6PZys=;
 b=O0FNrf6DnWjWH3N0swv0Izls+kS5FJTbTzX8bDzeFoWCdL8vfOjcha5xFYZGQGqo4U
 R2F064Qmyhj2PdH2v7BxfW/tnZJ02DARYiOdrAkHYnMc1EwcQf1NS3Yh6ksGexu9pFyH
 bmkHiof1+XDm4R3/cpG7cU1TOIp5xJuuZPxe/LZUGqmMf6f2S/h9zYZ/k5JpHwJnmjwY
 tCrAqP8DluMsB5rbXDsKgyiXR0VgCtPe9AiisCE1Rmp7dCqgtYplv9x4V0BKKHXqc6Rb
 FyloUzX4AQ20Ba5tX9CQ7Rp5QucP9W0j9uLD76t1dWwFiqSWcosgY4bqy2srHSVuD1Pr
 kT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777396894; x=1778001694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RmGOYhAGLse9yeus0Owfrm0ZcexMp7LbBCY4UT6PZys=;
 b=YXp3WeJoUAAAmhsbuWARA1vuWjfUYbRkt93xIXIdj0a+lMlrxb1xgNp7RlcPHPPC5a
 J1GsRe/GDhuFooipfyoRjuxyCOJ9dvx6fOdHpzK4OqgjhwzgoO6VRllNfCC8D9MEFmDI
 hEvKaKMqRxo0Ms/sUOXg4rlzs3ouUz7ziqPEZe2xAkUfV5Ru1V3K6ZnYyTWwsSG2CrbW
 lpj3XZETowv6cm16nwL2D+biqm34AHaBh6gnBIrXIMtgqfcnMG87+0Q84g1otN5J0zSy
 qCFJRz1DZmi0jCSh04k0sy/3UWgZf0MReXvsj9X0GOCQs16vUtKJwGO3tqRdHTli/8Mo
 9/Zw==
X-Gm-Message-State: AOJu0Yyn9nhvcJd7oI035K2YeMRPUDA34BDaXrE854M9MZdwyK4PvVaM
 Y4lMZcsLdCI6y/U5qiYhANWVdT8cxvGNMvOJq+EiHW31pa86y9m0b6GoR9lmuNNw
X-Gm-Gg: AeBDieuQJEzedup2Z9lxd1pHAG8vM2Js5n33auAXAFNnzL96IUOFNB2PJXgAvqm94XG
 vvj/u3CRndcGYJ0h9rE+7Y9eNskJq0ZlO6LO6wQci8iveI+ihqrzH9dUqc0wxdgvlN7dyfOnzaP
 0torew678dklIdBR3IUB/0uJRxn2zXuCvQDCVKbtJFPcA7sCXdWI4LmI3YRm9Lx9i1mD7mqD6z+
 TL82+0/iYfxm/J4fv2MGjUkBRq4lNUB/eRIsCudHUN9Q7dZo+SF3ROL9semK84yPwm4GUuj88QW
 u6jg40H1Q4Y3Lo3eLgD3/aNzXg8jWTSGC/S/LSZe48KrNt+GhaxEgDmfJNp8pLQLtAk3QKq1ZDM
 2G07oZ4TGIsluc6mDBA5PQheGQ+ruXDaDknUAF9FSTIxzKx+6chTg3EMQGbybVToiGP+bGFCdvF
 AGK67KHV4IW6OOVKDCy79kjy1l4U6TIU6sFj7OeGxO1mhbvLkwMBepr7WjMEIstzMdt2F7RtaOC
 513OFkVtHJiPfz5
X-Received: by 2002:a05:600c:3b8a:b0:48a:56de:d640 with SMTP id
 5b1f17b1804b1-48a77b0a367mr70786875e9.16.1777396893535; 
 Tue, 28 Apr 2026 10:21:33 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b900af7sm900415e9.1.2026.04.28.10.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 10:21:30 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as the OpenRISC virt maintainer
Date: Tue, 28 Apr 2026 18:20:55 +0100
Message-ID: <20260428172055.1525176-3-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
References: <20260428172055.1525176-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x336.google.com
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

I defined the virt board but didn't realize there is a separate section
for listing boards in MAINTAINERS.  Add myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44207949d7..e9807fe6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,6 +1516,12 @@ F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
+virt
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
+F: docs/system/or1k/virt.rst
+F: hw/or1k/virt.c
+
 PowerPC Machines
 ----------------
 Bamboo
-- 
2.53.0


