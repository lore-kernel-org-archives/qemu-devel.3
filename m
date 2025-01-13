Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E9CC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXON3-0002NL-Bq; Mon, 13 Jan 2025 12:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMS-00022d-2m
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMK-0006yr-76
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso48330945e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789772; x=1737394572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzCNbwIo87x4lOEY4ICfv2t12PV5Rydbl8ocZx/cYns=;
 b=cbgcKYzonekfIJxgcVEhT+CYJ/npyycy0FNGWWRCGn/Z8/luj7vzrUeUt7enX5H1Rz
 qR1lM3FgvKglYgHhOXi3IgOWdH55FJVjGDDytRJ2/AHPBBbJ3DyZsKJHObJqIzx+jJ48
 yFhsUuPcvbuUu7CKuZaGUu4WNRmy1pPuTPh+ahlPU5MZfmljludgBjidhOrQkU8cXtRs
 ab3cbCXAUqPT2q2Cx/fGRnRbynkbfQKnuxce+7dqzrcFaT8/Ws+g/RDJsO/GtElJGt51
 dAqPVVnOuWHN8sQvFBYvc4FrJ+d3CMFkk1JdMwnJgMFZ9UiN/KBAfpNb0lUusif3hX43
 nBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789772; x=1737394572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzCNbwIo87x4lOEY4ICfv2t12PV5Rydbl8ocZx/cYns=;
 b=rxYES3OxINPlZTENh1p45qWyjWcRwEQNCvgKYa8Gstz1brEjn8QNEg324eBl9JeXWz
 yZ3JzAASJLqVDfZP8cTn+0MzgdyMdG0owav1ce0YV0BUAqo2hLsa3TzPDMNIRGqKv3Xm
 RP8i0suIxLIMbubd1oXJS3LXxjaH26GbcK9X79lox6nrh29FGOno65S9lYo0lzwWkeiu
 f5pVwUuRRLjXwqFaTVj3KiFhfWnWbilhW3RsIHq94PTFAGNjbWdm4+Ac0Xy5XMxj26sf
 PwtNvJjJDfsOS7u++g1Fw350XI/gGpl1MQ0edFfvimXcWlylX15/E+ktOIUmlMOTUuND
 SYhg==
X-Gm-Message-State: AOJu0Yy0KzdB+izDEpk+yY00S+NkptysY47xg4o/dDs6zyJ7Z0n8C1z2
 f0U6aPa96fLjobu6skVZjb1RciWcmsHFAOEwd3dZy4C5fsCCickcd18JaE3uh31SfSNPAxdyYI3
 03bk=
X-Gm-Gg: ASbGncso5el0WxMLGQWeR7AfigXU8QVO5IK2z5CPOtEb8KZGm6XuyYLNLdrcq4aHUnW
 2SSQqF3zk9+kBfFuuO3gwtDb3gzXmTnhkYltweBNZH7FfL0mPw4DSRhc447tiafAarvtMtO/oSf
 iER2NjvRV6ZnUy2lhZ52xrfXsZCkUx0q7w2u8vxjf+6aasR+CJ8jdoDQVP+mfJsYV8puXlDahwT
 Ok6n0+GWL4H0n03P4mdavlqYLPL7B5cfkgN2RpBBleasCxq8O+rul79D4tCI34+qANAbMjoda+6
 715UWcljl/r7Zw8HCq9iqvXdkcDMug4=
X-Google-Smtp-Source: AGHT+IF6uUsTb9bpYcV7vwky7GAhL+niw9ROGKAt4cgqykrFFxW5PMY1Mq1MemJEuns/lzK/3bIkWg==
X-Received: by 2002:a5d:5848:0:b0:385:df5d:622c with SMTP id
 ffacd0b85a97d-38a8730dec4mr17115771f8f.30.1736789771685; 
 Mon, 13 Jan 2025 09:36:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm12945329f8f.30.2025.01.13.09.36.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v2 06/55] hw/qdev: Pass bus argument to qdev_hotplug_allowed()
Date: Mon, 13 Jan 2025 18:35:58 +0100
Message-ID: <20250113173604.46931-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
[PMD: Split from bigger patch, part 1/6]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250110091908.64454-2-philmd@linaro.org>
---
 include/hw/qdev-core.h | 2 +-
 hw/core/qdev-hotplug.c | 2 +-
 system/qdev-monitor.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 89575e74e27..930b00fb09a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -540,7 +540,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
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
index 23043b1e0d5..83388dc0c4a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -691,7 +691,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     /* Check whether the hotplug is allowed by the machine */
     if (phase_check(PHASE_MACHINE_READY)) {
-        if (!qdev_hotplug_allowed(dev, errp)) {
+        if (!qdev_hotplug_allowed(dev, bus, errp)) {
             goto err_del_dev;
         }
 
-- 
2.47.1


