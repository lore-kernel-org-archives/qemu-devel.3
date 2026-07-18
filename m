Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA70C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD5s-0006d3-EP; Sat, 18 Jul 2026 18:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD5Y-0006MH-Ua; Sat, 18 Jul 2026 18:00:55 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD5W-00059H-67; Sat, 18 Jul 2026 18:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412050; x=1815948050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qmO8d/rDXj0cALhLa0MQcV3mYO09GhDUo5aekxJsoCQ=;
 b=Hc2YYu34wLdUPKQmozlnvFOFa3I5YTfgP+yqAqCh+8h6g3G/GPRVzMFu
 4bSNYvSmAZ75hK/G99MDcnrd08EB1IX0jEBd/ja24Z2sV0JfI+Luhz7+L
 Ta54VP7qSLKqLm7fFGAdkvunzE7o0SWUE9H+o6re/QFSwVZ0oDVllVALF
 W0Msdfe//EYn+CvuUAU55PfI0ey38kmAalwQxlCb0Ft2vCt2ZHW4D9bHr
 ELVH8AJvQi4Qi9uXEEI1mJcyvNI9zG2kHUDwt+hCYNQnINXFjqBSb1PPr
 VbUsGJ2L1p4GqobHqqbsWIY8615sDHufGS+/INWcZoyQx3jvYuHgfGwft w==;
X-CSE-ConnectionGUID: D9Yy9egZSK+Cg3adSv38EA==
X-CSE-MsgGUID: lCOYz2D4RcKdNnn8U3il5Q==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23940282"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:00:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:12516]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id 6ac860b7-bfed-4bc8-848d-9aa050ba6359; Sat, 18 Jul 2026 22:00:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6ac860b7-bfed-4bc8-848d-9aa050ba6359
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:00:46 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:00:36 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 085/137] isa: Remove *_orphan() creator variants
Date: Sat, 18 Jul 2026 21:36:00 +0000
Message-ID: <20260718213652.37673-86-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
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

All boards create their ISA devices with an explicit QOM parent
now.  Drop isa_new_orphan(), isa_try_new_orphan() and
isa_create_simple_orphan().

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/isa/isa-bus.c     | 19 -------------------
 include/hw/isa/isa.h |  3 ---
 2 files changed, 22 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 7a6a595ce7..22452e5048 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -172,25 +172,6 @@ ISADevice *isa_create_simple(Object *parent, const char *id,
     return dev;
 }
 
-ISADevice *isa_new_orphan(const char *name)
-{
-    return ISA_DEVICE(qdev_new_orphan(name));
-}
-
-ISADevice *isa_try_new_orphan(const char *name)
-{
-    return ISA_DEVICE(qdev_try_new_orphan(name));
-}
-
-ISADevice *isa_create_simple_orphan(ISABus *bus, const char *name)
-{
-    ISADevice *dev;
-
-    dev = isa_new_orphan(name);
-    isa_realize_and_unref(dev, bus, &error_fatal);
-    return dev;
-}
-
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 79bfe16361..9bbaa3c258 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -86,10 +86,7 @@ ISADevice *isa_new(Object *parent, const char *id, const char *type);
 ISADevice *isa_try_new(Object *parent, const char *id, const char *type);
 ISADevice *isa_create_simple(Object *parent, const char *id,
                              ISABus *bus, const char *type);
-ISADevice *isa_new_orphan(const char *name);
-ISADevice *isa_try_new_orphan(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
-ISADevice *isa_create_simple_orphan(ISABus *bus, const char *name);
 
 ISADevice *isa_vga_init(Object *parent, ISABus *bus);
 
-- 
2.47.1


