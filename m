Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE0C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl7I-0005G7-Uh; Mon, 11 Mar 2024 15:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl53-0003PH-2T
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4x-0000NW-4n
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4133100bccdso2012385e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184370; x=1710789170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UgMQNZZ+dnFwwntXyAYCnlpzqcj4xoDYfMT2WTZkqy0=;
 b=b1SeFyiOSLFlP4dYJYXd26n4OMnm9OfeKp1BAkwvsHfJKy/2kmN/eGio+0KVnFw/A2
 wKyVHnEjIFQTEH1a8h3GBBKpgg+W1TBkr0dNZvePo4yOvrSshTKb7O8wHgVGTnUF1jJ6
 F7j0cBX4jYAd6t6QQEHtCooIxZf3TH1WSgPHnLDnCCpAhTMz65rLjLDiGplkWnzcPwyE
 i6K7gHLLMQ0jy8LJdqPKHK0sBYybC3kMJTCjIptpb7eSWXtSFGxpO8LKt6dTNMLGHSOa
 tsOcVhjuspFJp6N9zDd5lO/Y9kY7RxjdiyQOQ2ElQSuQg+rxSptfO57+cn1rk5LX2s/R
 MrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184370; x=1710789170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgMQNZZ+dnFwwntXyAYCnlpzqcj4xoDYfMT2WTZkqy0=;
 b=DrGBwZod2R+REdgyn8Cu9Lttbc9ldbvlB6m9XsvcK0I1CHHWCDjNWEBe6fOPk1xktd
 CRVnTiKw0FQkz0mMyOQ9rSayDTky9l/xIh05/+MtUmrYQAvCz6F3XwYJSh8d8MIDy79Z
 TECdFuw14eGMlhhfBtwub7VxwTSz8rmU8EXtuHN8v4S96Qksy2nivQXzKCpJrc5EpLAm
 2AAleCE2zyRdzHLdHR+B9Vb1Eh/RR8TEXVIX/0M3by/rVqBtI671Y1zSHvMRAthAr/Rf
 g6Zg0ihczx5YJhAr/ZgF8slTJLlpWsFuX4o5ejEl/jUW4cdrYj1wrBeynRw+qQ4KkL4A
 3txA==
X-Gm-Message-State: AOJu0YzybPxUcUbwLlU2SUOlPF8G2NAynDIEz6dPorAdRXyaoWfC54GC
 h3aFylsbv+NquhS3Ow4X8Vb8Im4wlB+zK8JhSArxbcMKWcmRoxKpYRHLfYUtxC5+kETlMqo+Wgk
 U
X-Google-Smtp-Source: AGHT+IH3QjjsP0vsES5x3L4SSIriIEFNnKnqNr8RwlUAbVsJ5m7w6n4hSUY5hGIKoGZdatzd2pQhjQ==
X-Received: by 2002:a05:600c:3513:b0:413:1741:289f with SMTP id
 h19-20020a05600c351300b004131741289fmr6240226wmq.5.1710184370051; 
 Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
Date: Mon, 11 Mar 2024 19:12:37 +0000
Message-Id: <20240311191241.4177990-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d96f855de5..12f5e47a11f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3587,6 +3587,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: contrib/elf2dmp/
 
-- 
2.34.1


