Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369C2C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ug-00046A-2r; Thu, 17 Sep 2026 05:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ud-000440-TM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ua-00018V-U6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso603840a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637599; x=1790242399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DHlw9/SY/MKdFHsd76X/+2RqJiqBSJWVubF7/UfKiAg=;
 b=ZGwBcP24otYOGT2+g15zJfktIjR24b5yH/3AC027K6xlgZGTEf8rciMeq9njxCjhaF
 qdwZRX2iZH4F2iRw9y3Qkii4NcSl0fGVhKSouGliMet9Et4HYYmYNO5b96EnreBaXIF1
 4+vm/Rc+uOlsLzC3ZzSgSqXlOhjUJnCHbhKzPGYP4QM+UHPujkK4mUjGYrywlME01ZeX
 cUmi25ohf9y92FGaPzlA8b0vlS5gTnm+BFm9GCfeRaBDldc5sRHwxnn9ZhMJ9+buVgr9
 IozWTIwlUcWLSki0goo/JFZtKunCVvelV1Qedb6GvN6P81VsTW+Tn+UWPv1xvsM2/YyL
 l/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637599; x=1790242399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DHlw9/SY/MKdFHsd76X/+2RqJiqBSJWVubF7/UfKiAg=;
 b=nBrSuaLMxh4UtWwBnnZCvzjpgPV4pMxdpk98vLZGPigX4o9WlE58qf4eM72Rcuilt0
 iiH6n+4ENppK7WnpqKYSZLvh3Awn3POlqYW0dflC6kGeCqY3JxN07GDnzo623OgFuZu5
 7wJsdH0G82GXrtc176aLvsr/NDOvD9rr75w0PWYDpbxbWN9YtT8u6eyhJpigPOZPqMzq
 aMzjDcheZTlgUzAX3ZV5QL2RpPPSxd1PxJnHw7u0eOkJC3xFA/yr5n8+xuGNL1cm0oem
 vzIkK88Q/Sseghv3H6I84SiJBp7z2AHmKj7kyGDfDjHR4kwYBZWJytcRgo8rgKvf+pTx
 sOQA==
X-Gm-Message-State: AFuF++npe4xcAJ3G4/AK3YvD/KvIuXxzwPOqBkPTIeUmhBSad20den1C
 OAshOk5tkHPqUvICHswvJWmRFTFivs+fv4ep7ZQKrRT6nFZZoqS8bXrVQ4W3xTiLj1J1inPy7YX
 Ddpa8H98=
X-Gm-Gg: AYBFou0J7Fl8/ZcAopI/BYt493P6K1EtgnLagw22q4NvCA3aV0oWQNPWwrAALmWzfsm
 GL1uau+mX85OF8KIar2B332xhhvxepAURfocNoVaSrNj4Fz5ztsaqfmv8TeAyGv0t5RenjQsdPE
 VBgmxdK7v9t+X7H9y7QYVFdBI2F6lNaMIDFTMsgsCzetsuS74Uw9by6+wsjNSNLMma8eVCpRt9L
 MQ0zamMlcClMqwJaXC1557rnShOmP2RHD0GAkxAYq7RbRkmKX3aoPOEB8YAMAyWQENNtnXyzyio
 X8+sBwwYg6wFA7S0tAxao+ervmAEquAH/rk3wNy47Nz5OyoEDW8LYC09EftCuQkWmrdNWhaaobt
 EbRjLJ1WPd/Hv9Li0riD8zx7dG//S6MCJOKfptQvR6fLVOLwD9I/N/G1eddOQ8TRSi6cNHpOjSH
 fnE4YgrGM6x/jTzIp1UXH3YXa5gbOVkIfwAvfB/+w6gnK7zsvLEmhKTdlv9nxxgvGp6//hc91JP
 MYBOlA=
X-Received: by 2002:a17:90b:1e0c:b0:39d:fd21:75cf with SMTP id
 98e67ed59e1d1-39e3615cb5amr4571710a91.26.1789637599174; 
 Thu, 17 Sep 2026 02:33:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 08/13] include/exec: Move tc within TranslationBlock
Date: Wed, 16 Sep 2026 23:33:02 -1000
Message-ID: <20260917093307.1092084-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move tc so that it is adjacent to cs_base, flags, cflags.
This will allow the s390x backend to load them all at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translation-block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index f3410dbcb93..ad31184ee9a 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -92,12 +92,12 @@ struct TranslationBlock {
      * Above fields used for comparing
      */
 
+    struct tb_tc tc;
+
     /* size of target code for this block (1 <= size <= TARGET_PAGE_SIZE) */
     uint16_t size;
     uint16_t icount;
 
-    struct tb_tc tc;
-
     /*
      * Track tb_page_addr_t intervals that intersect this TB.
      * For user-only, the virtual addresses are always contiguous,
-- 
2.53.0


