Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1EFE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5yl-0005Gz-P5; Sun, 12 Jan 2025 16:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yj-0005Ge-Ux
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yh-0003l8-Fi
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso26295885e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719117; x=1737323917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0KXL/q+kNfQgNKIGtpcxhFP831eHLwn668zoo5J99kA=;
 b=BQvWO/PbRuHcfqj1xvMlh4z5VjHi31lat/b6nqKLag4K68YGPxJ35KauwRVe5qtKBi
 eJdKCRvIys0Jk7gOEHU/dUGnxebe6yZ3ZVo/YlMPa/tf+fY7K9OtxXqbx1MJtDjpvuyv
 XqMhgdCSd7v1hHo/20Ebk4MvNHyxp+W6UyLzcS4AXvSFTRbBaYy08+5FSeTWdZ1tmjn/
 gC31SaG96o7ksqtqedcw1W2c1gAl0woCQc/c3oVJWvD3CDSrABAFZHDcUlmGvlL+sgLs
 nz6wR4CBV9/DCRvli+b2QCizMIRQIUbtQzCHm9eswOtuZIJbGXOg1YU9E2eTcPuzlsuQ
 02Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719117; x=1737323917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0KXL/q+kNfQgNKIGtpcxhFP831eHLwn668zoo5J99kA=;
 b=orMjtcfHsuz3gRmuIDT+on148PVh9+sbVAFMOhHPNIC1Fup4TLAgVT7lBtD3LqujqT
 D8XZFJv0i3LdLcWMQPFiQlTMkWcWTZJRkm/sX49v4A/h7yGxUf6aOj09b2XAYP5u/ZYf
 zCw43BQvhjvE55czDGTqtJr0e66MQTV4Ts2kGIjUgIXZDfnxPyBMeRVXSi/n0WD+TwN8
 7J3QCbiDUfVRkpqIe3MRkuy2sXR+QMSGVJulMeKqtk5WcjohPD6wjhDTI/2LQDs57CSJ
 Kr7Uq8q6EXSyQmlRSHgJOB1MVeQXA8tsIomdDleyB0k35+qXp0KEvTb0C/9LVYqhveYs
 PbOg==
X-Gm-Message-State: AOJu0YxQe6h/KDN1DqB+7KC85sxSrKgIs7jlynIwpK2cEuruMZNHUCdY
 IjZ8IYalQ9ZO/DGlpzVeJXWEILVeIu4WxOgJNKT62aTHpXJEgI/KnJ/FF2jjq08qruUT6chMlQ7
 03IA=
X-Gm-Gg: ASbGncu+CS4Z//r1iuRTyfCi4fMVtviMp6ZBg2ZhuSt43toxIJcZNC1xfa1b3WR4lmz
 51sJySZEF14c4mVw1H5Bb5YdSrSGbsJqLuMIRnep5rwEjbUxSQBBJQv2jY5RP5mmvP7tLLpghCH
 qHB5JGRhvOp9mWm5K4BrCkkgUExuWQm3UYVM0Zy21jciiEAtMnanWZ8znBOibkYdMkuDKFGletW
 U3Ag67dy/dcUqDhAGyKrNFHHtJ4B1mrchVPzlm8yr8J5q141GbMfnA6711nFe/NYlFeehC3q6KQ
 AiRFYjvs2CzOlAn9k8ZfLQRTkDgEvSM=
X-Google-Smtp-Source: AGHT+IF8+N+0UPUqBbsWHAUTKYEKFABPMJtF1u/EgMEQUXn+W2/AJYs5/EEzDXGs3IzaDnsiANw6iQ==
X-Received: by 2002:a05:600c:1c14:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-436e26786a3mr155177095e9.2.1736719117355; 
 Sun, 12 Jan 2025 13:58:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d111sm10817386f8f.18.2025.01.12.13.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:58:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/11] hw/mips/loongson3: Remove uses of &first_cpu global
Date: Sun, 12 Jan 2025 22:58:24 +0100
Message-ID: <20250112215835.29320-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Propagate values from machine_init() in order to remove
use of globals such &first_cpu and &current_machine.

Philippe Mathieu-Daudé (11):
  hw/mips/loongson3_virt: Factor generic_cpu_reset() out
  hw/mips/loongson3_virt: Keep reference of vCPUs in machine_init()
  hw/mips/loongson3_virt: Have fw_conf_init() access local loaderparams
  hw/mips/loongson3_virt: Pass CPU argument to get_cpu_freq_hz()
  hw/mips/loongson3_bootp: Include missing headers
  hw/mips/loongson3: Propagate cpu_count to init_loongson_params()
  hw/mips/loongson3_virt: Propagate cpu_count to init_boot_param()
  hw/mips/loongson3_bootp: Propagate processor_id to init_cpu_info()
  hw/mips/loongson3_virt: Propagate processor_id to
    init_loongson_params()
  hw/mips/loongson3_virt: Propagate %processor_id to init_boot_param()
  hw/mips/loongson3_bootp: Move to common_ss[]

 hw/mips/loongson3_bootp.h |  1 +
 hw/mips/loongson3_bootp.c | 16 ++++++-----
 hw/mips/loongson3_virt.c  | 57 ++++++++++++++++++++++-----------------
 hw/mips/meson.build       |  3 ++-
 4 files changed, 45 insertions(+), 32 deletions(-)

-- 
2.47.1


