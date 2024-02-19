Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33962C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Pe-0003LW-WC; Mon, 19 Feb 2024 09:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pc-0003D6-FH
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:29 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4PS-0008Ol-KT
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:28 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so5045975a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708352055; x=1708956855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4f28WQJxzPl90nyS2MFArA7P4j/F8y7DYz1HQkdfTB4=;
 b=MnqqyGKJA+Z8ThWR0m1IceQBfQDJ6gm9JT++jH9AtPgCvDXwvA1j+meBrvoNUeMvLv
 Kv8mwWbSwLJShXacN7pwaoF1c/a5PBerLwx5vxEHrmI4y19cBT5S7CS6Ps7LwZLHbwMd
 0sno3E5upVVnn/vO3uTlVYNJb1KEX3BK0yKt6H1CHuzAZjXddHh3+NewzcWdDR1hn/ot
 slL7ERth/fMYsMKrOOMLMz+a7KH5YxMKH7tDeYKWYQhjWN2/e7mWy5e+UYhPQufKPdgZ
 Nq1lsvPkg9KKt1gT7KnFj5Cvi3h7dFL5LcYfmfMPcanc8JUTougW8NjFoeoD2szVwNRa
 HQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708352055; x=1708956855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4f28WQJxzPl90nyS2MFArA7P4j/F8y7DYz1HQkdfTB4=;
 b=fAQ5umvHW8M5hfCFvfHdDxx7zJGGS7EpGcACDVwuiF6mov0wNQWWgraS1imOMfFdER
 OGCr50cbEipE8G03t+h6QXOP8Xg51FgD3NbFfFCvGnrxjcI3wXz9MQ2eJyre8csHEdXW
 NRX6ic1/GOoKgI+IC81br2bKXW6shbuLIm8SAw2BFzUU4zGTdVUBF7TC3VLQvknMX834
 XArf5gmxH4MIv6hI5J0ek4KUi8hKvZkjcpg8wsMAsQw4Mf1k+vQ65om0Sv56KSjFXCRS
 WivJCTOYUCxSC9yq/zTto+R0vM6AwaOljaJNwjVLcwRlRNUKQRrDHV9qk/SkCjT/MaTH
 5ZXA==
X-Gm-Message-State: AOJu0Yw3Nv0k6si2/+l0i6v9w2wl0rMedSknTlBLOwmgmT/E8AMNjvOk
 5u9XyL4KfAwF/ybpnjlcEg4Z2BXy3TnP/cfhWQnErR/izzO2K5fcJqxrcFSGTmMi7kWIkxwqvm+
 L
X-Google-Smtp-Source: AGHT+IHMf/+gNQyLvxJ2a/3DhDCfIv9szvwp28V6H52Q6kxy/deFHQghHSt+T+a4d0TnEGn6FgjBrA==
X-Received: by 2002:aa7:d4d3:0:b0:564:1c4e:eb5c with SMTP id
 t19-20020aa7d4d3000000b005641c4eeb5cmr3889072edr.24.1708352055553; 
 Mon, 19 Feb 2024 06:14:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a50ea87000000b0055c85e6d75dsm2686671edo.87.2024.02.19.06.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 06:14:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] hw/acpi: Include missing headers
Date: Mon, 19 Feb 2024 15:14:06 +0100
Message-ID: <20240219141412.71418-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Patches extracted from an ICH9 model rework. Explicitly include
required headers instead of having them being randomply pulled.

Philippe Mathieu-Daudé (5):
  hw/acpi: Include missing 'qapi/qapi-types-acpi.h' generated header
  hw/acpi/cpu: Use CPUState typedef
  hw/acpi/ich9: Include missing headers
  hw/acpi/ich9_tco: Include missing 'migration/vmstate.h' header
  hw/i386/q35: Include missing 'hw/acpi/acpi.h' header

 include/hw/acpi/cpu.h            | 3 ++-
 include/hw/acpi/ich9.h           | 3 ++-
 include/hw/acpi/ich9_tco.h       | 1 +
 include/hw/acpi/memory_hotplug.h | 1 +
 hw/acpi/ich9.c                   | 2 +-
 hw/i386/pc_q35.c                 | 1 +
 6 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.41.0


