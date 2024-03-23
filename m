Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23724C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5CA-0002lQ-Rz; Sat, 23 Mar 2024 13:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C9-0002lH-80
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C4-000663-CQ
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e07cd7b798so19707435ad.2
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215007; x=1711819807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqxxoJyz/Tp0Fx2Av8AP+03UJeuM8REKvV5gu6VjKFY=;
 b=spRDOE1iUdXA0sup6cNevxjuWFZWjRIfO0lgMHtk4IiJ0sTEJ1kB2y/vlzgrYYp2TA
 MX0E7gErMWPVSexk8GR4uKpgzYyRwIWW9WM+ScLGydcDLtuZvyHUyUqRhEI4Yz/PofvJ
 bbIUL2dXdmgyszbTbCA9ieRV/RiZ3+WSGHyyWbIPhj9pvhMb9ooBALEpu/PkVaNqfAtw
 AzELcIftKQA1+KSGA4LRisCUfOvX5EDVdlBlOqyXRoiXUkQo5jVVXBnJwDuITYKN5K1G
 hygUaHSuAo2SjG9gLX3Sz1mkWvp+/D2rY7zbwmRQf6lmrk7vr3x9fT+TJPVPnEQSbDVX
 WuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215007; x=1711819807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqxxoJyz/Tp0Fx2Av8AP+03UJeuM8REKvV5gu6VjKFY=;
 b=sL/7FtoAdT83DTXKi2z5Ip3QvznaAIDja04HVY+bLZJLcQMoliqegxPyh1Ev1ykVvu
 m17CGGGxKahAhuHQeFxiVG43Vs2Lrl59xLqf3OMbNwaR69hcekN3e6NuMNkJ5M5h1hod
 BsCB4X01NtE3mV33CJAgU0MyLIbTows092za1E1g2zq4tEVvXu4OwyepuHI9jMb6Gzlb
 0gQzw/gZNz69Ke+XWWFAOlgBfFEjOEEE+KhTfQp7SrWgA2KVOWP7VoUo2DbK49nFC8AQ
 xl0z4ZhbpdhXmMKyoq+RQTlRkzoKBnUut1DcSZT3lyuq435+7WpAUjFVRTYP6GO1AS6m
 c5hw==
X-Gm-Message-State: AOJu0YzVLExhS6GxQCd3L2GxrTfQ81wswvHzlQxqG6uLzm6Q266LsglK
 ovY8VZ3s4lf9Mnuxljbc1kpJXhAxdS4C7PcZAfZgEwYxFgfpHdz0vXNl+K3YKMV02u+6SbTdgBg
 e
X-Google-Smtp-Source: AGHT+IHSU8qNa1qitJYT+rWhIigugrDSdIb3Sc+cb+aqELfg07mD41+axlyMAjA/zq5qlZXkbaQZiw==
X-Received: by 2002:a17:903:40c2:b0:1e0:1174:6360 with SMTP id
 t2-20020a17090340c200b001e011746360mr3451396pld.14.1711215007005; 
 Sat, 23 Mar 2024 10:30:07 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 6/7] target/hppa: Tidy read of interval timer
Date: Sat, 23 Mar 2024 07:29:53 -1000
Message-Id: <20240323172954.1041480-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The call to gen_helper_read_interval_timer is
identical on both sides of the IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8c1a564c5d..5b8c1b06c3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2082,11 +2082,9 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
         if (translator_io_start(&ctx->base)) {
-            gen_helper_read_interval_timer(tmp);
             ctx->base.is_jmp = DISAS_IAQ_N_STALE;
-        } else {
-            gen_helper_read_interval_timer(tmp);
         }
+        gen_helper_read_interval_timer(tmp);
         save_gpr(ctx, rt, tmp);
         return nullify_end(ctx);
     case 26:
-- 
2.34.1


