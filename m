Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50829CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk4-0005Im-7k; Sat, 05 Oct 2024 15:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk2-0005Hu-S1; Sat, 05 Oct 2024 15:47:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk1-0007dm-0p; Sat, 05 Oct 2024 15:47:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so31848255e9.0; 
 Sat, 05 Oct 2024 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157619; x=1728762419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BezNNdk3PkYioTUt7iat3P1nWyR9v8iNK3NeX7XEJk=;
 b=CMrg7EZZN7E69XS/vcRD2eb8Ex1691lP1qro00GCZJ1NVHCjH8Vn2SZ4Q/C/H5+ZTc
 yfVEa6xkWEWaqW21mn1ngh4toMUdPfFNcLRAnLRnB/bAOSvO6Z1z7XZITX85om8f5miu
 A848M/aqPkYXUMsYEnpcTqE4oIJEJyUQxXSHzHnj/ZgDqXYqwLXKD7cxtnhKMbNjpcBe
 wUeAlRjb/2a44pHpDjzm9d/0UTSkFcCPpepGCNLXGoD402SjsuPVeF0XOxHzV+iysXky
 ANB7aFle+T98UVqAtg7VjgId6/xn+wJjizot05rlG14T5LbMTdyorqrRez7BMI93IFwx
 XukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157619; x=1728762419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BezNNdk3PkYioTUt7iat3P1nWyR9v8iNK3NeX7XEJk=;
 b=j46PWGdMgW69adUFgQpT4VYJEKcI2gG6oSHdoYI4imRIOW8ympKUtHyS6AR3ubKdnw
 DxVDLnFhwyhqNjL3lwVrP6B7z+MUhJW9keKb5dUa4864Z4HLsWD8EQ1b3S5jqqQBejLK
 2BTubMQf0lK2HMjYTN6F4qvg/bsaz03Ye2rAHjXr0iU8wVZ7lzhCFVV9Y6p3ifDYGVXv
 ATrRTK0cIE2NoNjJSpedVjPr6bsMnRX+bXBH49rClYuLfrhbF81Z8yvVF+JORfjOH6iu
 IgquG7ldsn86nFZLUnsk0AmFLWKOpWc9GmjmgxntxnqHe7aeCqjiARpUALuyrnjlztS/
 TtnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXeFkzJ7dRbGPy6MLfv+Fn/J7747N9d+B/CdcYNVrzIM2eKl5zQ4CRkFlb7v3Xd3WnDGJWlympeGDr@nongnu.org,
 AJvYcCWvUkuSA3Zb/FZuf8FH2bisXjOYYKm9dI0JQwyPt03Wj46BiDKogmyncCc0ak5EjrjKe7KN+pNRGYk=@nongnu.org
X-Gm-Message-State: AOJu0Yzv4XvM5kA82Sofw5veqMP2leeit0sRaF59Ok8R986/Qbl7p4V6
 SRT/H5Tn4aPc/C9w6hSmDvUeDExxW23BM6DfB+p2eaqwb7p0I+9Pax5eGw==
X-Google-Smtp-Source: AGHT+IGFgBbGivkDy5FOm98fjJjeBpPC2RekHxbbgLD7+eRwJKg2lYf75ZfPH7R3MfKq270SkHlUBQ==
X-Received: by 2002:a7b:c454:0:b0:42f:8ac6:4f34 with SMTP id
 5b1f17b1804b1-42f8ac65216mr20162675e9.35.1728157618622; 
 Sat, 05 Oct 2024 12:46:58 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 04/23] hw/ppc/e500: Remove unused "irqs" parameter
Date: Sat,  5 Oct 2024 21:45:44 +0200
Message-ID: <20241005194603.23139-5-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 32996c188e..228287b457 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -825,7 +825,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 }
 
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
-                                          IrqLines *irqs, Error **errp)
+                                          Error **errp)
 {
 #ifdef CONFIG_KVM
     DeviceState *dev;
@@ -865,7 +865,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
         Error *err = NULL;
 
         if (kvm_kernel_irqchip_allowed()) {
-            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
+            dev = ppce500_init_mpic_kvm(pmc, &err);
         }
         if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
-- 
2.46.2


