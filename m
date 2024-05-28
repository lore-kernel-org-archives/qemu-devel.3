Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8643C27C43
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqCy-00083B-3D; Tue, 28 May 2024 02:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCi-0007xi-5D; Tue, 28 May 2024 02:21:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBqCe-0005Ch-I3; Tue, 28 May 2024 02:20:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8ea5e3812so311130b3a.2; 
 Mon, 27 May 2024 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716877254; x=1717482054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l+AXSvJHoTvV3+UfIjLIRn/ldpLxhKETxJrMpzKYXQo=;
 b=YOhcAH2aDXg5WfCpRTR9QnjkKiiFNOG6XJuZhDQNdATG5X9Ym3u2DUxf2S2UpBbqFp
 9Rgc4IrRARy4zZsLal/WxmuLc2qCCxn+9XK/+gbOh1WapwpB5rUZzIyKhcvq3+8YbI18
 wj0IO9eHJPHW+bV7TJo3LZsF9XukS/MFFdzriGSdC5ghsjNM3C/YQq2o5vsl0v1XhQdy
 1v8CA2lbgMOQNEsvWC3SeDqotIrcmkMnRu97AuWim8zo5tiWbX0yrw2Rw53ARrpH0NMp
 A5IremEZY4jY+rgTGR1abph/HutthWIdP8n84ue1ht0lqnUoGt+38Gu0T3n/wx9oyNme
 RVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716877254; x=1717482054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+AXSvJHoTvV3+UfIjLIRn/ldpLxhKETxJrMpzKYXQo=;
 b=oYPQWuUmHsl5o7eQ4YbXqBd5MXdLWDNV+BFd6/U45On4k+0lXrLeGg8Sx/5+O0qVaL
 Piyy2UkI1h8WXcXHcT4fGD2+Mp6Dhf/XQEPgNsOSVu3Owblir/89ZfNriSEu9arMlLAU
 Gr18CrhesolrvIuR/ukpBj4MNI8nqq7754xuCvGnpJ2sPidgBKmNZBCzcoR7aVCPjq+Z
 HGoGltvlGtE++Nt9wGROOrX/NvIvlOFENE5pyYAz1aU+CFTe61JDw4rYdpcbECZKD/OP
 64LHC3Ft6RurXwSAc0oZynLlNfP+zoWco+WiBK/fjs5Jm0GZmP4Eod2hfRPsMaPrhgqx
 Uv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTJh8McJkd+jj9BKP3/mdjlodg8I/tMIlfbQtq94fQxCsEVpvCrTmIgvyMCHkznc4Z6TyAvasqFoQmi//yh/Pf+V0gURw=
X-Gm-Message-State: AOJu0YyA16HdDKd6BUBiNZpBDryx3s0Wf6vsIFAJ4aN7fGdnLCxwaEzt
 fze6HaWgD+wZEOlegcbUkUidKWoi7iCaHErvlCzBmskDsz+dbJCk2bV6Qg==
X-Google-Smtp-Source: AGHT+IFvsjBNtoBBzQepcw4HxUXOB7D5o2im7JG+9nB7NdAepnvhGmRz6PkNgWabqWsaOxgiaFOhCQ==
X-Received: by 2002:a05:6a00:908a:b0:6ec:d76b:6fac with SMTP id
 d2e1a72fcca58-6f8f34ae8demr13734974b3a.12.1716877253594; 
 Mon, 27 May 2024 23:20:53 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbdesm5969779b3a.18.2024.05.27.23.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:20:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] ppc/pnv: LPC interrupt fixes
Date: Tue, 28 May 2024 16:20:43 +1000
Message-ID: <20240528062045.624906-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Here is v2 of the POWER9 PSI serirq patch with changes suggested by
Cedric and some other things. But also in front of that we have a fix
from Glenn for a lost interrupt problem.

I rebased Glenn's patch and also changed some comments and changelog
a bit so any bugs or silly comments are probably my fault, but debug
and fix is credit to him.

Thanks,
Nick

Glenn Miles (1):
  ppc/pnv: Fix loss of LPC SERIRQ interrupts

Nicholas Piggin (1):
  ppc/pnv: Implement POWER9 LPC PSI serirq outputs and auto-clear
    function

 include/hw/ppc/pnv_lpc.h |  17 ++++-
 hw/ppc/pnv.c             |  36 ++++++++--
 hw/ppc/pnv_lpc.c         | 150 ++++++++++++++++++++++++++++++++-------
 3 files changed, 170 insertions(+), 33 deletions(-)

-- 
2.43.0


