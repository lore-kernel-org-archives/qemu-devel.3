Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C691E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfL-0002kg-3r; Thu, 02 Jan 2025 13:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeQ-0007D6-Pi
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:32 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeP-0006CS-De
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163bd70069so60166115ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841428; x=1736446228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vB8w75AClN6PL6VJUhDDjkdVywPr8GpO0chZ17bAQPE=;
 b=paQ7Gi8FcV6vxB2v+OItDV1n5m6j7rL11KVwU5m3vwSqyyjvf36jPZig6RgpJWkh2C
 kIImCf/QN9MD5tLUvya1opXXgjZJYJZQBS/HNsko5Z/QXNcDodfn1gGLrNBE8vn5A2IP
 M3lLtLje8OF9KmNrsFwWvSQn2tOqs3w9RhzAx9B06C3Xg2/FuTczAlfQmGl8bz61no2z
 jc2enuBhfZARIdmMt6hqUQHGiAAhCBTNBvfgKXJliurWc4QVdXThLIolk3ZtVJMLSabY
 6p3iPIkmt3ToxTlYDzOBozSqPtbixug+dfCoE7VZAO/lt32r6ci929Rl7X7JpWPd1SR7
 WlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841428; x=1736446228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vB8w75AClN6PL6VJUhDDjkdVywPr8GpO0chZ17bAQPE=;
 b=MDfJsLwn58ZejfQtBEevzN4cnJkgwBcZvXFt2IrMKPuRvpALaWfL/3PAGle5mGOqSp
 G3KPybR6cRJJNsmDEIdLBFkGw/3nU3LTMfCWD/LYziMAWMOU8YDcS8yMYRwMTNobcmn/
 Rnfxgk0rInFd/LY7KWnQOifVJJvfqJpUf37AP7lrLKdMIy2qK6JYGBiHChaG7ahCKV0u
 dYKbKJgJrzvFWMWy2e74H+eH22H8Jd22N4o8amxaU5eeehKxstHDoKNbUvIA7S7WhEsU
 M9hkbfeasQZOq0yQkFJeIjABg9bku5BCgGl5bu9MOMSoCEegvUdiS81bRpMplPR0j7aT
 vz4A==
X-Gm-Message-State: AOJu0YzheeowRsrpETZSehPc7RBiKR+x5CO/b3d5oD2rSIKi8MMgi1Kw
 JYqJNPLhGey8A0No66fRcvXbMVTs7IBV6U9mqCTjUJ6L+5qwJJI2qIk7YUCUkv+YuqlU9HBmXJC
 d
X-Gm-Gg: ASbGnctsiA9hUwFDYF3IK+xNbRTZ0ZHi1R9KFBjOgiqzW2QbEXLp5+bF6Xd9jytzbpE
 F3f8ogmAQmkWqp/2BqqXeRlg6r0vLxppEAlCI2UiybNn5fFzHV/v7sgy1Gm3kA/3vWChiUDDbRR
 qPTpf9Kxzvhesc29tZPfQVee7tif702G/BN1I31zZSD1QmavftMhO2USPBjCsvTsrZwNHG4Neal
 eCw2WRnhNklRLsv/C6wiq2OotI9MkvOd6TU+rz6ujUw5RXVuxVJLf0OAXlqJQ==
X-Google-Smtp-Source: AGHT+IGA/me9jIVzBs6h07YH6TWqwWzwOg3kK+7mPjc8tuvdBiuSG6LoI2sTIWxVh4tDd9nRyLlkgg==
X-Received: by 2002:a05:6a00:2c86:b0:725:f4c6:6b81 with SMTP id
 d2e1a72fcca58-72abdd4e7a8mr74242462b3a.2.1735841428114; 
 Thu, 02 Jan 2025 10:10:28 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/73] tcg/tci: Provide TCG_TARGET_{s}extract_valid
Date: Thu,  2 Jan 2025 10:06:22 -0800
Message-ID: <20250102180654.1420056-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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
index d6073dc743..41eb530d9b 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -59,4 +59,7 @@
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


