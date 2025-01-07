Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA96FE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bg-0005Qi-LK; Tue, 07 Jan 2025 03:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aN-0000L6-Qf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:17 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aH-0003MP-KF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216281bc30fso1718245ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237103; x=1736841903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=robWniLtAiud61uffcTHX5hixcvYYgZauAyD1vBT5zk=;
 b=VyfokhTX9oLO6WIIqf2PWAAiei+/4FXopbZ4onew2YSdfY6+l1LaW1eudrBXvVm2a2
 3ao89KnLFJRAo/Jg3I2XjjVrBZP4Xe95aGuORJhbWBY6oxx3iWTs6jBALySiD2XKgP0O
 Kjy/qD2aGyxdAL6F2AxZwHw5O3kADvxA98v++A2TUtFidiH500UCCn7yyTLozswgc5x0
 il3HtdfZx9q/KxErFwM8lnPzK78VsitNkyndR1M5CxPLsUHskgYr9OU7IEnGTVQsezCs
 XZGIVxi1SRQ+R2oJe6HTocJLsLaCmv93hkZrvaV7K4SH8vt5d7bsvJwn53yeDPfqnuG4
 AagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237103; x=1736841903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=robWniLtAiud61uffcTHX5hixcvYYgZauAyD1vBT5zk=;
 b=AItGAsLqqZWams8egSR56oZOUel81bav7pQOC7xMvgyNb9iBZ7vXRLjLAGX2DcBeHr
 1UgEQaGBnCFmAZ0NYc/GsnwzfR+XwGmbfYYF1fvOvIxDcrotLYjUIu6euKf8eZShX0nM
 Pw+N75NcW+8awTEkxYnm/xH9gDnaHT4iPI05uyVAEbKTJiTwO5Qv9nKG/cCxsTUf6mBN
 /vfDCqqzxc3kYFxCSvCgAdd2PWdA1H6hbwFevRzxoHav38j8FO+iFK2/3kC9oU1WbOkk
 TNxMA5HBbQx1YNDuIq1MF7LJMJ/7UTir3I/PxdhIDJzuYFCKkCWjnSuQl4Ck5O/SNN6u
 arXg==
X-Gm-Message-State: AOJu0YwU2SAGyH/MAga6TJI2txgkPVwoClUyyOag8t7eiCf+HsajIdGD
 bI8HJ3S65DgH3H+wL/AFWdTOm2PY6mxe/WM3sl+mM7LWwoC6l6z4fedlvrvjqCUpi/3iukYso6y
 F
X-Gm-Gg: ASbGncv82ruVPFyx9e1J11usYNK1gFWXpVzN0twekWdWsCLmKsezTGMuOYeS/RFgphw
 Q7I7OQIVV/+FxHIDmciBMbVj4+aCEgryOSNSl3UQFmngZhIL8PE72izCbHcHX0NSUgOFY3GmC8W
 1lV9nZYLgKObIec7BsSSp0ZAVywly2FwTaCNNK/C1gKjPtu/ULNrBr/jTrjreAHKHOnWHdGQhci
 8YzXySxVEgApoqqqQ2eOuXiIsj6ZVQB1UOb3O6no99QQlI6D5UxeZg3/LSgpR5Yu7ED4UiZcbjt
 EeYxY4/2O74U0SzApw==
X-Google-Smtp-Source: AGHT+IFzT4VpDqq7Zlf21PK+QJpdpQ+/Q5HjqVLnIGOWnk2IS3zpHeoU7VELjiSmogzU2PMGzfMufw==
X-Received: by 2002:a05:6a00:4c07:b0:72a:9ddf:55ab with SMTP id
 d2e1a72fcca58-72abdd9c06dmr89750719b3a.10.1736237103192; 
 Tue, 07 Jan 2025 00:05:03 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 45/81] tcg/tci: Provide TCG_TARGET_{s}extract_valid
Date: Tue,  7 Jan 2025 00:00:36 -0800
Message-ID: <20250107080112.1175095-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Trivially mirrors TCG_TARGET_HAS_{s}extract_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 3397403910..2f45ad614f 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -80,4 +80,7 @@
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


