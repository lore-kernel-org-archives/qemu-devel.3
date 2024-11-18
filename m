Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3ADD49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD19o-0002yz-66; Mon, 18 Nov 2024 07:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19m-0002yd-JR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:06 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19k-0005Ns-Ql
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:06 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3822b77da55so1514713f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934023; x=1732538823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKQcu6yyxgnJym09mQmqk/PdgN/HdWF9BDJSP2Hzwtk=;
 b=BFdlMj8dE1vOYtRZRJP6ljP1/sztQMndGcBWIscTpwK4wwc4aQnvFRMax0FVF39p1i
 05slaTO78xIz/zuhiMNGdqzTAFJxvTNekxXGOQUV2LTatkF0cALPC+vwQyHEybx1ox/Y
 MgHMVWZPOXEq273C7WPoKTSTUcJaHnO841FQLVIFCZ2BQFExCO5UZoo1m9d6pu3Ref2o
 ELr9X75TxJfw3jlvhuZKpyy0FUY00aEqKWhQ1cAsyB7ZJTNrQ9qpYgJ4j93RZMgavQ9Z
 OB9MFoEOWpGoiJpe/vqpaBkEhXreZSjmHDQlYlnSEti8IOE6bvLicwGeZpaC9GpKXvuQ
 tyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934023; x=1732538823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKQcu6yyxgnJym09mQmqk/PdgN/HdWF9BDJSP2Hzwtk=;
 b=Q9ttgvL4HVIO4iuIf9N8Oo8LpoOm9x2+Cxj5WB6ebvVMdbnml9zEwpHD5+S+GXXQp7
 G2wZRsL4nfG5uwwqfjkVqAkSLar33NZ+HXrEIR0wGtgThWmx8EcnykeT59hGDHnF9byT
 Qh09hMmUNJp5dw6ACMDT77zOdLcIsozssRu/WcsMO/zGUph6un656ehRzreyTH1/pUhB
 p/GDJ1E7zLRWoNi363bschaFuiYHGYvjjxAokZZEdi9VRVYncPFy3save9wGphMddxrg
 vRbu1ItWbjZomMYv9+ZEQjDAXP9wsa8Z+KjTTHhT7iwr0SbgVQ496jw7O/5fHbdfQp2Q
 zhVg==
X-Gm-Message-State: AOJu0YwYFJcSbjKzVDzir+pvHJcN4o7xJ6/Ky/FnXXkUmpIDCnw6nOaq
 8pyCplz50LBTOO72yLzMU4r14c3SKWaomnGMheWhW3MAW1+9D6RaDllI1XYnAyTXQoHizDXOVKN
 O
X-Google-Smtp-Source: AGHT+IFU0k7Q+poTGX59Kj+jvpvaoDOfPIajK7qRMQXzDXvE3SrvOgZWOeQRt7wM28JJRawOmw6+Aw==
X-Received: by 2002:a5d:5889:0:b0:367:8e57:8 with SMTP id
 ffacd0b85a97d-38214064639mr15163179f8f.19.1731934022793; 
 Mon, 18 Nov 2024 04:47:02 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae161d8sm12987275f8f.78.2024.11.18.04.47.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/15] hw/i386/elfboot: allocate "header" in heap
Date: Mon, 18 Nov 2024 13:46:30 +0100
Message-ID: <20241118124643.6958-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
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

From: Sergio Lopez <slp@redhat.com>

In x86_load_linux(), we were using a stack-allocated array as data for
fw_cfg_add_bytes(). Since the latter just takes a reference to the
pointer instead of copying the data, it can happen that the contents
have been overridden by the time the guest attempts to access them.

Instead of using the stack-allocated array, allocate some memory from
the heap, copy the contents of the array, and use it for fw_cfg.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241109053748.13183-1-slp@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/x86-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index bc360a9ea4..dc031af662 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -697,9 +697,11 @@ void x86_load_linux(X86MachineState *x86ms,
                 strlen(kernel_cmdline) + 1);
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
 
+            setup = g_memdup2(header, sizeof(header));
+
             fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
             fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
-                             header, sizeof(header));
+                             setup, sizeof(header));
 
             /* load initrd */
             if (initrd_filename) {
-- 
2.45.2


