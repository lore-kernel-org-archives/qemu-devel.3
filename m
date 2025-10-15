Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC88CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeK-0001vp-5o; Wed, 15 Oct 2025 05:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe4-0001ne-Do
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdn-0007EO-5Z
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3dbf11fa9eso1033833366b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519868; x=1761124668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efx9c1ZcXLUi9oQ3sye4iSYkiRtCvMScPRmIZtuVzkQ=;
 b=HSkCrcjSC8e5jNwUepGBpvl+BAZoiy+0zAkm8s2RDj6yrmxROVbQxrwCygcqSsxGMH
 2TcGUe/ie96Wwcojc4376f8iiu2uPjEHzU2QrePmCz54Jhp8230Hkb6Jiw+pD6SLnDVl
 Ov8UbHUOOjgDeh1g4RXL53mg+kus317mOh8IhsDiJDgSQOOMaXErc1uF3JQ98Vn1f3Fi
 ou2duVpzvWus6UTfaJStZ9tdrxFiX6v8XTC0qyEDF6PC3dEigurly1MU1bkqn2GoK0y1
 06V5D6CjpW4hCVoJslXrcKuAD2H3msusalriIkzHQbscZtPFMhOHrX0D/PU3Yy3Kcsns
 c63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519868; x=1761124668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efx9c1ZcXLUi9oQ3sye4iSYkiRtCvMScPRmIZtuVzkQ=;
 b=D6OVpVpLp2pzGAKxwDCh0hapA1Z0569XkGNv2wj4Eyp7vsa4VWXsB8HdX9vP9e4K+b
 nT2UfaTQHE5FTEpteS4FxeL/CFKWyZSxfMrU7XKlam4sDUs/8WmVtVDZgzQSU98QZk7S
 qc5sxJ4Dgv5KTYhZr5WOtQuYZcyNezdiF48ZIzzB807aL7k6RWbeNGvEMtrnk8F6h8dS
 ijUBzSIPsXVmcbcG7DqzruneprGlitzg9x7T61IglAUlC0zPNyvzRULLPyAQIBon2pgr
 55uiFllY21WrYoeoCAhjc+Pen33AYjtitUILsmmvUq0GO2C5qB/QmG6nW4bOszW4zwvP
 KqOw==
X-Gm-Message-State: AOJu0YwA+KOrNTbqLSgNpSx3i5vmQCMSrUZotjuKvpLnu/3Ml6t0K519
 sLLUCsmLhER1jMQqFWeimctJmX8JOwGjq1Lf5XOQ3ktVyX9J2n251+UBjhV98Qj4fYA=
X-Gm-Gg: ASbGnctrGa3+ziSbY3MTotqx3nH0BZDHdJkGHrmJaA34WXzgyJM6P1BYLnbbVB1e2RL
 aCA32lOlLSssaPZWB3pfztdjr3r+Df4P7TgmyMTvcmcKvAEoA/BkilC/1PUUrXXm8IsdC2Z7XRJ
 5u5PJoMf7TOvCEQDL3iVhbSW4Ps/KIEnW8Dhyq8dqv2Ep0Skds6B68AeL2xeGsGSR/0TeXoAp73
 5SLN4rQ9eISde1QZb/mVXSKqlnjcy/mjt4SQpMyf5vOSsowQbe9lA8vTSQKDbm/nnUB41DubMQK
 Uc/nsJfGAC1+cbkS1Y2ZqgN+s7RN3HgGROJ7WC8Xlj0aklBD50HWrZRrlzYaFYp7U+rnd6zwNnN
 WY2FDIHOK+OA3fvbx0krOet84UZ7RrTozA7eK71TA7sRrrPHJJUxOZ/tQFntkcQ==
X-Google-Smtp-Source: AGHT+IFFl2rV6vsNtRkVRtUFogR8DFspLd1983rC2z43+rKPgqnHcIbeBAfyjfSK21SkAOuAABqb0A==
X-Received: by 2002:a17:907:94d0:b0:b3c:e14c:e24 with SMTP id
 a640c23a62f3a-b50aa69e3c6mr2613939566b.13.1760519868011; 
 Wed, 15 Oct 2025 02:17:48 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:47 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 07/14] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Wed, 15 Oct 2025 11:17:22 +0200
Message-ID: <20251015091729.33761-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x635.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

It is assumed, that the programmable logic (PL) is always powered
during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
is set.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 968131a691..3df80a279b 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -333,7 +333,8 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
        /* Silicon 3.0 for version field, the mysterious reserved bit 23
         * and QEMU platform identifier.
         */
-       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
+       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 |
+                R_MCTRL_PCFG_POR_B_MASK | R_MCTRL_QEMU_MASK,
        .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
        .rsvd = 0x00f00303,
     },
-- 
2.47.3


