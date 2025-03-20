Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EACDC35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7p-0003om-C9; Thu, 20 Mar 2025 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7F-0003QX-68
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7C-0007mI-QT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso7419045e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485644; x=1743090444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dX9rUzkX3sdDr3FQsYg48xqFRgIMTEyFu0OjHzLhXeM=;
 b=jXu21+DYdFcEB/oFDFjTJsjUz2Z02geSnr085tJkJ2JwKhznxsnv2+7NKvZUZsI9Tx
 EoZFv55ECnVpF5aEH+Qdj0oGOsgUXVJmxOmOXNV5jy7hEigJ2e5SHrU4c11/o8VRH6vL
 AOvSod97tkrtE4HY6kjStwZJEiPwgA0XnZjO7KsrHMNrFjBO+3U88BuT/1anHAq7FJnf
 FeHrnYtO5hP36R4ZLrQPLfg7NToDCsNG5pMsd796K0ERhMmnnd3olgtOsXAC41q5touM
 M/2mzqUK8fugbsA2Lsyvy00HFnr7wmNVUS3rM1afv6dIUQxTqYnq4UycBYP5myWZu7yq
 hybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485644; x=1743090444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dX9rUzkX3sdDr3FQsYg48xqFRgIMTEyFu0OjHzLhXeM=;
 b=Hs4PU5WrVTSa/eX5Qybqa2K5oB0mHSfkq5ama2pltScwTpUvK7WeYkb6/X2yNiQaQ+
 JZi4tkJs3fbIpVkdZcKC6UI2CmnPVBqjMHbYX/VEFYtLxYJts0Awt5t+nx7RvMl4CL0J
 SNFlyxuFpdmO4XBmd081tHDKiIUOZK2sse4tCqxDK46dEXwQe7UfFYYhrPUdEGhWhsat
 wB5r0MwCkrEdlEXxmL/X3+1KJep+J2Bm4elRCQkALmMd5sOsM1jjEKsZN4UvWtrSr5Mu
 r3UOTZA2mSnowEj9eKyuOX2MBHyRO4vwE5USC6UxbNXymJEOANx+lsvUsZxUtLpJrDPa
 S8hQ==
X-Gm-Message-State: AOJu0Yz6K2RC8CtFe8gjB4Bg2tah5EFsMeDQ+Q6hhjjZ4Ms9o5J5ErlU
 ZudYDQWqhbGVfF3TnxzFpeGuWAJ17yw0k7MS8DCkFYaddBXjpyfKH6Od+P7DXA7edYyXQBwmyfP
 6
X-Gm-Gg: ASbGncvvaKW+csoX9sedrV2SQMhrpIOZLd9y7GogL31aOAUaRA7ecLIIjL5QcW1CdB3
 4/00nNYoiLN2sa2MBGavc8GSoPbO29+KDYnd3Ff3sZtdfEm2EfsdwblKQ5HN+0UvE0BM3wOeleo
 8965vvZKLDMZqYwoQ2aLu7DLRybedwlre8G0RP1GYR+HbRGs+LVEjXugq5pkC3iq0YL4mzTQllB
 x3pBC0roqQGcVz/vFVJxaVTZKODUNltLwpXIldSjE60H3UpjBMLfklx090zHXdP3lsJV4GgVDfR
 8kMlqt9PM0gZynodPDCqdoDSzdtz59YfWeNvNVdFikwBLvUManopobhRG26fILyEP1Ogrolznmp
 6Q1G6yvyk1ktvPhzJ+0ZsUJoSN+RvT12z2vg=
X-Google-Smtp-Source: AGHT+IHKLSBAaGymF10RQgWCYq22PPMV+5kVdDb1E4uxBnBj5Z/ceNqRWTQrFhT1jC14EmvDO/58KA==
X-Received: by 2002:a05:600c:4fc8:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-43d4378212cmr58732205e9.6.1742485644017; 
 Thu, 20 Mar 2025 08:47:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed5e0sm51715915e9.37.2025.03.20.08.47.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/6] qom: Add object_class_implements_type()
Date: Thu, 20 Mar 2025 16:47:16 +0100
Message-ID: <20250320154722.27349-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi,

object_class_dynamic_cast() checks whether a class implements
a type name, and return the class casted appropriately. This
also works with interfaces, except when an interface is
implemented multiple times (by intermediate abstract parents /
interfaces).

This series factors object_class_implements_type() out of
object_class_dynamic_cast() and use it (at least the meaning
seems clearer to me when reviewing).

I could get it working with object_class_foreach() but for
some reason fail at writing a proper test. Posting the last
patch as RFC so we can discuss it on the list.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  qom: Factor object_class_dynamic_cast_ambiguous() out
  qom: Add object_class_implements_type()
  qom: Test object_class_implements_type()
  qom: Prefer object_class_implements_type() to check type
    implementation
  qom: Use object_class_implements_type() in object_class_foreach()
  XXX qom: Test object_class_get_list()

 include/qom/object.h             | 10 ++++++
 chardev/char.c                   |  2 +-
 hw/arm/xlnx-versal-virt.c        |  2 +-
 hw/core/cpu-common.c             |  2 +-
 hw/core/machine.c                |  4 +--
 hw/i386/xen/xen_platform.c       |  2 +-
 hw/pci/pci.c                     |  6 ++--
 qom/object.c                     | 29 ++++++++++++++---
 qom/object_interfaces.c          |  2 +-
 qom/qom-qmp-cmds.c               |  4 +--
 system/qdev-monitor.c            |  4 +--
 system/tpm.c                     |  2 +-
 target/alpha/cpu.c               |  2 +-
 target/rx/cpu.c                  |  2 +-
 tests/unit/check-qom-interface.c | 56 ++++++++++++++++++++++++++++++++
 15 files changed, 108 insertions(+), 21 deletions(-)

-- 
2.47.1


