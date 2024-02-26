Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0379C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeIJ-00064e-Te; Mon, 26 Feb 2024 11:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHu-0005br-Ss
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:11 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHb-0007bs-Mm
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:05 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512e39226efso4491063e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966610; x=1709571410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AL8+zOsLCpeNoayTmXUJHUL825fMKeEAoMnkSikBrE=;
 b=W7+H/XPLXQlWOdkGvv/d+TSfyJuT4rNb9gtl7pNjaA03KnfGUauzCzShlLKtmRYwBe
 1FsoRllr5WK0vDsUroxBJrrQUahxgeY5iSKyVJK9AoP42ecxYDTdIaEMIiJijv0KdjDs
 7KPHXC/2l9xL2sWLROoSibZaS0embiA4vU/gsaZSVUVhwA4kkMX59Y0wjCL8R9XJ/WG/
 /4ZCHtDR0dY/3/4Ojm43zKZc27A4BVNPug2iyQru9jd0hdqkwcSXewPuyNY6gAtgn72Z
 8KPn3SAj6hJjoXC2prE2HQZWa4OmA7/eHAX77VTPisbZ2Kng3xoUkSlRqkc573iMOS/B
 k6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966610; x=1709571410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AL8+zOsLCpeNoayTmXUJHUL825fMKeEAoMnkSikBrE=;
 b=i/fjPTS22HRcg/AawgVH/MbXTgTvrU/pjGw2WNIBN1kK1trnFf3hR5/6pc57nrPCSt
 1EpIHHd1puFtkBloY3dDOrrmU2agI92PkNgnBF5hR6X1YM1Rc9MPTAJ4+mCWkEs9t7uB
 WSTnP9uwxb8Fm7olQPysE387fGQ9C0B7X4Yi2xroTe33ewzMc52GULPFLZr2hI/QB0Bn
 fOtxUynHL6ac3DDbVErVZD9xvKXCulUhA3vd9rK7JS9uF0vr/qtQ+qyIQU2puFSgBfAv
 5IIAdg6+9GyEfFRpPSB9xVO3HhD0GtgQ3st+8mq6g7NpWVVDzP+JKcOn4RSrWKytHdxO
 eHHg==
X-Gm-Message-State: AOJu0Yy3NsQ2rCwuFik6d60715x2KgwsHdpilTMmbyL0DGar/nsVTmJx
 D2EFgjWknpS2l9VpHkm9GG96bVqkJmUrv7sQ29RwcP7d6FyQkkSvFvf3ywBxsYU=
X-Google-Smtp-Source: AGHT+IFykQNOfrweVnl2YPAOSLpNNQkfWgFq1ISOM6wuDUgGzdtUCJwp/jvhhBHssTrSkvJpnVSdcw==
X-Received: by 2002:a05:6512:110c:b0:512:f5b8:8912 with SMTP id
 l12-20020a056512110c00b00512f5b88912mr4294057lfg.16.1708966609856; 
 Mon, 26 Feb 2024 08:56:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hg26-20020a05600c539a00b0041297d7e181sm8898584wmb.6.2024.02.26.08.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAA115F900;
 Mon, 26 Feb 2024 16:56:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 02/27] tests/tcg: bump TCG test timeout to 120s
Date: Mon, 26 Feb 2024 16:56:21 +0000
Message-Id: <20240226165646.425600-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226165646.425600-1-alex.bennee@linaro.org>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

This is less than ideal but easier than making sure we get all the
iterations of the memory test. Update the comment accordingly.

Message-Id: <20240223162202.1936541-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/Makefile.target | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8cf65f68dd8..a4c25908fb7 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -93,12 +93,9 @@ QEMU_OPTS=
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
-# ??? Makefile no longer has any indication that TCI is enabled,
-# but for the record:
-#   15s    original default
-#   60s    with --enable-debug
-#   90s    with --enable-tcg-interpreter
-TIMEOUT=90
+# so we have to set our timeout for that. The current worst case
+# offender is the system memory test running under TCI.
+TIMEOUT=120
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 # The order we include is important. We include multiarch first and
-- 
2.39.2


