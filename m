Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71FFCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObrC-0002gF-9a; Thu, 27 Nov 2025 08:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqj-0002eR-EF
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqh-0001Gn-UK
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uv2XiG+ubsG3OVkhVIfYfHbcOhJw5E0AUVe4KBxbFc=;
 b=QOso8l0H7YRSyKtpHsHYccMxW1fpNx4RnAK3YqZTKH0asPMO5UgwRLyTOuldkejv4cnQ6m
 msaD3bNfZ+IEwGX/MeJ8m+3uQOYivE+iViEF923MbXPOIEdLCyKGmQwvww4HT43NFOe5mg
 BzpIfPRe4VWb0mqFNL3v/YLZF+9tNqo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-_5tRG2aJOn65SkgEZQPE_w-1; Thu, 27 Nov 2025 08:15:49 -0500
X-MC-Unique: _5tRG2aJOn65SkgEZQPE_w-1
X-Mimecast-MFC-AGG-ID: _5tRG2aJOn65SkgEZQPE_w_1764249348
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b7336ad128cso83612466b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249348; x=1764854148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3uv2XiG+ubsG3OVkhVIfYfHbcOhJw5E0AUVe4KBxbFc=;
 b=rRzRSvj2wLOMSFVpruRN3ZCLVrWTw9m/ezUS7TEXy2SUHUdcLMwMpVc2GIdj9fTX3O
 uBQS5WIDwACj19i4xgeDfW/o50WLYCEbw+zMjPZJ8WN2PjTRkSvVYRVh5vdp4RARzLgX
 kiACElpR30thkoUxnxeztUAN3axto8b9041ZAAi8jcIU4EPtnTMcynwiWa7IpaRXihPt
 TRWCbqofgpJQXey1NbzPFMDeAHCeL/Zu6pggaDWj+ENwSh10Wa+WtoUhs4cM9thZ7CP4
 IpAf7UdlokvxSP7Mhme+p8lBzxDl58NoLQJ/5z8WoNPtlYdPMgui1A60szBQTAY7Ii5C
 6t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249348; x=1764854148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3uv2XiG+ubsG3OVkhVIfYfHbcOhJw5E0AUVe4KBxbFc=;
 b=f+Hi1dm2a02mJT6NHH30PAic9h3NA4TLGnD4BuuByxOAdtOXKGgXK+lqXk71X0Fx/j
 YFC20D6di/NhB4H91yd0WK3uqJgrQS7Hc9sMb3z6ky044HipLD/XC4xIyP5VbJUl84mY
 heomdYjc71b52fzR4jkngb/BxAdsO3xh2RkRZAO0h9mu6SplvNfNQjA4pp6VktuWqdWK
 YtcmFUURPhodR7ylvu2gsktbY4xdhJk5rPuIFKGvROrcrUQnJ+2sC7l1RSdC7NwW95qY
 DQ1kLpwffqCE5GNKfsDe0pn+nHwVT6VE2S066OotIhTsZlGCZbj2LF0VWFGR7zO1tqfW
 BEmA==
X-Gm-Message-State: AOJu0Yy2zzC9EHU1Fg3R1FWKVT8pb9VCc5VHuPwJuekPG6546YbAhKZo
 jRWILNPurC9L8DXn3rDX3p4aiUpiuHYqJsb+AWl0/S9HoDVhFYZ7fig/swN9HygFmiBdcQFjSjU
 fmKqc1GlUNFKvw3ZJ5jsLRZxnyxPiJ44qWgh+IAPxD7bXHn0YNJFSpoY9EL2jXICGwAP1QEFqhE
 RqZcKq8r3RhqaZ0Iq0wRzm1Mb6n49TcqQ+41Ta5Oec
X-Gm-Gg: ASbGnctU4YZc5lB+2fBmakyzhXMhlOJahTzaA3r8KBMOXp/zk21x9gbM0AFXizqOSIW
 LzBw1QXkQA5IPIxGpwfWG4VY2i1k6m82shPjQPD7507e3GkPgEvLksDWfLl0xsSwqK3NoIGuC7C
 //0+wORUw6zws1PtDGSMFhtak6ezZpF3v/JKGnmV4iVIHUSePYFdoPeZz3CY5wgGdor/VU/LJFH
 kmqQ5Sa/UHM0FgDaxWQKGsdhcJwLtgIZsNUXIxqkYVbCdbUVO1blrxw0VrEhVlvt1ZIMv9SHZgn
 XhWV1dULRdNMWEnVsLiyNIkjNr5AQoc4Z9mQCeAF5sX3Dcx1HCn1XlGf6+R1U4T/CPAqTkZM6Fm
 c41IskeOyvDnLfpM8I6cZyJXtCo8jz/pQ+d8sMlhLO7ogUqs4Roj4x07931R08GMj/6evYDMEf7
 7QRGiAU+sj5+dj5zw=
X-Received: by 2002:a17:907:987:b0:b76:277b:9a58 with SMTP id
 a640c23a62f3a-b76c546da61mr1109444266b.9.1764249347959; 
 Thu, 27 Nov 2025 05:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzM5dUm/dxui2eaHhubfbxRffet+YIQrV251+pMdW/Di5hVIcVlITn3qfM4B3CQsb5iCsuCg==
X-Received: by 2002:a17:907:987:b0:b76:277b:9a58 with SMTP id
 a640c23a62f3a-b76c546da61mr1109440266b.9.1764249347477; 
 Thu, 27 Nov 2025 05:15:47 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59aece0sm155842466b.32.2025.11.27.05.15.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/28] include: move hw/qdev-dma.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:05 +0100
Message-ID: <20251127131516.80807-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{ => core}/qdev-dma.h | 0
 hw/usb/hcd-ohci-pci.c            | 2 +-
 hw/usb/hcd-ohci-sysbus.c         | 2 +-
 hw/usb/hcd-ohci.c                | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/hw/{ => core}/qdev-dma.h (100%)

diff --git a/include/hw/qdev-dma.h b/include/hw/core/qdev-dma.h
similarity index 100%
rename from include/hw/qdev-dma.h
rename to include/hw/core/qdev-dma.h
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index e180e96b5f1..25c400698ee 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -25,7 +25,7 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 5c3434153db..8224fb88628 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -26,7 +26,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index ea3d5d2bd14..588cecef14d 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -33,7 +33,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
-- 
2.51.1


