Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94E6C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNVn-0003gQ-75; Fri, 08 Aug 2025 09:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVD-0003Vg-5B
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVA-0002Gn-Py
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b785a69454so1238805f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661077; x=1755265877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=biukNyNLYj2YKv6lz0uhsiGlEtJOutmbXn7faU4jjQg=;
 b=DFiS/MOvuUxOPGGOP/oGmNrXQkUhjjWq00r/LD/8d6KKC9L+mN+nebKfmXD0T0EzXX
 HQ22MNAtjleyvhjgUy/v7KQ7FsBwBhrTlDvTX60qrWDmZTIZyy5wKj9vBEK2gU7OD04H
 wP9bYdkWumJ+v7uorXWmZGf3CV6bg0Z8L19YDxrWkEfOmSVI5c7NPXxPulfF3lSD14EU
 51GD9gNDboeuJ9wUpXFkKbtSTXez5qYRuNCbVEtZwcMc37Q9dP+QIm6/SUDhTe9MPj97
 xJT09UvQz1lBfKKq2AB1HrSMZ+HFymZ5PpFQCBFZvCB4vbllSA1IM0vksxpLa94Jt24q
 MYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661077; x=1755265877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biukNyNLYj2YKv6lz0uhsiGlEtJOutmbXn7faU4jjQg=;
 b=etFo3lDGbmJdrzOAWvn4AS0JwlmBRz++ENeAJsfzEQFu66RJeGBmEmuVAjY96rmhHl
 cRQW41TNVNOqCvXbJlorifZ+mk6pu/FZL9bmYLaW49WwWd1LwJaBrXWIJQ309Oivu+A1
 IQmXMDf+XYC0CXnnvslcLRJpEbNQGrIpBRld0QwiTidLt3ynR5QDJb0RetW6MnFLIjq4
 GZ0FuvYZGVc97lEDXISXUXXDZAjnMmMa4vSSyFKPDVwAAKKeSj4tVTc4Wj8kuDbUPND4
 PUp226cG9zSphadM9479Lh+xqaG9Yc+VXDY1MbSE7UfXmdioq0UKaRyPOqHerlwUyoR9
 a10A==
X-Gm-Message-State: AOJu0YwYBNo0Sgew1P3rYeidYXWe3r4tzIO/0MwARSfzkGxIlN9hbodX
 9g9YAXvQO99UcDJAtayO5Or0ZDWB1Msu8vcfvi9maDWtPH2pvCb4my/URf70aEq0SGwmIs11RuF
 mZIKz
X-Gm-Gg: ASbGnct2R1haGD5SyxdsSBXGHG7nCjL6DE1RKtJ4scTRjbXeaQIGagkTEnUavK57s/s
 Q30gdH2zPTw7yxiHJTbXdfExGemKUXN+hatbWSCU5SyLKVO4IeJLvf5UUanTjuvdY8cSXMMgKNT
 luJKvZ9WzCC9bg+2J3n3a9XC40J8M27qdwfQ6cEZ24NJN2EV5Fk9Hr12YFlvlQ6xWjlcN1vd/Vs
 IvVDFijz26QRdQYT8OpYiWB2W/aZyTlFhfmxbZRH6/dlbuIj13ccA20gQzG6HjBCatG8n6qVtIr
 u3cwcKJmaW+F/xdSxwPDLv06WV89svP+dvoxrCB6h2cuPFpD4PC9bEZUxSROUWNt21Iv3t3w4VN
 edvow0x/9leBuaQ6vQCWREu1Mb+yTsMvHzzkeSDPE+Bqn9frVTWeIob5Oz0QTAUFkaAvwQGH9
X-Google-Smtp-Source: AGHT+IFAsuzEdFVn1Y1yktnXSP7JR1iU51QdI+ig3MK8CHl2toQKS98jJC2oZd5G22H3C37zyCHMuQ==
X-Received: by 2002:a05:6000:188f:b0:3b8:d3cc:8dc with SMTP id
 ffacd0b85a97d-3b900b5040amr2669729f8f.28.1754661077220; 
 Fri, 08 Aug 2025 06:51:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm31134697f8f.24.2025.08.08.06.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Aug 2025 06:51:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-block@nongnu.org
Subject: [PATCH-for-10.1 0/2] hw/sd/ssi-sd: Return noise (dummy byte) when no
 card connected
Date: Fri,  8 Aug 2025 15:51:13 +0200
Message-ID: <20250808135115.77310-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Trivial fix for the issue reported by Guenter here:
https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/

- Return dummy byte when no card is connected
- Add a test

Philippe Mathieu-Daudé (2):
  hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
  tests/functional: Test SPI-SD adapter without SD card connected

 hw/sd/ssi-sd.c                            |  4 ++++
 tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.49.0


