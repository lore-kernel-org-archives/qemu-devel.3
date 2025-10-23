Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E28CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC559-0005DG-Qp; Thu, 23 Oct 2025 19:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54s-000541-Gm
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54m-0007SP-Hv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:41 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b6cf07258e3so1090024a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263434; x=1761868234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epTAxD5qTIBr78ty+Lt7XQcrxEgeR2/1ctmBBVhqSCg=;
 b=YEMHqM/mKQJAktUkXk/CJEibHb9DT2s/FBvugkiC5shjnW8T3joG5jC0LYkjBTV5XE
 r8A2/hBGxmYig9/q6pF6jr7zoVIKkdAKyv/ultHPAax12g3qkPc4MFQIQm/tXxtL9o0L
 i/b+xq+h8qWxzDchcMdX03iXyvgcAWhos1OrVTYbRSvId+R+BKyAa7P5yOMQPZzuiGHq
 4QvltlaLZZ0/x1fb98UZ7HuIX53nSWLml2Lgcpyp5EY7/Dlh/kADMhlroTCSLAZSlmJi
 ALCrhfM77Vjq46wwM3o/QtlzzYXmVrti9o1UXiTzdm2NqwxEIS+b8IQx1+cL0Sc4uyda
 W7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263434; x=1761868234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epTAxD5qTIBr78ty+Lt7XQcrxEgeR2/1ctmBBVhqSCg=;
 b=kMk8OqnxOpDS6tDX8OPPAdq95Gq02Wu7lBrDUYYnSQpfdCr3hZqQEciBvyqTH1jc6k
 W1GsEY4HuEpt01chsgbIq/XS0PQVbOvhB/aGhyxHthG3G6bi495mg1SM98vwL+Md4pFH
 5hfvtYdetXMbeS6HJ9jA3ozTWfxoD6GeeEiYmpSe0WjTzj4eN4GPoBoc1NF0blOLcQGk
 Isg9Cv9Tru3I5s7/WGjq3o+SIExnASSUE2m54jPpqixI0QAGyccE1kQ8hhzucPO3co25
 5z1wi9xg5FZzIlTk5/+/VBMrxi6k4CzgxZ36vWr0uyraE6NIYJw3D7mKcdZz0Mz67U16
 picw==
X-Gm-Message-State: AOJu0YwkcWLPBWSiyuvKeqmBxUKXCOA8TLMWgteyzQMqK0qCX0MTYUzI
 j+BCP7UG5KMVt/9zoZYYzeZ2T3ace/pbj/fDUYygrkDSthrjk5xMNOet80/6EA==
X-Gm-Gg: ASbGncu00N7vpJ0uHVZ4RarcJWqWht7QHZuI38fjo5Hbpv1Q0dNuOVk7741/IilXeCT
 mJMv8FaJS9Wix0dnYCI3uqST+48WOCVZ3BN01CgkNBg9/OWaTyl6uXycrIVEYFa80cwF9BT/Xpz
 mYrN0d8hzlkqBruVmdKz7xp556ryXSM5w9B+K7h/vFQvhT3WvPyAH5ZBVMhZjZ0WkebJXgFJLFY
 x4qf0qJ/l0Q9dSp1OQJCKDTXkE82aHl2bMlhGBOKm1SviqigVQZlRodcgTXrBdjSPJF/v+dt0h3
 YP95TluZ3FRJ/6fGX9bM9HaYlOgDWSIqYbxMsHs6NTBA88PSi6u/qP8hfZ9LYXzNGfRI7cVbDz2
 xIs0qVU6B8GHrHNicqJ0V9/PRFuhDxhnWDRA2Vn8wrHNROGPAIxA+rG1DxztUDmhFI5a1n3qPww
 tsNuXlR65Y+WAgXGSP74sZmHWuuh3bv9csfZ/PXZDTly7xrnPPDdEnlEKSD1JDY++FkYOFs+Dm8
 hTerNlfpdNi+uVfgVE=
X-Google-Smtp-Source: AGHT+IGg4Vl9t/KlUMEPH+N/gvOWj6XP9aIprgjW9YFYcN9dYez5f0ySWOBZf/fHw3qKLMci70Tpyw==
X-Received: by 2002:a17:903:2b0c:b0:27e:f06b:ae31 with SMTP id
 d9443c01a7336-290cba52787mr322987095ad.61.1761263434284; 
 Thu, 23 Oct 2025 16:50:34 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/25] microchip icicle: Enable PCS on Cadence Ethernet
Date: Fri, 24 Oct 2025 09:49:19 +1000
Message-ID: <20251023234927.1864284-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

PCS needs to be enabled for SGMII to be supported by the Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-5-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 9fbfba8ece..4c939d8e96 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -415,6 +415,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
     object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
     object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, errp);
+    object_property_set_bool(OBJECT(&s->gem0), "pcs-enabled", true, errp);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
@@ -426,6 +427,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
     object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
                              OBJECT(&s->gem0), errp);
+    object_property_set_bool(OBJECT(&s->gem1), "pcs-enabled", true, errp);
     sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
                     memmap[MICROCHIP_PFSOC_GEM1].base);
-- 
2.51.0


