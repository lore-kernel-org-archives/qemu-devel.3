Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390EBC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMs-0006Xo-8H; Fri, 07 Mar 2025 17:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMn-0006NU-BE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:29 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMl-0003c5-KH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:29 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912c09bea5so1707614f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387225; x=1741992025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnovoaUMqprzKKHYFuoZMJZ/2zGWdVOJkellgnL8PG0=;
 b=czMQKFBYNwLtRP7DsDDarkvweUNXkkfgPiPyqMuqG6BtxfiOHcfehR2bHDv9iYQl+7
 3Hjdh8XagrlUPVpDWV4YAPdq8O8WTIq911kTDKgEAAqdWipilNHboQ+cSgqzaMML9AMX
 02vWH4FXm7XaUA+wm1ZlmL2HaTjMuu2GcVVD9NLrQ9s67QKo1LCiFe03+xC+LQQwR4DM
 nErDAh2KMsJpM+cd2oc3eIm7HzHI170z9I0b1G9EpULQxyDE8IVruBsTYJjTmEXqktwH
 vq95f5mgfrduc3vIVWTksT4pFN7xWKIjzXS8IFN1NuB8hny/jiCheQrNI33L9Jat+pP3
 72Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387225; x=1741992025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnovoaUMqprzKKHYFuoZMJZ/2zGWdVOJkellgnL8PG0=;
 b=KCT+3+96PCby4ng/nGlyf4zyR6Ngxz5UMIDncJA/2toyyy4VMYEl5o0yZWe5V2iaLE
 Z2/Cx6L/7E43ht3qvaiPgT6ZdJhUFKkILeaMmt6RKto65t2WU4lJpGv6xwKIV0LnaU1o
 jKQwih6orTuw3t36UCf8hjxkmUgyO+oRQixo+2PvZ53+orz0EqGUq5781GZPUeT9CDpQ
 8QUiFls4PxkNszH176QXmRzMbBadP1pjha7guN7e0M+NqPKLpnVatL7mybXB4W+xsasl
 P9CKeRZKtHI/8FthfgS+p/P1E9MGnYyM9z6kWoYcYcLM1ZcnMrsPNuQPkn+J6BySq2or
 zdtA==
X-Gm-Message-State: AOJu0YwR8+B/KQ1AHcrP0bYDY4H1WyzWhsXph063DfpCpJiFLoc4yPd2
 qL6+Uygvc0+HpmdhTl6I1QiIRn3900/PNrnnCZKi+VCFwV/GbKeQgJWGDfTa8V1P+QNhxt2+R9N
 MjyY=
X-Gm-Gg: ASbGncsZLWooeh0Ji1lrRyHFUVrE6Zr9SKWHOee399zb+nHu9c/JzQ4UB2ipZnjaf+3
 MJULglcaDic7g9LElo0CbQY9Xc3ysjIPBcnjb9dFUuXkgY75koZrSsNvs7OVCMKTUB1dUpCsUQe
 tY8WKDjRunGQzyO6uNYkxYaPoUj+xS8mJhO2QFr62oxzZFlMe8SOcS4g8C2hCeQmZaN+GPpSoXC
 uoZHHZeNFBrG62pER9vJMQU2FdK3Cij0YNapBItUvthu3QSoruIfLscNIxXKQx2tXCZOARIPonM
 XjG1qzSI0751G65H08HfG8WMQSLptimJXuv5QpSBXd1JNmvFyDK88ENUU21mwXzpxr0TI1U34MC
 UvwicG/p+mJ42DekqTbk=
X-Google-Smtp-Source: AGHT+IGY8etv8/dIDm9L/f7Om9gzMsUEqO/hLEAhAxuVK4Ifw6WAs0qqxGNql5lclqfEMFltDpfVAw==
X-Received: by 2002:a05:6000:471d:b0:391:20ef:6300 with SMTP id
 ffacd0b85a97d-39132d98c7dmr3250867f8f.37.1741387225570; 
 Fri, 07 Mar 2025 14:40:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9471b7sm63627185e9.34.2025.03.07.14.40.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] hw/virtio: Compile virtio-mem.c once
Date: Fri,  7 Mar 2025 23:39:49 +0100
Message-ID: <20250307223949.54040-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 1 -
 hw/virtio/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 5288fe597b3..2e51dcfdf32 100644
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


