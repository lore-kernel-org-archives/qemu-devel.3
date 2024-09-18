Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFB8CDD55D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tS-0004xG-JM; Wed, 18 Sep 2024 17:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tP-0004pT-UY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tO-0001bD-Bw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so178895a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693637; x=1727298437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rI5TLawxN3XyN9WoPBlVoz7ngejExnr3r/CzR6HnTEw=;
 b=ePkdgPe0gcPr6nOaB5z1PtrkqCfoNwc7jf83SPU6KK53OqYrwfOaT07xZYoTGmnxWi
 8Tj0Pb3vM4buIIeITZjoccZFqDC6DcMO2+WY5nLkmQrDoXiW5Ngxd6tc3Rx6UawO+P0p
 wQUweYqX1acOqw1GL6afMk2uC1YcGdwQcxKBxEO7S41WSML3rJfQFe8KUz/18w1wmxF5
 wdjLcoy24SrA0Q8lBeiWZdRrKTw/qWtmNS9mzmyXoAql55t/5OzkqIKiiJ69eyLAvPrI
 u5aGQu9oElwD05IpNeOKmzHRVVanlfGhKn/eP8n6+heehu6D8yKM2OozZ6Gu2IlWcHKL
 ZhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693637; x=1727298437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rI5TLawxN3XyN9WoPBlVoz7ngejExnr3r/CzR6HnTEw=;
 b=ANDn7d6xLcK5UJ4KVPKXgOc6w36C9ei5gihgAAxUdKA5WvE+8wYSNdFoce9xD927gF
 EKx2f9Mdnc0dsnUS55nr3v0GOXKjY3UwyCTLN9tEHs2LjdAwo028MDDnEAoU18eb6cJ9
 yE1Va5CDeJusuUVxjb0bPPLl19g+exkyLZlMheUrIaRvdjQixrlRPkxXfczeSKvM2yUB
 eUiMydje/ZdDcJt8JDSCVlcZwqBOX9jSStXKLFWP6EOw3lS91ogQEjRKR/PELDCWwGkM
 KvxWnqEBdgsQf16BYxbSYoRxJisb+nD8Krbc7t2SD7v772Ya3KMx755b4V0K0PBLCUbm
 oAnA==
X-Gm-Message-State: AOJu0Yw2Mmm8fDCtE+WEx6jK7o2+1daM5OltN78adx5Xiq0UHbnZwRIr
 QYmbKwLNOzsASZDDPYA5YPi6L/d89jRAM3Y+9WCjgc8oLeAyoo/lG92U5L2iy4s=
X-Google-Smtp-Source: AGHT+IFrzLV+tyZj9XLtohYflGz6GBsLa8ldZJM6I5s9hcmwOt0nDLT4iupCkVIq+IktCRB//9cQxQ==
X-Received: by 2002:a05:6402:518a:b0:5c3:cd88:a0a with SMTP id
 4fb4d7f45d1cf-5c41e19063bmr17990636a12.18.1726693636778; 
 Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb56b8bsm5388386a12.38.2024.09.18.14.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E97E75F915;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/18] tests/tcg: allow to check output of plugins
Date: Wed, 18 Sep 2024 22:07:01 +0100
Message-Id: <20240918210712.2336854-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
Message-Id: <20240916085400.1046925-8-alex.bennee@linaro.org>

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
2.39.5


