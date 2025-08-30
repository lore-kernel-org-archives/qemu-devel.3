Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740EDCA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNyQ-0006C4-4K; Sat, 30 Aug 2025 11:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQw-0007Kp-AG
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQs-0004uv-39
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-248a638dbbeso24949965ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532840; x=1757137640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYJJNkCVSQ5j5v2XBrKXrPA82mG4YwUVjAuTO3fF/o0=;
 b=cv0BqxEkjlFnQtGzO4d4y+BFz0np1Qarf5CSwmMXiYeSHKRZb5kPxCWlONTK4Ca1xY
 r20NRXUgEMnFShL8fhxwmDVCLuvt4OByaLYGBO2DkwxzPNPfhW0DYb2Py+DaEIv3ng2R
 ADaFDqKcKf4Nd90EPE8036hCHQYdr4nXxmqNZek9Fx2G9slBW9HRTgwS898r1ChDebCx
 VtglmRXxcKga95HmqMieyKi3m+mk8Kx9Cxfj733eayfvKNU94rXd+7EL5WTBVcIxRcwB
 jnIIKhUpPbnFc/tr5/GTFtJ9nV3+5BDeWCAINVXLnDOuCQXHYFVVLb0LjoODyKcg4nY7
 1jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532840; x=1757137640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYJJNkCVSQ5j5v2XBrKXrPA82mG4YwUVjAuTO3fF/o0=;
 b=cdD+/OWTg/wB6GYomZ8T/HDgoW5h5rLbDI/uNqq/FBiJIEnjBHLgE1c57W9hW918iQ
 Rteok3mGBth7FIWzzPl6W6DIZQ4I44pjLnwnFFNQO0Gi+/9JwiysDDTpxQ3764Fl9t5G
 GprB6qDlPRvn4TX1JD6hZl2NUTeGbQ6s6tnhVTWH2Ti92HQOF8sJrHgtqnFDAl88ZCSP
 tPQCQy/Ehp+H872RfZB3LmU1Ki5zEhmzhMhTeL1dN+k+tjM0lG10yZen4PztFQ2yhVVp
 FKbsP9BFvIdZWK3qzUy+6d3TT33SQku5v74NJ8FBzIXwSioyMKzslbHAZTmqri/ezE5C
 RJMQ==
X-Gm-Message-State: AOJu0Yx9T+MNHAKQ6tewmj4Aov4tiFw//Dw/RJVjsjF2j9VzEcq2E0n4
 oT4s6qr8JPUlHW9rGKhtsquTIbTnBcYwxDTOoY5YDpJh59uIASidd7N+GkWr8Zo07RUFlwcBmpz
 UrWNaKI8=
X-Gm-Gg: ASbGncv1FG6y2ohl7j/j47oFmmb7RQk62b+13Z+w5UTJ+M1DsjKs/QkLaVGZbz7nDSZ
 8NeLM17fUDAB5AwIuTR+gwkntEWGduelXdax1ThtakJosaF1n8zaFmPCdHeFxoKJyP3nmTxNqsK
 VxyI0dMWZ1aWlcp+1OCdk69cl2gILse60relxcxDj7r4KuyClsX3b+47yviKX2jvT+TYlMQR1m/
 OMA+C8u30rniweosc8wJupHqqUlEwQi2Gx0F2q354cxAolllTjHTWbXh2DETnvw4NIIk0hFsdwv
 RxSX9cZB7B2fPMI8CITIkpRDzs9XNDw0vmIb0iMGdmz6iXj9s2HXeJb99BaR1KmlzchTLPmKf5d
 +acmEsxHtFpgKAT0uLA6weVtujPTCO36pao4jZvwFDadWe7UJqwbUkDyK5sUouASbGFrqu4jxmw
 ==
X-Google-Smtp-Source: AGHT+IHIQpu80eMVyq2bq5aOdwyJBpJCo+35JDCbOv6EwdyX15+lZ5bM9W05ogQ9AgBmMCqVj6i0lg==
X-Received: by 2002:a17:903:15ce:b0:246:de62:e0b with SMTP id
 d9443c01a7336-24944a9baa9mr15142215ad.29.1756532840149; 
 Fri, 29 Aug 2025 22:47:20 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 58/84] target/arm: Implement GCSB
Date: Sat, 30 Aug 2025 15:41:02 +1000
Message-ID: <20250830054128.448363-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 8 ++++++++
 target/arm/tcg/a64.decode      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 022a7c27e3..84c62fdb4e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2072,6 +2072,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2ae73f443a..01b1b3e38b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -248,6 +248,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


