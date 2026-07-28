Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01044C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woqRa-0007D5-So; Tue, 28 Jul 2026 18:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRY-0007Am-Uz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:36 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nodokaorganized@gmail.com>)
 id 1woqRX-00027f-D6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 18:38:36 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ed2a00f12so5931727b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785278314; x=1785883114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AwLlwqIULYzs6brU2iW3maT1jYZq1OENqElphuHRRCE=;
 b=ipvNU6Pgb9KVbd/aWZoSBe53UD9E64hWddk/qzHgRWkygsOfSzaRwpdtY1ffC70UJx
 iM1Arc39rSspwTKkf2ZQszWAwxf02ZyLYLHyghuEXBUfHZQ0KqZsDyNIpU6OUI4l40zu
 Bjfwj37Y7qJ8VzpxP3gANlZ70K6BH5uIIbIATugjAIGyl7nvoOTUfv54rpgsq+Q4d+O5
 a0VrbVis4HPzIGINqyPSR+/joCLik1UV8PUdlqI2JBVR0qWV3y+B858Hnglpqbs96Y/2
 b5WA5U622t4AXHPNXNGiLYe6zEMdfGOvKvM3NV9BNLRaZ7UbmddbfbfYo7abtQHtmTV1
 pViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785278314; x=1785883114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AwLlwqIULYzs6brU2iW3maT1jYZq1OENqElphuHRRCE=;
 b=ndR9790KsndXMRlk97qhuComupdnLI6fxutaeSOphzzXJszgSt6a5SooXK/Ip2forG
 8EuqioNOYFrrK273f0w3ZLkcaQAR42IFwWna2mc4mbpZab7AetmB/kQyW5DHH+rNzhUZ
 cDt5NBq9f50bI2E3ygQaqD0G2VBlURjmLvfunaUUnXL8LHs5E5bSugX7ztahXA4/NuAl
 ls20u/XifPC+8FHgw12jLgkBL2/qgp4CbeZPKaIghqjhcVm+D9calrp00wmSZGMyuL7N
 r0OSzBTEGPJZc+jMebLW1/1EYuNPgb2n0nu33kFyRra4hiIHnc77V7+gWNfS2jMcMI+m
 SsxQ==
X-Gm-Message-State: AOJu0YyR7QE2EbDYOSG8tI1LK4A8dzUrN/ZrFzg0uWE17DDsRQBL/oes
 tr3pytv6a8hdeVczQCrnsK12UrdDdQPhwT8esB64XWzcUGjFtPnyX8w89ZOAUjdU
X-Gm-Gg: AR+sD11DtV1TZfH9KuB5pkcgZpPd5hz/ilR+2zsCVJE8Toc5m55Kx646NViHIZ3/IRI
 adgJv5aisbzDrSZ4qGehNtM5G6/MGUzBuZ43MMnG+nJc0lMw3moMQ0M0Ev8k0K6rwIt3gColnMJ
 eBtZTTFZkdEgrfNwlh2RnoTKyvjwVsxGmXwr12enUtdGRQiUQdgcqFMNM7NpULb4HYfFO32MxVB
 X2L2NbXKKYPPO6x7K6TuYjEiFxGss/LjhoPhBFnBJ7jt2FvXy1PSNaxjVNAGN26yk0vBRF2oClK
 l4dUpDmFjRGqulCQubVsLEy9unPE3srQfu1rtLws1wGzLtk5srxewrljkq2ZmZk5Y47MSb3spTX
 G3UFO1OQp65Tzjw8TyGra0ZlfRgSBiuLkDcmpQuPYuS7fn5l45pPkVQ4OgYCt2PAnZbLYjOrKHi
 zXfxEgfZGC76H0kS0aGxZqse2bfvEdkO4tuMiJKKlzTd/4tK6JY1pcGrSsQac7y7FDXYPnaZtHY
 XGf5TF6dws2MV26N8IAZ30SnzRJtT9A/YaUuTtONI02PULKrrtgHWBq2rI3kEu4YjzjbmfQ+fAs
 m+TfXBGErgmWFTHqsYAp
X-Received: by 2002:a05:690c:3681:b0:81e:d8ec:d855 with SMTP id
 00721157ae682-81f9936c55dmr19427097b3.62.1785278313923; 
 Tue, 28 Jul 2026 15:38:33 -0700 (PDT)
