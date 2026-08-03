Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26669C55175
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqo4V-0007xQ-Nb; Mon, 03 Aug 2026 04:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4T-0007w9-At
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4R-0005sH-O4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so18698905e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785745850; x=1786350650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L5Jr/hIRWPgDaNd50pToA0whxhUrAjNm+RZd5ccvBpY=;
 b=NO0P6eNoEATSB4tX0drgdys4p4t15XWAadA8tomOnG1rejmKMu82zjCbi8A5PZcCIN
 eNAcp/97pnD3CSHd5y4DsSikEfLeepa9MzsHXL+IB9my5UtN5QLjWcDZ8c7ilf+KsffJ
 KSMk8ZTrXU/8n1e61L7E0tsJ8TtCwKhWDbh/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785745850; x=1786350650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L5Jr/hIRWPgDaNd50pToA0whxhUrAjNm+RZd5ccvBpY=;
 b=LAEWsuOHgLfK7911NVnX6N7vwUEd+CaukR4L3fOzPqRvNx68oF6JGDNVWoR7RenW1q
 ebVshxiNADtyS3MNxjyfMUu2Zn3rghqKu4tNBeUyRIZawpzE9oYf3ZwidI/YVUpgDuUS
 TS5TTaX0TlZ6INOef/zxy2A+CA7CPvEXTUgw9PYIlBf3Y7h4JsMYLprSIpyiGNObNV2w
 BtN/Ufx6x6WGT5llWEIlL5dW5Pl75er2PUvnNAnGDcoerK+Ak8S+pY22zynpAueC1qGZ
 T1NlNepSdZfxO4I7icGpQgJncc21d8l/XXiRvzKzCpQSQb9yyX7caa2HWe6X5KbQI3f8
 T6BA==
X-Gm-Message-State: AOJu0Yy4V7RK5noAZtDauWP9J2zdKT3/nFbiD1A0b3YBNbcLZ/4KCeJo
 p+czn0XsKjpseINEW0Hp3oSS6P2PVz0JdmW2pblmodJa9aihy+Tyx4dg9NwTvLIfUwAYftqCDZz
 odLN4
X-Gm-Gg: AR+sD11m/FOcyqGHGCYcCeB8uHuTLv0ajmwOPYLla9HbBrW67iDmnoDEO/BFI01cZAX
 BhYhPB645bs3gaWGQ679vG77cLvOfk/gRQekd6ivqpyWtdWDnJINcpw2L2oqo1Zj165t+cEPFnJ
 4bJQYxpa0NQZ2ThdtQyeNrszqXBgokGswame2Jxi1a6VpO6EsMwxfJhah20YERbCXD5DDV2ZE/b
 5T1UX9HUp5RvBjZ1UKu3HDPi3oA6/vNsCB/sTWWKxtSCpjjKeaBrw7f0S9brJbZEavam7pYvPqb
 zhvqLxHBIsgCktavRoUc27gjMwZQgROgBMre1FzKkf5WkmtMwPnNCwalCjf6cfK0lTw4XReYOoK
 66tN+ihQTw4iUx6JSXJ7Or+uUk23W3wz/L/VpT3DgsJjEGKA21R9GRh0EWqht65cHxHjscSxxCn
 l6cSyJWNkP91WCY0RB/9FdVViyJDHUoErmq8OXY5IRluT4k3Eyl5BiQJhRobkiej5IaVwYtFVqf
 c4Z09r2pOVCJ/iuuMVP3kx0ctiL6Gy6GIs0kGdOLZehueJ8ZX4lDqxbdtk/jz5b2uvJqTkm
X-Received: by 2002:a05:600c:1393:b0:493:bb0:3b43 with SMTP id
 5b1f17b1804b1-4980c66c7cemr192987495e9.2.1785745849579; 
 Mon, 03 Aug 2026 01:30:49 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bb45ebsm152286045e9.4.2026.08.03.01.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:30:49 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 1/2] hw/nvme: initialize ns->subsys for n->namespace
Date: Mon,  3 Aug 2026 10:30:45 +0200
Message-ID: <20260803083046.110121-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803083046.110121-1-alexander@mihalicyn.com>
References: <20260803083046.110121-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32a.google.com
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

We must properly initialize n->namespace.subsys too.

Will be important in the following patches.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index bd6ad64b200..710c3e0d77d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9648,6 +9648,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         ns = &n->namespace;
         ns->params.nsid = 1;
         ns->ctrl = n;
+        ns->subsys = n->subsys;
 
         if (nvme_ns_setup(ns, errp)) {
             return;
-- 
2.47.3


