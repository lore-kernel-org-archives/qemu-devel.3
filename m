Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5156C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWuk-0002xb-LL; Thu, 04 Jul 2024 20:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWui-0002wV-Ri
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:35:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuh-00007d-2L
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:35:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fa9f540f45so6587755ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139697; x=1720744497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70GLN4QAz+IlBAZY2/ey3oOeez9V0zHIxcaWOnyG2XY=;
 b=a+q2x4dh+tqv3133dcytreSIGU68KPXT7vCZb/01ciZD89QiGofpI2eFNr27uwaJij
 d0Yi89KV9VBLoo4fhuiLlomZLBlT2CQvHLAxp1KBiJS72+fhy7a2fFKz/tgi2c5G2agN
 5MPuLUWmOUL8f/cmKGMNbcgs8iuxbfZf0TynLSNpmUUMXglQl9f/XFOm9qbUTE1fup8G
 9ecb3vr17YUk6kvvr8yWx6VSGwfPTKgZh/C6qj0ga+whFIwuRrn2CnPcV4+s96/23ftH
 YfJaQ+INv8R+zxuOjHh/CZJmRTV5GLfMbgF0YmUUhYF0T1Fp43Exsr3/H7mQ615U43Cy
 MtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139697; x=1720744497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70GLN4QAz+IlBAZY2/ey3oOeez9V0zHIxcaWOnyG2XY=;
 b=J3+EoiavSWcwxh7Ohh8pqyWOAEnBVNjQ2qrYK4hI5dDmuF3r0d/lGlF4k9aqguNHo8
 8dtxpPPK32JiYdpgSbMqcGy+rXgxuO5jqlF0T0eBskm0ij6OY+hxBxggglpbx1J9/2tb
 CoS2OmlbFEg+gB47gX/B6knCa2YipXly0JjsYrKUvT+Bx38qGVkvPrbUzm0YBeW83/XY
 Op3rzogpMrM0/h6rIgI3+cSexzvyPYI3xCHcUxzRFTqRVrqmcsT3Td854l9jSXKASJyL
 /Y/8kbSQXZZC7e0sgCqbHhCsl2G1pKgWA2G0AnD8M4LnL/YxLOLByZornMWVBu/nV1Tm
 jcCA==
X-Gm-Message-State: AOJu0YwQuU4vh26bJ8lsoTfzc1exwyzpJ59xsAlq6Z1bPk13gxyHSxFb
 PRzNg6+jdPX+14vxGRxKXvhA3htEOTr/fRMOz+vlKVUdkleIuGyJLKtfjzZq0ZdpHhqgUPE0PBv
 AYLA=
X-Google-Smtp-Source: AGHT+IEKGOHdC+W/Y5R9gl5URhf0fcT+deM3/gSdq/RFtCJONzUy64cswhD3BOifZD41RyNd3OHfEg==
X-Received: by 2002:a17:902:d4c9:b0:1fb:3e9f:ff6f with SMTP id
 d9443c01a7336-1fb3ea002e6mr19037185ad.40.1720139696768; 
 Thu, 04 Jul 2024 17:34:56 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm39008595ad.15.2024.07.04.17.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:34:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v5 5/7] tests/tcg: allow to check output of plugins
Date: Thu,  4 Jul 2024 17:34:19 -0700
Message-Id: <20240705003421.750895-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

A specific plugin test can now read and check a plugin output, to ensure
it contains expected values.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index dc5c8b7a3b4..b78fd99c337 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=true
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,9 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+	       TEST, check plugin $(call extract-plugin,$@) output \
+	       with $(call strip-plugin,$<))
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +198,9 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+	       TEST, check plugin $(call extract-plugin,$@) output \
+	       with $(call strip-plugin,$<))
 endif
 
 gdb-%: %
-- 
2.39.2


