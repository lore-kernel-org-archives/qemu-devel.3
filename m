Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C37C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJyG-0006Ch-1E; Wed, 29 May 2024 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJyD-0006C1-2F; Wed, 29 May 2024 10:08:01 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJyA-0005jW-F5; Wed, 29 May 2024 10:08:00 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b7a3c19b0so89892e87.3; 
 Wed, 29 May 2024 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991675; x=1717596475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEv27P4h9FHThImWZFNAzfWD14sQulMv77KGwqjc99g=;
 b=GmLp6uVBpfpPp65H4Lta1X4IKs2vtmyu6m9Cd59jPMHEC08tCAIj/JpntShn1EChB2
 58m3aEqIyRdfg0ZOWImYkht9k6LJ0CPvTckI6yHTvJpdA87Zl3J015qQAlONYbCM/Tg4
 8hvwDMfM7T7CWawF3wzgIswHQ8S95uxJ9C33xBL/0e2v4nmOUyZjzndGA89Dn2CMwXlF
 kAfCWNHhYs7L5kCN6Iv6bwJB3MIKKg32WXUaxhicdFlDvTtZlmZJbI/S5aivInuxxAqk
 DJxHXxC0Wfm2mVkUJwkODRuuUeXWoyVqAdoSAlTd3AhrfVsZ+9RGJ/T2YLIehIkb6TcN
 a6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991675; x=1717596475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEv27P4h9FHThImWZFNAzfWD14sQulMv77KGwqjc99g=;
 b=wY70hsOh8eAEfo1u6elmwwRDRdoHoQ5wr2Dt7hpmnEAnGy4/yHTUc6Lntz+9LO9zVv
 N6t0/JNA3eSLTrIyz2+Ov12TWHz1bYhkOqhotE3gOaE+HEGDJtAPLGaWHRSgFdvJcua/
 Cwq18vulUDkphdCyD1TERDH5WKCDTe1CsA9qESJ2SU8A0YJzKKiR++zEFGtU6PLbRIi6
 NwZFGwx+/lfYWi7mVMlBbvEr3SarVSFUQ2beq/m85iEyAFiG3Imv6VWvp24pmayoMETe
 +bwVg/BlxwNKovk/wYpOzhY1UvslFWV3hF6j2yAdfcZStUkHAzojlln3qUlIOdZvcdei
 2KzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1AxCI6zFg1YPOEgHWN19SKSmWcRfgo7XfcVZzRV7O5P9HkV2d10f8EdxDmjTBOuIWk6OdAalEPyo5pOutSLlvqChV
X-Gm-Message-State: AOJu0YyLLwG8lFWA6H1C/bUgWuupT0/lLTjZCjphxH32xD7HldhG3DO+
 oBpo1rdmjWXwr9M+BUd+tfT2WI4wdfgiFfH9reBxXHfBn+mzSeXU4plpaBlE
X-Google-Smtp-Source: AGHT+IEL0r6gK0il/RzsaJAW9Kz7pktj4eJeK2D4zknuRjCDUMpY29QDkroYx9PyQXCu1NbDqU9kWQ==
X-Received: by 2002:ac2:4904:0:b0:51f:fcaf:e92d with SMTP id
 2adb3069b0e04-52964baf401mr9487810e87.18.1716991674993; 
 Wed, 29 May 2024 07:07:54 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52970760245sm1290849e87.122.2024.05.29.07.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v8 8/8] hw/arm: xen: Enable use of grant mappings
Date: Wed, 29 May 2024 16:07:39 +0200
Message-Id: <20240529140739.1387692-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xen_arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 15fa7dfa84..6fad829ede 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    /* Setup support for grants.  */
+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.40.1


