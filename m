Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8839E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu2h-0007ic-PD; Sun, 15 Dec 2024 14:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0F-0004mb-Vn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:08 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0C-0001ZR-UR
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:07 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eba0f09c3aso972099b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289802; x=1734894602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cg3lUmbt7wwIutnt45V0TVXZjKRNVCq8SHBaFS/d0Ew=;
 b=u4m2+KusrfxgTeagG5lMRbvXRvWdmofcd5Yvi6rPQoMWIdVipDh7Vn+eLpibytA3e1
 IgCwjZW8T1VmATE9t8kKQ+jkBlgMOQ3da4/f01bAhqL4kgKNuxO0mRpwpXM2UkB+KH1D
 K0kn8pU3CWQIsf1exg0SNxMjSIgNomAS09X09uNp7nTewkVoKWPx8vGyrW6N6Yj3UZxD
 Cdm8rYNbZn4WM2VKpRMexxnUusDlx6/UM57Gi/P1IYTThM89XduGmrf0dJIa5PiMtfoc
 OkocxFqZi6U3/So1dkcMa83QWdvMZw7W2YNDR6Vdwpa/WCGaPXuOvh9MwhTf8N9cFz6y
 zSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289802; x=1734894602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cg3lUmbt7wwIutnt45V0TVXZjKRNVCq8SHBaFS/d0Ew=;
 b=RkurslXoMtUGEPmBID+b7iaYXVd+dhBceboXgj3psYjvOWwu7k62IimqL/ykuVdFGl
 tPECduC6ifsI+uNmALWF7BxJSlXDq3VCULBZhucrK3UDClwgAVvcrgLz5ncmCBVjJu4M
 vqvkFq3MVHnNfLcqGPychxf+8eL/FQ6spN9wZx7lbN8oE5D5ohq+/RIdb5JSILBSG1D3
 dWkHouGvxep2oDrV1AZMxBOdmn7GIRaVHI0Ec5ToeVbHnT5KJrV5EOf1j4gcsVivaaiZ
 zvvsZerRwBPgXkPFCatIONRsn3FmnoR4CdwodxJPNud1ZaLaA32PMxosXpzdOoFXY/mO
 zPlg==
X-Gm-Message-State: AOJu0Yw5EQEEJKu2BHtstZhv6R98u5LtNOw2tD0/LdcVwIAJX6HpCwYD
 Zi4u8AiYFEjMvIpzmzpLhi1XR/1iqy0QXzr91qoDdtuvPuPrcHEc3AY256ps0bdHTBwWWGr3Fld
 qLKGru1+y
X-Gm-Gg: ASbGncuZM1tSuoigG6i/7Dve7xZuCBTuyvgmWUGJZKSEPOLLWP04/YkhP5zWX2cysIH
 pXbUUr5tpgcJAMKCEqVq4KMExhIEh9ab1LUUNClHfCdU8JWC+jcqa0xUXAXZQbB1v8VrJhjDZ4F
 qnSYTwuLVc3HyzKKJXO3VVmQEJAtvE2c4ebS0/+DIKavi2c8T7r/7f7CqNDKsm9WF+dS2IDVjUJ
 D/n3z5Hw64Hp1suwcXzoQnnSwrdYNW54VkSM3JVbZ6we+JwSLQMAC5XXPxDFl3XhjuXBeRMbc2X
 aesGunAe9+pmr4jLType1urlI9y6+BjKEjB8AWnBXbk=
X-Google-Smtp-Source: AGHT+IHZcmXzhxe2hqpvp3WPEeQXeLiwKYkiBlwsTcABnVXsstvQ0Dp9/pXsCtb2MaKqLDJHdFhgiw==
X-Received: by 2002:a05:6830:3695:b0:710:ec4a:b394 with SMTP id
 46e09a7af769-71e3ba498a1mr6814946a34.29.1734289802396; 
 Sun, 15 Dec 2024 11:10:02 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:10:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 66/67] tests/unit: Constify all Property
Date: Sun, 15 Dec 2024 13:05:32 -0600
Message-ID: <20241215190533.3222854-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/unit/test-qdev-global-props.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index c8862cac5f..1eb95d2429 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -46,7 +46,7 @@ struct MyType {
     uint32_t prop2;
 };
 
-static Property static_props[] = {
+static const Property static_props[] = {
     DEFINE_PROP_UINT32("prop1", MyType, prop1, PROP_DEFAULT),
     DEFINE_PROP_UINT32("prop2", MyType, prop2, PROP_DEFAULT),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


