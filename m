Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E8CCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTs-0007dw-8i; Sat, 04 Oct 2025 03:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTh-0006yl-Fn
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTf-00053t-M1
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso24491525e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562085; x=1760166885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rpKgy8qh/B54NCEvqdS30/eBsVzS7Y4BO//HdAAbFOk=;
 b=CeyaOGETJv1p25PDozSViDlH3cb1zC6HjjvanVWhLIQgNc9MKuGtY9gdEJrbMtQALN
 zRu9C4yrQxw9YU0bu9sXJVLLk6f+KfOYzn9eW0BQRrUo6sJaNePZVyMXOG2PDJpAmFwF
 ItYJ3S6knbBHFzGaZqQUxJcqHwRDtju1+D2BQDq0sHa1nSos8aBmqD6OaZpNgfC16huC
 mRQzBN1/WAkLPsjgD2SC68AfXzO1h2L+gxiKM9Q8amwenBLiQRUKeBQ+tkgmgVVVcrTK
 ZUjF/yPzE5OGG521YQ3gF1z2VRSg9PONx0L5mCaZkselzU3xVthO1tDwUbEcGDktsQ5W
 ZULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562085; x=1760166885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpKgy8qh/B54NCEvqdS30/eBsVzS7Y4BO//HdAAbFOk=;
 b=uaaOxYCgWAGB3FFpy/kd/LnWxNXDMpuBQSARsWsrOdneyGbx/Y2asrP3x6rp99rmuo
 UieNqa0lusOQMSYG0A+P8xFM0fevamHy8/GdE51V2MgRnL8YaqBRglGSvwirVtUNga5X
 Cz1TMVyS/vITZQ/ySrNr3MKeRlWJIyFnvR8ZhC0GcYqE/Mybvrq+9V10TKCJTG0WosA4
 MzYqlrM/vclQ0hXo9MgA8pNlsX26Ps/Fo0/4GSqZnzqPo/pjLpdlJqlObMByJWLhPm9S
 l2VVvcPcUFa+WkaOqN3XbnbpWVRmzfO3OPyp84wVK+GZSabwFfInDZScEOZVzdxcPM94
 +4gQ==
X-Gm-Message-State: AOJu0Yy1P08eRIGtuvKerbDz2EKYVJVppq6Rb5cxJdCVrDt6798a1Pen
 WZ/Qn8FFYkoORHzSTzO1jNe8Rel8Puvwdqt7H74lAOciRTBbgp60NuNhhsBwJCsXNCv+er3X7NZ
 9GQ+o9TBn+A==
X-Gm-Gg: ASbGncvKebhL7ObdCXYB6gUF8zQad73kCzMb7L3ClOU+ldygdxgncvKXy8cOk7zuZ5j
 aHYhs78IFrn8yIwbVgOfys8G7sm7hitQrbeEOxwnXVzUuUqSFrxBI3w55WifKmsNF7oD2af7Fo3
 iwWzHUtdm7vXsKKk3X91TMljiQOyDwMJothR7xWgkp/8kTdrw8F99pYc9iiGo38yWFZHw+T/USl
 l9nk28TMWtD2mWQMsU+SyLq1krhjL7b6YMiHYkxowFk8IBluApUWnSCC8JOKspezP1UcudspjOK
 3pnI5hvHBLzpao4hSka9jvMTHybddQB1j1U/xDh667/2RhDJESPjblsweQ8knnaJRD/1dKaLxcy
 v6ZsQAibtz1BggNIHtLHjm7Z9cbtFN6ueiXVr/s762a9BM8nmqCAmH5QanAsUYgTCCAZAiYqoLm
 NlNPOePskIwMPKGPFbPiTl6zUPToRl/3Y9OAM=
X-Google-Smtp-Source: AGHT+IFExXw2CxM8/o7k2ls0DC46FAstJ+bqFRaIppchG20esqmiKqusWA6CVqkIcrnUix0n4AT+RQ==
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id
 5b1f17b1804b1-46e711026c4mr42356705e9.12.1759562085078; 
 Sat, 04 Oct 2025 00:14:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm66647485e9.20.2025.10.04.00.14.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] system/physmem: Avoid cpu_physical_memory_rw when
 is_write is constant
Date: Sat,  4 Oct 2025 09:12:46 +0200
Message-ID: <20251004071307.37521-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Following the mechanical changes of commit adeefe01671 ("Avoid
cpu_physical_memory_rw() with a constant is_write argument"),
replace:

 - cpu_physical_memory_rw(, is_write=false) -> address_space_read()
 - cpu_physical_memory_rw(, is_write=true)  -> address_space_write()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-15-philmd@linaro.org>
---
 scripts/coccinelle/exec_rw_const.cocci | 12 ------------
 system/physmem.c                       |  6 ++++--
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..35ab79e6d74 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -62,18 +62,6 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
-// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
-@@
-expression E1, E2, E3;
-@@
-(
-- cpu_physical_memory_rw(E1, E2, E3, false)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_rw(E1, E2, E3, true)
-+ cpu_physical_memory_write(E1, E2, E3)
-)
-
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
diff --git a/system/physmem.c b/system/physmem.c
index d5d320c8070..23932b63d77 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3190,12 +3190,14 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
 
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, buf, len, false);
+    address_space_read(&address_space_memory, addr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+    address_space_write(&address_space_memory, addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-- 
2.51.0


