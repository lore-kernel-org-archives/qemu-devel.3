Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC47C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqwa-0003vi-37; Tue, 11 Mar 2025 00:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvV-0003Kt-6p
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvS-0006SV-PZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224191d92e4so86286465ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666145; x=1742270945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJTMw6tkQg2gyyv9VopXfGbD8re6/gGFQNon8Npv7Ak=;
 b=Otz9/smOaGLqXsY92KOsYixd8d8OhNs8pfdO9+gdcHa3Pr9Z2vdLd1ahh/A3IMq4lx
 IdM0CBHGouOsFtEXJHHeojn3YWIvkj3IBgnMn4xdn465yaRZcRT6FOENF7S+MNCzUWnG
 vjSJpDaLH5YysTkM0qrbCHKwV+pbHHvmcvP4WW2OpRMB2S/K84R4rmGil/XnD9xK1RyA
 1uEY/e49825ik2T26rzmhbklovh6ndcArHh99O94oqN5UknDu6W6GuaB8LdKbS9UIOPA
 3BaDUqze6XZgKWR/QOhAx80dENNiIYzNXm9IGJP8rV0McwK+d9f8ABfY0X60o7O9IVkT
 1C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666145; x=1742270945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJTMw6tkQg2gyyv9VopXfGbD8re6/gGFQNon8Npv7Ak=;
 b=gF71uGDhSG5Op20S0u0/QFludpMVEH86oxIaLnHZIM8gnLcCpaBLtYIyCbRqxGofA1
 zuIZay/pbybSee71VqxDUUFkPXD63qWJeFC8IYPcHlt9U1kpWSABtlOBEtidVFzd8h+P
 whT7sdi75H/3XXNZ5YPt2flPRN+idtoYMS/uDReuWIOoZMsT2WUO7o3mjKix3gOfv2GV
 pv5m2XoTrwpCc70cMB7lk0018HuIO6wQfNYC2FOj8APfu8rkyrXlgWKWv48oe0L6BNbZ
 7+qFI/BynlN7zKNjmGkonmT7D00+JT/IsXmzDHIcrZ6AqfU0YA0bymJ5XI0ZU41eqgHr
 bdLg==
X-Gm-Message-State: AOJu0YzY6Dkczix4bAJOHQXD8PmidPp91BqIq6hqWEMtf5bx2Aq/KRV+
 2b5tVN/8JQpnIry878arrrCeerJhAJ/BANYrW6Q/XMRtGQHh2rF7o1Ux+C0gOF9Rhqq49t6Qa9U
 /GLo=
X-Gm-Gg: ASbGnct+ykjJJ9jFhPe7Yel867kfRgnmxRmQNzxoY3usjVskR3faHHyrrZxs91SrCM1
 1Jeb+bvbftQMi90b4a+73AbnNhpmgjdUAa1Wy3mRoSjqWhLmnoNPndJhsNvGWWTFYi0JonsoxTg
 aJqE9n0cNckHEZ95lD4kuUWawElWcVwYxRo6O0mE/+urDk7fjhE2l+wIM6XL3TgQEPZEQ3n/vYZ
 gxmKpa7HAVVlTstZGtf7Ddwx5eUkIf/z+yAn7YtbDTC3KgJb6xd86reqiJPLS9G8mznnv8Ct+qa
 rVYDRI4YWklARNsR9esYSND+vynut2xoWo8+i+4eNLIk3diV26lTNqI=
X-Google-Smtp-Source: AGHT+IEZQz4PbmDcJ14zbyjAyAYIBXfqlvYCPkEDTZUS00hzo0yd+SRkwBCunP0Y6iJa+tBGNAcErA==
X-Received: by 2002:a05:6a20:2d2c:b0:1f5:8221:d68c with SMTP id
 adf61e73a8af0-1f58221fee5mr8742647637.3.1741666145118; 
 Mon, 10 Mar 2025 21:09:05 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/16] exec/exec-all: remove dependency on cpu.h
Date: Mon, 10 Mar 2025 21:08:29 -0700
Message-Id: <20250311040838.3937136-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/exec-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index dd5c40f2233..19b0eda44a7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,7 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
-- 
2.39.5


