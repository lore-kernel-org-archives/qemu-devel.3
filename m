Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D728DCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDg-0003dT-T7; Tue, 16 Jun 2026 15:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Z-0004ml-9W
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8U-0000xE-0M
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso3412767f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636820; x=1782241620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ic2bXL26/Yx4lR7wZIf6TWd/FeRNPNT75FGM1aR3uho=;
 b=pE9Eo/YyY81zZimcpHK1d1fjQrPFghOaGtG3F10xqnZmiD2DcwhJzSZT4Jq6BFxNuk
 T8aIj11jUOejx4f7zeXjKT2E1W8NxMzU7IYxkY4yFfP1Xb40C53Nj4P4QvM+JYVfPHcL
 FPS1Vu3wx+UCYgQERek/fYgHMj9sQw+8SkYXtzconlNqX67QNjUcjde77pAbiEMClXs1
 urjd9aPlz/5486eDXFu2osNRlK76wQ4kTe0QAjDS8mQTjxuBi1OaxgoVXZrL+IXqInpY
 xt7gctJM1lhVoFZ98YAoRoj/JNFEsYXGoiK7ofgNhpaz0f3RRd/+2heVxJpWj25E3tfn
 37LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636820; x=1782241620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ic2bXL26/Yx4lR7wZIf6TWd/FeRNPNT75FGM1aR3uho=;
 b=Pd3+CrU4gRWxpPv1+bq0MCnQ6QYlC2lDqoztGhanq+DIMOle784ucwgkiVoaOXOqL5
 nNBtDHrnmzCduwnfHtNpkGIunbf5nJ45Y6rTXyDwUQ7V7zFhydywG73XAZhEFCwBxvIO
 elj0ic7zI9JOFaKJbRpY7GAG/P2blwIXwcrlgXGaBU3oR/du/fK/lXoEdMFJe6ambiDc
 JmfN9RPjJNTefh27o03JtJ6QliJu0WlbgjWGH1xPKMgdeEAg7f6J9UY3/u5fdDKlhALM
 F0g0JPLrX63/CdXR2OkaWqynXGZKbClx4/p8lJTQ2MlCtU7gVoSzcnK4EdeXuXiwG3eM
 Yo1g==
X-Gm-Message-State: AOJu0YysRMY3sD/kmwngs6jbtGhWj6wcJVi5VUGIbrkCgxPusqEjYmdA
 00nZbc5sfLU/dHUQE2GJ6ugDSGgBsUvGe0xKDNQ97tCL3kL0RJLETPHFbKDyWT0TUgwQ7yZLmFn
 hNEVL
X-Gm-Gg: Acq92OH6HpIQb9CAVL95Z+rKVI8kFAPUbQVERdXXJhHkv1/Ris6smSEWA8jwGzx5qJQ
 pFdiwkIMbrSuPHgLS2kIMbgb6FmwoUoPwAzVDNMB9j2LCi+sH+o+rcgnGNql4v5Zb5rcPfLVGn7
 1qSp+1Zx3upV7lVEsFrfw0A8S/BC6TjaUWIXr/Z0P1IuCyn8W5wTIYZ6Thju0HyVRMHEtc+hlqY
 zX+9yT2dZ5c9pOM2oUO6Dhj/b1JWzFkGr9ahFy2+CPVgLbqBQSqCtnNsyWHQ5+7dOCpR4d9B8aY
 NGC8HZr50JOwJxcbmMxtXoYmwdIRMc2nZzMVeDvDDftEbPqr1/cdJ8JnQzvHTA1oE/+Rm6W1Hdo
 lyuAyAmhhou3bu+YKxmn/Udx+W/YeDudlQuBn+VsNrdUBe0tcch6hcN5erA+g0aWBAv6lq5sbqn
 bCcUwMUVJdvSZvnykKFI3uASYfCOccM0MAQCZlLChtcDtB0Fy2SqAsne+Te99D7Y0qfKfB8UVV2
 gJa1sIi4tWX92BubMf3otTsRYo6qH8A
X-Received: by 2002:a5d:45cc:0:b0:45e:945b:276 with SMTP id
 ffacd0b85a97d-46237d5b277mr950005f8f.20.1781636819589; 
 Tue, 16 Jun 2026 12:06:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/61] system/iommufd: Remove unused viommu pointer from
 IOMMUFDVeventq
Date: Tue, 16 Jun 2026 20:05:52 +0100
Message-ID: <20260616190639.3462006-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

The viommu field is assigned but never used. Callers freeing the
veventq already have access to the IOMMUFDViommu object through other
references, so this field is redundant.

Removing it also simplifies upcoming changes where veventq is
allocated based on the viommu id before the IOMMUFDViommu object is
created (e.g. vendor CMDQV-based veventq allocation).

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-6-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c    | 1 -
 include/system/iommufd.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4cef487679..70b2581c17 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -553,7 +553,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     veventq = g_new0(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
-    veventq->viommu = accel->viommu;
     accel->veventq = veventq;
 
     /* Set up event handler for veventq fd */
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index bb8d5081d7..da68ba0037 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -58,7 +58,6 @@ typedef struct IOMMUFDVdev {
 
 /* Virtual event queue interface for a vIOMMU */
 typedef struct IOMMUFDVeventq {
-    IOMMUFDViommu *viommu;
     uint32_t veventq_id;
     uint32_t veventq_fd;
     uint32_t last_event_seq; /* Sequence number of last processed event */
-- 
2.43.0


