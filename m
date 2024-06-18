Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2D1C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbN3-0004IV-6U; Tue, 18 Jun 2024 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMr-0003ot-0S
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMp-0007y7-DW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso42791895e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726849; x=1719331649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9oK3hagVT3DDExa4pE11FCGGKWewTtrkZCXKVX3HNA=;
 b=yKu6cDhJQ9Dv+ixnNd+8nXWJCnM0uOr+D8HdVZMKcIEnEIwOFjvMR6u9Gcr9L579ku
 KIPduuwd6WmaljwkD0Z4kHxilTJ8KNSnUSZpHjEAEZyWSqARFzBy2uytlxWVmQKCn0wR
 N9SNlEueQ3Aa/Bsh7M7gVzT9D5LUCwthpriyISmPO7T66lB29YauOFHbA5YHaFulizGc
 KT+nvuea+aH6xWbXt55HY+qOw72NIazZqkfd7jyaq/KWXWBTYETWjkHX7oG1IdG6mqdY
 6XjhnGTTDGI9SAYJxBasyZx3Uds91IQkslsWYXrlgUSsSs+fFOuyJP50uClG8o9xAazo
 L00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726849; x=1719331649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9oK3hagVT3DDExa4pE11FCGGKWewTtrkZCXKVX3HNA=;
 b=rnqlEjaxlJZSHBtSI6h0Bytfc5ofTYO4XweyKYwT+amWNQVe9SfZFKzL62BT9iCcUQ
 9w59sNBhKsUFMwj1N5O3iTd7qLihJbx2FDSh+mf78hCySmghPHnZJtadmhN304hr/3WG
 lKSvC/P36Hh1aj01sIrxlL9BWm1aF7FXu54IZV/GQzY+owUyy8w5DSV7OQPNdVScdFQW
 SuiF8LWfv4pXOyxTe1zFjWFgtlmF8qUWySGlmHylJp2T7Y8Xdi2a/qTKmrEwnEHlEngb
 er981XHqCt/w5bvq/cDmJMCHfoxPZJ9JBu9ZCCcs66FLjb8J99zsK4cOwMC3UMLhxSZS
 nIlQ==
X-Gm-Message-State: AOJu0Yxv8Ctgrf3vsYZmw8fSCK151GTxSRvolAnYnvXzpF9nhOjleffc
 Tg3q8/qtETKS2J9zqosbVPh5CSTPKjgDTCODZIBFLgdJsCLFjbLIEw21iMWaOmAqoZva6eQzJew
 T
X-Google-Smtp-Source: AGHT+IF/VRRkeIaeBFZ2iccBSWrPEzd0ZdtGozsL3RSYotladdhpEhXkUdiFyqsCgmbheoOd0xUWPA==
X-Received: by 2002:a05:600c:5349:b0:421:1dde:cb5a with SMTP id
 5b1f17b1804b1-42304859dcfmr106905045e9.35.1718726849608; 
 Tue, 18 Jun 2024 09:07:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e986asm233111365e9.27.2024.06.18.09.07.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 71/76] MAINTAINERS: drop virtio-gpu maintainership
Date: Tue, 18 Jun 2024 18:00:33 +0200
Message-ID: <20240618160039.36108-72-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Gerd Hoffmann <kraxel@redhat.com>

Remove myself from virtio-gpu entries.
Flip status to "Orphan" for entries which have nobody else listed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240528083858.836262-4-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f63bcdc7d..7cc6421e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2579,8 +2579,7 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
@@ -2602,7 +2601,6 @@ F: include/hw/virtio/virtio-blk-common.h
 
 vhost-user-gpu
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
-R: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: docs/interop/vhost-user-gpu.rst
 F: contrib/vhost-user-gpu
-- 
2.41.0


