Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF989C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pl-0002OS-J3; Wed, 19 Jun 2024 17:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pi-0002Ln-B3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:18 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pg-0000jE-Kr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:18 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-70346ae2c43so916740a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830815; x=1719435615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtNxjFE/f89KWIDXkuZChFJ2j7WRxZA+Mhz/JhRC3yg=;
 b=IIy6ns+nConpkdezXu+VmOc6doR/SpZddMTcpUmMxW8zVPDno1mVFWtJQKzb4W6RbK
 Kp7Zdj3LNtUV6WMG/Ye4V8qNVJQF1fzLCViKTXXq4TnLbaIlRKBtv06F2IcSKh8KCBrD
 ABFsG+hIC0OEdarL9m02+JtAnlX5CY5kImv/MAe+CV0sYHUG3sc+lQo0KPDcAihYyMIR
 wCf6lsJ7TlawxkyO58P+6P3/Oz/UiHOmBrrrt36yXtq7ymAEtAXuRv6pTjVy/AL481fO
 Us5X3XzNcTHOM67Nl2X4m67Ipo8/Kdk3FHH+kU39NWDnvMtxDUwwj9VBZeijcev5GfCJ
 40nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830815; x=1719435615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtNxjFE/f89KWIDXkuZChFJ2j7WRxZA+Mhz/JhRC3yg=;
 b=wh5TwMo3Thx0Nw+S388rzPtoYEZdnGTZRBO82Yeh1d3+oWsiKO/ZDDBDDiXsTcKr52
 7knjo/6tHjaQ4bWqePYGA5sT5zOW74M9Ay4xd/iKEHwdcuPYa5TQ0tfcxjpyiX2sC+T7
 5vr3geEZ2N7rxRayvOxkeNXV9LDaf2DiWSg3+2V1vHj9m0YgMoj3hzDSr3YQmTPbOrCR
 Fy2xQAh50lWU1y0hBO+bnjMwszkucZyLUhHCR+UTMYkZt1FIBtazEcRsIbNviU8ufmYT
 P9rwOXNRfq/NhAZXEZAK3i2IrrwhlEI039QE72XmIs42MmKe9m8+Zj32+oQvefIDGbxO
 96Pw==
X-Gm-Message-State: AOJu0Yx4Duwn+bky6mtvb+MD4ixRM6ZwotIJ1VM8YXdEwdyC8UChpQEN
 2GndD9n7hGDVgnzDELUmLlTSJ0/ccR6eXoPI4QvIZr6alxPjPqkxUE3dXaFDQSEUcDC+3SvKz1Y
 n
X-Google-Smtp-Source: AGHT+IGJQF3MB+nVBhH8FPJcFeIDjPRo3oxMhg5mST27Les7pOnXtDsrXmWa/9lh8kpjqcvTH3Ia6g==
X-Received: by 2002:a17:902:f9c4:b0:1f8:3e2c:d66f with SMTP id
 d9443c01a7336-1f98b23f6d9mr67753515ad.17.1718830814841; 
 Wed, 19 Jun 2024 14:00:14 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
Subject: [PULL 23/24] target/sparc: use signed denominator in sdiv helper
Date: Wed, 19 Jun 2024 13:59:51 -0700
Message-Id: <20240619205952.235946-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Clément Chigot <chigot@adacore.com>

The result has to be done with the signed denominator (b32) instead of
the unsigned value passed in argument (b).

Cc: qemu-stable@nongnu.org
Fixes: 1326010322d6 ("target/sparc: Remove CC_OP_DIV")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2319
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240606144331.698361-1-chigot@adacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 2247e243b5..7846ddd6f6 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -121,7 +121,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
         return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
     }
 
-    a64 /= b;
+    a64 /= b32;
     r = a64;
     if (unlikely(r != a64)) {
         return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);
-- 
2.34.1


