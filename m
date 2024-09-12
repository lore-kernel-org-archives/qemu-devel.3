Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E0EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodie-0003jZ-PY; Thu, 12 Sep 2024 02:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodiA-0001UK-2t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodi6-0003WN-Od
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374ca7a10d4so436770f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124025; x=1726728825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8JlX1hTCmbpuUkyTy+jdA1DfHzPSmi+/XVGPIHJ48I=;
 b=vw3wAXP8YyzANzqGEgQrOwiwgB31HJpXKWjseKvB6y6bIkQBjfb4EK17i7YFtwXodI
 9YMwilQxrFaR+RlaPhoguLtZid9DhRgOmRRMOSG3hsm9IH7/44jhNtvEtO00dMOeRQ0p
 HzioYey86r0hF7TBeU/FzEVKwxUAyxVtR17IrLBm9ED3sW5rWtwCSxi4EmeA2BtZCUJd
 XD7diH0F16jGv8NGGQ0JSKFtGxJlSRXhn3CG6Um73awRniignheZqDamBYKNKgPNgik9
 YTigqKkQvZ1qy0AWiSKluFyq/uX7b+U0A+4nJgTBP2ttKVJw8691y418+LWb9XOLo2mt
 AFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124025; x=1726728825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8JlX1hTCmbpuUkyTy+jdA1DfHzPSmi+/XVGPIHJ48I=;
 b=JkpsLV8WxxnL0TFoPXaOaFP8/zSxzabgcMzKhduBVUDu5jKx/8bUx2wpoDjg0X7Y4U
 fKORvjX6nyBs5dIWqvRPX0+TBjEpOSlJdJiq2sdMBslrYiZt7YIbPYoXb/HqdYQaNA3U
 4sVuFmfHd1OjPWzsvO9hNaMrHN+J1LcSN5xpTT4KYuGofyVxyFWE5/w3U7E92YFvQSnS
 CnQFxoiPR/3i7VVeE62g6kGMmI1/GvFEyjcfZnUPOvQ/GRRJEuz7ttjNun26N9RLUIyi
 JAouCq99mdtu7Azy94K2G5Bw5NI//2VCrzFFsDilGg0iyjomSJhCuub4bLs6NJgLr8UA
 VdjA==
X-Gm-Message-State: AOJu0YxZxvGOKXoaVNmauOix934mCOhg+MPm6+WgCjLMAXf/JVPwp0me
 Q57c7KxcjriY2WmDWTsAPhpb1r3tIXt+TA1QmZ8QizgR1INrT5zDW6Erw/pVyiVib9P3FGWFCWa
 a
X-Google-Smtp-Source: AGHT+IFje1iHjYQRayee5IXKWbieCnQTeMV5uuBMuNTGI4ioXw7aZ7eOs0b0GJZpjngZdOjXPZJnhA==
X-Received: by 2002:a05:6000:459f:b0:374:c0c5:3c05 with SMTP id
 ffacd0b85a97d-378c2d4d802mr923227f8f.42.1726124024412; 
 Wed, 11 Sep 2024 23:53:44 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956650fdsm13521670f8f.25.2024.09.11.23.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 61/61] ui: remove break after g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:27 +0200
Message-ID: <20240912065227.67848-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            g_assert_not_reached();
            break;
          | ^^^^^

Solve that by removing the unreachable 'break' statement, unifying
the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-37-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/qemu-pixman.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 5ca55dd199..6cada8b45e 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -49,7 +49,6 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     pf.amax = (1 << pf.abits) - 1;
-- 
2.45.2


