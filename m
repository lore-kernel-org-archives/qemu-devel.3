Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBB9FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRur-0002sq-R3; Mon, 27 Apr 2026 15:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRua-0002lu-72
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRuY-0000GU-Lm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21tqP8lo9LBFSvH7A6FrcFDu2dSjpwHDzyS3XvE13w8=;
 b=R2eVyqsD360L99In3+ml3News5eF/OqHvayVfFDt2PKEVdyTkZdBRXd0QTLHk9ybUACIsk
 dgiIvvLSENJqNCaJphifMP/uP5mnODNiegsEbUnGaVrm1r9vEY/55sooXZFGHRRZZwp9Mr
 pGd/764wIFk1tuCrDeQetb8LdHtqHSA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-rl599GoVPO68LvpiNffp2w-1; Mon,
 27 Apr 2026 15:46:25 -0400
X-MC-Unique: rl599GoVPO68LvpiNffp2w-1
X-Mimecast-MFC-AGG-ID: rl599GoVPO68LvpiNffp2w_1777319182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E560419560BB; Mon, 27 Apr 2026 19:46:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B01B1800664; Mon, 27 Apr 2026 19:46:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:38 +0400
Subject: [PATCH 39/41] hw/riscv/virt: free flash devices and OEM strings on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-39-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jKlBV2vW9MmXkiDj0aUyz1PT6pjDCbRhdhlP2u5ZfZk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wWrBOjNVGMG8NnDAHrZQTa3DrhN2Eh3pJhD
 NLOPtOzJ0iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FgAKCRDa6OEJdZac
 5XYBD/4va9fk8mS/iZgqHaK0/86XuSW7lHtQ5WAV6LpWmskhApa+J/mU87vD9WqgysnhHQ468do
 12diWTF9Avk8iKXUXteLBoG1WE4oMA/hcV5LMIzFAuRVSLcyB4Jmh5jq9UxvcKCfsaaELYrzNOb
 T85l7ok27K1F5LCAPqXJb19NNknc270Rs7YNPtDjscdSTxIvp+H0abuvmq6QjC2fMNweQICk228
 WwfQPYI7NUvY5C+pyYljg/AEbKD4fI0Deb5hyMNAK+Y1tt9NU6ZS9UdmLnA7AUn8yDJWBxXhPaS
 PV7z02nun18JHQ5QY+uisY4+R9sCKjL3ZLK55bCxDm4jDyJ/vpNoBaW0VwTEsINRVYcdNFbVyh3
 SyDH5tmuLwjiRqFWwtyZV2xYJ38xoHIlwRxILVopETvgTVLWX7swRJ2kK+70whTSQXArEmz+4ur
 JjXzrazKVVjMgDSE2yd/QHy5tyMZXW6c5qMqhjouFzJufsZKa7oxHFi3ehtaDUlAdsAY7rZsnvY
 U6MVJ+KPFAsVzFWP6qc6obG+G4U34eZAJoY3wuQxgCVBg9ThhrbXKDJLWYY5jSsbFYbmLb6OqiF
 jK+6i/tqVOSkOaqLE0Co7B87Qoy5MoGqK0JO/5GicbV/G23nzB8/1QRDM07+YfiKJzii7r03dlJ
 UX0VuL+lSxTLpKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add instance_finalize to free the two pflash devices (when unrealized)
and the OEM ID strings allocated during instance_init. Fixes leaks
found by ASan.

Fixes: 71eb522c4063 ("riscv/virt: Add the PFlash CFI01 device")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66df..315049bc86c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1745,6 +1745,19 @@ static void virt_machine_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
+static void virt_machine_instance_finalize(Object *obj)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        if (s->flash[i] && !qdev_is_realized(DEVICE(s->flash[i]))) {
+            object_unref(OBJECT(s->flash[i]));
+        }
+    }
+    g_free(s->oem_id);
+    g_free(s->oem_table_id);
+}
+
 static void virt_machine_instance_init(Object *obj)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
@@ -1984,6 +1997,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
+    .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },

-- 
2.53.0


