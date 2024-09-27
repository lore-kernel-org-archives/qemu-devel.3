Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8227BCF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suImd-0003wg-4e; Fri, 27 Sep 2024 17:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImb-0003v8-NL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImP-0003tt-AD
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso22508765e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473535; x=1728078335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8FAFiSDjqWLgEQX5cTL85SBND1KMRxlAjrYJKgtvFoY=;
 b=vPHZ+jIR72za9EyIvLAXJeJCkVXFWsXn1xzG+8mOZ3Ac9rDm0FMVeFk2bZ2UW1mrvk
 zUF62qsscUpVM5uUcxGwvdZA70tqoOGvBc8nusJw0xWPC+UEZBNGk4Wy7nc7XsQGlCB7
 9WZEQOTNJRXn4ZL5DDIcLxqL2Q+FW3dGfX4h3RinpmQUA1/pV+OIBtI8IH4CTDUgDy45
 hueW7LT7MbaQB0KysaNZpALgi2+hT9tHeHgC7+MurWz1EdIm3MPqJvPVVcFkavL0fbQ7
 RH/IVax4aCbvNMjjD2zuOr88sVi0+EdLENkFMdGi81mcYte5CeiROJuknE6tavBk+EOF
 aBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473535; x=1728078335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FAFiSDjqWLgEQX5cTL85SBND1KMRxlAjrYJKgtvFoY=;
 b=MzqLSdppgf5hbv1jxhe27qwZD9GmnDE1EuKRt6qC4UHpTbvscwhW34PgXIko69tQvt
 sgXmQf6WSD/q40HYjwKhC/TkqiLqFh1L8oKD95sci5xS1ScO13H8pN0xWotPd0pyQWtt
 xSaJYUMWMflaEsXMRYi0FzJ8wLtWty0xZb6LPQZ64suCWa4/xM7a35q3tRkiMO+K4FXN
 odhYcOr395TeJij1Es7zzQaR9NDVjOpsTzz5cYp+2AoLC1nt2WDqhZl/MrtkvCuL3IlI
 G04OGVFwbaN2kYjUj32BQbPaEhh/4i7tgDtVF+EyzEeze9GXsgepf8dDE+Cu7XLrik++
 cHIA==
X-Gm-Message-State: AOJu0Yz1PdtvUw4p2792NBtLJSB4bQ1oB7nR3IlgLVFBQKXaQHk1FCwe
 k0tFZL5aY0b6h+24sW4+oHFX/Ns3eCh+cfwTInxsRUafeqRgKa5RIXzEbdINtbx7XIJeTL30QRa
 N
X-Google-Smtp-Source: AGHT+IHG9Xq5YG3NtoL3/Fizyz22Mo/QWHGL89Zcu7ks38GkRYS7JN9KZsnlZuI8IUA3AfBdhsAy3Q==
X-Received: by 2002:a05:600c:1988:b0:42c:b73b:fb43 with SMTP id
 5b1f17b1804b1-42f5220105bmr53303435e9.12.1727473534591; 
 Fri, 27 Sep 2024 14:45:34 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f2083sm83472645e9.15.2024.09.27.14.45.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:45:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/ppc & net: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:45:27 +0200
Message-ID: <20240927214531.20242-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use ldN / stN methods to access variable lengths.

Philippe Mathieu-Daudé (4):
  hw/ppc/spapr_nvdimm: Simplify LD/ST API uses
  hw/ppc/spapr_vof: Simplify LD/ST API uses
  hw/ppc/vof: Simplify LD/ST API uses
  net/l2tpv3: Simplify LD/ST API uses

 hw/ppc/spapr_nvdimm.c | 47 ++++---------------------------------------
 hw/ppc/spapr_vof.c    | 27 +++++++++----------------
 hw/ppc/vof.c          |  6 +-----
 net/l2tpv3.c          |  6 +-----
 4 files changed, 15 insertions(+), 71 deletions(-)

-- 
2.45.2


