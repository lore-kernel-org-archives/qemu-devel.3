Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A43C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdi-0002Ap-Nc; Tue, 20 Feb 2024 11:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdf-00028X-7M
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdc-0005G0-FI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41269c801eeso13266925e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445190; x=1709049990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItiTCkAfmzt4OaTQ5t65CWwnYcleCpOpQ9IF8gCFhuc=;
 b=jcbstVlL9o8xKfoeXjqHmARA7c8+9YChtFy31J2nwUzA6GcUrjC4HcBy8BUgFBj9KQ
 av7UHtgv1hIWqtUb7nCDmA8iiTPm05FhXCNeQvo0rO/ELdGxb8GofBxOSbYa0HVG25RH
 LAjriSnZ1HjwBB1IQYOCt3ZVB3REO240z5PJCovCIRsNpR77EH7gvLdxHWg6evp4IdhZ
 xHpM/scLG7CxX/pztj1hWFhzPYIX0QF2hCmrhHdIVQjYG23L84wO3DOe1GX2fyysOV3T
 FKRlPlZQQnt0amakwga3fZH7O78APBcKaZA+tcRv3uTA5aluXUvE4S8TMyp4X/Hhvc+c
 3kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445190; x=1709049990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItiTCkAfmzt4OaTQ5t65CWwnYcleCpOpQ9IF8gCFhuc=;
 b=gecI4L9b2Aalbn/CvjGkRUO8phKv/m47w5YpnZ8GnbCAbcZzyKm2SKQ5euOAny/yn7
 rmt4xDEvGoIH25/V3ABldvaGA86y+1Ip9cIxhzNSvb86wXdoGxOrphs1ESEHehCJDzys
 uVTTJqx5fhbTt2Z8dy8il9KaGsK/zAitBbAB5YgcE2Z6phu8f6/5Pd9I+gSthIstm97J
 V5y4CQp1ySae2gN0LrfRm46v2Bw4zluBe2cZ144tSRINVggjZ1uZkckbBDubTQFdOnEk
 iGRBLmdNLSgQt5+rowhLSB3bZkxnJKV1IJjDkoHZgPh4BNbE4oYK/MSE95MLyDnImJcM
 fuUA==
X-Gm-Message-State: AOJu0Yyi1t1tg9qu7xXkQ1UqusR6Og02SD5DRw2H05UO2Q6+YST/7kNw
 nlHMjMIcE7LAvJp8vhW0eSNxtZLFJR3A/baKH97NBWXsKbXXKt4BR5KjFlOR8ml+QbNiCmWRGWd
 l
X-Google-Smtp-Source: AGHT+IG5fA8cRiSQZMvAw0nvfAZ0CNed/B4mryIZdzif8FxC3m1+XlnhTHny8WnaRTLLkhdnPDB33g==
X-Received: by 2002:a05:600c:4706:b0:412:7180:eaf7 with SMTP id
 v6-20020a05600c470600b004127180eaf7mr792749wmo.6.1708445190608; 
 Tue, 20 Feb 2024 08:06:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 10/10] docs/devel/reset: Update to discuss system reset
Date: Tue, 20 Feb 2024 16:06:22 +0000
Message-Id: <20240220160622.114437-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Now that system reset uses a three-phase-reset, update the reset
documentation to include a section describing how this works.
Include documentation of the current major beartrap in reset, which
is that only devices on the qbus tree will get automatically reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This merely documents the current situation, and says nothing
about what we might like to do with it in future...
---
 docs/devel/reset.rst | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index d4e79718bac..2ea85e7779b 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -11,8 +11,8 @@ whole group can be reset consistently. Each individual member object does not
 have to care about others; in particular, problems of order (which object is
 reset first) are addressed.
 
-As of now DeviceClass and BusClass implement this interface.
-
+The main object types which implement this interface are DeviceClass
+and BusClass.
 
 Triggering reset
 ----------------
@@ -288,3 +288,43 @@ There is currently 2 cases where this function is used:
 2. *hot bus change*; it means an existing live device is added, moved or
    removed in the bus hierarchy. At the moment, it occurs only in the raspi
    machines for changing the sdbus used by sd card.
+
+Reset of the complete system
+----------------------------
+
+Reset of the complete system is a little complicated. The typical
+flow is:
+
+1. Code which wishes to reset the entire system does so by calling
+   ``qemu_system_reset_request()``. This schedules a reset, but the
+   reset will happen asynchronously after the function returns.
+   That makes this safe to call from, for example, device models.
+
+2. The function which is called to make the reset happen is
+   ``qemu_system_reset()``. Generally only core system code should
+   call this directly.
+
+3. ``qemu_system_reset()`` calls the ``MachineClass::reset`` method of
+   the current machine, if it has one. That method must call
+   ``qemu_devices_reset()``. If the machine has no reset method,
+   ``qemu_system_reset()`` calls ``qemu_devices_reset()`` directly.
+
+4. ``qemu_devices_reset()`` performs a reset of the system, using
+   the three-phase mechanism listed above. It resets all objects
+   that were registered with it using ``qemu_register_resettable()``.
+   It also calls all the functions registered with it using
+   ``qemu_register_reset()``. Those functions are called during the
+   "hold" phase of this reset.
+
+5. The most important object that this reset resets is the
+   'sysbus' bus. The sysbus bus is the root of the qbus tree. This
+   means that all devices on the sysbus are reset, and all their
+   child buses, and all the devices on those child buses.
+
+6. Devices which are not on the qbus tree are *not* automatically
+   reset! (The most obvious example of this is CPU objects, but
+   anything that directly inherits from ``TYPE_OBJECT`` or ``TYPE_DEVICE``
+   rather than from ``TYPE_SYS_BUS_DEVICE`` or some other plugs-into-a-bus
+   type will be in this category.) You need to therefore arrange for these
+   to be reset in some other way (e.g. using ``qemu_register_resettable()``
+   or ``qemu_register_reset()``).
-- 
2.34.1


