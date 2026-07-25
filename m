Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8DEC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncvp-0003bA-MW; Sat, 25 Jul 2026 10:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvo-0003at-Fb
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvn-000531-6r
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wYVe5coY+/gP5ZW+DnrDyDBSPmW8qWvLqlbb+wP5hE=;
 b=d8Qmk8nN837mZ95x4axckf5o1YDgVFCYXvM7wucySuJWz/Djk4K1DS+cqXZGny0MHNJr2B
 2Qr451o5kEhknjy5oKJbjpL0pNJ8Xsbe4i9JxrU+GGp1q5qva7uruf7J6oMFSpG46jTkl8
 fdjt6ouPn7jcOdDA8N6VoX0I5oBGuOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-HSljVq6cNuityrvDnuqJnw-1; Sat,
 25 Jul 2026 10:00:41 -0400
X-MC-Unique: HSljVq6cNuityrvDnuqJnw-1
X-Mimecast-MFC-AGG-ID: HSljVq6cNuityrvDnuqJnw_1784988038
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2631195608E; Sat, 25 Jul 2026 14:00:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B4F3190BAD8; Sat, 25 Jul 2026 14:00:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:05 +0400
Subject: [PATCH 4/7] hw/hexagon: fix machine->fdt leak in qom-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-fix2-v1-4-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmccR1sOhKJLjubdgeqiWoOQhkY4UNOtveg
 jPMRqeZwE6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5YaZD/0RpfmrTuzTydjwDRCPi61LJoY4ZXv9qHeMGA4RKwU57PH/dDnYoYLk/n7TuGOLNCOweT9
 P1GOBp4WxUp8P9N1eigROTqHwWqbawa7o8OHbMi1RXkUOkR3IVJ/VY/EbjvTw433iTR6ibsuhK0
 42hUVCgzCyv988GNwlKsh3xKAB5FvWN2bsq34XYZW8Drev+lgF37VsxqvCJZVHntUL6vL7TcSrZ
 JH1l9jpMT0F8gRYXX/HMKv7VSqiupP6MAxwm7Z6tusmHsZrh4oRC2JME79fDaTCXO5AEi+i/A31
 Nxr7a6eSmnWdYHON5DcmzLR8VkL2GXxtq7n9EyKHpRajp8+pLL50ZcgFx7pe0YsEZOmV+GLSSy4
 W3ytHVKnxpy7exY/iQpLW2GR4FZQC5DE5JsduCVXxqvCoaPNzCLm4alsocU/4DEciWmVMcKEQVg
 D01+2k3Cb9GUv5ED37Zq68KVOlmoxEB5MSP5E2YiNoSml5sCA+uma3hnZcDnXXe3DEBHvP+g5Ww
 c2Be4LvG7EY4iHaZoPppaZpDUkPPMAS0jMLSga8Qm/NIrhi014iYVUtdYu/XyVat7w3bDliLTUV
 rTvSjo0i8g5zDi2kReYPTOE/u6nWLYGhd5mij3FPqsqH6Z42NpZh5uN2LU8XAVVpDQP3GTZcAxT
 NMIfYli77pmQn/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


