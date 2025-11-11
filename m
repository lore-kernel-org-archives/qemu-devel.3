Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CACCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlcj-0008Q3-7t; Tue, 11 Nov 2025 05:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcM-0007fm-Bt
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:54 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcH-0000HC-BP
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:54 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64149f78c0dso5365630a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856924; x=1763461724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d/AzQC6EdahU6w8Pku7xRAbXQexLsJDKD33bKyFb80=;
 b=jsp5GL4TEoNhx9Yokl1Jx9L2D0ZJcA5TS3QWZp+7ymouWTxlJNZqS0bAwQKY5702xs
 Gc1XcPtwWpbibAGKjPIVNoJNMyU4YDeIPeQ0gz/kSDrBO53tL4b8KWauP50t0DI8ynZ7
 tLyjnIxLh//bFFzUra84IG13OcZUw53r2glDAoDApcWuj71KmdEvka+c9bYl9dIsiLjM
 ZN/JM7y0RIIX5024y2sQyFVXxexjNs4+jwR/lVM9Ch6amKVwr/GDi2MC7vG6+d8LClPv
 lEi67fKGJHCEw+wvoRIUYeVmFPfZQuHimqhxWkZoJhAi/QFJ3rBa/ziZQW6ysB0SmrOY
 zzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856924; x=1763461724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2d/AzQC6EdahU6w8Pku7xRAbXQexLsJDKD33bKyFb80=;
 b=klJoGG0/+tHiupYloNubbWhQoxvJJVP615adfeERSDtZKyuhZl1h5WJUvWOiN/ucf4
 GO7EkxZ/4TdKoWRHb7yN+ugC7fmncIzT0kedRKsAg2dWHiKzICXwy1fDuCjEl6CVVWli
 9lsUF0D0CwEgNfXE+/WS9d8kf7usp4IQN8f1NkSWT9sAQydsYiotbn55cTai6iGXmKco
 PPrODl5I+4jZiNHrr718E6E2tjkChCAIQ12/5jbmMb+OCZv6FZphnFJVZ1GA1BcrUxAF
 ei6YzG8RAvwiiU0jNJZft62fz3Bu2uDJJ+HQDOnRrZJxO8i1HwgJv62Ev6DRR3MnBSXs
 FgGA==
X-Gm-Message-State: AOJu0YzAWwzXWEGF5r1J+iy2oVA3hyVApDA350e/GnmH8KrpYkrY2/iH
 FhB8ICId5BAFV8J9BjGwEMK1VAJOF2nkIMvNXsGQ5ATo4c7H7tTbt2luDPY/GS+c
X-Gm-Gg: ASbGncuEiYWHYHxGqZs+ogzFG81VNYOW8C56+iZKHhkxkg8k0bHcIjz6PfN74vrDUOW
 Jds3fNCrhgvYx6lsCvun8ezEK1KmPvif/tiUgvBWBiIsZxgwPqlSiLkbP6bbSFV+nCDlcCYc4xh
 FzlTVh936rVyMF4ALMTRsScc333qvcvK6MCND6djgieZZN5FFepLh36YMIEJ5p62AA0RqusWxKD
 GkRMZalrw/5/aKn5Xjoh1JVKEeImHgDf7LBROKaaWoo1kZ6pMPY98WKnDSvWUJC3Z/Erj8z8SFw
 f43OclchsV3Cytxc0hA8tg7dp4fBTF3A42G60jSxqwUobpRS96WuoX1luGR/oTcKkaP6rP49m3H
 5MgV8oDrND9dGHtoc0pOQHHzfVg3wPimMRq2ANMnlLEuxRTcy1WBEteOmszkj1wmXEaM1WBBbcm
 w+rWjWbWuWWJRNJ+z+sOPTpmtLdXAnhBdT
X-Google-Smtp-Source: AGHT+IE+wJ+sRgqecwDlXbvjEd4G0KlDZmc8F8DABZcMhofslmCSVluAvzwAh4m7v+HCGpaq4aEnZA==
X-Received: by 2002:a17:907:7204:b0:b72:adff:7ea1 with SMTP id
 a640c23a62f3a-b72e05c1490mr1157054366b.60.1762856924276; 
 Tue, 11 Nov 2025 02:28:44 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:43 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 07/15] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Tue, 11 Nov 2025 11:28:28 +0100
Message-ID: <20251111102836.212535-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 53bcf49140..512a33b066 100644
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


