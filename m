Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046DDE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwgT-0006m5-Qu; Wed, 04 Dec 2024 16:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwg4-0006Ts-IN
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:13:01 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwg1-0007lD-Mh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:12:55 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-724f74d6457so308370b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733346772; x=1733951572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okXND1T4OJuVtkNA/GEh6VGd1mAgkVoLXbl0XLbMi40=;
 b=r1AlSc5gHSRDWbP7vh6LzhhPXu3ZK0xtw1oPLNRxYDMbky2iIXf39cUeIVOL01eih/
 JIvAegVjGL8JLM7b81KQgntqDfyIRh7pHGY6fyrCnPpjVWxwk9jIdCC4+96S7lSYSn3I
 54wniYzuDtCXuB7HsppVHPms7ptl4R/nHHQ5TYqTenkb7Zy7QjrSTXpcbAtVXk+NDK1y
 U+IfDhzSCm7qPAft/v6oHPIoLOCRtXgkrjULZSaJx+m/tsjT6wSTXNHQIPlIsoVMSyAA
 sQFV+3712UDT+nNXsPgacRJ2Hcy0I4+DvXe9RBCk6xWXZdyYR8aXZjP+FPPIzNBe9WSQ
 wavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733346772; x=1733951572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okXND1T4OJuVtkNA/GEh6VGd1mAgkVoLXbl0XLbMi40=;
 b=gVv44awxanX6IjgaNyersMF3GrL9p71GMKCSV48omyWs4QE0q96PCVloOb96nax1f5
 EQm6q6b8uNwv7Qy/VkqDQhRSG3pnkxYibYJ7Ok5kBFzghX2lP7KHEC8Z8yBrtzoOjaJN
 vu8+9DefQH3DjEw0omTU9jKTgLql8zVBurt/S24g+s06Nz4c/kyMX+SOI193lRdFm6ap
 uWakOWhv7noCvnZvCnUcKVC9mnUglG8WidtiiSt1FJLTNUTo8N0LwidHzR9IQr3e9ACH
 2s9gXr5P1Zug2RbrUPj0FjaLtTKPBcmZdvMZXRi9KZqDYCHGN7FHSJ/RdyJ6qJtgTR+g
 LwGQ==
X-Gm-Message-State: AOJu0YwO+66lbSGEqqXm+QhI5pl9xwEOeJwiNzXhO+3YbMpluJ9NXpg1
 l1/+QV3UKYFW8ARcLqeAIM4vpu5rSgpupMb6faboL3Rb2+kNrxwOxpEh9UKRs+lkMWnZgiXBnT+
 5Zj4=
X-Gm-Gg: ASbGncsdAsXauhgAQEaSiLkPsIlEgbP4kDOCro+YZ85VyjJfcmrtf2cpeJf57ZDb0hF
 zcbJV+E8JAPUj7WqGDNJ8QSCkw2PdPABEnYyqV3FSR8KuLPxsjZ1QawZKWHKEOHlXp6XbLVmDFa
 w/gUQwT31xZM3pjDqDqQLRN7eEc0ENrvU1V+A5EyXITGleo7G+xpFahPKrmYIHeA66Ba3RmBKR8
 JLy3DEtFVnsi9/BEdqm7WwrWALs26PS1BwDNxyuBdFKGyw8t4/4tD5fxo2CPW4/UkZqjvnwuoto
 G/wAP/2F
X-Google-Smtp-Source: AGHT+IFs6zydCz/aedghNnDWrbYfsm75thqJc6ke8CFCc8uPywde2n7KPs8HxmzH15WSEGUhXju5qA==
X-Received: by 2002:a17:90b:3b4f:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2ef011fb85bmr11125389a91.9.1733346767525; 
 Wed, 04 Dec 2024 13:12:47 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef270089b8sm1905830a91.14.2024.12.04.13.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:12:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] target/arm: change default pauth algorithm to impdef
Date: Wed,  4 Dec 2024 13:12:34 -0800
Message-Id: <20241204211234.3077434-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Pointer authentication on aarch64 is pretty expensive (up to 50% of
execution time) when running a virtual machine with tcg and -cpu max
(which enables pauth=on).

The advice is always: use pauth-impdef=on.
Our documentation even mentions it "by default" in
docs/system/introduction.rst.

Thus, we change the default to use impdef by default. This does not
affect kvm or hvf acceleration, since pauth algorithm used is the one
from host cpu.

This change is retro compatible, in terms of cli, with previous
versions, as the semantic of using -cpu max,pauth-impdef=on, and -cpu
max,pauth-qarma3=on is preserved.
The new option introduced in previous patch and matching old default is
-cpu max,pauth-qarma5=on.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/cpu-features.rst |  2 +-
 docs/system/introduction.rst     |  2 +-
 target/arm/cpu64.c               | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index d69ebc2b852..37d5dfd15b3 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -223,7 +223,7 @@ Below is the list of TCG VCPU features and their descriptions.
   When ``pauth`` is enabled, select the architected QARMA5 algorithm.
 
 Without ``pauth-impdef``, ``pauth-qarma3`` or ``pauth-qarma5`` enabled,
-the architected QARMA5 algorithm is used.  The architected QARMA5
+the QEMU impdef algorithm is used.  The architected QARMA5
 and QARMA3 algorithms have good cryptographic properties, but can
 be quite slow to emulate.  The impdef algorithm used by QEMU is
 non-cryptographic but significantly faster.
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 746707eb00e..338d3745c3c 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -169,7 +169,7 @@ would default to it anyway.
 
 .. code::
 
- -cpu max,pauth-impdef=on \
+ -cpu max \
  -smp 4 \
  -accel tcg \
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 34ef46d148f..8b1f26a9664 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -529,15 +529,15 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
                 return;
             }
 
-            if (cpu->prop_pauth_impdef) {
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            if (cpu->prop_pauth_qarma5) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             } else if (cpu->prop_pauth_qarma3) {
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
-            } else { /* default is pauth-qarma5 */
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
+            } else { /* default is pauth-impdef */
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
             }
         } else if (cpu->prop_pauth_impdef ||
                    cpu->prop_pauth_qarma3 ||
-- 
2.39.5


