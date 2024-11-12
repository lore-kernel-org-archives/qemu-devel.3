Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08036D42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMi-0005D1-9n; Tue, 12 Nov 2024 13:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMc-0005BT-C5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMa-0001wa-A3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d4b0943c7so3727460f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435098; x=1732039898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgOSNR6wPQJECLaWUR0U2aDVp6+TXCTXj/l4QB6G0rU=;
 b=mPaVWrNODwimrCiGaStTIfjh9I0CStiqM58LF9XK2CPnMtnU5Q1SslHCil/76ryTIM
 jsXMqMpAUYQeVTWY0b2A8gwvxRP645VkwzKhfDd1bG87nzsNQL0Gw9s5NRnN+kQaTd9h
 viPYr/r7RojLUWwndqrsSZs4tXQX7/AWK9hLdPTNXtlE2JlORdANyX0etCm9MrrM/oTj
 gzWqmKujHS3cPtGGNe4suw2GvFAikpQ+U+FfzCJz6PEJ+ICiHtU0VNxG/WPpnn+0Ad+8
 qfNuCSkKGbI1FoRMFnAGgbl4GEhggZsUjL+w6CQq07NCMZG0p+U5y7fOO7pbbWEnRX3k
 PR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435098; x=1732039898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgOSNR6wPQJECLaWUR0U2aDVp6+TXCTXj/l4QB6G0rU=;
 b=fhAFDqHfEAPyIUHlSRxO4VjbTwi4zwEYIrxOuOOFuOPGLPnc5uCHIyAZIa6O0ylgV8
 wi97q/qv/IqLTLr3c7IYLfDF09/cM/KrDgLt6sJxK+KbXNY8NJwj8bd0j/frdVde+ndW
 ApEZ+pQxaBaO3+AR9SmYng8YN7Zg3cegZC4sD0jVZt6czfZ7p51oVMUdLIA4/uKz38rE
 JWtS1tHd/wZGnTAbRiVMH2ZO8rLxAJnJ3scPQyKIoJ0uo4ygZ6qvap6EVy5OFIMZKrCp
 u9YwQvRyjubKbWqx62ngM0+6Ql0ko4Y4yqWZ8cIclY4/0jlrhhXbMVXLCeqo56C6PGMZ
 QLLw==
X-Gm-Message-State: AOJu0YxbBA1LnkAybgyvQtkKj7V9x/xIFMZQqYsgBeEPptRfh7h3fWia
 k3b37cAdvy0Hozidt5Ltimqb3Joyt865OJDuGPBc0pxfUnL6TQPT7aHaK0Jy1MOgxYyfkBVUBa9
 7
X-Google-Smtp-Source: AGHT+IFsF4foONjJOW4bmVgnTVFCrHVLZ2H51xCAsRqc7ggHD4LRg+7hZrCxdG0huNvWXUQ9IJgavw==
X-Received: by 2002:a05:6000:4028:b0:37d:4cef:538b with SMTP id
 ffacd0b85a97d-381f1872621mr12245629f8f.26.1731435097732; 
 Tue, 12 Nov 2024 10:11:37 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04211sm15991976f8f.94.2024.11.12.10.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/20] hw/net/xilinx_ethlite: Add addr_to_port_index() helper
Date: Tue, 12 Nov 2024 19:10:32 +0100
Message-ID: <20241112181044.92193-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

For a particular physical address within the EthLite MMIO range,
addr_to_port_index() returns which port is accessed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 20919b4f54..fe91891310 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
@@ -86,6 +87,12 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
     }
 }
 
+__attribute__((unused))
+static unsigned addr_to_port_index(hwaddr addr)
+{
+    return extract64(addr, 11, 1);
+}
+
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -190,7 +197,8 @@ static bool eth_can_rx(NetClientState *nc)
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->port_index * (0x800 / 4);
+    unsigned int port_index = s->port_index;
+    unsigned int rxbase = port_index * (0x800 / 4);
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
-- 
2.45.2


