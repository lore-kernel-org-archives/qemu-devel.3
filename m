Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFA5C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VT-0001Pq-Vf; Mon, 16 Sep 2024 04:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7V3-0000F3-6c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Un-0005D7-8N
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso41372195e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476847; x=1727081647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUal07zdcm4Ygo3M2xPY0Gx5kjUZNu1C0Q2GU9EplJc=;
 b=MjhT80Z1H1MhvVaVj20l4mE0xDhHvEx23edFmML0ZbxFLMg6TOmN09ph4499PzNkBV
 xb98ViK7d9d1OMadPMwgT/Y0xHX98fyk/KphkLSsztMH0u857sxxg//dqfV0Pkxl1NCE
 LQYR4LxzA/RL/ptwhdxyDpYyJWERR5s8pD/M+VQBMjZHCVBOmXX3UKf3ITcfQPd+BQ1K
 hjqfAq1VT8EDYOl9yKjf9JNp3/t1ODN7P30Gbk64MtH1YEygGrwdFZxqxBhl4Bv77CIu
 +ggzHTmoxArhM+BfbXpwoImnzlB+lGUJcr/H2PnBwy+xjAeZmCvfvrp/96F2bp+F0Evu
 M8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476847; x=1727081647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUal07zdcm4Ygo3M2xPY0Gx5kjUZNu1C0Q2GU9EplJc=;
 b=Ke9R1KWczr/vL+PXlTKOy1nnR1/LbW76az2Rv49MDKbte36XUg0YMZwIWxxOoAF+qX
 SEsO4w9OLQyj8EYazhj+WmPGrSY59Z+DbZU42g7YgtaSRxwo25YcMK9FHP1VaDWn1f1k
 rR16RDUe2CZRNq4IE4BRCpUsjkwao/RxXiRmzYAQItZo9aWjDbylJnyBYXWxTu8jxkhs
 EWRmkQL/o6HmjDNOfJNiluBK05q3Z1lDNiVAyXBSfc4a2gu6LfYB7gLF7GNSpDQ4Dhpe
 p5xzqPyXwoI1uncG5cIvSeDhzRrRim/xbayG9nD6uC0VoU8sdJX5GvJBoy2MZBEUMp7q
 guwg==
X-Gm-Message-State: AOJu0Yy0LdgPR87noPG7TXtW5kAYJPW+N1pdUMjqH1/Zn34IBgwTpKoZ
 yIMiw9oayp9EH+XPH125WFk5ET4fN/G8tYX8mpJ6iRn0hidseQhpluUjy671ceU=
X-Google-Smtp-Source: AGHT+IEo0yZ5diVp0hlLRhsui6fDh8LduTTeLCCSJxPyAIVX85ykZI72X//yqhFfmobilM48ckCa+A==
X-Received: by 2002:a05:6000:1448:b0:378:a935:482 with SMTP id
 ffacd0b85a97d-378c2d621c1mr10585661f8f.58.1726476847478; 
 Mon, 16 Sep 2024 01:54:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b054d7esm104993085e9.1.2024.09.16.01.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA8565F938;
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
Subject: [PATCH v2 06/18] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Mon, 16 Sep 2024 09:53:48 +0100
Message-Id: <20240916085400.1046925-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
2.39.5


