Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC24D2445B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDiq-0006Aa-Iw; Thu, 04 Dec 2025 13:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDij-00067M-Ru
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDig-0005Xq-8U
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso718510f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764871580; x=1765476380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=lTrJwie28wTVbt08NwGM3xAMY/LNJ7IPT0XJ0xjqoIlWq/NKbmGU8WK3UjiZMfSiiq
 44jeqfc+v40ZNJr06NJAcKdwL3Fx9+1O+EIvr3wRg3pi38ADUvhGyhqnZ+Iyk5LaJTKL
 QGglWJRolyqmWGrfGb55+xFJ/oqBCV2H9OSifXtlX97mvzxCLhtZtNau3SL41OR2d94p
 Ar0ExFjTqDXVQAtBYxQF/yWSuCX2UdMqIFeL6WTNxUq9Z/wWLfLpVeMwRCz/EYnAKwNl
 wr8twGAmzMEAyB8bxsbn2bZKBwdUDJJNdNoBYjFtB396Uym6TzmxbiUZeWgnnSVXt2Wk
 JvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871580; x=1765476380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=XDxf/POP9XZheA3xw8shMIizZC471pROJJPIRSyAw/oq4ex01t8lL1uAsZ+GhGlI9m
 48OkzwyIgAzp5YopCRja4B0QD/kl7kiXWwNgAgvRoKF0cZa3oUtyFpkPEMLrmau1lUt3
 UekawMAX5ySeuXtKBkL5KsIRsKNAHj9F1Gg7VwPByMRAJPQkbMnMJfmOoHx+qc5SnDXe
 SLJpXqEk0X7DTMFXawqW69Jhl85+Fb7p2ZoV8WG17AyFE4lgRsKeixVmRM8YSWW1abKk
 xng/J64bzIe3ntPP7oM7cHeMzWWjNLTmx1JnkCc3SDfnM82t4RYQEVgcPwvG4tU6PMrK
 w9EQ==
X-Gm-Message-State: AOJu0YxwJzj15fJuazyO3v+PuL9J7oI0xNANEByCbcddP72AqzwHN3mZ
 zqlMb6gQ3+G9BhnAv39mN9tQi68meBmlZ2UGl3cWBZnnGHa/1pYbvgOtMNziw/cKE5Uk+XmTAJe
 DiOwc
X-Gm-Gg: ASbGnctuNAPlde14JB2wC8DSNQnIhxlfRF7DVUXnDUbWu/MYY59oWeMo/hQxCsovW7F
 B79HYjcHqyI2HJy47EfIDQygB/fUDqfJyq9lAok9bIQx4gN+f7fWj3BFEB/shvDUgqFF2jhvBz8
 YrOnDZNoe7DJp9poyOE16DFJEOyRfq+jL6MqV+i1LB0J7L8EaaHG0nzaHb8vpKwNFfvZUosjqRj
 JlEwRavi+uY0dNccFa1VP6B+nbdpSBelTr0wVEds8cWOMIxLd/QjGgn9JcbXunroTJZpcwxdq4u
 hmHTpboDaQMfRvq9GOupIa+EJdCk9AgzWjXk6CY3uOWg/9k9mk8HGL4G5Tq6pIWdpvpjr/ujnJH
 nwoB6YccHV6FsE6mZo0EYmq5NeJ/bVFS+AuhSpZ0jKn/4uN8oUzf+LmfnzbO1ajcQH9xQO/Sehh
 FPN5qf8fJYV69c
X-Google-Smtp-Source: AGHT+IHdXPMQkc61rFnp66+Hnj8vxOTn7Nm5+pp1SaajtwOmUTAywFIm4MbGo4jNrAow5CnbnSUqtg==
X-Received: by 2002:a05:6000:290e:b0:429:c7dc:e613 with SMTP id
 ffacd0b85a97d-42f731f5ffdmr7950499f8f.41.1764871580123; 
 Thu, 04 Dec 2025 10:06:20 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4589641f8f.32.2025.12.04.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:06:19 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register
Date: Thu,  4 Dec 2025 18:04:11 +0000
Message-ID: <20251204180617.1190660-2-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204180617.1190660-1-jim.macarthur@linaro.org>
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


