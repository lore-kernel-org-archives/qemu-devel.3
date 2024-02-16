Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A78C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razSz-0005W7-3v; Fri, 16 Feb 2024 09:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSx-0005Tz-AL
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:27 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSv-0005Yb-Ps
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:27 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3d159220c7so119107566b.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094724; x=1708699524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTV1hvk+3GXPfy1FUvwkBJo4EhZOBPRYeMtALlPmFCg=;
 b=nqON344Ku3h/EadFpfWx/0eqXsJfplih4BERCxA+uCuZV7eTghTcqXbWAHHfHihpBI
 vV9LmPxW3HVQSRjTvhYl2LZrOJ8UBOB0QokgFUyH5kN30iNQtedQuwczAJ0Issr6Idr5
 x/ooJHSoXqjbHPQX8z7b47i43ehfCcrPqKDYyXfj65kwRujcF95DVmZXzOjGpHbGE73G
 Bl+Gemof4dfdIZTkJHQt7CahQzll1zy2tumubYEuB9yNEmpioPqu8Jm8XoTFoAZvfabQ
 WvBnK5euO3WJhNYcn0wlKk4L+dP6pYpS2NtTwZAYHzedInp0DwMz0dZS0wRpYacGCI2S
 xHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094724; x=1708699524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTV1hvk+3GXPfy1FUvwkBJo4EhZOBPRYeMtALlPmFCg=;
 b=XerDwTKmgQPQtU8Qs90lX5UDtwMiSnCxj3tUAaSyMDO2yt7bv+HrudOpRhAllk+RyA
 CS7VT72iynzvyb8PMUzYZMqiUBvyWFz2Sk2wi3YYaD+djUCIqCa6BVeDPt0pRPYsu8tX
 cKlybGazmnTNvrSbUsi8VhYw8IOHiJxE39GFHKpaIYX6DEd0A/cSUCvzpP13uOdw69sB
 Y69wxdtsyUC+auBBcaC43eZs+QaTchY1lg1MEvD+WA/+gRFoQvWWDZFax1l0RqDqIR04
 RrZb6FmutcuUTId7ieqpQIMdm2tT4qWY5YSfPJMkaKmDvhmJgTQgt+u9AFXbFappwzRI
 7oUw==
X-Gm-Message-State: AOJu0YxyQBSfzOoP1ngZqnBDA4/YjI1u+nU/VoMPlrw0lhwgDcfj8Znl
 k4lnQxNiXekBZwkaoN+1hRmJK3HBeMyNUTY4zrIgwZp2uGP2rzvASBcOr98ywdXFx5VD/+/2cq6
 y
X-Google-Smtp-Source: AGHT+IHbqCH+Y3UVzShUZcHue7uudIxl1S8ppZme8kclN2WfkTatO0o1NHeI33w2VlRh4xPZbiWopA==
X-Received: by 2002:a17:906:6d0a:b0:a3d:d7ad:49b1 with SMTP id
 m10-20020a1709066d0a00b00a3dd7ad49b1mr1271394ejr.19.1708094724295; 
 Fri, 16 Feb 2024 06:45:24 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 hw18-20020a170907a0d200b00a3c456b0c0esm1614529ejc.108.2024.02.16.06.45.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:45:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/6] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Date: Fri, 16 Feb 2024 15:44:54 +0100
Message-ID: <20240216144456.34992-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231127052024.435743-5-gustavo.romero@linaro.org>
---
 hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
 hw/misc/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem-pci.c
similarity index 100%
rename from hw/misc/ivshmem.c
rename to hw/misc/ivshmem-pci.c
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 84dff09f5d..4a9369082b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -39,7 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
 system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
-- 
2.41.0


