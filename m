Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5BAC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM2-0005xw-3A; Wed, 05 Jun 2024 13:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLz-0005x5-FU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:15 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLx-0003r9-As
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6c55e3d2740so25074a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608192; x=1718212992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQDQOnorouA7TMw0UGCQBMF+zmAgZPoC8F01caazeIs=;
 b=WWvBNey7MwYzLSwBbObWmn1FDqtESGdzr1JvoxAKSwsW0RJTP9ahKAoKg9oOnhAKBJ
 aVV5N5i/BhfP1QVk+lohXB2Ss1hkfeAs+pZtUBK/RwAyqT3xC4XvodNDoG5rNOxSdx10
 x/d8YV9Nhye9akJ3CrxyfLg8ODVslpQxt+7Kjl+Xkq8Dew8TY06d2oEDL+fpIQVdiAgT
 HLV5ivAmuc+a8TWv0dLLxnEGDyI/Lpi8KurmqoFyF1wOZR/J+qt2sEjCVhDtG9cvRSGd
 FKRn/ILFO1bZgLhUIZwxtv3dlOBvVBET77FHqi4lpWoZ9j2nhQb3JPLd7xGHJ27UDWkX
 kvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608192; x=1718212992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQDQOnorouA7TMw0UGCQBMF+zmAgZPoC8F01caazeIs=;
 b=a1nhKDXwZYrrDmimu2KORFsEZtfvt0v6r7VscIpF0nx/hBaHMoPxiWwPyjaYo3+zpB
 i2CT+b3BGTcV1nEmTD0RGgxgpT2Qrzk6ECCB8rVOXmpLE7cRgcUjoDGB+XyEhrqJ/Yop
 2QWMBn0UHEwN8KdYjt/Ozfrzwqs3G61OgC9vsJ64B6+OOiTZbZff0Utlgvn5OHWfdGYS
 UiqqZ2QEmOezHTWORqw+OHlMMOEUGzo4c/YAQbF+mwYfUSVRHD4m/BC0vlhywY+WPlF4
 4JeH1Qs7CjzB04nzTbyTH//pQLhxoRQgQfSZIzY7perel2F4emCd/cWGhbqBNsrgfMAa
 kF4w==
X-Gm-Message-State: AOJu0YzVs0gvBji87rj3WjINGXrdJXkqKJ/zX5NQ0afu1VE+e68fU6GJ
 oN48oFg5l148i3/ifrti6YQ5QpLbVtDKHI2vLJBBHxUDHlvvkdfZprmqqG3O1HE9ngSq6cqRCqM
 N
X-Google-Smtp-Source: AGHT+IGOMLz89Fj+ScdSOIj+AtCr7x5f8XR+nSKmMZK28VAu1f4P2+GCVdsUQz8veQAMW5MKDaQ2/w==
X-Received: by 2002:a17:90a:b014:b0:2bf:9eb3:cea7 with SMTP id
 98e67ed59e1d1-2c299a04728mr362786a91.24.1717608191934; 
 Wed, 05 Jun 2024 10:23:11 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/38] target/sparc: Implement FPADD64, FPSUB64
Date: Wed,  5 Jun 2024 10:22:33 -0700
Message-Id: <20240605172253.356302-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 2 ++
 target/sparc/translate.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index febd1a4a13..70ca41a69a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -441,10 +441,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
     FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @d_d_d
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
+    FPADD64     10 ..... 110110 ..... 0 0100 0010 .....    @d_d_d
     FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @d_d_d
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
     FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @d_d_d
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
+    FPSUB64     10 ..... 110110 ..... 0 0100 0110 .....    @d_d_d
 
     FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c3956f489b..48cab59c07 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4912,6 +4912,9 @@ TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
 TRANS(FHSUBd, VIS3, do_ddd, a, gen_op_fhsubd)
 TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
 
+TRANS(FPADD64, VIS3B, do_ddd, a, tcg_gen_add_i64)
+TRANS(FPSUB64, VIS3B, do_ddd, a, tcg_gen_sub_i64)
+
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


