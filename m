Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D33DC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauB-0003RS-T9; Thu, 28 Aug 2025 07:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau9-0003QH-Ih
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau7-0005nc-KN
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so1635045e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380894; x=1756985694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8ZNqyB7lsPlVBv6H+81X/cqv1r68vjQ/+0ChB/MUWw=;
 b=QtOqieXKFBOyrQTT4mE9MTxpQe1bC23Pzddz1J/w1MVAb/vt2AO39Ou7zvCZsgYHdK
 zwxXi6XgXKk+01zNn27GXVx5rIFxuBLTtZ3x3Rnu77Oo1JMQNp24JOcui67vpRfI+mEq
 Y3LTcXa1hCmOEKTwP4tW6UZppYbR7jm+M5nhcATUxzp3U5WLQnWtfEPqrJ7hwjVDV926
 pl/DhZD/MY5xsAHrsc24g/gklE2kWqH6pFFEm2QFrrCgWq0QRXu7/1jjWRWybDgmSHV3
 HCIzkZS58gQMKS7/f55STsajY6SX+JPvIcF1GgQ1NLwt1ZgWbg8Bfxwea24t1WwMUUU2
 7azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380894; x=1756985694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8ZNqyB7lsPlVBv6H+81X/cqv1r68vjQ/+0ChB/MUWw=;
 b=ZkaPxXghyMwUhpJrhuyjEwZAMrfJeoAlvw+r4pnGcZopaDsjQV8uDswKk5YU+llQKf
 87tanL0+xywaLVd+gF80YDqKwNklb7cxvbcAIFu2DjrlkDqPk8U9ZyXdH/fTo5OAla1h
 v+iCR6AIvKPFpZ9m+8HC4tXhOq0NdNxR/azUr+baZjPv8V1g/KTgLGtYudS6i6a2peHX
 QKltBGBcXyLy/HKUcFL4fbCwTrWrqtL+JY5OXUe7MGfOIoJYl5sTVA0fTS7+kzLCv/yU
 XMZfejTMdprKihZR8B8M6Fli4EIAYS9Fto5mOmF+/RtZ3CF6MUKPIKMxAQ9jlQohHc3R
 lETQ==
X-Gm-Message-State: AOJu0YzMM9b5rIlbjakdYbJAvw31ANFtHPQF3F5wCi6WChzcb6H16/rV
 U75pw82L/cVzu+Hy4atOPaaUjenZGI66pV//vhbo+vnacXFBXjX+ykJNJGQzxK1xs7k5ZbThDGe
 WT++u
X-Gm-Gg: ASbGncsWztikqdEeq3xaSPzaUgVYd33Qp40Wdr7Z4nCpyqjUVu5oANODfAR+pJT8Go+
 B7X8OASHXspWpbuFCuJv6Nrni/6PKex8Y9/PPBjLwStc/8peu/xQga8JosJ/Iwnv6a9nt5AVGew
 UVS7yyyTJMacpIdad1OebTgZfzQx2U90ukVfUZENySyM7UW4BNQTIgMwGfUYpPQV6p+R/+tXU2h
 keVTZ/XT4SkfSOeA6CqIyPeb5g42oHDXqfStvgckZZKz2ERZoRvpBrillrYxfYZflz3bm/ZyJCg
 U4yrxzbscRSuiW1iybehkQKH0FEu3bg1LDeaRFVuI8eosOqvNfeFc9rzXd5mlomiWEVlYj9kFZL
 HIWyeZoX7Z37aIJ8HlunbTkVflUuIk9BGQ09bAJI=
X-Google-Smtp-Source: AGHT+IEr66z4VQ7ZP603hU4wwFW/8y3EYgOXvV5n6jhuOySDAlFj8leRA+7z21JWR0EyRbNKiJHkuQ==
X-Received: by 2002:a05:600c:3b26:b0:456:1ac8:cac8 with SMTP id
 5b1f17b1804b1-45b517ad6c8mr196830175e9.15.1756380893735; 
 Thu, 28 Aug 2025 04:34:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] scripts/kernel-doc: strip QEMU_ from function definitions
Date: Thu, 28 Aug 2025 12:34:16 +0100
Message-ID: <20250828113430.3214314-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This commit is the Python version of our older commit
b30df2751e5 ("scripts/kernel-doc: strip QEMU_ from function definitions").

Some versions of Sphinx get confused if function attributes are
left on the C code from kernel-doc; strip out any QEMU_* prefixes
from function prototypes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-5-peter.maydell@linaro.org
---
 scripts/lib/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fe730099eca..32b43562929 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -907,6 +907,7 @@ def dump_function(self, ln, prototype):
             (r"^__always_inline +", "", 0),
             (r"^noinline +", "", 0),
             (r"^__FORTIFY_INLINE +", "", 0),
+            (r"QEMU_[A-Z_]+ +", "", 0),
             (r"__init +", "", 0),
             (r"__init_or_module +", "", 0),
             (r"__deprecated +", "", 0),
-- 
2.43.0


