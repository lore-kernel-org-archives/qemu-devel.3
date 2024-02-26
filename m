Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BCEC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWwC-00077r-Ty; Mon, 26 Feb 2024 04:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWw8-00076s-Fr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:12 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWw6-0003Uq-3N
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:11 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3f5808b0dfso379043666b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938364; x=1709543164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dS51kZ+UuDIYaWNHO+8DEMv/N1ViSJF+CA4Rg8KDWD4=;
 b=nrm7x3RaoOKOHJFuiT6O8sxWRHTYfH1DJlhYH8IwYcAftyr/CY45jVOCZFib0L3dTg
 cVD20+kiIELp0wquZAQ07lP/+Ja3mYIgwuAw1wlwjk48JnDHcTgOXzvQp7Gr74wPbZ0H
 fY3PAIoc6cJPLISu5s9y7CIx6+savB28U6G3hclY8wcPNjoYJHKSlwhn6HlKFoHmXsir
 tTsGSakbeqAJCVnkRSrnrCPVJOYrRBPfVRAYdzSNo2wS1mgskapEVd35Yt4GAZ1c88Jx
 A4z8BHsj+rPhI+Oe8Y+5mkcpeJ7wQGHSKHfC86kaJMwHGSbw8GyUMEoqZU+PcIboN0/M
 b0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938364; x=1709543164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dS51kZ+UuDIYaWNHO+8DEMv/N1ViSJF+CA4Rg8KDWD4=;
 b=MMkNyk7/V8gOw3NAPxo9mfSK3miPAM8UgA3X4dwntQgtwDvWavEGboHdtkuwcG2YNd
 8VJM0JM1HJi7ezcz6yGquJiz8V7KOKcUM59mhc8E5eyYyNdOQFUNQFNGljC7iRE+Udsb
 071cWF8v3TtoihHkTLtYxx9MystD5L5OmK6fWVt2usd5/BseKce0+ctqmP962AGdRdsP
 JNUWVKa2vLIzNCpKuw8dJy71lqK9gxNagOjixBt8y7i4hq/I+Kp4f5RMuSNV5wmVVWNC
 5poHz3DCLTSD20jcaCa6xbbzzFgMLFifC63XrSMYDVkdtrM5RSFt+VXPTG2qyPXdVLMv
 ntnA==
X-Gm-Message-State: AOJu0YzcSJXUWowUoY56jUAZbYIWWBFakxmApIWxtNry2F/R3AiCMLUz
 oAzXF/AYF1Zs6QnpOdHO0A+BSoPrR2Pej23z7seFf2fMnVXJfT6VW6KNFlep9sJyS15ji5pV6yu
 W
X-Google-Smtp-Source: AGHT+IHoNbGxG2PC2dU4lUFLAmJ6HXKOdevJDhtqmqUKz6ftBHBp8jTn+docyX855PKXmhLmXEWuUg==
X-Received: by 2002:a17:906:618:b0:a3e:b439:6c8d with SMTP id
 s24-20020a170906061800b00a3eb4396c8dmr3570463ejb.25.1708938363905; 
 Mon, 26 Feb 2024 01:06:03 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a17090631c600b00a3cfd838f32sm2235756ejf.178.2024.02.26.01.06.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 01:06:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/acpi: Include missing headers
Date: Mon, 26 Feb 2024 10:05:58 +0100
Message-ID: <20240226090600.31952-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since v1:
- Addressed Zhao's review comments (typos and sort headers)

Patches extracted from an ICH9 model rework. Explicitly include
required headers instead of having them being randomply pulled.

Philippe Mathieu-Daudé (2):
  hw/acpi/ich9: Include missing headers
  hw/i386/q35: Include missing 'hw/acpi/acpi.h' header

 include/hw/acpi/ich9.h | 3 ++-
 hw/acpi/ich9.c         | 2 +-
 hw/i386/pc_q35.c       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.0


