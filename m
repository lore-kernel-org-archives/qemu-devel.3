Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45FDCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy5N-0006h2-Jx; Mon, 20 Oct 2025 18:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5M-0006ga-0T
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy5K-0006Jd-D5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so2745398f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998232; x=1761603032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlOoyEXpkN3tIXY88+1raREhED3aLNcbV+Eg9JKDcmA=;
 b=S6SzRAST23sflyOUV4AYEPy2BB7aiWLgVqn7DHkL/YNK5xTPNZ1tCZMkgn0kfc0bBk
 FUvRUnDhaEuqzYYYxcYXc7ZUGx7LBj6ctBEehzXTlTjIzGotp2U5Z/ysYig5XRbDo4sw
 HkZVP794Uj0sQXA3fS9cOMpQ5KJ6Gx3vF+ak43mJsgCabuErihWmfuX3VjIJYcJjbSoz
 qVeqUOA6Ddn3nNW74oaiREp89emtMG66SsOqZ91jTxM4svj5BO8+c9POe2/rsF84YRpU
 WdHlb0l4XFdx11329dFJh6lsjt3fIqAZqt4jTewUStqosIjGSzFvGKEfk4/FrQePhmkl
 Qo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998232; x=1761603032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlOoyEXpkN3tIXY88+1raREhED3aLNcbV+Eg9JKDcmA=;
 b=vg5xgNDHFhtLPT9kFo4PiZg7nKovoNlaIDJzeeOACn2/h1PjW29llr2TsX9JzvWDPr
 QA5seNKJVZpxfNGpiPfocusE5OAG554zXWf+I6h5mks5fI5ZEacK81qiu8oCGrGQmMyN
 1na7pxe+JTFeYYaC8dsy3cCVbLIECKmVeANJOoDcsf8SujoEd4Iu5AtTYyz1pXl9FyFm
 l+HgbTURojlkJjZ36L30NhXWYCtRRd+6ld0Jt+bG1lOrekoYBPraPgS8viJeiRddHpEs
 xbJDRlNYa0S30Y5+XQHNYG6+ZuXJpv5H53iiFWXXzHUt8/7Rn2vycqNGOgeiJizTmGxc
 WRMQ==
X-Gm-Message-State: AOJu0YwulizXhrOU3BiKSB9B0yp4Um40ImQi52aOKJ+um5tUyTXFOyRW
 ngVk2qwIBBsKWD3UcKqPJJm+93OZzWeTKVP/hhEqJU0fg6kBqHsxA4y2kmNvhZFDFi9yDYmqrA8
 e1XYubZM=
X-Gm-Gg: ASbGnctpu0i4aRlTqz7T76imYwtcfnMnX4ZcfgRH3Vg4tTMkcGkJYRE59761j3NK2b2
 1BZP/S2t5FoP9cW0P/4WvqguRx7dP95nG/lHK3CzSwHEgMLukhQfodRM4lVCmXmDn1ihOVSJJRk
 sLzyE9TmpJexwU8geIJG5OtnbBondLbuWATladWbK4Qk2j8/ayBx6PI7C4YsLVWZhNHm7sLRxVP
 I5APtw3z6ZjmNNchz01/+8w3qFgm4BrXtBAeGdFdh/D3uO8I9Db77/6UIv+U2Qtw56JDEfqs2rL
 xoIFJ9m76+4xOg4AR3vUOWNoS+Vb3CdDO4H7BXvlTMaOkoxK+ImkiVkiY9D3jcnZX9XsadL2c44
 4PnT1onfM46Q4PQK60BW9BxxBb5OFyTOpNk4fHPdqhG8tDzxY8tM5oJIW0m/NEa6ffBGcAR+BGK
 on6c4ViTAPEiszhMFLc/x6GIv4Jmcw7dWFatJHcC04RSiNEmz0VQ==
X-Google-Smtp-Source: AGHT+IE2VTyDGM5yZZkIotHm4CaoOzgiK8FwiCEDrUNHL+Cb9wsYleWkodcpP69eRMHIr2+IdPzYQA==
X-Received: by 2002:a05:6000:2287:b0:426:ff4f:39d7 with SMTP id
 ffacd0b85a97d-42704d9447dmr9488463f8f.34.1760998231874; 
 Mon, 20 Oct 2025 15:10:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82b8sm250516935e9.15.2025.10.20.15.10.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/30] qemu/target-info: Include missing
 'qapi-types-common.h' header
Date: Tue, 21 Oct 2025 00:09:18 +0200
Message-ID: <20251020220941.65269-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

When adding the TargetInfo::@endianness field in commit a37aec2e7d8,
we neglected to include the "qapi-types-common.h" header to get the
EndianMode enum definition. Fix that.

Fixes: a37aec2e7d8 ("qemu/target-info: Add target_endian_mode()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 17887f64e26..e446585bf53 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -9,6 +9,7 @@
 #ifndef QEMU_TARGET_INFO_IMPL_H
 #define QEMU_TARGET_INFO_IMPL_H
 
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
-- 
2.51.0


