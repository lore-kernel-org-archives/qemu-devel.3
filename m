Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FCFCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ83C-0008Ru-Co; Mon, 15 Jun 2026 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ834-0008QR-Sy
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ833-0005FI-3m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso44359295e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781532739; x=1782137539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwI26bAPD++fDBpapjaelr4YYzGf4tn+w+2LSRNSEKk=;
 b=CbEPFWbOB/eM+tWKsvY+2fmxg8OqjHgYsR5URAbZ2PL9DqgttgzZXyU6j3H7+B5UmP
 DoaVVr1oQo+Px0XggsMYlWnQN/R1d0FVhbEV1SFXiRR7qGER/drxq4bUB0iwovHgMsDh
 o1XCobC0zUAuBGvaim8S/n+qi3ZWbeksTJWDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781532739; x=1782137539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SwI26bAPD++fDBpapjaelr4YYzGf4tn+w+2LSRNSEKk=;
 b=aOBo/ZEQZnGiAYuukrYFcBBfCZSrlBjGqfbupFhASPTjWWd6UuS2DVZknK1Rqq9W2K
 mDyaAvf9eNRd+ZAyuttWGAxi3BOXBMw6ufuB+PwGmqZdwq+XnJ+hNA56G4nAHkE4TbTC
 uO/Mv1Nx+mOnCZX7iMyRhSwjI1qIFHgovJ4mfnXf+MaKQlEM/as2GmUb2b1keezt2OZa
 0hXJLq8fgJPrxDusX91hjqYw+U0bTinbl0WchXoy7Sz5k7tCWo4WiNhFucA5qlakbYSG
 hie/Mh/IjtafIiuLfsKVIu1MU+grYX0Q0PcwUxmMWAxQ07SD963DtWpVjbiBp3XThIoG
 7qpA==
X-Gm-Message-State: AOJu0Yx4IP+5lhwbRnTucQdH4Qv34fNGbdvBamzy2X4mySRl0rgnebmd
 rUOGuHZrg3jdkpDoqdCe7hO1HjtHHfa+gJ1llxtlGq8iApsule6DnoJT6SdOv21VqpWk05QADHs
 hrxhSf3w=
X-Gm-Gg: Acq92OFKY5YAaLRoIAaYmYDO88nOtaMATcpfyNXN9uvut6J7YMVk754TdOgttJpS66s
 J803Lq0TSHbHf4oWFZy1Zb0UyfziX/nZibozbpMQuvuZZWh5dKeXL3q0VGaKOEa4OrCVgOASbp2
 KaFPas2GP0be75svtBVP1LgMBiJ+vnK5KjyctgFJbZQ2tW2Md1oFwqWk8MUv1JmJD91zgm16hYy
 wcDi39ZlpjoUfzKde0DgQrV8aHHYep35JdhZwhLGkxEJtFR1L3gXDzXUfEC+VdkBBKIYkOfYvid
 PRSVLN32Wxt2PyA+ksV1QZbWRg5vqbctyWHZ2WLK2WKEjxVWrhED4t+4n+ZgHqU8ZD2j2CA9dS7
 Gf6q/yNUNGslB23cGyvtAB78kH21xji3H2NYBHtvM/JlflhsXGdrwehwBgZhpGCwm18LqU1tlFn
 8+SLxP7pD21nFA1KDKQIGSnVMEUIcyRycZXZuk7Sl5yFq1AJkeA5uqveR8cNpC+rXb+uKAbdtvJ
 SI=
X-Received: by 2002:a05:600c:1f8c:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-492200768abmr151599685e9.15.1781532739263; 
 Mon, 15 Jun 2026 07:12:19 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:574a:7200::9a8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm213758215e9.0.2026.06.15.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:12:18 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Jesper Devantier <foss@defmacro.it>, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 1/2] hw/nvme: initialize ns->subsys for n->namespace
Date: Mon, 15 Jun 2026 16:12:15 +0200
Message-ID: <20260615141216.162388-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615141216.162388-1-alexander@mihalicyn.com>
References: <20260615141216.162388-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x335.google.com
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
index 815f39173c8..391f8260fc2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9331,6 +9331,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         ns = &n->namespace;
         ns->params.nsid = 1;
         ns->ctrl = n;
+        ns->subsys = n->subsys;
 
         if (nvme_ns_setup(ns, errp)) {
             return;
-- 
2.47.3


