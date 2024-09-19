Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12CFCDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwx-00077T-U9; Thu, 19 Sep 2024 09:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwY-0005Ya-3u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-00015x-4l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so7261885e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751489; x=1727356289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HkJpTrMUcMhqOQXaVK9JEJmDtKhFoBos/v7rYBsEpnY=;
 b=kPSLVKSB2kNTDxUXtG2qIolkNmP1wQ16+NYzdGNg1TWD34LTKn6M8QmeIBYaGzqZOR
 9fQi4FRBAlq/l0G25HBkP4Vagij5MTGBrgW+cp3fFgOT5Zy6dADzB3rT2QfzoMPTXSpd
 iEGva8KrNHYS/Vi9Z7zXFU2kzv0EEjNZCiW7VQRdFKK6+zPocTFzTplW7nyEOyaA8nxP
 uxe6SjinF8TeglWuqq+JDmXFxHWx9cjR1VLH9plC/QEPtjKyqsV1HlbGPrMXIOQEw7ua
 19uiptsL8H+fL+KoBZ9kWbWd8EC15asapfCNVfyBxCTovKfPkV97rqpiIT+YbqP1x9x/
 BCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751489; x=1727356289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkJpTrMUcMhqOQXaVK9JEJmDtKhFoBos/v7rYBsEpnY=;
 b=wrjl9CFC76RxvUBTmtoRVbu8reQYR7tVwKZ1xUEFvN3TVAOCJ8X6wreHqF9zggbll8
 7FN8L00vnVHhX8NjTNFcDu6TkDE8WuAjoA0pkRhXXqanxWZLGl4l22rsQdZeRz0lRkFf
 8VfFdpGetEs05moz0Io37JtKo/MngyY8yWs+ilkdVoG6mGoELpI7iNKPYw2PhtCRU4Yr
 N9LF/DOe1i+lz5GV7oBIv1YMRHtKyy8pqL2ta76snuOFajqEJ+D/M02sDBflZ4TbwLJT
 wTblfF7Wovm2HNf7QZ+LqpXCjxhHZ8kHRKNhmwQFaDIYttlrfu8/+beAciMm+By/ncPf
 vDdw==
X-Gm-Message-State: AOJu0Yxxj/fRxh4xnBXgKATnT08SLKFzFkBy54eYOnUHG5+DLaB/xW3l
 udEHAJUaS5f11KRNdsapnInryihWsPSiFsgP4f16MZzJibU1Q9d/NDZDcaC00zOHecaYx7HV6aD
 v
X-Google-Smtp-Source: AGHT+IGt7gUCEd8bFDgVKhby4AkFjgpGtJVHCmHE5FgJgDo7I4KP2tmlFNK2ZNrCDTekUpTkFju86g==
X-Received: by 2002:a05:600c:34c2:b0:42c:bad0:6c16 with SMTP id
 5b1f17b1804b1-42d9070baa1mr145801465e9.2.1726751489462; 
 Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] target/arm: Correct ID_AA64ISAR1_EL1 value for
 neoverse-v1
Date: Thu, 19 Sep 2024 14:11:05 +0100
Message-Id: <20240919131106.3362543-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The Neoverse-V1 TRM is a bit confused about the layout of the
ID_AA64ISAR1_EL1 register, and so its table 3-6 has the wrong value
for this ID register.  Trust instead section 3.2.74's list of which
fields are set.

This means that we stop incorrectly reporting FEAT_XS as present, and
now report the presence of FEAT_BF16.

Cc: qemu-stable@nongnu.org
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240917161337.3012188-1-peter.maydell@linaro.org
---
 target/arm/tcg/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b9f34f044d0..01689208286 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -677,7 +677,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
     cpu->isar.id_aa64dfr1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0111000001211032ull;
+    cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
-- 
2.34.1


