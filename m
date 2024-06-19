Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65235C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsxU-0002HQ-E7; Wed, 19 Jun 2024 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsxT-0002HA-52
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:54:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsxR-0003Wm-Nq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:54:30 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f176c5c10so788765266b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718794468; x=1719399268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGd1+AnZ3JAdUcbDIrNFBYwbiGRKQANzIDdcCwBjRKs=;
 b=vwmHYy377k0Q1eENd4+lT5qlSMmhLhZYmYke7fMW3KG0qnuBArsG6l9eEJeejsi2uX
 AgwlbFvuRl+CbY456CPAtqvgQPvyZJ+My4a+/89hdJrjUWHJFRpLcOyYTVhgr4ey1JYV
 JbG6Gxa3m+VfYvKiuv68O4Ah3yh+Zc4fKh0V3aKkOy8SqsnrxO5TzwXQZujXBHjCVG1Q
 v0hPu5my3ITkjLIBYDS5nyMKzKBZI3cGZcVB98Q2QsyhHeDuO/MYjJwPfFwn1PiST3ZM
 dyXd/tpxm+C09k0tj63ZSi1Q0O0lKLl1fJiV9IOtjqWQB+eIxcM2emS/WQRkJpRlYy3h
 jwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718794468; x=1719399268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGd1+AnZ3JAdUcbDIrNFBYwbiGRKQANzIDdcCwBjRKs=;
 b=oYypTmhQLKOLh5DXtPYJ8T+IopOA9n0mG8es6oysyGDU3Q7ldf8Wen8R62tr1K/Dp7
 0cwK9xsKN4hrnooPw5rmXr97KSz8YcO/QmkvY79fVotujIbMXJz8DwjH1Wt2oEOWGNkf
 09i2NKn66pu5bJyZPCfC5emqjj+TVRT0aChBTm+o3K2tHPzwD2ESs+JsEG4O1SKZ1tL5
 oJ9S2LcWnTZImQdhhssSc9/8dFY9trf5AB9E+508HtcKtfNk//nwWGbbtxgxh8sTuWZv
 HkEamhw5RKYYpaNXMT2veh91yrlXrizCfBf1fw4X3Ft61I9afYbtsWNCT1GlboWyVeRg
 lMjw==
X-Gm-Message-State: AOJu0Yz5un4hiaTLKngolqERcI3jyH2lk16Ktz2/0XshrWzwVy8JGtFV
 Gj3QQvQxh/qrnGCD0VgGK+ZAvB7GkSldSovidqIazMx0hiVPkF4ZSoAuocnAcyYL7iksLkYBury
 k
X-Google-Smtp-Source: AGHT+IFRN+aroNI/BQvFA86OnpZdI7LmkTCzuRSd7Z/n/nzNxjiFSq18lf6+a/74vaQxw7OiDVttiA==
X-Received: by 2002:a17:906:2316:b0:a6f:67a0:c44a with SMTP id
 a640c23a62f3a-a6fab615ad1mr140020466b.24.1718794467706; 
 Wed, 19 Jun 2024 03:54:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f9802csm654034166b.189.2024.06.19.03.54.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jun 2024 03:54:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 74/74] exec: Make the MemOp enum cast explicit
Date: Wed, 19 Jun 2024 12:54:19 +0200
Message-ID: <20240619105419.49303-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240619105419.49303-1-philmd@linaro.org>
References: <20240619105419.49303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Roman Kiryanov <rkir@google.com>

Make the MemOp enum cast explicit to use the QEMU
headers with a C++ compiler.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240618224528.878425-1-rkir@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 06417ff361..f881fe7af4 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -161,7 +161,7 @@ static inline MemOp size_memop(unsigned size)
     /* Power of 2 up to 8.  */
     assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
 #endif
-    return ctz32(size);
+    return (MemOp)ctz32(size);
 }
 
 /* Big endianness from MemOp.  */
-- 
2.41.0


