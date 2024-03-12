Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D00C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQ1-0005sn-Hb; Tue, 12 Mar 2024 04:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPy-0005rj-He
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPv-0001BM-RZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4131b1f8c91so25236155e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231801; x=1710836601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29XjHGwit3vYXMB9dG4vvP3w+ZRgmYEAu29xmgeR40E=;
 b=AX4t/VahYZcM87BIA5LZ0LFDZ899y3UkP1QNKUqZRGY1b0s10GoKAdJXtJMeJY7KHz
 7drWnOAcSx1IthKJR2u9JZ+UCE4gIqgiD2E4jza07NjkiTqD5KMQpUyOn70tlJhotcwf
 /jWuvbra6vCETc3LeA9Szgc9yIYqWelcQ/gL9gCNCpoCpP6hfJiL2VRQRVj2oVqzRpMu
 GTQtjuQoF5aedpn7+ip3Zi9TSNYHoCRW+YFUp3+j3f2CkiGFy+dR0YYg9ASxLjaHvHOH
 gdDgOvC7vZj+Gkb75n2UwgoyTclB7wqU2XSUIzKqnVASViZzlhbFImVMWXLtYFBDTgW+
 Uw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231801; x=1710836601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29XjHGwit3vYXMB9dG4vvP3w+ZRgmYEAu29xmgeR40E=;
 b=noD13LpemdhPA/IQhQmRPHwNf4OJMn9E6lIczPnCO+NDfmnIxQ931ZL4GyAcTGLsuf
 9K9UEQ4kqFRbCJdfI+X9IL85HXEgMYN58lndvCm8xEDvdclmhP7INnT0wMmRdx01HK7Q
 MJHGr+GVYsydtEyJoKVITveQNsiiga2rAxB9/F83wLqbJeqRtQp5rjrGNzA9oHJg4vPN
 ChOY6dTE7Y8Nup7XWjsDSQua5B7JoJ4w2zv29/5hb3g675I1MqrOK5W7/qdXkY9mLy+g
 WTtnmNp1Sdi62zxKsnGTsFSLkM1oupReX3d5a4NxljRAC3jyyG+sdP8uMsa6X/q8XaJI
 ngBg==
X-Gm-Message-State: AOJu0Yw6JA1oaBrm568HHtUtqjNfhSxFNjXgrB1Qo8y9pK343r2XeJwj
 FfUZIZawavEyi79r6EWTPldLpxEXR0TMpP5rNN7zEjn03pCWK+h5Vv7pwjseVIz5A0tNNAWDXQE
 b
X-Google-Smtp-Source: AGHT+IFoVsmNpQuLbqfqPyDiurVI8kvgNzArr/AiPDLgxLg6ygTQnedi38jg1zpokb5Jo2ZwV0KXIw==
X-Received: by 2002:a05:600c:5190:b0:413:27d0:44ff with SMTP id
 fa16-20020a05600c519000b0041327d044ffmr4080264wmb.8.1710231801005; 
 Tue, 12 Mar 2024 01:23:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c348700b0041330d49604sm2480108wmq.45.2024.03.12.01.23.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Juan Quintela <quintela@trasno.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Galaxy <mgalaxy@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/13] hw/misc/ivshmem: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Tue, 12 Mar 2024 09:22:31 +0100
Message-ID: <20240312082239.69696-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The ivshmem_common_realize() passes @errp to error_prepend(), and as a
DeviceClass.realize method, there are too many possible callers to check
the impact of this defect; it may or may not be harmless. Thus it is
necessary to protect @errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Juan Quintela <quintela@trasno.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Michael Galaxy <mgalaxy@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240311033822.3142585-17-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/ivshmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a2fd0bc365..de49d1b8a8 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -832,6 +832,7 @@ static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
 
 static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_GUARD();
     IVShmemState *s = IVSHMEM_COMMON(dev);
     Error *err = NULL;
     uint8_t *pci_conf;
-- 
2.41.0


