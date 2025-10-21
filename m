Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A06CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4zl-0006tZ-JJ; Tue, 21 Oct 2025 01:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vB4zj-0006tB-Mp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:33:15 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vB4zh-00085E-Qs
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:33:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b6a29291cebso27883566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 22:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1761024790; x=1761629590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9uxUFOiI0JmTDyuLajZyHTRkptv0VzvvjRt20iQ5558=;
 b=C5wRjzUUnp4GKw0FPzQZLwMzrI1xavC6QF9o7PECPdq0fNJgUtaojaksQPJSHWEADv
 J9olcgWdu1tBO0DypOXjH9k4Yi5d+7wZfWnPG9fo7LVyi72QR5dm5yttvDwykCJOPLMd
 lYuwTbnnCEmULCRPb5MF4+hkYE2lVfsv3ZSgM0eU9rdMNyS3m6y+HgT6VQPwkNWATSwB
 24bs415W9Ty1WKositjIBxxbY1Tr1QL7d1prsJ96/7muRktFDM8NTSHhdANHH3ix55A/
 4WqJe+SIvS4BIQqGNWcifkIsy5zmjL9zpFPG1Sxzboi2OjF8puJ6DPV6YVcL0oIbmnRV
 jp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761024790; x=1761629590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uxUFOiI0JmTDyuLajZyHTRkptv0VzvvjRt20iQ5558=;
 b=f0XF78Qt1FNN5myQL97WFeCSKzOI1B1McjL6GVDO3NTEBYsgJY7ng3U4Ugv4m239/o
 L3A4l36sjVCro6TSgPnzKpxDcIJh2rLRrB+B2fuMYpAHcnzJJRULLhKknvXSrL8U3HTy
 PYueGIx3RvuDKyF8vTdA9QfXMl93dHAf/5SsaU5vl6fePCd5yULtP47WtPjJ1/zgoaxX
 yDrTk+5wRJgd8cOgSrL5GdFfkA93R/kWL327rigev4HiE5oG7BN6q0M6u9AU+TGydLKT
 boE7Ylqn15OYy/4wMCzyyM/0DF4qD2xnmp0rCUt79KIo1FDXJsL2i8/pZ4FKsBBYBXKI
 7J4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3GI04vNhJOuGDlf5OG/5L/P22Go5lPCVXX+jEXPfpcRkU2ttOOGdmCGGC0XxZpkRWW7B9wZaAbx3@nongnu.org
X-Gm-Message-State: AOJu0YwJHPJXW26AVtpMVUOH/6O/QnCHNPxGAa+sBZ7K9Y4RWCbimDL7
 pRRjJwmjeIAgWJc4y9jKofjRtVbH43ueFL9vOfWw4/f89pMwM15xXBVA5FptfsJbzwA=
X-Gm-Gg: ASbGncuju1dUaXl0SFWerV8+I/JdtkB0GOTdXPrZYqlrEjS56VmpBPwqjGk37Fcx+aX
 unccM5/HeLCXZwNDdLmK/sZ7uXqxX2DM+cDPirMmgdx/zsOlU4fnMUQBRSf1lvhk7k4/2nXBgPE
 q7bNqK5XcAoSehjs5xcPWtBKEiZVSF/lEbc7LwIpyCE4fA/M+9M/dS34UarNmerjz/k82/y44ZA
 WkxKlnJqB0fapA+iasuYHo6tcBR2KW+kMRJN2cmO0aws6Ftjrk4d33VC3K9ML97ytuKl+ZV0fsk
 YZSXJcKBFhNvLkEpCYjmC4pBXUWxpp4QICqa24hlX6/MOmgjZi8fPr/CTwUeMn6tuLdegWHJkIk
 VuTBBOOYxtRNuB/qRUyYUNlbISrnGCoTd0ETPWbip6OfyCMg4xxij9l3MSSTo0M2hyBMdryIwdl
 IoZn2Zy/RIhyymmivLkzQzuvl+
X-Google-Smtp-Source: AGHT+IEkifa8Um4rOYr0AExSE0eh88i9ThUGL6AlxnN1Xj0+MdWRN7X4s6dEYO6ae/pXYx8TksWCyw==
X-Received: by 2002:a17:907:72cb:b0:b3e:c7d5:4cb9 with SMTP id
 a640c23a62f3a-b6c7758d3fdmr146570666b.5.1761024790389; 
 Mon, 20 Oct 2025 22:33:10 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net
 ([2001:9e8:145e:5600:d92b:7238:50ee:a22f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebc42bc5sm967786866b.76.2025.10.20.22.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 22:33:10 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: yu.zhang@ionos.com
Subject: [PATCH] qmp: Fix a typo for a USO feature
Date: Tue, 21 Oct 2025 07:33:09 +0200
Message-ID: <20251021053309.208957-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::634;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

There is a copy & paste error, USO6 should be there.

Fixes: 58f81689789f ("qmp: update virtio feature maps, vhost-user-gpio introspection")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 hw/virtio/virtio-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index b338344c6cca..968299fda0c9 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -299,7 +299,7 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
             "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
     FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+            "VIRTIO_NET_F_GUEST_USO6: Driver can receive USOv6"),
     FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
             "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
-- 
2.43.0


