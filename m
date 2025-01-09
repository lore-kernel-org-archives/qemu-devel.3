Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D764BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm4c-00017u-0r; Thu, 09 Jan 2025 01:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4O-00014h-6m
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4L-0003mD-V7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:03 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2167141dfa1so9561705ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404260; x=1737009060;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=XfMLPuPZmT5J/pbJw3AoO1PpHU5O0wC2NBvBpdM1aLIVVDHLeVTBRK1CXgJq3Vr3n2
 GRyn9joJE2Pvvvue855QEoOm4fWXwUZF7azynpfRk+9eBd0k0NQUXq8HonWvKTkqWN0e
 I0/1cs6or95YRj7a8qaEA3p1qlUg4JNdHSHojyEGcQp+K03eh1TiSzvkb4aOAGb2Rpcb
 F5ixySOvlhd98KjL3RhCnIWXavEfLYA4Xjn147SKJq9jVtZskPjl/MWdp3LyRSp5NI5E
 TDgrSeE5LVQbpBseEeghmmTmoUOM1553V2XqHseYbVX84FJI0lWVV5wNZdg7CUPda6V5
 74Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404260; x=1737009060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=wB45Wt1UvrH7jtEaQr+Qq1n6edLK2f3Jkc3j4+rBPb0iiP/aVuPvP5WjyRJaVKaJsr
 EJ1fA6FRguxI+NBiJvk33N6ULi9wueQyqrOYd6MSfa0LGQuQEOP3XPSEl999/DiZif4b
 2zVzlqpz2ClOjPdPh810ow+JFerFlBCOooajBgOBIhN5GlTQN4iSUAPHb3U2xOYJu5gB
 nPl04bhoYcrZxpM4Elg/WX56yLroVntx0elIiafWdFYAQzRNZ+EJkSIpGkAD0ZCGXuyp
 LP+181JZbwdIOWGQbgKfDWYkMtGGZhI2TpSdcj7jC89VRlKWvkaxCy5IkFjlPBoD/w9b
 F9Fw==
X-Gm-Message-State: AOJu0Yx3bDMQcEUV1UCWpgKqr84EndWS21LIob4TVXcEr5yvN/OhsMXs
 M4ZdiunqsEAqvu3vvEyvsnF/XPE/DHmiKMu+ilL/dIcT7N5+1RpHLZdC/qUCkyk=
X-Gm-Gg: ASbGncsxivuBnAJJkhntPP4tu0jjFGXTSU2NuCJ3asr/vpIBABwXJcntC3GzAlITrUB
 sOS9iDQXekQrV9qaiOo/ZpnKd0vUDBaix8YjlMTXRe8uMNpAqXVw824K8GoztU+KP1H/wiZuKXk
 qRS6WKmU9f3AttIRcDVoH/c29CbQgFlgV15GirHrpFWjOPKn9ymS9Qs6s63B0DlBKc054g4jtFA
 E91M0GTBIECBJZ3KoYuO8UXYxxiAUMnziLKVOAwoL28I4tg6IApvqF/ksA=
X-Google-Smtp-Source: AGHT+IFP1P3p2eQ4aFX07J+kMXcA/tpHSoSElPHKrh+1cV+AlLqrL32VQ2mLXU3eNiAGQUdjInEcYQ==
X-Received: by 2002:a17:903:1103:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-21a8d676dedmr37461265ad.11.1736404260609; 
 Wed, 08 Jan 2025 22:31:00 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a7dff6dc9sm37658625ad.179.2025.01.08.22.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:52 +0900
Subject: [PATCH v19 07/14] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-7-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.47.1


