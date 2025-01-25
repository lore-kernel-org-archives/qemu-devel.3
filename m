Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE489C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfL-00089M-LV; Sat, 25 Jan 2025 13:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfK-000895-4n
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:13:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfI-0004C8-Mh
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:13:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4368a293339so35389195e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828831; x=1738433631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/se+ZOUWHI4guWWCfgPKU8ovKC99g/6LRZidVGKe1oI=;
 b=GknMRLSa0TwPL7aGa+NUapTQsmVfLpYvkuIwl9e3cChzeXZKOw3zwYpUhiD7mwsrQa
 AaHaHMKF/Ur92+Dkj+7ZTPHHllsL+jkSNbQ88UwFgsgj1XWbllYpIUejAH0D8h4KfbKy
 pqnNOYSB0j4GAjEk5deYZ2obM7SdFoh8fkVjqXeeIK996XlVil2bmTd+qLaX8yWeL3mW
 KLywr33aSGfLxqeGRVOje2oMc220F2Z8xXCw2276C/vUSkMOExAWgPYBDwwX6OFXpQ8E
 oUV15Xt89TB73ujlZGqKPHN3MmLOz1LYyTCxTdR/oCfOMeoTfa4B/T0SVtlJ5NDgFq7s
 xZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828831; x=1738433631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/se+ZOUWHI4guWWCfgPKU8ovKC99g/6LRZidVGKe1oI=;
 b=Tf3sa6fEtE7QUtPrI6Sghy5xypFxPMSrFQkUw08+1u1P/Yu+mbw5DTmNdK4AYcHuFd
 5aAKlJcozy3zdRH8apB40zwwDS9bhokweu+u7mBFwFe3Hi2IzWnojpEgNLUetoet3Nkw
 TgCRAi+4sehgjY1KuosFcSTo3iAiQXPc4/PdmSZ119ipzhlCDnY0S0azWwMSEhebmMVn
 ifLF2QuixtReF1G43i9Ey79NJQhGjLyWce/qpgvUgC0NoILCyz1gGEAaqZ3sTb29nBcI
 eFMbhOKJUyxcyhO82vCGvQoS06wLQ6XILxLoWzzQzja/1F0nJzNeuYwo493lz52P9OWE
 2oWQ==
X-Gm-Message-State: AOJu0YzCirW61FgRxWc0a9TfnUFk2hZwR2UDFMt1tCCjXErVindzvfGZ
 7AG4007d2H4iXrwx75aBJPQeWS2hj1bSFYMPN9pzGjwIVDPdDPbdvlcl+4o8Yh7Jdm/q1A2mI/v
 SRZs=
X-Gm-Gg: ASbGnctqgdsZWp7DN4H3AseGnbNQfQd1yIoNFbvOxAMnQykScCCzCVH1lftfBxkmIwd
 RHbb5guABQmhyfgfZsBSNMdbrvtXV3JkTloU7l+jvpDM1OfaNWCuZt/Us6eSP5G4YRSUAgR7qMB
 OP1FUcY1CpyN0vq75tK71+cGrHWD0O/d1Es9D+hdDpIrU1wADf0XFW4rOSiVqm37ZwE3jo7gr/6
 2KmBmJENvF9aIEun2i8qhgbQzn5ZVN0ErDxSv+FaHQFi+QG4CR/WOOgg13qgUEkbc3lgUAofaWw
 tB1v+pp96yoUk9mWNze3F9YU23swdk86NE93uMY4UIPYFY96LfDNC0IQB5tF
X-Google-Smtp-Source: AGHT+IGP2iaXKLI15CkhKDP5NBlnFOMSHwCbGSNXKLvJxawalslRdLF5wYi0CoJhDHevjTYCGWh83g==
X-Received: by 2002:a05:600c:3d86:b0:434:f9e1:5cf8 with SMTP id
 5b1f17b1804b1-4389143c306mr335517805e9.31.1737828830945; 
 Sat, 25 Jan 2025 10:13:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4e49sm6227077f8f.98.2025.01.25.10.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:13:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] hw/sysbus: Use sizeof(BusState) in
 main_system_bus_create()
Date: Sat, 25 Jan 2025 19:13:35 +0100
Message-ID: <20250125181343.59151-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Rather than using the obscure system_bus_info.instance_size,
directly use sizeof(BusState).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9355849ff0a..f713bbfe04f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -323,8 +323,8 @@ static void main_system_bus_create(void)
      * assign main_system_bus before qbus_init()
      * in order to make "if (bus != sysbus_get_default())" work
      */
-    main_system_bus = g_malloc0(system_bus_info.instance_size);
-    qbus_init(main_system_bus, system_bus_info.instance_size,
+    main_system_bus = g_new0(BusState, 1);
+    qbus_init(main_system_bus, sizeof(BusState),
               TYPE_SYSTEM_BUS, NULL, "main-system-bus");
     OBJECT(main_system_bus)->free = g_free;
 }
-- 
2.47.1


