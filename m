Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1EFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDM9-0001Nv-Mn; Wed, 29 Apr 2026 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM8-0001Fc-0S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:08 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM6-0005Dk-Ed
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:07 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso151301a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501565; x=1778106365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDvXDQ+fyFCHbP0IHEzFnjC3uz7yibpL+nfcOcMhE5M=;
 b=JqJ3wVZoD9VpMgWTlOBDV3CEMxFZt7OVv9fp7eWhSbOATi6PtrrjMCACcO6MYKSpbx
 A4DL6fz9beF0A9Gq+/hf632CIMuzYkQAeD6m8US+1JXYYvzXyUr+S2+xq34W3duanmOm
 D88LSk6BX+uzbHgHjWaApLkFkFY+aBLYBiaV6roFLljXh0GKKDdekxX/XmgQ67yth81t
 Lze9waO9/krghMtLwagCEYg8N2b2TUB6fyfJx8Z3g/t6PPRi/Z1PbjBsRobVcq9B+c4m
 2WW05llELEQRLSlXYLcq4CsJDI3DP8hfZQMHjF9KUhd5bRaOH+P8UO2QyADqm0U3+ZkQ
 bkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501565; x=1778106365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kDvXDQ+fyFCHbP0IHEzFnjC3uz7yibpL+nfcOcMhE5M=;
 b=RZNkjv6+ZYim+eQbAlZCpF9jA/yKq1QnK6PCKG1VH2Dwtf6yHMKd5HoVxBxpFCnrjO
 lC4fBDGLLXUC5uYoqNisy2yS260MWNnoiSLgIFXhyWexZINbz2fidHa8uOA/xQuymVAD
 8KSXHMFY85gNEbvxT+u1SDVaJ8I/7xFdatdpOdFxeSXTBTV6t5EPptKNTi60bQN+Y2Xd
 4m9kXhPEo/+H1ntKuKQ0DPaErFWyZiLexh5T5sovu2pDRp/qVnY/QivUjSatqm+DdfnI
 3Jbi6P9gV0rP9giJO+uMBdJ7yS9FYKW6iuwKfDAxQlLFGPmVmtx4NdDBIH0fa/jjRFW1
 h/8w==
X-Gm-Message-State: AOJu0Yx68fRECGsM7VZHmDrOcjrYhlOTPqeokvPlTLQVS7r247mQ4PRs
 /sgdnvsfID2PaQLZREd02zDffBjqAI398Ew6gadluCyU2LXFV6tRXGvXF7bYJXnajZdBn9bkssO
 6ZC36ubs=
X-Gm-Gg: AeBDieuYzv68FXUVp8zu4zjFuVx209MuoysOwThZxF4axw/H4XltGd4/NsuRBOalgc1
 3tsA772RBE++j42MSv4UmcJWKWIpvDVI7BQweb8wDr0FtUmBHN24lVfpkPuMGT45yj28/IiHs/n
 QpHnhChTztP3svNPkvsZ81GnTaTFYtH8sZ7prrob9XSbGUeugNsblmlUGemj6O/N5DnBjv0GJjt
 fThYJe1+5ncGMbnrgv2RGmCrpegZllUl3gPxbbriL6209hjfp7F4AeMPmuf8gjtPGRlWASod9TC
 GPqWYHnBrvx5rn4Ihr4BWjGIj6w1e1k5KdOlUuU5vY+tXRXOC3cF5+p0TMo/VSxuz2Vhhh6YX2E
 +atcoFswGqXsgoQKvk7SSo/Q4dLuiCiQSUjiekHmTM0gzexEs/dhjd6HeD4braTCs/xiW2FSzFr
 aqG2PPnOh0sV9/d3iyX1DM56QXmAY3X3EWH9jkqx3T
X-Received: by 2002:a17:90b:3907:b0:35d:a3b4:2ef6 with SMTP id
 98e67ed59e1d1-364c30e8b55mr169384a91.21.1777501565094; 
 Wed, 29 Apr 2026 15:26:05 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/48] fpu: Drop PARTS_GENERIC_64_128{_256}
Date: Thu, 30 Apr 2026 08:24:26 +1000
Message-ID: <20260429222445.26301-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

These macros are no longer used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b1c2f884fc..d077e8da69 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -770,15 +770,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
-#define PARTS_GENERIC_64_128(NAME, P) \
-    _Generic((P), FloatParts64 *: parts64_##NAME, \
-                  FloatParts128 *: parts128_##NAME)
-
-#define PARTS_GENERIC_64_128_256(NAME, P) \
-    _Generic((P), FloatParts64 *: parts64_##NAME, \
-                  FloatParts128 *: parts128_##NAME, \
-                  FloatParts256 *: parts256_##NAME)
-
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
-- 
2.43.0


