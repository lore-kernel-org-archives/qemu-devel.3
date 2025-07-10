Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFB0C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZon3-00023r-Gi; Thu, 10 Jul 2025 06:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomh-0001rB-DO
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomZ-00077g-Qc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so516559f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144334; x=1752749134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vko3wg0dgxa4EDIqWLrzBh8ANpBppL8w4+YtdHLVV04=;
 b=Xr8D/CiAmkld4seW9kE5O3BQi71xxLK5Gdw7fZ4+CXSTEqa70Mguc+c5BHYDOdMbHc
 77xEEzUuRhmp0T6buBXxUdJJqXxkdzvZaszvZJ6eZI/wAlojw6pKYAP/kmpvEYUHawqe
 6egc14SKW7cc2dxcmv7B53Hzz8TzhrdZpT7Fdcd9W7dkDQ0fSWepFMaxpfujzAnfXUUg
 ylNzg96Km8ZQx9FH19AOqR4Wa2GxafpndnYNQBW4jzyJJzw4o68o8/hKDwnoo6UcBJmM
 1ovnhqth1UH5ztr6EycpX5X3ZNQSGWX7iWPPJCpm2tZZyHkNsTmoOXPAjlhsMKtlgG0W
 XWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144334; x=1752749134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vko3wg0dgxa4EDIqWLrzBh8ANpBppL8w4+YtdHLVV04=;
 b=k+ryVyAqVTDBXoG8q/GnR5rlhUmX+Bno8zmm6vWpfdEDI/Eo+mhNW5SmMyXNud6AOd
 IfXTDcLAwc+N1zk+c97aIcg3NiGUxSy0KUNoanq6mqVV4j35vSwuqgSr7n/XyBDDa6Gx
 rOayyk/zzK8gdZss9kJcPcZ+JnrqsiMebyn40/4xpdGb+N0Br/GDzPQnvB32lFRXBtjf
 xkqe/hc6np0gTYvNnYjNUE7636s97OmC5HeOVBEhfywETL88JnkPU1fVk7wE5QvygYbA
 /8ghP6zbJStg6EQk5b6RfrZ+GXSt7GQRxPPb/uVhJa096E3f073yQoVl1oPfGnLmQWt8
 FJPA==
X-Gm-Message-State: AOJu0YwJaM+Wz26auXxE8LN804bT/2owPUGvFYAu5cKV03vliX4NUQSQ
 61Jovsfzk2ddixJlaOP1tZyccr56lopOwP6mbBKw+GdtnfO1ns3uqtKjpQ4DMAbihzM=
X-Gm-Gg: ASbGnctpvB8zZKTsWqDbNxzBDRCIsptFOzZEn9a9EXf0fdC6beBzB+TH3ErmZqNVMEh
 1m97/IuvdoDmvU5/KmsqrOHgdLhjTIFiub1xpuEYcVtaqcB0BUjl+DA7KpMD88n9iEXMBMhQ9Vt
 4ZlP35WOXde49yToRZHKU0kFAg7n7U3yHzmZWbmshz+gozuGYe1odtuRL4Kox+exvOQCtOgsPB4
 bP6UzKj37QnOJiOjraHQpttxZRK0mWf7B4aGodenskj2iTutSCFhyPwVxSx5POoARyDa/wI8UQZ
 RidORg1RXI9vccdH33d90CLjSZVmEX9Ml7/Df0CrfMM9LSYMOwykLmWHB2OMMUI=
X-Google-Smtp-Source: AGHT+IFDr5rMnoDAZwoH8J4FS5zvABLEzQ51b4ZLB7/1GbMRjOUsYcbaeSHpj6cP909fGrZD8zeycg==
X-Received: by 2002:a05:6000:4107:b0:3a4:f936:7882 with SMTP id
 ffacd0b85a97d-3b5e86d65ecmr1700657f8f.55.1752144333702; 
 Thu, 10 Jul 2025 03:45:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d867sm1547708f8f.61.2025.07.10.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CCCB5F812;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/7] maintainer updates for 10.1 softfreeeze (gitlab, plugins,
 docs) pre-PR
Date: Thu, 10 Jul 2025 11:45:23 +0100
Message-ID: <20250710104531.3099313-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

I've collected up the last few bits that are ready for my last PR
before the 10.1 softfreeze. The most consequential is enabling
registers for the Alpha target in plugins. The rest is little
clean-ups here and there.

I intend to send the PR on Monday.

The following patches are un-reviewed:

  docs/system: clean-up formatting of virtio-net-failover
  plugins: fix inclusion of user-mode APIs
  gitlab: add -n option to check_units
  gitlab: use argparse in check-units script

Alex

Alex Bennée (4):
  gitlab: use argparse in check-units script
  gitlab: add -n option to check_units
  plugins: fix inclusion of user-mode APIs
  docs/system: clean-up formatting of virtio-net-failover

Manos Pitsidianakis (1):
  docs: use :kbd: role in sphinx docs

Yodel Eldar (2):
  contrib/plugins/execlog: Add tab to the separator search of insn_disas
  target/alpha: Add GDB XML feature file

 docs/devel/testing/main.rst          |   4 +-
 docs/system/images.rst               |   2 +-
 docs/system/keys.rst.inc             |  49 +++++-----
 docs/system/linuxboot.rst            |   2 +-
 docs/system/mux-chardev.rst.inc      |  38 ++++----
 docs/system/virtio-net-failover.rst  |  51 +++++-----
 configs/targets/alpha-linux-user.mak |   1 +
 configs/targets/alpha-softmmu.mak    |   1 +
 contrib/plugins/execlog.c            |  15 +--
 linux-user/plugin-api.c              |   1 +
 target/alpha/cpu.c                   |   1 +
 common-user/plugin-api.c.inc         |   1 +
 .gitlab-ci.d/check-units.py          |  29 +++---
 gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
 linux-user/meson.build               |   5 +-
 15 files changed, 250 insertions(+), 86 deletions(-)
 create mode 100644 gdb-xml/alpha-core.xml

-- 
2.47.2


