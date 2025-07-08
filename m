Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248C1C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4d-0000Gt-6H; Tue, 08 Jul 2025 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEh-0006um-9b; Tue, 08 Jul 2025 16:48:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZFEf-00030q-HB; Tue, 08 Jul 2025 16:48:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6099d89a19cso8636434a12.2; 
 Tue, 08 Jul 2025 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752007695; x=1752612495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FvvobzBx99gkG33buzr8HiFgQYziBfA1louF03XtHno=;
 b=FJHcuX/GVf8r5EdDAfYiZsHxShKjL9cz7I2Xm1o01+rWENThHrwP/JVibjzGEvPOlH
 ouw6gvhqfSIVqWxNPJ4XOY4BvXQjov6KJCJavGzeEiUxC3zz9YIuvOtNynZYd2HAg2aV
 qxwZj9n7pn5Nr9wQ4d02Rc/6ac2wqZLrqd5fDmoTcf2QQeLMIuuqsvYNx38+RDGraY+t
 wmPHTALFIOaTIoRVFxzL9nBU+a5f6HcGS0QNWKMpokoUKAA+14oA1Bma92GzNu8t+vio
 SH5LBSOOKWKKcGoJZV5Bq6wdHeh/IdSU4+F5zOnEDJ3WxKWrjcEIAfpsR1LHZk6Je9wQ
 3A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752007695; x=1752612495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FvvobzBx99gkG33buzr8HiFgQYziBfA1louF03XtHno=;
 b=nQgcNexvK+iCmA0kRxIPi9W8nqMwzbbcw0aqF5S0it7I8ibQfHCC6k8kfNh7HDfw68
 37AUBzrWxSeD5aQqSNtjzhdwzdisC8J8/be6diQVp5jtF4CAfsyaaU0SsZt73LZQKaRZ
 eFRWfnylqceem0zpevle9C3X0f238Id5qa4VjN4WNL7ubwHncLBNaKxBnQXXrpYC6G29
 I9j10RS6izRf55oClfa41je0jwTHnfsaSqa1336jZvf5O9RTFySUjVLCYPmM8ZsYZ0X9
 TfpyXS3BnQ/Y/MvwEqH0i3jf/P/p2ybf3ciPWjWSPBefU49NKnN2CuAD/jR1XG1Rki/i
 pzjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKTWiOnRPUCs8bKwSvNrrIXHoO9SDO6lPw5Rwm6b8J4o/grZEBZ2APLirWxzDYUXrSdapc6oKtK0=@nongnu.org,
 AJvYcCX0iwhOYFj1Zb6uK+dATtCN/+HscXdRTYKQ45oxMmqxL1NH5WPuPx/KEoSz7mZtzXhWVXOYc2vaJA==@nongnu.org
X-Gm-Message-State: AOJu0Yxabt6uv1uLXeBdc4PTRQsTH94fI0UgKybxvxq+2M5JSb2FdYvI
 j00W2QhwJgnnGJyZTWqXYiUOp4sIjpyFHhsIS82KtmHzHlTPh7rSG7OJBmCuTA==
X-Gm-Gg: ASbGncuDAI3QG19iZfzJR5K+sv1mh39KzxErQPwVUy/lXDAJm/vQjdLC04EAiD0oQCZ
 phHw8gCaCRfgbXhvbXLFPlrNvGAI8w235XTxRaRkQhayaB5BwO1264iBJtadd+uD7sGKXNx8Sc/
 mNthteIiyXMc0UPrfOjAc2V82cIRqGNUx1UEBf4FANTZhvxR2u4+gl1aAMpwQcOe17l0FxnKFg0
 L2MhyIbwht2J4bFQqxtjJRfnIMdvIxYhDBxY1I43Q66w/y9N/lNGK/sewHY+GDElU/wpSYiqTNf
 8VUSZLEs6RGChnhZ55AUTqYYNAB1gqdbyKUhHCmTZsDQsCfIZnSecuQGlL3a6CHHVxYzTLrS1vL
 D390e8ggsB+EcmxzDcRM0H8gFnNrjsh9ZyaaYzuMSpkSDWude310pXrITM7t5p3ULcjgbd7y9Pl
 GnwBQFlDtRolmlTOt7
X-Google-Smtp-Source: AGHT+IHhMUqXZD0KhMTOqCpjTzBKBqjDSWYJJPqhzbxCLoBpV+WXAMtwTkBQmCa9fYMIWUVXvaeSwQ==
X-Received: by 2002:a50:fb8c:0:b0:602:a0:1f3a with SMTP id
 4fb4d7f45d1cf-60fd65260eemr13728817a12.13.1752007694463; 
 Tue, 08 Jul 2025 13:48:14 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-18f0-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:18f0:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fca66410bsm7647461a12.1.2025.07.08.13.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 13:48:14 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] DTB build housekeeping
Date: Tue,  8 Jul 2025 22:48:03 +0200
Message-ID: <20250708204806.1898-1-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series removes the bundled device tree blobs from the repository which are
redundant to the bundled device tree sources. To make this work, the device tree
compiler 'dtc' is now required whenever libfdt is used. Furthermore, dtc can now
be built from the bundled libfdt if needed.

v2:
* Allow building dtc from bundled libfdt (Paolo)
* Find dtc iff libfdt is used (Paolo)
* Remove dtc configure option (now obsolete)

Bernhard Beschow (3):
  hw/microblaze: Add missing FDT dependency
  configure: Ensure existance of dtc when libfdt is used
  pc-bios/dtb: Remove device tree blobs

 MAINTAINERS                                   |   2 +-
 meson.build                                   |  16 +++--
 hw/microblaze/Kconfig                         |   4 +-
 pc-bios/dtb/bamboo.dtb                        | Bin 3211 -> 0 bytes
 pc-bios/dtb/canyonlands.dtb                   | Bin 9779 -> 0 bytes
 pc-bios/dtb/meson.build                       |  17 ++---
 pc-bios/dtb/petalogix-ml605.dtb               | Bin 9882 -> 0 bytes
 pc-bios/dtb/petalogix-s3adsp1800.dtb          | Bin 8161 -> 0 bytes
 subprojects/dtc.wrap                          |   1 +
 .../packagefiles/dtc-meson-override.patch     |  62 ++++++++++++++++++
 10 files changed, 85 insertions(+), 17 deletions(-)
 delete mode 100644 pc-bios/dtb/bamboo.dtb
 delete mode 100644 pc-bios/dtb/canyonlands.dtb
 delete mode 100644 pc-bios/dtb/petalogix-ml605.dtb
 delete mode 100644 pc-bios/dtb/petalogix-s3adsp1800.dtb
 create mode 100644 subprojects/packagefiles/dtc-meson-override.patch

-- 
2.50.0


