Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B33C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVr-0005rF-QI; Mon, 05 Aug 2024 06:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVc-0004sV-Bi
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:11 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVZ-0001On-UK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:00:07 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-260f863109cso6152922fac.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722852003; x=1723456803;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=osg9wNLIbceYUs8hCxmz+jq+/9UpZqtpngDUnZTlPZfAbkB8BrlUZD0o4Ik1u82Nus
 7WQrwNn10iP3D6g6lEJjc0yEHBLZQfPO2IkTP0aLcidsdebcrB5Or0bWE2i99+VZ5Neg
 yVIcwWDEalGXQVOmBWe9vG67lQpc02BQDfhyd1hOlIOkd6XKLKhtGeKK/7y0iUHcPTSh
 CZVfkE/4sGeiTFIvhRyde3SM/5K1W963M6xB2ydMf8LXDWZo8OqwUiRgPKD0SoyCxx/k
 0Kk79qgzkVIf/uV9jVs6HRUhker9//TcasqK/2pjHNEYenL+Rkv/qCfUwityBfOEno1M
 ei4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722852003; x=1723456803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=V9jH99z3ANKHKu+2J9fEiQw4PqHxckMXVEeOZ64DNJTM2FiIzl3V7urRYgy3Y+oIsv
 EV+mh4qgKYLjpukZFdS2iINF1lHS1JH4hJZnaDGBjztFyWoNSkIk2/be2q8RbK4zniay
 JwTrifVxvCtUg0fIBiKno6kjStsUk9xP4dmZcdlK69LEHTwbZhMC5cxJLWP3hUf8Z8DJ
 OF+39s5MQH4huLtezUR/WYlMd2NfYshs8ShyzOEaOXKvLRWyRFEwKAvIrLdUWPeQwqB8
 b7Hvrnxy5ok4Es/fHneYiITLMu3vdgR3BINuTH/CA9zXSbKYH4i9FcysrBF5Xur+IPK8
 zyQg==
X-Gm-Message-State: AOJu0YxAtf82dPKCCaVcW9Ap1wiaBI8k2NXM4eQc/027bUIhdV7eL4FJ
 TgVNxMeUq4IZ026wAfGIgFvszxWpm/VsnThEzHTaivt8wUJMIIOdQLqmEBpkPMg=
X-Google-Smtp-Source: AGHT+IHLtKvZEzD1nLCuHl/V85Fxnr6q24DjY6nxZiVJdLSG34SQwfHeOmhPd/XpM4MDrAOD/vVp8w==
X-Received: by 2002:a05:6870:2193:b0:260:f801:61b2 with SMTP id
 586e51a60fabf-26891f240famr13333670fac.43.1722852003533; 
 Mon, 05 Aug 2024 03:00:03 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7106ec05b77sm5042993b3a.21.2024.08.05.03.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 03:00:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:05 +0900
Subject: [PATCH for-9.2 v13 08/12] pcie_sriov: Release VFs failed to
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-8-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2c.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea85..9bd7f8acc3f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.45.2


