Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B2E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwJ-0001H7-FW; Sun, 15 Dec 2024 14:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwD-0001Fp-Qu
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:58 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw8-0000zx-VL
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:57 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2a3a40c69e3so1499546fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289552; x=1734894352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhqtvCsP7B/3GovJPeysQPzd4kcIcPuVsgvdiXaClBY=;
 b=GfsHjDXESWhZDPNCdUaPY0u0Y9PlsdrPZL1ijPBQEkFhQvcfRMk/peeTfKl7Ps7+ex
 F4Xb9PxS7wSHbSQSCSLc+d3AtaWF+ylikSGfFKN0WFCnZOOGuB5m6R/yXdd6dc8on7ad
 6BYNAOf6QaX4GCwhgQ2hB+uzQw1RRtd826gTqRIIv4IAvwMbgB7zWxQB3A3K0Zm3dxw4
 E5VvQ++OTAe5dRIzxMGRxLpabrWvlPKBSvqed1wcVWdNUawKAmscnloF1lbZYo6PRNhB
 8O8kFZL4PyI12cncXWbATPw6+k2i+Zydhi8k5/kik8Q/R8Qde7fIcUhuvbmpv1dUtjab
 011Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289552; x=1734894352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhqtvCsP7B/3GovJPeysQPzd4kcIcPuVsgvdiXaClBY=;
 b=S+PABZvMkFYOo8REdPg5Jrw9pszQ/HvsbKtRoubyTGzkcwPa8rjjVX9TcQup4T/Kpv
 inY6LLRbfoj35JGrzw0L/AFGlPGauyQ/k3AxF+XZwpaLExsb2Qgxyu1BzxKu+1zzL+ph
 AvWUPqEMFVNjmX+F2QbdSkqo/73BqGW1iOCMgqYOy3dO04n5XggD/vgOX+cBWIdTD4Q5
 RuQyQs6mqNKMiyIDMZ9mXRfhXl2quVyB48u60j5D+mXc8G2PJXB2vikXAH8liqg6N6YV
 7Y+z1GTK59iJ7y1lP4BQDtz2GauVhSote3gMF+fEeyREazXVpcHboCTE+cqf/hrn7vzs
 xfKA==
X-Gm-Message-State: AOJu0YxEsCmab+eRsTC5vRLg1HTUniWCaVGLumDpKTunMnQCzZ54UZEJ
 FwfXgjaK5i1C5Yradpa8tkmFjf6JJ3dDJY01itRdXus9FxZxfnu6ziZpCp9PUXnBuilYtLwBrCF
 t2+y6RYSB
X-Gm-Gg: ASbGncuSGghntsQBOpViQ/hrBKOO1E2Y8k5ocOxCR75exOe0Sq6WB2MgDQcBpcJz4p5
 AZ8POuw7cjmW2qLlDqmGvuuSHcWn2rKJVttyuV5Er0vXwZcs6ggL9nEbnv8zNSmzw31lr7XYUGO
 GbSzIXiCj/9QUYyy9ssaLhVsWlm4Bx0WRSvePxcR0b2ZC/tt3VwmBBxqhpAHunRq509VX4b7EJl
 z2ZLZDJU7ohP7kiOwGwpgniGJaMd0yXeiYHFU4+g7Qt8wFHuHm3K6UEZi64n0CkydQlooT4nGJV
 Ma2Cv9/clNgHVJWggOj2XNU/NladS3qLH6fryCt78MU=
X-Google-Smtp-Source: AGHT+IG278VMVmVSCOg64ZPclU32flRPtK4LJK/vlJsBaVKoFP8dstTNRCHnn1gPAH80oL3FlIRVtg==
X-Received: by 2002:a05:6870:4721:b0:29e:569a:f90d with SMTP id
 586e51a60fabf-2a3ac8b75e2mr4369838fac.32.1734289551879; 
 Sun, 15 Dec 2024 11:05:51 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/67] target/s390x: Constify all Property
Date: Sun, 15 Dec 2024 13:04:34 -0600
Message-ID: <20241215190533.3222854-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index adb27504ad..4702761ca3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -309,7 +309,7 @@ static const gchar *s390_gdb_arch_name(CPUState *cs)
     return "s390:64-bit";
 }
 
-static Property s390x_cpu_properties[] = {
+static const Property s390x_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
     DEFINE_PROP_INT32("socket-id", S390CPU, env.socket_id, -1),
-- 
2.43.0


