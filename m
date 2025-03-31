Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1266FC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8x-0003Aw-Vd; Mon, 31 Mar 2025 15:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8k-0002aq-GQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8i-0003Rn-H6
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so2378532f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450582; x=1744055382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/jd9HigZUkvZ9mYhgB2s1hOlVQphymlZOIUStujzjg=;
 b=vjBGSYea+bnXAwcN8JSchUQ6vwB6Ie3pofc0NNfYb3um2QOStFQ6jRVmX/PvTtxrY4
 AaMfYf3bRMj8RPgYhIPSvrMZC6qb9CIIMLN2xroFjAInQHD3LI4QpVUHFQQWCcg+82eN
 fvqnYBK5AWxgu/RE/UdAlgMWSEHxL37Bw0e7YU4hnk2zB8nGKe80JJrEL9tKUbuT7OTt
 F8HAexO0BUtsaGuxNnncVqw3sCQDKWRQMCCUIVdHtM4wTGIYXdv8D+dEizPzeyMkuIQY
 cPRYWS/jGfv4rXIrUEdGIsHXymxDK4I0cyUCQ8G1uKx0iFeFD+t0dACqBnSclR3fkENf
 AKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450582; x=1744055382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/jd9HigZUkvZ9mYhgB2s1hOlVQphymlZOIUStujzjg=;
 b=TftWO4qn+IpfKSDOPBz/sPqBj6da5AMgQdXa4j8nhYML4HL38lec6+gYiXt7+gZ9eD
 ji0mT5R8iqioOyTmjuEjPP682wZGY8GEF6fQnAdnLEeb1Af7BVHOCuuADpfZhLFLad2m
 aAhbJXVPiv8b6N045fOUYzOJJpBmROdc93UUkYMaJ0gIYg5gJwZ6hpx23wRePEJIoBoi
 AUtXLQqC5D6HEMSOSWw/DzL1127acggtG9FsNeA9sC4TK0510TwO496DSf5RK7o0dg9d
 l28fDUriEfDyVm6lw0GYs+L6HgtIK2IGcind38fa1YkmKXpqljJj+tz+Y3K3SAdTRpzF
 AeNA==
X-Gm-Message-State: AOJu0YzxQskWQ8mX1TuQF70/uncpdx4FoLjcLufVoElWqCkBSCUG31yU
 NILOpTlEjkzJb7XbHGuBRLE1aBMg1uB7Loed7czJdQ+vl0xfHNah7qYRFRcFvVDqE2mzSPo21XK
 z
X-Gm-Gg: ASbGncsYCvJIGDaxcDETknTfBUPWUJRd9vzpELpUELCuunm1CEGxfosWO9YT50jgjBR
 4h9+d8gKK6SoHq56f9LgBn9ad50WXssQyMlCbWpW63ql3p6Fz96NHGKeUSMgPB1MZu25stjI/VV
 dkc3lwa4hiUZ1ITXGtFO4Xx8Cs3cKr2NO+SxFD+oLggSq5niTKPOxQH52bNVXyU6b+JgnZ6Zenj
 HDe0MRfkZzi2yjju1IUOiKn41z7m5TwI64CpbnFxc9nOw1ouRSQsqn9BUT6BaWSjAvm0ED3+1FN
 1/dWEN/2aVZBL7yrS4oc6K0G2mx0His9UkKTFx5SGI3h9j2/2OT+lOayhWsda3bllg+2TooE4H7
 9+nB2xkPS7roDyiemP+Y=
X-Google-Smtp-Source: AGHT+IGlznRzHVVi6hbOwifE+N4TwtvHdOxQ3DAio6Zo4VKgn7rqwlfnxLhTxmuWntbnNWmb9uZdmQ==
X-Received: by 2002:a5d:64c6:0:b0:38f:39e5:6b5d with SMTP id
 ffacd0b85a97d-39c12117d3emr8212094f8f.44.1743450582608; 
 Mon, 31 Mar 2025 12:49:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f59d0sm173771505e9.28.2025.03.31.12.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zheng Huang <hz1624917200@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/23] hw/ufs: free irq on exit
Date: Mon, 31 Mar 2025 21:48:14 +0200
Message-ID: <20250331194822.77309-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Zheng Huang <hz1624917200@gmail.com>

Fix a memory leak bug in ufs_init_pci() due to u->irq
not being freed in ufs_exit().

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <43ceb427-87aa-44ee-9007-dbaecc499bba@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ufs/ufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 857de6e9c2c..ee13edacd8f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
+#include "hw/irq.h"
 #include "trace.h"
 #include "ufs.h"
 
@@ -1808,6 +1809,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
+    qemu_free_irq(u->irq);
+
     qemu_bh_delete(u->doorbell_bh);
     qemu_bh_delete(u->complete_bh);
 
-- 
2.47.1


