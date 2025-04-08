Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4DFC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E78-0004Yp-6L; Tue, 08 Apr 2025 14:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E71-0004Xx-V8
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E6x-0004Cx-Od
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso40398255e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138549; x=1744743349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHTmarhdzx/+kGuibyF5scVpYUQxoz4xhKrDhSMfcxQ=;
 b=tdE9NBVU7MaQwfuVml2H3+LQ9l/leoMiTqL7eegQLjFKHVwHlha5f0qesDdJ6/fJxn
 FtqqKNFpphYJILbX5YhMIVDTI+n37rqmZBmz/yxU+xmlFjBkylDMJNYv3fcTKk+HQfAg
 btKHgeQPhIb/g/f8lmMGvUiYkjZ/CfmbsP10Xee/U3ZRKqghspAvnMTHqeL2vsJR1qHk
 4AG0J/5u8yyeCpy2EOIDVhbheU0himqsagt2F0CUN0UTjduJqafDqiM4c4nlRVdMJnG4
 Bl7qxRwdcZxVBpxUZ4pdYpFztCdeNoWg82/5cW5+SSKNVsw3P2DnN0s0fHJOQh0jt7cK
 FETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138549; x=1744743349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHTmarhdzx/+kGuibyF5scVpYUQxoz4xhKrDhSMfcxQ=;
 b=SVWmGGlPV/efxXpR2uOe6+vpE/LtCpETYhemyc3dj8O4LXRJZZRwSuTxt5Qc5g/SYb
 3UNpOs9k/vu1FidV6nLnxhoLQwxgTEsF9ZQqTAH8Tj6iadGBnOalh9w4hLEVuuQ8b5Js
 MesKIp1CiR+XOuH/OSny0hR41Zzj/22o+tKzSJBXg5OkUJB6GV9uIPMPgIWPENDbnpzP
 lKqfaIZDBw0yzeTmu+Xfbdh8WTB1ct5XHtsOQJlyfkRncLGGxGSzjG/2HIHDOrbIZ4Uo
 QRS5ytA4fmqv5PbiC6Ujd1MF3GpNxRJdSGRUO+BPbcK8Ew/cuAVlgRu/m8SgXRTT6opV
 VbHA==
X-Gm-Message-State: AOJu0YzTCv3ejxHzUi7iD2pEllV+jfC1oeCytalU4kZCFjlp/yWw7QJs
 7xOVw4jVYP5aGHc2JyjfIVH2ftc5C+z5+xAqkSicU4ar9PaQxLLaOl0i98gcAJw4J3Q34Vdp/28
 0vno=
X-Gm-Gg: ASbGnctVw58Hr3WrXneHtcSWdv6rPertrVQXSX08Ok7cmbvaNWT2Z5C5vEGlMxfhlQM
 iaDMxR1DNE/jGsfAwJp28J+Dxzy9E+0QFoWYlDCsI4yW+QNPRgHmraavJ6kLp1TDcElPhCvyLyu
 2AslDKSL10WkW4L+1UU2vUJdSHbOVH2IzHo/LyfHEz09JoTcE1mZXPRy0imBiAxyC37+ZUfDi1I
 SPVSlg0jUhNkwOWA/lXp3SONIgTN7ahkD29BRUOjExyV+sEea3y572lcXS1ZwbkaUebHTsjS6YN
 pUySlAM4chN0ESre1YYhVNww56ci+0By03QvUGIzo/ZVS2E+iuYSQ0xfnqIU/1f3wu5uHWCRfad
 dUaZrTW7+sR7Vivma3i4=
X-Google-Smtp-Source: AGHT+IFJOlxXwa9Kgu8VV1WYuWMSK2ul7z5prsya6O9gF+MlGeTbBPb7m0TCnG+TMaCEiIqTVPiASA==
X-Received: by 2002:a05:600c:1c02:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-43f1ec7cd2dmr2584905e9.3.1744138549410; 
 Tue, 08 Apr 2025 11:55:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663046sm175470495e9.13.2025.04.08.11.55.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:55:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/8] hw/core/machine: Fix -machine dumpdtb=file.dtb
Date: Tue,  8 Apr 2025 20:55:32 +0200
Message-ID: <20250408185538.85538-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Joel Stanley <joel@jms.id.au>

In commit 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb
option") the call to dump was moved with respect to the init of the
machine.  This resulted in the device tree missing parts of the machine
description, depending on how they construct their device tree.

The arm virt machine is missing some PSCI nodes, while the riscv one
is missing most of its content.

Move the dump to after the notifiers have been run, allowing
virt_machine_done to be called and the device tree to be fully
populated.

Fixes: 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb option")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250401041509.719153-1-joel@jms.id.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b..63c6ef93d29 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1731,12 +1731,6 @@ void qdev_machine_creation_done(void)
     phase_advance(PHASE_MACHINE_READY);
     qdev_assert_realized_properly();
 
-    /*
-     * If the user used -machine dumpdtb=file.dtb to request that we
-     * dump the DTB to a file,  do it now, and exit.
-     */
-    handle_machine_dumpdtb(current_machine);
-
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     /*
@@ -1750,6 +1744,12 @@ void qdev_machine_creation_done(void)
 
     notifier_list_notify(&machine_init_done_notifiers, NULL);
 
+    /*
+     * If the user used -machine dumpdtb=file.dtb to request that we
+     * dump the DTB to a file, do it now, and exit.
+     */
+    handle_machine_dumpdtb(current_machine);
+
     if (rom_check_and_register_reset() != 0) {
         exit(1);
     }
-- 
2.47.1


