Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBEFFF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRts-0000sB-Av; Mon, 27 Apr 2026 15:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtp-0000Xi-Qw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRto-0008S2-CB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zwr78nSyzsd0DrKYZjmxnd5WP2JnUPCWfhydW/PE7V4=;
 b=Ys4DuV4iNqd9xgEckAUwPGosNp389MwQPkXj5HMTIZs/JqBLOUJxcfywPGhSVNuRNM6vnF
 yIhj+ucRJ/nQP6KAwi9EmjPsBzQ5WjyiaesBpCb6ouuB072OOzwV3WQX8OVQPaA9ETQkA6
 tc5Xt7qzeoxpU+Z8GfjPVAK+XsLZEoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-3VYbIdaWPZuPSMTDml-vpA-1; Mon,
 27 Apr 2026 15:45:39 -0400
X-MC-Unique: 3VYbIdaWPZuPSMTDml-vpA-1
X-Mimecast-MFC-AGG-ID: 3VYbIdaWPZuPSMTDml-vpA_1777319139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F9E180034D; Mon, 27 Apr 2026 19:45:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A25619560AB; Mon, 27 Apr 2026 19:45:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:31 +0400
Subject: [PATCH 32/41] hw/tpm: free PPI buffer on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-32-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U9Mzlvq0rrjlmHM8sXAmGAsGCpP4e3dRZe1kgmOmuHM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVDJwLi20apizk6puKvICJAKyj3t1kRPDZ3
 HhkiYxNrbuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5Zz5D/91pAuelqe9FJFUKfA88vofp5pVr+PVjRqjfFbDYiXdq6pmbbzfk3OL8U4pAxbzMFNGl1k
 OG4wkTO4SVOICrWW94i/hKDB38BBypqupIfbi2EThhyrTaWqnnjEewNgfpBqog2hEPVK1bXN+1D
 hiD2Dsm8enOevm6LMObEa+4AZrhOTsLz2QGoVNtSY5fkQ/vcgxMnkLjCP2yzHPSBndmYfHRy7mC
 APPTamZf+la66ZcuVfC42RrJGkl51NZ0cAZTjMjzdaq1fh4J+qOzemOywGBk6RtFkjhMEKaRQWq
 qz4acAexpo31TFMUoBO2dJoU8hm5TatkCnbKZI0qA4wWWpWlV1S/ByW9vXG586bHv8XmfybzD12
 b1xhWTCqMYu9DMw4PahmFBTq1lCdh+3/37KwB0GBxYcUU2p/prJzDvk0vTfRkH1S/Nd9sHit/GO
 tKKRcwlwmoyIQxrOTT9Ly3x0aYnZUGMsoKyoNvUtKQQOA1PhAec1ycfj2sT2ZDZpDHhEkKvE2/b
 ha0xvP31EG7RPpOW//3uX2MFPNi00vZ4DuhlnN0V35rhCU1MzXU43BZtqPmNwp2wlCFPt4yWR24
 edEs5GynMqQeV+HHnJDEGyARvDNJe6Ek9LPEhDO2ozCdQKiAI1E/ABOF9IgkcZngMbV3+VY1pHk
 gOL9WKSAD4EsKIg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PPI buffer is allocated with qemu_memalign() in instance_init but
never freed when the device is destroyed.

Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36fc..891766ee03c 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
+static void tpm_tis_sysbus_finalize(Object *obj)
+{
+    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
+    TPMState *s = &sbdev->state;
+
+    qemu_vfree(s->ppi.buf);
+}
+
 static const TypeInfo tpm_tis_sysbus_info = {
     .name = TYPE_TPM_TIS_SYSBUS,
     .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(TPMStateSysBus),
     .instance_init = tpm_tis_sysbus_initfn,
+    .instance_finalize = tpm_tis_sysbus_finalize,
     .class_init  = tpm_tis_sysbus_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },

-- 
2.53.0


