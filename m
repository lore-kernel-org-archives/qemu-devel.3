Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462F7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dLQ-0008FX-W4; Thu, 16 May 2024 11:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dLG-0007xL-5y; Thu, 16 May 2024 11:48:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dLE-0002x1-NQ; Thu, 16 May 2024 11:48:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34db6a299b8so6208629f8f.3; 
 Thu, 16 May 2024 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874501; x=1716479301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCUy9HbKYqkB8J3c8ehjTn+z8ZMWUL+bdITYZiFkB6s=;
 b=ASqp83IXu2EGJ1fIG+YNAcfKQJauEMO2bmlDucuuXBwncLq8C8SIaPEzGVBRvPmW14
 tujT+NZK/U8mH703KALfCFXlyTt8XK7zBCkLFXcQz4q4W7Sw6rPXTrhPN0pvDhXjOuRl
 rIob+YvWBjgnZtgRG2cEmmegXftlPXbD4FIcKs7affMuV9aRafjeUrbo8djhHLD9+qt4
 2L4qlDYae0pNWn8O5+3z3q3ZN2kCv9mZo5zM4iY4GvNYaglPWwQusmVRc5nWboP+JgkZ
 Svf86QPH5e4qt7+9mblQPivoxKn9zzbKTx6jWXdE/hFcqQsY/JrRQNM2vfKRgQT7TOU+
 z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874501; x=1716479301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCUy9HbKYqkB8J3c8ehjTn+z8ZMWUL+bdITYZiFkB6s=;
 b=qX5lZaDOZMdnfiJV5yQ1QimtH17FPAZjGTWxvUNx6B1JRHkkv4ng7lNN0l8kvyRjB9
 bvt9nkDW5Mjqp10AsmEydNXQdzglauqK1jd33Dj6PyY5iJoNJAXdMdC2B1Sdo3kfbzo+
 AfPowTpWX6rI9YWuzR/8SBywwAcZZQmZdCNvA71HNs+lhoPtsiHUWmAk2hpm0bxPjfIL
 6aq6IbGC3QJ0XlrStYAokFUJcZqCSh0CDxdEggABr/VkIqB+Pjdkf+bzPqbagYtRemji
 nne9Atp54ssgTIhHgAT9RvwxypNCdZY0E1ldduF9Vb79v1+CSqIPMsBRes4ia5UexFhR
 23NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtdFz+OFmibX/PrgzokFjIOFEubbcbeTZX4QcN5AI0beOszoGuYLU3lQhx4ES7755OaNuDwwP7hy3SqKZyVUKK1ees
X-Gm-Message-State: AOJu0YxU6Yg92PINBKRSJHyJib3tGWU6Zysdta7ytqZj2DVllVbAMrzE
 2/N/S4OrY8b50+MMl+v5Mx0gizuhQEMDej03nvRAdQZd1VTbW8WMtlK8ENy7ybc=
X-Google-Smtp-Source: AGHT+IEwcZbEPom12z3812kMP7vsTMcAg8TdMvpmTOTbEOi55joxiQSv7I6fMODFQLwQnMRBeVPoow==
X-Received: by 2002:a5d:5701:0:b0:343:b942:32cb with SMTP id
 ffacd0b85a97d-3504a6363ebmr13666343f8f.21.1715874501537; 
 Thu, 16 May 2024 08:48:21 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacef2sm19457771f8f.85.2024.05.16.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v6 8/8] hw/arm: xen: Enable use of grant mappings
Date: Thu, 16 May 2024 17:48:04 +0200
Message-Id: <20240516154804.1114245-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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


