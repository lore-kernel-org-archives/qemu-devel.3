Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B98C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7Vb-0001vK-2Y; Mon, 16 Sep 2024 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7VC-0000l3-9M
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Un-0005DE-N9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so23822965e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476848; x=1727081648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uke3qYlJar9aO7gasrp34dE9JqnQR3uW9hBIj7y5AhM=;
 b=LFp/X58Lx/azJhRQ0g2eSMNg/OSHJQB1YF8y/sj7EVkaBYTwQyLRbfbSKzwSGzyhF8
 Ae8ws3qWcZPy6JnQwKPZuwcpVqR3yRcVlbj4FKLSZJRhWqP2vtqBrUjesO3XbsPmkQsA
 WJfQcWge6MXxbkEN+mO18E3BKiUPHLu5UuFYjoFE5cJK3kh6hqWukiYGFN9DJ7ZAiuYj
 G0jYvwB8EZu1EzR0JUeqYS4bi8kBItsUO3Ztan6rG+cG2RxnlPoXRESgiQDx3QVd+JfY
 1rg/1vnrRKx27CfAr8xGvsIsmXd6NSn9iRUif3sYeu9jH8ZOe6oloujO3K7KTG/wiFjy
 Od2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476848; x=1727081648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uke3qYlJar9aO7gasrp34dE9JqnQR3uW9hBIj7y5AhM=;
 b=uMZ0cu2/9mxkJCjUt01dFMjJu8L+YZfupW2J0Mgo6E7YkWhlUqc/IsXzYxqVt4/+y4
 XqZu+NmqouoJ2rUiae3E51/A8sdVneDt77EcB9iX6Ms/6G5ueMZ8/uQBXeZ9t63wdzEN
 5p8WCINI+nYPdyZN75Ax6hiKiKFYBmYVPXCD7Pc2P1i9EL9QC+7KYe4YFR7xCL2WLuw1
 rnPGCKiqOs+9RmXkBcMSW2FiSU+aACdDzZpRWrSNf4BnDIHB/phcX3rqucBdj7qV7wtj
 SmnwiyyoBIaA7fNs1jZkr3xc05Gsq6b8Ir49VA8/crO/MBR9pNjdtvIV+nJmz/pQVJVW
 sVJg==
X-Gm-Message-State: AOJu0YzJfJxVheBEdoCCVhETYPsKpmC2qN2pPl1GfK18Yjf4GUAx2MTm
 MxCXpNLZWiuma/P1FsV8cBSdNiGeNYJj5HpvzMdA35IxfUq2Kx2pK/M9Ec0Huo4=
X-Google-Smtp-Source: AGHT+IFYE/yFeRtC22pYFDJROSLLTdHiC6hwxDOcWYvwEDVp50B67sQuzpyj5dqbqORoFiKUKyMlgg==
X-Received: by 2002:adf:b219:0:b0:374:ca4f:bd70 with SMTP id
 ffacd0b85a97d-378d62537c7mr4746205f8f.53.1726476847831; 
 Mon, 16 Sep 2024 01:54:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780028esm6574261f8f.71.2024.09.16.01.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F08B65F947;
 Mon, 16 Sep 2024 09:54:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 07/18] tests/tcg: allow to check output of plugins
Date: Mon, 16 Sep 2024 09:53:49 +0100
Message-Id: <20240916085400.1046925-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.39.5


