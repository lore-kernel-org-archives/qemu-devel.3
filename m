Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FFC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkCd-0002xG-Na; Fri, 19 Apr 2024 05:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkCc-0002x6-Vt
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:06:39 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkCb-0002GG-6m
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:06:38 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a554afec54eso188293866b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713517594; x=1714122394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LidnAl7eWJ4b+0Uo3uz6Oeu4uX46h+VjTtLsUCeSVyA=;
 b=ZeYvCtawaaPqD4CLAHc1ruI015ZLryv1iq8jWqu7xWfDUQD/5AS5e55GpVVlxv1TWt
 bnfA7/zp29fmkSjUO7L9X11gidSbo4TeDIsl/gqoDJsvMlH0G0iMrtXrlVanAnlwLVpj
 tqgcaKHBPzuY6wkzNdKU6y5pILlnt2iCXEsAOmhbNCYYN4hzQhoGYGuRQzfmL8wqYIpM
 w9BYeCu6V3/0ma/V0iepSVtzvv6CCQqNNRvTz7K+oYayS//8vUTcb9OWbp1vG+I3O4T3
 TFEbGw0HSG5dAvmjOYGTVMhgwH5bwgC+SIMWll2sNXmxlh8Ig2omPoVPcxlVQ2NKnGov
 H3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713517594; x=1714122394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LidnAl7eWJ4b+0Uo3uz6Oeu4uX46h+VjTtLsUCeSVyA=;
 b=AxssO4RId81ub8/Vk4AkGVjh2YO30wUfEBZ+NZj5+9E3NFdG40PFeE+BkHPNs4tBGq
 JslE2PW55SOARwdeFAIsvNP0XTOwjW0ej4P7xnKoL4Fc9xkQC95NNInA6vo78YeTC+QE
 Qd1W3CEqLgLClphu94bp50Pv/OMhWIFKLSmdiemuJYp3bIoa8v7KkPShiiWVg28ugBI+
 fB4b1wTXbvUYzkFtCoKNJb7lhgbqmt2gLiJczzjg5z431e/PYQ/Hwg+nyCn2LoUXDaG8
 p2uK8VMNbZhooEyxmO5qti5IO+pjAAOyVxmmFBpU2j2y+612jGqxK4mSwolearVKyccw
 iHKg==
X-Gm-Message-State: AOJu0Yy5wma+UQk5zufn8XCH9tbJNZKLWDQWEqU+O98EPYxcTR1IM9F6
 KwCjRDex9tR55aDUvaNro/+lBddftceViIlv6vd04Nj9LXfuFxGK4xGGh7QtlZfNU4CkTWxADcw
 C3to=
X-Google-Smtp-Source: AGHT+IGKp6+yk/EUpdtc83d9X2R/fScS45iNghNpOxmx91kr9aPFKqRWcdPpwVPA/5oROzyxAOU3Jw==
X-Received: by 2002:a17:906:618:b0:a46:bfe2:521f with SMTP id
 s24-20020a170906061800b00a46bfe2521fmr887129ejb.24.1713517594469; 
 Fri, 19 Apr 2024 02:06:34 -0700 (PDT)
Received: from localhost.localdomain ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a1709060d8b00b00a525a18f748sm1926458eji.165.2024.04.19.02.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Apr 2024 02:06:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] target/s390x: Remove KVM stubs in cpu_models.h
Date: Fri, 19 Apr 2024 11:06:31 +0200
Message-ID: <20240419090631.48055-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Since the calls are elided when KVM is not available,
we can remove the stubs (which are never compiled).

Inspired-by: Thomas Huth <thuth@redhat.com>>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: untested =) Inspired by
https://lore.kernel.org/qemu-devel/0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com/
---
 target/s390x/cpu_models.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index d7b8912989..a89c2a15ab 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -114,23 +114,8 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
 
-#ifdef CONFIG_KVM
 bool kvm_s390_cpu_models_supported(void);
 void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
 void kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp);
-#else
-static inline void kvm_s390_get_host_cpu_model(S390CPUModel *model,
-                                               Error **errp)
-{
-}
-static inline void kvm_s390_apply_cpu_model(const S390CPUModel *model,
-                                            Error **errp)
-{
-}
-static inline bool kvm_s390_cpu_models_supported(void)
-{
-    return false;
-}
-#endif
 
 #endif /* TARGET_S390X_CPU_MODELS_H */
-- 
2.41.0


