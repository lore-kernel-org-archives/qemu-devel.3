Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD406E9A05F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9d3-0007oG-6y; Thu, 19 Feb 2026 14:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ct-0006cy-6N
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cq-00007N-He
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4362507f396so1362070f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529027; x=1772133827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrFlONPsJLaPD1g1U2uRKMZT1OxnmubFnfdQU/xYBPc=;
 b=vt09rEGFEyMYvjYFVDp9WDqlSuAK01Bhv8kUBq9oKtANKHLv9+u/zjZ10ArC/py3Nd
 61ArrLkl+Q6DzJkcw4qhJgVa7towG6i4kQsYTwfGILG76c/+MnsDPjr1fsAc3WTiFjFj
 q26EiKfXqv/PFVcDx+BiDK7JVZrw5wpKMF3J/nJ4RHEnMemOamiOKE8NX2J5zOMwvNcD
 I49CdAYACvH2npMCb3s0yle8jzVa9Y1xeG7vk5iRz1v/9hvukPT5eHE+IeXVBXZHseOj
 2Kh8OZOcIXS7pNp77LxUmtpANAX0C7j8r2+lfuYGfX6TIwUsM3ya3IPq51aQIe130fn3
 01bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529027; x=1772133827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GrFlONPsJLaPD1g1U2uRKMZT1OxnmubFnfdQU/xYBPc=;
 b=OW85DBsaXRM+B1NVN5EAOurvyRlE8INoKnS+7O/JNSUiFxEUz4EBYrQX2GekRPWIyX
 aWe21EuoWVNb0GEHhXCKZ1rJUmcW6oZ0/M6X4k/FCKJGrayRhIKo+8K6lYiTNk+mk3kg
 va+pHg3npC3GBbga7jyAxFobOTKWQtpsF5ud1RZ0X3ndwIUjRch/8u9zcgGNGISRf3Wh
 4dW9gb4YAzqGofiQQP3geLZZdPPRDT2k5AGd2ZlIlpXrguevF6E7Qq1ttQ1GvELJtk8H
 xcf4xTb6ymSOovci1mI8arLnEDwJqTMalwQLzxYo32De14v7K5NJj8shIwcqrCvHviCr
 VAXA==
X-Gm-Message-State: AOJu0YwR8KrjEUOCG5CqL/joFbmXVT1k97Iuh7qo8/+OsAkFnsEbTKi0
 dnQ7EksM8OcuxXwRVU1wZdbw2a92CaGsTheME2NVEWX1R+nvLOHDQ6N8A4+utzL/5L5qMeFo58Q
 1QziSoo0xHA==
X-Gm-Gg: AZuq6aKmQsgK+lm+7yZd51X1cvveZCKpYtwD1JAop8dxR0nBAVwNGWNYukb+D9fYs3i
 U4ddXzNSIOsnozDzqs7HA64ksjuGgA7a97G4eV4zYKnMlvU0G9Go6wAcPoyv33dyrY5odPRHDM4
 dI3yapg5M8/ZT1jt5CEhjDUm2jFkgMe2IPI2JlAhLEjQ3xX/mx9vG6/BSquIYzz5kMHfa06YDJY
 P09qq5aWP4BIRTr5rfX+5pHOQY3y50gUdX8k+twOLCvu7UQWP2ez3ElabW0Yx9VkI0OaMjEBX9H
 k8tyE6LHTxp+Cb/DTt8GhTFbIcH9ovQEoKx9iKLbC0JT9Hz/WjOgX5tnbriaF+D5nsTiJQw3ru4
 pd2/t8eMMbNitki79yBFZWkrDHFz9yfyBx2omaZlKTXRZbLwG+MMBEttDl9EfpcBCHC7sTAHfkx
 nq5Xe7C1+4R+3PWmcrmEFGoV0ARtgB8g3ysAlMUg6glJyWrK4g9os/j/+quJt7b0TeXaAhUBKZ
X-Received: by 2002:a05:6000:2407:b0:435:dbc4:3af0 with SMTP id
 ffacd0b85a97d-43958dff89fmr12178009f8f.14.1771529026646; 
 Thu, 19 Feb 2026 11:23:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5f0sm49482834f8f.11.2026.02.19.11.23.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 32/50] target/alpha: Expand gdb_get_regl() ->
 gdb_get_reg64()
Date: Thu, 19 Feb 2026 20:19:34 +0100
Message-ID: <20260219191955.83815-33-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Alpha targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha-*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg64()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 7722eb46806..b458eadd7d9 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -53,7 +53,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     default:
         return 0;
     }
-    return gdb_get_regl(mem_buf, val);
+    return gdb_get_reg64(mem_buf, val);
 }
 
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.52.0


