Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E034C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79SE-0005A2-OD; Wed, 15 May 2024 03:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rz-0004eN-RX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rh-0001c3-7n
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-420104e5390so38425355e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759583; x=1716364383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43VCEYELAxrkckI6OKg065TP0NGfyWvRiJUBmPu7X2I=;
 b=CfItn7JY1qh78aeiNtG/V9EYg7a+CCwaHLgOxZwCd2AlP38JH2J/nnqlTszZI0bqgM
 xH4vdTB2PIgHN/8Qma1r3reeByT/1GdG4F676hPCKNxtdnw1fr+NJ+bUW6zAPp37ymXG
 KKpvrgo33nizWO7BdevC/VSit5rJGZeI2lOM9LUpJAImQL+UkPiqG2P2OZydZcD6NM0R
 fmXMFjcXe7mu06xo59qaic0nvaJoxOZUCh73CBTcWEPt1X1f+ZpDJ5LBY0/x+mc1VF5t
 On+CNCYPxKDVAiurwCJ6Y1bKh+qoAwPbD7tTFeAFETa6R3w7FJPo2UTo02fOcyocuS6w
 rFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759583; x=1716364383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43VCEYELAxrkckI6OKg065TP0NGfyWvRiJUBmPu7X2I=;
 b=SpJdaLaqD1d8KRO1mm1ELAV/CZe9ieZzbxk6DUCAr0PQRrvtfZCTrdhp8J7eljR5QY
 Yr4zIJza8vJpzx0TdbVZngjVbCqmo5q1WfruVmQyWHFA1UUiyOopL86gB3bmcnwxwLJZ
 wkOBtlkf6HUrQZlqbIaDX3zc3mJHdgx6FLYQLyNkAt3ZiCwUt8gD06TWbw47oqB/nNlY
 QlKuuz7isQCaXuhshhKb0+XMYCeS8ZTLhkfykN8YkUi2KtMzUEZlNeaiO/26eOEUT8Bu
 70fdINySAq/l64V/7aebUX3u6Z/mnxFzYUnCNCBfxs/tnQwKtIWkZlcbHcURLTzZpmzL
 RQjw==
X-Gm-Message-State: AOJu0Yxm6bAnmriHetaAwXhhuyoDJwC2ga1K5RcYC3Yq8Qywb/q4S3u7
 JrvHPnjI+voboAqyHnbvOKADW2Ak3zctAXbxbZT4TSwlb7/vAk4qVbZWsrQ6LJ4QzTWTBTEyh2s
 7Mfo=
X-Google-Smtp-Source: AGHT+IHVp11SrtDALob74MSW09TBemqyEDquHwG+aUpNHhUcPPfU6Us9Breavb80XpthzVx/Kz9eSg==
X-Received: by 2002:a05:600c:4707:b0:41b:edf4:4071 with SMTP id
 5b1f17b1804b1-41fead64731mr137083725e9.35.1715759583648; 
 Wed, 15 May 2024 00:53:03 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/34] target/s390x: Disassemble EXECUTEd instructions
Date: Wed, 15 May 2024 09:52:35 +0200
Message-Id: <20240515075247.68024-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/s390x/tcg/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 95d4d6ebc3..bac033c63c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6525,8 +6525,9 @@ static bool s390x_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (unlikely(dc->ex_value)) {
-        /* ??? Unfortunately target_disas can't use host memory.  */
-        fprintf(logfile, "IN: EXECUTE %016" PRIx64, dc->ex_value);
+        /* The ex_value has been recorded with translator_fake_ld. */
+        fprintf(logfile, "IN: EXECUTE\n");
+        target_disas(logfile, cs, &dc->base);
         return true;
     }
     return false;
-- 
2.34.1


