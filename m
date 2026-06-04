Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB640CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5Mj-00075H-BZ; Thu, 04 Jun 2026 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Md-0006t0-Sk
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Mb-0001kn-9X
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so1114377f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1780569108; x=1781173908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwI26bAPD++fDBpapjaelr4YYzGf4tn+w+2LSRNSEKk=;
 b=drikDSnk4z0xryU/KYJwSNnG3+zY2sVUJutpUSKzuahffeamrIvmaBZgKb0aCrZb16
 gbqXHPbF/qepfr39tJ4YlxYorZ/yjEBqXRSfrwrLiClcZRCUo+E7idXXiIek8fLrtLiR
 boG4HlLXdWvHWsMGAVjpeOB27xzfzzR0fdZYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569108; x=1781173908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SwI26bAPD++fDBpapjaelr4YYzGf4tn+w+2LSRNSEKk=;
 b=gaG15/zL4bkHHwWbY5GeJCClLjlnIsghxvpyA5eb0SCWHjEJgAURohLl8huwYjZxqN
 A9cj7Daa5T9Z35+vDyEoVzaY2+QKq+hJHQzJegGho/JOkycSwj1MTnAMlAqpYtP8r4cB
 LFazLlBIX06m2dDlsFCZD0LCwnY8HR4dM3Dhf1JMCQy/EqKDS4wpR1Fdbbx4AXDXcmBK
 RJrRWAm1+dqYbzzBqaU1J76pnC6kmejdQhAhnV7RUqh62j3zYHDkMMKrvHl9QD2iF/OX
 1/y951Sz7lVnwvXWfzb13L0UGUTS/iW97W7wY+tHEDfwqmuntqaVvv/TLa5mpH0U+pma
 UDBA==
X-Gm-Message-State: AOJu0Yzg/SPjxO/gzC3dQ0ff+dNecuOUy6UQyNnTZdPiWCjeHXwuWe0r
 iQOMRI04SgzTuIQRFVGq7xnECf5oqcsToK4OwBxAlBZB1pgYOVY3iZyDXwTimG3+1ZIZIbqhJ2f
 JwrgI
X-Gm-Gg: Acq92OHMEijRo1e+aCOLQI05JoI16dnhjv1ffAbMRS0Aqij5gBB+i0juJs6hQAI56Zt
 rdzMIyhC6vjxkKOIhBQ4ASV3lXjASyFvlFlqhN40xonEq2IvCFVxbJKIzhoXFNr/O2IkAFXT2a9
 gsU6gPdUIg/yfHQWV45ArvyDtrm9ul+iuj9YL05wgWC28PLujJ8F/Or5nWrpD/gMLLAcHUTrLk+
 +unkRYjXD0MjsVMG2jHxaBRHR4TEkEn5qgRy0Zsr3Bimg0Y+2zbhjgCEkFe7KgvNyvj/yJHKVjT
 110hnVA9ea1MBBY6gFB++lfptOJMr1wa6xpox3z19Xu8iJkRhWOYzy8hy8ImBV6hfUDDeNCSW5v
 RAcpMjfU1J1HRVDZ7Mn1WkZ7lgNebuw3rWeP8VlFwBOd/JdfbzZHh6eIN317Z33rD/oeVDwpQEA
 HKdw8KE+31kisLJLEHIOOYndz8DRebyEt9ph2uL8NenTxVeMWRK/ooyfe5/ZpH5HEaYqLjG0hvd
 DtnnhrUhJ0UAA==
X-Received: by 2002:a05:6000:703:b0:460:133f:2a4e with SMTP id
 ffacd0b85a97d-46027317db6mr5118188f8f.13.1780569107809; 
 Thu, 04 Jun 2026 03:31:47 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00::9a8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm15928661f8f.6.2026.06.04.03.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:31:47 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 1/2] hw/nvme: initialize ns->subsys for n->namespace
Date: Thu,  4 Jun 2026 12:31:42 +0200
Message-ID: <20260604103143.462071-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604103143.462071-1-alexander@mihalicyn.com>
References: <20260604103143.462071-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42b.google.com
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


