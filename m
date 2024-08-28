Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83526C54FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxT-0004Hc-Hf; Wed, 28 Aug 2024 09:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxR-0004GY-Mr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxQ-0002KZ-1t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso74553845e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852610; x=1725457410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnpFdezWBkNzeCUXHokhn/eMQxpgjho0h8lR/o8L3Rk=;
 b=TGBU/Yy6kJM58emu0pSmIUCEONjv5NY97CIVMbpWdB8C72SDLoL0gpHqWePcdePhpY
 ZMyXpZ52WsDttUG6iUH/l5aJiOI9A13nT+pKYTvZe2oqqFqJLNr586OQble0WSZEJb6w
 6RYKArOQjCG4VHQJ5vu19ScwG5VbTvLJY3junt37VqYJuR0DOHiCw+uGU7wvHloJhl+M
 7q56p4IuTdiCtIDyBVv/mMrJbgHrgCwGEZ8V21b+GE8pTCsOr2GBxmTKu+XnuerZ/t84
 j5XI22LuEh7QuptHYQI7N2Vma3a0V4oMfyI5pD/fnTTwz3bjo+WA75ycsCPFrEuqtYyR
 dJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852610; x=1725457410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnpFdezWBkNzeCUXHokhn/eMQxpgjho0h8lR/o8L3Rk=;
 b=CYK4nJm4E6NEQFMuaduFVQAkXq0/haSS9DOQcthWTQQRJp4cHuH65es9FFiQS8rg+K
 j5QirxRbshIy3SLsihEDVou1VUY7dXEfgpLQrRMixOQcWErPTf04VdNY/WIyqkvn1RRd
 y93mHFEYGe8LBJ7gOlAUe+fqjYqIQCqwVhbSTgfxFelID9Tnc2mdXIEsNsOENnXVeSgL
 3RTcwwlvqvj3WVD9q8Fjzy/trxLR/D9ohV7lM4BadasX4UoUlQwTMYwe3ci2+fiQfkRR
 Bh+60JKpjtEeQOWR5dQdSYjrdcXB+A6rjIPPJ2+XjRXhC0JMvtWa1dmDV7GcXOUbo8dU
 +L3g==
X-Gm-Message-State: AOJu0Yy8OR2pqCf4YANko3hgFEZIBch/YS+bpRND38igPJvLoRTsBBZn
 JD/SOsQm39nwCLypN3bJnQPW1E4aDoFU1I34JwX72Po1mDHNO3DlgaPouw==
X-Google-Smtp-Source: AGHT+IGvzbCjFRhJ8g9uyDVNE4EwX6DEwKB+VjNVPuRTrtmGVFyj/j0ulILummyKsy2tN3xKQWWfiQ==
X-Received: by 2002:a05:6000:1081:b0:368:4e35:76f9 with SMTP id
 ffacd0b85a97d-37311864df1mr13011911f8f.37.1724852609971; 
 Wed, 28 Aug 2024 06:43:29 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:29 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 0/7] vfio/igd: add passthrough support for IGDs of gen 11
 and later
Date: Wed, 28 Aug 2024 15:43:21 +0200
Message-ID: <20240828134328.94528-1-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Qemu has experimental support for GPU passthrough of Intels integrated graphic
devices. Unfortunately, Intel has changed some bits for their gen 11 devices
and later. To support these devices, we have to account for those changes. This
patch series adds the missing bits on the Qemu side.

I've tested the patch series on an ElkhartLake and TigerLake device. On the
guest side, I've tested an EFI environment (GOP driver), a Linux guest and a
Windows VM. The driver of all guests are able to use the GPU and produce an
output on the connected display.

Corvin Köhne (7):
  vfio/igd: return an invalid generation for unknown devices
  vfio/igd: support legacy mode for all known generations
  vfio/igd: use new BDSM register location and size for gen 11 and later
  vfio/igd: add new bar0 quirk to emulate BDSM mirror
  vfio/igd: add ID's for ElkhartLake and TigerLake
  vfio/igd: don't set stolen memory size to zero
  vfio/igd: correctly calculate stolen memory size for gen 9 and later

 hw/vfio/igd.c        | 185 +++++++++++++++++++++++++++++++++++++------
 hw/vfio/pci-quirks.c |   1 +
 hw/vfio/pci.h        |   1 +
 3 files changed, 161 insertions(+), 26 deletions(-)

-- 
2.46.0


