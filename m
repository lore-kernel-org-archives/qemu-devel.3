Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A056CE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4X1-0000I8-FM; Tue, 07 Jan 2025 03:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wh-0000CH-DM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:24 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4We-0002sz-WE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:22 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21636268e43so41671175ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236879; x=1736841679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z8/RpfbHSz9cX0UKXGJWkzsyMErHRUq2IN8dUjdwnQ=;
 b=sWKrEJp+GnnWCcVoN5N1BU6obN9AZSL/Oiv9v/NX3AgnqghY2X0Wf7caqwLvhnZ5r7
 gCeHTXwLI5VdySAicq4sPWedTEC38aJ0as/77tX/io9AkiaWsTKiyVYrbjOx2Y+t4XLL
 uvRFnIOunNPRVnHybIOFBcM5ufhDfagQXcF1LpurdLzbevDIVQv03wMOu4wlnAsuXs3Q
 45dMOqfCfnD5o2+IV/mGdR6XVGPyPCbPMvxfp6GscWU2Xj6Rv9q2x94bcyAnsYej2REw
 8JTrfByxTFvTKr8TDve273o5UfaoO7PevoJIA+78CJHmm0KKH1ncLO8Zv7kdwf1xOBCO
 kc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236879; x=1736841679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5z8/RpfbHSz9cX0UKXGJWkzsyMErHRUq2IN8dUjdwnQ=;
 b=FzHFV4rStWZfoshaPUIjU8Vf0oheDWRqh8ZUwbvvUtzl2f6+gRj3vDNI0fuH2PHuDn
 7RrDFQFej+ieJCVDqMqRPUcCS9OuiPNuyZi6IXT0Kfra/ZALGhITTe0PnfaudNZ/EO2L
 KRm4jKIVeR797X+ywfzywbNtL5GAfj8DWJciKIO7AQhI3p1OKPD/VgHABkmXfOdulE/9
 DJE/DvkxOvQLuQOi5EDGdlucOuzHfdviJapLmdjmKex4MPLBGBjLwUkTeKk4RVRBg+tr
 /J2r/jEKzEH2Tq3UW2gorfEe1Z3RObWbeRhWNihzrCU5OWUs5hG4UB2Du+4TMXGoqq31
 0f2g==
X-Gm-Message-State: AOJu0YzuKQ6JR9Jo+CzJXlWUyf58ReaM3meBE0dAXdKfOyUHSja769D/
 ovJ3/7u8l+Mv5Df5YMPnUm9XoRMt2JfqlibJFf/FmvBhDInfLZdWRWdFJZBi8QeFOeOAkMdEat8
 C
X-Gm-Gg: ASbGncv1xhSVJxiTQhis+qYWkup4cFIwvt7B7DA37/BwhHtXH8gtEp8s4ZGDr7hzzfY
 ryuRlYEF7YCt9ze6txIJTA2HbOxoRzIKNC/nKwVDCz5AXJ4Z1y3DgjnE060xyavF1lODmSczAtA
 e55rWhkDIreqZQj70aIRCScDznPkyjxPzLfjWARB6Z3FuAQfPe4yVhxW0p+qHrZ7iMS5LmNcgZ6
 z59AYOWg3SU6fLoy+2akpW4VjAGGHifb7cRdXPxX+oXZXceqFgkKW+ERm8V8a9W2cwiwfzR1h2a
 W9UFXjo6a/3CSGIGMg==
X-Google-Smtp-Source: AGHT+IEO9VDwt5IKd2pw4lvNGessz5hB7fRmVSlI8Bh0Q7s6ZT3LzCT0faPHIn2GO+NVoZJXsn0L9g==
X-Received: by 2002:a17:902:ea08:b0:215:4f3b:cb20 with SMTP id
 d9443c01a7336-219e6ea1c22mr836202765ad.23.1736236879598; 
 Tue, 07 Jan 2025 00:01:19 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 05/81] tcg: Add TCGOP_FLAGS
Date: Mon,  6 Jan 2025 23:59:56 -0800
Message-ID: <20250107080112.1175095-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

To be used by some integer operations instead of, or in addition to,
a trailing constant argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 5d96cdfc30..e80b1f6efc 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -440,6 +440,7 @@ struct TCGOp {
 #define TCGOP_CALLO(X)    (X)->param2
 
 #define TCGOP_TYPE(X)     (X)->param1
+#define TCGOP_FLAGS(X)    (X)->param1
 #define TCGOP_VECE(X)     (X)->param2
 
 /* Make sure operands fit in the bitfields above.  */
-- 
2.43.0


