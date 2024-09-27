Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A93CF6480
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIaN-0007u8-QJ; Fri, 27 Sep 2024 17:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaL-0007rz-Ni
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaK-0002BQ-9r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37a413085cbso2568052f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727472786; x=1728077586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9zm+sBpkfOJThBc4nEo/SB2oeHmD37YPA9r+McQzdo=;
 b=Qra+TMPc/b0QyGOoz//7ETyjm0476XUcEtOJ/xJ9EgmlygBeQ97qvv/+IVs07ilzwZ
 nGedaF7rvPtKuRP6yM1UDLt1MjfKmU0t4C0BPWmM/iBvnXZWkcTxWrNDGCTxsdaKnvmp
 3c1//UknS4BctewQYAJsMKxbZmnHK+aUtwQKm/pGQwlCHg4nHgeqZIlwvpn0lLdto86u
 lygx0Pwynhi0CI+ung1KE2k8VIXVHdk7Qs+TCREmCbO70mEFYGfz4JQkj1Vt/YlyHpA4
 dEZhaRaAFkK9j3/kucc0SP6u1cGecC/znPJBp3RFPn/asREc3CxLYiTyajDvJTbBXPYP
 XQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727472786; x=1728077586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9zm+sBpkfOJThBc4nEo/SB2oeHmD37YPA9r+McQzdo=;
 b=tgf72xFwEjS3PPEbHtN8AjaJpmELVH+a2pd/8xW2L5C/RadpNG9KLoOaG+/mXd9B0x
 7ahOHOftC0v7OwmuVhFrIVQstugxGEXn+G8B7MNH3GtYoTlTBIZHJxOwR4Gd/MHKFtvv
 3q/M3FB4LJhWAos6/70SHPXFpX4UVZ5Fshax6pjOY/ET/zRDlHFgKcTe6eTTYlXyclBP
 dZYPVLnKEEskwbGG8h5r/+NsuBaxfN1F6UxrrShvRUyixsoR1KwuV47L5MWmvxz+/W6g
 /YI549v1X1rPw4HvuJv/1DDyZruZ8I2Jee6I1i6U+yQ/U+m6afTEnc7IFwfdHXC9LjLg
 dqjg==
X-Gm-Message-State: AOJu0YywhrxCK/2YePFgfs3fcEympKFEW9q5op1ZWARVOBQv0nBI7+Hg
 QOmyToJP6muuBEDkkUa/sV068UI5+6MM3W1zetO3uCgFq7y7pDEMHCRaswOVu9qpPV1WV7bl5/J
 Q
X-Google-Smtp-Source: AGHT+IEd9QCfarIuSK4tIer5YBAuAYtsJ/NoGnne/z+pIZ+V2zG/c7LQJfoyV1fpoHWzJs2StKVyCA==
X-Received: by 2002:a5d:634c:0:b0:379:5c8:33fa with SMTP id
 ffacd0b85a97d-37ccda6c493mr5507631f8f.0.1727472785696; 
 Fri, 27 Sep 2024 14:33:05 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575c830sm3350556f8f.111.2024.09.27.14.33.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:33:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/loongarch/virt: Remove unnecessary 'cpu.h' inclusion
Date: Fri, 27 Sep 2024 23:32:53 +0200
Message-ID: <20240927213254.17552-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927213254.17552-1-philmd@linaro.org>
References: <20240927213254.17552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/virt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index c373e48f27..9ba47793ef 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -8,7 +8,6 @@
 #ifndef HW_LOONGARCH_H
 #define HW_LOONGARCH_H
 
-#include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
 #include "hw/block/flash.h"
-- 
2.45.2


