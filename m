Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC4AE77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVT-0006QJ-Lk; Mon, 09 Dec 2024 15:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVC-0006Hw-J9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:10 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVB-0003FT-8E
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:10 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3e829ff44so3836739a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776628; x=1734381428;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYJPKkgcbTXxdsXMNMCRcjhKt+ms1PoytQbmmSrV3F4=;
 b=MSSrHX2CDFbQUas3w06xQuH9T1mlo9XqCRYGf4YhlI1fXwwiv9acm1GZ4Wr+Ps/Ts/
 7UwT4PvtlGC8H08sFOdXDPJ7jO9kiFHh9i8ahFNbfE8kMqaCBMMj1PjWAGm0aY27AKug
 C0+0ez6sNused4lLL0uAsW5i29pKMRky9Tpzd6Eec6QuesCtNKFXSTYXuDBdmirtUUIl
 eXeIcDcfkkz4U1yhOOMphXtAu3B9c5i06/s5rKi8q8rFFcZe6UwRwSD6F/qJTVWyexFf
 kmrsTW/RWyLd+teiK2Cpq638Eiulztr7anmi4+fuKjAMnpvlKbh+lnxiV8d/l5banm/9
 vcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776628; x=1734381428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYJPKkgcbTXxdsXMNMCRcjhKt+ms1PoytQbmmSrV3F4=;
 b=TVWPp6D3aSnBmLL7pv8NMylfTqipg6jZo70dQOtTgwUQ/h7AqfeHthQqRFWVMSBNU4
 9LFPakorZDZrHAdJudD0nz1yjBvOxJ+i8lW5TrwkYDAfiVCZjjMTWExThxtk+t0XNSip
 tjRrM48eQOm6RFp5+vVNlOOLLfoHpkKyiIo0ty1UKWkPJNvngBED/YrGfzHlMcRs548Y
 6QQ004jqzGkAf9g1M/0xEuPh+jCFTOE8usIwZXxeSH9/vke/PY9z9nWr3pjMqiPRCbnL
 6aKrmjEQ/6n6UKlM6rj259fuC4qlWjYEwxKhU4yzPy5U6R13HTSvv6etV6xPnlQS4kSx
 VcSA==
X-Gm-Message-State: AOJu0YyDmHRfLhNcOPabkQU/PLtxmXHb6u41UmrkElaza1ov4v6KKC7S
 8ZAZ3WTrKMMh1cZwhuTaOLSzFSWuxpDftfwSPxGMdqJXKJpC08yEgLqSFvje3AowDeGu6HmHJRA
 TYA==
X-Gm-Gg: ASbGncvJUeEGK6Qsds5A9JEtXSGadfLX+eE2+3S2jR/N0ajxep/VMgc45+w+WScN1bd
 WbhkFNS/nh9cizaWE6cK39auWcF8M73iRiMWAm8Qro2tfY+nUKEVSToQCvUHiOkHcJ/vft0UPhI
 MAcmieZABf7CbPVYvV8R/cYO0Zn9v7xk01lxad3RDczIINmkojXjmRYFp1RLmilRpoJeOLmQohb
 XJjQiTFjuUMOPKsIrLMJ6odRhxYn9cZlnC0xXihCClfzEHrAmBBRvIiyCntg7KoNDFNAiyQ6OtV
 oXtKVITUP2q9qaCrD0vHQE3m8B/EAg==
X-Google-Smtp-Source: AGHT+IHB8k/H2RYEWOrL0OQQ9Gp9k12FNItyZBOVZ8YhOP0e7vqWuWpx893ffQORrlO+5JsHVKcYdA==
X-Received: by 2002:a17:907:1c85:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-aa6a006e645mr65933966b.8.1733776627709; 
 Mon, 09 Dec 2024 12:37:07 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:07 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 09/11] i386/hvf: Print hex pairs for each opcode byte in
 decode error
Date: Mon,  9 Dec 2024 21:36:27 +0100
Message-Id: <20241209203629.74436-10-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Printing a sequence of bytes as hex with leading zeroes omitted just looks odd.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 6c7cfc820f..f8d37f2d53 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -30,7 +30,7 @@ static void decode_invalid(CPUX86State *env, struct x86_decode *decode)
 {
     printf("%llx: failed to decode instruction ", env->eip);
     for (int i = 0; i < decode->opcode_len; i++) {
-        printf("%x ", decode->opcode[i]);
+        printf("%02x ", decode->opcode[i]);
     }
     printf("\n");
     VM_PANIC("decoder failed\n");
-- 
2.39.3 (Apple Git-146)


