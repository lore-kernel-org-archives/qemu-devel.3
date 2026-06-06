Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA86CD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPJ-00044d-Tn; Sat, 06 Jun 2026 01:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPH-0003qQ-Pb
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPG-0008Kv-8q
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HsSS9H0XnFqDg98btc/iipFx5pPynADB1oSYq6cxGQ=;
 b=bEWi47XFjORK1J9M4J390xiU//V7pmlbnIqo+vIC93kX+D49wx7V+viUVGg0GJyRlSltHd
 HF2vY7/TVRKb/cM3Xe4eJDaDI9rS9H6lw9m/v0Lao03Eecw5eEA3Ui8eUSKtzPxUzvDadr
 88nQvJlYiL/DwaLgYgZusUaeV6bVOl8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-Hsz2wV-HOQGDq7dr40xs7g-1; Sat,
 06 Jun 2026 01:17:10 -0400
X-MC-Unique: Hsz2wV-HOQGDq7dr40xs7g-1
X-Mimecast-MFC-AGG-ID: Hsz2wV-HOQGDq7dr40xs7g_1780723029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E2081800358
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5B51195608E; Sat,  6 Jun 2026 05:17:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:49 +0400
Subject: [GIT PULL v2 17/23] hw/tpm: free PPI buffer on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-17-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5CtS+EWJo3M/jWSkTkfccFTnWRkzlJxRsPCSKv4FqPs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1CIhBL/yonnrB+fZWX8YtM8Nds9tzB8LMd
 xcDtRWoFbiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5YAZD/9tVhnbJk/LBgH6qKoiAgQ3lwq0UfEBc+PMnBqGQ+9j8ducKxvGOsiMUXLxtS+l8q8wIK9
 LYbkFyR3pnG5g7SfyhP9Na7oA7SYmWywgcFtBGpZ5+z8UJEGsI5Ualk0+rl0ck8MXQi9scJnKm9
 7hE1rNR+c2RR3XY8kiVHYPWd0yx4JskgKSpfdjvHt0jpERkKUNhp50VcZKq8KZis1ruHAroQFlt
 kx0xaP/ZdGVjIdFHNYVWFGxw7kDtTwQ9WhNHUqa2x0ACUKkx0pEudWnD+zePJPQuTGLoysua98g
 376OfPqu67dPxL01WQkE0cIok0xkyklcz9LpAn+RlTmWvnviNtKcd7rdfBq5AxPYSbnJSC8c4eu
 QkTAcK2oz4EAmCG74sOneie6MclSKVZsvvAW0yEhWdFjfG83AfYNjiOTYxtYlOYroq2m2TwG5HD
 78tPGxGbSz+cr1IkWud1s1zaJGqkfFyArG+tq0Opp1Mi0vAltgLubMOZeQHDpy1WmuUPCBg8NU7
 q4m942/5Rr+otliyEpBO2O3Uw5mc4Ia/ZDKS/D91WHSyCG39yVplt8XZldRkwYjbtk5YFrv2Mck
 wDwnR5I5ovhC2mbURfd4U39iD85dHHTj+Z6lheWTVnqkcRPqlbcXJ5w5aYu6UoXwtLJkLdGXySZ
 gb+kApCn31MAK5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index f9cd1c8b5c6..16bb17874b8 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -148,11 +148,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
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
2.54.0


