Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7825FC52D72
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkh8-00066M-3q; Fri, 02 Aug 2024 01:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgw-0005wb-Bz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:04 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgu-0006wK-Rn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:19:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso5920548a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575939; x=1723180739;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=mDuILuDnZruFwPlWR9DU9g86U5pLZnkPjetohw8ryuCQFC3msiiCM1ddjIbA6iYSya
 uj3l4YV5kvlxLILdF/Kj6ST/diIfjbCXgOY1dEwQG404vlpl/Rt2to4mg/JDb7Q8EOf4
 k/D3nSURxX5ldEdSWunD4WvtIWSlee6Qa+kZ21kkHFzCWUGTqYZoImfD6+7dlbZwl5zX
 9BDOjclOG4a10DEOpGx2zNDqK5jE06YxRoeJzbnipTdPdBK7yPQ8Al/OJ8Npq1pK+7A/
 Jh1kLNlFVKbKfzXsKys4KyzvhqA9au8Jk4BFWCB3nb+177lzrI+jkQu0Ibu9RIw3LPcD
 6tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575939; x=1723180739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=ffkPZFa9jbDrbhDmSepO0cmjoZO961MEd/tK5UEf1KyMRQ+vj3YZ4zfrGWKxq2+ZV+
 K9D5UHKKo6+Nut5968ThBKKEPA8S+CSVbXejST3nXgYis27mgqO/5PsarlUCPlMsHfCh
 rTNr8ZglokvCN7rl1xia7Y2AiCy7KE4U6XUldbM1g/rMexuLS0hVbt2XDSkw3A0GPP6n
 yBP9BbBcvhzInhH+qARnoYqc2uRSyyRRT7NY+wv3zXlabrR9kMPWDmYdnhYKq15Kzhwm
 5qvZkAcZXVQAKN3tbA4BS5mQEL5Y24DddudkUlUQhhB8TUK0NUynMB688s9dmKL872He
 ySFg==
X-Gm-Message-State: AOJu0YzfgF+vqv2ZtOQ9dJMEfX4RpGLbA8lB0XeZ0hd9L9rgAJg6o0SB
 1I4sC7WHWi8cRJk5RBb1Nn8GRT4vA8BHmcptMT3ShHmKh/8mX8F2Dl45MaeVCUo=
X-Google-Smtp-Source: AGHT+IH9VAaArrXXja+1b8NQQHdLVygPxRE6N5AVhwzoVHVnk/cAEDuw5oambCMSR/YRjOfZQL+99g==
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cff9559d93mr3094073a91.33.1722575939610; 
 Thu, 01 Aug 2024 22:18:59 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cfdc42f9c7sm4305133a91.22.2024.08.01.22.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:18:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:17:54 +0900
Subject: [PATCH for-9.2 v11 04/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-reuse-v11-4-fb83bb8c19fb@daynix.com>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
In-Reply-To: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.45.2


