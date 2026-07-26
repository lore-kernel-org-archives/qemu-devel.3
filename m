Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEC4C53219
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5in-0008La-Nm; Sun, 26 Jul 2026 16:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5im-0008Jo-Dc
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5il-0004P8-0X
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wYVe5coY+/gP5ZW+DnrDyDBSPmW8qWvLqlbb+wP5hE=;
 b=CfFaWNzJyKcgHWJVTS6QQr3kpIHhKTBe9tc2u1zHMkIqooqPSAhBKiwIIYLvREgHk9UOf+
 gJ8is+8wly7qoYh6JkNiHRmlgSLe81beeUTSBpgbVj6wK/vXlNNQDUDczkbJJMFh9a3Ko2
 NpugPZHoDEaYWDIYhInTmcDuFV67kbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-oNRUeo_LOfSNNKM-VRXetg-1; Sun,
 26 Jul 2026 16:45:10 -0400
X-MC-Unique: oNRUeo_LOfSNNKM-VRXetg-1
X-Mimecast-MFC-AGG-ID: oNRUeo_LOfSNNKM-VRXetg_1785098708
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7C5F1954B35; Sun, 26 Jul 2026 20:45:07 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76D5619560AB; Sun, 26 Jul 2026 20:45:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:07 +0400
Subject: [PATCH v2 08/12] hw/hexagon: fix machine->fdt leak in qom-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-8-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sHbc1QFubXFvCqldzNTjZD5Y3aSuMfriFlxuneTvSTA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXGk6SvtrQGOkQAChwsOc7oRmQrtBARLsPr
 glA40doeoSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5ctCEACiiHpn1U1s4n1r6sQSG5lKVEW8A5zMYdjwsHzdcY6oanhHI3iemp+JK0Bhb6Qd7I6HNpi
 TUX2sP5efuZCZw9DR0nHwsUitVvOu/i4IyrGGzaA8vJqEQtx2bKZS+TC2KFzsDFTQXwe/bUWxND
 F1Q69uIyHc4NpC58Bv3lnq1Nzau4pYxrnxfTxNc2HD2GmegXATZoMLukSQQ4C9FzizP4nWHtZbk
 tWBrvCt7+pTAoE7rdSCgnpppGibWM6G1k2hMU0jwNq48AXYZrVtbxD/MpbpZ9iTpCUpqBVQ1cUc
 jsAxwRDK/keseA3ETQO4BvlbNsmaHAVx5oqsqGWk78zS5cj5hGzsE55V2ivRFzxJYzDKXHZ3KrL
 CxVouIUnQhifCpNzDUxa5paf3dv9LGczsgnrgHw+DnrhAOl1WPTxUlKO2A2liFmwebF2gphm07q
 TXaaLPFLCF9XS81I8/zBB4vd2RzKezENRHYPpfw74J9zAVg6ogd9dxJspNwcOAZ/C2NcXtu21oJ
 6BIMwwMWpcomLYqxtM9PtqidOcVCtbsBKUyZSRjskgKDYUBYIqgYp674nRwq+cXX9kyh1gFSe3l
 yLeFthtAjP80MNea+FwR+MGlufwtxTgNPZfRCJp36nmgveu6yqtdWDubgJtGJPfhc9KbIUaqPcd
 qRuBofHkfP3CCbQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virt_instance_init() built the FDT unconditionally at QOM
instance-init time, so simply instantiating the object (e.g. via
qom-test's introspection, without ever realizing the machine) leaked
the 1MB FDT blob: machine_finalize() does not free machine->fdt.

Other boards (arm/virt, riscv/virt, ...) build the FDT lazily from
their MachineClass::init callback, which only runs when the machine
is actually selected to boot. Do the same here by moving create_fdt()
into virt_init().

Fixes: 88a8bc7f43ff ("hw/hexagon: Define hexagon "virt" machine")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/hexagon/virt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index a3638998b873..b75047250260 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -175,13 +175,6 @@ static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
 
 
 
-static void virt_instance_init(Object *obj)
-{
-    HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
-
-    create_fdt(vms);
-}
-
 void hexagon_load_fdt(const HexagonVirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -242,6 +235,7 @@ static void virt_init(MachineState *ms)
     DeviceState *cpu0;
     int32_t clk_phandle;
 
+    create_fdt(vms);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_cmdline);
 
     vms->sys = get_system_memory();
@@ -341,7 +335,6 @@ static const TypeInfo virt_machine_types[] = { {
     .parent = TYPE_HEXAGON_COMMON_MACHINE,
     .instance_size = sizeof(HexagonVirtMachineState),
     .class_init = virt_class_init,
-    .instance_init = virt_instance_init,
 } };
 
 DEFINE_TYPES(virt_machine_types)

-- 
2.55.0


