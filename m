Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED901C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtON-0000wN-T3; Tue, 30 Jan 2024 14:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOL-0000vf-6F
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:29 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOF-0008UA-Cw
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:28 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-510f37d673aso3875276e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641401; x=1707246201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gE4N+SZz6g2Nc8XtfAugEaqTsmycgrTHLFCKHFIc7Ik=;
 b=zpzCG/I9dy1Hcdc3hMSZ6GgTU3Pvw6s6oqSv+mqUnh14mStgv11gIGppuEaqPTFjJL
 xUeRIVhxidKbJQyRLZejDhVWW6tuy5e+kjnXMCqMsjU4ySbhiKWhaNk+vdAYg4fAfWlo
 3RgemX5iogntu2Y15GPRlBllhvgenHCsC/K2NhDxNZVXININ7bsKCYkKBqEMO0x2F4eI
 0ZnddZMJ38P9Q8DRqFblqnX5HvyRyH3gyK3UACR9KH5TTkgPpE1IW2OxDcSExOPVqfOv
 HoxLmLWAO8hjy7ipI/hb3ff9iwwFmMtdjRc1IpS1GbhKKibiLJYMB+yZN+MHFzdaBO0J
 EQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641401; x=1707246201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gE4N+SZz6g2Nc8XtfAugEaqTsmycgrTHLFCKHFIc7Ik=;
 b=k+hVViRt7iS5JOUBkr9bORAE8bjdhQXch2PVgvmibprZ44IA483DMimH0JxUpmv3NC
 ADDiooL45dYaJCZeWw6LcrJoasPYe0Hh2QG7CfrijjtNXvhYW2Xmcw+Wv2JgmAVJFzfF
 pKsozh8/wXInACUoHE3oGA+86QGQTanxfo0UUTXJuojmvn37vaRHxA50tkywV1OVTaOt
 oqVkHrpEnNtHn0sB7L+VXXJ4cjXYnH0La4i+bVioEyxF0qOBDEZkHkKX/1sLMnCNFndg
 w7sD4nJlDU+jiDodf9+ZqvXZP/OLOXvZi+r66gpSHTZpeT2nYSIjtrv3W+zDrNvkKEJW
 j1ow==
X-Gm-Message-State: AOJu0YzWx/8BiKRJW1JY8/1F94HsZb7VjlK7RaL6i3+nf3D/FEYJFx19
 aStRV0LsTWmP4nnxnZzInKUEg75SUvH6uYvvtt/K7HDJmG92+Imc7lk1TMkMy4POPUTqHgFnmAu
 x
X-Google-Smtp-Source: AGHT+IF45jkOv/Gs02J9RwkT7W3WKzG0Dyu2a61WnZzEF18oo5KN4fWicDfFHM/1NgjnX3QYuj2QMA==
X-Received: by 2002:ac2:47f2:0:b0:50e:7702:a189 with SMTP id
 b18-20020ac247f2000000b0050e7702a189mr7185145lfp.22.1706641400804; 
 Tue, 30 Jan 2024 11:03:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a170906a10500b00a35cf6727c1sm2179896ejy.105.2024.01.30.11.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 11:03:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/arm/stellaris: QOM/QDev cleanups
Date: Tue, 30 Jan 2024 20:03:13 +0100
Message-ID: <20240130190317.25692-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Gustavo wants to access the QOM path of an input IRQ line
from the NVIC, but since the device is orphan he ends up
with this nasty path [*]:

  -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath='/sysbus'

Add the missing parent so the tree is now:

(qemu) info qom-tree
/machine (lm3s6965evb-machine)
  /gamepad (stellaris-gamepad)
  /oled (ssd0323)
  /peripheral (container)
  /peripheral-anon (container)
  /soc (container)
    /v7m (armv7m)
      /cpu (cortex-m3-arm-cpu)
        /unnamed-gpio-in[0] (irq)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[3] (irq)
      /cpuclk (clock)
      /nvic (armv7m_nvic)
        /NMI[0] (irq)
        /nvic_sysregs[0] (memory-region)
        /systick-trigger[0] (irq)
        /systick-trigger[1] (irq)
        /unnamed-gpio-in[0] (irq)
        ...

[*] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

Philippe Mathieu-Daudé (4):
  hw/arm/stellaris: Convert ADC controller to Resettable interface
  hw/arm/stellaris: Convert I2C controller to Resettable interface
  hw/arm/stellaris: Add missing QOM 'machine' parent
  hw/arm/stellaris: Add missing QOM 'SoC' parent

 hw/arm/stellaris.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

-- 
2.41.0


