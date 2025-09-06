Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA15CA1013
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiRv-00043t-HG; Fri, 05 Sep 2025 22:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiRl-0003zB-Di; Fri, 05 Sep 2025 22:14:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiRZ-0006Xq-Ts; Fri, 05 Sep 2025 22:14:32 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862Btna041566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:13:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VCWgUoTRg/k1AUk49wkoQFRWzcXCqr+AZelXZUH2ZBE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757124799; v=1;
 b=Mb9LKHOE4d7dnUuZfJWLY/3080nZZk1K5DYfN8zw6rcWo6d3kX8Vdajif3FrTqmu
 RGLaMlcLa27yhYLG+iOQW853AAxlfsA7WDaaG5agvDj8v5zRxAxtjMaA7k41Lh5+
 mB4u3VwytzA1F3ytFldPs4XjNywaXEXqbaStkX8wl2tYMRwqe7mrVzivSJ7rRJVn
 Cgre/iR7Slo0EpzeeZ7kemPrJWyclDIEdCcFbrGEL1PLtnnGTg0PqkpCpf0/E7he
 u9a9GlApmfSfeQc3E/7Len0lX2K67MUrdTJP0c950cumwFfu4AcWPEU9Et5CPSRJ
 FSC3GnsAgG+kiCBMyoriDw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:11:14 +0200
Subject: [PATCH 05/22] target/xtensa: Fix AddressSpace exposure timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-use-v1-5-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

xtensa-cpu is not hotpluggable but its instance can still be created and
finalized when processing the device-list-properties QMP command.
Exposing such a temporary instance to AddressSpace should be
avoided because it leaks the instance.

Expose instances to the AddressSpace at their realization time so that
it won't happen for the temporary instances.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/xtensa/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ea9b6df3aa24178c8e6a88b02afda5db659199da..63edc3a5b2778c8379a30125481f65361655fe1c 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -243,7 +243,11 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
-    xtensa_irq_init(&XTENSA_CPU(dev)->env);
+    CPUXtensaState *env = &XTENSA_CPU(dev)->env;
+
+    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
+    address_space_init(env->address_space_er, env->system_er, "ER");
+    xtensa_irq_init(env);
 #endif
 
     cpu_exec_realizefn(cs, &local_err);
@@ -268,11 +272,9 @@ static void xtensa_cpu_initfn(Object *obj)
     env->config = xcc->config;
 
 #ifndef CONFIG_USER_ONLY
-    env->address_space_er = g_malloc(sizeof(*env->address_space_er));
     env->system_er = g_malloc(sizeof(*env->system_er));
     memory_region_init_io(env->system_er, obj, NULL, env, "er",
                           UINT64_C(0x100000000));
-    address_space_init(env->address_space_er, env->system_er, "ER");
 
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
     clock_set_hz(cpu->clock, env->config->clock_freq_khz * 1000);

-- 
2.51.0


