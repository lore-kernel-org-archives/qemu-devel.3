Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F68E7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5G-0007AZ-3n; Sun, 08 Dec 2024 17:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5C-00079F-VP
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:59 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5B-0006EF-KM
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:58 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71d5862c1d1so1667203a34.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698136; x=1734302936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mYJt475jbhCjJ0U4k+fwEo51fziCsqJ4VlkijB6Ad0=;
 b=l3p8eaBqNqCkPWH7gq6OQl62jNqf0SFfz692Dj9Bv3r4qUrMeNKbx3TIJotPRc+4z8
 kfxZXtQyfS7/pu3dId2w2ocdfOk2DPDTQvIqbvx72SyAyxVSSQWDEyS3dIR2kfpNLgE0
 cX8CWql0YqOA/DWYxH0RWF2jGuL+H3TcbpvbIonIrDqWg3xGV8gppV+EY4krb7FUpVeY
 jSCIra603/n5yIce0bPux+5gAfH0UicGueByA415rAl9oLEXBE58KpAZ/vn+URyW/8VR
 5VgmdyFXGhPY+lZ0fsRkNUCYFzKKwujNsoETGRt3my6EXYHHcy+TyrJSuGpoVPvZo/RW
 S7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698136; x=1734302936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mYJt475jbhCjJ0U4k+fwEo51fziCsqJ4VlkijB6Ad0=;
 b=ZyNCyXsbL+tYfOSNxdwdT4y7MM7xeMUtT61uSa4JEBUVvoPyArfjKDHHzjr/u3ZRb7
 JTXyxrIwGX9IczFHNl/mdfAQOzt+aNCmIwasx5ne7xXXlbfk4ph+DeXZNL1K1GU8pE8L
 JrwdZcECv05+XXqPXIpJPOkOJ+lElBbwQX2c63G1oLogy8cqxqBxbAa5LoaBVurxou1M
 Wdtf4IFE0GGJO9AMMjR9CNQXmjEvGwem3jDefJdkmiQjvWMrMKd46ngdnHZEvuEGFlpi
 t4/bUbi1bIjx9xVYusVgu+qifjHr1nTPVILpagb8sQZEtX2mZv5Uk33w2OdvLfbejC2q
 49Jw==
X-Gm-Message-State: AOJu0YwPckRK43oOGNfhIk7rzLI5Csc/LZHn/Z/DJkEmNLfHXEVZzfZq
 LsuLpl/euoSKVA5rzJqSIku9g+1VOrcnH0OaIJnRjbOJe5pKJg6f8/PT7FMgeOgDN+YivIkIbqP
 NWjPBkw==
X-Gm-Gg: ASbGncvtzvEv7dvUUQvYC/vna3T1ba5Chl7QffyrrH9E+mFUmRqqNyX2WdzhzM8w9H7
 8PGn7bmWvzXuagVuu8V/aT4xjE7w9koFguBQ+WXwT0AJspuoxJvB7HD3z188GI2Pbdf0yulOq6D
 g7aXEzdGQdYGDSsUdOpTe7SSppkFWWEgkKCtWCDtzTzOoU+UR66nUIeBtkCZ+leEztnqrAF6iUv
 bUZ2yeIa94oJR79VQf4WUj64fXiHUaanin8zTv66yKy31BMoMI3EyilN/XoHB0ckDn+wpUcGIPb
 QDna1bmx8YbmJzlwsgQZV9x4ISwVsXmec5/q
X-Google-Smtp-Source: AGHT+IEUu3pwNI4Vf9YU5E5UMVxB/SLwDS/b+G71mrM1HHoLji+rMZyDX0cmhQnWGv5eZtqRGvm6KA==
X-Received: by 2002:a05:6830:6208:b0:71d:4d3b:bdba with SMTP id
 46e09a7af769-71dcf54911dmr5967010a34.20.1733698136592; 
 Sun, 08 Dec 2024 14:48:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/17] target/hexagon: Use float32_muladd for helper_sffma
Date: Sun,  8 Dec 2024 16:48:35 -0600
Message-ID: <20241208224844.570491-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

There are no special cases for this instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index b8b556f4c6..7d459cc6f3 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1166,7 +1166,7 @@ float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
                       float32 RsV, float32 RtV)
 {
     arch_fpop_start(env);
-    RxV = internal_fmafx(RsV, RtV, RxV, 0, &env->fp_status);
+    RxV = float32_muladd(RsV, RtV, RxV, 0, &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


