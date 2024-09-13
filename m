Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E07FC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4s-00073u-AJ; Fri, 13 Sep 2024 13:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4g-0006CZ-BK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:14 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4Y-0005ud-UY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:12 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f75c205e4aso28588761fa.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248424; x=1726853224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULpurcGomJFFFXGFveTbWvPTjZlX1tphSs0Gpvsy70s=;
 b=TjyONR+5oJ4CLd0adPktjCagrT3leHJfAEvubcExyQij7XKGks2SVaZbP3yDwrWhmd
 kga+5q5QfWZDiY4x0VuH9Ir6A+VJxaSfDBbYabz9Ag3oT39mLhj02llO8JEH3d2m6tIL
 wO+cL2iZRUmRDsicfH+ygWJfUHfuy8XI4WisS76zUbouQhJTo/o66nqGA6JqQE4PCrpM
 fjAKEFaErqZnVJ24qbV9UU8JQs/JWegoxa6YyBFHHvafwkOg16z6gUUOa/3RmfnQjrAZ
 YyL44yAuEOzHgYNNQrqHTk5pXa9V/ie5ZRz2LVH+5KhqeRce5KWhXXDJORlHxnsDMFx8
 TLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248424; x=1726853224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULpurcGomJFFFXGFveTbWvPTjZlX1tphSs0Gpvsy70s=;
 b=bH9Q+06+QLVKwVecQhuHey0ALC5EL7NITIircctxxS09pd96VzzXMUMBUvKWSmqinF
 qoTG0Drkc9Zp+JCm0V2kPh5tZxyHyItdQKeY1qGLUj1mq7nR2DPE97dNKkxQNjR3+mmQ
 sPph6N0JEQC82sA9A8yWNmyQyGZpqMRI1MayALOH05TD+3tajxJA8A+WVSzLCcJVZlf7
 HwovJ86fC7rBX03n1p4dzyEIqHD6fbuQh2oJiSzRklgNxRagMI7RJCPJSG2RSKuvCO8H
 xCZY6OnlHM9fnUEI4BtGjhCdO7Xp9+pPOMeNmEiPmBb7XMMM8T5MH6V75mOLHP0tQNCM
 KDmg==
X-Gm-Message-State: AOJu0YxhEavniM2+98rwlGqLtZlr0/cMVuKvArNfg1CQ66S7T/oZUXHx
 jExMYX+zb2ptIldAVUDFwdSwktvbRXtlgPUDWmkIRvnjktSxBK/HawiEp9V92lo=
X-Google-Smtp-Source: AGHT+IHUgGNMl4gArOg9bhBAPN/+RFKvWFvEmqsFPVMiNlb0mEFIYXTuaQ7uc//c+IwCnVXmEGv/Gg==
X-Received: by 2002:a2e:a595:0:b0:2f3:fd6a:d170 with SMTP id
 38308e7fff4ca-2f787f2e59cmr39386161fa.36.1726248424070; 
 Fri, 13 Sep 2024 10:27:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cc1sm7879905a12.1.2024.09.13.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1D4E5F9FB;
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
Subject: [PATCH 06/17] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Fri, 13 Sep 2024 18:26:44 +0100
Message-Id: <20240913172655.173873-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


