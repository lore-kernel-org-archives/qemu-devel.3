Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8C3CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3en-00024o-Kf; Fri, 26 Jun 2026 06:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ee-0001Al-5O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ec-0005Nz-8i
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuaCIBqbAEEM5rWDY83KXOVdzkSLuV45P6OsTJ+LHD8=;
 b=eafA6opeTQy/ZeVzKlGkjNY+NcXpvEw9cDkRGn3tIyVkCZLEPRLxKrS+u1x2gSe7IJXJMc
 MceC92ch17fcsP3mGEEn8BqccANpHwVhlmUnz+rN4KJIMqem+0bEHzXN+gxWqJ5pYFyrRW
 tqQBXeYbfioLVgCOAT7sSDg7OKwBRJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-TeHFs5iBPeuGFKAxMTOBFw-1; Fri, 26 Jun 2026 06:19:20 -0400
X-MC-Unique: TeHFs5iBPeuGFKAxMTOBFw-1
X-Mimecast-MFC-AGG-ID: TeHFs5iBPeuGFKAxMTOBFw_1782469159
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4925bf70f5bso6251615e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469159; x=1783073959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuaCIBqbAEEM5rWDY83KXOVdzkSLuV45P6OsTJ+LHD8=;
 b=bQDjpGzGNAUnCs9ygATSa1CupOW5nV/zB8nC71mKhZdmFyo6M6lhYGJaY1aIaUNMdG
 gQmJlyx63ggmHJBXjaF5AhXnh7jQ7UxN8eesNG3Pl2Un/SgZUmT0vRYIMqrwvzbbT/iS
 pmeYWlIJRF0mg7SLR3w2snWZ7bO6wJy4keO3Sh23hVJUQyZia+m7DrCzTgb5tphBXmGF
 gjRTHRy0wK2vNmeQp4xsUu9asKvA5rO5CsJvdqsf14b2GRuaLolx2b6AQYeTcmU3uyGz
 SV6QqULyL11hPShze4QEdvtRXg06rG7RHF2qmh80+BNC7IzHcDfnp5eBzEUCzVV1ZHoK
 hVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469159; x=1783073959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuaCIBqbAEEM5rWDY83KXOVdzkSLuV45P6OsTJ+LHD8=;
 b=faKMxhOYgfFdgNsitLvE+/g/KRKwCpw1ysEOJAc5uKP09AL511GNEKIK+Af89jXFqe
 n5svHxelc2UxzWXjH4kI9PCuWvXkPa1fdoYawKiLcLMEqd376B3Iq+5L/1qcmoLcdtc+
 xZZX5CMYzyLo1rer/fJPBNU4rskwfMZB9vLBFGO1P9vVwIX8CzVkgJv3RKgodFO9oLbs
 IikzpN2stQPTy7B7pCujrK6bz5hIz8MOchEVX0xNCpOOn0qmIkSTF93R9X4TOAyCAQjw
 PKYeruklLNzlC2Gg4QwhV5AuN1cDOdTJ6NLyWMswbNALS63YxzQ3lWrCDrJokjGJ3AFn
 0Xkg==
X-Gm-Message-State: AOJu0YzUGae2/6RyWVkuiUG1iM07p3zacsD+t/jzcVD7DKpnsN/TZjMy
 NoTi07MxQBFuMZZsKNTiML/84JDidwkBC9yaQMMtvHRC398OagtpfSyDZ3vpKeoRvsUoiBagofC
 PIHlO2k1H7hZRZrV//NAr9lc2nkZWakJouJfEBKFEPyX4FJg6pNxIxpORYpElQTMQEFyRszbzmy
 f3K2ilpye2vh3BQdDHGEPjWDYPHj2iDVqZs/bnQpC3
X-Gm-Gg: AfdE7cmOlr2p+cxYvwJkKYQH+fARcOTWosokIWq8teFTALWi2amaauQq5I9LMMas6hX
 huUfZcAarG0MSFf6x5Jq31JtecCNeJDuKxXQ0H2SATImVB1wmF0VLgO+zE/Q2dWEw5/rxTA3L1k
 DiP9qFkkUjKK/n4Ht6P4upui+roMHonDnAKULL+GJl0aIH4JuXYdQc4eIq5vXqG8HpKJ0/B9TLF
 uyVGZ+91TPEYJ6SH8cHo4FbaUKwUQnspsh1ptp6T3kRdIPt/RDvofZ54tAAz14d76URw7jkH89u
 YmFXXt9U9OH1Vhh5VRwjQGBKU3s0JZjeX6zqX8lzPpi/m2U9vBKcmhonHQSYCSeYfwBB5Sy8fbH
 zz7Ekz71TxhC/Dtb+4O8M4rOb9YRycEtqkXPEoxWOeQJoRryKEotzFNcLQ54YhIi2qTWVbVGT4Z
 BMnWjz7gIBJCaomq7h
