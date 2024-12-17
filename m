Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6645E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZGF-0008RZ-5u; Tue, 17 Dec 2024 10:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZGD-0008RQ-AI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZGB-0003It-UD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:21 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d161947so2606231f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448398; x=1735053198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6S2xlttjp4VhpiTH5RBxnctIn3RW53HPZ3WyhXqjYw=;
 b=MqAJZ1g5ylMx22uovF6OxvUrMBd/pzq2spycCCkzn3IqiTDqiFpSVtRMyejLdQX9pJ
 n7lLEzSiPGcLoMJMZTmD9+f0xhwj17AAq2aWGJAzqokPBSdj9vlJuRbtO4HZUGWGw/bg
 YHSdoAw9yOYrBG1uWqpio/iaHvd7SyxyKEvcqBWyZXkgYccjKzHovhFkKB+7MuaYgMkl
 rQT8knyj2vAsUkmdOEFYe9tVr6Kqy6Ly8m9av4o6g6jOWICmjM5u0p9Ipo3s0ISuIktv
 V4LLvmEWnpmK/AoL098pTuaLF646D4BMByierfxwIoamgt/KQ4pBjpWi7ZeLHUgF+x4b
 SkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448398; x=1735053198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6S2xlttjp4VhpiTH5RBxnctIn3RW53HPZ3WyhXqjYw=;
 b=i+0JUuwvd/okee6dUNt85TqnyY2t8BuZr6v+cRM3QUu7lnB5LevnMxTCpQSWH0ZB7s
 FEGo13TqcJU6fwa5GGWOwFBZUTQ8fbHK9b3qMCA+9qjO6lz3H3roqWSNAjC2voJYFVfz
 RWGlTpVWVRZfhDPFXaVqsVW0H5F3+WQIeDaWivmq+Ir88c6g86Sxtf0aOZ6Jcy3URbXb
 dAtuTxKA7NawR6TwJW2IL9qrBjSQVof2FDnCv4VP0Q94/XhAVi9OQU1PRbmOUOgL4v6x
 UQhONzsXXdWNFX9KGXWbqEeUt0G7lmhCAi27j+6SKt2Pl8XjccmzWvm75prcWxQPg79K
 Cs3Q==
X-Gm-Message-State: AOJu0Yy35yFl/PxfbbUm0zSLKNAIWQgj2OOCTL/KRDefqcPeMRj4AudU
 3Nh3qkK6M1IBLQaRS/A6sbzsXIt/DqdOe6Sk/zixllMnJ1DvgLJUm2os8UTvgVpZ5+X71EFN0Sk
 Y
X-Gm-Gg: ASbGncvMeDEVHOXrwhc/fF7A2d8nKuf3aIlcypJEMUjpWiKih2nZgw2q5vOwFB0LkWf
 FaLsryaGHqtTPcnazjce/zG/smy/C1wCIddPwBl6f5/dv5s2OmRy9eVG7K+rdu9PtS8rlq19I6k
 T5BoDBOw5q0aSrF4RzdELjCx30zzi8Gb2Gwo/+K2gQKw4nq4WP/wIquH/WHohbfhg6ezycIB2sN
 fCA3kalZkW69JIMwEhPx4oCv6XjubvP7ldlIIuCNVP6NeGZUIUQ6fe24/w+nN/Kfp9hBJgW7qvw
 Y2+c
X-Google-Smtp-Source: AGHT+IGcIc9C+9xF7u7hW0QxoRTcmmxZgIQEQHrG2A+QXqPWKTn7jmn5F5uLxS1c0rghk9D+Onu6dA==
X-Received: by 2002:a05:6000:4012:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-3888e0c0656mr14540012f8f.48.1734448397845; 
 Tue, 17 Dec 2024 07:13:17 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8049facsm11612456f8f.79.2024.12.17.07.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 07:13:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: [PATCH 2/3] system/numa: Remove unnecessary 'exec/cpu-common.h' header
Date: Tue, 17 Dec 2024 16:13:04 +0100
Message-ID: <20241217151305.29196-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217151305.29196-1-philmd@linaro.org>
References: <20241217151305.29196-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Nothing requires definitions from "exec/cpu-common.h",
do not include this header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/numa.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 04676141470..1338db9502d 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bitmap.h"
 #include "qapi/qapi-types-machine.h"
-#include "exec/cpu-common.h"
 
 struct CPUArchId;
 
-- 
2.45.2


