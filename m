Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E0FC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1silnJ-0003kf-Cd; Mon, 26 Aug 2024 22:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1silnH-0003k4-FS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:18:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1silnG-00040z-3O
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:18:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2020ac89cabso44067505ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 19:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724725128; x=1725329928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G69uxsUxTNKt3B8O4R1AJk3VxchZ1vW3Jd8TjLqokew=;
 b=j2QRQkl06NPo/5jLRBGnvA6PIBgPMvWltukgGUd20JuUEXFb1RevnPGJMPH5TCRdAD
 m5qL++Rq3rzO93aO2QLPdc/fXwTHurZ72fsC4C3LSf8FcGcoMghBxfN+aSvX5yFkL1Ao
 NNcsghFOw04D3yW235YfNJwztp9w/4oh4eVkKW0svgt8W8WhBWtQr/SMnoVV6fZ0Rw27
 94e9j4G4MnJlEh1U5wkZXcU0b3qgYG8Ntd3dMyRTCpBCVInp+kcXqJrDGT5j3FXezRlM
 l7AHcS/LUZVG0DeuM0vCMi6bmnl3zGRzC40rO/3Qpnxx30QYX1s6fUUrpwgaJ/875fsT
 ASfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724725128; x=1725329928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G69uxsUxTNKt3B8O4R1AJk3VxchZ1vW3Jd8TjLqokew=;
 b=LVFnOLP6yzmQ8xYhtdY+DJ3U/KOGrTHV160DF8vm7uz4BnN99beFEYiJjr+9ybV3DH
 V1b06+x1/+IrynzB+18IXkmSkZIaJOsTaXkbr1FoKLzd85rO1zB5wvsMHovfCTXrqclM
 k0394xECvGaba6vljuBMlixmwMt41EOouv8i73ri0fFQcumCJZPUhfUhyaefIYs5sPs3
 qKMHbKUh4aiyGeFSG6KXaSw4IQDoVCT3kt149Z2CW/5x3+02malEjFxuZnHosyBz89Pi
 068EbJTYzzT+38fgTqk5kk4SiSauzBnm7SWOkqn+zE7DEKCcgkj6StrhlxIZGEAGOMlc
 dKJA==
X-Gm-Message-State: AOJu0YyLL2lwvbK0ym2xnRGMZShr+Ra+bSLbgNnRfqHLtQbLw/IkEv+G
 L8sVxAXai8538OeIChn/VS8cLYAssB6BLszAjLvIVFNF/Egm6Jr9oW20fUYy8ulZdA==
X-Google-Smtp-Source: AGHT+IHxIDLrh6555Lkqbs2oxU8wcs+g2p6DCkFMdiOSFXBUTD5Dkl+5nR8+yy5hwenFC1Mtr4W0lg==
X-Received: by 2002:a17:903:2305:b0:1fb:3e8c:95a6 with SMTP id
 d9443c01a7336-2039e4e855amr158168695ad.40.1724725128283; 
 Mon, 26 Aug 2024 19:18:48 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557e759sm73241305ad.67.2024.08.26.19.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 19:18:47 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 0/2] plugins: add plugin API to read guest memory
Date: Mon, 26 Aug 2024 19:18:44 -0700
Message-ID: <20240827021847.218390-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62f.google.com
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

This patch adds one API function to the QEMU plugin API

bool qemu_plugin_read_memory_vaddr(vaddr, GByteArray *, size_t);

The API allows reading memory from an arbitrary guest virtual
address, which is useful for many things but the motivating examples
are:

* Virtual Machine Introspection (VMI)
* Accurate and easier execution trace extraction
* Debugging and logging tools

An example of its use is added to the existing syscalls plugin,
which now has an option to hexdump the buf argument to any write(2)
syscalls which occur.

Rowan Hart (2):
  plugins: add plugin API to read guest memory
  plugins: add option to dump write argument to syscall plugin

 docs/about/emulation.rst     |  14 ++++-
 include/qemu/qemu-plugin.h   |  32 +++++++++-
 plugins/api.c                |  20 ++++++
 plugins/qemu-plugins.symbols |   1 +
 tests/tcg/plugins/syscall.c  | 117 +++++++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+), 2 deletions(-)

-- 
2.46.0


