Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvk-0000cw-8v; Thu, 22 Feb 2024 15:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvh-0000Ap-3z
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:29 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvf-0002r9-C4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:28 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso392585ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634666; x=1709239466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IHP5ncEs8tF3IKC2tmO2/I2hmkIrpcpNSR+zNTTzRE=;
 b=zFvQBNZ4z+cZKLLa9HO6ZhSEqZszskTadS7m3eeKK3dFB9jzelPniaZwmrZNzCCTAG
 HvFEcWhGXXKoVahl1CtmQ3Toj+UuJTVNbdUx/lOrLsS+8INZ46AXUvoZ8cKEJ3ePSOAd
 WkFSOGxQgFo3duVha/WEyIsckNAYKtz0vhBz7u6QqjNhu5lbMNf5o+oJRzOqCNsdV7tw
 aeZLWG3eNUyjYGFAe0i1m3Fvi6Xu1iE8RyJNH0w9mvNcPg25gOukssv+YvW6BmlRXZz/
 D43Gjq/4ffgUPnyRS1qw+ebM8BNGzb23KRc47pakqcDiqMVcAplNSv7UliURk3L7shIF
 ryag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634666; x=1709239466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IHP5ncEs8tF3IKC2tmO2/I2hmkIrpcpNSR+zNTTzRE=;
 b=DXqqBlkP3DP33Io42TBFcs1afZ0VzPsOpo2GRuEf273PL9I11NmyRuEPsCwAZZa8zG
 VFRZq0PFSqXstymtY1t/oe1BUbyRbU7NY03If30d3adIqCkoiS+uLqStxiV5gfyZr+Pt
 UiFry3Nh6voa6xryeJFtJqi+0JU6nEZWffrUe0aTApvBSvQpmA8vRhKXiBkQKQotojgd
 yJmhU3QlH8yHcvljzUSbfQowZ1KgJh510IpOiEuZ28WQ3EvyO8NKWt7PSJqAMUlklmZd
 MU8vq6WjTHr9I/shT1BAjmNbzBT+d2sDVrbbpV38eALGLg+TNxj+wF3ip2zGfaqccxfR
 dHGg==
X-Gm-Message-State: AOJu0YzpwjoMt00N8+8hBvUv1JbuFQqv4bUk80e5clBus4+bi9DS34n7
 0BxZg7yv4QBIGHBorOLgcOPF6W1S64SEM2OlTMG6hOD70LPvH57X1/TDKxmE9gPIeB1mJR07V4v
 f
X-Google-Smtp-Source: AGHT+IHFEOzU9Tg4swhd+twq6hRB7UvutgSNhHJxmwPp3XpdY3d92zeLvbYD805AhfB5jiFLMum8lg==
X-Received: by 2002:a17:902:8eca:b0:1db:53cc:1b71 with SMTP id
 x10-20020a1709028eca00b001db53cc1b71mr19682143plo.45.1708634666121; 
 Thu, 22 Feb 2024 12:44:26 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexey Sheplyakov <asheplyakov@yandex.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/39] linux-user: Remove pgb_dynamic alignment assertion
Date: Thu, 22 Feb 2024 10:43:23 -1000
Message-Id: <20240222204323.268539-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The assertion was never correct, because the alignment is a composite
of the image alignment and SHMLBA.  Even if the image alignment didn't
match the image address, an assertion would not be correct -- more
appropriate would be an error message about an ill formed image.  But
the image cannot be held to SHMLBA under any circumstances.

Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3f1ab4f69..d92d66ca1e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
-
     /* Try the identity map first. */
     if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
-- 
2.34.1


