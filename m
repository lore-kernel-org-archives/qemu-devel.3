Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDB7E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUR5-0003vG-Dv; Thu, 19 Dec 2024 23:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPN-00010q-TD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:39 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPM-0006pI-E1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:37 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-725e71a11f7so2030682b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668075; x=1735272875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zHRYikYlUcGaNY1VZY67VXJBI/Xxa/TUZTqCG4A2qqU=;
 b=FPJMWxhx6//IBm9AMSVJvU6TskweitBpOHpNYz1/anR4t3HL0t428iqBfdGcKYUcZZ
 XRmIiHGlBo+aXINUap1mUKHFVxd1fwkCRm23TINRpJOa8gQ62RDuhfQjp05pEmXhhny6
 9WNJ9R5uLB647DRx0IVSj+qI/DBz4ykONa+xAPWdnXEncvZZvohA9GZKYi5MUO5B2Fmp
 T7ubLFk1jVi/hKEdRh17PCOwkqaktiojOX6JsGU0Ai/riTTe+oQB/FdHtqPtrZzZ29BR
 /MUmzOhbbEgBNMPSFyBXOMdJS4cZvaqnGbw+JWePQMLAtW5D+xJccpxPLY3bmrcFNp8V
 JVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668075; x=1735272875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHRYikYlUcGaNY1VZY67VXJBI/Xxa/TUZTqCG4A2qqU=;
 b=IH6J+ml0Gyv97A+PurL99g+/FQdIlPuoDYjS1BCsKUG3Z0uLRudTQGLAv48/XypBzG
 O4p7YCe9zkJC3sSFVnA7kGLij6ydFw5CpMtzS0wEJYfmS+OL2/m+WLfe+jPobheKzb+L
 Fa+njOixcVdwMMj6FaTRSJLJTo8q7Mp/nJBCqWcm2Pn9cifjcVIL5r5pfpdWPxBaYxsu
 1DnFpXwI2sR/CSUElAO4m1XUX5MmQMtlPSi3cVnfxt7/EFydpQvhOLSEQLGSVrwRpmMJ
 +lchRoeduT+o+hPIktVVIQ/cuSapzpBz6hyq/I7/SpNLDJm1MqyUMrVsH0KJq+a1p8tS
 E7ZQ==
X-Gm-Message-State: AOJu0YwErfakSGA9SIP9oSh3iXthlVtQ+IrD3Lkv9Bxq3/yYRknjVS8l
 eXgi/p4FELeAFlqj8qRbNhjQrRiU4rXBWzPwBMgIBhd7l0fAIKQe7UwP2/kNQiNv7emW979woP5
 b
X-Gm-Gg: ASbGnctpDLG09OGJo5XKMe17/z01D/GAE+LDFmexSc9Hb/Aue1qZaL3g8WyMQbVAWEb
 RZKHjDSTLDS4L6T7ENnKYtWpXCllqojNBUAKHhJYJOxNDIEm9mspvDmcOLwICnllnpmnSUHGQSN
 mLIaL3uwMt1IEhZdHPd+q90B5A7l6FduSGxFSJFpzr0AtU1gQgCDnMBUFhQrV+QagIHyDqx9T6q
 seVyPtXDT73XIp5OBsUgoXETMR4F+/TP3R5/lF6sr477HzErUE9E2DDJaKtnjU=
X-Google-Smtp-Source: AGHT+IEMM2Dio2c93q3uWmEsWyIMalPHfheUKiss0qaWryad2G+Uxhpappwlr3q+LmfrK6Q/j/vyJw==
X-Received: by 2002:a05:6a20:7fa6:b0:1e3:c763:74d4 with SMTP id
 adf61e73a8af0-1e5c6d6b62dmr8829195637.0.1734668074876; 
 Thu, 19 Dec 2024 20:14:34 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/51] tcg/optimize: Canonicalize s_mask in fold_exts,
 fold_sextract
Date: Thu, 19 Dec 2024 20:10:52 -0800
Message-ID: <20241220041104.53105-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Simply or'ing the an input s_mask with the mask implied by
the sign extension operation may leave disconnected bits
to the right.  Use smask_from_smask to canonicalize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d0a9ea1ee4..8735dc0c9c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1827,6 +1827,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     s_mask |= sign << 1;
+    s_mask = smask_from_smask(s_mask);
 
     if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
@@ -2534,8 +2535,13 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
     }
 
     s_mask_old = t1->s_mask;
+    /*
+     * Use the sign mask from the input, force the repetitons from
+     * the sign extension operation, and canonicalize the result.
+     */
     s_mask = sextract64(s_mask_old, pos, len);
     s_mask |= MAKE_64BIT_MASK(len, 64 - len);
+    s_mask = smask_from_smask(s_mask);
 
     if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
-- 
2.43.0


