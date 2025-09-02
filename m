Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1967ACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUDg-0008FB-0F; Tue, 02 Sep 2025 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDe-0008ES-RW
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:54 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDd-0004Po-6t
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:54 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b0225483ca0so550972566b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756831851; x=1757436651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jtVv37IFrMt/51iDXJklEJqQ7iS6Rm5PnqjC6DUh6f4=;
 b=Kw8Wp+wZHdoMuYWaU+Ja9kQcNkQsUg44eX6/Ox5bxNVfvc3FLEoJnOqqQpsIRGY8Md
 N/x6h7JMUNX2Cotfsz3bL1cBtNq/2K//Im6VN+x9YzOtRLgmCvxleDLISfJ+jw9toM72
 akiuR7Y1y8ftNIgQ+2GzFOUs1XojMfYKa+eZnjjneo726TOc55QVNfwYfgIJyRV7CHcy
 g2/SmptlWbMyKUajEQh7IlRpL1+r439v5QlBqAG1fp0ZZNnZSoLMJ6vi43ZvsQ5apBHG
 J7BjhCNDEA18Ld+5qXQBr48X6en5//Cj/ZpsHsIpVXnhzBEI5tPVvIDQq5ZYobYSCwMB
 BVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756831851; x=1757436651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtVv37IFrMt/51iDXJklEJqQ7iS6Rm5PnqjC6DUh6f4=;
 b=L0weFiV+FOhYy2iapeXtzLurF5K5PrhDh7381SxkZTBce1eJOiXk6dgkBQv4ULYr0q
 WF7WNCwaKOOUsrHIRDTlwLyWjEGJrpCvN/zXfeRfyCenJ5Pv1XRwzMXFltPGs0XDUhk1
 qXPLShG454BtomJu5c/PMWfhAK9QzfLoF1/Xpb6Okd8VqHk8Mlp3k8O+zxWYlul/3DOZ
 4xA7Gkn0RWseH5mPJ/UKid0LKrb8Bo/0NctWzVzI5PHj+Gd/AeiwwgurYBY5wPqs0GRi
 +4RyR/mVB1LSLm/ZH9ps3qTXnEzjgRF2LniBc7BS0DP7cxWnhqzCuYEoRnkQEqFEkw6Q
 mi3Q==
X-Gm-Message-State: AOJu0YwIXZk2CpD2Zepk0QI9GHUDHeYE9igN1MOoWp3cIlqJPSBDm7oE
 tN/laFM4lwMmm+ye/0g+NpVJVkzxEqwmFB3d1znh86FbEbG/Gk63g441v3PX50GjvJU=
X-Gm-Gg: ASbGncs5Qpr938RwRB/lnQuG3KdWa7PcwkDuLiyDvqY6mi+zZr6rdEL3QffGj82pfk2
 iD0yy1ABQ4aXDPJgSlMpKekRHqp58VGu3urJ0bV5gEermnjipQUI1Jquf4fdZcP4RBFSwWLDGkz
 zXKF701AfJTPAXt1H4X67uMHzPWhCvko7/u7UK9+s/yGKOAz0dkbKZFH2ik2G6cs/KC4B9L3lSS
 YCIUZz2Ag8OWqk0AkPfv57S5htY4ZT7IU4e0WmgfUXxYC6edHqfdvy8XIpTiXARUDY5VvEOpAMC
 qDpKVtqd6tcONmIkob9fpoSgGGqbzitkXJyxL5+J7gCnXGpcfPLldsXPOSSeAaE16mpJLcYonMH
 ocrvTsyAla36qxxAL5NZ4vDY=
X-Google-Smtp-Source: AGHT+IGgNhBEyN8gNysNAoj56uQ96otFlRHk/GUKx1iYSE3AzP/GlZi/DIxcHoRXEt8Qi7sxTTHA/g==
X-Received: by 2002:a17:907:7e82:b0:afe:ec09:2a23 with SMTP id
 a640c23a62f3a-b01d9769f7fmr1131782566b.43.1756831851341; 
 Tue, 02 Sep 2025 09:50:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc52ade4sm9831541a12.45.2025.09.02.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D80F5F82D;
 Tue, 02 Sep 2025 17:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] virtio document cleanups (esp vhost-user)
Date: Tue,  2 Sep 2025 17:50:44 +0100
Message-ID: <20250902165048.1653323-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

These just tidy up the device emulation area to be a little more
organised as well as splitting out the VirtIO documents themselves.

Alex.

Alex Bennée (4):
  docs/system: split VirtIO devices from the rest
  docs/system: unify the naming style for VirtIO devices
  docs/system: drop vhost-user-rng docs
  docs/system: merge vhost-user-input into vhost-user-contrib

 docs/system/device-emulation.rst              | 18 ++--
 docs/system/devices/vfio-user.rst             |  2 +-
 docs/system/devices/vhost-user-input.rst      | 45 ----------
 docs/system/devices/vhost-user-rng.rst        | 41 ---------
 docs/system/devices/virtio/index.rst          | 29 +++++++
 .../devices/virtio/vhost-user-contrib.rst     | 87 +++++++++++++++++++
 .../devices/{ => virtio}/vhost-user.rst       | 22 ++---
 .../devices/{ => virtio}/virtio-gpu.rst       |  4 +-
 .../devices/{ => virtio}/virtio-pmem.rst      |  6 +-
 .../devices/{ => virtio}/virtio-snd.rst       |  2 +-
 10 files changed, 141 insertions(+), 115 deletions(-)
 delete mode 100644 docs/system/devices/vhost-user-input.rst
 delete mode 100644 docs/system/devices/vhost-user-rng.rst
 create mode 100644 docs/system/devices/virtio/index.rst
 create mode 100644 docs/system/devices/virtio/vhost-user-contrib.rst
 rename docs/system/devices/{ => virtio}/vhost-user.rst (77%)
 rename docs/system/devices/{ => virtio}/virtio-gpu.rst (99%)
 rename docs/system/devices/{ => virtio}/virtio-pmem.rst (98%)
 rename docs/system/devices/{ => virtio}/virtio-snd.rst (99%)

-- 
2.47.2


