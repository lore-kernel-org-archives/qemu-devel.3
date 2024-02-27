Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F71EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypW-00040T-If; Tue, 27 Feb 2024 09:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypP-0003QL-Ug
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypE-0004nr-Qw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so7273985e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045573; x=1709650373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=kekDdyQJViVGT60DTUr/E5cnT3ZjN3UAmwMuAd84hClAyg1wLUu9spvHV1ompmRwsC
 oDHXMS7juodoZE2FYB2E67ptvqv+loGZyG+1otO4AC5qSFCK7itXSzasMIdxYDZA9Ind
 Y3FqBOD+tCt6masdAF63sJ1reMluUrkBT80Alt6EkMF51nNParKxqHdjIvJOhctEVDRn
 ZBLAJ0Cp8NsB8e08ILhWnGLfVJd36XF8C1Mzzi5QM74LMXO8dnL32mJKR+AaIlMfE8Go
 pW4fss3pwOxwlaTOUETBoBOF8YWlBccjNgd/rekC06FW+KeniPtIn0JDGri0sq4w50Gx
 yUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045573; x=1709650373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=V75iZfgpm04aMEiG1B0xklRs5OXpY5Dm2LCZBuDQOibdktgIjYCUK88zoniWyvutzi
 ToWH3OWMA8LH93wD333uGik5hIatOXPYPchkJzu4wQrvtvSphITwDSiQE/8gG7OKSz09
 zsZISzJc0A/DH0THMS2u96l7c1xdmmHg7kYwwp02u0LYzQ0SBUxL/HjK8P+Gb1GtUtTy
 M1hTJtMhG+oX7SnhhV/+rMjiNA92T3zoBt251THoduRFXeRJWXFj03z0AKy9pKHX1vCL
 sILrcRZR5wdRDvbhcj3IQ/x1PegYtdI1hWXZcF+GEeSbilxMvlzS4/KF+QwdEf7W0PdO
 sOBg==
X-Gm-Message-State: AOJu0YzdFfDW9tTGlmtc4kwRwXyRdaTATRmmc/Q64nXlLbOMCFIzcrsg
 k4cTagZ8y+Doju4+dw0O1yO4c0UVRaVyM+6iysYewLjHcD5zRXbwtZxpwWkqIE0=
X-Google-Smtp-Source: AGHT+IEMrcrsgzx9LyhtNiRdk9m57oKDvZT3irFofG/fsSiWwA23AS/x3JXsWUqiaHcu52nQ7xf35A==
X-Received: by 2002:adf:ead2:0:b0:33d:1ece:d618 with SMTP id
 o18-20020adfead2000000b0033d1eced618mr9437170wrn.8.1709045573434; 
 Tue, 27 Feb 2024 06:52:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033b48190e5esm11960506wrb.67.2024.02.27.06.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14A105F92E;
 Tue, 27 Feb 2024 14:43:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 27/29] docs/devel: lift example and plugin API sections up
Date: Tue, 27 Feb 2024 14:43:33 +0000
Message-Id: <20240227144335.1196131-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This makes them a bit more visible in the TCG emulation menu rather
than hiding them away bellow the ToC limit.

Message-Id: <20240103173349.398526-43-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-plugins.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index fa7421279f5..535a74684c5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -143,7 +143,7 @@ requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
 Example Plugins
----------------
+===============
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
@@ -591,8 +591,8 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
-API
----
+Plugin API
+==========
 
 The following API is generated from the inline documentation in
 ``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
-- 
2.39.2


