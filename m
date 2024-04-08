Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857D4CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 12:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtnpY-00064t-BE; Mon, 08 Apr 2024 08:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpW-00064Y-15
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpT-0004o9-Cz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so4006508b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712578104; x=1713182904;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VV9gBz7csStPxVydv90uxwG7/JIMdzeCVlYS5yEGSYc=;
 b=bQiyijC1xgIi9+46XkdjhSk1XURCVeyzk/dEChipRqtRNF1WjFrZuxcLWLEdsa1wc8
 LAH/i3iN7h0wnYgDLBdnNQCc3qj4NRwmbIR0faRqzlGi0ahlCGZ4bpE4kJgDqH006KF/
 Q4kpSnzrX36MHDBZzoBlx6xPUbwOe39jqtad9aund3mkSubRxhbz9n3vM7TmEmKaadS9
 AKMQm3Toce6ueBoxBUyWmcjl2cjm6tdoi0D/PT3BAcFwDLJbMFH9eT6yj+mov2/YjQYX
 4+94p6/MedZ4OvbTrIeH4C3BAVbTdKbrbZhCrEP9leIPp/EtTrqMhB/K4ImLB9jdrRmt
 8U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712578104; x=1713182904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VV9gBz7csStPxVydv90uxwG7/JIMdzeCVlYS5yEGSYc=;
 b=eVjhB6ZPxjyk7Ez+12gZQiggaIw0q7FTv7yQ23ABfiEvTxp+LurUT3YLYeBFY9osO2
 FWHwxIeiv7pqa/5VwxjkX4I72O8JxKRtPQWvHYRZtat6tFTahnjhZm0WK/mOPlZVgKUc
 Ed/iLa5HHwuwVXK1das9bQEJL/nL11ataF9CynP4S5KNooDD4+Sd2a7HpRhx4TPml3Z7
 Bd2k14Gz9B1poeZS9XZ7L7WWqRE2KV1n93c11XmcYdbAako9VApP+aqrVsyOdnrKlO2V
 nK6lzxerzCBFtenb/H/yliRnIHiX+J3nsV8GzgH7nZW4kGjzdWJaYLgGGGc+fFoRyxRq
 2mOg==
X-Gm-Message-State: AOJu0YzJXg7pl1Fe1YCoJ/KPMXgsCCLc1OpCIJoI6uuUsSN+4vV/zlkR
 zTzhyhdzP4mI/TCYw9bMDjb2tQ7BqUR0FW379l2kFgx2AmDHK7pEkAOqxNAkSNAaIwm8jxBFCEM
 sJKcXDA==
X-Google-Smtp-Source: AGHT+IG9Tqcp288M2EfLD6ceWW77lvERgp5USVcGG6gOVal6vLHw0oxCPDadL6K3vJonRIB/Tq2ITw==
X-Received: by 2002:a05:6a00:9392:b0:6ea:c9c3:94a5 with SMTP id
 ka18-20020a056a00939200b006eac9c394a5mr12417397pfb.0.1712578103676; 
 Mon, 08 Apr 2024 05:08:23 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 x42-20020a056a000bea00b006e6b180d87asm6410478pfu.35.2024.04.08.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 05:08:23 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH RESEND 0/2] Fix crash of VMs configured with the CDROM device
Date: Mon,  8 Apr 2024 20:08:16 +0800
Message-Id: <cover.1712577715.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This patchset fixes the crash of VMs configured with the CDROM device
on the destination during live migration. See the commit message for
details.

The previous patchset does not show up at https://patchew.org/QEMU.
Just resend it to ensure the email gets to the inbox.

Please review.

Yong

Hyman Huang (2):
  scsi-disk: Introduce the migrate_emulate_scsi_request field
  scsi-disk: Fix crash of VMs configured with the CDROM device

 hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

-- 
2.39.3


