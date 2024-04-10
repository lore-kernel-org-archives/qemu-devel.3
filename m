Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC62BCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaTD-0000CQ-VX; Wed, 10 Apr 2024 12:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaT0-00009p-24
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:33 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaSv-0002Yj-GT
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:06:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e23bbe06bso1765346a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765177; x=1713369977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qtkg4POGe6isMYcrXvpVF2IG6m9MMiveeMLsCwcT+VQ=;
 b=G6Tg/+7vqom4SNpdVIX70ttnwcSqmozkV4XRrB62f/sBjYNHlDrAeIM0oE/kR+KBma
 q2Vln2RLSFBrBYt/g1N/OsR1qBRIYblNhYQpEdWKX0JRQJtDWH0hziAN+CCCMx79vSyG
 cPjDX3eigUsYmdAxgnMJwvr9/KZiv/78jjfBDZnTf+NODkuJKuPHx3zJz9bsbxSOXw0y
 LRoVSBldmYdvnvd9kVfszBe2d2uN9Og/JltDYrjC2bbzoEG7KPrq/ZDWaq8nn+IpyFL/
 R8VoJIrWOt+ERWf44wIe8zKMD9cRMtSstpoknlkvMc39a1UZqX54KbzErvKUYJETPjdn
 RNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765177; x=1713369977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qtkg4POGe6isMYcrXvpVF2IG6m9MMiveeMLsCwcT+VQ=;
 b=iCeidnlZ1nCQiCuolOLjt0DerXu6GNqG/d2BAhlLmWAflJbrQdmfCGc5npTBtc8KTH
 YlRvqEwybfJIw6yGFLsEIH3LLYpOoYKTw6fiPfqmJPmL+TxKvBfibTK59SMcXOnramJy
 R5Vkls/joYxNZr4C3MIZd+68uEXRbgKpRj46/usAOwewIglXuseEP/GffHUSuxpjHtU/
 uH5Wpv2j86dNMTdZbT4lLwc9rUj+ibmy8jSIPbZOjJ6/syhb2nM4o9urKwaUnTVyOcWD
 7eUypQZ7u5/WvIEW3CmCcM2Vgck0iqfM45NOO/gQ8U19Tj+MgVOFlQjxsxX6KPQy2dyl
 18Lw==
X-Gm-Message-State: AOJu0YyRJ4SaY28SDtxLLZg00gxScesS9+A8LddsnNqlaN2Uxs0zWHyQ
 Dve+LnB4rw6BsYDFC3Q+3BbWuu+A3LTti7JcsDjTLEtwWtXhxPV4EtGyxPm7fKRRGHVobgz88x/
 A
X-Google-Smtp-Source: AGHT+IENNDBjgB5zP3wFtVbzCY+JjfY0BHT+HQMjrnfqWD02zBru2t8OP7Iza7z+MLaShI5EZmD9Ag==
X-Received: by 2002:a50:871c:0:b0:56e:3088:49a with SMTP id
 i28-20020a50871c000000b0056e3088049amr2567624edb.37.1712765177225; 
 Wed, 10 Apr 2024 09:06:17 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 i2-20020a50fc02000000b0056e22be831dsm6544900edr.42.2024.04.10.09.06.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:06:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12] misc: Remove sprintf() due to macOS deprecation
Date: Wed, 10 Apr 2024 18:06:01 +0200
Message-ID: <20240410160614.90627-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Hi,

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Suggestion to avoid the super-noisy warning on macOS forum are [*]:

* use -Wno-deprecated-declarations on the whole build
* surgically add #pragma clang diagnostic around each use.

None of these options seem reasonable, so we are somehow forced to
spend time converting each sprintf() call, even if they are safe
enough.

I'm so tired of seeing them than I started the conversion. This is
the first part. Help for the rest is welcomed.

Regards,

Phil.

[*] https://forums.developer.apple.com/forums/thread/714675

Philippe Mathieu-Daudé (12):
  ui/console-vc: Replace sprintf() by g_strdup_printf()
  hw/vfio/pci: Replace sprintf() by g_strdup_printf()
  hw/ppc/spapr: Replace sprintf() by g_strdup_printf()
  hw/mips/malta: Replace sprintf() by g_string_append_printf()
  system/qtest: Replace sprintf() by g_string_append_printf()
  util/hexdump: Rename @offset argument in qemu_hexdump_line()
  util/hexdump: Have qemu_hexdump_line() return heap allocated buffer
  util/hexdump: Replace sprintf() by g_string_append_printf()
  hw/scsi/scsi-disk: Use qemu_hexdump_line() to avoid sprintf()
  hw/ide/atapi: Use qemu_hexdump_line() to avoid sprintf()
  hw/dma/pl330: Use qemu_hexdump_line() to avoid sprintf()
  backends/tpm: Use qemu_hexdump_line() to avoid sprintf()

 include/qemu/cutils.h   | 17 ++++++++++++++---
 backends/tpm/tpm_util.c | 24 ++++++++----------------
 hw/dma/pl330.c          | 12 +++---------
 hw/ide/atapi.c          |  8 ++------
 hw/mips/malta.c         | 22 +++++++++++++---------
 hw/ppc/spapr.c          |  4 ++--
 hw/scsi/scsi-disk.c     |  8 ++------
 hw/vfio/pci.c           |  7 +++----
 hw/virtio/vhost-vdpa.c  | 11 ++++++-----
 system/qtest.c          |  8 +++-----
 ui/console-vc.c         |  4 ++--
 util/hexdump.c          | 33 ++++++++++++++++++---------------
 12 files changed, 76 insertions(+), 82 deletions(-)

-- 
2.41.0


