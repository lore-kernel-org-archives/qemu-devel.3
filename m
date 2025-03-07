Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD7EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZU9-000838-Fr; Fri, 07 Mar 2025 10:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZR7-0005t6-5O
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZR3-0004J7-0Q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390ec449556so2401433f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360581; x=1741965381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2M0a517d1Rlrjf61qw++CyqLYHK0smyqzlvRXusipU=;
 b=ntMcKTzOF+7AN04NBz90bvNZZqfi5AobvL9Ctf+9qlmW2vH6tWZkaxyKnxY7dICY6h
 vcxayw+4uj4KiM8DBYxmKthMsL6gMdgjJfvn5J4Vb5MOPede9SVlFdqviuyZK/9K8A6j
 rykEkc1ZHxuDsEO0IhjLzPHNQtDNiPKqRuHV5GveHtYYTd/nAmawgMEVqcw1UKuv0pbh
 UY4L/FKiGphwhyiXufBlGUXUXUFiriuTe/sg2VEWto3tzn7+kPBPcsXItMS1i3CaBQnJ
 Fl36o82MtM64axER7odQjBQOh2pDC8JAHwLlEqpBVcS16UJ4933ttKBePg1P2LdDAwLD
 3EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360581; x=1741965381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2M0a517d1Rlrjf61qw++CyqLYHK0smyqzlvRXusipU=;
 b=dfZdjiQx6H5i5PAkUpp3ZRNWFcKV43kcZ7rCYGkrKZJXBPgkJcjNC8ZElFWC5kLBG2
 lhEp5wfxvv8Qd79Qu9aGIBCPPjcoAQ8VNY894ojrChh7OJrUaQe+XuDylSW+xWhGlOwg
 j3R23hxsae5XarUcjuHRzW3pdKxIUrPZlDs5RGGIDr61T7B8DGk0nVaIOA+ELkNX+ZTC
 bZtyHMNuwmEzIIZxtXC3ytK2m9x1qRROf6y1pcA/lJShR4bSazpoIr9xlVgH2HTDfL9n
 ija2KSRU8r0pDC2ngt3SPgnkzufrEx5DtG6uI8tK/6/aCl1oLoAR3QXb0ptqyXU86juN
 NpsQ==
X-Gm-Message-State: AOJu0Yx8H9HhAsTL0zsHoC7zNh5/em/XfVvSr/0sDMZJUu3NkskfUMth
 y9eLDSIjPx9+ywp7Jotk8jE/gU5Ozmf8Hv2Kk4LST9oudsoFdR2QhQ8qawdkj2+pcCM7wvpd3R8
 lD10=
X-Gm-Gg: ASbGncuDaSko5hyF4sCIM+13GjGEZ8T9lpVKNaoRs2z2hDbi8r2xKLmM+3MQCvRsRDb
 9gpGUBiYCNEjPlp1UYPyCrTODwwXlPtl2f+EACwnCByqpN/MnAqpsu1Yc3ZAKcMlxs7l9TRTmZQ
 IYbgD+wvXZBUJtg9E0HjMYsiA/zdCUXwPbIzjpMBf39R6n4WernED2RM9BjI0d7oNXLIbCQEgo4
 mD4hUh1+1QLQS9DdzxrOz1gn22nwZeuQZRksXuCQF6uiz2lhgh4SUUiLP/RQIOtShKRHxxQilZX
 +36Lq9I/BSVIutH29b8NAK2pd039ouJhue3BbRzuVsL+/fx8kTTBqd8/FDX51uqk1mU+EX/pFc2
 oE94g5JeKCi+k0PaznX8=
X-Google-Smtp-Source: AGHT+IE6viTOxfYNINYbNt6NqpVdYkBqIDRHvZatGCQ9b6TBRyzoElVMUx0m1H+D07c9TUGpR9Cbhg==
X-Received: by 2002:a05:6000:2108:b0:391:22e2:cd25 with SMTP id
 ffacd0b85a97d-39132d7290amr3197152f8f.31.1741360580240; 
 Fri, 07 Mar 2025 07:16:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1037b4sm5651435f8f.92.2025.03.07.07.16.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:16:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] hw/virtio: Compile virtio-mem.c once
Date: Fri,  7 Mar 2025 16:15:43 +0100
Message-ID: <20250307151543.8156-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Remove unused "exec/ram_addr.h" header. This file doesn't
use any target specific definitions anymore, compile it
once by moving it to system_virtio_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 1 -
 hw/virtio/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ea7229ce28c..a5d732ac6d9 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,7 +25,6 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "exec/ram_addr.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index a5f9f7999dd..7c3513315cb 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -55,7 +55,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
 
-- 
2.47.1


