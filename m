Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF082C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAr-0006H2-Pa; Mon, 26 Feb 2024 11:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAq-0006Gg-O2
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:52 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAp-0006Hh-5N
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so2237839f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966189; x=1709570989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9EOnAK3G1S7aJVMzq+KHRG4+8D5fltRUtqq+3DIXP0=;
 b=x6/Lrd1owNB+jwKi2KoKD4r40dk9XP8Ho7rH5dfjkyfBhg4Z8NszuA77V/Lw6it9Ad
 5yenYEJHZKbbkKW+g09Q1SLvngfTc6n+FiU6ixWFU9N05rGJQIN2PGsBqEEfOREqE9ln
 aexM6nm24NDMMgY4A1xLDjeK0rbUNe4c3gMFjKx/NCqcXwbhbkeF3vIUeSXGYgduMewD
 08qGHoMuORLzRsclJeTnM6JdRrYWO6OD2rYHMKRzzvr5UClBPhPbO8wxNOWw4hGj4Ff2
 HLHCDEm9Y2n2Q+Ub46DLM7Nfd5KBnXkKvCsswoxJ/CocVV4k5LYN0k2cbjKSeUDh5FY4
 pTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966189; x=1709570989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9EOnAK3G1S7aJVMzq+KHRG4+8D5fltRUtqq+3DIXP0=;
 b=LJc/yZzYK2K+Mn1LErnVNjEwi0iy1mba9PQhJzkFC6pRv0y4J1c3Tevnm70cqAy/g8
 hCnByI1HndDSbYLOe/I1AiUGFY0uUxW8249bK4dBSwFHpNWDr8qSPsOJue9u0Rkp5Auc
 MpKEISem5zXgOfpXhkeW6cliY1cmtKKAHbV9koW0MiFvcFTUDtduRo5tSCMkTXivqcz5
 cIPdJfL8VRjH54q2c3ZQA/sNSONPcapYwCJ8jqATECGd7t1lAe1XCKkIouCozwip6l1G
 49aA8RQtAPNZpgmcJvb1tuNwxqj4wX/SNCk/UqKZYS+hlM3aAk0ws/1nAnat95T1reOq
 P8MA==
X-Gm-Message-State: AOJu0Yw/OWjSy7ni/TDSi/P2B0g2FHIyoADm/QzVxbymLh1aI4lBBGun
 fEit1EVd26J2gAeAVkVKs4DX53kgOhOSYwUrVD0uj2BqyycUoMk+OPvfj/oIBt/o3fiRJ6mEf8E
 8
X-Google-Smtp-Source: AGHT+IGpAM7epHO4BimF93PaPzI/MDmq595S6HSutG3SNMb83SnwZfECtVpH7gzX4CyXYEPObHPnmA==
X-Received: by 2002:a5d:6649:0:b0:33d:aa78:ed82 with SMTP id
 f9-20020a5d6649000000b0033daa78ed82mr5311945wrw.34.1708966188918; 
 Mon, 26 Feb 2024 08:49:48 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 bv20-20020a0560001f1400b0033d73e1505bsm8884920wrb.18.2024.02.26.08.49.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 5/5] hw/isa: Build ich9_lpc.c once
Date: Mon, 26 Feb 2024 17:49:12 +0100
Message-ID: <20240226164913.94077-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
References: <20240226164913.94077-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

ich9_lpc.c doesn't contain any target-specific calls,
lets build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 3b5504f78d..df58287d62 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -3,9 +3,8 @@ system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
 system_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
+system_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('ich9_lpc.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
 system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
-
-specific_ss.add(when: 'CONFIG_LPC_ICH9', if_true: files('ich9_lpc.c'))
-- 
2.41.0


