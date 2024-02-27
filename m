Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A474C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VO-0006Ua-Ih; Tue, 27 Feb 2024 13:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VN-0006U2-5h
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:41 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VL-0001ST-JZ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:40 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e4957ff05cso1621046a34.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059718; x=1709664518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYBkGoMMC9wjPymAcLzdiqwt32NykwjmDLE/jmy3uYA=;
 b=PTWOgijnVwgQfa5nMUkRjVR5K3R0he76rfrErF9KisHjaKTDaJFh0Z42IDGsZab/8M
 BVuQaio33mtUA9L2XCBiqJePIWohU8mGEmzK+Sm77RCFuexvrJmbfh5tg1MwJWviOU9W
 k1XlgdZQbJ5/X7Sn1CZLHbc3/x0bXVwzaOkAEEj5UGRtDDQHskp+t57GaMJUMyCRqAhv
 j4i0r8zHJu9hb6ljI3+LcQPynMMfk7mqmwSpLj8/xItp69QK/ZjVQFfJcvl320KU4q01
 RBLFAfyQZsTwtGkc+JJJs0bhJFxxZTvshPwlCvJ66qLstYjC022lu8cp5GkAGUoTA0jP
 d30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059718; x=1709664518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYBkGoMMC9wjPymAcLzdiqwt32NykwjmDLE/jmy3uYA=;
 b=NMqiNn9gC5p7+XMhCyXqd2KsL8XekO4/d9ya1k+0SJwjSLrxIbY80ft2fi0rEUiSJN
 fxF8ojgPZw0bgqa6QcD/SkGj1AOfJeB82TW0Fo93jsB07JXj7u9kWvkeQ6KhWplm4Mc6
 sk245Dmr7biXOlDMuy00HL+yh5JF5RkQLx7UN9njatm/bUQgYNZFj0zldHskV22xIN/7
 CJv4FSxoYjDrgrD8Cr0mdy49qTnc8zjUQuY/cx+YZDDWg3XRtjvTCJ4ztFsTizO0qOOV
 //0MnW5xBDgtkiODX2QToMds5RWKkPWXDmAH5PJl6SgiQ6I157tGkPSmrMFzXMv2bweV
 35lQ==
X-Gm-Message-State: AOJu0YyZo3sAnL6lT9hqFhNY5NdA2QJvayKg+rzde6j5m7D7WrvzLEeR
 irizTmGkV35R9LESl7VkyVXH1SumdCqF9b8Pf4yW12su2KZaFia7osksaQ53Q98VKDFkzAXiN/v
 j
X-Google-Smtp-Source: AGHT+IFiH9Zm7aK5ryGMl33mU4PJvdSIBmUzqUo9c0/mSBWARMXyCltNiDwnNSdBUuRLo6k3f4fyog==
X-Received: by 2002:a05:6830:1390:b0:6e4:7a7b:700b with SMTP id
 d16-20020a056830139000b006e47a7b700bmr10732280otq.14.1709059718356; 
 Tue, 27 Feb 2024 10:48:38 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 01/14] linux-user/elfload: Disable core dump if getrlimit fails
Date: Tue, 27 Feb 2024 08:48:20 -1000
Message-Id: <20240227184833.193836-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Do not dump core at all if getrlimit fails; this ensures
that dumpsize is valid throughout the function, not just
for the initial test vs rlim_cur.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8eef893d0..fb47fe39c9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4673,7 +4673,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         return 0;
     }
 
-    if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
+    if (getrlimit(RLIMIT_CORE, &dumpsize) < 0 || dumpsize.rlim_cur == 0) {
         return 0;
     }
 
-- 
2.34.1


