Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09369C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb8p-0005gx-P1; Thu, 01 May 2025 17:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7S-0002vY-Iz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:59 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7Q-0006m0-O4
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:58 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8616987c261so47491639f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133615; x=1746738415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZHrZc/SqHQCuHNUknWmlRcBkOUid9mb6wG/E9aJXzY=;
 b=JB1ZcBEhox8DyxEtyex6GQ9rcteS6g+DR4lZ5Eo28liSC7CvVI9myw9qIcTxqQzs3C
 2Sc6cslZ91ZWqg7wa/lR9GJheZ2si9HlZi34ewVALsq0H9Uok1LmZybooqIH3G1roc0O
 8+DMU8BBuGiaGSIuni3P2m8CMVkRJOvrtp2EhFRwxsfSnTIqOSc2YhPb7NoPz0rvSlGI
 ehEOSQUcXFOzlnISfzYYIqt2dOwZfs+UPqqJvDM9O5GgTtzOn/9kmDQILbhHRYnyTaLB
 Es/DzVJshcKWuOdxEOq+gL80kVyOmqaB+T3TmDdQjFIoi2r2B351/7nfTsciGqkfze2/
 lOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133615; x=1746738415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZHrZc/SqHQCuHNUknWmlRcBkOUid9mb6wG/E9aJXzY=;
 b=VCK6SFhWU+oJzYCVR3j8rOkr0LvD0A+fBQ4LdTrPEw1kC74/ZqnkeEMVGFy6o1cvp6
 jf8ilRIKsIOUZMNsqn2YN68/nCF87XPc9RPHOcG38WKIGv9SJMJ5eqZGcT2vN/7eHkET
 5+JR75gaYZIvUEi0gyUEKJ/urcwXFp5U30stirnFCpb8Juyn2aZw2bWhJlHqxdoxaI77
 43Wc2OgDAV26ZPQ4P08/RBrpaKidZ7VA7aW9ZaBgEJIRiBx0V2xWv9itPaV/Njl4PnWd
 VfajLXVh4Ge5rfevMHWNT0Dcmc9GED7gzP8Syvew7MnX7auWDPJgYX9fXq1Qwkh+d9wq
 CwGQ==
X-Gm-Message-State: AOJu0Yz2/XdeWEb0h5v5gezgmGHn74B6CFh9AcsNh9ejfiEYj6ElEmGs
 +DUThUA2BlOCcWj5hPgRPyNqqaSkrFhUqAFjuEssGoSUBr36SB5qisG7aZk9SBVnU/2Oo7OE3EL
 Y
X-Gm-Gg: ASbGncuRhKHGe6HEgblNCdw20PwqUYr3xilbM/4T7xvHFGWrJBhhfy09KDmxOBiYa9Z
 /c0Ceu8vu+QOKiMOvRsafOHQ00GJurs+5IjzVMLd4lPHR3ALc5/0ON7MgbL7MeREtAl+OuOi510
 +UHfoOLCc1Btg9qokqxRyBG59755ydO0+37hjV0WSYBcHXv7YsCFfNQOQCc4lhJDPWCpgv56uOU
 NIr4MIoVdx6x5qSM+KgQcC66h4TkOh7Y4q2yhVSz7ooNJYpcUPOIDXCmicdQn2ZTVjYQEfjvztU
 dW59RiqkEOvpwflEr6fa54N5MGMtnKEsHobQ0ZbUiV3aZQNQY1xN67UaWGdat+YSrKPdXDlgkN3
 EkzXweRpXxJ5G5fY=
X-Google-Smtp-Source: AGHT+IEFqPkhVc8RoBBRp3hJ+ER5sKSr0LXlPBt3TWkNE/vEJoqOW7hEWn7+OQbK/8C0ef4Wtyr8DQ==
X-Received: by 2002:a05:6602:3a15:b0:85b:577b:37c9 with SMTP id
 ca18e2360f4ac-866b4298812mr90498639f.12.1746133614798; 
 Thu, 01 May 2025 14:06:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa443886sm24652739f.36.2025.05.01.14.06.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 13/18] hw/i386/pc: Remove deprecated pc-q35-2.9 and
 pc-i440fx-2.9 machines
Date: Thu,  1 May 2025 23:04:51 +0200
Message-ID: <20250501210456.89071-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/i386/pc_piix.c | 9 ---------
 hw/i386/pc_q35.c  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0d6ad9db627..5c7d0c50f8e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -737,15 +737,6 @@ static void pc_i440fx_machine_2_10_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 10);
 
-static void pc_i440fx_machine_2_9_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_10_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 9);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 54c18100122..d66d64b3b62 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -630,12 +630,3 @@ static void pc_q35_machine_2_10_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 10);
-
-static void pc_q35_machine_2_9_options(MachineClass *m)
-{
-    pc_q35_machine_2_10_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-}
-
-DEFINE_Q35_MACHINE(2, 9);
-- 
2.47.1


