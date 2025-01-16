Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B37C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLkw-0008ET-2Q; Thu, 16 Jan 2025 04:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkm-0008BE-Cp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkj-0000x7-Iv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:28 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso10936665ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018084; x=1737622884;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=JSzGXOKLGm/S5GNreEjX/qlLD9P9oDGQW9Q61TmNPi9q+Mm3Dnf6+oDYSs/6r6DHup
 VZKRxGmqlmPlTvy41dNBghPHmGOgdbVgffoyLF16lW4cZGCpKv5FvZWGKVLxnG8OGGMi
 PsfmMStiBfQvZ3IkINMT6qQrnQNOtFFQkByw57ScmN47M/96B1B+d1gdo0IEJmz3UzkM
 KuT5J+p1Er7Gm6DpszzlSHkE8mG8Ftgzt4OwEXh2zwrHrCvl//2Z/zkctfUF4gnAilAI
 II30CDkMwsmyjVoCzMGvxIBWfCfw7JjMN88MBs/jV9fxG4TeWyNyFFfrsgKvyy1pUbgs
 unyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018084; x=1737622884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=DbdR98bxOvFyzJnYPbUTTvJqKSsSOybQNTPMgbmQazlwbZsdT5ZRhG3zfYgvYUn+br
 OBdHAFV+y2rpKRFM/srUwk6pdQCDKzbSuLv7VV+5qLg0RiCl+g34vcBKbr8pcwRj9k+4
 VIPZiqZv9RgSZeAJs40LZ6GPiWmFUpQ9R2anKXLRZhmwYzJQr/717htzycRznZQJ+QgO
 3Rl7rIAhLflOQCaCRdbz+eldN6XhHSMA2ykBXqHbSsJsJd2OfpIyPp7KQkucO2vqZvb0
 LxY9cyOBAGVhZQZ8+DNTJat/+mxBS1G30JgOxOPmQYFw8ld4DCmZRpG6VsM3t4M3A5r7
 eMBg==
X-Gm-Message-State: AOJu0Yzoq96F/cCcPCqkuG2KqNA7Qsm0gweEVNMWV2lkLYT+5qKQyVno
 uWVrIDJxwSpKlAQ99wqfj3e872rPB+VdPa/18m9DKXaAqLNZj1v90q4pSp6m50Y=
X-Gm-Gg: ASbGnctpKe36PQ3Z7LJlWxhNhBNifPTraqucb94pyryaDw5UkdgdH8gM4a0tp14k/XU
 tvrd09V1flyjga3j7XH5AJG+P1ICuFr7+PCrJ4nNr/NoGa754rI98HUClM0ShcWs8y7/MEfIddm
 q/dPAV+Alu1Y/9r//+YKA2NDbkNnvpmpHGzLavD2FAG7muwzUgxKIZYTP3sbaS/981MuqfAfh+A
 h/VZm/pgVjFn+aZInHqE9RMmpM01VknJFY1A1lFCwyP5ZBGTWN5N5s8s90=
X-Google-Smtp-Source: AGHT+IFmNJ1enmRO7k7pgsZLhZRoJJCVDIvfPpvaf6eHEXUanEeF+2rfsRnKML38qNzlzOAb6bi0rA==
X-Received: by 2002:a05:6a20:a107:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e88d2fc6bemr50702667637.39.1737018084282; 
 Thu, 16 Jan 2025 01:01:24 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d4067e31asm10345667b3a.123.2025.01.16.01.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:53 +0900
Subject: [PATCH v20 02/11] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-2-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b94e4ba1314f..e0a9d50edc3d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1549,7 +1549,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.47.1


