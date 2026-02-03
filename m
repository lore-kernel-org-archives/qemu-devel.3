Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729FE7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnEx1-0007tm-MV; Tue, 03 Feb 2026 06:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEwy-0007sa-6s
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:08 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEwv-00057d-Fv
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:07 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b884a84e655so808427966b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119524; x=1770724324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCrALKTLyk0E2VKZgTKk8x0b5abHTmgDgtK5TpMbn+A=;
 b=dgnXZb+DRHkH1ZMcFGTQefoN1EA5lXNKqDiJDVppalkylFRS5GdfZFP2vJbts/b/kr
 TA7uiJAI//WkPklCgHbWy2ijdQES9MQ2tfc40fPBvUe8H0vdasOb8LjBoCZOGojQ+dVh
 ZBGwbRNyIqF//+qcx2G9K95Xes5rxA+SRhLPigEIc7bK2Ub4vvGzd7QsRFxgQ7+Lfwoo
 t9+A1I9xoYLoGdkflApm6S5Xo9ZubGNYPsovs6q4uKWW+pE1CfdN5/PJ64C3TQvsWOaU
 DeG3V1tOkYaie1PxnNc42ybXCmDXkeS+7H0QmOuPATForPCOHZAsSjFla6zfMzr/eweD
 pxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119524; x=1770724324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCrALKTLyk0E2VKZgTKk8x0b5abHTmgDgtK5TpMbn+A=;
 b=cGO5NARrLMfhc339HV0Z+mNGDkFkShy0RPZGTzwqPOmlvRRNLEza3I5nWDpeWZh3sh
 hRm/aubgtHKHyJVi8QVfn4fEC54is1VhmzUDrg/6GbsgeYuA452/HqwPOCBSj2NfS35F
 1lzVX5a95KdRD3/ew59205jN3Yjz4yDGktBseJPMr9bQRSZK3wf46NYRoGilydJvQWXV
 GnrqzCRT01LOKidTGbau+HxM6q2O6pVmW0wOidzUA57k3cq8rRgn94vExuUU9QwC8+je
 PxuhRBxA+be96UDXPxDoztGC88lOHzJE7TcgwJUtDoeW5YK5LhVB1qs/Fif7cs65FneZ
 041w==
X-Gm-Message-State: AOJu0Yxf0+FxHdrqDPxaAZ8hmiNErY/5cgZd/f86TTqzlfFEmtCqmVne
 1aJkjYsWimxFeCBVzkQkMXKqtO5Fb3P4qJOgcjAakLSj08Lhq7PDtN73+yV36YrmBcw=
X-Gm-Gg: AZuq6aKALPb3bCroG9p2cT3MOXfIC4ei93l2im9d5Yw2hkLQ+LvD1K7ZBmA6TqcL9JO
 +FwRDRMhXrTgS5W4Xm8CpPbKg2SvQlp0qsNHVjK+nfXd2oaBuwoYXe2/PwN1LMWU1oLz1ZotRzK
 RRDpA84Fhc5GOuJCKiuJE6FEsUiSCnZ/l5dl6qZwjXv8ToZ84gxr/1WCEj52HHf9Zr+Cbwkktu3
 1ftCpvR5sGe54sI4tq6pJE8BXbyF9ssXteRKhe672UlKZQAwbZJGcUdf64AwtMMbYKdisuGKxfI
 spynIwaKNv0X1Dvaq9YNMBcB/hr6+uv6cwb0KshMflwcvLe5UbxBKCAPehwmza8WqLJyFatGHRA
 QBCwBgg1IIHcslW4yi5hL35uv2BFNn8fYUap/VJ1KiHX4NiWFZw/0q+L6MBGzonTZIYz5DH1VWO
 aW0yQlWW5n6bg=
X-Received: by 2002:a17:906:c153:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b8dff5d95e5mr835340666b.22.1770119523543; 
 Tue, 03 Feb 2026 03:52:03 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8df8465cb5sm757815866b.40.2026.02.03.03.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C4365F874;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 02/11] Makefile: add python script dependency for
 meson-buildoptions.sh
Date: Tue,  3 Feb 2026 11:51:52 +0000
Message-ID: <20260203115201.2387721-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If we update the script we should also make sure we regenerate the
help text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9fb55dcf330..54547a37b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -130,7 +130,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
 
 .PHONY: update-buildoptions
 all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
-$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
+$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt $(SRC_PATH)/scripts/meson-buildoptions.py
 	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
 	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
 endif
-- 
2.47.3


