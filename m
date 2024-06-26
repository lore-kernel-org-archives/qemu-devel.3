Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5959C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbpI-0003Dz-FV; Wed, 26 Jun 2024 19:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbpF-0003Cv-Oa
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMbp4-0000Oo-OJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:13:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f9aeb96b93so50208495ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719443585; x=1720048385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=kPh+jV0/JpWu1FW1OgWeGyym40AzYaFvIk5XBoMXbA2krNquTKEd7Jj5FBNmYVL7+U
 MHN6WzvQp+Qji4liGohqAAnmiI59kQE6paLE68SQv5+/2KNnILz+CWOe+snLQYidYu64
 PrIJnGx78bKx70jsNrDqneuB+ohkAfT64NFcPjBMkVl5RfvFk6sf3VzaijUelMESZvGe
 NIopLTQ2qmGtYlH4Db5Y7m4edSTgdVyn30UQUwA16Ij2Hm6rMwAzrFlUDeMuj95jTlKd
 DKIkO1plTcX2ykk2t54oK4FQmMo22xeqQaNlVh5b/oLibUGOF885Y5spkdzmx2v0kAPy
 /xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719443585; x=1720048385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfJtbR1DHFH39g5O1RoXMV40m1cvFRDojz81uxTKSUM=;
 b=hZ2tozTpPuHf+6YWDvZLTXQUmFKm10BelFVDRH0COnjv0/sANYbVyfeL2REO6r+4mE
 EBhTAFKXaCVKMlhq4/t7Kn7aTq70dUoq1aXlCqHsqhw93rPqd6BmcaVRiDuk5T87FY/z
 xmPrpVOmrwMkVTSar0dWEbDNyCwz/7zIjIFdfRtGq7g9ch//9yN/DrOfBbeamMONzxIr
 waurkBG4LgwQuV5VmklecjV1fDJhmRnh4i0Czo+gk4t6KNhrokxOw0Iiv47cx3hzsq7/
 JB0+2MTIhjV6o/Y6bxHdq5uZ1tw7+UL+9W2XLbgff0vv2fInJrOZ2amVi1Li0eL08ydF
 fTjQ==
X-Gm-Message-State: AOJu0Yw+fIBkqchMX9XTP70VZrefREqUJ3Je0rnySF+dHCz63gCB3qDv
 4Az/l1/QScueL+N8AbeGxi4u6r02hIdhA4pqs9ogxKVWcIc1kHdtKbGEff2xnf0u8dBmB0JX1XH
 4UNI=
X-Google-Smtp-Source: AGHT+IHz7n0rgQ3mTIOlKvDhPA03qfO4XnDmk28WHTm2yljHoInggSnSzVTEKeHq3Exgwfugkzo6bQ==
X-Received: by 2002:a17:902:ecce:b0:1f8:46c9:c96f with SMTP id
 d9443c01a7336-1fa23f01d4amr141234695ad.61.1719443584791; 
 Wed, 26 Jun 2024 16:13:04 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac82cd3bsm478215ad.0.2024.06.26.16.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:13:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Wed, 26 Jun 2024 16:12:52 -0700
Message-Id: <20240626231255.339353-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
References: <20240626231255.339353-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index f21be50d3b2..dc5c8b7a3b4 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


