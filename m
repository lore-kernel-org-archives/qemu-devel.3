Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA08C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTgL-0001aR-JU; Wed, 13 Mar 2024 14:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgB-0001ZQ-0a
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:19 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTg5-00048E-W3
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:15 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5131316693cso261196e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710355812; x=1710960612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cA2TT9vWbQLNZEplCJtFv+ktuA7SvmljLFLbMp9Tj4w=;
 b=D9XA2JeYuliooNtIgl5agwclxJ73pP6GWAj7N62L51Y83gjC+XJuMl9aaTG/zH9dpA
 2mJqkh+EybJEjtF3/ZGYuOs75lSjMDuRMZAUqnKnd4+BvtkstOOm/fUQP5X6C4BEfylc
 6iSFn1fmTayyFiiP3GEluxtxSkssp1W70gV9Fijvqdu++3BxTKTJ77giMSJrFwmBHwf+
 fIQomMs+kifyc4hyRVBGCM++NtSL9D2wt+nsCkQds2/nttIuRPfIdUoObD1vJPdqvkOo
 KYF4JdcBhohz0Yx/ZszIqOnJ3PbtMfjBPlr2fpa0YrE1YBpa0+mDz2wnB1AMkxYKi9zq
 2L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710355812; x=1710960612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cA2TT9vWbQLNZEplCJtFv+ktuA7SvmljLFLbMp9Tj4w=;
 b=uebUbYQuIfi1nIhxu3LzF23Gi5ubL1hTs5Hk0DgjAhGXOGECIeyjP5fGGejSu9rzfu
 FKxcFCuM+/lPmRFwQPD8EYkJxBQeHJOJBxf/Pd61Plc1qam0U+F6uMalCPsQ1z79ZyBz
 S5/LSuJoU8TDyp2fT653dUxILLQ2cP8aA8FjJsZgwspZUQ++N6cmJZmO8Dh/pxD0zgv6
 Qs5EI7yiSCCA24NH7qZx9kMBV3IONx3PkvRM8twbXdPtGEmckNIojJbSA9rTnG4avHr3
 4RatvkqDLbC4RdwhWRJKssrJyE9vwtp+jlxZKo2Mp318LTrfLKC4c5m/MpmrVYE58P51
 M6Pg==
X-Gm-Message-State: AOJu0YzpP7CN4CZfayh8iDUsoaOysPE3NV2k79e8bqVfeWibVOQDLtv6
 2uBEp9PJ44BEXMKF5XGbMNIdKzDuWwAs83Pjf2ov/q00WJNktbYZDaV/BCbxKJQAQlQ6qIyiu25
 r
X-Google-Smtp-Source: AGHT+IErD8+wsDFyofiAR17/n/Vx51vdGnap+p5x0vXw6nHzFuP2CiGJWNaob7zogYFn+3muVuph5A==
X-Received: by 2002:a05:6512:3b12:b0:513:2329:4308 with SMTP id
 f18-20020a0565123b1200b0051323294308mr6796012lfv.14.1710355811959; 
 Wed, 13 Mar 2024 11:50:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b004130378fb77sm3129692wmq.6.2024.03.13.11.50.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 11:50:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/4] hw/arm/smmu: Avoid using inlined functions with
 external linkage again
Date: Wed, 13 Mar 2024 19:49:51 +0100
Message-ID: <20240313184954.42513-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313184954.42513-1-philmd@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
inlined functions with external linkage"):

  None of our code base require / use inlined functions with external
  linkage. Some places use internal inlining in the hot path. These
  two functions are certainly not in any hot path and don't justify
  any inlining, so these are likely oversights rather than intentional.

Fix:

  C compiler for the host machine: clang (clang 15.0.0 "Apple clang version 15.0.0 (clang-1500.3.9.4)")
  ...
  hw/arm/smmu-common.c:203:43: error: static function 'smmu_hash_remove_by_vmid' is
  used in an inline function with external linkage [-Werror,-Wstatic-in-inline]
      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
                                            ^
  include/hw/arm/smmu-common.h:197:1: note: use 'static' to give inline function 'smmu_iotlb_inv_vmid' internal linkage
  void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
  ^
  static
  hw/arm/smmu-common.c:139:17: note: 'smmu_hash_remove_by_vmid' declared here
  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                ^

Fixes: ccc3ee3871 ("hw/arm/smmuv3: Add CMDs related to stage-2")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/smmu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4caedb4998..c4b540656c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -197,7 +197,7 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
 }
 
-inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
 {
     trace_smmu_iotlb_inv_vmid(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
-- 
2.41.0


