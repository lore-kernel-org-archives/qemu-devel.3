Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46514C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lB-0002HS-2a; Tue, 11 Mar 2025 15:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k7-0000ya-OU
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k4-00004w-GN
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22359001f1aso140554325ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723099; x=1742327899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=aw/aQ+jpPy2luIZYXTFo5tY/KJYB+/jY9ET4myaJoAMSxyzNVBizMum3OOhDAzU8qu
 qv8k478ouBY6Uh5l2gqMW1jSZu4xVM7zkaYxmA5Z6OQj4SFuV+KKMGPblopXp+oLnfxR
 EtTEzVC6e7+ODUyea+NX4rd0vYE9VSV9x/XA3ZN2CTnDsBecKDnOa+gPj6YzE7ujzp9P
 qrQqIR5av7A5xICug4gPqILjkhNq/3/QTzXUNKu+DGfeDtM6F7tRrebo130rBRJwq/M3
 2mePmOM0VMoFe2JligtDOsOzuUaPq5zNbkkmqpSuJ6d3n/Jkpezw5VM52NX+AVtijm3i
 VWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723099; x=1742327899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=fBuSgycDHXg8CGM6ZU8RtV67bVga4KTM9a6Z4qAorM8LwHSPfS9b/B6BuGOdChNEw8
 12GCr5RM6lGDK8kvjWN+reZQW/HOK0drLtnXlLhj+LEj2Rw9Etq5G1n1ex67PH1YDgij
 LsPxc6cZOp7rYR2e8X3RUL6Zq9kk0tLtDPFBZROK1QdMDmfb1GauK5OKBzk7PEimjibK
 s/uRzVpBIl3tf1vbtHDSTXzsSWLDIkICgtw2ccAh9ApkP0jzrjqLAnz7zBWyOaNkYbLy
 GI/xZaeXCHa07xsyM0PH2S3UftlClvZn/BBGLCFcviNlBaNylyTYPSYI3397yOEh9ftr
 RHEg==
X-Gm-Message-State: AOJu0YzAeINIj6FzN6qdD9h7s6Cf0jo9dw7RJobqHzy2u8VFzLUailUk
 Nlluy3yVy45d7DdaQge7gdgV8i/SQlfYkWqhTFleRu58ZLyE+HlPeNncY5NjP59l7cocDk3HJxh
 a/ac=
X-Gm-Gg: ASbGncsmvlE8rzzqy3SzIZxJlzak7vLY+s+r7R1eneMEV9oLKlLPDqxwKrFkI1sQ52l
 9Gwf4yCcugtT0z0yhkamcORZPohM95669H2+no7mzkshys7YKqJOXz78huzyarl/AUs0HSClFu6
 E9sGmds8EYLQb3FTAlJ4jXBedEnhg+hZfx1sQ8qzENHXBMZgxaNtut8sUSo03Wn56N7KbjrBhwD
 7VZh39KUL+tcZMtIaGUWExWy3KFJ4uYiysKZb2LslsrxdfvNvZdqoBAvuqvx8BicRpclRigZwc2
 f74VZQE+ar1RLXpLosaojBQwj8M1yxvNL/dgTw4/59ntDzyBagjNhu4=
X-Google-Smtp-Source: AGHT+IFbL/EikEqHmQH7/+hOB9jflYFjv2fXkewmYVpLTsSrUYTiBJ9zTgGhdqBywi26rV+yUM0nVQ==
X-Received: by 2002:a05:6a00:1708:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-736aa9f0b0cmr27815913b3a.12.1741723098739; 
 Tue, 11 Mar 2025 12:58:18 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/17] exec/exec-all: remove dependency on cpu.h
Date: Tue, 11 Mar 2025 12:57:53 -0700
Message-Id: <20250311195803.4115788-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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


