Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmWV-0000WW-Dc; Tue, 26 Aug 2025 01:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWN-0000UN-GG; Tue, 26 Aug 2025 01:47:04 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWF-0007ES-Oc; Tue, 26 Aug 2025 01:47:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2eb6d07bso4398293b3a.3; 
 Mon, 25 Aug 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756187212; x=1756792012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6oy8OkyoxoCWvgcIQjEdmPLeYXlsxxxzgt3nlMA1C8k=;
 b=KI1ETV4GUuBrWTt29zOqMHOtb3+j4fSmR6i+UYoG7NRHzQ/TRM8MVX9fJ4k7SC7kVV
 NnYPj7isUNPHziWQsBLEjDcEUrDyd/BwywNNTOTKSW8kKokE29fkiXDkmzQ8zIp/u1lx
 xKcmrRRRalXh5+TXICxacMQ4vme6UMk2/JhWAaq3BATI9z8i5vvaNLRPlDQIhYhWUIIj
 EwCi2HQQ1TFmx/h1pzMtHwCrjtSuKhObXhsFYC/HjsIl1LnD4/cqqHL6TMo2+iZZYQbZ
 N7Sd8SqfeRsWKoSCLjkXIhTxuGSaBaVNKKqqqIFlDu9OUSLd1rjJ1N+ScnsXQk2OFfWE
 EFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756187212; x=1756792012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oy8OkyoxoCWvgcIQjEdmPLeYXlsxxxzgt3nlMA1C8k=;
 b=Nt/KFy0nblsIbmpCtnD65VLXi2SddeXc/Ez5D8kf6ICuTPbiJwY2iKZiyUvhwYoDO+
 iSRGbcU0gqpU5sXl7QI6us/UnFHo+nPFCOo8gFF9GXFEcZ1MRibMVgDJafLm7DwLUkj7
 kmMCNGmDPXCB+k/4vocvtPZp+FxXTW1wzmTCJMinpYBnJcmBXiHgVC3U3TP43czCZFeL
 vIPrBY2hO8qcgS3MBdY8t56j+wy/3paZH3VfVB5kyoKaUSd/Xjg7oDkp8GZ+gT4gur/4
 9MqaeXRXMJnsvABHnMiTvDCmqXEupslu2WQFMo6RyOK+RexRkEOSUyGCDKl+jBRmbVA/
 lPrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGiXdLUYLnSKxpGxVbqkq8vitaEDUCkIUOmZidjBZg82gOf1FYo73lEw3RmZ0FAZxC49QGjDeEPcoUQg==@nongnu.org,
 AJvYcCXx5lHlCdie8ZLcZMOXQ04pENqT21z8Lj1ia4f+MdCgJFEomuHsmOKQcwICqzsWqjKrgbgWpIfYsmGd@nongnu.org
X-Gm-Message-State: AOJu0YwvY71dc0yQQrp9PtfbActsZaGE5BTBUuWq0ynPwyUphTdqTuml
 g9RuHbORdHzd2ZZU9RQCLwl2uLDWJhaFR5gsOTKrOdnuZxraRN4pocKt
X-Gm-Gg: ASbGncuMhwiV7UUflPTsKXMvReyx30ktdnZ2ZV5EthepYduOvn+S2RUG8Fn9vzeuB0s
 ww2PIwJztPSFKdPbu2YRYIYoEVEz5Cm6zWewhIQ0Kzq+4a46cOEInAIoySU5sMfMp2tKU7lzOp4
 5O/humClDijGakq4hxygY9qtD0DuKVnp4FJcrOhew/MDJAeJiVyNJShyRUNJP3Dhzk7LQUPLrjf
 e9B77No9gPui16HTptkwlghswNUwGbq65Qad5q9aohtrEJuGI/ya9g/eGxzMWxfNc+GdmAkwyo5
 FbU3AzVPxtr67ru8lp4Jlxu+S7+HwZrYOrAnosPoEU5nJpMfVJlCt5kGohqWOQGew95UgnJfxVS
 EALXf88YKayL46kGo0hHi6TNTEg==
X-Google-Smtp-Source: AGHT+IEGtlVn+9kFaShhiYJZ0A/MF1Z+FEYNYmN6YdU70+w4nsohrtKAdrSuTnARHLMjP3HBREe31g==
X-Received: by 2002:a05:6a00:218a:b0:76b:d869:43fd with SMTP id
 d2e1a72fcca58-7702fac69e7mr20450969b3a.18.1756187211675; 
 Mon, 25 Aug 2025 22:46:51 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401afdaesm9032365b3a.53.2025.08.25.22.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 22:46:50 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 0/4] NVMe: Add SPDM over the storage transport support
Date: Tue, 26 Aug 2025 15:46:26 +1000
Message-ID: <20250826054630.222052-1-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This series extends the existing SPDM support in QEMU to support the DSP0286
SPDM Storage Transport [1] for NVMe. SPDM Storage Transport uses the NVMe
Admin Security Send/Receive commands, as such, support for these commands have
also been added.

With the addition of a new `spdm-trans` CLI argument for NVMe controllers,
users can specify `spdm_trans=nvme` or `spdm_trans=doe`. This allows for the
selection of the SPDM transport. The `doe` option is the current default,
`nvme` would select SPDM Storage Transport for the controller, where SPDM
communication happens over the NVMe Admin Security Send/Receive commands.

Support for DSP0286 already exists in `libspdm` [2] and support for the QEMU
SPDM server is being upstreamed for `spdm-utils` [3]. This series was tested by
using `spdm-utils` as the qemu SPDM server with SPDM Storage Transport support
built with `libspdm` v3.8.0, and `spdm-utils` also as the SPDM requester.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0286_1.0.0.pdf
[2] https://github.com/DMTF/libspdm/pull/2827
[3] https://github.com/westerndigitalcorporation/spdm-utils/pull/139

Wilfred Mallawa (4):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  27 +++-
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 264 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   1 +
 include/system/spdm-socket.h |  46 ++++++
 7 files changed, 351 insertions(+), 17 deletions(-)

-- 
2.51.0


