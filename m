Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F29C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKce-0003mf-Bx; Fri, 25 Jul 2025 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc4-0003OB-RY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc1-0002Uo-KE
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:36 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6129ff08877so5310713a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458331; x=1754063131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igf1pNYcYoZ3hwlkUPmHcAumxqDOxsPEzXZR12elC5s=;
 b=t3dcKi+GoCNOTP17Mi66uc6bOfPzNV2Klba9RMw8fsbcbcjETiQHvPTFbPqXj0lw+n
 fMB8lM2oTkmnnVQ8fJoR9ozzxQcSRlxeIqXfPWBJLase1NuMRi2bORxr61c4IQjFcBpv
 Ocx88GhK0qCS5w0zrgT6CSm4qgLshSDFwsTuo5ZSLSG4GWYHLIPm2cHCHQyBxQWkJhPM
 VfDKmXVgxOtcPZnpZHYJoTn2DIEy/aFuNu0g93GVkoumH8QuoKCM8CRez4oKcyJkeg8l
 ytLsApbIlxoQACCxMPqTj+y8KSIrXnuEBfPkLxACKI4c2e/xbZSSvQ+SILD9IjVFjF7h
 oKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458331; x=1754063131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Igf1pNYcYoZ3hwlkUPmHcAumxqDOxsPEzXZR12elC5s=;
 b=YG4yf6outA+6VYQKMizPp2yCgomkN77c4RgzWaRjmkPl1etEseF0ejc7KwVKCpVdv3
 uFPXsTmBQ+EE2m2T4/oA1VMaDWChRzPn1bKrH7gEDyixUkD1SOAP5xFvjFL9Lj7zVIPJ
 h/Z5CO9iKjS+CS854pkfgvchTOuFvzidAdeh5DdrF6JFQjfcsvEoyx6FbLqNayYwarqp
 7RwSiQwIFEz5banujXgpj6j/BwJXrpnYTsmmFM27YkFcMHbeY76ZLMONoeFVDRBpCCsn
 SJO0wpkNM2MnPd6qJK7lFuqgyev6n4lgEQwmePw+H18JQk/13dQJ9wey7bGGbKGv63Jc
 eZag==
X-Gm-Message-State: AOJu0YyKq+Th40atBTAbngP+3vFchmOh5nbhDf70paKHEpMPKj+Aav/j
 m2ZmG43n5/xRpr87PmTrs6Fx8btA3FwxhPmz3WdiCiGf3rSXZ97KmqLRcpBrxw8lSVM=
X-Gm-Gg: ASbGnct5txtnP0I+bkBPnwrVMM7laHxEQhD9CTyGp8LBqq7pIH9iJ4nRdmxSCiJqAga
 Y1iyDExLenXhMsh26jINUJAqvty31TggqFHPBcBxuEmsk+/MVLBpL4ObUYyH1PAQrpJIfD3Z75e
 xTzA+VPtg79RWLoQK6UPSFfeLROyE529yYKtJ7raz45bJzaVXqFYg+BjGaaPddEvxSrGx+wU7s2
 rHoErmBjHrxfMYBQnlVN6tc4skOrQhfmj8FSU/fAJqjMO/sJAyAy+FF1BSrhtUR9edW0NFH7Tgw
 SpqpEJ98FX0/KpzPkTs/1tWhL/SzUuY2uvaZBZnHERmGszwFxjYZ2TO4lCDicrcUGBJ1R8mYAhl
 6qGFhvbYNsPIbxG7yz3Mq0lI=
X-Google-Smtp-Source: AGHT+IH4rwZO5CpAHKc1e6daW/zsvnpN1AsNCxv11WFGwoG29RlPHAsh9IytmlJy1oJYkDgyPtrZbA==
X-Received: by 2002:a17:907:3c8a:b0:af2:4690:9df3 with SMTP id
 a640c23a62f3a-af4c3c4bb54mr665196266b.14.1753458330912; 
 Fri, 25 Jul 2025 08:45:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af6358600a4sm10405066b.25.2025.07.25.08.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 738435F8D5;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 07/14] tests/tcg: skip libsyscall.so on softmmu
 tests
Date: Fri, 25 Jul 2025 16:45:10 +0100
Message-ID: <20250725154517.3523095-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

It isn't testing anything and just expanding the runtime of testing.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af68f11664f..3d96182a7b9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -155,6 +155,12 @@ VPATH+=$(PLUGIN_LIB)
 # For example, libpatch.so only needs to run against the arch-specific patch
 # target test, so we explicitly run it in the arch-specific Makefile.
 DISABLE_PLUGINS=libpatch.so
+
+# Likewise don't bother with the syscall plugin for softmmu
+ifneq ($(filter %-softmmu, $(TARGET)),)
+DISABLE_PLUGINS += libsyscall.so
+endif
+
 PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
-- 
2.47.2


