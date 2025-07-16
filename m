Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13906C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5vj-0001nx-OX; Wed, 16 Jul 2025 13:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vd-0001iX-4c
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vb-000087-Cs
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so62386f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752686901; x=1753291701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvMqfwhNEUaAbyBTg3ZU/8Yl+gwZdDpyb6yyXj/6hXQ=;
 b=iwuRCXFRw/tt5MDLDAhuz/Myp6KecDaKVwyvBDHW+SnsFEF3iU34qCKlDUpzOxN1Zj
 5wFrLd5Bw5MFtOhYorjZcjTVu1KuYM7PMIOkd4SfuCYKmGlqK4QrUxhPwLKdUvOmlJbE
 wJC0Wk2TCoIGt63gWKo3wj3sxsEbv3r7HHRvAZqbKObD6sTV+zOuKu7DlxzuZelmyrc9
 avX6zrgM3SzDHyXcEwXvtgwXF581/5nHu4RaXGloFYJN3JoDvn8wc3k7/Bsz1DqEf9TD
 1H6KgPzxwh1W5vcaeitnsu6OMgu/veWn+s/ffkuIU9dGlHhpwPNQ2nA/IlUmr23O/xwH
 H7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752686901; x=1753291701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvMqfwhNEUaAbyBTg3ZU/8Yl+gwZdDpyb6yyXj/6hXQ=;
 b=ZTMOi/q0/YOXD4DT4vc2+rqK6kUy4Fyd5Mr/efmVWjtWZA0OhOok45m5OsQan+dqIk
 GBtjZJdgbA58noDR0RPCDKmXv/eiOunhKGGsYXDlAuIptmkX+/2aJszsZbPAu2NgiuiC
 3jQorpHVL2BQVyfPeX5BvxFa4fOXbXCpSWPN7oYxdrMOCbg8rx8tEmR634MzPTCt9uAT
 zavctNQx4nmz69bkIcVaHxNI8AE+75akgJc1qtvkdX2PVSWSvLmFO2U4RA9jIN/ah7y7
 ADC6M6sGhsqm7/u45/hDzn6t5sCkR8qPJluKHT+j0TuJHlQDXwG0I5mH6EhTnh1RYJfc
 JRWQ==
X-Gm-Message-State: AOJu0YwI4r7BUY6UObWaF5o+ocSOA5CnrH2+yxDlrHjkAu1mb+Xcr6DZ
 pb2r0hPyAG6q2MSbVbi/ys6N4PjU6QJf9n9MagxldKh9uZo9zqX/kH82BRJZNqZDPkrhZ2CijGX
 q4E7u4dk=
X-Gm-Gg: ASbGncuRvgjCAG+It1SsEuPmiEWfd9uW8I3Uqp4CpAy+XLvIWfgx0IkRs2czWomMgFr
 T1reUsrqyNjzDHBWgPkPczdCggK7D/YoOvmaAiqTFLbo68cE+wHiwmRfNTe9yxVRW0n0C7a/4Vq
 ovJKAMNuw5j877LKfYfy5ghXxHczYoHm4fAbcB5NqxXx3jjOMW2KPD5280tGgxZykauaNcAr/GT
 H7BzoVd/KKKbV7SwdOSAXAvpvLYimVjiouQYAesyFTXnaVIoPKoAATrE+deWy5duczlxUAFNBCC
 SREwKligzflhWwCRHYAQfB77ZdUNznKagvZGE3w9zNnwkwRFSXyCKm/h7RaBuGOArqwHAO+3GMx
 KLtfx8SKcuI8UtlCh7xbHTxImpan/Xm8IB7QqA85kA/PEd+4LfLqNJnMzuT2+jRHa1Blr7DZWKg
 kZcqT5PAk=
X-Google-Smtp-Source: AGHT+IEySn6a4TwkwiHvZsCcDGfvrS+Pq05mAv5J6DwrLCGyKDFZtWtTqsOikgNI0LL+aO8PTZe12g==
X-Received: by 2002:a05:6000:43c8:b0:3a6:ec1b:5742 with SMTP id
 ffacd0b85a97d-3b60dd4f78amr2806114f8f.22.1752686901040; 
 Wed, 16 Jul 2025 10:28:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562f7514afsm22412785e9.8.2025.07.16.10.28.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 16 Jul 2025 10:28:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-10.1 1/3] accel/hvf: Display executable bit as 'X'
Date: Wed, 16 Jul 2025 19:28:11 +0200
Message-ID: <20250716172813.73405-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716172813.73405-1-philmd@linaro.org>
References: <20250716172813.73405-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Developers are custom to read RWX, not RWE.
Replace E -> X.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e67a8105a66..0a4b498e836 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -84,7 +84,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
                      flags & HV_MEMORY_READ ?  'R' : '-',
                      flags & HV_MEMORY_WRITE ? 'W' : '-',
-                     flags & HV_MEMORY_EXEC ?  'E' : '-');
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
     ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
     assert_hvf_ok(ret);
     return 0;
-- 
2.49.0