X-Received: by 2002:a05:600d:6454:10b0:490:e243:4806 with SMTP id
 5b1f17b1804b1-49266866378mr73931015e9.9.1782469158908; 
 Fri, 26 Jun 2026 03:19:18 -0700 (PDT)
X-Received: by 2002:a05:600d:6454:10b0:490:e243:4806 with SMTP id
 5b1f17b1804b1-49266866378mr73930675e9.9.1782469158488; 
 Fri, 26 Jun 2026 03:19:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492691f60bcsm69684995e9.1.2026.06.26.03.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 32/45] target/i386/mshv: migrate CET/SS MSRs
Date: Fri, 26 Jun 2026 12:17:35 +0200
Message-ID: <20260626101748.1728079-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This change migrates the MSRs required for CET shadow stack and indirect
branch tracking. They are gated behind cet_ss_support || cet_ibt_support
mshv processor feature flags.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-24-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h | 11 +++++++++++
 target/i386/mshv/msr.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index b00ec8a6367..c6749a95255 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -170,6 +170,17 @@ typedef enum hv_register_name {
     HV_X64_REGISTER_SPEC_CTRL       = 0x00080084,
     HV_X64_REGISTER_TSC_ADJUST      = 0x00080096,
 
+    /* CET / Shadow Stack */
+    HV_X64_REGISTER_U_XSS                    = 0x0008008B,
+    HV_X64_REGISTER_U_CET                    = 0x0008008C,
+    HV_X64_REGISTER_S_CET                    = 0x0008008D,
+    HV_X64_REGISTER_SSP                      = 0x0008008E,
+    HV_X64_REGISTER_PL0_SSP                  = 0x0008008F,
+    HV_X64_REGISTER_PL1_SSP                  = 0x00080090,
+    HV_X64_REGISTER_PL2_SSP                  = 0x00080091,
+    HV_X64_REGISTER_PL3_SSP                  = 0x00080092,
+    HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR = 0x00080093,
+
     /* Other MSRs */
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 76b593060a7..8c220a99423 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -81,6 +81,26 @@ static const MshvMsrEnvMap msr_env_map[] = {
     { IA32_MSR_MTRR_DEF_TYPE, HV_X64_REGISTER_MSR_MTRR_DEF_TYPE,
                               offsetof(CPUX86State, mtrr_deftype) },
 
+    /* CET / Shadow Stack */
+    { MSR_IA32_U_CET,       HV_X64_REGISTER_U_CET,
+                            offsetof(CPUX86State, u_cet) },
+    { MSR_IA32_S_CET,       HV_X64_REGISTER_S_CET,
+                            offsetof(CPUX86State, s_cet) },
+    { MSR_IA32_PL0_SSP,     HV_X64_REGISTER_PL0_SSP,
+                            offsetof(CPUX86State, pl0_ssp) },
+    { MSR_IA32_PL1_SSP,     HV_X64_REGISTER_PL1_SSP,
+                            offsetof(CPUX86State, pl1_ssp) },
+    { MSR_IA32_PL2_SSP,     HV_X64_REGISTER_PL2_SSP,
+                            offsetof(CPUX86State, pl2_ssp) },
+    { MSR_IA32_PL3_SSP,     HV_X64_REGISTER_PL3_SSP,
+                            offsetof(CPUX86State, pl3_ssp) },
+    { MSR_IA32_INT_SSP_TAB, HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR,
+                            offsetof(CPUX86State, int_ssp_table) },
+
+    /* XSAVE Supervisor State */
+    { MSR_IA32_XSS,         HV_X64_REGISTER_U_XSS,
+                            offsetof(CPUX86State, xss) },
+
     /* Other */
 
     /* TODO: find out processor features that correlate to unsupported MSRs. */
@@ -287,6 +307,16 @@ static bool msr_supported(uint32_t name)
         return mshv_state->processor_features.ibrs_support;
     case HV_X64_REGISTER_TSC_ADJUST:
         return mshv_state->processor_features.tsc_adjust_support;
+    case HV_X64_REGISTER_U_CET:
+    case HV_X64_REGISTER_S_CET:
+    case HV_X64_REGISTER_PL0_SSP:
+    case HV_X64_REGISTER_PL1_SSP:
+    case HV_X64_REGISTER_PL2_SSP:
+    case HV_X64_REGISTER_PL3_SSP:
+    case HV_X64_REGISTER_INTERRUPT_SSP_TABLE_ADDR:
+    case HV_X64_REGISTER_U_XSS:
+        return mshv_state->processor_features.cet_ss_support ||
+               mshv_state->processor_features.cet_ibt_support;
     }
 
     return true;
-- 
2.54.0


