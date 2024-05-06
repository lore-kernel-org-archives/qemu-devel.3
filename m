Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BEFC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xby-0001Ji-2a; Mon, 06 May 2024 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbj-0001FU-DM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbg-0001y9-2G
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34db6a29998so1157035f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999089; x=1715603889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15MBw/M3WTCtNRZ5kPDhx5DhGKWOE30iPpFmTieH1zg=;
 b=Ulfr9+hFM/7FKHO2u5IALgiIcuO1dRGPCS71WP8dKlw5//nbCSCUMHC1EQwgHSgYNz
 AZqSxq9SEfEc9EavOq/1xS5D4rusMbGXCot6HmKftLvj6irrxJDQ42mDhYctIGkRksY/
 Ox5+AWTWVtSHvGSnvcwbi8odl+a36hDungH/I/iEcqPf3YLJU7fXeff2GPiR2LZ9LntT
 j53vjb00RCZVsTmlu+xSMNHySHCI0D9tN/Zv0zolbJuLJ2TwNcUmAbDgc5dohhLt3v2r
 0BvqMl95PJqjSN3D1B+KRNnUopupo8Jm/M4vzCGE78reMxCH5wY8wTV325JtxaKtb012
 zqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999089; x=1715603889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15MBw/M3WTCtNRZ5kPDhx5DhGKWOE30iPpFmTieH1zg=;
 b=PEUSvwM4vHDOp43q4BvlL9BQhIU9Lmvid61ycuTj65AEmRFuuxhKniwHoGyDY9/OWI
 e3hiBGPS+NDvubYAau5ISklAPrCMPxUoX0glqVm9JP8uj8q06p0JNffXchmj4j9B1fnf
 qK6NUO0EJHQDNMfH9qjF02neog8MoKlkjOQEFcmE8UrJ+gNUb6VDBQrHZtyKOrJeaKqD
 xGQVHtIjkmSuBlsewGPiEvzmO0aw+PJr+ZLH51Zy9DP+ZyxEdBtyD6e01rcQbBCMKlE1
 ku9GTYcUS8jb8Xip9vy5ZCqflMcQYitTvHCsLB5XiEtXl4C/1zCCRSo3DBijx8FfifwF
 AgEQ==
X-Gm-Message-State: AOJu0Yxjo8ixPE8ZJbR1jIEKofJ1eu0qJxESQjxLEQ+6zwKRq5rm/bMA
 eD+AFnSp8CWPbfmcRsS6VXlgqTi1EwWYKzOCKGoHZhE5x4iSFAPaevdnDumQcewOgseFviFeLYZ
 Q
X-Google-Smtp-Source: AGHT+IFDU+99lncK7da2xi5GWim14c2OnM+UL5AkujLJsnX125/d6nWd6zmcrwf+d1KSar10+0HwwA==
X-Received: by 2002:adf:a18f:0:b0:34c:b31e:18de with SMTP id
 u15-20020adfa18f000000b0034cb31e18demr6845895wru.35.1714999089417; 
 Mon, 06 May 2024 05:38:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 k3-20020adff5c3000000b00349a5b8eba6sm10555499wrp.34.2024.05.06.05.38.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/28] exec/cpu: Remove duplicated PAGE_PASSTHROUGH definition
Date: Mon,  6 May 2024 14:37:04 +0200
Message-ID: <20240506123728.65278-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Missed in commit 58771921af ("include/exec: Move PAGE_* macros
to common header"), PAGE_PASSTHROUGH ended being defined twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-8-philmd@linaro.org>
---
 include/exec/cpu-all.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 104c5dd2da..c4dada5b44 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -157,12 +157,6 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-/*
- * For linux-user, indicates that the page is mapped with the same semantics
- * in both guest and host.
- */
-#define PAGE_PASSTHROUGH 0x0800
-
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
 
-- 
2.41.0


