Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA349C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwM2-0005au-D6; Mon, 17 Feb 2025 03:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwLu-0005MU-2h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tjwLs-000172-2U
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:41 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220ca204d04so53324435ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739780378; x=1740385178; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDAvIEmpWpFT/aa/l7nf99wPxKKGcDh5A57FUObLhds=;
 b=KoM7RZqNHShrN3jS+aIKXF1/YSryOE6kWlNvcCP8DpFQjpt6JmbH1/++eulYj7gxsI
 zNb6rRK+SG380ikdjfpZjYSunwftz0DbO6H48qfuL+8JiIb3NkwQe53/oAureB+59Y1S
 5xDL4KPX+87Zc4JjVrlQIfogf6+6aQ+TpL33nPLP6ON6a3/UwEjzKa/rKNCtMgcCc8XM
 w1Q/K7xTjdfStRrnt343Y0bqDm2cVjthO+2mMfDO8vnu97jOuHkS9MVDFKOcAp3gImN0
 iHHubp4Ro6KImAgV/drhwd2mlGgbspp6Dnxj8nWOM0GurHGkgBpLN2Jjycdo3JKurvwq
 kinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780378; x=1740385178;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDAvIEmpWpFT/aa/l7nf99wPxKKGcDh5A57FUObLhds=;
 b=B8ePtNFUiM+sDTg+lkgrwU6+lnq+7MNFmk9/xFofAka1KN6IwJN/sRncATSOi4OZmX
 id4u2nvc6+7XUoWuNofIivI9HIzX3SrErhSwBXhcSGrK0cQjzbiR/SDX8M3r2Gq6Y/Yt
 deDRy81+U2mTY0L5KPrpiqdKLIhgAAYKdsnTZATRTo+GFwDIDyyEksSHxHjDK/x+CE6J
 v+hw0Y8rHomhZmRZ+f9xqBBae89ZnNZDVcmkNeD23V4p2z0yZRFO7s8jSn6uvu22u4mM
 PivXDkyYq6+ldZQReNfPXmjwFodJx9KMgf4dV/FnoOIj0b89BhYE6MLj1idl8/RBw5zp
 7TMw==
X-Gm-Message-State: AOJu0YyTCGqTm6KocM1yQ9bqu77ucycZrPt7S/WbAVvXtCu1e5x7nwWD
 4imS0orN0bcub8KvVI8FVqJlXUz7G/5qG7FcTON7DQ7CLERmGs6yLmYj6L/KRXLR1SQ9BKLwe+V
 z/3WfLHqCOWkK12ZONhFgYOV3083flaXDmVkUJvASgTZxoG/+Xuo5+8NCepBc6TSZc/q8KxvftC
 /brR2IyvwmT6Eee/jb8tDYpmZxcFxVPYVsgHcg6SRTnA==
X-Gm-Gg: ASbGnctk5zuuhU5W5hD+ELtlib0kQmMf/+8Zt/UKn5b0uinbZ899dC2q/cA1wpT62BF
 DLY6zLa6olCg85tK8OMo9VB80JRf3mUDblvIC6mAqcbJWDDwzwW/ptguhIHjvX2CHiZSpb0TIbM
 HzfspMRIgkJnskervKDK/G7mCo8+qlnjKlA9ZoryKXwYgXqDFsIzOCby+yDlbjCasWAifFceTc+
 3KVWTZXk6Nar2NjAUTDRnxiiSG+Gr/AmI/ZC09CXliUbzSu8cNIqdFMP9EhALF65Rh4mBNl3WaH
 rOWVsoU/+xYkT/40uzKXH096bHhQkbCiPwS8D0KNlfkZMA==
X-Google-Smtp-Source: AGHT+IGVSAgiuDdPJw7fIZgiH+FLHuDrK75AnVxFL2DNppjkS8MubIX1kmvusJ8RTG+hRgPXGNC8nw==
X-Received: by 2002:a17:902:e88d:b0:220:cab1:810e with SMTP id
 d9443c01a7336-22103ef206cmr134473255ad.6.1739780376631; 
 Mon, 17 Feb 2025 00:19:36 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d5e6sm66023445ad.173.2025.02.17.00.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 00:19:36 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH 0/4] riscv: AIA: refinement for KVM acceleration
Date: Mon, 17 Feb 2025 16:19:22 +0800
Message-Id: <20250217081927.10613-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x630.google.com
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

Reorder the code to reduce the conditional checking and remove
unnecessary resource setting when using in-kernl AIA irqchip.

Yong-Xuan Wang (4):
  hw/riscv/virt: KVM AIA refinement
  hw/intc/imsic: refine the IMSIC realize
  hw/intc/aplic: refine the APLIC realize
  hw/intc/aplic: refine kvm_msicfgaddr

 hw/intc/riscv_aplic.c | 73 ++++++++++++++++++++-------------------
 hw/intc/riscv_imsic.c | 47 +++++++++++++------------
 hw/riscv/virt.c       | 79 ++++++++++++++++++++-----------------------
 3 files changed, 102 insertions(+), 97 deletions(-)

-- 
2.17.1


