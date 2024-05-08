Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED06C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNc-0002mW-2G; Wed, 08 May 2024 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNV-0002AX-98
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNQ-0008IA-0V
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59b097b202so2562766b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190405; x=1715795205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvmYkwM/vtus+gTFbMymcQXt7CwFyRNe8VlkJ3oWH6M=;
 b=HVNHj3K2OIXkdH+wsxNcXWxn5VzagTNa11PiIQvKN3GiRDLAcYQ5hMVF+nO3lj9Qs0
 OFAju4QI9JoQ/x966YiwwbTx/IDlkPDXQdjqhPRAsFnW1987HJmpvdBEQK9KSWYpYUWc
 Qk0kpqEc+zq74YGYJRG8zrilUNs5t6crcFNrQIlQsXDqH8IBc3dASz4vKoZJsZdp3y4r
 km36CHEinh1UnjElnEBSy/DSabpgHAqFkoav2YHXJBemctb0qFXqMhalptdk+jX2+MUH
 kZ3os9b3X3U5rHqYfFqlI9dxHKep+TGtEtgziV/dv+dGliLD+K+dU0eryRwxbng0e1j1
 FXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190405; x=1715795205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvmYkwM/vtus+gTFbMymcQXt7CwFyRNe8VlkJ3oWH6M=;
 b=OX6W0wmwvNPGxs/rnYz3cz1XrvchmNi1rZoe0Udir7ML9fbcE0jJuo8P1vBs8+jmp7
 EtVLoSomlXB9vI0refQ+r9UzHorIjsgzM5y57M750w7CWPjDvQQPDSXGKIeXnHrRpuPz
 s00mFnS5Xpd1ZSuWTBIK4l+Zg3UWj9DFfx9570nTLcpfk1ALnMyBqiGc6QBv/LKkx386
 Anse8gveAmw3+SQAyUL8ttgOqzJPjKl28X54wAyrFzxai/zsYypom2GjcB3S5ob1S0a2
 qjmRHKCUY04tBF1q8DZkv7Rjf/h9Kjf4zoIGFjE4VjrmymDNWrKrzXI7uACKF/93tf7j
 AA9w==
X-Gm-Message-State: AOJu0Yzf5bsUzwEPej+k0AJIY7hzRNtRND4AG+YbExhknPjTjOZcFWw6
 mAs52sfQufMvY2FjvpJddWRup1caS7UnH4rh/RJNEZ7KQsF5LSXNFAMJKHmp35qfhCWHYZQkQAH
 k
X-Google-Smtp-Source: AGHT+IF26hRzWZQQz/L7HTj2f+65lx+LGGImSfo+vjzv/tEhlb5+9KyVzLr9GXO+pyHHYTPj/UZuOw==
X-Received: by 2002:a17:906:6051:b0:a59:bbd6:bb39 with SMTP id
 a640c23a62f3a-a59fb9c6be6mr220795066b.55.1715190405295; 
 Wed, 08 May 2024 10:46:45 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 d12-20020a17090648cc00b00a59a874136fsm5744899ejt.214.2024.05.08.10.46.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/26] hw/ppc: Deprecate 'ref405ep' machine and 405 CPUs
Date: Wed,  8 May 2024 19:45:01 +0200
Message-ID: <20240508174510.60470-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The 'ref405ep' machine and PPC 405 CPU have no known users, firmware
images are not available, OpenWRT dropped support in 2019, U-Boot in
2017, Linux also is dropping support in 2024. It is time to let go of
this ancient hardware and focus on newer CPUs and platforms.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20240507123332.641708-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/ppc/ppc405_boards.c    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03f8b1b655..e22acb17f2 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -258,6 +258,14 @@ dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does; the ``sx1``
 and ``sx1-v1`` OMAP1 machines remain supported for now.
 
+PPC 405 ``ref405ep`` machine (since 9.1)
+''''''''''''''''''''''''''''''''''''''''
+
+The ``ref405ep`` machine and PPC 405 CPU have no known users, firmware
+images are not available, OpenWRT dropped support in 2019, U-Boot in
+2017, Linux also is dropping support in 2024. It is time to let go of
+this ancient hardware and focus on newer CPUs and platforms.
+
 Backend options
 ---------------
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 4092ebc1ab..c44e7ed162 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -350,6 +350,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->init = ppc405_init;
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 static const TypeInfo ppc405_machine_type = {
-- 
2.41.0


