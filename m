Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FFC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktz-0005gy-Ar; Fri, 05 Jul 2024 11:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktu-0005cg-5O
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:06 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktn-0000Ix-Sc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:05 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7541fad560so204966766b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193456; x=1720798256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgH3hJroWZO1UK9YywGYVtlcVLycJueDEDps19iwMSg=;
 b=uzvV6aXMD/fLrJ0PvMQVDjSNB7hHVbLbCNjMuW7Irb3NG/7lpyBM+5pK8p0FoWr8EF
 kL7nicCYj0KJgCq62iE0lTMvFJDXDJw7EgZUov1b3pxj4xp0sx92qLLtYQA/1UBkcXGm
 IiwDxytBFJo/ufYabuCsZr161reATHkos+tFHwW6PzjBhQcumCdw2MlWhSSduf5UieIr
 okTeVoZxZRHU3OQNgtK4/mBY7aOKk0vXdF2TmIixinx0Sf7yoqzlkAGwb8WOGT3BetB8
 2jQSGP8M6iUQCjlKm/t2PHH0zyBrBfUpg5hPRg6zhHOnxPzad51k3kT5bjfWh9pEeRLC
 t/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193456; x=1720798256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgH3hJroWZO1UK9YywGYVtlcVLycJueDEDps19iwMSg=;
 b=kU75zsX1qzALqN32rN7KcGuTW5qIgp0U9Tm+JBrSpn61hhOBKFl/nqcc8aoUM7kn1o
 uN7zTHtnEIh1x1ZXwYacA/6c2AhsY+b6Q5QorNxeSIepkzOIefv0aHSIEAPqUsQZZVuj
 qHWrEMrV676aIg6WQoRzR6mypA0CS2hZ41vljdYEZoyGOel3fFCGSxrC01XTx8wKB4X2
 TjUVGN4eUChw77oLXNIu9P1GSnIo2Debb1LtGEq6mq4K8R0NnRWEucx3cFDGvO/ug7Uc
 x0AqqTKi8GMgxBBfs63JtcWFYWXGtLBge7FaDpUwFZYtw8hl4d/HXMcX3HJvDK+KiK3F
 3geg==
X-Gm-Message-State: AOJu0Ywh7qw8Bt0mJOAsrRsa4h8yXr2YBA8kFqFfC0H7HaaGUBS0dldx
 kdRCxefwys7sMDnck/zHOJ387+eCRDzFdU2S0c1EcNTA+t8EgBerW0+0lER9g1w=
X-Google-Smtp-Source: AGHT+IEmYUzvSGk1q179Y7kU1U+SyJnIRTXKSnWzEQN0FcvwBv8QvpB6NjEf9vBorWF0XF+zmU7hHQ==
X-Received: by 2002:a17:906:747:b0:a77:c824:b4c4 with SMTP id
 a640c23a62f3a-a77c824b586mr190009666b.19.1720193455672; 
 Fri, 05 Jul 2024 08:30:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77da27c044sm33099166b.157.2024.07.05.08.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 637955F931;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PULL 04/40] hw/core: ensure kernel_end never gets used undefined
Date: Fri,  5 Jul 2024 16:30:16 +0100
Message-Id: <20240705153052.1219696-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Really the problem here is the return values of fit_load_[kernel|fdt]() are a
little all over the place. However we don't want to somehow get
through not having set kernel_end and having it just be random unused
data.

The compiler complained on an --enable-gcov build:

  In file included from ../../hw/core/loader-fit.c:20:
  /home/alex/lsrc/qemu.git/include/qemu/osdep.h: In function ‘load_fit’:
  /home/alex/lsrc/qemu.git/include/qemu/osdep.h:486:45: error: ‘kernel_end’ may be used uninitialized [-Werror=maybe-uninitialized]
    486 | #define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
        |                                             ^
  ../../hw/core/loader-fit.c:270:12: note: ‘kernel_end’ was declared here
    270 |     hwaddr kernel_end;
        |            ^~~~~~~~~~

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Message-Id: <20240705084047.857176-5-alex.bennee@linaro.org>

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 9f20007dbb..7ccc9d5fbc 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -267,7 +267,7 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
     const char *def_cfg_name;
     char path[FIT_LOADER_MAX_PATH];
     int itb_size, configs, cfg_off, off;
-    hwaddr kernel_end;
+    hwaddr kernel_end = 0;
     int ret;
 
     itb = load_device_tree(filename, &itb_size);
-- 
2.39.2


