Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B103E6FE3D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdN9-0002Fy-Nv; Fri, 06 Sep 2024 14:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMp-0001id-2o
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMm-000563-S2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so1429262f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725646046; x=1726250846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLZYP9oZiGwTAwn0IB4n2i9sG23m9F19T+BjlVlZE4E=;
 b=wet083Pls+8muELKY+MIOyL6uy73mETXvfXhwOJcY9tZ81T0nRpFRf1WbxLdaHCyKI
 LQH0JwNrYBaicEMR5NfaYT0r33boKcKlJO+rIi2uOh1DB/AkOaqIq+R5K30iRgX+RHG2
 HcgtROxEsS2X4dscarBgzLl0wk4gDxfnHDpJPqUdmuej+u3Ftadf866X4QXuv7f+rTZ4
 whd5zbPES0T3MN8DnY+Fy61XivdCY22S7ZqREgw41B60eGUAgPX60aNiaCSdE3cgR02A
 CZKH4zWyDrdieyr1sNlCAgtYqluOzEtqnDBsEUrVJ4ka5GjWWcjhiomQwsLpoOAyhAHA
 VXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725646046; x=1726250846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLZYP9oZiGwTAwn0IB4n2i9sG23m9F19T+BjlVlZE4E=;
 b=bp8edsoUO83Q4/36SCHBUIvqu8flfZyjOGJAQcZasojW7JJhFmiTU+YGEY44Vk5BfI
 Dmay/0DD900zPo23zzxsAuV3qNCmVusNZzJ0dUvEmDA27AhPSxkHzS6W3MfVlVZQbWYB
 J9QXtdNTkgGWCDD5CTKYP8I3RxfPwXDmNdfTcHb6ZAvpkrmMO7gI6ad0jAGPM84W/W8v
 LUUMt6ZFVl8bC0Kqa5T6Azb/eaOdQtAZq6hrk5ZWb3hpFNHGGPHeaB8pWp8PVx+bolO0
 vLFx6f7vFDzzafDJxDe5iR2lILaaV5Lr1o9AnIOQwOa0v2I0d6uELoh0hBnT3NW3QJqI
 Gb/Q==
X-Gm-Message-State: AOJu0YyhyPm33BuSDtSz5wUWi6rFiEF5z926oFqbgIePOK7TNF7U838x
 yvcH7QyhumhxFCF4S5RLuOb/uKnsTfCOLD5lJzBlNnmPGsq2ZNtTMh4J/SC4W+JgWqNlHBTqpVa
 k
X-Google-Smtp-Source: AGHT+IHKxxfmuyRYrzAbbqwdvP8qJJywc8TRmzIDsG5zXC4SlzSiHCC3r10Eet92VRHABwOeR8jFZw==
X-Received: by 2002:a5d:670a:0:b0:374:c61a:69b8 with SMTP id
 ffacd0b85a97d-378895c9439mr2267106f8f.15.1725646046005; 
 Fri, 06 Sep 2024 11:07:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37891657a2csm441860f8f.95.2024.09.06.11.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:07:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] scripts/mtest2make: Honour MESON_TESTTHREADS if it is set
Date: Fri,  6 Sep 2024 19:07:22 +0100
Message-Id: <20240906180723.503855-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906180723.503855-1-peter.maydell@linaro.org>
References: <20240906180723.503855-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'meson test' has two ways to set how many tests to run in parallel:
 * the command line --num-processes option
 * the environment variable MESON_TESTTHREADS
If both are given, then it prefers the command line option over
the environment variable.

This is an unfortunate order of precedence, because it's frequently
handy to be able to override the default by setting an environment
variable at the top level of a build or CI invocation.  Fortunately,
we can flip the order for our purposes, because we always invoke
'meson test' indirectly.

We currently invoke 'meson test' passing it a --num-processes
argument based on whatever the '-j' option to make was.  Adjust the
logic in mtest2make so that if MESON_TESTTHREADS is set then we
honour that, and don't override it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/mtest2make.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index eb01a05ddbd..6de0044134c 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -32,7 +32,11 @@ def names(self, base):
 ifneq ($(SPEED), quick)
 .mtestargs += --setup $(SPEED)
 endif
+# If the user set MESON_TESTTHREADS then don't override that preference by
+# passing --num-processes to 'meson test'
+ifeq ($(MESON_TESTTHREADS),)
 .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
+endif
 
 .check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs)
 .bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose''')
-- 
2.34.1


