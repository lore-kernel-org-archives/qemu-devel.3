Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061B3C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPb-0007nf-Fd; Fri, 04 Jul 2025 09:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPX-0007mx-0E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPQ-0004mK-Sg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so5483495e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635495; x=1752240295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5nYic5S+woPErZDBZxh3/mWAIiQzmBc40zT84YLqoN4=;
 b=n3qxbsYjXl7mcrdtgp7WTANCKPVgfKCBfEFdS5be+p4etCASNE2auDT2AYQFpI5ovo
 kC85e407pRUYMAHECa4oYobC4WC+qh4fpe6P/fgzZbwgf4TGMewDWZw4M87kCG5AxaUC
 V6/2wq2u1hWDXpfoGwOTuHNzzA0ahSVKx94k4oY0NafHKvOLXTlRQp3ejIphG86er1c2
 VvJJduKOvq9xbxQufdv8S2+XVk6aGBIEl8HdgR5vyXYATj5MXQoK6BHYQ0JbPsTkJ/qu
 6iE3id5NmBEz0v/1Fh4IRx6OAmNzvrC/GRZCVzQUh2eMZc8vCnEPfTGJRRLr7qysOMkg
 HbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635495; x=1752240295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nYic5S+woPErZDBZxh3/mWAIiQzmBc40zT84YLqoN4=;
 b=TRIAbZCp/vsMyO48WAb8obK0kBmQJbU6smL/BFxjf9UtKmRcmKzyJnuJSiORvhLh3m
 8fmxxlMGtkKQYLJFxViUf7V4tcA/7V4Sy4ptOq5f5csiPbN2RXeJn7jCmJ8wMvtekteI
 tRKEEcdHrWQmiP8HMkBxGNaPNsLKKZY3PbuJAH98v/esfD8lqY1sQYiLKO+spwfWy1/F
 SyBZy1v3Bwsun1VPLilBuQrOgRKf9gsot9D2bQNVOSFcN3gks7qkuzbq0tVib5IeSldE
 qkCoRgZ1vmnkiaWCMjD3jZFvdMLRsNbhgT6S8UGJ89VQ578Py7Ghim+/y6ReRC+FVvPr
 f2mw==
X-Gm-Message-State: AOJu0YyO6eZl7Y0Hcfl3O3q6ZGtXOE3WOoFa1Q4aC2VIX1b6J+LGF3J4
 f+i4sq7g3dsvf6Iz1RRVoNnxps94oQ/XOcYqSUxhlZQUj6xs8niwAdtoBIti1+9oM4ZPPbLJJmS
 nOzTJ
X-Gm-Gg: ASbGncshCu3aFFsURItbdtNVxOtso8ScmFCHDBZntC6SIV9iszDgc6jYiCiigxkJQVS
 fveysLDydqW/nrJnV/a4ywIfZXWSbcFcmAxXog7CZEBy2zD5BGfYkXY4eEawSbfb3fGkrTWQjN4
 JPtxSMFkS/d9RGsacYkLPR2CZ8/byFCxL8PfIcHbkCm04nDiGQkVf+xS5TJ6Ebq87HvzPk76IzS
 Kk/zjuiyfPeXMOziskqL66TCA/fqdagiPPBC5VqXCnlDtxvF2RZGbt+0cm8YjGpOXui91Ulq+vC
 p0XqvL5TezkJX5Y5KDR1zN8EFte4enjvN0KwbUET3Z3WJAV2Py+w6bX/MepIlIoPDW1/GIUxsRH
 WraozAZk5zudxs+53kpp17tM+nS9S+itKZVZWtbK9AA==
X-Google-Smtp-Source: AGHT+IFaUnNaZD/79EYQipsGz5W9Pk7Zk8YaFxrBgGHK+lPXQi0QhGgqjVqIK4xLT86yu0ptLIhxqg==
X-Received: by 2002:a05:600c:a113:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-454b321fad4mr22500875e9.18.1751635494802; 
 Fri, 04 Jul 2025 06:24:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1696ca8sm26991605e9.28.2025.07.04.06.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:24:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/36] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
Date: Fri,  4 Jul 2025 15:24:36 +0200
Message-ID: <20250704132439.25743-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

We need the QEMU binary signed to be able to use HVF.
Improve the following:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
  Abort trap: 6

to:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?

Suggested-by: Shatyuka <shatyuka@qq.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Message-Id: <20250702185332.43650-29-philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index ddc77e629f5..09fe3f24152 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -263,6 +263,11 @@ static int hvf_accel_init(MachineState *ms)
     }
 
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    if (ret == HV_DENIED) {
+        error_report("Could not access HVF. Is the executable signed"
+                     " with com.apple.security.hypervisor entitlement?");
+        exit(1);
+    }
     assert_hvf_ok(ret);
 
     s = g_new0(HVFState, 1);
-- 
2.49.0


