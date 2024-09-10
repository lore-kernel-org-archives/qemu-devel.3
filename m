Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CE4EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X4-00080O-Mg; Tue, 10 Sep 2024 10:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X2-0007sc-PN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X0-0006XO-Ti
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:48 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso6333829a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977265; x=1726582065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULpurcGomJFFFXGFveTbWvPTjZlX1tphSs0Gpvsy70s=;
 b=SRCXR3IHhnl+JZXbMBu9HjrxeOHFy2c6aenKD6QcZQX7gPeXouj5mXGVfFKg2FAvGS
 ptXT5+Rjy825IlO+5ewHUL0cesCe4CACCbvhA6jR6sfVza16n0MD8C6INmH8AjrwUT3+
 nTyz15y29PKJZb7NlLL9MgRfREui+WI7ylv/PbA5B2b3gItblzM9KPMG633UQl0HvO4A
 or1pDSCMHO7pen5lfdIe7WEwsBVJXvh0wgSD9sEnAm+mJrCoxAlQfb7qrq8Ym2cxDbMy
 XoXLW6+/N6Wh6Bw0Tk2z8EbGqeMulFXvfBbl6Lzs1ozdEwUYxsQrzGAzRNXmoQEdAtFJ
 8M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977265; x=1726582065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULpurcGomJFFFXGFveTbWvPTjZlX1tphSs0Gpvsy70s=;
 b=XsBpoKrsA4r4UpaVtCiJR3LzVZ8Pu3zNfNLY43+V7SwXvUXbDqWXjqp6oy0H7IouU5
 n4q9YnEdqN78+7J6w3ty7BXMJxoeFBqW7MXlnHI7A7Tzhg6GyC4aueWbpyaWpMEV525J
 A1GpzK+MOrcOebB1j6Vy3vpxnA86ahiuIlKcziQarumZ5ScHu8UzVn5FKCisVSKwctzM
 TpG7MymXttIr52c7MyMOMXEFPgKCeOJt0U2PV4o+gegSop3o7M4OQhErf3ih4a0ONZ5+
 v4r27I7A+Sy5ozw0kx4nVEEsYW4Ow0ek0Z0eekuH/BRYELQ0Pm8SrtjzlwI53NnhdlqF
 +Nrg==
X-Gm-Message-State: AOJu0Yy5fl4tbXZXco6bO61/RDWaS1PCgglFegjGRkrEz/Czc7UXMhp4
 XCRRO9tqCxPensHQhIFkuR2K+GvnnSX2a1PddViURvkrs/S4B5Bbsc1VnmKaXsc=
X-Google-Smtp-Source: AGHT+IHYehEW5p/CsUsTqjaRfEvlPOLq1Z68qD+WjKXPatoYneJwmFjyKUkL3uODjj0Bn52xNprQDQ==
X-Received: by 2002:a05:6402:40c7:b0:5c3:da92:495d with SMTP id
 4fb4d7f45d1cf-5c3dc78008cmr8846555a12.3.1725977265063; 
 Tue, 10 Sep 2024 07:07:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd466dcsm4317560a12.24.2024.09.10.07.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49394633F8;
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
Subject: [PATCH 16/26] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Tue, 10 Sep 2024 15:07:23 +0100
Message-Id: <20240910140733.4007719-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240724194708.1843704-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 452a2cde65..c5b1c7a786 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


