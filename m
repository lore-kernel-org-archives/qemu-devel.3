Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C6CA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJX-0003ev-Bi; Fri, 15 Aug 2025 05:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJU-0003cB-Fj; Fri, 15 Aug 2025 05:01:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJQ-0005mF-Jm; Fri, 15 Aug 2025 05:01:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a23def5f2so566855e9.0; 
 Fri, 15 Aug 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248482; x=1755853282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vawIzwmzl7x6M45nvP0NuxtDTp5R+Phklc/iV4Vde8E=;
 b=P/iBcTLW/dJlzWC5Y8E2bBPRIGYHgWKU+p5+ROt4VnRomVqVl702/x3KPImexW/07W
 yEICF9v2/sR0oQE+WJnY95ACyozbc9xbTqSR/vzwGu5gGwYGo/gI7paTjaVtZApQ/ECw
 8wm33o3CjrlFz243lUkKGS+8WISqW3lDr6LR73FtgTSb9JSugW+4WoWmFf19GoYTHy7g
 ZRvCMvsimxKQyxyPLf++Jta3LevvfskfQEgHYWvRTtQOpuDREuCqkifKjTU+6hqVwgM7
 Chl0CLyGbmsTDNV0k5H09q9YqceeDRtZl0Rw9CdTJJga2IV1DtrE8Ls1w1GG/ojXtlFh
 zO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248482; x=1755853282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vawIzwmzl7x6M45nvP0NuxtDTp5R+Phklc/iV4Vde8E=;
 b=L96bcnjtf4YNPqW2DaIIYWIfYu+GvkK2WuZuIxk4N1N0kOXRjEKj+rlpHWmGARMjLW
 XUxHW1VOnvXZlK0v7AdoT1erdRE3tfQ/Q0C4tMG7/wNzEXefgIIQJ0NaC49II0dUFh3L
 HCDxhMT+3TbHy0Oc0T+RPhnwGn4nrMf3vrPnXIvPjkbHTumtCUzoCpqz4fIRpadVI/zI
 F3F7otP5HPHVBdJQBuyRNajcTlclpILGiyVtMMMjw/aFZHV742DwVkShllhbWMepNOpV
 pTNiE4sP/jI3zHS5ppj6VFBPK4ZbzttzTdhFvyHQMozc7mWbPLZH2LdbazxM3RJh8AHD
 xNBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRaA8gfVcZTYAuYV0joLwB+rnvHYLt3LrGmRnNMbed3s7lRKGfRiOv3IDZTmJiPTdV8ZFd5lexcw==@nongnu.org,
 AJvYcCXdE0/N/08yFuHg1jzslLHF2XdFDd/oYPt7jYBMtqos2SWAlOS8PbLCtQ1osES/ACIvnjbgrrIh2NyNCA==@nongnu.org
X-Gm-Message-State: AOJu0YwKU/tSmbmrUQJ40O0yhtTURlzCIJ9rTSkDzxismBXiPk4SxMoz
 G2b1M3Qs7d2N9+GstMByJvselEuBXPu62eppgpCFJERSDq+5i6PoHcBBE/krYQPH
X-Gm-Gg: ASbGncsge5AStXXQmIig1QJezp2vWNjCANWEbxSrfb9AuCpcijJ4yNjM4nq8idQ5Zu1
 dVmKdXNeGUvgWR8I1pQy0ZNGtpnnDJ0FwabN4kOPKJTbe0IQLntRAYdsYKo/svzsR/sLGxjODZL
 lNVzQtGTrdTjKBnUGG8ECAmu/14Gya9KDoZn0uFp0YqtvQU/QYnWJwlKBFqlFPe7PNUu2ikPmv3
 bv/QjlOzNsFRoeuDqHzmrZiFWyA6Oj4wO/a01wG+g1HpqWDIu2ryGGK4G/kJ6UtwzcMLiHiZjG2
 s+yjKULvLU2tLdIhDKEXtLbS4DSfQ+gcQ9n+SrXNNZBoyYEkD3Efpyw77+nnny0PdeLlaBA3KBf
 MoSPadgv0kJr9kvpwnCplxPZBMSh29EOXW2lb8XbP20OkLQ==
X-Google-Smtp-Source: AGHT+IFZcFh5MwVeSg4UkQ871q2k+C437nLtisLxXZY7NR9xeFIr4DtwqX4JNMgzMnGNp23+l2YAGA==
X-Received: by 2002:a05:600c:4e86:b0:459:d6a6:77c with SMTP id
 5b1f17b1804b1-45a2186461emr10794045e9.33.1755248482132; 
 Fri, 15 Aug 2025 02:01:22 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:21 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 08/14] hw/dma/zynq-devcfg: Fix register memory
Date: Fri, 15 Aug 2025 11:01:06 +0200
Message-ID: <20250815090113.141641-9-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32c.google.com
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

Registers are always 32 bit aligned. R_MAX is not the maximum
register address, it is the maximum register number. The memory
size can be determined by 4 * R_MAX.

Currently every register with an offset bigger than 0x40 will be
ignored, because the memory size is set wrong. This effects the
MCTRL register and makes it useless. This commit restores the
correct behaviour.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 064955a0f8..83570ccfaa 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -393,7 +393,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
                               s->regs_info, s->regs,
                               &xlnx_zynq_devcfg_reg_ops,
                               XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
-                              XLNX_ZYNQ_DEVCFG_R_MAX);
+                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
     memory_region_add_subregion(&s->iomem,
                                 A_CTRL,
                                 &reg_array->mem);
-- 
2.50.1


