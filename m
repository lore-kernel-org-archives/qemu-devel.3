Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8H-0006L9-08; Wed, 15 May 2024 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8D-0005ze-Em
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8B-0001fk-N4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34e28e32ea4so4257705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766061; x=1716370861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKJZYifPLAfMVMiut/051TBGFTmpS1Nu/DFU0w70ggM=;
 b=WGpYO12GgmpAJ3Lt6tq6QIHt0JLGkxAtAvATq9RTPZV2z4TMoPmVR8WSfMRbgm31RV
 ZBf8tRl7TGlHfOkMaeRF+/ze0PysUS0z54Hh2p3CrE/j5I0VKFOZCBpKWY1ZzZSdgt+f
 j9U/tsn4AXm0p0EWCp61JMWgH+VFfnxrp1byImwFoodgL+OeOYQChnH64SOuxlyyGRSt
 +7yNj6EwBtyDr9jToYsMaBO9YcYh5qx/HBBjHLjj9Ml89Snsq5Jo/pRnzms/RLV5VeZf
 d7dtdDnuBs+0wZW1nDMKPS9+xyPdNQCUAHiYUXkGIT/5FK2XfgVudLKH3HfUUpNX2JCg
 6ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766061; x=1716370861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKJZYifPLAfMVMiut/051TBGFTmpS1Nu/DFU0w70ggM=;
 b=uJFQeGqDU7Dx1rTV1rfnY6H+4YTTa7gba5pHSQYXHbaGsiuXt2i3b0d9DNO/81mgGU
 +4H8iGbBuZY0i6KmhrP/XMZM5RXElnJysodmN2jKWlR21i8isrKBm0AH6KnWrqOT8Els
 vZidozwqy9WZPe6XrkTc9lCFnTlpkUqSnmhOh7gkKbmBkWjlGBAJXjMHXX98RqJSIakv
 CH4/XWouI9EVytju5VPSJn3fFgYReg3W9i5vDERkEys5xbe1KU5yMuLWn+3RTEzq+p5I
 Qf5MTeIv6oUGn9W+HJVrHkmH5vPStiIZjuZF5ZXEJ0Xjr6hWOS66RQBSrace27HoYxbL
 NCmQ==
X-Gm-Message-State: AOJu0YzqsrMBy83pji6SDv9THmh28G6hqj/ti7OvUiC8VqJbwp7Idgav
 VgVYYOfKu+i5N9JzfRf/xwh7g+VmzSySBNXfqhodlTWPdXQW2/v0+ca850XExTNEj1mOwW0McAA
 GVbM=
X-Google-Smtp-Source: AGHT+IHJIyejTZw1hrYqpZCXLzaktTVNyact63ELR7sqDK7z1Zk7SlfvE0W7PMy9Q5h/eA99DjIrPw==
X-Received: by 2002:a05:6000:440e:b0:350:4c83:d668 with SMTP id
 ffacd0b85a97d-3504c83d8bdmr10074397f8f.67.1715766061303; 
 Wed, 15 May 2024 02:41:01 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 22/43] target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
Date: Wed, 15 May 2024 11:40:22 +0200
Message-Id: <20240515094043.82850-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 62cc3c3117..b19d7c64fe 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1006,9 +1006,8 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tmp = tcg_temp_new_i64();
     tcg_gen_subi_i64(tmp, res, ones);
     tcg_gen_andc_i64(tmp, tmp, res);
-    tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
+    return cond_make_ti(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE, tmp, sgns);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
-- 
2.34.1


