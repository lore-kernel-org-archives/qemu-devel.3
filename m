Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E0E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSz-0002Ii-Tw; Wed, 11 Dec 2024 11:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSj-0001KR-Sw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSh-0007tW-Vv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so69482675e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934078; x=1734538878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EDkpBBfEr+kYrGwFggLG/G/iyWn141UY3RpqFYSFXYw=;
 b=klx1dFC9ul4A6G3k2rWIk7sSgSDcxcYfQO689lQz8UYWpikXkNiIig9TnFMayJ3cFr
 8kRv2ZvCaSexkWPApOC0dUPv5TXIKha9djnSiKlLVsO5buycbzfaTxkqKagPs6lFAQNP
 zH0uI12ir8py2j5XfCHiaRgq3xDUudI14enSNQXJyuFFcxAii4bG1lwEKNtBd0+HM40b
 4Xz8D0xOJz1DtIxo5f7iDqAP9xBJAulMC0duE7tNHjgEtXMZaTGuyUsUm+lYHL9W7kKy
 OHw7nT8/NBwjPVjhmgr4m/AzfAKRq0v7bTP7kv/JXRSs/M/27zK1EYrBD0SwsceukfiZ
 iY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934078; x=1734538878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDkpBBfEr+kYrGwFggLG/G/iyWn141UY3RpqFYSFXYw=;
 b=wDr/9IqGlTQqozG8Dj6hutXU7VLZ2uOZT2FagFtlKV9ir4JPAyQ3OhlXkD60qpuQGb
 hCMsg9x/PPjJ3sEJrWzDnT79/rTtl75QfHHHmF82bYn5me5g7sJVRZL1igm9z/N6wtuD
 /gOjayCduFeIK7GWuKOn8Uk/kw6XqJ//D+4rVAhPSh8H44DZ8Aaa4SIawkWb5Ws94WYF
 BrI4pST2D6VkJ+GMUj8Rr1xtBREJVeUbnwiikva0X5jIirstmALvmY09lLZKXc54Jsa4
 NiSJ5dvrreMi+R1N+YbZOIRjvF+3u8r3UzCgMOw+sIMfdZDIs6znoB3SQN96vPJ2nu+Q
 jotg==
X-Gm-Message-State: AOJu0YxA3hiQPoNu0zGL5BuqJJxX75c6cMMySUmaYLgFlge/CuQ0Y8wv
 XEcDO3AcnDgw1sl4VO+LW09Lf168sjfVETErZ++4nC/r8+tDVK4UARIbfL0rsRdRsgLe5GtBFSX
 h
X-Gm-Gg: ASbGncumXP3uCAiLmmEXlniZ80kmrLU+4bCnZh2YytARrLF3z3Ao+Wyq41rnZbiWdru
 vAQijd3dFeANa9aY8QZSL5TVpVBqYMvn9CPgCE9tiETPq8UM52k6NbTcQYo+yKkqxL1yJiQztKI
 dRjccsl6d/Q7aIr+9sSxWDR6w1q/Ayur3JBT++DnVE4DB8WAybAj9Z3oPd6f1DsyM3jvVGbS06Q
 vRP700Sf/5OWwuoBhfchSV42hhzFDBJG/XckWQuYPfVInP4O+WOdzyop1PB
X-Google-Smtp-Source: AGHT+IEBh7JDFK4baUzCNTc44sra/iizHxCa+p1nG9iADdYhnx55x/ba1xQzaTyvcF4fwWsLzjdSWA==
X-Received: by 2002:a05:600c:19ca:b0:434:f819:251a with SMTP id
 5b1f17b1804b1-4362282ab8emr3245905e9.9.1733934078582; 
 Wed, 11 Dec 2024 08:21:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/72] softfloat: Pad array size in pick_nan_muladd
Date: Wed, 11 Dec 2024 16:19:56 +0000
Message-Id: <20241211162004.2795499-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

While all indices into val[] should be in [0-2], the mask
applied is two bits.  To help static analysis see there is
no possibility of read beyond the end of the array, pad the
array to 4 entries, with the final being (implicitly) NULL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 525db617411..5fcdbc87fd7 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -106,7 +106,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         ret = c;
     } else {
-        FloatPartsN *val[3] = { a, b, c };
+        FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
-- 
2.34.1


