Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D99DC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslah-0003Ph-Fp; Thu, 13 Mar 2025 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslad-0003Ma-Ui
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslab-0005di-14
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:23 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso2578480a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883959; x=1742488759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=aC4VCAoPc7kCgFR9CbYieqTDpfu6vlK6GW4NxpxryYtlJcXnTMxpg83PoNJPkAeHJt
 +wMOnLTvEmp15jilYmwubF1zElzC5dnpJGFWrHzP8tWwkyip0Ww93tqz5pgzJRraFZG/
 5QWsfZXLLgFnKwClEAkqKSIekXv51bZv1tVISZYleQBIy/IaJwwlRRG1zz4BHAzE/JnY
 6brS9Vcu4uMEiRrmlksHO5+I7GFO/xJLnchYsOcaMPTJdng63cHp8+sMLnfSw4fpr6hH
 sAuxzhI5rSMXgNJcj0b9WeGr7nmMeiqiFBnlkPvxI1MitZkgSSMt0hHnw0D534sXX/kR
 /5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883959; x=1742488759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=jfsKraaM7e39MNH8oYrl2s2MkqJwxeVARnV0nNv3uAb+DgxnMT+W1dZG1F9a7bOHRi
 jPbZoFLQ6vbcluF3a1J0fUJ2s2dNTTvFTGfB9Akoq/JOFZDyYi1J+jtLvnFWiCtOyU1n
 GvkOsswLJXIxI+SsHKaDJCfq+kw5TGH30FEWXUOAJNYnOSL7V0DLeTCL1zRqfUIGHA2P
 4AA+iXNIRpVoI2Chk56QtTeOodJmZvR6r/uQD/hEVemOqBPU4el5XdImZWM+Cg5oFEjZ
 aKTVOlaEc4bPP56Tps7qFOLgnkTDNZIM8rv8nAYCYXm6rKatuvU2Ep5KRARNcA6WGgYu
 Nikg==
X-Gm-Message-State: AOJu0YycA8/LRpEsC2SOioNs+zYz1uCUOP2kfYeWB1MxmeYY/fwB7lHK
 IcBs5DSCfG+aKOg88vrDYPH0VRwxllgO58qsKklCA/8+IPDj7tDT5qIxc5DESP1xI4RklQjwTe1
 g9AI=
X-Gm-Gg: ASbGncsbINUo5Tsp98XGhAGPr+d+NkNR6pRflwDkWYOo0rbaIyL3s3TXDcCDancM4XW
 TsrYU8YjHMIOrmEeBvD0GIBySheoY4xygBO7gUKo/zbt69jWQUHod/Ds5eZEfdXsQ/1vJFth5VF
 CLAs7mCLiaI0SIT70f7vmZsW3spFmFYWAYyiBCKK26IAMpeJZNea3+gGmEed+87keYZyn8WzRYD
 M+o2mYUjMGg128uOwzR1JHN2+BYYpyO2MM46CHvUeSSVL0N+DOecY143Pnx7XTRnwIGmkp7W4sm
 eAGyIclNL9E9FlM23P5JrbMZC5s7Hic0qxxHYKVNWX3w
X-Google-Smtp-Source: AGHT+IGIP+en0Aj0eYAe+7XhNeZ6W7zp31secPtMQkoPMAwiLZjQzktFWA/FDeyZICzvqUiJA1imgg==
X-Received: by 2002:a17:90b:54c4:b0:2ff:52b8:2767 with SMTP id
 98e67ed59e1d1-3014e8619f7mr247106a91.19.1741883959525; 
 Thu, 13 Mar 2025 09:39:19 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 07/17] exec/exec-all: remove dependency on cpu.h
Date: Thu, 13 Mar 2025 09:38:53 -0700
Message-Id: <20250313163903.1738581-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Previous commit changed files relying transitively on it.

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


