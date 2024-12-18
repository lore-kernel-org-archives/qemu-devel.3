Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79719E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2c0-0006Zj-LB; Wed, 18 Dec 2024 17:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aK-00047h-An
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:11 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aI-0003VI-LZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:04 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21644e6140cso1699135ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561121; x=1735165921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TduC2J/yNmTTE2R5ICRn5/t9vkcz5PWA+UR8MkeO9Bs=;
 b=DUNxedke6pbRx49uLGs4Y0KcsYVzvGZRGNirCyG5QF3IBX+EmrjazW31HPWQO1KPDV
 JLTP6qj6vfaOg8Q4BGB8EumSs8V3GQA7GSqV0DRDfIws3tRzdWc5valiiGQKLN1sJlHr
 8eLIxnjTZzk1PGpjxBu4PUQq0TIArle2T7SvF3D3lFVYeI2YwjDLUmoDb8yT1UCta/OY
 Ej7jxrsACt+Qe2tON73ZIi0RpPldikWvQTg2fTdtcur5qSf8lj+z6CO05kzlOc972Qif
 WjKOZp3HvQEDLBHcFkIqUBks9qOycfyUJvDramE8e75XE15EyyH2xXb0CMedudP2jlh0
 F/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561121; x=1735165921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TduC2J/yNmTTE2R5ICRn5/t9vkcz5PWA+UR8MkeO9Bs=;
 b=SCOxq76Q9tKU0lclk//85XIBddubyDOjx90ZLXMJ/jptxP+omevX0AWWH4JK5s2qXX
 999fWceE5nRo8vk/j7+PxoSyzwGaUINdwYf47lCEpF3nbNXmu4pPtWIHGp9pMDno3zaa
 sj9PsLY0ckbc+SIKRrW2ahWGs9E6itn2lGAApWv12s3izhs6uU88J9x6LZIMcRS1lN5O
 p71NMK1snmX0RsJ4E77gfWfcjNNnt8OTKVCWTiXTA4QTFxTnHiK0L0jiIOF1O0Iz3r9V
 BFlRmAnmDxwnHG5i8zoJBw4mQnq1TU5rQP6MgAknycQdx4UOMxmNPp4qWlsvgqP6fwoV
 P6yw==
X-Gm-Message-State: AOJu0YxV4h+iSMQ5KsmBcRxxwkRzT85hrCJLXNYEgrkFmjWovlvEJcba
 cgg++RhKbcPmj8cGE8rkzT1192KGm/0nLevd+k2y6XYAFz6An7Y6AQPbyQ7X
X-Gm-Gg: ASbGncuRJz2FB/PvgB7zrTznmRcPrI7OSx+75oK1XSJCua0KjXQ6L0nUtcYxmPZKZQP
 OT3ryz84Dr/lcgrHyK3beTTr85Ds6Y97468eZbcdLFuA2YRvmA0tQfpQ0mlYWORqcLOFkU3JdDX
 xsKgiP58fSUCX+phiY7zP1GeX4pYhvMqWvfoChUuMuIxXfzs98UGKApFiR7pT+GMSOSVEtODvnS
 GmrkqUiKhX08syQBgggbwKbI3sKeCtRxsoARfqXPYeAg9ZwxeWMoCEKfNv9JppQ2/svWOm6n07H
 ZSeTIR8xUXKnjaxs5u7PYI1RY8NOsgYQ8dehs/CVpPuFP9h7EQTJ53+2JTyDD9M=
X-Google-Smtp-Source: AGHT+IGaZlQEzir81UMCqDFHXwpDZ9fJRG390eMLWOWDeVzJySiOTTv7zGKK9jijNlVf2xLc5GMW7A==
X-Received: by 2002:a17:902:d510:b0:216:3d72:1712 with SMTP id
 d9443c01a7336-218d727b5f6mr63635285ad.48.1734561121114; 
 Wed, 18 Dec 2024 14:32:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/39] target/riscv: Check svukte is not enabled in RV32
Date: Thu, 19 Dec 2024 08:30:04 +1000
Message-ID: <20241218223010.1931245-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

The spec explicitly says svukte doesn't support RV32. So check that it
is not enabled in RV32.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-7-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..3b99c8c9e3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+        error_setg(errp, "svukte is not supported for RV32");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.47.1


