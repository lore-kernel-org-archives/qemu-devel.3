Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC313CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5Mg-0006zN-Hv; Thu, 04 Jun 2026 06:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Mc-0006sb-ON
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Mb-0001kg-49
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so2894305e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1780569107; x=1781173907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rq7DGzm6/xhCxRmyryBKQqjtaie2aYAZM5R+lha2Zqs=;
 b=BkvyM3WXEfVlv2dKX4MuKv9LsC0USjhFVzrb8aZ7MaLDzyCH5SzSoxHzWVb8qeIxVZ
 WKOOe91b5jxAEN4dL5nAW5NwAR89+4IrI+wXMJlag1vuIOicbbmlYJb4gZQ4KMwGI0O7
 DxG6Mk7tguy8udiPR9EzuBZCwsviXp4B1J5Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569107; x=1781173907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rq7DGzm6/xhCxRmyryBKQqjtaie2aYAZM5R+lha2Zqs=;
 b=QATu00LWlk1usMoceCgfBzuacgZL1UAqcl7cy9DcofOYbx/n+JnTIS4jmpORVeCZ6Z
 qkOnS3DwKknngCdhz/Cn/JqN3hBAY+pFoEt1w2lOBH8sWfohByHuPiKXE12LSH1locho
 40OUMtQaC/6LPDg0KWhThjFWn8IHrVs08vZD6e56D+k6uCNcOS7n0ZhyuUDR5NGGVpzF
 VZ8DlPJUmwVF21qHacQhlbxqnfp45ZSFSsh2N33ryOWyVgx+zfi6Q1b0EBEUVJdTVeGd
 cGbyLgZhLwEn4QlNa9R78dfEW26FqEWk1UYbhv3cRdiKKqYAi6NEUiOGgfEfG0Wn4+Ym
 dkgg==
X-Gm-Message-State: AOJu0YxRAkNkmpNa+grgrfYZ1AWgpWZ3GJPJ55RqTUcSmFZiInDLV3AR
 QcXjuZo21QDp0+JZe/YGdxkeM1eobx/G4IOAgpxIIpyoOLC8G54EtaPfWNIogYwrDi4+9bp+j5y
 jLI1E
X-Gm-Gg: Acq92OFcKSyNT7o3bDeJ21dMsQj4v/rjji3DJsy+ipEiyi546cz/VPhHtrhLOw7CRhC
 BCKZjVl1oyiIkcxsyiPKe7rM0nQU0XBc5kxfwaTVLCrg6Q9t1EDhqJu40yiGNKm1XrbjF4I/CCy
 qV+HKzhIEEcsTUrnWtmP95IEkSJ2394NTCvMZzmCJxedhyEmog+Kl1cZ2FNp8AbQRFPjoSWFnSF
 ZwN6pUNUJy+43r3Idru3XpjiN3pKywcJkXeISPt+zMSuNFFwak+veiqerMZAj70vs5/dzO7dA/+
 UojihbK9UNBXalXEhorjnJiTfPhVL8PUhGWkzYl1vzUZ5YY22CccBpY7AGPhuVvlbEBprnBjX/f
 GCAO1fAv9/6sIXCVzUEmTOeFzygwaj7CglzNNmUyHLiqJNaiXTLSWpF9GUHm5orsHWaJNfp1wDw
 dWUGGt5DnL4LblEh+hUUYTLcNwWItiWmgYY7s9AUEbijV65NluelSwJ6cDiE4+lPQ8mwL3ZyE3v
 j+amFfRy8Z/XrUocRTQiX5F
X-Received: by 2002:a05:600c:8b01:b0:490:6237:5200 with SMTP id
 5b1f17b1804b1-490b5d36863mr119634005e9.10.1780569106637; 
 Thu, 04 Jun 2026 03:31:46 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00::9a8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm15928661f8f.6.2026.06.04.03.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:31:45 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 0/2] hw/nvme: support online resize
Date: Thu,  4 Jun 2026 12:31:41 +0200
Message-ID: <20260604103143.462071-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset is aimed to support online resize for NVMe emulated
device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
callback and ensure that AER notification is fired to all controllers using
a namespace that is being resized.

Testing.

I manually validated this with Debian 13 VM and Windows Server 2022 (resized
disk was a secondary one in both cases).

Git tree:
https://github.com/mihalicyn/qemu/commits/nvme-resize

Kind regards,
Alex

Alexander Mikhalitsyn (2):
  hw/nvme: initialize ns->subsys for n->namespace
  hw/nvme: support online resize

 hw/nvme/ctrl.c | 10 ++++++++
 hw/nvme/ns.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.47.3


