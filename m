Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9628E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQun-0002Ug-Ns; Sat, 27 Dec 2025 04:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuP-0002Dy-2P
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuK-0006sh-Vt
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xT9y9UR3+zCEYdJU7EuhVDLHUDh0P/v0kAFoxiE1HTQ=;
 b=a2HZiEW4RpoVsyPmeWgJkdY9XnqCAExMpTRzaKKrkOLlalOAIslPj69c2/50lPu/q7EELL
 Q8j54O0s1CM2Mc1Hee0kzNwVrT0kdoEUasUnm4RGemalRrxTP6uwGK5HtiFlyH0YNJhkK2
 kzbQLFEElmsBLRmjdkYkUE1D8j7VIHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-6bAuzXDqO9KDnbBJhHBczQ-1; Sat, 27 Dec 2025 04:48:18 -0500
X-MC-Unique: 6bAuzXDqO9KDnbBJhHBczQ-1
X-Mimecast-MFC-AGG-ID: 6bAuzXDqO9KDnbBJhHBczQ_1766828898
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f8866932so6174272f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828897; x=1767433697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT9y9UR3+zCEYdJU7EuhVDLHUDh0P/v0kAFoxiE1HTQ=;
 b=rRwTRU9ebxMLclD7o0Em01IziPcOEbEb7A9QER0lC4rSDd+Mg5EkyoPhyP9PwnOSxR
 AJQnE/ssSVklmLierGqqUBzx+nXuJigplbYxxrVCdQeB9cL/fTydEurlTtkYNToemPqr
 tUWoaVdFfl12Z+GCbxp4LOWM72pnGQQ6eu7FtZwgNhdFpSMnLs60zsEWpkqbGWovz9u0
 q4+7uTI31xbv9wmJtm7+iNusH6W6pTPs4MYPyPCU97kxXNyER77krw/9+1o6k530uigf
 NyDHi4R0erZciNQhzSDaS0Q4l9d2ccPmBklrTXSbtrhIAOzPDhvg+xoMYjx3W8bNo+UK
 2Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828897; x=1767433697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xT9y9UR3+zCEYdJU7EuhVDLHUDh0P/v0kAFoxiE1HTQ=;
 b=ZGAmLtUCrXVvcG4AksDIBd19MWKT7Y3Z4z4/CD2dCYvqa4rFR7glmm/qaFuKoGOD5b
 S2lxZlAyxKkHJE7la2G6OubUqdLKgyY+vwrFsyZS4eVrILlPj9yvYiedwlvGLxWz1eYy
 Vr250OXy0Nzyi5pIlp4X4BQY50Wkmd+y1za0BvWNl2JOpfFa1vCHYjZ6wv2yiyo+8qnR
 JV+InRWuvjCLLMQTfj1965X3LnMzZDgUeIgTNazyskU3FVCXzSTd61oz0+O0WvygAWGt
 nt3lZZdMqkOJZdToKdDL8lE2YFTYLiHXVp0qcnY3PYyOe6KpsRG8nl7lZ1HDqP6Pj5kK
 xBsQ==
X-Gm-Message-State: AOJu0YzBrbieOAikJUSZPahmwp6cdh/ANe6hcW/pFK5K4a8g/wDEPRER
 J5YHgmMthEZ+YPBU2EqPFLoZ3k5R0fBK/osj3+YI/IqxqgL4mFfdXOzaa5dFgXsn/oDwH5hnOoD
 TI+57tSOuxnQA44M1jqEjFpNS6NN2uV8ZjYEwgHkf+zHr8Rccm5LnfQA4EK43kVdCm/q6cI9vmA
 Meq1dxvZ7Ygt2VYc0EskXkcs9R1+NTaSAxERuV/1lS
X-Gm-Gg: AY/fxX4zTA0aZS1sDddVipdIPhHN/9DkMMVBCbmspYKa55YufT/41eGU3UlzIeteOE1
 aPSF88jFb4iM8fnIK41cciBRnb6ApvXHsMnW08ByDEfC96WIJrYY045hJHYHo/IQ6XBBiztgSz8
 5giu5H0o63Ehmo7XPA8s2SFU2aZxwYg7rgq4OqQB5sILpKENIBxdxwmbMB9k5NbxJU2lZQBee41
 7LDHbTGMwAWtoOT2WfR5JFL6Znr/qVrbvBR+mLRyKF+IWo0Z0Ix39WGFXmswdE+r2Vha5SLaPMX
 TaWLluTUEqWm0J2++uV+XfImOhgnW1RC+YRVz/IS/PAFwLRGtw1qt7xPxkD1m3j++rQwUCSO5yw
 DxQs4l40N6OAza8ZNrpIkKzwxIS2WROgpnojyWDNSTtzu8myVobfHM5vrp3/4ZmTif6q1LuOn+L
 CNhTRPd8f1/yw3oXA=
X-Received: by 2002:a05:6000:2302:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4324e5060b7mr27006219f8f.40.1766828896913; 
 Sat, 27 Dec 2025 01:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9NUnbVcMUSLBX1mQH9WXT0HeTT5BXcWe7AezcVJchpiqRlEGL/68ao44twU2Q55ssQDtFzw==
X-Received: by 2002:a05:6000:2302:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-4324e5060b7mr27006202f8f.40.1766828896471; 
 Sat, 27 Dec 2025 01:48:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm51007182f8f.4.2025.12.27.01.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 082/153] i386/cpu: Add missing migratable xsave features
Date: Sat, 27 Dec 2025 10:46:47 +0100
Message-ID: <20251227094759.35658-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Xtile-cfg & xtile-data are both user xstates. Their xstates are cached
in X86CPUState, and there's a related vmsd "vmstate_amx_xtile", so that
it's safe to mark them as migratable.

Arch lbr xstate is a supervisor xstate, and it is save & load by saving
& loading related arch lbr MSRs, which are cached in X86CPUState, and
there's a related vmsd "vmstate_arch_lbr". So it should be migratable.

PT is still unmigratable since KVM disabled it and there's no vmsd and
no other emulation/simulation support.

Note, though the migratable_flags get fixed,
x86_cpu_enable_xsave_components() still overrides supported xstates
bitmaps regardless the masking of migratable_flags. This is another
issue, and would be fixed in follow-up refactoring.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e9ef8b992fd..8c00a3ad4df 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1484,6 +1484,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .ecx = 1,
             .reg = R_ECX,
         },
+        .migratable_flags = XSTATE_ARCH_LBR_MASK,
     },
     [FEAT_XSAVE_XSS_HI] = {
         .type = CPUID_FEATURE_WORD,
@@ -1522,7 +1523,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK,
     },
     [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
@@ -2154,8 +2155,13 @@ static uint64_t x86_cpu_get_migratable_flags(X86CPU *cpu, FeatureWord w)
     for (i = 0; i < 64; i++) {
         uint64_t f = 1ULL << i;
 
-        /* If the feature name is known, it is implicitly considered migratable,
-         * unless it is explicitly set in unmigratable_flags */
+        /*
+         * If the feature name is known, it is implicitly considered migratable,
+         * unless it is explicitly set in unmigratable_flags.
+         *
+         * TODO: Make the behavior of x86_cpu_enable_xsave_components() align
+         * with migratable_flags masking.
+         */
         if ((wi->migratable_flags & f) ||
             (wi->feat_names[i] && !(wi->unmigratable_flags & f))) {
             r |= f;
-- 
2.52.0


