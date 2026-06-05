Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F48CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkS-00072I-CL; Fri, 05 Jun 2026 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkI-0006HD-AG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkE-0006bS-V5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HsSS9H0XnFqDg98btc/iipFx5pPynADB1oSYq6cxGQ=;
 b=TrAiPpQkCQG4jC5fu7CVv+4grdsCPeg9L0EdXS+J+cw8YJtTB7ucV7rJhUf9UMtnadNBjt
 nLrhnNW1Dq+CCQjb3Ip4SSef25jjJni5Dv/fmP4g3PjI0pXVYl+Xos4U+GcZutzXZrOIzV
 txVenKRZo2hWaFEETXaqidtiu4ukmVw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-JZiQhlI8MHaSDdHhoP0tdA-1; Fri,
 05 Jun 2026 11:45:59 -0400
X-MC-Unique: JZiQhlI8MHaSDdHhoP0tdA-1
X-Mimecast-MFC-AGG-ID: JZiQhlI8MHaSDdHhoP0tdA_1780674359
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20689180048E
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1874D765; Fri,  5 Jun 2026 15:45:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:37 +0400
Subject: [GIT PULL 17/23] hw/tpm: free PPI buffer on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-17-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5CtS+EWJo3M/jWSkTkfccFTnWRkzlJxRsPCSKv4FqPs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VnS6p5r3bLN8trD0H3643Lj8IIOUiX6lML
 b4qow9YpnaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5UIoD/9dfPjJ6ROD5KSSe1R3CkdVfQi8Q7ZT0Ka77GfKFxyv+FnoFDCKOvy7DncBXIGbYI29cna
 PsNOA86iT9suJrNknSmYPRjw8qyd1DqIqAEo7+OGkRov8PDuiRWrG8eSCaaPGybnJh0ZJz97GCq
 /7ryvk0IyJJxqMQsZWNgVy0++ad7uSIcHjjz+anZkmqbvtrl4dMZwKrcW0Qc8oAvDrmRA18vox4
 TSpLEO39KOBqrMs7PMwuVfRH4tTXJ50Zzef5lRYW66cTxGr2Sa2VfCpPo9e3HBo2S9t4JbyjF6V
 dyq51SZpRKL5VLIkN3U/e7h9KMwa97aFNg8muXud1h8cLZgl5ZKa4MT2zTuqKvuGwCMVJVaPJ4L
 sKmESGZWho1JrBnABAkUxO0FtgaLkg/e4tN1H3h2hXDsCvhXtyN9Y3+pa1/aWqyo4RlXCAKkxea
 rJcTUVqmSyS+o/nZ/ChgN/yyY2kacLqboUJSLvu0ajPusgTdgPznGQeX03DZtPmcZ1vcuIgc0m1
 ugwqV7fO2irL7WfVe8MCD9quLSeyKTPGlLL5bBmT1V54nAcMjac9ujVAm7Pm06Z32la4/DInA0p
 46thYBMraPVU83t2sduttwIcXDQJ7xKMYqjgQ/vznzxrLytblxC2dbxM5uj/77Sh8M//fnzEawO
 5KJ2N0cdc7JGERA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


