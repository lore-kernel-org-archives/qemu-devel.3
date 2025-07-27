Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670CBC87FD1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwOk-0006zq-CZ; Sun, 27 Jul 2025 04:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwM0-0006AT-6b
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLy-00049y-IR
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so8010535ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603409; x=1754208209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOJZIZJj/tIs5sXQuR3l8mzb1hhaa8gRwgUU6Thg5os=;
 b=ngAtlPtsJncqr06iep+oPXpQHy7aKiXvkQ+7gqQqUXhIYA1GP65VoM64zJozqMtkba
 7FRBPzeL6nIvrxtum47SwdYTn/GELQ9gdcZd7fHo4LE3lABak/rgGdUfbdbkKkBL1s9B
 KzOzP/cnfaRE8leH/Cn98HIz7nGpSi24S874J3W6l4SNXZoL4EJ/Br/2PdzwnaBsXpI9
 MnSKbPqtVHn7dkQYlHfflsHTO+x65UfW8536X0rEheFlto/SwYXNozK01fd/yrUXqOYV
 WTcsKyOG7ZTnfK1qJRqiXvFuVPvqOx3Oad2jmwt3Ar1WTlTgfFeFCYYpjd4OZt6+7fsn
 svPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603409; x=1754208209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOJZIZJj/tIs5sXQuR3l8mzb1hhaa8gRwgUU6Thg5os=;
 b=Qu3ADAHmQdaiRtf+0Pngfuuimj47mBmJT0Pl4jtxVro/HoK2enfI/ry5JfFhR/9gRM
 O0G/K4WU46RsrNtqRPwSgkmq+hIN1NygYL5ru+DtIpcSV7vqBmLtfSpjVXk5kBztUZ07
 DjFmcBmj/FKG7/lt+xnhNOIi1THL/T1acLIl2IDMmzcL6g3x5GIWA60mOGy8oxO3omwF
 S6/3cRhgZ69KJglfp7TbkagtYyb6o8lBaCUCv9tLvoP/N4FbZ6MqDoS6KTFyyzmm5Hyr
 R8nAhgQaJqqEOdk3TTlBeeQcLuPRGD1nJd9d7IOLU/Db/EiPNNI3hoPApcMhMGypMCRq
 G5Uw==
X-Gm-Message-State: AOJu0Yzt9lwRTaaJn4Sof9404KTKSkzTHRWeFAxYs6NQa4IMlk0eJI8W
 Wqk4CR3lfldGKhew8ECX4Oyo4OzV6pAIOmesjcQxDCUHZNtFmbr6prDfoNdl8Yws3HZCB/J3dbV
 eZRnM
X-Gm-Gg: ASbGnctFOJcKXbKJ7Eb3MpT+NqTo5vuL5TT78ckW2pUibcffMx891sqNOGnQ2qfokU3
 WlqdbMJ88FUbp7KLIUypChCtBy3ly76PTeRw8xsJOKsYw0k16UDrnhIdeizeiyBLTVnsi7asRma
 f92kSVdGJI0eofm6WpePpB1f8XuiacglsRjOljQY/txBQ/jvJEs0brYLzNaD0XdtSr1YTF1QK6a
 hf74GqCoC8RrXufVMLYvfbukJLgvnrPIjOFzqLzLBPIY/mHO4A4ltithEX4/ifmcSkR+uutLIDV
 OFMmwqMkIDoBhPrbJr67HrTjiWMUsIQaero8LQl5GTG06VnPZbXuOIbrVh+CmQqwRx0SypzySuW
 +Fxyk1ujge+7J86XRhE4W3emobcWOoQaJRli0uz8Yt4rzT7aUxWAT0r3Ij6wXrKOabJ+7omGspd
 8JyBjve95EkA==
X-Google-Smtp-Source: AGHT+IE38hch7fbzFLmFmhk0gVXu4FVu04ds4WO/+HboMxMk6/MfAwsZjKFErX691bsc8n/IpFVfGw==
X-Received: by 2002:a17:903:2ac3:b0:235:15f3:ef16 with SMTP id
 d9443c01a7336-23fb2ffc4a3mr110180555ad.13.1753603409284; 
 Sun, 27 Jul 2025 01:03:29 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 27/82] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Sat, 26 Jul 2025 22:01:59 -1000
Message-ID: <20250727080254.83840-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


