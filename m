Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB78EC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwoe-0001SY-9t; Sun, 27 Jul 2025 04:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoa-0001Ij-Hg
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:04 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoY-0000BJ-T5
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-615398dc162so140665a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605181; x=1754209981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoLK9AJv4pJieo+fXA2Uyn932HEwol/SYLf8iQNNeQM=;
 b=mQSHXgoNiHhjBOkn/qC8Pgj0idqdIJ2sq/ve4P8nrMSr1orvzBRptlse29INe8g+1m
 quwsfsRkoSb6zEXiL//lilRbCgzQESZP1EPVNvmvRRvTQqvb0mjNkPEvM75cfJgQTeEX
 Mx0eSW9sv6+MuQp7aw5DPlp9QGbpK+TDlR7uWfTWsAX0vbXEpczjKymxsEW9JHiho+V+
 rMy+8o79XWaRG/tEZkQgkvfRQLFdNbjIP7xE8qG0o0gniqcDfgaJQrtYuMpJWCbJ9Ahb
 c+51kqqRvsRbC56ohLmXQxGujyIptaUqa5RGZQr3kVDKeUEvBTMkec4DxsRuYhBOyygX
 MMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605181; x=1754209981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoLK9AJv4pJieo+fXA2Uyn932HEwol/SYLf8iQNNeQM=;
 b=TBja2dWgTSmS3yF12MVRh0bHbfLkw/JMCdDrLpSe3+9oTMwZoZ7e7LAzvny63xupr8
 GdTA1ZtZxsdzz9m/Qfv4yxwoEpz9TnXDF67iSwnowjPfLdNGC2owtX+IhWr7suNhc6ws
 DauSWMt5eks4uM4FCaae82VCcQPkKQ0UuVBc8daEhsA7bxcpbB+3/gu6hHbvhsaM18p9
 GZq0QIGxxdZ6YRBTJlUGMofV8TqPMejV2Up+6rPiXGi/T//bqyO/tW+UBBW9IqkWBHFp
 vwY6/BwWTJjphf/WICYAtHG2l1NuSss7MkzC5WhdeLPC+UgA0xgFY+Kt26R6KHErMLa9
 UqZg==
X-Gm-Message-State: AOJu0Yz1lSTJZ/u2E7bWUhmQP31h5eSokZW4zTDHM1FQe/5AtRDV8ZRD
 tNk3t3FdmPK0GkKawKiz/Z9R+FHWjILXcmyzXId9LTByS7s2ijZusepcd2KbjrtymKk=
X-Gm-Gg: ASbGncvYd+VfNkHTGSgfC3uN4GBX/tam1tKD5aNVp/KrjL3cPbuUX1l3Gnzl9GfnozH
 HdzPu9+3IC8iURC09UpsbEXfRh+qGeiAOjqhGLl5sBiAbr4vZTlC89JimZP+nF2zhczjafK2CW1
 0Gft4S6eYGEhN8eZktLzQ8vpHP6lDF/+4aQjG30v0KTZKhrFmdvOs9MoSI2yXJCgbbLDz6/xh3g
 zaBBv9lczz1x0OlTpbU9FijdpeAHmk0WCoAn+19NkSOkddI+dnf+huaFAckSZ31WdqwXvRGX/FG
 vbN+UjbYny3LzyWfyeLfwcfMPd2ojXyEySkFyyFHdyrTAYY95ew+wYb4mgaSTMrSKb+LKPEeJaS
 112AnEjAbAnrD5DPwpW9Isrw=
X-Google-Smtp-Source: AGHT+IHZLo34YarrSG9T7mk1gGQgWxCO27tJZqvQH87q0kYKSmeKXxLVjireKlcHl5lM/fVjTNvfqg==
X-Received: by 2002:a50:8e13:0:b0:612:3d0c:a728 with SMTP id
 4fb4d7f45d1cf-614f1d6a985mr5539460a12.12.1753605181114; 
 Sun, 27 Jul 2025 01:33:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500aef3bdsm1925090a12.68.2025.07.27.01.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBA165F8E1;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
Date: Sun, 27 Jul 2025 09:32:47 +0100
Message-ID: <20250727083254.3826585-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

We never actually used this is the end. Remove it to enable
re-factoring.

Fixes: 7cefff22d54 (tests/tcg: add mechanism to run specific tests with plugins)
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-9-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3d96182a7b9..97ebe8f9bc9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -169,11 +169,10 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
-# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.47.2


