Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78270CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrH-00013F-Il; Fri, 10 Oct 2025 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqy-0008Ac-Jl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpm-00044d-U2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so18568105e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101611; x=1760706411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EAmIkQfE9xLbeSqqtF2jX59gL8K6xolNz4VmTIBL0lA=;
 b=NEUtH23m2TuRR8JYaY/5zColV2YuRSA2+EhgbChlYxwLZzAwKrMIfJByx9ydrRTgek
 dLsaVlS+MLgiT8S72T+A5hxgcg9mE/BJiPhyqeZJsT1ffNGrF11ZglpQfZyxGn3k0tbu
 PLvXqgPcZVhngH4bwRPThRTTWTLE9nzonflAD0oMJJs8wRuxekEOTpEgGoN81guR8VSo
 Fos8jR7UyX8781U50WsfD6dXVYjSSpcOhL25d3CxmrBSeTm7uEyRKnqVFF5T3+EodsHy
 qBWv2qx5s4YwACH4HsH4ujq/pDQ/HLPd1B+3cZ+/O0jwhArNc/v1rHtMd0tzc08jxwrG
 vfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101611; x=1760706411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAmIkQfE9xLbeSqqtF2jX59gL8K6xolNz4VmTIBL0lA=;
 b=uWJtcT1c4URp1QXYDCbpbB12CA1uwRRnuIzG886cVqRQWxC/7BsCXuMk4RGzO2y3ys
 HXmRYeiP9LmUt/2oCe6s+5muzlur924lxcUIKPdzUqTojAJHZbhIj3nvz11JpCqgZZG9
 oHJTcF9MSfncJm7zyViHk+vxZaa9y1hNMX12fqYJ6pJKjGjciruba9ntYeOvPszVHU7+
 HpQpcd6a7OCa52zblzvBhASP9u4khMfhFsaNBnDmFsChuKT9TAR/J5dTe7wPQvNT1gYp
 lauxN7TCyHsgL/ArERTkiFAk5JP4zQrySgBb6dEsE4t/uFnq7I7Ln1h62N3yc/b2YxI8
 LhSw==
X-Gm-Message-State: AOJu0YykhpIp2nd9KhDl0E+cnt8ZcmSDB9dcRScS+Rp6t9wrCMB1qkpn
 Hmr08VswQy+V1xw1k5NbQtIiFcH9YVzJ3MfL2WFx4NhRkENGZKi5W8r5q+0jep3sjVCjFl7Dvs3
 LS2Mv
X-Gm-Gg: ASbGncut2tjehKiBWaakbL00COSOxh1TmGmQh+LEaHa3DWpQtzoz1TDF/PgO6Zwew8A
 KlY0n0oDhFZyTR/CMKuB2DZG8XH4GvWVjwaVRLIz7Z8HKja9svAIKuGZObFJcbYg9qqZkMq+8YC
 Tf7apwiSyp3JR8tc1SkxGU0AkvGcr3n0aOIn3cQJ6d1wSW4oGe8jD4FSpXEDWF9EaSkYmILA+8j
 K5/sAR+2FjM0OXkwudAA4AVFLJrAh3rF1+lTS7NpnUrJxeVCedkIQKakwukEmQN4KDnAUugQM2Q
 qJO/g/HOKUGduffkbCEWxdo3hGBWCAo80Z/2h1BiVNcW6P13I+qGOtN/LvMA/z5c9KpQGNsN8zr
 DbtgiuC1uMJ+GfTWudXxhGCa/6SGQtzDoZdtQDU0TQ8WlQ3Rbv2/TyP5FjVMBCQ==
X-Google-Smtp-Source: AGHT+IE22fBCJh/a6L7VLjwWNxtWKCD7fAylnAuU34zsxApNv0RP3hNuLjMZXbMMjM4tNwgkaNvh6A==
X-Received: by 2002:a05:6000:400f:b0:425:74bb:7c4d with SMTP id
 ffacd0b85a97d-4266e8e68a5mr8049876f8f.61.1760101610872; 
 Fri, 10 Oct 2025 06:06:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 74/76] target/arm: Add a cpreg flag to indicate no trap in NV
Date: Fri, 10 Oct 2025 14:05:25 +0100
Message-ID: <20251010130527.3921602-75-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a new flag, ARM_CP_NV_NO_TRAP, to indicate that a CP register, even
though it has opc1 == 4 or 5, does not trap when nested virtualization
is enabled (FEAT_NV/FEAT_NV2).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20251006001018.219756-2-gustavo.romero@linaro.org
[PMM: tweaked comment text]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 732c07506d9..763de5e051c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -144,6 +144,11 @@ enum {
      * identically to the normal one, other than FGT trapping handling.)
      */
     ARM_CP_ADD_TLBI_NXS          = 1 << 21,
+    /*
+     * Flag: even though this sysreg has opc1 == 4 or 5, it
+     * should not trap to EL2 when HCR_EL2.NV is set.
+     */
+    ARM_CP_NV_NO_TRAP            = 1 << 22,
 };
 
 /*
@@ -1178,12 +1183,17 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
      * fragile to future new sysregs, but this seems the least likely
      * to break.
      *
-     * In particular, note that the released sysreg XML defines that
-     * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
-     * trapping rule, so we will need to add an ARM_CP_* flag to indicate
-     * "register does not trap on NV" to handle those if/when we implement
-     * FEAT_MEC.
+     * In particular, note that the FEAT_MEC sysregs and instructions
+     * are exceptions to this trapping rule, so they are marked as
+     * ARM_CP_NV_NO_TRAP to indicate that they should not be trapped
+     * to EL2. (They are an exception because the FEAT_MEC sysregs UNDEF
+     * unless in Realm, and Realm is not expected to be virtualized.)
      */
+
+    if (ri->type & ARM_CP_NV_NO_TRAP) {
+        return false;
+    }
+
     return ri->opc1 == 4 || ri->opc1 == 5;
 }
 
-- 
2.43.0


