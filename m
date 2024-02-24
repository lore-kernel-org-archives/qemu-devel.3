Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71273C54E41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoIA-00086M-UM; Sat, 24 Feb 2024 04:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoI8-00082x-FE
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:56 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoI4-00030d-I0
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:55 -0500
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7c78573f294so53008439f.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766751; x=1709371551;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hSE21Mrqfu0T2SnVvXYjG34ImKuNrAuZftAxXoyYdr4=;
 b=VfAWUDdLbSz5oEj7hG48UFcQ9WoZZTzHkZqxYnOR7Ccq7GCVqdVONy6yY/N8rpmQT3
 Xd5hPQGE1c/QwuC7vUhuDM62lPaC7jn56C8xMqjGA2kQXf/kaWEcCSEK7Dgn0fFAdf9P
 PrMnzjTqDQRlm8NOyCY+CHNVH8YvM2Y3sdiGWleQpS+SNHuxVXrdNPRk2Y/8L7A5TBMX
 Y+fpMQA/9vLpY2TiZzycMxLIXdkfpLuRahhxJh0icByw+OM5oKqTgSXwn/dewDkhI/eg
 +Ntz81UqIce2hha+IiQDDekSbpp1YVdMLesYv+1xvvkR5D78yPZvRw4T/HasXvNUUAqL
 xfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766751; x=1709371551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSE21Mrqfu0T2SnVvXYjG34ImKuNrAuZftAxXoyYdr4=;
 b=knWmiTLEkH7hyw3EmTJH+ugYr0P+XDqZnrBoPBHUeGh+yKkhxzdmQTQeifWtKiRnI5
 ocykYHr733u5kzCdY6gbZqBMt8+470od1gAtSzWjoLD+LmPzX4U6PBSNl0lhDqVSdLct
 ijXKvz75MxpO7SFawoiLxG0blZxfjy4V6CDAGN90FZL1leMUPh+CgXXcvqsqMD+flGOP
 ts4W1VVN3JdIbk+Tern824fFuAF0nQ6ETNP6bJpqZYTEPnK/8n7KbL6xZ9DIG+m9aMGD
 cMfJZeMfC6UrcFEW4cjUffu/Fz5qtMsOPZznSPGJJotSbgXR6O68Dq2GKbsPzHML9iai
 W3Ag==
X-Gm-Message-State: AOJu0YwiKK4yalf0GcZ5ohOajD8CdxZfDrIkkzaKMm8BqOvhuMofkaid
 OXxslGqX4QCCN4iNKkGcO42mrTy9y9zTMVhhDJZaw3QCMr/47ELbL0FSTQCZoHI=
X-Google-Smtp-Source: AGHT+IFeMHZzNpTz27T1gwY8AaHkCbiXaDe9kTVTw0TvvNZXA6LGK571gWLlSCae026SM5VATJUoPw==
X-Received: by 2002:a5e:d60c:0:b0:7c7:94de:926d with SMTP id
 w12-20020a5ed60c000000b007c794de926dmr2314803iom.21.1708766751414; 
 Sat, 24 Feb 2024 01:25:51 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 eu16-20020a17090af95000b002997e87b390sm2852345pjb.29.2024.02.24.01.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:51 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:46 +0900
Subject: [PATCH v7 14/16] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-14-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca151325085d..6be0f989ebe0 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != UINT32_MAX;
+}
+
 static inline void pci_set_power(PCIDevice *pci_dev, bool state)
 {
     /*

-- 
2.43.2


