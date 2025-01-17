Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1353EC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1s-0003xO-6Z; Fri, 17 Jan 2025 13:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1m-0003tt-LX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1k-0007eQ-TZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165cb60719so46216135ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138302; x=1737743102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5tL6sktYYC9Rw5x1UyaJLj4KaE42qpOUtqK87mSas4w=;
 b=ZAayI/ZY81Xkz2HS9XNY7OVV4LbY2RmXCget2imidI2TFP2xDyxcKE0Kmb3cOthU+K
 iWF84cH25qag94kRO6A+BurJdMAkBvv6Lcf9ifzpaWYT53nP12cSq3ypM0MOweOp+0HK
 LdGSg1b24LMZzLNnpVRhiV0Mf4iSAKBJ2QbkwTkjVJdeCB3dI9BB02zBNEkuHySd5R/z
 vxq52I1CtWlaOzkdCQdVzydHZBUxFXH9zm+N/aNbNsJ0yFJcHENnHZ5wVLOdv6fyCv5j
 FKEcNEd5wM6IvaVJg+93jTM+X6YLFQ2wSBzbCqb0NdHEf4JYA+u6VudbhhUmXZ5uxYJv
 A0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138302; x=1737743102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tL6sktYYC9Rw5x1UyaJLj4KaE42qpOUtqK87mSas4w=;
 b=DbWJmB9M2zySHIkJj8CZW6jUOS1l3aPzr4kNkpkkPzenOQgffBJY17TFxwe9c4F/ik
 xk5XjoGa4rlUHtkQu1kOhK8hsnEXPtnVvjBI6uZrhNOSF8NCvNoUICq1DErN6+ZWyXtv
 HROi+1mL3k8mgkeT/RKa6SgOnUTu8gAEgtzfcHujHHTKCrvUYLngm40JLFQm7sMZqWlh
 ++9NwsL/D1/uSklVVEM1x/aIlw8TPFb4B1i++mfV93V3sae0GbQp9Gr/nN5hz+yw2vvP
 4UAMzD3So2h8sUhFNl57qRlAfWvZnZyiGKIzXUzLdAxM80vh9EvC7C93T9LhPHKJorV1
 03Kw==
X-Gm-Message-State: AOJu0YxwGUyylyScYpJJO9QvJ/CP3C8A6S0bBYz5nzEtM7sQsDF5kIeW
 NTgbLbiS8M1EoSd/phSXWNeQWulRzSg2MFLA9oyxp7a2BCy4g8YS4kJ3mQT9UVnhedvnhFCUYwE
 J
X-Gm-Gg: ASbGncs86IgYQw6Bj2zLWd45vZLMGfo4ArPvd68ohrV5I0cvoPai9f++Pjhs2e2mXFR
 bm7/G2nflNpVOGLAXj7/5389DDemPBzOSJ3riYNwfbE1d/v1OxyhZfSZELGNfiII14yrxZ7u4KK
 h0fWuBhBP5SqEV6jVlexz5yNo8MMZbZ1fcf36wUzD2cINajRB10hV3SMMj0bShpg34gXchZTgQk
 608aJ0kGS31lWEwCt//G4LltBAW7p8SjpjVwSwnKI2fE2Q7GrcHUW9A02v0SXPoggm1PuYf/o2F
 7JW80NXpK8sl20o=
X-Google-Smtp-Source: AGHT+IHdMDxaanPNM8TFNLWtgemz3tdFGcTGjmczSDUpNixmiE2kX/hJnp+XDuDCpMcF/mSvoqDVdQ==
X-Received: by 2002:a17:902:e80a:b0:216:6769:9ed7 with SMTP id
 d9443c01a7336-21c355c7dc2mr59064705ad.40.1737138302408; 
 Fri, 17 Jan 2025 10:25:02 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/68] tcg: Add TCGOP_FLAGS
Date: Fri, 17 Jan 2025 10:23:54 -0800
Message-ID: <20250117182456.2077110-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

To be used by some integer operations instead of,
or in addition to, a trailing constant argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 5d96cdfc30..238c55c9ac 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -440,6 +440,7 @@ struct TCGOp {
 #define TCGOP_CALLO(X)    (X)->param2
 
 #define TCGOP_TYPE(X)     (X)->param1
+#define TCGOP_FLAGS(X)    (X)->param2
 #define TCGOP_VECE(X)     (X)->param2
 
 /* Make sure operands fit in the bitfields above.  */
-- 
2.43.0


