Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58115C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZF9c-0000Ss-0T; Tue, 08 Jul 2025 16:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDSC-0000my-EU
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:54:15 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDRu-0008KT-6d
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:54:04 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so942903666b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752000792; x=1752605592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzMk4UkL9eAVR/vohhIY8W6V8rBUqTGnnCp6qj1rt4I=;
 b=WVwzVda+0O28zYWGIYe/tlWu3bAW5AWJrlG4JyJ2zpo2+fuIYE82mBy+rsb/isrBKg
 er0zMiDuS5V8p61LX95GY6N5sn11jvUXql8EqpPWwFBoZwPb5przyE3IkIK7U6RIJCkP
 DvRURcaw/ap9BiKDf/F8NYlS1i86JSZEjdNWMq66nej24IRr92V4wq+7hYQWeM6Sdp6Z
 otfuglvf4oC6KYrKDpJUDDjRU0VoGSMQdccXthlCjushMRbB2W5YvksdDDqA7KM+IFxm
 2fKUS25XL4NJN4b9I+XIqG+2bIoFjrWWWjO5h410ovCbYMboZZH3pHZm0vGYvgz7U1PJ
 yOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752000792; x=1752605592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzMk4UkL9eAVR/vohhIY8W6V8rBUqTGnnCp6qj1rt4I=;
 b=QRj/Q+5zviEByERjTB1mC2hEHUjYCvKvkqJ1FNQuD0YnzNZeTBbSspnrrMvQbCF8Lc
 tjLk4tIaNURtnmFlgAFsIAbEqJjksCNvJ7u13zmcWIi0EbgujZoDaLW5/13p2zegFzfD
 uhnXoAjy20ziJt+KOCVnEAqQpnq43SfgHhdliQmVj/qsbZuiJSO8UE51NXjm4Uu10QxS
 dUtvkHSp107aY6C2DUAlK6Qn0swJX8tNiafIp7FQCnqfG8UPl6dEtPdIOj+ss819l766
 Qg+GG7qQDoTpa0DTRgIuSRWDeXZGQKASQf8mUZf9ikdFuGnRwJa2Oh+EJkVt44ewCcJi
 hLWQ==
X-Gm-Message-State: AOJu0Yysg0NUsS+BROEDQwm+nIxD6awvbHsmVtCAZUrcN8PDB8OnDOZw
 kaMYPnIVcFjhiX95roxNWOFvZvlXKjq+0BPC6e9CNdlOibNQIuCR8f4EsUs3iwuoH67wIp+VJL6
 lBKmDuBA=
X-Gm-Gg: ASbGncugTkFRNuEXsXyod7SlaltcspagiWyNBCp9ktBNWsMjt6yHN2muSrA8Oe5r80X
 JQUWxrylC7HhtGUjp6Yi/bD+FBhg5V1qsg9aRx62REU/hWjWKNnnJT9upOXOxKUBGFFuzb9dRcK
 CdxJaC5HEM2gcqH1feOHmlF4KiJ/sDrXiLIOHy5lLXhMuf6ShFkznRfyKy+oXZZ06D0tAE1l39o
 SkwdlhuVJIYPcqQ0NS/KNKgSJdLXphSnpYYuBM3+c8TDCT4j5BfX1DhZjwurEbyBvpLPEQb1u6G
 xAoJI2pTunIl4lWm7JUqJnt47RN3rRIJxSbqyYBKYh8jAljbulsFsZDXR8/c21dbFfDoNQz5cZh
 tNP0dJUDZ+H+LUtMw6hspRj0rKsbSzzlqIj66
X-Google-Smtp-Source: AGHT+IH9Eb2xgLOM5u41cB8jhtceXkQMJqP5FOYGPVh9MDn7UCU3+96j99E25Ti0s3sN3hniFvGY6A==
X-Received: by 2002:a05:6000:2187:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5dde3f94fmr1899037f8f.12.1751968673235; 
 Tue, 08 Jul 2025 02:57:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd7e2f5dsm16264625e9.6.2025.07.08.02.57.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 02:57:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] target/s390x: Remove unused s390_cpu_[un]halt() user stubs
Date: Tue,  8 Jul 2025 11:57:43 +0200
Message-ID: <20250708095746.12697-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708095746.12697-1-philmd@linaro.org>
References: <20250708095746.12697-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Since commit da944885469 ("target/s390x: make helper.c
sysemu-only") target/s390x/helper.c is only built for
system mode, so s390_cpu_halt() and s390_cpu_unhalt()
are never called from user mode.

Fixes: da944885469 ("target/s390x: make helper.c sysemu-only")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a4ba6227ab4..6894f0a2569 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -246,16 +246,6 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
-
-#else
-static inline unsigned int s390_cpu_halt(S390CPU *cpu)
-{
-    return 0;
-}
-
-static inline void s390_cpu_unhalt(S390CPU *cpu)
-{
-}
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.49.0


