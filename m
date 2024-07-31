Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E38C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARN-0004lR-O6; Wed, 31 Jul 2024 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARH-0004VL-Vv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARD-0002eC-Nx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so6298255e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436581; x=1723041381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqmrBtYb8ViR13sxNlTUjriTArU/8ikLrSiXBCb4+9Q=;
 b=P0QOKp5fkTNMmBU+g3UKBk1cLg8UmUMzqt++z1mf62smXFZNA0CD//fmkBYSKa/Aqs
 2TY/9mxuG/MSC8zimFACc4TQ8VC4mv2Jefcd2Gy8JANM0vg1G5EFUBzODyNZkBGnVxE8
 hS1GxKOJQQmIzn9G1wnwTi3Hrs59W0gmTFnfp9xiTRlhmvJNzpscGpxJT7uGoICt1R25
 sTgreOWLwXK18peHomEAgB2ZvYADlpQ2SMH9EPO4Fzz4+Qk68Q1JQ2O9Xw9EBUTe6tCs
 SbJb3/6zavgb5QrNHcta0Bb2neWX6638obOkhHuthhE+vZHWvWODkXdFbhWjLJwguG6Q
 6dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436581; x=1723041381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqmrBtYb8ViR13sxNlTUjriTArU/8ikLrSiXBCb4+9Q=;
 b=lYwqGW9Wzbrp+lK86/Kboqm2lKR2+5NCRkHplOmcfwz49HfD1KkF8/AGr8xx/G0BiX
 /eluSSFYXh5JAQmPbu+m1dDXMqpVoY2NXXGpiTkgQbOgL+YhSfjBg6KlRRpRwC39BzpP
 YRAvPfuBkvgvXXq0tn23C8j5hcKgAS/ru2a6f65OhGxuaXf33n3cdzJALSUguxfl1YE8
 0YsqmejkDR8ZQEMqUhQgrlCUC/OhO4H055UMHKGIl/2t3YzakbB0AsyK/xw+s/xYivhD
 +mjrfMlgmiW+Yggh8Z8N4yLamO2GqCxpFj7v+Y0Y+RXaWFWCFqtL2Gn3cyt1MZm9MoME
 mN2A==
X-Gm-Message-State: AOJu0YygRp1KTdFUZanSzdsb0a3KvmlS09v8yXH7xaMhv4pjkKpB6xaB
 AGhXfzT2+gWOVS8wGxpXvsLiQfzFJEXGfr6XN7s6VvlTbz6E4sfRND4Q/VfeLejAaqK4sJc5HWr
 i
X-Google-Smtp-Source: AGHT+IEtiVN0DM+ve/n9wSITlXRKO/G5kfu3YXSne2swaTnggBpLftRGrMeemDnnl8zRtp/caLxj0w==
X-Received: by 2002:a05:600c:3511:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-4282440e013mr41987455e9.9.1722436581281; 
 Wed, 31 Jul 2024 07:36:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 4/7] hw/ide/atapi: Be explicit that assigning to s->lcyl
 truncates
Date: Wed, 31 Jul 2024 15:36:14 +0100
Message-Id: <20240731143617.3391947-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In ide_atapi_cmd_reply_end() we calculate a 16-bit size, and then
assign its two halves to s->lcyl and s->hcyl like this:

           s->lcyl = size;
           s->hcyl = size >> 8;

Coverity warns that the first line here can overflow the
8-bit s->lcyl variable. This is true, and in this case we're
deliberately only after the low 8 bits of the value. The
code is clearer to both humans and Coverity if we're explicit
that we only wanted the low 8 bits, though.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ide/atapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index fcb6cca1573..e82959dc2d3 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -265,7 +265,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
                     byte_count_limit--;
                 size = byte_count_limit;
             }
-            s->lcyl = size;
+            s->lcyl = size & 0xff;
             s->hcyl = size >> 8;
             s->elementary_transfer_size = size;
             /* we cannot transmit more than one sector at a time */
-- 
2.34.1


