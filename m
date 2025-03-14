Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B32BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tm-0005wW-OT; Fri, 14 Mar 2025 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t6-0005as-Fk
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t0-0008F0-Mf
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:31:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22355618fd9so48789715ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973513; x=1742578313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=H9duQxFvfjDJ/5RWK7zM0lYMQNiNW83G69CdomQndShsG0t/7YILuSCNLqX2ihNS/D
 i+B6XoQzVfYWuwsauMEUySfWjVi1N4w+JhsXwe/vPgkkjVOGKkk3bHnYW9NbwQzDd/WL
 BSGO47p2tQV2Zi9v0WOTK+B3XwknoHEsl2G1BKwEymS5tGs/2zHGaFGBzJAA4YPamiyV
 P5J14SyIpc3YZ2UKY2Lu86TH9yVmHCwzgBPWMsTdp8qu847nuevOTU98prGZ+SO5EgNC
 /4Fa49yUr2Xc/68pP6D/Q2tXMT80Pfzs8TI8hDv+nd1O47rMk3JrgtD9kfsTqICx8tyL
 FUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973513; x=1742578313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=WiATb9ViDEHCL2eOfd4c6K6V+sgKSrwy0+gjKSbZZ2nhciW0KO4koiDhCMlf+UbLum
 yV47H1LF8RQjtE8ld1EtMbN8iZTqal6ddz7Zpe12EMUGgt5yz4scdLw96pTGaVR3OB6/
 RpP0bWHrQP0oYftHztSfIKloKNuuKfdohQmoHqCmvkpbhk0LMVJqpevrn5fbw1PM4XZp
 vbTFEvL5hhuW26ULQHuW+VSMSDVYgZ4hndgfdwJpy7cUQ4nPPX9UyrH5/1zHKOTX168m
 VJsjMsMq7Gng/vDHHMSJ2Snmhk9Kt8nOYx5T+8HFugJnvR6l2dEXzJq15VUSG1qo2T9A
 /c5g==
X-Gm-Message-State: AOJu0Yz8j9xEhNUz0bPz7yfNL5sLUOu71fhSK7wcEhoDvPsVwPEubccZ
 z3JgV07gAIGyYHL+MbU6qAGZQAmRuteboxSQxYNP+2X5yNajJrvOgCSUQlt2ChKeQUoXDByxBkT
 JAF4=
X-Gm-Gg: ASbGncu7IbygaVXxiCWeGzw987XONgc8yF093/5EQwl1juxgDif0qpRwfSJUE9F841r
 8OJ7uA19rD+DAiJywQUuOkfx9GLEEGHV0bZK1vIAQmzam5MPPgtMibMfdk/PM9QFDVRLZR7B1OL
 Lpo9NHAArecb/fP3T+CZgZS7YTBMRflAOxtXZGTKsvk8QPBeBoWgQ0PPLFqECUhp8SH03ObJkDH
 qL2CVN86fn9h++qAZFFIMpgy8S8N50Cy8UW13yHXjAdedhS4D09kpM9/n0VywaZWu+4G+QdwsMd
 KPwUCtoNO7eEENAwQW8RR0xITcD4VtMB0HbCJjOWjlPn
X-Google-Smtp-Source: AGHT+IHKJWanCd9a3ngVFjdniRCV0nA3qgwDHy2sNxgD5gHXjvzGRnW7PF30BgY1b31dJB7uC0Yy3g==
X-Received: by 2002:a05:6a21:7308:b0:1f5:64fd:68eb with SMTP id
 adf61e73a8af0-1f5c1137439mr5964561637.7.1741973513079; 
 Fri, 14 Mar 2025 10:31:53 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 07/17] exec/exec-all: remove dependency on cpu.h
Date: Fri, 14 Mar 2025 10:31:29 -0700
Message-Id: <20250314173139.2122904-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


