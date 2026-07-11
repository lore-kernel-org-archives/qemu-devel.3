Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC96AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigdy-0003dt-83; Sat, 11 Jul 2026 18:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigdx-0003Yw-05; Sat, 11 Jul 2026 18:57:57 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigdv-0001PN-BT; Sat, 11 Jul 2026 18:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810675; x=1815346675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ma/DwAjwZrLcqKA98spRqUTG7sd6afeYhtmjFkqce2M=;
 b=MmOVFV4j7ToMhTfH/GWC3VI5GuScwXruas5Q5G3J9om/iQktoWFk3wc4
 AKM9HOkU3f8R1D60GRLJ9Hk42O2VXM0tQ7RWy+EFGqS9mtId29lIzfPca
 1YMPRlS94mMNAWaak7gxL/UwNTZDhpIPEBraNBCiQcXy0+kuzrS+qmyKj
 PGrNcdRwXOCAOXBtKBCP+jEYAebi1uhCoGkDs/Q9833b8WdkqhCqvWa3/
 GazcA2YEtCmf5XtW7hS8P2OQMhh/DehxRbTCk1kXy2I0Yr7Mm0sAbTOSP
 KFIV391bQ8JmiAC3G0tHcPoHR9KhNjVYSxlKX4plVEl5v+0iug4zyFOwp w==;
X-CSE-ConnectionGUID: 3HTAobOWSR+ialyx60XHPA==
X-CSE-MsgGUID: ecozqXy4TZKqeVEkBQYEIQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296857"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:57:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:11199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id b383e339-ef54-46c7-9d12-f452bd2223db; Sat, 11 Jul 2026 22:57:51 +0000 (UTC)
X-Farcaster-Flow-ID: b383e339-ef54-46c7-9d12-f452bd2223db
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:51 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:57:42 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 078/134] hw/audio: Give -audio model= devices a QOM parent
Date: Sat, 11 Jul 2026 22:36:11 +0000
Message-ID: <20260711223707.42139-79-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

audio_model_devices_init() is the '-audio model=' command-line path,
so parent the created device under /machine/peripheral-anon like
-device without id= would.

The intel-hda .init helper for '-audio model=hda' additionally
creates an hda-duplex codec on the controller's HDA bus; the codec
is a natural child of the controller device it just spawned.

Both sites drop the extra unref: the child<> property now holds the
reference.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/audio/intel-hda.c | 4 ++--
 hw/audio/model.c     | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index cd4743a405..f51c98511a 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1313,9 +1313,9 @@ static void intel_hda_and_codec_init(const char *audiodev)
     intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
     hdabus = QLIST_FIRST(&intel_hda->child_bus);
 
-    codec = qdev_new_orphan("hda-duplex");
+    codec = qdev_new(OBJECT(intel_hda), "codec", "hda-duplex");
     qdev_prop_set_string(codec, "audiodev", audiodev);
-    qdev_realize_and_unref(codec, hdabus, &error_fatal);
+    qdev_realize(codec, hdabus, &error_fatal);
     object_unref(intel_hda);
 }
 
diff --git a/hw/audio/model.c b/hw/audio/model.c
index bd8ca35153..308b899459 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -110,10 +110,11 @@ void audio_model_init(void)
     }
 
     if (c->typename) {
-        DeviceState *dev = qdev_new_orphan(c->typename);
+        DeviceState *dev = qdev_new(machine_get_container("peripheral-anon"),
+                                    "audio[*]", c->typename);
         BusState *bus = qdev_find_default_bus(DEVICE_GET_CLASS(dev), &error_fatal);
         qdev_prop_set_string(dev, "audiodev", audiodev_id);
-        qdev_realize_and_unref(dev, bus, &error_fatal);
+        qdev_realize(dev, bus, &error_fatal);
     } else {
         c->init(audiodev_id);
     }
-- 
2.47.1


