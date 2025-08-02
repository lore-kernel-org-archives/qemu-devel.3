Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA6C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLpD-0007OL-TK; Sat, 02 Aug 2025 19:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmM-00032H-GP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:46 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmL-0005k7-18
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:42 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7419f3428c9so269028a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177800; x=1754782600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yp6GjOVr5sFSu+DGzVCc+heSPSS1fAAC7M3WZ7lFas=;
 b=t2G21qyD6z3sJtMIcRkgALemGiZDl86Cbx+2aN5SJ2YxHvbbne8onvriflDH4vjaMu
 ff+4HX2SFvEIIxxo1fba6c6997hJxVTw8Ch/ylaLphiHwZFOkuYBW0Vqc039xN3mibpl
 YfufyHih6+4D0ySFnqJrkMAPTOwCIlA10JT5UlSjU1XoINVCyUR2JRlUpgngS5WR0+le
 HXkS0v+GmT7XOoqLm5yyo0xYY6NAl0tMTkMuN0SssxA29kio4rdhEvpHFAS9OypfOaOX
 uNr2PLKt/ghKzw0mG553rmRpSPhEq0vbeJfZU9RYZV7gFuCuy7G99cT1eBYKLvuSFng4
 MhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177800; x=1754782600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yp6GjOVr5sFSu+DGzVCc+heSPSS1fAAC7M3WZ7lFas=;
 b=SKq8PNex+mhcIwhRyuIl49CDUsnWSjuwVeGo9Jy61RWXZxQNHAobON5+AUNoLir7fR
 KxtJnC9WbDb9KQ+EYmzah1sALzRjfab5mB/oNV/l02CurUxotZDmqofvu6anmHsBqEEz
 aWwqSPLt+wJXLmnI2SczAjkUCvZKr/iYhFKVcYdjn53SZvGOrpp1Rx5bFSKcRqG18CwN
 BaJ96b5egi3oBGcPKvDyKx1zl7VszQLMtjnOjJvg80os5XGbCxX6amHPFYvxvuYBGgmT
 0ViW+fy0ObnxKd2Soii1mMWIkui+A6LPVNEIhJdBjDGwcwzvp569yaSVS+9uC0/gYICA
 C44Q==
X-Gm-Message-State: AOJu0YwmTImi4wrfpIpQYbqhhuPrvGLldIQ9e+bdU5+uF9YNVdRNJ0Xp
 NFdeOJ/V1q+UtjH9smTC+D6wyUvqvN/jZQOLF6si6RBXMSglkGtwmWEUlbLGIFZjjCd2RfXhChv
 4VBQ5jaE=
X-Gm-Gg: ASbGncunCUdbccwPrXvH+btxa28wikw369un2bUlFJgbNDVoTM5hDHhAI1MWGWf/Ojn
 EBjUGgriBykpISDJmaV3iM+V9vDh2/WXjWo8Fz3KfeKg3+0XioijFIzmaNrn7zK1kWd3yCN7I4Q
 GwDOvBEH8djE5x6Y3q5Ju47waRRdVLERAKMBBGk4g0x6X3cBbEpkr0ukZR/2a+hwKVlIMZYEPSO
 naPchW9lXckDEsPZkkkOmn1J4yscaXiyzubWOxtMUgsr/mAQ437I3fADIqJ/7diziioxKGre+4P
 keeAxCD46EkOOssTSRztPE9M+Of2fYUB97lvkF3vh+roNbrAaFsN5FmNSujRe9PZjriJ8Ews8Uc
 OOol46dkbbT5PyoT6DBdeLuTYrhs/IqKn4XhmEOe9iQCSswF96Xcw6wzAT0Y3CHE=
X-Google-Smtp-Source: AGHT+IEivDBOTGrUqtjbaUTfs4h1AUX7M7oii1pwKBAEuNKV+Qq2kwLGsXHhwpn1JzXgzPzCB8QDaw==
X-Received: by 2002:a05:6830:411b:b0:73e:5710:cfa with SMTP id
 46e09a7af769-7419d1ff199mr2563144a34.15.1754177799740; 
 Sat, 02 Aug 2025 16:36:39 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:36:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 45/85] target/arm: Support page protections for GCS mmu
 indexes
Date: Sun,  3 Aug 2025 09:29:13 +1000
Message-ID: <20250802232953.413294-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ee887d9a02..3c84f0f024 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1584,12 +1584,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2236,6 +2240,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0


