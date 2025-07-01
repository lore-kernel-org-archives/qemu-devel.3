Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAA-0005Kg-D6; Tue, 01 Jul 2025 10:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcA6-00059a-0Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWc9y-0006oL-ND
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so34743915e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380831; x=1751985631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvuJfWqGzppF+6GKJm+5+ELCNc5TU9HYoRZM5cWxCY8=;
 b=xiRGHGjiIKgrKBKu1kwJicCyEek+J3TjNkK4/ys9ckJ7nJ1U3m9w7u0JMzmLXueThv
 DawwSwod7gKAIS47WInmqVT6ttGLyM3C6TMwqa1Yq5YqTK6GXf9idQzdY56sGnJxxzCD
 oz0mVXgyJuIzpciompA4fqtl9FhM5snNmjXKAeXz/AApbHVjUrnnJsrAfRCREX9lZLJx
 BjgHt6gp/1Am6Qq6kleJebCUAEZorh13QA1mepc/EVvICb4C1Rzd7u5IDdF/MuWzQzph
 Ox+lxzVfWCGOQ4DSCOobGo5iBfc/7BtvDNDpECzIHO7rtWbFonB0RQei4bqstlA8FkVm
 iVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380831; x=1751985631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvuJfWqGzppF+6GKJm+5+ELCNc5TU9HYoRZM5cWxCY8=;
 b=i9VRWRMrQwVNqx9P+ugmU4wnPeXgqVTSMR+bx0uvm3CcdASFl/IP2mM3u8b7tg71Kr
 tElphZbyK1xCarcvyeDpJ83VDjhIP/Rhwr/v91znBzpChva1MObJ1j7/ICTJfUohZhes
 cBscpQwYswCl/zxdr1rtteRN+eNaQB6KwGfM5r2NSgJF2+g/HCs0W2rUDj9ndyeuWur+
 Tm40EJil465kGMeLp0J0UQ9CZb52hXAZMozWHhtt7sknn96cln8p7K4OS5j8HfcDSY9L
 Asllk6J0LE5zOx6vQ1jujH3rIzHVWqZoj4q4KRjeQ1BFhYlgxZwven7GGkM7sw6kqnW7
 z8ug==
X-Gm-Message-State: AOJu0YwX30ylziSIYgHgWE4rU952sbuC3dbVEPWA+Xng3O9UlwPSICVr
 zT9Uj3p8FC1iyA+X//eemGCwrhHxW0jsYXFnzzKtihGNY1EdHLGNRNLVMSnA/+DL4TkqoBAcoEj
 xmUWv
X-Gm-Gg: ASbGncsiGgnoC3Ks28sny6LCoUyj/0IPzjfgZHGNjnd3yQ1PBuq0cowx0mx/2uTpFsC
 YXFN2pAbnoL6VVZtTD9PdpPpbQbL8xFm3IxHbAwp8Y0IrSu2KbnblywkT09bQVODns9qzv78X8f
 QCq736mvtgoWVGj8JAlpN0z1Cp/Rlf1Dhek8IVfDtp1+ZDTPPIMt9whzqcGxghyPvpzFNS5aqcd
 wMKRS8hnPe4aoadYv4b1kHNHtMqsCsBUlBO3G1vvb4vPeciaoKTFnt9wtgqH8Y5Uf79JhyeSyLt
 Kc1DZ/hqHgGUftYbeKkVBHb0fXOaAe/BtuD46KgLY8G5nm2f6tO4atGEIDpS7WFaU84Pw9SgUZY
 2h1SH4hY2mOR+IqUcK6Q1H7M70b2TkrgdLlEh
X-Google-Smtp-Source: AGHT+IFmti5Rfu0bgwIeBc6ssNqUMNTrBzt5g3E92IA8qcdxcOxuJfHYzaXCWHHc2+UjPzFoMnc+nA==
X-Received: by 2002:a05:6000:4105:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3a8fdff464emr13002876f8f.16.1751380831335; 
 Tue, 01 Jul 2025 07:40:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59720sm13394681f8f.73.2025.07.01.07.40.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/68] system/cpus: Defer memory layout changes until vCPUs
 are realized
Date: Tue,  1 Jul 2025 16:39:10 +0200
Message-ID: <20250701144017.43487-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

vCPUs are not really usable until fully realized. Do not attempt
to commit memory changes in the middle of vCPU realization. Defer
until realization is completed and vCPU fully operational.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index ff0ca40222d..8b2be31fa7e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2792,6 +2792,14 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
     /*
      * Defer changes to as->memory_dispatch until the cpu is quiescent.
      * Otherwise we race between (1) other cpu threads and (2) ongoing
-- 
2.49.0


