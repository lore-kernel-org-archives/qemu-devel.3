Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023DEE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mf-0007Hc-Pj; Thu, 19 Feb 2026 05:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MU-00075l-4L
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MO-00063n-Kr
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso6185865e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497255; x=1772102055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MsmPUrRagvo2cMfuuEF3Q3H/QYPRKo/Q2Vmbz/5Q72Y=;
 b=ujPcbOR56xa4CS3WX/vTKkouXXGW4gQy8DUFs4GYHDMvoKwDjO6f/oAMQv1yecPJY/
 HcZj0HNf/b8dA3tQtmYjkiPUClClhGEMTIhKku+K2xiDouNGJ5Sz9Nbr7qW33jqkOEmI
 bSad0wmWOKpRf6lIqUEq+S53xSdJclJz4drFeBTEkZ4cWTh+Sf8aLdBnMB2WjL7uutoJ
 DF4iIIGQWktaASBqlkUjYsMXuB8g5vz5OhKWZz1Ub/A0dLfFZKMMrH0tPx0W9Rldm8Oj
 8LsBv8a5LBRcF+T0BonfSHnLl3q9+G4FBQh3CWbonWo9DUcjexTY7sEedhRrNpUVU2OW
 u0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497255; x=1772102055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MsmPUrRagvo2cMfuuEF3Q3H/QYPRKo/Q2Vmbz/5Q72Y=;
 b=AYNV0GpIn2cEmJi4xidi1evxyDx7OTrmQE3X8KoQ9IecjZt06IvYgKXsHYelF6eKlO
 XmQrKRG4+C3zai5RBo11PI1GasRubvJ2cL/eIc5GJszLiQsKauN2fIJ/V69b/XPQz8hL
 GUy28ayTrzCA849+rJi5OBi9noLk8jEZtwjYDxAud09Jw6ni4p7MBBzcGW5kCU8qPGVa
 Ps/thmNIZAYybeHSMToexyDScWSHVcFT6g0yW4OuYsCe3pOo9yMY6wSJ3dcfs5UErt3X
 bFcXpFFzxoTG19hGWJ98rA1eL/oULkCitQVdbTxDBE9I9rt9gzo7Yk/5LEBUQN2RMHYE
 HDNA==
X-Gm-Message-State: AOJu0Yy9zHaqaXQ+URbF+Ty0BNzJtON38tuCLaHeQLjqyqlC1kU/lnkK
 b2KFtaU6fc53KB7500JuUGhcD3lgZ0x6JTO4hxwyCXm5u34JQBGQMMqzXsSu6Zem+7VOD13OmBN
 VEdXw
X-Gm-Gg: AZuq6aK9/UYjlZ532krH+zDs6HFcQ26j7bYTfhlaGf6Lufg1ZSZpYX63WjhMlSelGTy
 rZFsftRm+YQoYi+SSjbFYY48yZegWAPIxLg8gel0PXlQbxzNU15U/Z0DiuwJs8vNQvsbywMSfKR
 zpJ2w8uejbrjNytR6OtUSqQAt6rnF7+X4+8N/SsbngkPhMb4Nsqgv/masSBDSYs8r1OZt0xrhox
 BU0nXegvH0+gWSb7Osnaoc92efwYngXIQlJWoGQZdaLEP8PXSaXegDZDojIAcRA4q2+6qPbzChG
 nJraRAdAV5Q6l8RMmN8ZmLwD9V0I4ddjTyXCEzKE5TVDYGpxhRcEBkC+hEWn/T0J0tcoGPJc5r6
 0inwJYVOwp24h5gL1fPHh6/0X7NDHF1dRvwH5tMPO9PgXoszpNVXTXoloJwYMWF9EkhVe57F4vF
 qHi0jjjm9xOSsluwHLQVGXT17ONOp2Nw/Ch6emCM3nCTzASAysmKRk2wMn4jyuXa9thjHV/lLYg
 4+nxOEpm5btoDKjxo56TtgbxgwReOc=
X-Received: by 2002:a05:600c:4e42:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-48398aee810mr93991525e9.33.1771497254781; 
 Thu, 19 Feb 2026 02:34:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] target/arm: Add aa64_sme_or_sve,
 aa64_sme_or_sve2 features
Date: Thu, 19 Feb 2026 10:33:41 +0000
Message-ID: <20260219103405.3793357-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With FEAT_SME, even a CPU which does not implement FEAT_SVE is
allowed to execute the subset of SVE instructions which are permitted
in streaming SVE mode.  We correctly handle this when the emulated
CPU has both FEAT_SVE and FEAT_SME, because sve_access_check()
includes the logic for this, matching the pseudocode
CheckSVEEnabled().  However if the emulated CPU only implement
FEAT_SME, it will fail the initial dc_isar_feature(aa64_sve, s)
feature check, because this doesn't match the check in the
per-instruction decode pseudocode, which is typically:

 !IsFeatureImplemented(FEAT_SVE) && !IsFeatureImplemented(FEAT_SME)

Add a new aa64_sme_or_sve feature function that we can use
to update the relevant uses of aa64_sve, and similarly
aa64_sme_or_sve2 for where we need to check FEAT_SVE2 || FEAT_SME.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260202133353.2231685-9-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 49c50e850a..6935ef2f78 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1522,6 +1522,16 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
+static inline bool isar_feature_aa64_sme_or_sve(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve(id);
+}
+
+static inline bool isar_feature_aa64_sme_or_sve2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2(id);
+}
+
 static inline bool isar_feature_aa64_sme_or_sve2p1(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme(id) || isar_feature_aa64_sve2p1(id);
-- 
2.43.0


