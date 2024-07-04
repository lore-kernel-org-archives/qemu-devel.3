Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C7CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLuJ-0005i1-53; Thu, 04 Jul 2024 08:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPLtm-0004gc-Tw
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:49:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPLti-0006WE-HQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:49:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so2633125a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720097353; x=1720702153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mE9NVMNgeMpdIBYLHPdIh0Aogurvyr2VaxgmAxGfLmI=;
 b=TyHQbsYxd92JNCOdwESYkzhxd2wtqp/CXZ83CFRvupRMewwwvXhVEy8fvJcykuy50n
 7wHJo5qGX23Ywc35weHJvVDFZKH6SV0R86DcsV1y+6m+/Ey6mcqBIAkTPxRFMhigmAOa
 tuHVKbbfzcE2yRpo9GDtuKz1eLAUAgb03QgWbk/Yvt3bbXMoz3K/zxfU5B1GBp28DSdM
 4Y0/srIS0xYQ4xqdFvzSU1rcan8NJzeKfFydupdJ/4Ql+zqBOkAtf4xbFd+CyzW1GLvp
 BkiYrRXqNR+UbqM93oy2F2qvpcPb+aNhXRPqavOCjzQ05QMNIVJJEReLkqEvpMeVxJfh
 bm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720097353; x=1720702153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mE9NVMNgeMpdIBYLHPdIh0Aogurvyr2VaxgmAxGfLmI=;
 b=oLSAsL43Zri3HzIrebMkygH1DkcByaQ36xI638nidoxICfzNZq0kcqIUnBavJHpHyP
 JPk48SIStZZU6C+9cB1uOnOM2xD1/Yj2ybbCuzvPX7WH0AJ2E2Rf3+VGo9Yzjaqkl5VJ
 XcSj4Gx+JEGki3D+m8gAvCcNWf7C2vRSCCcJPLLgs+VkR5AOLmcdzbl4GMDGethmCATo
 NxATSlW6c9tG3DnXVI6ih+IV3F52TzqyQkJdCshpG6g0ilX4cf1yOTbLsEA7zonLZGez
 zInwP/lh+veoqnuRVHuI9t4422Sso2lYzolmVXxIOYkAS2N6bLJ1Pv0SO3Dk7JPakVix
 xLbg==
X-Gm-Message-State: AOJu0YzDfhMvC9JuYKTldHjK/TKOqwtmVR/8ajMfNIYLHW2NqBREWydD
 PnUJYBnVReuPPWVuy+3ew5eCdk7VwlmRhzzlbmbIq2JeN6X3o3Sm6qOz7v0MBZQ=
X-Google-Smtp-Source: AGHT+IFzjusZs1x4NIxFmn6I6SEK1JhfdfIwTfj27mVmL9vmASC1hLcself7wYYASaUyxhsZXjbluA==
X-Received: by 2002:a05:6402:5110:b0:57c:c171:2fb6 with SMTP id
 4fb4d7f45d1cf-58e7a74d33dmr1041672a12.1.1720097352521; 
 Thu, 04 Jul 2024 05:49:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861381868csm8327192a12.55.2024.07.04.05.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:49:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9FE05F839;
 Thu,  4 Jul 2024 13:49:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>
Subject: [RFC PATCH] hw/core: ensure kernel_end never gets used undefined
Date: Thu,  4 Jul 2024 13:49:04 +0100
Message-Id: <20240704124904.276603-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


