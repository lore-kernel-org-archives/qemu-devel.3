Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B0BCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jPS-00035y-It; Fri, 03 Oct 2025 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLj-0007mW-JB
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKB-0007pC-Gm
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2461172b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511518; x=1760116318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=JQsMTjhkSXTajJk5u+7tbZIrE4Rm4KmnOS5PfKqu4V22ZjzhGH+1IKk4F+EWbSmd2W
 35uW5ot1ME6nhQx4CIgJ+L0L9uaKKfZUdyOUwUqpmz8gXsX5CwiXa7izrs61ifxGWSg+
 YugX/BXd3avpcn4qc8WoZdDb5vqIBe9fZ1oPnYzdbYxOJzr6g9Yca73NyyAyLLFBhb+T
 vBc7vr7yJmykg74ucFT6M96DFie9vUyW8try3mY2fx809987MzUtJFeypXYn6oKlgaqS
 oECv3EPx8eEi9hQfA0Ht/AO0u1tnEvPSJ1HtQoT5Wifej/lesAEGu4g3LTfRUYZNSonz
 YiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511518; x=1760116318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxayGpcvk1WgEIrwtrnI87HtMykvmuTE7R78plec4rY=;
 b=GllC8E3/mXx7MJ1fddHJ6stRpxuiMwzdm3Sme/mLNjeS1nBSaD6CcbyjcI4OPXE9xh
 DqGCvj0KbtbcYXqEs6GBjyW/NFgXrUaiYYR4aPuEUh5yYE9w1/QDS79w0Hx4eZPHCZyn
 7ywg4FKARv6OoeO4CvY2lzusuV4IvLMJsbME029rY02MIthbkP0Wlj3ygdb4rL5sqU//
 +87uyzfsbL3PZUK3CtkX/hXrvvKE/RJNmSjtruCdmpY77QsmPSxk6Ty+tOWCxhXfJVt+
 p2qboKTZahmisvKcjfBRhU1VmgFuP2Vc30db1Wu/cl5xPEJsXoJnMIo+oChwRT11vGJl
 ZJdg==
X-Gm-Message-State: AOJu0YyexC66tnhK5LRNM23HeX1hBxJFS+sjUWTz/xSzj+rV+cvHcP7F
 74UoCeMMidvMPy4aOaCnNBD+F55GIfq78+HorcwkkV3RYVTpndGugrgX4XYL0+0TP3s1JjLhvad
 A9l2A2Vs=
X-Gm-Gg: ASbGncuU/iPfLRQl2M15GWWSvV7O6/15gwXVHHqJdGbmN1NdFRa7Dg04erEjDZxNmOD
 Hv5HLzFfMrMRntH2NWNqdre2zwvrbcYvI+Xk0AjaXS6AzaO2nBo4fbdv+YgL7FefQXThm5A71QE
 ux5V33Y8S1i2WhoLuzYpJOhg1pS9c4xk/2xwl19KpDcL2Ztd0fmk/hovVg+gtDo87JR4YmWJHCm
 T7kqBiBifn125KXo5ibX3qj2wucYLJgiL8l7Rrso9oU7QVAZKoc0KiLIv8aHd8emn4uhjA9tk4t
 ZZMpO2B3Cl9vKc9t7mi9LLXlOJdb/PZu4UfF4yrvSET478PDCj/wU8ecPh/fEYVzn+vVEt1sNm5
 InwvsbUQ+7j4nSiBiiEUGa8EJy+BrMyx9wFoKDJBzwzTJ3l2utEeqXNET
X-Google-Smtp-Source: AGHT+IEF6i+ab9i/ZYG9tyI9q++ef3dz4Hj/rPBtVo8KDrYWF3/miU6z2fAkUqmmUOxpdy4JIUEoOQ==
X-Received: by 2002:a05:6a20:729c:b0:248:e0f7:1331 with SMTP id
 adf61e73a8af0-32b61def0b4mr5374868637.3.1759511517727; 
 Fri, 03 Oct 2025 10:11:57 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 62/73] target/arm: Enable FEAT_GCS with -cpu max
Date: Fri,  3 Oct 2025 10:07:49 -0700
Message-ID: <20251003170800.997167-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 76193826ce..8ebb0a91db 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1206,6 +1206,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4b07af9eac..21c187a464 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -73,6 +73,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


