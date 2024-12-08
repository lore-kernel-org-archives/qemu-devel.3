Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8701DE7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmy-0005M5-42; Sun, 08 Dec 2024 14:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMms-0005KG-9X
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:51 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmq-0001Ww-Nq
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:50 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so96984466b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685467; x=1734290267;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/FQnyaymDlHcJ5QODQTDwIMUzbyGNUlK4WHRRDGI7E=;
 b=UZ+9Tlab5I1mw23dsjqGnHy18GBoPBdznf7kgPTSmP71LD+HlMfTJE1Qibe5YNBvhg
 sJNwoARlzF73iz0/qpVdylWQJQAlSJA29KJvLsFCT42FuCqV0+1l5dzvZr/2HWuU2Arc
 HLVwtkIdYls7afZDFPiNp+NzboqHVhnQCqZ65cRTQW6bgcuUb9as6DCldJWfgIwnqZQR
 UIGX06gFCs8SIKIDcC1267yr0bDts9gxcpEksUPdyoeuCoi/T8zm68z1ZLFuNWFJ2qEd
 92ZnRw/b0J8jkPHHP5Lv882AN+6Nv8Pdxxm3JHHxmQUXvN5Cpl/0vPxrBw3x8N5lGDHP
 OPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685467; x=1734290267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/FQnyaymDlHcJ5QODQTDwIMUzbyGNUlK4WHRRDGI7E=;
 b=ThBgTChRtZwSXSn+5b3lDXU0iC+ADsGQupLk7/FXo/cjnAED+GGuaaEbRNTx3mC9/H
 mLVQyfVe87HzbgBPbIf6W4hOkTMPKXWEg6oFv7kQ/6qzi7y/51qDchmWZs5X58afQZY9
 556MLziTAgrk76xqfsqqkbNlv4SKVS99+50B3GWG8qTaUPOu38dgU/Ed2CB4eACge8DV
 Yj6NSNQ97Bk9Sl/nnPPTseCXdq/5ESIDV4L4lgNuIjWEOFnb2NXKoAjAsI7yO87ePpLr
 Y65DIr1LC5vl8HmWsNqVxJI+i+qwbSGrL+3FXyzTCFseQB4N3G+VPV+9LfKFxPVnHm6i
 GJSg==
X-Gm-Message-State: AOJu0YygCio0rYBv2IX2wTNicoUSjWGQCypphbzXHA0OkRKcOtZghEEb
 z1IU7PiL5SEjbXNCwmUpkxplUDEvjk3r0heP/QMLC86SOfWmgPwka28c32bzmGIzpnBSPs8iN/H
 4tw==
X-Gm-Gg: ASbGncsE1X0dwfIsbPOXYXPHtoDI4DO/ez65+poWyHqXmt20vL3N/qgJF6DxfF2gEnA
 8tIb/Cgni77vhDCZKJoGJ83KUhCfpvPffj95UWzkSJsO9pgRHAYdrkVfTz8DLOvP8HpxT/+h3w8
 xrse9SSm5mTnC0ZjU9YrdIkz6f3cbrMu/E3yyCQj5SH6mllLiVKkwif1RjfMX058t7E7oN+wQOA
 nO+CGfF7UeqVpL/Vs7x/mUM54AoLWohHFLycPm6h1CF5hPy7EOLSLLoABooLlqApRbGkZVBrFZI
 Qi9b6Sic9UZiRJdQrZU6w/X/hg==
X-Google-Smtp-Source: AGHT+IGVCrf9khaUMdx10i5J4p7xh4y+2m02UBNgTwdh5t4J+5DWBadO8NuGIM0KML0+GEkPmVKqTA==
X-Received: by 2002:a17:907:cc26:b0:aa6:8676:3b3b with SMTP id
 a640c23a62f3a-aa686763cefmr121703466b.30.1733685465892; 
 Sun, 08 Dec 2024 11:17:45 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:45 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
Date: Sun,  8 Dec 2024 20:16:46 +0100
Message-Id: <20241208191646.64857-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208191646.64857-1-phil@philjordan.eu>
References: <20241208191646.64857-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62f;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62f.google.com
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

This change enables the new conditional interrupt mapping support
property on the vmapple machine type's integrated XHCI controller.
The macOS guest driver attempts to use event rings 1 and 2 on the XHCI
controller, despite there being only one (PCI pin) interrupt channel
available. With conditional interrupt mapping enabled, the XHCI
controller will only schedule events on interrupter 0 in PCI pin mode
or when only a single MSI vector is active.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/vmapple/vmapple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index f607981bc40..156ea33ae79 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -453,6 +453,13 @@ static void create_pcie(VMAppleMachineState *vms)
     }
 
     usb_controller = qdev_new(TYPE_QEMU_XHCI);
+    /*
+     * macOS XHCI driver attempts to schedule events onto even rings 1 & 2
+     * even when (as here) there is no MSI-X support on this PCIe bus. Disabling
+     * interrupter mapping in the XHCI controller works around the problem.
+     */
+    object_property_set_bool(OBJECT(usb_controller),
+                             "conditional-intr-mapping", true, &error_fatal);
     qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal);
 
     usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
-- 
2.39.5 (Apple Git-154)