Received: from ip-172-32-0-41.us-east-2.compute.internal
 (ec2-3-143-144-70.us-east-2.compute.amazonaws.com. [3.143.144.70])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fa27592e9sm7541447b3.8.2026.07.28.15.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:38:33 -0700 (PDT)
From: Nodoka Shibasaki <nodokaorganized@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Nodoka Shibasaki <nodokaorganized@gmail.com>
Subject: [RFC PATCH v2 0/2] hw/i2c,
 hw/misc: emulated Xilinx AXI-IIC controller + PCIe FPGA carrier
Date: Tue, 28 Jul 2026 22:38:27 +0000
Message-ID: <20260728223829.2613524-1-nodokaorganized@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260715221400.1484805-1-nodokaorganized@gmail.com>
References: <20260715221400.1484805-1-nodokaorganized@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=nodokaorganized@gmail.com; helo=mail-yw1-x112d.google.com
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

Hi all,

This is a follow-up to the single-patch RFC I sent last week ("[RFC
PATCH 1/1] hw/misc: add xiic-fpga-i2c, an emulated PCIe FPGA I2C
controller"). Based on the split suggested there between a
standardized controller and its carrier, this v2 breaks the device in
two:

  1/2 - hw/i2c: a generic model of the AMD/Xilinx AXI IIC controller
        (LogiCORE IP, PG090) as a SysBus device, independent of any
        particular carrier.
  2/2 - hw/misc: a PCIe function, gated behind TEST_DEVICES, that
        embeds N of the above controllers behind one BAR0 window and
        aggregates their interrupts onto a single MSI vector (with a
        legacy INTx fallback). This models a specific FPGA carrier
        rather than a standardized board, hence hw/misc + TEST_DEVICES
        rather than hw/i2c proper.

Together they let the Linux i2c-xiic driver, and any I2C slave behind
it, be exercised under QEMU without real hardware.

Changes since v1:
  - Split the single device into a generic hw/i2c controller model and
    a separate hw/misc PCIe carrier that instantiates it.
  - Added a register-level spec for the controller
    (docs/specs/xlnx-axi-iic.rst).
  - Added a qtest (tests/qtest/xiic-fpga-i2c-test.c) that drives a
    transfer through BAR0 to a tmp105 slave and checks register,
    transfer and NACK behavior.
  - Reworded comments/commit messages to describe the hardware in
    generic terms rather than referencing a specific downstream
    project.

Open questions (carried over / updated from v1):

  1. Is hw/misc + TEST_DEVICES the right home for the carrier, given
     the controller itself is now a standalone hw/i2c device? I split
     it this way since the carrier's register aggregation is specific
     to one FPGA design rather than a standardized board.

  2. The AXI-IIC register decode is deliberately partial: it
     implements the subset the Linux i2c-xiic driver actually touches
     in dynamic mode. I can flesh out static/manual mode if that is
     preferred for a general-purpose model.

This series is based on current master. Happy to add more qtest
coverage or documentation if there's interest in merging either half.

Thanks

Nodoka Shibasaki (2):
  hw/i2c: add xlnx-axi-iic, a Xilinx AXI IIC controller
  hw/misc: add xiic-fpga-i2c, a PCIe FPGA embedding xlnx-axi-iic cores

 MAINTAINERS                                |  12 +
 configs/devices/x86_64-softmmu/default.mak |   5 +
 docs/specs/index.rst                       |   1 +
 docs/specs/xlnx-axi-iic.rst                |  62 +++++
 hw/i2c/Kconfig                             |   4 +
 hw/i2c/meson.build                         |   1 +
 hw/i2c/xlnx-axi-iic.c                      | 284 +++++++++++++++++++++
 hw/misc/Kconfig                            |   6 +
 hw/misc/meson.build                        |   1 +
 hw/misc/xiic_fpga_i2c.c                    | 261 +++++++++++++++++++
 include/hw/i2c/xlnx-axi-iic.h              |  69 +++++
 tests/qtest/meson.build                    |   2 +
 tests/qtest/xiic-fpga-i2c-test.c           | 159 ++++++++++++
 13 files changed, 867 insertions(+)
 create mode 100644 docs/specs/xlnx-axi-iic.rst
 create mode 100644 hw/i2c/xlnx-axi-iic.c
 create mode 100644 hw/misc/xiic_fpga_i2c.c
 create mode 100644 include/hw/i2c/xlnx-axi-iic.h
 create mode 100644 tests/qtest/xiic-fpga-i2c-test.c

-- 
2.50.1


