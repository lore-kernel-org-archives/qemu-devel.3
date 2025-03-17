Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471A0C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xA-0006dc-Qh; Mon, 17 Mar 2025 01:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2x6-0006dG-54; Mon, 17 Mar 2025 01:23:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2x4-0007n0-H5; Mon, 17 Mar 2025 01:23:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22349bb8605so80465065ad.0; 
 Sun, 16 Mar 2025 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189028; x=1742793828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwfk/klmzmPGpfHaFqqk2IGyHBeZO9L6L1vDs8m/L58=;
 b=KRI5WTvOHEUSKFcJvB6z41PTB/pH+7gGJlarbFOJnqCa08noYfZ99ctMcfFVG+RT/u
 pZGwR51B+Dp0SpEXRvLNnsP9J3wBWf8/C59BZyc1IFcw/lj0T0xAH7UJAq7cV3QdGOtt
 RpWnUv4rbFq5hwD+wKizkWb1eF4W1kTC74OrHoyrHYOgy60OOA+TNi3nMCKDVPb7vX1z
 FLqggUVSKt88meRdWbojvqa3x/3GTAD5ZP25/KqW97PkdgGe6dKR4COOig1CaXhg7VU1
 DgGPGLIUjGquM1EqVS54weM2B3ccHZ46N2bs8Gw74p3LLZZemwcrdtV6P+Oa0YUi3j53
 yoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189028; x=1742793828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zwfk/klmzmPGpfHaFqqk2IGyHBeZO9L6L1vDs8m/L58=;
 b=gzR4a5ruSV1Zn45KAG7fPz1xAe1aWEMcRw2xZlEQpfU2nCDdMo8nL8LV+dfvssDhIT
 yiF0RB2XCuH7OYf5CAjRzjkghgjE3iduPOB36ZxlyEGL4wkG4ICk1GU2iYFXq8Mp4Zvb
 qouDeYm+lFLr23oc1o1+2TX7mTLKF6VaCEMKmz7s0X4Ahx9F4Q8gE+aqiUiNzOzLghCL
 Wk7AzTLQE4tACI7x+D4YVNZK5wdC2TqpYKtjqiOk/O7JFVjOGwYdVYFnwOxD5xl0NMuX
 51P0kPZrKNlHXkZoQrNrE4YE16F8vAOyBJpnQ2MOcxqB9sEHyQmXjMmH4100zeZOj3RW
 jOTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0o3Wnlj8MENwIaX1gzcIHQRkzrvpIHqc6nv1cAiGLOOdEXhCDyYR/65dW7pmAjSQmg3a9dazFQ==@nongnu.org
X-Gm-Message-State: AOJu0YzDjwYCjzW14doO6l1rPcN4jw8McPDqxIcnj8sMUnrtC2HxA01Q
 FWlPqNmBn7Zq0WS/cKUtm04OFZ6qK7vU9x7um1Ceu9PJLGYgAqBYWi2zow==
X-Gm-Gg: ASbGncuBkFP4dDDKMKTsGX+fFWsoXi7dZwJx2X25oabOFXIniizdUWPNItVu5Kn1DYX
 sUUL7KM4hp2polhmCCMppJYzdDM9ME6xgW4jMLU09p+QUbyQ0J9azyX291XAIXOHS0H6CPD3dFg
 o0cNwEPxxE1EyUgKC2UvgffZsGa826ohlg0cIVofDTtgJ52eApB0TL9M9MAGDwKhLCg4YhLfBYP
 cJrjc6sEBMGb45XIkID/2yPwuMeyM4VxofY85D/coVZSsyuDi7FniFGeNaVRy+dKn9mQRHuCXUf
 XDBx7WqHxMgUQexaRjt04jcQbPzn8zOWXIBs41MqaJMtOpBCcQ==
X-Google-Smtp-Source: AGHT+IHP5RWNBMWgGk/AYJePMYutq0HoI5J2toPN6zRufcoR2biEDIWUtmhqxeleK2zr3YeqlBO43g==
X-Received: by 2002:a05:6a00:1256:b0:736:5c8e:bab8 with SMTP id
 d2e1a72fcca58-7372236c795mr12060532b3a.3.1742189028108; 
 Sun, 16 Mar 2025 22:23:48 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:23:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 0/6] ppc small fixes for 10.0
Date: Mon, 17 Mar 2025 15:23:32 +1000
Message-ID: <20250317052339.1108322-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Coverity reported a bunch of issues with the last ppc PR
(thanks Cedric), and a couple of other things that were
noticed too. With Zoltan's amigaone patches this should
fix all Coverity bugs I hope.

Thanks,
Nick

Nicholas Piggin (6):
  ppc/xive: Fix typo in crowd block level calculation
  pnv/xive: Fix possible undefined shift error in group size calculation
  ppc/xive2: Fix logical / bitwise comparison typo
  ppc/spapr: Fix possible pa_features memory overflow
  ppc/pnv: Move the PNOR LPC address into struct PnvPnor
  ppc/pnv: Fix system symbols in HOMER structure definitions

 include/hw/ppc/pnv_pnor.h |   1 +
 hw/intc/xive.c            |  29 +++++-
 hw/intc/xive2.c           |  21 ++--
 hw/ppc/pnv.c              |   2 +-
 hw/ppc/pnv_bmc.c          |   4 +-
 hw/ppc/pnv_occ.c          | 201 ++++++++++++++++++--------------------
 hw/ppc/pnv_pnor.c         |   2 +
 hw/ppc/spapr.c            |   1 +
 8 files changed, 143 insertions(+), 118 deletions(-)

-- 
2.47.1


