Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99703CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4F-0006KQ-72; Mon, 13 Oct 2025 15:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O49-000698-Hr
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O42-0001qc-3R
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so27675525e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383112; x=1760987912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FFYu5WAdfoZfSrd8BJg28wx1m6J32jEZ9w7yIox75F4=;
 b=OmjYSYl072hZ1Uyq8let5wgiNs6/GNfoofekBj9o+cI8w+lIKER7A825qCY5GmQsNW
 0oy1lHI0Us+opIOIG6t+2/TPullripnMER+SWaYGCQ5GXAM+3R4p4RMSGyiZ+lkVcntn
 5qTYbOCC9+jgcbIhk3r7huwZwNrQQNuMqQhqAmyKdIhJYWzcIRvoLk6G73IA88Mgnggs
 XGUI1IJAqrmelAOmaubx2aeuKB9PyJpbVDAW92ccIU/aQJlIWemAoP+jCi4JLY24dHfm
 kRuj0qWGOqsQ2j3zjxk4zo9bVap6Gm43bknen1sarr3vPF9YKvC1FlgMSaqGRiO4GXSB
 o6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383112; x=1760987912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFYu5WAdfoZfSrd8BJg28wx1m6J32jEZ9w7yIox75F4=;
 b=nOZgDpO9IQSswy8NFh0/OxkjBEL1/4EFySXNc6qu3Qkgd6pdqJQYBnsa3II0wbWhwa
 8yz+zxMYOiu/ZL1CO2URZPGDKr8ZeJPuMkVdw9FopDT6ejaffDQ16+BlwSQFKsxfIfGt
 a/doIqm3Z9qwiqlbD7Nw/IPfNvPimwUZfwOdVdppjqimjzQKccsWriX8silnXp3zOMr1
 KfGsgaTLdBB43FnTjjpjvCWWZ77OlnxWJYVZ28z4QRPfuUn48FzmC98ZSNcLd/VIKvMk
 4TmQ6x6z2ik8jpAXgGzv3OxBjEe84WyljnpWzAUQvyK1gQXbuvfJBphKA0V9zGaqtS7Q
 XQJA==
X-Gm-Message-State: AOJu0YxvMf4aehzxVc0XY+IfgKVQrMnFuY4WhCVKzW2c1g+TzbPu2GHj
 R2+UwHOLJT1uQ5eO2Wjs80xrxOWPwSmH8q63aR3XOLpisM5NPW0Uuc+lfOIylomd7cvh8O/QrT1
 Q+78ah5FFKQ==
X-Gm-Gg: ASbGnct1Zdv5NRyDxBqRci74NdDlTuGBd8hur2KFj21rQSxqhFWrTQ+Y4gknLxXYJf1
 VD5HSj/T9V6kys3ytX0UmANwgt64QipSWAW+wdgKNuNG+oZIUE21jmb6MFQo5jLI7az61BMMeUK
 BrGBehGbphk5uJMw6BKObQZdgyXx/OoBdwJOt+AAqYz2aHJ9tP1Ma5rULUuuSX2jqBjkiRhw3Dq
 p2VuCwP0zH5tukv2cBsOSlmVqQgx06W23+1YZBDRUXA2Lrf4hELQrooD5prVjbk3yyHDebS4Ibd
 +b785ywfbVTJpZGijC8cx4CA5NO9TTJkihCFEwp0SXDHVIV2/NYkkWIvisELkVeUrSzupLmOFm6
 4o32ww8jpOeUP6pbiqghS+pmkC9I0t7q4rTK4vXfjFuaJQx8S8DJlC6VkgYOoyv+Qc9ueMW3QcC
 Mp7Q0K8r5JMUPhkJQeVT/2LYeMj8kdIXDczJo1XPPA
X-Google-Smtp-Source: AGHT+IGWkdnSVHJ677mWDy6vm3YInoZNlICjPUBp0Q5LPcR1uBI7swQDADG2nqO7WWsUm7hd0d/ZAA==
X-Received: by 2002:a05:600c:8206:b0:46e:19f8:88d3 with SMTP id
 5b1f17b1804b1-46fa9af313bmr150572735e9.22.1760383112051; 
 Mon, 13 Oct 2025 12:18:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d4bbsm19956108f8f.2.2025.10.13.12.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/net/can/xlnx-versal-canfd: remove unused include
 directives
Date: Mon, 13 Oct 2025 21:18:00 +0200
Message-ID: <20251013191807.84550-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

Drop unecessary include directives in xlnx-versal-canfd.c.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251002073418.109375-6-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 3eb111949f8..343348660b5 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -35,12 +35,8 @@
 #include "hw/irq.h"
 #include "hw/register.h"
 #include "qapi/error.h"
-#include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
-#include "qemu/event_notifier.h"
 #include "hw/qdev-properties.h"
-#include "qom/object_interfaces.h"
 #include "migration/vmstate.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "trace.h"
-- 
2.51.0


