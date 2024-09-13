Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E813BFC616B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4m-0006ZH-Gs; Fri, 13 Sep 2024 13:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4c-0005xs-RI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4X-0005uW-R5
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so2772504a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248424; x=1726853224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLtSiC/Qmy/Q/dtQX8Zk8sWvmopgnkSy4LkF7QeFpv4=;
 b=JITw5UeMtK/350EYxkHcACmVWMq7lyjDsrc1oUZc5L2gRMN1niIVDqMFDYVZ9hN+5S
 0ZWewREjiwIeXw11AskTQyzqUelKEVWF/ZuIdi7amLjaPEIZr5nG4aouebltjHTPXAz/
 3uFTxVsBuAMqKxh12mdv5cgZo38IUwHkXDdiSNH67PiAc6kcPAIH54XHmMVH4THg1sh8
 2HAlAJ5Mi0maR3WD+kT5tFiRZzFy8Dn5EmNh4L282MLN6dLUDdxsGGLyd+XxeWtO8ZBb
 qji5SaYWb3amaiRSSrlWeaZXUzyPIByHkHcAlPuShI9iBr8VDMfgEotc45mGzEfBQUUd
 amkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248424; x=1726853224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLtSiC/Qmy/Q/dtQX8Zk8sWvmopgnkSy4LkF7QeFpv4=;
 b=a/I8sLom+kwZdGE1uLENAhAqDFY/etH7howLdjoA8hyhXyxQPwKsvfJIeJjCAmQIQs
 EGsuzYkVubW4hqa7L6MK+zLQdwWxL/l2JH9SXNLdzkA9K2vpCGqjIumsPbfEHUZY9Gu/
 m4tSe+gKn8zds26KLxgWijk2tfkuk+BAXSs2spyU/Rvj3V017oB7+jexpLfyumpFa2W7
 uEz1dNWUqOUdpTqqjE50+yWTFAYhHle54khJOPq9Kyy8ylzdgu89CL/fEYcUNgX7FoEd
 pzluWZ8O8sUkfzFCR67I88iXa3YvXgT0iOZXC5N7BhX9qoGT/HjG+4rMZvo/MzWQdaXB
 EVoQ==
X-Gm-Message-State: AOJu0YxU36vZETpzkrQe/cx3QRE6Ydx8fuvB6PdJJOeJcQfilqdfTv19
 PmiJevHqAcKDu0m4Odp1vFK3RCxXz3DVxFBzOhpujINPOjD0ODMCpQZue9ima9M=
X-Google-Smtp-Source: AGHT+IFGOu+K1cKBX4F+chTqE7Mrjt0YFX23GT7OgJI2Pj3N373AeGI6ei7xMtZ1+82dfMxsEH8MFA==
X-Received: by 2002:a05:6402:24a5:b0:5c4:b00:5e62 with SMTP id
 4fb4d7f45d1cf-5c413e2a27cmr5376289a12.20.1726248423625; 
 Fri, 13 Sep 2024 10:27:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c401420b55sm4748991a12.38.2024.09.13.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C58AD5FA03;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 07/17] tests/tcg: allow to check output of plugins
Date: Fri, 13 Sep 2024 18:26:45 +0100
Message-Id: <20240913172655.173873-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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


