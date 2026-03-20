Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2321098781
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZiM-0006dq-Ch; Fri, 20 Mar 2026 09:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhs-0005v2-JK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhp-0000M7-Vc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:03 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso211889266b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012560; x=1774617360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIz9gW23DrBUaEQreL8nJOWSO/UpZAg23ZESrVKKT9Y=;
 b=Y1Pb5FetPbGxEhiWBIrs0G8Op9wchqtAMB0wrqIadaJsKdJyetnC67bsqF7+ib1/L9
 48wdWubzD6vWO5nKdz4z50ZwPFQ0yyfIoXnMucHBiJHSpIjxd6SHXdhTkSfNxHJDlQiN
 MgkQ9PwfHVLNKal55NjAH+9Zcnr7pT0Op3iZbWQ3PswRaqsNXAOIXvURGdL8x38QsXr8
 taxr/TKmgZ/k6zPLMbxhqEvZuYIyfyEYpb4ZAb2bTdgtGv3P+nIoKO+XlUw4dJtHaAIC
 CuNqMNXmN1YPvF/RzzwUEdfYfGJrQd3Iip0izE/NuDy0nfon85B/O8H7a/U9hGA6KCI5
 qOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012560; x=1774617360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bIz9gW23DrBUaEQreL8nJOWSO/UpZAg23ZESrVKKT9Y=;
 b=RQtVhSt3i/LtM1Yu6Q/mdCQuKj+VFqIvEciMLtpSB6eNnibuu70mnrec+SzJS0Ir/u
 L0GDfm4trc1mTtPnQ+Q46cMZ6tbBjCZQSh762NTshLZ4K5d+ClT4v8EcBjYiXbkgdxCA
 OVDna8UCGgF/Z4KqxLzI26/pN1VqZn6Nxs84SLZNfJevLe2EqbffOFyH0rhyIGFnD45z
 2h9blEvaTDM8gCzPPpBZ0bFm9dAM00QgkbFaMN2jMzmufsBy0PEn2mikIiM8RWvRMvMZ
 5KQsXUhAG0CjIDlSKj7wNDNMzNWIRyZEKu7XhQOKMzT+KQcDEmhzT99A40qXhc00CRea
 ecSw==
X-Gm-Message-State: AOJu0YxFOSGwLcgV+4pgqmUQOnnSLj0tAi9MbaAdJtmiz32xSWI3eNsv
 NWphnBdgFG/2dblk432wS8hWlYrrzUjc/KBQ9zpsBYh0qoeru7FuDhdSkC1kx3GVixY=
X-Gm-Gg: ATEYQzzrdgPACiQG3vQj4qJxpZLyVJ3Qc41OlOZZu4COtLCHrjP1Kv9OrNoh3yiuE1Y
 oZO27u/CT+ljNpsQ0OtscZL6srCJRKOJSaUfg9f+F+Ep0UNzN0pE7SeO3HHvfaXmlGK7yNzpxjg
 hHcsiD7u13mOosoqUATeMFPRJFwfcBHFWYFxlMM+0Fx8UofFZ/E5gIw9ZYDr5TN1utUuUnA+RNT
 Is0fpkgUrIJdoPsZ5vbgEoGc22xG2eU/HoJPIooXeD6w4dXd6bCuN1Y5w2HwYOM0uGdBfC4Jz6c
 n/DnmzyctNA1+BEuxggyGCDKM2FUnpiShpKdV3HtotgvWhYSoUcoBSxC6s5RYRCuoHpdSMP/NIi
 oxvN/u8OOSI9C3f2WjlmVclyk0t3mhLXu6s9cef0L3YoZjnzgYhtYN2eoFuxm9vDxpSEWcW45GV
 X79ffFnm7rGbCAFTPGcIWM62Q=
X-Received: by 2002:a17:907:da4:b0:b98:44b3:7e95 with SMTP id
 a640c23a62f3a-b9844b38052mr33210866b.40.1774012559958; 
 Fri, 20 Mar 2026 06:15:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43b5csm157132766b.1.2026.03.20.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 35E255F9F7;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 19/35] target/arm: make hvf use syndrome helpers for decode
Date: Fri, 20 Mar 2026 13:05:50 +0000
Message-ID: <20260320130607.2071996-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..1c1c31f0b15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.47.3


