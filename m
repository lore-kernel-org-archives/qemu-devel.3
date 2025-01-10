Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBAq-0007Fr-8m; Fri, 10 Jan 2025 04:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAk-0007FE-Dw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWBAi-0007It-QK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:19:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283d48so13620185e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736500755; x=1737105555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yA2q8zcDZ43//TUDxGWS7Y9cWigJcJ4nPMAPak2CZ3Y=;
 b=aZefgLBeAg7aYzpfcR64k+w/Eg2jeUb8LR/4Sq6rA3rK2iID8vykFYGVM3+Q3vO3p1
 6qbYYvr9QAwZGhMtx8dkUWQwM/qv8nthtdUFoQt9EQ50M7MCk3ym4CAWcy59/kQoielq
 T5cKVQ+8Qp0IwV3ZbhHXTF9prT+etkMpP5zrtO57HKm7NmRPpVluzmH55thRFt7smQFl
 N9y9lEPj02aYCF+EcBOw5hfIfUolj+TOIr38RthMMtcdGhfv/dnGXfTZTi1FnNSVe80m
 n+2H2UM9TzerewTfdNYO96BZlbwPNzcvLtfzWYtxe/GiZ+fOyYQLy/53ku39/SAqvkTc
 7ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500755; x=1737105555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yA2q8zcDZ43//TUDxGWS7Y9cWigJcJ4nPMAPak2CZ3Y=;
 b=NpTg8COJhBeJRujELh8f8J/YlYsVrestVe9l100KIRKkkpJGeuin4RIz0lho6/2Xu9
 dxzu2lkX+80iDOSZ3oWIbJhGw+3cE0IBeF5jyxzO11DSSXrMQQz7f0OtN+FL1IwhWfaD
 rEd7mLv9NApJPUBsH7QHEALUQLW7KaRdQSNDYGyn+wI3/RERbjyEIdG19dUwkcEtVZaT
 j3tpRJ3bFqvKIDw0/pNebGPb2EGPsn90emQllMN6K8yU7+VQkwLDYMlfgoFGHz1Ln36N
 BsVD0x0fJpDYX1gOwOYVxLdVVMB1V6krrbgij90qn0gMKA2dvgWxWlqERfBx/EMergeH
 fnaw==
X-Gm-Message-State: AOJu0YyaicYknrFZFtGCWpFgSyeLy68ylaYO3JRXzTc58Cd9+QAC88Z9
 dpAzkTtuZrF6f1mDmxCi+eip3rG02NJzfE92dtXpAnrqG9g51XwlZcPJWkWkS4rTm2iDOj8JUW9
 v3+E=
X-Gm-Gg: ASbGncsWtt5f3d6WTPvymIECq8K2VGt+sL6L5Te6I474aVH/ra8ylT5jqI8oGCVxdCw
 /6mXuV6KO8qybmKsZq1uH8NUOHFdw76RWfL1AS4friXMhF3HwYF+E0KspAPb5cyV/gz6BCHN7hv
 PhxAawBYvEp8TeOuolwGm8x9g5vPGFoaQ6ZpToi3xGgLrkfFhkcXybTphP05AqHl6a0MNesm/j/
 cL88dOw5ALsm4jgmbfvGeNYYe6tHc0PvBY3DSQuje9Bk7IjHHGzYr1kz6hU1i7r5ZHoslMMjEGh
 cHxXITP/dZeTj8Wi56evRP2vLmTwENN8Cwuv
X-Google-Smtp-Source: AGHT+IHsWT2n/0k6z8ba7UFj3dlxOdT7kejyRqgtgyMPHCtOwjNaTm+z99tipr7j3WREfehFoEeInw==
X-Received: by 2002:adf:ae11:0:b0:38a:88f8:aad3 with SMTP id
 ffacd0b85a97d-38a88f8ad17mr5658914f8f.55.1736500754655; 
 Fri, 10 Jan 2025 01:19:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92dc4sm79820625e9.39.2025.01.10.01.19.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 01:19:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/6] hw/qdev: Pass bus argument to qdev_hotplug_allowed()
Date: Fri, 10 Jan 2025 10:19:03 +0100
Message-ID: <20250110091908.64454-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

In preparation of checking the parent bus is hot(un)pluggable
in a few commits, pass a 'bus' argument to qdev_hotplug_allowed().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 2 +-
 hw/core/qdev-hotplug.c | 2 +-
 system/qdev-monitor.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0..b4a5b203aab 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -544,7 +544,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
-bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
+bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp);
 
 /**
  * qdev_get_hotplug_handler() - Get handler responsible for device wiring
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index d495d0e9c70..19fbb11a316 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -30,7 +30,7 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
-bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
+bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 {
     MachineState *machine;
     MachineClass *mc;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f538025..bf1afb81886 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -690,7 +690,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     /* Check whether the hotplug is allowed by the machine */
     if (phase_check(PHASE_MACHINE_READY)) {
-        if (!qdev_hotplug_allowed(dev, errp)) {
+        if (!qdev_hotplug_allowed(dev, bus, errp)) {
             goto err_del_dev;
         }
 
-- 
2.47.1


