Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A7CE6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOvc-0001dx-Gm; Tue, 03 Dec 2024 04:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvb-0001dp-7h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvZ-0001F6-Oy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso48325425e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217039; x=1733821839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0d7wByjlR2vqwPzZ/uQgMGwIZ57lBUNVChrsIVLPDAo=;
 b=ZJ+vrRXxJXOPs4rIXRNauJza7VrxBi/AwsCQ3mkwpIx5zJtMu/mGlT4o+BUOXqaww/
 YPs4kx2fiD1dKqavwQjVYzYMykMQBWDJqHRg6OLxKjK1VOkY5XNKLtlJhFUUmgFBzJZR
 IZr9xBgB0nPiRc73bvAi3qmBeLdCgETR+nVdfrrIaWGbATUqp0mUSp89p/JUeC4nC0uw
 GCtKYwVo6XxVXsxw56F/MPeBbUiIFQ4lfMVZ94C9dOZNoPK1CO2DyB5dd6W64tueukPK
 JsS5q2lYnwmYjY4o1dZXe31kFgGi34dGxDw6j+erHUwLyppvj4mnScWXVZmOMsIUXgkg
 Y2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217039; x=1733821839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0d7wByjlR2vqwPzZ/uQgMGwIZ57lBUNVChrsIVLPDAo=;
 b=anZEJAtv6hFSyVpSX0HttpzWHYfq9qGYSdbfmU/XVnAZR+/ID44E1FrghRWk6ZHjzU
 JHDrQVfEr6Jda2ElLnuCBbUdghJsZ+dwkXmZkwEJzEOOSwh0XHMX5pxhhM3VD/QbEuMI
 YIMRexpt6itOKhlWfI51le3apwehi99B11Pz6SY/nYGaXPuumzsmidOsRuODfLixft4z
 wH7j0eEYE5q8nRJwt9Fo4t3szRL+npMyITYBQ8Rdfcc4t3JrK0aww+x2GUBIyP8UBhQv
 pcLxyhAy2h9niCPZjrZeEWeyGcpUYSH0/S+EBtUupF912EPbjmFLYPgJFknqaUJTNppQ
 39dQ==
X-Gm-Message-State: AOJu0YyGfhVswT31LMyOFNG0+dCWYz0h01JwEMR/YlGPjGA4kEI10Y7t
 cEAKBAI6A0eI3sdrIyM6+/+YQH1jwr6KZIKK68kiY4RrEOgm/BQrvAI7lZRAfElPsoGX0QqB/SN
 P6Fk=
X-Gm-Gg: ASbGncsw1tQI9be72ZHY623VGrRLLcYnpl6IeAQ2nuRAND6jHuSX58ETVKv54a70Ald
 vyBSEk5VZeOOMixqU3lWtBkrEsp42MXaGzdyLtK0yWg38ssjzfdAVdO9KWlv8VMCD5vhbLVm5UC
 5xpIRcZqgos5Zq3ZxUwv58bpwiX0udMl8NtaQQ6wQOGpg67YEl+dfA63IME/xM2f/6/d4O+WTM+
 Vrc+r4FitaEkQC966sBjzPG7R13kVWL1y2crNz4DeLFW3jmMWz25S8EazHdR1x66TUxQEEJ
X-Google-Smtp-Source: AGHT+IGVNQONH8iXd+h//bSASSylbkPYOLCEPsJPBFisRDSxY0dO0/sbCg1OC6XsJyo5sG2YUYc4Fg==
X-Received: by 2002:a05:600c:4fc9:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-434d09c0b88mr14633705e9.9.1733217039201; 
 Tue, 03 Dec 2024 01:10:39 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa78120dsm212297365e9.24.2024.12.03.01.10.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:10:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-9.2? v2 0/2] tests/functional: Fix tests failing when TCG
 is not available on macOS
Date: Tue,  3 Dec 2024 10:10:34 +0100
Message-ID: <20241203091036.59898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Explicit the QTest accelerator to have these 2 tests
pass on macOS when only HVF is built in.

v2: Use -accel (Thomas)

Philippe Mathieu-Daudé (2):
  tests/functional/test_version: Use QTest accelerator
  tests/functional/test_empty_cpu_model: Use QTest accelerator

 tests/functional/test_empty_cpu_model.py | 1 +
 tests/functional/test_version.py         | 1 +
 2 files changed, 2 insertions(+)

-- 
2.45.2


