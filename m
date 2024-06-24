Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DDFC3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjX3-0001Lm-Ir; Mon, 24 Jun 2024 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjX2-0001Ld-6p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:52 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjX0-0004x3-Ke
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:51 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so15556521fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234888; x=1719839688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mJMievbUPjRodtOESUjRxIX72igzigbVmP1VpcJ+Qs=;
 b=AyLzsuEvGwqKY+pNXiS6CKQuRD1FaJkYZ4FlJiCEg9DJss/XOAxVJix9cy8c41qifr
 J/obTuV8jwWhIRA3ONHYRWzTizYVGGfEbXj5716qV9Vxji7WPQSC9d3WYgYW6Gvmnvfa
 aY041ASuDB6KJfbASvDmZjeLt/Y6HzbF5iaPaJ6AGMNEmlP7qNiQt6y/p5wtbejrH1ih
 eiNXRJnV9ayr3+TkDw3JIcJGsWdgutyYJ0FAv+mTJk4olFERVqIsgyhFfFLtnE7MFTeA
 Q+L1sSTo+CGvIF5jQZWoV0ma6J61hL5RJvlHP9WHPfRM0ouFBbdRPP3aVsyjwvlmcvlF
 k2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234888; x=1719839688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mJMievbUPjRodtOESUjRxIX72igzigbVmP1VpcJ+Qs=;
 b=MMoR5cAXprJKP91uLAoQu7OS5ZTUNFVWqsvyZlodCEPoDcasOnnCrJU/1ugFTv2y7w
 4Tzg+6hSZIg8kmd3qRR79w3zkm3Gv3RdQIg1Ddx9t9eb9dnPVloCc/A2hfX1gx51sQ0J
 xcEc0p7aMT+78Wk03xKrIF2u3VudR9gh75h+ug+GhFrLT/HYUy8vsb3IHDdY74lXomNg
 CGFpVEmrKdHEFpwBuX3Q7amiuEAfSDTBzKKR7/bMbveR/FFTT/SPKZz42cGTSKesYDna
 qMVeyp3vp+UgmyVLhr9JVtpurumUZhECGGoQef/1O9X9z54qq9BBEL/Z98uLE3IPzy6o
 aIqg==
X-Gm-Message-State: AOJu0YzSQwscAboFnzuPsglkbIzj5E6a+v/h08hIt02HjhtMIa8xjVWm
 EIawNV2JnAAo9A8urAQntRJCKYvdMYg7LJdHbw4AfisTe7M2g4oLcr1GaoRGq3yefI+JrtG2BAp
 P
X-Google-Smtp-Source: AGHT+IFKSUCwbyug4dt9nWTfDpOjGVqMwCw2DrgQgUvfZxUzt20BuZeIWNOSINyKNPWnUN8YsDyrwA==
X-Received: by 2002:a2e:918a:0:b0:2ec:4086:ea66 with SMTP id
 38308e7fff4ca-2ec5b2fc27bmr38710701fa.4.1719234888511; 
 Mon, 24 Jun 2024 06:14:48 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663ada0bdesm10021016f8f.113.2024.06.24.06.14.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:14:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/19] bswap: Add st24_be_p() to store 24 bits in big-endian
 order
Date: Mon, 24 Jun 2024 15:14:22 +0200
Message-ID: <20240624131440.81111-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Commit 14180d6221 ("bswap: Add the ability to store to an
unaligned 24 bit field") added st24_le_p() for little
endianness, add st24_be_p() equivalent for bit one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240621075607.17902-1-philmd@linaro.org>
---
 include/qemu/bswap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index bd67468e5e..ad22910a5d 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -38,12 +38,14 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define be_bswap24(v) (v)
 #define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define be_bswap24(v) bswap24(v)
 #define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
@@ -357,6 +359,11 @@ static inline void stw_be_p(void *ptr, uint16_t v)
     stw_he_p(ptr, be_bswap(v, 16));
 }
 
+static inline void st24_be_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, be_bswap24(v));
+}
+
 static inline void stl_be_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, be_bswap(v, 32));
-- 
2.41.0


