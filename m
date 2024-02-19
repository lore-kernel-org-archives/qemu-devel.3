Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A87C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6g6-0001YJ-PI; Mon, 19 Feb 2024 11:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6g6-0001Vm-0N
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:38 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6g4-0002y5-Dg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:37 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so2384253f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360774; x=1708965574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teclhIdRp9DBtUYfsv1Nj0vfraIqiRBxDKPN1DGCTw4=;
 b=Z0946+W8T0GVl3pUl/1DR4QtwMAFKiJxmmUHrvs9pZOaBsj8N9T4lteRrjvrU94xm/
 Y81slROxwNxkET+6eL6lb/1uVzapRxs3ddfACSeg+ai6MA496VddafzhAWmgwJU8/Sfs
 /4fwaQuvpxaWFEMLytevb3ig+u2JPN0exV1ak0eVs1dUuAxMPs4wN0DKc/U4HW+r2YZX
 73hH0j3fja51or7svAXp/7weqNon83+kfMvF06tZRAaBVlHV4OPkafL1Gx+ykIl7Wik1
 fJyeIhfJ0dz6Qoe13dvrOXm6LxpBRZ+OcCrGPuEHopx08jVL4txM5RQTBIctc4UbN8sY
 mm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360774; x=1708965574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teclhIdRp9DBtUYfsv1Nj0vfraIqiRBxDKPN1DGCTw4=;
 b=RPe7fUm9D7kOf2KyTZPDzpkgPMfY+4ew01A8ZNwsJ6hhzZ1jVG4UZtFdYK2C7Uz1Pq
 19Is+8we2WieqX5tq1W5xSkqLPpMaIsjrIPFizvdBD9C0HSH++gy0tA/a7g4EYDbcs5K
 PlMWxqx0FxKaQtyVe0tqFNWml526UKew15woAyRnAOCJmcCM2gEcPAmFafZM/YPZLo58
 HAoEK7JXgB3ZWbbEMLEwHn26n0W7On0TpKn2pUmsnTrIGj1DG4Yo5A2QVWgr6m+CvgKJ
 D0q3TuqxBjywwe4xt/bhU0ulVy0345uMt1g6DeCqgd06IEDmh4heX2feFyxp+sx6WmFW
 vFQw==
X-Gm-Message-State: AOJu0YyLWNwLGJGK+4rxyr8EAdmubt3PtckPhY4YVToMYALdg1CkhVAV
 tn0On+rrBgMRI+J5kqDYsldxgArkg5nK33DHeD0Spbo+Ef/kOh7fK4NDDbybjfPnyVPQS1CJpXj
 3
X-Google-Smtp-Source: AGHT+IGi8R34udasU67z3s9kYOt7Ya2ymAiPIfqO4AcqkX/hMc2iN+ZrvRgtJ3yyBludnc5EaP+Fpw==
X-Received: by 2002:a05:6000:1864:b0:33d:6334:e14 with SMTP id
 d4-20020a056000186400b0033d63340e14mr373508wri.11.1708360774545; 
 Mon, 19 Feb 2024 08:39:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 ay3-20020a5d6f03000000b0033d1b760125sm11129469wrb.92.2024.02.19.08.39.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/14] hw/acpi/ich9_tco: Restrict ich9_generate_smi()
 declaration
Date: Mon, 19 Feb 2024 17:38:45 +0100
Message-ID: <20240219163855.87326-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Only files including "hw/acpi/ich9_tco.h" require
the ich9_generate_smi() declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h    | 1 +
 include/hw/southbridge/ich9.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 1c99781a79..68ee64942f 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -76,6 +76,7 @@ typedef struct TCOIORegs {
 } TCOIORegs;
 
 void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
+void ich9_generate_smi(void);
 
 extern const VMStateDescription vmstate_ich9_sm_tco;
 
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1ac4238f7e..bee522a4cf 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -11,8 +11,6 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 
-void ich9_generate_smi(void);
-
 #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
 
 #define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
-- 
2.41.0


