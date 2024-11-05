Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961A3D2B944
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzM-0006j7-Ad; Tue, 05 Nov 2024 11:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzI-0006ge-27
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:00 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzF-0007OK-7m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:00:59 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso5244401a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822456; x=1731427256;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyCrwL3QUsP9ACprYAhuYoLh1NHjzeMYZLQmtIO85Lg=;
 b=dHbsWXwdFKash0sWTIlyqDtuDHyM5SCenig2CiFfiTGVhhgvMGbaKO8P+bfGRyrZlX
 SLR3f2ScRcpEyexllDU3nf/jLOvHBi1bvNCUbLaSmYiykm50icMkH+Wn8vp9XvGwzSsx
 emm7NwZWFyTy1iTM5aQcjfO/3myqM8frj/qqb9sGwAoBct1NJXIqydq0vulxuviPNKSt
 eGn7eg1pH8kmyrG3h+/2Q9JsOueHe0c92d1T7156g8TIe5/2lLghLNfIkDnkE7XK+MRd
 DRmv2P5dzTW2L3woe/vRpsKIOxPVD3b4DK4Barf+ml4HoboZCkGK+FLApmZXoEndN8WK
 7SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822456; x=1731427256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyCrwL3QUsP9ACprYAhuYoLh1NHjzeMYZLQmtIO85Lg=;
 b=xEMlSiA+QzxPmHoYBTEPh6jpqTm9sMqxWG4tNvIkNWiN97Zg9v5LrQs/IeBZ4Mrrob
 tzZgmrludRv7PL82vFIRvGg/MEifcrpulIYgXPTvi59usWvJ8MThckwPemmQnFU050b/
 5/VJgibIuEVQgS1qqmUd9M1vtEQN22id0W8WC9tf+edUgTDYBmjLE1/nf9MROIpdWop4
 9DoZS1AVQrcjFSCCYY6STfHhKGp9Xn5II64uff0JeuTQao9whmdE6Klggo1ThOd7k1NX
 DRxYoMmxVnJChXPbmWVXwUbrDO021aAEHucNL2Ln5YFo9pyWApeM0466uRMYdOqtuN0m
 LKNw==
X-Gm-Message-State: AOJu0YzyJxEyo3wVZxVLMLuQqLKAzqjxoPgEfQXkfufe8CB3isRj/dpr
 bDhVzNxiQzCdePoOTdb9OQB878aMqnjWpTBgBkeJiZSB5YmnuZGTKEbux4rDKSjke5RAHeeUO6S
 FOQ==
X-Google-Smtp-Source: AGHT+IGVrjrX1vlRd2uG7oRQwie7RyQ5UOTKHCjgIWdFbAeyGVFShvSMO95vZxX6XL1f+wTeBj1FJg==
X-Received: by 2002:a05:6402:4405:b0:5ce:df46:7087 with SMTP id
 4fb4d7f45d1cf-5cedf4670a0mr4390457a12.4.1730822455509; 
 Tue, 05 Nov 2024 08:00:55 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:55 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/5] i386/hvf: Fix for UB in handling CPUID function 0xD
Date: Tue,  5 Nov 2024 16:57:57 +0100
Message-Id: <20241105155800.5461-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52e;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The handling for CPUID function 0xD (supported XSAVE features) was
improved in a recent patch. Unfortunately, this appears to have
introduced undefined behaviour for cases where ecx > 30, as the result
of (1 << idx) is undefined if idx > 30.

Per Intel SDM section 13.2, the behaviour for ecx values up to and
including 62 are specified. This change therefore specifically sets
all registers returned by the CPUID instruction to 0 for 63 and higher.
Furthermore, the bit shift uses uint64_t, where behaviour for the entire
range of 2..62 is safe and correct.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index ac922d7fd16..9d9ccaa815d 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -119,8 +119,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         eax = 0;
         break;
     case 0xD:
-        if (!supported_xcr0 ||
-            (idx > 1 && !(supported_xcr0 & (1 << idx)))) {
+        if (!supported_xcr0 || idx >= 63 ||
+            (idx > 1 && !(supported_xcr0 & (UINT64_C(1) << idx)))) {
             eax = ebx = ecx = edx = 0;
             break;
         }
-- 
2.39.3 (Apple Git-145)


