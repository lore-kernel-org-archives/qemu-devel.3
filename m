Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E560FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH86-0008Pq-Gx; Mon, 01 Jul 2024 09:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7q-0008I6-6O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7o-0005O3-GT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:21 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c86e3fb6e7so1744260a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719840679; x=1720445479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1RryP+60mMhkO8WnO7FIMUxhiFZxnyyH7/OPgo3rZg=;
 b=V6P7FiAhJM39OZUOFKjcmBxysuuAtLzBLNm3ghqcHHP3qg6YSj6OF+XHz8kwE4tr2t
 EYWiJljwr1Hu0yEPoQ+yPOQHlG8uH+OmD3PutB4X8GpqxPmZVEBeFA1291btvrdkJD+c
 Bt6o3QJNxltZyHTgrjNc9oq90Y4HnHx0sGuKdyaK9brA+0LthRAHrdik4Z3sYr3OiMIZ
 59sP0/7i9bOi+wEy3J02ogp6IraLHDGnv/mQ9gJmBpLYDxVNrIFwWQ4oN8FYRDWeozsH
 6abJHIxzwcUNsarK84U9X0ziypOBdAumGkYn/t/pbJfKjN0aE2MjpbPSsubxUTDYhF5m
 6Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840679; x=1720445479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1RryP+60mMhkO8WnO7FIMUxhiFZxnyyH7/OPgo3rZg=;
 b=NPlLozpBR0Y5EHkgOjz/sIedxnt5dvw56nHtZ/JEUGYiWyQcdCrTFJ21gxHgRWBNpO
 +Iuw5RaC9322UIxoJV9n7unkLttxoSYtb6Hi65ctD2kidM4Z9K2EyHuNySmRdnmEEUxu
 brGppQv6sKXJ7EZxK5ANHy4qqUKzfxBj8pfrnQRwpJIjkGjJ2Xb6HMUerY2ZitZ9omkc
 KpGrw3S61mXiamDTXfOO7PHWGFEInsJC0MQbeakg5faMegh5OSiP3NEL3urexOTBUkN6
 Rvt24ptFeVFGVRrhAiaVziO5P2C7XIUU8EnsQFIgyXWsWeYjjMVr9K2JRnNv4R+mhvz9
 5Xag==
X-Gm-Message-State: AOJu0YxAdOaLCezWzFt8c6UZbgRAAb4bAX6RmJDI9ILozQeL5ijuGQDS
 W6av3dpOEtXgUiyLLp3guYcMUtFlKoTpTYVL4wIv2rEpeCqITWj21+lFBhYl/6xQtOjhe/tDYhE
 j
X-Google-Smtp-Source: AGHT+IH1R72NCHWtyvT6cjF3994QPDwvLOpV5wTHL4TprLIAx7QRrwQpRwu4I+azK0yqLdUKiuo5OA==
X-Received: by 2002:a17:90a:bd86:b0:2c8:7564:7fab with SMTP id
 98e67ed59e1d1-2c93d72e239mr2543406a91.27.1719840678414; 
 Mon, 01 Jul 2024 06:31:18 -0700 (PDT)
Received: from grind.. ([179.193.8.43]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3eb34bsm6736935a91.56.2024.07.01.06.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:31:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] system/vl.c: parse all -accel options
Date: Mon,  1 Jul 2024 10:30:38 -0300
Message-ID: <20240701133038.1489043-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
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

We're not honouring KVM options that are provided by any -accel option
aside from the first. In this example:

qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \ -accel
kvm,riscv-aia=hwaccel

'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
option that set 'riscv-aia' to 'hwaccel'.

The previous change guarantees that we'll not have mixed accelerators in
the command line, and now it's safe to activate 'merge_lists' for
'qemu_accel_opts'. This will merge all accel options in the same list,
allowing the 'qemu_opt_foreach()' callback in do_configure_accelerator()
to apply each one of them in the Accel class.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 system/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/vl.c b/system/vl.c
index 32602e68b7..5ed9a9229f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -259,6 +259,7 @@ static QemuOptsList qemu_accel_opts = {
     .name = "accel",
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
+    .merge_lists = true,
     .desc = {
         /*
          * no elements => accept any
-- 
2.45.2


