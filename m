Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF39D3E78A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 02:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTWqs-0000d5-C4; Wed, 10 Dec 2025 21:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWqq-0000aH-L0
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:20 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWqp-0005Ad-9r
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:20 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-343ff854297so662306a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 18:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765421777; x=1766026577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=11A3yeaklOY7mKV6ItYwPBCa1g1fu+lM9TmhAd24ieI=;
 b=P7rCmsfjh3BO7dzi/QDPU6GJLKtf9SFragFbTQCYzoE+auOw+na1lptJkejCi4zF9w
 qqIq8uZj1Up2+sMwkO6MhMqivPoX3K0zyTOowzoW5ZqP1GjG8NF0IHOj8HkQvh32th2j
 7Alf93yuXydLT2O9eipUbYmvacczijXi0kR7YBcFktcX1JYLSv+wKSHtkGYlY3KOLVds
 gg4YV2KrqOAco8cZ1wI4/IhMMRVqYkJPfqGRX0qS/S0Wf5VCGlvTjoZydhmeiPfH5abI
 Ns7GeiuET0T1z/Bw4mh2CeMI59eGq/DnZv3N55sz+/DXLE1n6tp8E2sUsdElqdeTJe0c
 6WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765421777; x=1766026577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11A3yeaklOY7mKV6ItYwPBCa1g1fu+lM9TmhAd24ieI=;
 b=s9R+M8H43KvwAx1gePrLDIRLsZK4yqO1TQEUjWoNEP4OmhwdXB7KvAZU4Qy/n4IZRg
 tZ0oAUm+bYzUPdvP4KeL8PV4UTRdnLvh+x6n3zuoOzEaXfVTwN36G2BNiN2PwXah0DE0
 aI6UfiIgYMS49pN5tAbxHNvpHryARKFEmh0Wg/fzHQ2WbUeMgCfKCjU+lset48tepc/D
 rssCyuh+BU3S0BipVEtlgvNNktnov8pImU3pKIXwUz394z5Hj8pJ/9kxQf9DWWAGT8i7
 TcrSwVz1aGha2f9mhiF6g8KClthOtfKFZtgfCaAC/w4KkqX/v02xbwmaUmVCgnzKJcoB
 9qBw==
X-Gm-Message-State: AOJu0Yxl6MafZkEr60qooqRq0u35TS3P6+K1+1Z1gBKz/C1GUF4yRmz7
 h/QirHETlaCqAHwsaQka214yMockali8swy8wp6vnaxmwi4THP61qdGj2LrvnvHVtpmLiTZwy/Z
 0mxqUFBQKVq5lPOhySOTHK0pllpV5HdbvvlCpSYYzZhD7Shkymu/+TmmYMnA/jI+OegE/SOvsKO
 UNJOzRLf/UryPFv00NYekrER2Z4uP9Hv5Hs63ejv4r
X-Gm-Gg: AY/fxX6RcNYbAQLS014DVPAVicQQiC0EvDkQ1O4E4I3Q/viC5GSkDah5x1yOQD6SC81
 U6H6iKW8mS4jyRv9bvru2nQJh6AGZBATlNscwNhmEx+kITn+lKmnj+wB4bcS6X6Grc1K8JQfW1e
 y4Z6ev9A5HvcIwU4PwcVjDSEVDwk1ZO2j/GTkc8D0e4kl0xjTOjC463K41qFajjjpuehRH4kR70
 sBiklmLoTKBxCQ4NmQal4Qs7nz5jjAZofKRsr+kRFDL1Bvgc39DrHkvR1O1qzG7s0Hy/t+0fgGc
 cE7ocm8KmpdBs1uGT6+2nf+DwOXaNHA/Z8F7WSp2CW38492cmxJU36y/tNdpWPlsfkusb9ekn0/
 nqD5zehLYw1lGH53R5NGlI7FkkhhsT5rn2EgPGqtVLrIFI12TwnBBjOQeX0vq1pgGwuVIqOPg8p
 wu7Tfj5l6nYP44DrwL6T3/YhuVyGw+bpnEmPZwFWA1ffj9YSlXjw==
X-Google-Smtp-Source: AGHT+IFe2QHF1d2a2fq7OHFK12zbdTCFduXMMJ58/klvLvCTDQqJma7/p32mvegR2jcb0HBpVMinUQ==
X-Received: by 2002:a17:90b:50cf:b0:32b:623d:ee91 with SMTP id
 98e67ed59e1d1-34a72917938mr4102368a91.27.1765421777145; 
 Wed, 10 Dec 2025 18:56:17 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a926de17dsm70870a91.6.2025.12.10.18.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Dec 2025 18:56:16 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH 0/2] Don't insert DDT cache in Bare mode 
Date: Thu, 11 Dec 2025 10:56:09 +0800
Message-ID: <20251211025611.99038-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When IOMMU is in Bare mode, DDT (Device Directory Table) lookup is not
performed. This series fixes two issues:

1. Avoid inserting unnecessary DDT cache entries in Bare mode
2. Properly free Bare mode contexts to prevent memory leaks

Jay Chang (2):
  hw/riscv: Don't insert DDT cache in Bare mode
  hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling

 hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
2.48.1


