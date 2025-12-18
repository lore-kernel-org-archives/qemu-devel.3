Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6465D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMHu-0001yM-6p; Thu, 18 Dec 2025 17:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHa-0001fS-E1
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHY-0006xM-B2
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso9794465e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096134; x=1766700934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ai82X5qjfSKpHMHTaz42E+3ndTcjTJ0slisrNHpajs=;
 b=Y0RYmoVhD9V3w8maW3iZKhqqVSJa343xosHJsWa8GaXIO4CXIKsU457mmuwB9e3u1r
 F16l4GESFFwr2p1wuu2nt9uJKiUNr132p1MkIxRK2cyxURf+RzYAFsX2lAPBZ4yNhuUo
 0uZ3qOyIriQcki/zRVWyq/3L7TNVZp+VuKf4SKwWLIf1SNP2upc88A8ODRjOAxnGxxA1
 FhYX64QkzXZLreDMEGg/bZWcSEaKPo25/CI6QZDYELTkR/W94Z0OsFUlCGzTQOGr1Xkh
 8gyQf/EkM2lcnC8aAZ7DMX9KIusljS92QNAfruWJoSktMrBp3KaDmKG5qgpR5pd1v4H+
 MLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096134; x=1766700934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ai82X5qjfSKpHMHTaz42E+3ndTcjTJ0slisrNHpajs=;
 b=Y2iFgbkrmIdXn9uazQsuPzXPruTltnEYw9dtOFwhhfY/BOZ91QFLiPIWQrhm/4c8gw
 iiFHWf40yoTC/V1hoaU+lZpY5fxBcc7+yTm0zduAvUNcUinGGzrY8Xqy8ERHa5Y5/DEN
 YJAJgaVnkMHcDenUaiyCJBfKu2ME8p7hNvOj0/ZBbsgWCF0jiK0naWuslFxlNr2d0xjC
 MfuTZzOvJaNQNX/RseI/y6WW7111X9rPK/hPgM718Wl9iR8vaLey06Vlbrf5pJ6d5OBm
 prppbbm0v8xd8LivFhPAxrJ1Cm8U3Y1g0zEzUATYuOHlERFtV7/9U4A4zB37QWfXgaJg
 rn7w==
X-Gm-Message-State: AOJu0YxllwpAXSQ8VaXInqGmP9FIV03k0ykjcAWV46sJ/X8KvSPOMm2/
 bTxWDr/CBm5fSGsgjvNtcc/DJjPOot86jjobLta9t/Qx5dT2rVIex1D8ZlPdPJ8lr0kEhvNSXq5
 dJRrYOWE=
X-Gm-Gg: AY/fxX6lQ6dk1wM8/dy+rD97nE7PgU47HVaEFyA+KwKVNID6+Oqd0uOnneuhm1ZZQTX
 FYO6xUcntTHHTPEhF7NlIyF6kDPYO06Q6AARHj9XMGtBqriIeJkxn8P0+A40RyMoIBGMMltBLS4
 aaPy29CUhLzZnoIfLDzra2/hyGFgxVPfXamLz7e0HBLO9+SCU1cUKRYFAfYpjbr1+Bfkh8CM/z2
 zJAB07Y6zDtHn+BkJWv9CyVhIomfm2i29TM98fVy+nmJUtBh55XX2klrRM9aQ4X3g64yJuE1ij1
 135NqKOKCKbGxUxXMqme24PlvY7Ur1dd4pb8QvD3IpuLV5+gerUCNRP60B+isNvR+ibcJZHrzCj
 swzIs+JwUCUI2G0eu6tkVVCM6Jy9uCBUQWB//WEwqJ5fn+GpgVG6YZWw44byVf3gT2fOh7ipb8E
 EEWMOhzUnWIEGaSWjmZrTgmnhnWYTEAos/Sr7/AFZ6UQwUk/rB8FM2gwCv94AV
X-Google-Smtp-Source: AGHT+IEbg6nUPAcQ7Dmf4wv9OGctpaenVpQh4kP0zTmGAfbkG+be/0y3YhcEa8WffAnc40O1Wy6H0w==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47d18b833a6mr11165315e9.2.1766096134014; 
 Thu, 18 Dec 2025 14:15:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm63775225e9.13.2025.12.18.14.15.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/sparc: Use address_space_ld/st[n]_be() in
 ld/st_asi helpers
Date: Thu, 18 Dec 2025 23:14:55 +0100
Message-ID: <20251218221457.73341-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Do not open-code address_space_{ld,st}n(), use it passing
the access size as argument. Directly expand to the big-endian
variant (with the '_be' suffix) since we only build the SPARC
targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 42 ++++----------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..052608c02d8 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -701,25 +701,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         MemTxResult result;
         hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
 
-        switch (size) {
-        case 1:
-            ret = address_space_ldub(cs->as, access_addr,
-                                     MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        case 2:
-            ret = address_space_lduw(cs->as, access_addr,
-                                     MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        default:
-        case 4:
-            ret = address_space_ldl(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        case 8:
-            ret = address_space_ldq(cs->as, access_addr,
-                                    MEMTXATTRS_UNSPECIFIED, &result);
-            break;
-        }
+        ret = address_space_ldn_be(cs->as, access_addr, size,
+                                   MEMTXATTRS_UNSPECIFIED, &result);
 
         if (result != MEMTX_OK) {
             sparc_raise_mmu_fault(cs, access_addr, false, false, false,
@@ -1066,25 +1049,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             MemTxResult result;
             hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
 
-            switch (size) {
-            case 1:
-                address_space_stb(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 2:
-                address_space_stw(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 4:
-            default:
-                address_space_stl(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            case 8:
-                address_space_stq(cs->as, access_addr, val,
-                                  MEMTXATTRS_UNSPECIFIED, &result);
-                break;
-            }
+            address_space_stn_be(cs->as, access_addr, val, size,
+                                 MEMTXATTRS_UNSPECIFIED, &result);
             if (result != MEMTX_OK) {
                 sparc_raise_mmu_fault(cs, access_addr, true, false, false,
                                       size, GETPC());
-- 
2.52.0


