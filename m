Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D1C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyL16-0006qs-2Y; Sun, 23 Aug 2026 23:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyL10-0006m5-Mu
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:06:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyL0w-00044d-M6
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:06:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so33445345ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787540774; x=1788145574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hSzeeNc519qewfjxDVo2U7VPXPLogh/HrY3PtLKPaJo=;
 b=kqhLu0rMC8hVJxvGvl0CnEDMuXiUyfWWQIUahOeliAmihCnPIvQO/bfUdSQQLOcV74
 cx0CASi8nt3GhUUBBAhybENAifAx3qyr/9IoN8Ikq4JccEGW9LJbN11xLvGAaCWLgK3N
 9XmTPg97RyPsHM42fe9wTaRBp6A6LJ1ni1aVnQrwJMesV9XcKikr/JfSYiydwtwkCnVi
 /U2dqAyDUOir3+e4qU3cYKY6TpETJgXvdEgOP4FlhfgH/1br8SglfoKjg1jY8KYTZoQH
 pY4PGFqb8hVvflT8LHGl5odeIh/mFRkpzRdhKaNN/kbIU33WwFYo+iN0hjsMD6yj07/J
 ES/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787540774; x=1788145574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSzeeNc519qewfjxDVo2U7VPXPLogh/HrY3PtLKPaJo=;
 b=CU3vuwlz9b1P+48Og8Vfwo6Ost+7+KlaCEAK9hf/MgsTO9cGMVYYe87OZLgf7pqzhu
 18GPSYLZiwfVV1QM057QosSLdBdZ/wBYyuHF5CL8MGAn1qBqCxDN3wNQtrrYf49FJhPy
 AvcQ8CGsK26KELbbvhuTIjbZlT8tlIFQ2R5N519eBQAotpVH6kiUc0zCyMN31tYBRyf6
 PqtPJ3xYGzdcgN9Ad/pxzEfeEFKXPlJy+zbjzzDiMeCBi97k/QeBwWeWzogsM0yASd1k
 cSFJM7UD1UloHI5atcH3dj4HHfbFFZVHCsuOxnY2lnUzyL+3uUq20Z8mceVyMqBOqbeF
 0cUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWA2HfOA0ZEYHfOrbbKsuto73S47aJQRIIzi+2szW/izA3i8PiPzJWr0/AAojpKSOdvzLTSuIzPmlz@nongnu.org
X-Gm-Message-State: AFuF++kMi1pjwVa0KcOSoIMz+1asfAosD1sLwYQ5fKLLdUGSAB84B+5E
 nvtH1VgxzdCoWG3FY4x8wiPk5dorwJ/RbLWGk5qsuD5kRKmKeYPgsI8k
X-Gm-Gg: AR+sD11cRNijnD0P23xUgpVxL9qc56nBwjgOqwHnrYlMtIfcY7fC/tHpjjBGzRmmcsB
 DJVyEzZqgjXQIVsFzPMovunAVlQkpsQwAyqNOUIU5NUJKp5raNdpr+72nEzfqJelaXe/j9168Lz
 cklWhaWx168FNHz8lMzHkkh8kAnkkN0t7OFzxnuppcMnqFvjRaULS6D2zA4FV5Tr8giJxCsp+lw
 ai4AH4pLm/dOM5sTYuZRowIED+jYYWbV8AR630S9kXYzzGgp3lsQi0RncND4oOfM8pHx5M6kBZI
 r9nlgef9AWiGQWTr51BVbVHFLMSzV8Jdzes9ycAEcGMy4GlFniN4AUZlEb7eWrdQqf7uARy+0na
 VNKLy5tvPWWTckF+UN5P1TuNoTZku6YLkFlShUE1rfisP2HMJRHor8dvg9rV38xCLpwt6gfL+qJ
 W2ScRnhta2EDNPELDevSKtNitYt6WTGmRrDKsiSYRzxe3PXj/zVGM8Xk4N/twnCVfH6tqSOYfWO
 FAVGugPD3wCsYrN3KGPHJ4GHAR6MfHNdCMpSpMTRPZ4Me3YGiXVo08Ju8p7xTVSBBZOfbwNR7d5
 H6B2myMIADjaNf2rjPeBtg==
X-Received: by 2002:a17:90b:1c90:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-395c351d788mr39916418a91.6.1787540774095; 
 Sun, 23 Aug 2026 20:06:14 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4a4e5ecsm8299699a91.16.2026.08.23.20.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 20:06:13 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/riscv: Make s-mode IMSIC stride explicit
Date: Mon, 24 Aug 2026 12:35:05 +0930
Message-ID: <20260824030509.18078-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This adds s_imsic_stride to riscv_create_aia so machines can separate
the s-mode IMSIC layout from the guest count. They are related but the
layout isn't necessarily defined by the guest count. Doing this means
we can fix a bug that was in the Atlantis machine that I wrote.

Joel Stanley (2):
  hw/riscv: Make s-mode IMSIC stride explicit
  hw/riscv/aia: Check for invalid IMSIC configs

 hw/riscv/aia.h         |  1 +
 hw/riscv/aia.c         |  9 ++++++---
 hw/riscv/tt_atlantis.c | 19 +++++++++++--------
 hw/riscv/virt.c        |  2 ++
 4 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.47.3


