Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5FEC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVm-0002Kf-SK; Thu, 01 May 2025 18:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVi-0002Gb-Or
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:07 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVh-0002yT-0G
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:06 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so16215305ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138963; x=1746743763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNtrhN9YbjPg/7Nhp3PsvLWWauM2W8aWQIlB3BOayNg=;
 b=w173QeWglOYzvCY/Y/j1ATi2AYFD9uv2e46kyvg7Jz1b/lxiQcMTuOLVdSGmzQ74uu
 zLvjdAEu8AsJ3R0xKrEjOn72WdCiXVfDuEujHyX0WRPDUKqgNssefmjg9+GaxfCYlusc
 cSOzObLYyoIOrzzsUvGq1kYBheHHq9Cka342ufggtuizqrnG2AaEuCMNB66ib6m2lWvt
 xi8meb4cod+nFH3EUAd1yAWEEbRO081Pwtm9lBRGHiuKSc0NhtiDBVHSMeKWl351lYAl
 DUHINYsI9qp8xjdJMLK1nwsFEkHIdI8Q8Yaeyk5gQUVhLmATmvdsb9LF7DG61a68+81/
 fiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138963; x=1746743763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNtrhN9YbjPg/7Nhp3PsvLWWauM2W8aWQIlB3BOayNg=;
 b=SlmHEdllhUeqNUIgqI75CJEaNFfK8nzU5AD62oZhGNHtOOqBLtr6QUmeF03zIZ+YG1
 3edtX21HAio86F/pcahbn8IM2FAXAck6TvXXU7WrE8uQhMGdxA4Sl1RM86JLUNRIuPUm
 WqEArpwet3deV/03sg4wyM4h+b326ugq3yHkUOaID/TuwXwJcFIfKbXrMezUXT1xGIpm
 vtT8CJhc7v8B5U4VjqL42jY+bmRzIoqzXZgYB45GVe6lpH0CNti6g2d/2tAPGb2MTp5C
 47Y3yoLMMFl0h9HfUx97wMBcB98787hJt081G/XYItgNH9sFXScUgv2Tf5T3qEPYrdtr
 iduA==
X-Gm-Message-State: AOJu0YygWUUFmkCq07iEjqwcX/l9tEuSw47pNIjD6JZ77mrOZOjSxEnm
 t8soRFTd8i1ndsoh+T8H3FwymwBGlF8f4g7fwSveHtOvV8ZhsQIGyFfHLaM9GIxvaboQKIBnJqK
 H
X-Gm-Gg: ASbGnctjnFcYrZZFlxXoTg8IjVnqOPR+k847YpQsHn5Xb//R7CXtsp8Tp3O7egDWMnX
 bdUTBvgrb0bF/xqH3OWX0UgaugxYO1fMXAcmlGJcDivCOZeVGBXr0lYKMWgwv12XgpKr6CtCecn
 vdNbXmuK9rid2vAs8QdEaEJOPpNyxTBBm60+Gp5a3kpDowyMnRyybMGIHy2+6YUJ4W5NXWq6mEk
 2RhScqLZu1Xw1GQmJ0zPVYH7Ht9ANAZMOMsWlEeGMnsvXBaX7eiNx2u38T7M/WWy3jhsmdj62Lq
 dSEZjyKubLDSnknK3JhBhWx8CFwiC2XXb7nAtRB4rZ76BOwUNMjiHnm59fikcMEWMfzpCuGYhnQ
 c9kQJ51W2bj9i+YeXvb+1
X-Google-Smtp-Source: AGHT+IEaQCgnznCC6qYs7NfzS2fXNwM+qUoiosOfZWq2OJMltwKnc6G4ral0FiYnHr/6YfFixLhJuQ==
X-Received: by 2002:a05:6e02:3387:b0:3d9:666f:486d with SMTP id
 e9e14a558f8ab-3d97c237decmr9904005ab.15.1746138962901; 
 Thu, 01 May 2025 15:36:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a916042sm80567173.40.2025.05.01.15.36.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:36:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] hw/i386/pc: Remove deprecated pc-q35-2.11 and
 pc-i440fx-2.11 machines
Date: Fri,  2 May 2025 00:35:19 +0200
Message-ID: <20250501223522.99772-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-il1-x136.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c |  9 ---------
 hw/i386/pc_q35.c  | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f0f71de4405..4de84bce8ef 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -718,15 +718,6 @@ static void pc_i440fx_machine_2_12_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 12);
 
-static void pc_i440fx_machine_2_11_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_12_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 11);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1bbf2385431..4839e8c5731 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -610,13 +610,3 @@ static void pc_q35_machine_2_12_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 12);
-
-static void pc_q35_machine_2_11_options(MachineClass *m)
-{
-    pc_q35_machine_2_12_options(m);
-    m->default_nic = "e1000";
-    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
-}
-
-DEFINE_Q35_MACHINE(2, 11);
-- 
2.47.1


