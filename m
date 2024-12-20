Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA7E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFD-0006p0-Fp; Thu, 19 Dec 2024 20:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF9-0006ep-St
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:56 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSF8-0004WP-FC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:55 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so1100820b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659753; x=1735264553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTdaw05ysd6G+Wo/MGIHYx5h64ipYyB+ZBS1Cs3n/8g=;
 b=AJGR2xkf9y68honrprqGLw39k5ahj9q4/qUS6qWRsj52RhI3XY3yq/f/Pie1/LcZz2
 K+2WKRDAPz9C0MBd50qLDMUWpjNx4hb8q7HjK9UIqtbkbPHUZ217T6d7tVgUZwCkTpR5
 DGyMC8acRQg8C2nu5f83vfyJuOuWgl1tOPYF+0+jff8VRu0GYH7poTZX9ihQ9iwQmgvv
 LWOhl+V9afFNCnyapuDIWW2GAfNd4Hbcw/a/laW0wLcr9+FAjr/SxvT2pt6z9ZQo5/qG
 2YCzLcXJrKmtVRQMYduPfONQiXZnUDVjS3aA7EVJGUA9w3hDWvni7R3mY60rEuk55yQT
 XBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659753; x=1735264553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTdaw05ysd6G+Wo/MGIHYx5h64ipYyB+ZBS1Cs3n/8g=;
 b=mebVNfmGS4zmFVKUv381xcYDbBqEjtPsY9IRHpzZEJnoH6bLtozHsIMJUz8G0Xa4VR
 W1fCWPzkPHJM1Q+Dbm6Qqh1VY+nbFKKCFjoiBZrUIHFRYWNlkFoi1TFAOf5mHnKQB6Z6
 fcoEFXfWpeRc4+Ai73PpgrpTvlMVcepZSre5evxRf05beAvmBI4rplz5QCwchFvS7Uwl
 SCMCIMLheiV8xN/sBtSZcbi8Rp2hgLad66zBB0kNVWhl0oW0KF8N5z43dwOrtbjZMWTe
 oSSuWafO7dDy6J/YV6mO9GRgjnq9m37FaPvsIi/j4Wpprm7AWZtpVCGf0Y08NNfMocGx
 6EJw==
X-Gm-Message-State: AOJu0YzV6Axlrit3buR/2xhxHB/QvCojJmWLEup+zl5as9eBzzjNAG3l
 E0eof4hxP3XRCLUlo6I2U24grsTmGqUiI63iiaKuU3TJPuT0vvvdmIQMrg4D
X-Gm-Gg: ASbGncuQRSibpd/LqSNJUZwFhiMHQmQW+88laOSwNga5EOqLijqVXWFsSusRTslCSyx
 i/AA1AbVHsKaAWMJcNSnIeN44hjTQj3oybPqpoHsMiGXU+OkU+5iFB0LqJWJAPvvbcXD4a7RMXW
 Z+A6Em7PhBZSjKMBrIBh9FizQ2OxUC9jhHqN+Wx5RUmdBzriXrnILPu7eeggSqu0RrasdBrOQyj
 Mu1cVsDJd5gz6k+vIN+Q/KybeQC8cCjNuE5zZL+C45M6iaH7KgitlF3bacjCt5PIfSU1/xsRM1c
 uaf3WY0ARNgUo2SYp+AAWCdnzvr05vhCPbZzRu5uxHh5+lJX0m+69Yo04PMmzFA=
X-Google-Smtp-Source: AGHT+IFou76Nd/x8eLscrITUkrS8ONLRa8b1YPCz1IpfbMvgRvt8OQbS+Dmu+K9uQWiue2GOmBTeqQ==
X-Received: by 2002:a05:6a00:1909:b0:728:eb62:a132 with SMTP id
 d2e1a72fcca58-72abde0f2b0mr1175782b3a.15.1734659752967; 
 Thu, 19 Dec 2024 17:55:52 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/39] qtest: allow SPCR acpi table changes
Date: Fri, 20 Dec 2024 11:54:20 +1000
Message-ID: <20241220015441.317236-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241028015744.624943-2-jeeheng.sia@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..aae973048a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.47.1


