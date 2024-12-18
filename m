Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF5CE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2af-0004cT-LI; Wed, 18 Dec 2024 17:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zb-0003RE-9S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:24 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZZ-0003Hv-Ci
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:18 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2164b1f05caso1579325ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561075; x=1735165875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTdaw05ysd6G+Wo/MGIHYx5h64ipYyB+ZBS1Cs3n/8g=;
 b=RMJuqMBedufBHBg4NJixEc4XoEsvuWCUL7Ve22sXJHrQQ10NyOsPzqJXu09YeI+/jS
 9QoZiQSblnS6XZH2ZLd26cUZHIoFcLuUyOAx3cnDkQjoYGNye4xkInUfzu3hjAH0r5Qs
 +r2PFQ+R8j2IXEi7OCSXmMHBpYUXOUZVf0ABLFIsGNAeolOq8o617fhGoOZ3XDFoW/WA
 czicOE45iaqSI3TmOuTPIxX2UMlMjJUWENGkcqQ0t/efuuUDlvPpIEWG/g/HmSZP1AAp
 rOVUyd9IoHvk7KU+2gnbWigy+cdzT8JUKOBEl48sxT9ct0MVCj/wxfOE4ia5ngepAWql
 2Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561075; x=1735165875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTdaw05ysd6G+Wo/MGIHYx5h64ipYyB+ZBS1Cs3n/8g=;
 b=Ha0wR5d4HCiKGC8KbkAHvTfOeFcwGWTvZr17qWOMOyEifeV4HGktn56PfjHhgN4xgU
 AtYU/nWBrH2cHXIrK945CXPnf06sS0rrrEdNUiac3LytjTC6KHsXI7XdLtASasocv/h9
 yft5qMJHbIqxWg/hkJAHVtn04IFxv8hXVYqJ2pMl/XQ2+2YGBgcEoCzR2QuMD9t842l+
 XuC+i+0vjFjWMwhzUj+jnH3oymDbYtUj3y33HpU6xvWf7P/1d/QOksKH9nmwWfQrK2qu
 28SenSd7ZXzJUZhgFDvXkue/7OpMjQarwFRyxnZsDKomXIm0YQ2Nx2LbzS9EEvNvBN3O
 j7ww==
X-Gm-Message-State: AOJu0YwAXCZ/HQCmDZ7AujyM6z7Gll3hrRx1Oc8N/2Hzp8T9AKGXTKf7
 2fGhtbsyc1G8kkRVJa2gJRZP8/XGYUoC9BiLB8cBqwgQ3il6k5NkHUAGDPbj
X-Gm-Gg: ASbGncuAAtTDb5w9UIA5utdB0cr7KlxS6Ohy2nkqTL6WWqdzTlDqnlXeqiy1A1iag5L
 MWXiU1sirD6KYBwI4rzA9W/P40/PdwGeXdXA2uyyGh4isYAXkfYK0Zn1QYl5xVW/NU+JkvWgpYO
 3NVpp1QVNH0f3pE25jYf6o/267oPWenzUOq3ZPsyQxIbl+tlW9x9+BRqxByefwsVlOB5ROf7P6S
 8Y1MhtVdQ/wueEtFQRGGL34pVJmxVaXbczD/cvjgvTc/+GkzDQ60KOUVO2x3t7FIpd+2nyLY8rt
 DkhjA2eL50/R+9Ma5HVOsEmzWUBx7QbeRFXDDKgHpUwELCZK8Pyxyp84SERWrLw=
X-Google-Smtp-Source: AGHT+IFOucXHv+bhg8XLguNQq0hjcOFzp/mK+hAdwnhnlnbX9gSQp9sVK8i290A32LKbcpZHuSd9ag==
X-Received: by 2002:a17:903:94e:b0:216:46f4:7e30 with SMTP id
 d9443c01a7336-218d724d319mr70656235ad.43.1734561075648; 
 Wed, 18 Dec 2024 14:31:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/39] qtest: allow SPCR acpi table changes
Date: Thu, 19 Dec 2024 08:29:50 +1000
Message-ID: <20241218223010.1931245-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241028015744.624943-2-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..aae973048a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.47.1


