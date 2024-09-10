Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C6EECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1XA-0008Ri-BE; Tue, 10 Sep 2024 10:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X6-00088h-I5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:52 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X4-0006ZB-1Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:52 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso88146066b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977268; x=1726582068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLtSiC/Qmy/Q/dtQX8Zk8sWvmopgnkSy4LkF7QeFpv4=;
 b=Eo+YfplgzxTRJ6aaBfMkkRCHAW12mQEt5OuqKJoLpuxCBPqsyq7RaJSfVFg0oYbcei
 ZywLHNjIlbA8XtLrr1hj5l+1CSvvEqzS1muUO8kYHfIMTx4HdaIdOL6dIKfdAIYzNngh
 FwWzCZfphI4bTKGkksg0F+Szz89m/0+mn3ggYp83wa/zoCngdlxhruglKdiv/QrmO95P
 wfwm4H/hGXMLeZ762NAD5ot7rB5L38dyg+qd7cOUVapF3k9fyMu3vo3+J37lPB5hrRiB
 ahNAtGCRYClAl1If+rTM6Dj9lz1JxtA4Ld9eZIwTzezmsuKZ/8Zvmr6KctEG+ZbRJira
 hnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977268; x=1726582068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLtSiC/Qmy/Q/dtQX8Zk8sWvmopgnkSy4LkF7QeFpv4=;
 b=N/DvBj9/zQidrHDf4XfhE37dU7auT0v8CZxZ1zGWQjv8ejmey1sTL3QIEyIFo1VJVm
 aPUVKkhF4ZqJX8vDPL+WAfiAsO/Dr6AG6vmIiV/p7w7QcILpSo7OjwblyiSS+joRfXIj
 Yp8+v038TGOgbb2/+UEJdihLDqzVLtEEAAxgwRPM/ZhdUkKMSHTpTNdAw7LOD6VqxjKt
 DmdotY2r7lqUo0orWEKb3zO6OYEacVYjenQGL+weC2pUXLiI4oarnAORqO8Mw/Exlkyf
 1E2ZgrX79QvHZgljOaRwcWcceGJM0kBQM/A0OPd0pgcrFRWTRWB1JhjSiCJRreESNpEB
 GW8w==
X-Gm-Message-State: AOJu0YxghCHC3k5UgLuFR4cUd8rd9HfQmNXrqeLfkc3Vr5k7d2zhGpNH
 +BphG7CDLtwV8jwsdjQyKn6SCt6xfamyer6LDHAo5SJCKqydRsAHVumsfOQigMk=
X-Google-Smtp-Source: AGHT+IEKAlTEXorwouZ2aDQpJWExbQ52iHDvEN1lztyi1+OuHEASvG3yXZUfcRMRclhGDZYJPhZswA==
X-Received: by 2002:a17:907:72d1:b0:a8a:8d81:97b1 with SMTP id
 a640c23a62f3a-a8ffab92bf0mr96711966b.27.1725977268411; 
 Tue, 10 Sep 2024 07:07:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259267a6sm493257866b.51.2024.09.10.07.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F19763404;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 17/26] tests/tcg: allow to check output of plugins
Date: Tue, 10 Sep 2024 15:07:24 +0100
Message-Id: <20240910140733.4007719-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

A specific plugin test can now read and check a plugin output, to ensure
it contains expected values.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240724194708.1843704-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index c5b1c7a786..2da70b2fcf 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,10 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output    \
+		       with $(call strip-plugin,$<)))
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +199,10 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output    \
+		       with $(call strip-plugin,$<)))
 endif
 
 gdb-%: %
-- 
2.39.2


