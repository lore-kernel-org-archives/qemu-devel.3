Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14D7C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgcx-0005cD-BH; Mon, 10 Jun 2024 11:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgcv-0005aF-Eh
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:05 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgct-0006WO-GH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:05 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52bc335e49aso11419e87.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718032081; x=1718636881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+MeNMbQoUt5UPGUX5PZCY5d/IlWBTMDhLjyRmqnhkuA=;
 b=JER9O+aQPDqEKBpx27EN+F7VWEFInYQzurjge/jD8UsiX6KtxcId9YZEHPkERBkpWk
 A+pg9HgLMrq5lV9zKfrEFb/osc9Y4MTQo5IO1aDcrnISK8hEZH+SA0Xe+pmyBZQdqZ1w
 4kLA88Xxsr2DTfhE15ZaF/i3BJf0ySeLPfu1CMAFZxmRKVEDAz0XjscuhwytS7MQQ0u/
 JDd0JRXw82cTYjQkX1qdY4qnkuu0mbYa5P2TwniqKPRHYeSVprVvO/yXuuj/JhyTcu6r
 f0Icct5vXordHWoM+QwPUcxw15P7HNSTTMrXmCSVOPlZzrNBznnce8lfH3tG26Nm8kVp
 3nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032081; x=1718636881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+MeNMbQoUt5UPGUX5PZCY5d/IlWBTMDhLjyRmqnhkuA=;
 b=SBDXE1M4QaLfunaFVtJXkd0pY7s44Aiq9ebQXBVoO9jbZOb24o+ktVU80xs/w5Z7Uq
 +EV+lWYZoloO/mRbrfGqfR7m0QeMuCywOJi+NLyYnQZa14j2PNhE2K3u0fxi9Wm5245a
 Mka9dN9IWTQfW3iWYqianmJvzGEVg77dOHlcIouq3M5gLNWMUfCK/HiguQ5x3LOL3yF0
 INOuJ2XJa/VuK1rYzFRJFFHKocDIqu1YIviwRji3crannHKKCbhqAQkeM0ie9q3328Pe
 FS8eTbDLr1RpZ1aUt3gUQqX/IBhkX5h1DsaFSeFAp47upKgvk+IXoEnZEoJOEKq9BOE5
 T5xQ==
X-Gm-Message-State: AOJu0YyXF3IpbjgGy30IR4v52f47yqGO3nbiRkJilE+JB+iahLWk2WuC
 wuyhtNQfcNsMY02PO84TRu6PF7uxHh2FURT0otW0bSm6Uvq9tTWHrlH7M2Gf/zunalyO1YF2agM
 A
X-Google-Smtp-Source: AGHT+IHP+wsMAU6AJW+SrjECnziGh5Cz1id9zRadMBJwxxiOXdTtdzTBZvLd/sId9cLs6fsZRmjR/w==
X-Received: by 2002:a05:6512:282a:b0:52c:85d1:6eb3 with SMTP id
 2adb3069b0e04-52c85d16fcdmr3965799e87.30.1718032081062; 
 Mon, 10 Jun 2024 08:08:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421e91c46e4sm30514475e9.9.2024.06.10.08.07.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 08:08:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/misc/mos6522: Do not open-code
 hmp_info_human_readable_text()
Date: Mon, 10 Jun 2024 17:07:56 +0200
Message-ID: <20240610150758.2827-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Officialise the QMP command, use the existing
hmp_info_human_readable_text() helper.

Philippe Mathieu-Daudé (2):
  hw/misc/mos6522: Expose x-query-mos6522-devices QMP command
  hw/misc/mos6522: Do not open-code hmp_info_human_readable_text()

 MAINTAINERS                  |  2 +-
 qapi/machine.json            | 17 +++++++++++++++++
 include/hw/misc/mos6522.h    |  2 --
 include/monitor/hmp-target.h |  1 -
 hw/misc/mos6522-stubs.c      | 18 ++++++++++++++++++
 hw/misc/mos6522.c            | 16 ++--------------
 hmp-commands-info.hx         |  2 +-
 hw/misc/meson.build          |  3 ++-
 8 files changed, 41 insertions(+), 20 deletions(-)
 create mode 100644 hw/misc/mos6522-stubs.c

-- 
2.41.0


