Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA86E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmv-0005L0-3N; Sun, 08 Dec 2024 14:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmq-0005Ja-BS
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:49 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmo-0001Wi-W7
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:48 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so59281366b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685465; x=1734290265;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSrK0KIvSps8khYl73b0xinOM0CEMUR/qWbB2TAKeag=;
 b=j8IkPTSK4oeUaZdwZPSXD2dc/Va9Csmc2BwgEE6ZdpgnO0ZJ273wUZ0E7u7LcR+p02
 RWaNLoNtCR/j+y9yIXYdgylobDj9QivkBC7xz/D10UQ431A7sfU8/HpNDVluWrp6Tn5H
 YHeMJ+bAn0yt8K7OK+PwsjO0G0DWb9mDiyCncsET2Hlkrt6leOzhmy/hcxJ06b/j2LeP
 6Pkyx1JkAeXRCFDZ/l116JHC+iVrWS0sEh2Sh24tdJ9EK9czY8fNn6K7oRu0jjRM2yFW
 v9bBKQUtKNuH8bDAERwdgcri8ru0KnlGcA4jRnsKWm8T1Qe0h7cde+eGAWfPpkWoAEzO
 rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685465; x=1734290265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSrK0KIvSps8khYl73b0xinOM0CEMUR/qWbB2TAKeag=;
 b=DrvS37IhgUAR0+XgssOpFAMqLMl05Zyc5O1YzeEjpr8xPDzPnBVvGu+UsBZXEzt5OE
 DDyW5W6rcuiS+C5632ftOx3UNMlB3hD0LIg5OMnU6Wo5TRJS66CV8+7+fNtH6ukPEU/J
 dzY4HnCTQXndo/Pjb6vOWXmHEqLhWzSZH/CmJ19p74ADtpwM2e7JrZZ1ZkPb3QrXWsqu
 k8hbpP4T3dyC3Uwk0ddzpS1nP2pkhMm6WEiWzZjTZ+xK2nMYsPUM5k7iYM4SHFBGuTOg
 iaonoSYVjZG3f/vqRGhZpTv9bwYGQlptjsQGb2KYChpw+5ot/ubejCy563rRThfC/KTi
 2DXw==
X-Gm-Message-State: AOJu0YysmZBTO8UQz1qjjfkvc1iMby1ytWZfePlN9vnco+Y/c4CjFqo+
 qg6FP5Z33AiFxf8ZMO7w4ggdWSYf9qK7HztSQk+iEKM/UksgL8qio2KdUm3bR64Hy5BPNlnnpIG
 NIg==
X-Gm-Gg: ASbGncuLGbJBgwGfEf2UuL8REgXVVOlq0AOyCVk/kl97Tr6Pch8hr/R5hh8kZ6/Z5Xd
 Isbn5edPXgVs6Wcxcjp7jrUJrAsTRkFqPt9l2igIMwoj//3QujS3xegZYjOp9NN4JJrTSYL6TJp
 y8eQI/QckiX5I/B6vao0MjBbCqFe1b1Cz4XC6qQyHm/Iu2M1f0/XAlaGMg2Zzth9P5Yn5/bmm8S
 6FgxEHKYKMEN+puo2wUtkStrJ+B1SLYTcpUhu+Z/jInpuaLmw5Gn5b5zdXXkzCWP0r5lvCsitLh
 4C/PYyDwUTcSX+hkBBpZyX/nIg==
X-Google-Smtp-Source: AGHT+IGAN4bwicfgo5P/qLjcbPQsTrM9+khvMX+246bA852bdueXIVjZqOpGMIbPBw0atBJlOLn7pQ==
X-Received: by 2002:a17:906:30c7:b0:aa6:5201:7ae3 with SMTP id
 a640c23a62f3a-aa652017fddmr561191166b.40.1733685465004; 
 Sun, 08 Dec 2024 11:17:45 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:43 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 5/6] hw/usb/hcd-xhci-pci: Indentation fix
Date: Sun,  8 Dec 2024 20:16:45 +0100
Message-Id: <20241208191646.64857-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208191646.64857-1-phil@philjordan.eu>
References: <20241208191646.64857-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::635;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Fixes number of spaces used for indentation on one line.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 8e293cd5951..6b6f0f91a18 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -111,7 +111,7 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
     PCIDevice *pci_dev = PCI_DEVICE(s);
     int intr;
 
-   for (intr = 0; intr < s->xhci.numintrs; intr++) {
+    for (intr = 0; intr < s->xhci.numintrs; intr++) {
         if (s->xhci.intr[intr].msix_used) {
             msix_vector_use(pci_dev, intr);
         } else {
-- 
2.39.5 (Apple Git-154)


