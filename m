Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reygd-0005RU-4c; Tue, 27 Feb 2024 09:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygY-0005PT-Tk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:58 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygF-0001xb-Jv
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:58 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-512ab55fde6so5685554e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045017; x=1709649817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AL8+zOsLCpeNoayTmXUJHUL825fMKeEAoMnkSikBrE=;
 b=zrs+lQTveRicLO/PHwGjuJ9b4oOFwlMBLaJe2IzrEe9w2S2Jj0ZXMJql3UwGFJ4b0B
 MKBaD3dmVyCLUElwbpeKqS2bdZAf9O9YE93vLwCtOJn2D/G9LEcvmceuF7bJhxFV5F1M
 vpzgo9PgRaFxoRNlKGi98beoR/RzQI7bXFv4d3GoKDiRz7+eYd7ZXNsx6nUmc57+xPyK
 25SZjX1q0LqchSbks6Frl/zDDP/HVLnn9ZhG4NW+izJf9FeVXP3lbJ2+gB6//iEwUjnN
 Yem1fRDhNcU1rRBqhnxdisRDGxiCllcoqR+gU/4I2eyuZOAmbdWK8gd67zCurngXB7HL
 aksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045017; x=1709649817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AL8+zOsLCpeNoayTmXUJHUL825fMKeEAoMnkSikBrE=;
 b=fytoJAi0PLo69vI50/wIjRrNz1HfdOeKPO8jOFBWCrfZXuh70d4+UnMc3okCKlGtwN
 4yDDJKT86S7AdK2YC9yPmzcID3j5Fn2HTCtS2VJ5fY1HjtP1VXFiW61gtCizfln85WEE
 ++W98wkJM2AsoEiTbaZp10Is8MFoJ2VONtdjkXveX+7afzS0Ae50TsWbzExmrfuQljpw
 9dIK+zSxyMVRXODa+K9fjBDOZTcz7rl67rs0LTE+oCJIeZFRAFEGYBkYx1iUsTMmPe97
 FfYWoO3O/Y2WfU7IL8D/ziG7ISdYedESmvTdthan6SAfCtf1UfGgxUaHgggKhrBK9R7x
 4n7g==
X-Gm-Message-State: AOJu0YwPEse6uWGILC8PtB/sojFlDVVHoCjTDG8UH6yy5fYFdsqxpet/
 avUuev67gpO3ZPlwawQ26VodLYn4LVjDy14QgAOJ9foJvX9qaWUQD0BeeEjR5CA=
X-Google-Smtp-Source: AGHT+IF7+UTFJoEc0G4DDoYiqAaS+sAzWfXkGkrxGq3YDrPP/2VvSz0vVcjGUlJzkkSGrEj4kruWCw==
X-Received: by 2002:a05:6512:ea5:b0:512:fc6a:2d10 with SMTP id
 bi37-20020a0565120ea500b00512fc6a2d10mr5074942lfb.40.1709045016834; 
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a2-20020a5d5702000000b0033ce5b3390esm11537174wrv.38.2024.02.27.06.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CA7F5F8F7;
 Tue, 27 Feb 2024 14:43:35 +0000 (GMT)
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
Subject: [PATCH v4 02/29] tests/tcg: bump TCG test timeout to 120s
Date: Tue, 27 Feb 2024 14:43:08 +0000
Message-Id: <20240227144335.1196131-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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


