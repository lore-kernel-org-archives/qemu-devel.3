Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C355C54EFC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtK-0000eH-LP; Mon, 27 Jul 2026 07:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtH-0000LM-37
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtF-0003wt-Fd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPm8Vf4l9uf9AJqUVHnAtIZ7hNE28mt3apZFpqXO+vQ=;
 b=LLui4kVudOeMZTGDr+XPlq1IYJCf9YdaVCM5Er3jnvLZKMeyGBC/ZlktsHwPH9oraww+BN
 yEyLaMt0Ri98+JoAd4eDH6innjzn5/Bp1hDF1KbF+k3OWoUUOigpJO85NELF16tXFHONnR
 fDCz7yWMyLOOnQWWH+DO7TIR5CTr5yc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-2z9ByVa8NCuiHHV5dT-OnA-1; Mon,
 27 Jul 2026 07:52:57 -0400
X-MC-Unique: 2z9ByVa8NCuiHHV5dT-OnA-1
X-Mimecast-MFC-AGG-ID: 2z9ByVa8NCuiHHV5dT-OnA_1785153176
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56EF81955E86; Mon, 27 Jul 2026 11:52:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C77D180034F; Mon, 27 Jul 2026 11:52:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:24 +0400
Subject: [GIT PULL 15/23] hw/hexagon: fix machine->fdt leak in qom-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-15-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qAXGTuubxIbIhkEEcJPIbjJTilc1xDRew6qMQFBSIOw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/IQB/oLY+UazuWcsrdZKA1Z4N/KK6M3M9I
 trjt2Z81c6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5XQ0D/4pL6JgDTn9gkeyu7gyqQ5IYVlns+ITsjzsD4auFQ5oOejo2zKW5l1sAA5AyL4wzBXqrkn
 Zs7EJcWjAXqr/dyc836QzrgKNlz3ucmZmseChk/4Zr95DgsD0kdh4lvc0N08km/7wQM/mrkOzOn
 IVT6t3a0XxCSGCvYNfPSTtHaXvvZa9K8+NOPt8Jbvf9XQhiXf5DvYSHTCFQFwev4gls5EKPDaqj
 om4SbubzboTwxlWG1DmTAxRqGUJAbZCrckLFGEnKXsRiHTMQcWr/g9i2yrUWacs60Oq5B0JRQH0
 mm5xs8TbQFLIpOvrIIRSq1F8MvTKp5M5ERsU7tvFP4zXUI/nfRVFtXvmcohGW3i1GKmSf5L/Azq
 qgSnudvxpK2uE7F+e6ZqhUQ4m8gvzXqBENwUoX5T7lAPStg7oUpZzCpX3ZumzOCVDxknNzrFGJE
 fqe+pJhoSjPHAct4cFVAzuLRVHzVdHv7skoaKMsVtTD+gUc8P55qajhgDLp0Pa0C/avYKH9bxBv
 lUsQdVSQg/rZK9RRY6ZqLpPAKRI1KrJOjQQeyELHlqLMAo1f0gjVfC/7RCP4cmOwBJPAY5g57D9
 h6djO/x9QxJ5SKEqboyK2ZN+lz7D6nfnp6nAK8cPXI37MrGkT3LTr7tpuhL9Hfp0ifhITO1gos2
 o3lAhl8R2h18+hg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


