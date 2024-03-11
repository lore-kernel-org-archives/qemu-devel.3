Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B404C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl80-0005Yf-PC; Mon, 11 Mar 2024 15:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl53-0003PJ-1x
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4x-0000Ns-4n
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41331166961so1665875e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184371; x=1710789171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yKKx3IOByUMeAMGSYuM0l0stWjxVzOikFpYz9umacLc=;
 b=CKAogRjR1/zANIGqogF7BS0hCbJyBf51vSWn7kuKGqETKdmwdaAaIhKTgOvge1EK+G
 ueceZAa0HXc/jF22wtAT9g1KSKFElFtNe3yvMoq6oaScV6t/PPiffERVa9dES03HGVac
 hlNUgxOC4jJmCuk/umuqf/iE29vLY4MiBkaGBr8Coa04KZlfCzRxc3pbceFFWaVdCwUF
 K+4hpPhuaDzOElvCxugFzPOVTVn8OHXuOSdEeIjTBrAiueMRhmOLcqR7QJf0w47PaBMa
 qcxmu7RAgVeuNKiJnSbCe2299lM5rHn9EKGhtkwY8aRMuNMErzQaSgCTjkfaWsIzleJq
 0Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184371; x=1710789171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKKx3IOByUMeAMGSYuM0l0stWjxVzOikFpYz9umacLc=;
 b=NmziGU5Xnh2nqskR/+ctkcuoJ+sIkBSgOfr9OOZfIRB/O8/xdJ7hwIV7bTU4K9kIPO
 bLUrM8ZW7HotLzR0SxcyBKxAN9HRtxnjImDbzTMgZNBI4cHwuIGnwaQKBk3xiWckxwdH
 xRdBINIjIsBcVDu6C1Nh90c9VSQm7PFGj81mxt2+2CebxJHGGP2ZWVThO/hoeKaCRpuE
 fNMH9haECq7zWgZ9DH2HXrGrGzqOPEi72rxv7VdXHDzQL0th/p/j5+XLWAbrBIxnJfgy
 bsgJ/GZ6JME6LyQQwWStpLtgFIjL676nBlaRdRas7SdU3HScdnduG05vqm83tRuFP5VN
 Iexg==
X-Gm-Message-State: AOJu0YzK4Si4NAdrEO1rejNz+B1eoaKUWbP0tSF9TIlbZuDI7VPRZTkW
 wdakuTrLLhHxiTkpPAIoTS9Xj4nvO0MVnbScCi7F47nLwDCE+IIkzIOHFmSPrxIFLnxkooXmBBA
 t
X-Google-Smtp-Source: AGHT+IGjga9VscIE24EwtSAb+HwGThVHxzA2jcWbqetdPuePYkOoa6uJ4R7t9iP6OReqePaYegKkDw==
X-Received: by 2002:a05:600c:6a1a:b0:413:1285:6e40 with SMTP id
 jj26-20020a05600c6a1a00b0041312856e40mr5673901wmb.20.1710184371490; 
 Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] contrib/elf2dmp: Ensure phdrs fit in file
Date: Mon, 11 Mar 2024 19:12:40 +0000
Message-Id: <20240311191241.4177990-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Callers of elf64_getphdr() and elf_getphdrnum() assume phdrs are
accessible.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2202
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240307-elf2dmp-v4-19-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 8d750adf904..c9bad6e82cf 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -132,6 +132,7 @@ static void exit_states(QEMU_Elf *qe)
 static bool check_ehdr(QEMU_Elf *qe)
 {
     Elf64_Ehdr *ehdr = qe->map;
+    uint64_t phendoff;
 
     if (sizeof(Elf64_Ehdr) > qe->size) {
         eprintf("Invalid input dump file size\n");
@@ -173,6 +174,13 @@ static bool check_ehdr(QEMU_Elf *qe)
         return false;
     }
 
+    if (umul64_overflow(ehdr->e_phnum, sizeof(Elf64_Phdr), &phendoff) ||
+        uadd64_overflow(phendoff, ehdr->e_phoff, &phendoff) ||
+        phendoff > qe->size) {
+        eprintf("phdrs do not fit in file\n");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.34.1


