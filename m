Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0BC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaO2-00059q-6O; Wed, 22 Jul 2026 13:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaNz-000598-QD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaNy-0001YG-3x
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso22910955e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739933; x=1785344733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=bKNxdLfBZqq60BOvjAPWergIOC6S+PpuQkQ9GwnQF1u8hMWYMwCrplcpasO7vgN62u
 onXBs16iw4kTdoxAwDV3JIHsdz1iOJr3rVNRe8sdcMaAGkoAzHbmZ46F99uxNEyjahUT
 +IYnCAM4SZmuHFYJ4aQPF7wNo6+txs6ikPjK3vIpxyLE+MNdEko3mi4Z10Uii2c1ATyU
 lTGk81IsE14SNDHskpwW7dYV49nxYSkIAHkIG8l9DTmhDXZnZ/4QmtIxiP8Lg3AZoRZf
 1oVbaB+Ov35xCrnwmW9TxzRn0H94sRrXNGDhLg4JzgahAf49SOmPbvbK8pEfz/oDtOl6
 vrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739933; x=1785344733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6peXfCAI9PBCc+mW0GS1f5pARDqtu1ectajEcLcGxc4=;
 b=XBB3hSvQeXfIPOpFE9IHr28Nr0+2gLhRS5cAYTqNvO59C2bLoWzxBxo2ZR8+M5RyY6
 Gz+y8SAZ1UMbf1c2NNra1pXbrVcIHt7UKbSukHrybbgbdapYc6Up07HuRPu8JqWFQJv6
 QmUSvj/naq+EJ3A2zBNwvnczn0XeQetEHmyOUmZsubr7PqwO6OQOWL5y/C8YtGyrvm4A
 XRBSg5eLslDq6KDzUet+I0a27chXeoj+CtSVkYuNMPgjKScz/Jr0qjjBhTmaqiGaVYzT
 5hEHzo4/8QVXMdMUm+PO1V5X72UsQCekNnD9oMnxAr/vVoOLdfIrSPSRNAp6f/CZedqm
 eXPQ==
X-Gm-Message-State: AOJu0YxJJsH7MSoge1FDiXJOsQ/7s0/LTUTo8/pajW8Y74TDb5Rha0q3
 aNoxHhRpcFJM5TtMen3PYsDBG4lmpF6HR1313xMXgcI8H/SxNjHFBkFq3a6qKHwXgBiSpM/obup
 OvVsd
X-Gm-Gg: AR+sD103uW0tLwCSdgGUYWVT4TqvZJ99ANQIMl5883o1Q5vw+MYzDLGua/djFJGdGCr
 mzcie7wx/WGZqz7vF7DRXIGJLQChR0hMZUk80Uxi/eDdGhpvhHE1TxGGuhBPI2TjX8wBECY8dKQ
 Mjx7DPfJ8HAUCkC/pIAWjsNp/9P4sUvcJlbA2yBjr6O8e7PVNbSZBY4B6bmULF8wvAAcLkbuROT
 Or/P8L2IV8I/MnLtXjzn20l85ibbK5vTNb2NZwbITLsnrePpDw3M1DXg2mlovbHQeUXsPH89xf1
 NxBS6QwugVleUS7RExnMmna9VahaiSJ0i2eGTi4dkVFpT7Y6HUdfWTiyXjq3ulPg2WjpxRySAam
 MboOu/7/fSLcYf6gmX5MUpyf0zdgzRdrWu4GuXAqqV6pPHkvHA9K1Z7FE3UQmxAdIMe6ba/KelB
 k=
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4954a3dc7bcmr304740015e9.16.1784739932647; 
 Wed, 22 Jul 2026 10:05:32 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/9] parallels: fix integer overflow in header size calculation
Date: Wed, 22 Jul 2026 19:05:19 +0200
Message-ID: <20260722170527.2593225-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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

parallels_open() caches bat_entry_off(s->bat_size) - a uint32_t -
in a plain int before it feeds into s->header_size. Near the
"Catalog too large" bound the value exceeds INT_MAX and overflows
on assignment.

Match the cached value's type to bat_entry_off()'s return type.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7a90fb5220..59f00c64a6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1240,7 +1240,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
-    int ret, size, i;
+    int ret, i;
+    uint32_t size;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
     bool need_check = false;
-- 
2.53.0


