Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B524CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDk-0005OC-4u; Tue, 14 Oct 2025 09:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDi-0005NX-VQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDf-00011G-Qy
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB1cEppwLCqDji7ECAgcmqsbb83VNwGMahtfkyO/muU=;
 b=iZqVEm/B98VA1JvS0sMqw5QW2nEDZ+NbNbtAUs8eqDE3LcSa38/pEYK0Q3a/vFC+ojo2VC
 Jk/CQeNtNUZmgizNEgcnCJweDopcQ9Xc8o8h/dcRqluC3XYw8DLIh0+nDzveqFrh/RSoHP
 U8FxHIt23cqtKhW1lN4B3VbdB/LA4yQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-DHyHZyzwOl-FRxo2IexCDQ-1; Tue, 14 Oct 2025 09:37:30 -0400
X-MC-Unique: DHyHZyzwOl-FRxo2IexCDQ-1
X-Mimecast-MFC-AGG-ID: DHyHZyzwOl-FRxo2IexCDQ_1760449049
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e31191379so39306795e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449048; x=1761053848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uB1cEppwLCqDji7ECAgcmqsbb83VNwGMahtfkyO/muU=;
 b=EQa5JnalE/f5Ilw009vz2n0cboEHz0c7NUsr90Nim0N+hVJccPFOeA95+T4Utl1ae9
 BdZeES3aXa2gsueXTR1zFxA/jNpDj43r2NJ1yc87XKuJfhV4hjAMMABPViX6Z+jaMgbX
 mG090Eu27t99xK1NfKKPEcGeq2K/uA+52oTJxdePc+fF+rDOeJ2kpj5BS8yq4urJ9mMO
 6IvZdPaJGE9//rV0uYtH8yVaZJEx8ZKn+RKE+qrpoy2YCIxCrII4Z48rvkRw6kUsbr2f
 h8kcePk7Bd5KBlDb8GwmpzOZ0/bhwpOMDBF1a0OdaB4qwL+x1aNC4cyoTBDukrBmBCB5
 COfw==
X-Gm-Message-State: AOJu0Yzn69Z/knAw/MWOlEHB4y44//PAsiO3sJDrVzmLf2xsimJvTk2D
 nod3ecT0HKSiSGEkh7aLtYt6F1AMGgQDntyHCkRP7NSpm+d5teMGnKAMhVSBRHqn6aqvoV3T9Z0
 kUhSK9e3by5kq/rbG6wZLG0AnfJ0227xlhLvm2Nd8Ffl+2j6lMszEKfjzXbv0uLGENT9O+DhvQa
 Wx5dc/3sNb9OnsQZRa73LICAowzKqsuxCK3xLLwClp
X-Gm-Gg: ASbGncu/ZcMMP/nHbJ3DDxeSqbLe1/0dSG5XmoE8IRzdkS2bo/0/tCEtVE20dYIKUAD
 TIajKI7EZhlb9QXM/qpM5uZHHXMuMh7xlqmXw9uepX4EI3rXp2E+we8SVZADcIBYrFT3PckMGHx
 9IWLln+20OiwlxOBLmm3GQnT690zblueJB7/E0maPVdKt4ElMyAwgYkqS5qVzZwmImiHuj5mkoU
 RRrhItFUzSPa345Mdy1k9P/4vhfdwgO6s81nnIVUgo0D7RoZheJjBfHDum+zrG6KpER+EdYbbaV
 nHc+g630Zqt/+5epmGrb/8Q5JYzF+KqS9RGoK4BOkirV3Ux1yXyOmQSSFTWau5uXYq8OdX01Gjk
 j9SIvdn1ivLkTFNX2ASuQw6WyMA01hRItvZEjCHkuPqw=
X-Received: by 2002:a05:600c:5248:b0:45b:88d6:8ddb with SMTP id
 5b1f17b1804b1-46fa9b1968dmr182733005e9.37.1760449047849; 
 Tue, 14 Oct 2025 06:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/PLwuDlRs89C2Oasp7RH2ymVPKoR+ghQxTz11/pik7JgNjVryzuNOxLzeq4nGxdsE7JUYqQ==
X-Received: by 2002:a05:600c:5248:b0:45b:88d6:8ddb with SMTP id
 5b1f17b1804b1-46fa9b1968dmr182732725e9.37.1760449047406; 
 Tue, 14 Oct 2025 06:37:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a60b8sm243488485e9.19.2025.10.14.06.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/28] target/i386: Add TSA feature flag verw-clear
Date: Tue, 14 Oct 2025 15:36:51 +0200
Message-ID: <20251014133713.1103695-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Babu Moger <babu.moger@amd.com>

Transient Scheduler Attacks (TSA) are new speculative side channel attacks
related to the execution timing of instructions under specific
microarchitectural conditions. In some cases, an attacker may be able to
use this timing information to infer data from other contexts, resulting in
information leakage

CPUID Fn8000_0021 EAX[5] (VERW_CLEAR). If this bit is 1, the memory form of
the VERW instruction may be used to help mitigate TSA.

Link: https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/e6362672e3a67a9df661a8f46598335a1a2d2754.1752176771.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 ++
 target/i386/cpu.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f74f13534e7..ce948861a76 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1104,6 +1104,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
 /* LFENCE is always serializing */
 #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
+/* Memory form of VERW mitigates TSA */
+#define CPUID_8000_0021_EAX_VERW_CLEAR                   (1U << 5)
 /* Null Selector Clears Base */
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
 /* Automatic IBRS */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 339881b40f8..4f99cbc5c0b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1397,7 +1397,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
-            NULL, NULL, "null-sel-clr-base", NULL,
+            NULL, "verw-clear", "null-sel-clr-base", NULL,
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.51.0


