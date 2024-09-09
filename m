Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935D4ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBk-0003zi-Un; Mon, 09 Sep 2024 13:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBk-0003wy-47
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBi-00060S-Ah
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-206b9455460so37857495ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902908; x=1726507708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkNkUmASmGlQUKASb8Xt5tpAkjJXSsZCepHO/OHmg6s=;
 b=iOeC9XdHTj42iMFoy6elbuRoyHCS2X1MID2dyUdSfFEhMfy/hTW8jGapA1yR+dBeq9
 LU9mbsocot/96OMAFncKLIjDkzVTbcUmOYkRWKIs66jgGqM2vMU3ejf7AVPfzOBo8xua
 zV2eDrBUlu6gB4v62lVVUcrTBf62H1Xv1cJuTg9nzIwtJYhnxvKCUf8NVQYqTITvlUC+
 cBV06B0QepECLvrK+q3ODw5v+WuBgzVI8IRk+eBy715CgSrQxXymoG2m8D7EcN3Ymp5i
 pbBF/FNcaGYxsw9K5qD1tSon8Otk2UsOhYRB5Gm75XqZLMMtzV7ifD9/45gzQEuS+Xak
 Z1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902908; x=1726507708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkNkUmASmGlQUKASb8Xt5tpAkjJXSsZCepHO/OHmg6s=;
 b=e58GjBRtTbRg63mIlpS0/MKictf8iQJBRIc5E8hk0mkTWRojsvabRJecjUp2EJTTJi
 xpLwIyIuDptQ1Nvh+Frq4wkCeRS8E1fmeU6Pwu+wimjjtADLbEBLL+j3hFtsJDZJblXb
 ooOVaY0WXk9Xqel0WUEftgAqACH2t4Ic+TWV57bOR+wbDiukPbhcWoJWHlvLhStB4KN6
 MQJYqg9KWXz04L+3Dchi1ru1WLhyy/ZlPj06fl/7rpsuWu88SLAduptcZ70IZMIxZHP5
 U4s1ey3m1fS8L3B88rB92tErXomGVJuwZQXTpnvouQmWAlUv/9OwD4sqU2TrSrHbsRB3
 8IyA==
X-Gm-Message-State: AOJu0YzMOk3Et7uMh1E9/kgf86eZlEc5QzoKHf2iH3dC+5Q/Q4y9MUlP
 vTbjDOddqn4mB4hHcCn4pJSAFdOOtDzWsrOSMlYlbbBWaRBCawKeu3TLFKCsR4CUBp+puGxAyUV
 k
X-Google-Smtp-Source: AGHT+IFEWcYT1q+Re60GDlswQuMQ+LIcKzkI/hHCx6J5QYB2GczdtTbOVWuD/KdfnRPJG6dCHbUMsQ==
X-Received: by 2002:a17:902:db06:b0:205:5c06:39e6 with SMTP id
 d9443c01a7336-207433d94e9mr5368675ad.0.1725902908140; 
 Mon, 09 Sep 2024 10:28:28 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 03/26] target/m68k: Restore fp rounding mode on vm load
Date: Mon,  9 Sep 2024 10:28:00 -0700
Message-ID: <20240909172823.649837-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Call cpu_m68k_set_fpcr to make sure softfloat internals
are up-to-date with the restored FPCR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1d49f4cb23..4d70cd50b4 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -402,6 +402,7 @@ static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
+    cpu_m68k_set_fpcr(&s->env, s->env.fpcr);
     cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
-- 
2.43.0


