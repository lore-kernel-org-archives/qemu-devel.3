Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BD1C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLU-000122-Qr; Fri, 07 Feb 2025 10:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKD-000842-QU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK6-0003xZ-JI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:24 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dcd8d6f130so4399235a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942276; x=1739547076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgN34HFjNsDM8vD8ylx4YNq6temrMo6Bfwlmv/QI6BI=;
 b=Hhts110rpdfD53pM2x8aBxsMRrtvw3A95Nt+5TOnjx1I6erYUU/6yjkq4uTPQKrPgz
 j7YUI5thE/4n2qSIQZHPUme6Iyw4E3qabnHKBqN8q8hI/OYB9bZE4CVbUKy6vGPtHRmN
 xrSOj0GEccvhTPwGOWUOVn4S/gqo20XxJzjTvkDAZ7zEFs0uvYyPW3aAFLaCUP0YCmfE
 mN/H9Kk2nI38P0FByFe8wrkMpbEiW5sU+YNtL0v5MD2Jil6dJUrJcdLt3VUlj9/WMwn0
 /f8jAMwFrbiCMvFNRSBXH5LAcyWolJAHIFwRceM2wYfiuulxUcRL56zFA8SqQ2j6bvrL
 GZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942276; x=1739547076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgN34HFjNsDM8vD8ylx4YNq6temrMo6Bfwlmv/QI6BI=;
 b=LBP6Lqqo45G8v7tHCZIFhDRcbuqhqCCVK2eG/Io+sWzq95gBeFom/GdGlSd4OgklxE
 rHxgLlzUZ+gVZ8Uamzrfw+jTqk4TTYE1aonBcr55xjRGGbJv7idL3Wh8uJfOCnAgNf6t
 YMOURAly++WvqRhG0ip2pMqdxWNXn1H+3tVU97iyniOG/ZxX3P7q66XWlI3LfFnhU4IX
 cAmQkbaYMLU3nGLrYZgkIKgvtr0jccUs8yGrBUZaYjPgjVZ95uaFFwdqEa5y9IGQXD2I
 9tpBAIx++Oe9f0hnP2NSVhQlPUrM6cvVx+BtJzLzZfbNpwV+Ln8H7tnVuhZ9v170KVmP
 SpSA==
X-Gm-Message-State: AOJu0YyiMv+yrrT1+Gd7pqCo+YDlugyshWjdACZsFt/KC2pxcqOKWU0j
 Azv1Aa+nBIFtRWeVmsu6Njm0qZHU+bn0KrPaNq7qlhNjjAXeg5oNJKeL5Ti3h2k=
X-Gm-Gg: ASbGncuK3/8bGaZekYjRVIRC2H621veu4GaJ7wB/mJhX6h8Exw/4sM54RAfXYRSDKwM
 uz9DSrhtI/MEcKmM/rmrS0jyF+8vAt3MNRk+21QU8zJax+wLdI/gxHFnTMKaRrP7/looTxPPGKv
 XKkVovJ4hMe/uyXrldqnRytnki3W9RBWGunWd7imj+Q4tgP+RtoCqvnc2CAFIPVxGuvwPyAp5CN
 yQ5o66OxcTNfSoQwe8b2RG/GEutTxTXWyCXIf7aUukIwiAdmioRRVKOjF7HueJmTFVrGo/J03em
 KFubd5ze4mWWyQg3Cg==
X-Google-Smtp-Source: AGHT+IEqzFUgykFDg+BzRAsgHxxxzwOjwd0iFxcy5saGCHYKMbqqCTZmszVdtqyx4yCd8hLnqX/+uw==
X-Received: by 2002:a05:6402:3903:b0:5dc:74f1:8a32 with SMTP id
 4fb4d7f45d1cf-5de458c49d5mr4466459a12.28.1738942274649; 
 Fri, 07 Feb 2025 07:31:14 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de46b7b480sm1366479a12.36.2025.02.07.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A48D95FA80;
 Fri,  7 Feb 2025 15:31:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 03/17] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
Date: Fri,  7 Feb 2025 15:30:58 +0000
Message-Id: <20250207153112.3939799-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Until there are timers enabled the semantics of clock_step_next() will
fail. Since d524441a36 (system/qtest: properly feedback results of
clock_[step|set]) we will signal a FAIL if time doesn't advance.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 tests/qtest/npcm7xx_timer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 58f58c2f71..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer test_data)
     int i;
 
     tim_reset(td);
-    clock_step_next();
 
     tim_write_ticr(td, count);
     tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
-- 
2.39.5


