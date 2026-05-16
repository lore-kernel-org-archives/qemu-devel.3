Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C86CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xN-0000KP-FB; Sat, 16 May 2026 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xK-0008WV-Uk
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xI-0007mo-Ux
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVBuI+EbJBte7cudwIUDMDVUZlvs1SZgaSQuqt1SPTs=;
 b=NVhox/SOfASvPAYe9iH3vlRizXy3qbo7RaS5rXWGwgJe34UTChEjHnmwjvSK+TRkCOS6lp
 oopI762KoCOGI9UiZv0Hb+S+UYlM/+LLJtdwHe7RvMrPwawY0zITr7B9FUsjMpasp0FCgh
 knqICj+82S4ai2babwUUmQb621moh7A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-csKsCjIyNNG7MpOcuzNLDw-1; Sat,
 16 May 2026 04:01:02 -0400
X-MC-Unique: csKsCjIyNNG7MpOcuzNLDw-1
X-Mimecast-MFC-AGG-ID: csKsCjIyNNG7MpOcuzNLDw_1778918461
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D795F18005BE
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A74CF19560A2; Sat, 16 May 2026 08:00:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:17 +0400
Subject: [PATCH v3 18/24] hw/tpm: free PPI buffer on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+gbtJ/99XwN9Q6M5HxsUiEi2wFIXez1EC/KRfHjlUrQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPP3nEtnDdW5+6p/1SiUp9CFyGisVLWDjPK
 fCBSgHNoSWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5VZID/9e7nqnhbv7ZqLFQ8Er+JlATKnq9UOqTl1DSXBTudwhNMfQVt2PQWN7uHUVIVEEFAkQXve
 3B7WUn0aKIhlSW+HPgU/r9RQgTJcREzCr3Wy+urDMQrMVZcoRacnmRYFSOSG5wtnpydmySMcGWr
 m7yylywJBvSx9SgkSlQAObqtaLb8Ty864A8XW2iMfMF5dUUDOkFO4596vo193WpqZ8ZqWzUZLNl
 wICa9pQctBfpnTNnhySJcradUD4txWTnNh7OSroilCncO7GxraJ3KM/CG5c4X6F7SY1LgYgORk+
 xWCehR57haX+WHDZSOrzthlDAGtA75RkEL+wQoiF50NYmZGSA9WEaNb01pzRh5h4GdibbaX6Ry4
 nqdVfvYMwxF9Uw4Aqr1KQBj9xbiiMxlkQIDjKjSnnPbc6Et4c24jAPLY5hO0Llphajn3rJgo0Ns
 11tCERwQIwXG1ZVbngOY1HOLpDE07DG2EtoknDd/BRiZ49zvaKWimxqU0tKnrKWgedI6rTSRQCn
 +v/w41uigEA+AQCwktZAbtQ9oVUDBWHt2QsxKCDYu0AIUJ8lqnZy9+3fQ+CZiWRra/2h6SfT09i
 SBp+EU5r67PSCzO+4iEo2zsnJ5nhmS6hs63lcuUIoH90Wtrrl02H8XRhzhU2ZV1HzVZHckUCdzn
 2Goir/rxJYiWeDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
index 6bec30c36fc..3984228c42f 100644
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
+    .instance_init = tpm_tis_sysbus_finalize,
     .class_init  = tpm_tis_sysbus_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },

-- 
2.54.0


