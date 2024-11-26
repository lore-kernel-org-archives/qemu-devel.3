Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262D1D6552E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxR-0007Nt-5g; Tue, 26 Nov 2024 12:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxO-0007HT-Sw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxL-00020F-Tu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a1639637so17361425e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640549; x=1733245349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U619nSfSYW4XQ1QmRquoyj8F6Iwl0o/6CLdfCIYuPP0=;
 b=scizYW2tx7mMWMeGqdkv14hBRtI3EjM7JvuOWXpW8Z6Boim+UqPCpzY58ueAp8fQAb
 BWWW+7MBuDRLA3AJMIostGBuvuDNMEQz2OQMlD9DehbW/iYo+WjfdpQnt2fZrjNLakAF
 zFEDtz7jeYIcjgorqXd9C/am3XtTNPFDXvhaeIe2lcoocvEvpovBCKi7Ii6rzuQu6h1W
 RwLnRKbXqkAaFsKaW/68XUw7QA2z1ZjzZdEdMx4G2TQ0Q/U06HydSSMhUqZfeb5gTfaz
 F9FNY7jY6KWK02c4axOkBw7jLthdoAnIA1TRu71NfuhKHoVEQvQ00/6sk5REvLnVJYld
 okzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640549; x=1733245349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U619nSfSYW4XQ1QmRquoyj8F6Iwl0o/6CLdfCIYuPP0=;
 b=Dv1+x8F5U8X4pwTsTfyAOpicQowKk15D8jZBKU/6R9f/ukHgfM6AU6hFul8uEFJVaM
 VEIgYCbTnh3bvYmdjQAVWdbApgRBuf6ij2or3IU+DvoFdHDnbse6N2Wsb6BQjrj/+9g/
 U7W3FD6CKaENFSy6Tin1ZE0OupWSjfgbUlOhxJAsGd3VmwCfGp0zQyawpX6cEscYP4UP
 7ttTMUHfic/5100Sghw/vG7zBGeORCX+0g/ZTZdIRpb3zhy2svZbpfuqWce2eHnfxYWB
 B8EKvA2fXFb3rhYsO9qBdaN8cFaFmdmtI5V1EBbnSfdy6d2s3oD45Foc439CeRhQL4VS
 wz9w==
X-Gm-Message-State: AOJu0YxjYcBiVWv1n6tvBgZvZADmdmOMdmv48wqQwGVJLp+cX+6Mj/IG
 LMiitMYXj2N8InLVvTKIpuM4kjRdxqozxmqOozLa/RrfA1CkRkDyYER1wBF2Y6WDY7IZpIpnEAR
 d
X-Gm-Gg: ASbGnct1lgzZegLHIA3r0vvozbGHrFc+SRo8dGfbtqsqrm4ra3Lux4EUdSSU1020S2v
 Dgk7IRDex6KCPvwVw9jrDVUPFpXxqUrzH/5OpFti6v4gSfTh0MPJsndokqdgFsAaYtk2ROG6gAl
 FEwWLt9HtM9guqsD1kImTwq+sNP+GgEvRRPTyPVcv4kW6SBiPObnQFsa+8plrNFAS7lKYON6v4L
 JKV+94um6PnFrrSIleHzFJOkyI2S0Coc57nFefaQmtsWvLt369b3seU
X-Google-Smtp-Source: AGHT+IHZrmHPGl52jV6+aJkhux9WJIjok7wQZi0ZJ+4WEGoDHKNzfuwKwZNQrEB9WgqXOeU3dYB1ww==
X-Received: by 2002:a05:600c:4fc9:b0:434:a6af:79f6 with SMTP id
 5b1f17b1804b1-434a9dc7074mr240055e9.15.1732640546345; 
 Tue, 26 Nov 2024 09:02:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target-arm queue
Date: Tue, 26 Nov 2024 17:02:15 +0000
Message-Id: <20241126170224.2926917-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This one's almost all docs fixes.

thanks
-- PMM

The following changes since commit ba54a7e6b86884e43bed2d2f5a79c719059652a8:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-26 14:06:40 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241126

for you to fetch changes up to d8790ead55a2ef1e65332ebec63ae3c5db598942:

  docs/system/arm/aspeed: add missing model supermicrox11spi-bmc (2024-11-26 16:22:38 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm/tcg/cpu32.c: swap ATCM and BTCM register names
 * docs/system/arm: Fix broken links and missing feature names

----------------------------------------------------------------
Michael Tokarev (1):
      target/arm/tcg/cpu32.c: swap ATCM and BTCM register names

Pierrick Bouvier (8):
      docs/system/arm/emulation: mention armv9
      docs/system/arm/emulation: fix typo in feature name
      docs/system/arm/emulation: add FEAT_SSBS2
      target/arm/tcg/: fix typo in FEAT name
      docs/system/arm/: add FEAT_MTE_ASYNC
      docs/system/arm/: add FEAT_DoubleLock
      docs/system/arm/fby35: update link to product page
      docs/system/arm/aspeed: add missing model supermicrox11spi-bmc

 docs/system/arm/aspeed.rst    |  7 ++++---
 docs/system/arm/emulation.rst | 11 +++++++----
 docs/system/arm/fby35.rst     |  2 +-
 target/arm/tcg/cpu32.c        |  6 +++---
 4 files changed, 15 insertions(+), 11 deletions(-)

