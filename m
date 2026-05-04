Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC5FFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrd6-0005fz-Qa; Mon, 04 May 2026 07:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrd3-0005Tn-BM
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrd0-0001E2-NB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVBuI+EbJBte7cudwIUDMDVUZlvs1SZgaSQuqt1SPTs=;
 b=UqlYLBPabTfy/Eo13lWpxZnaW6zFyaYkXW8GuPVs1oNqaGDVGm+grawwkigINmbiZBvIRc
 F9MKOJs2yJ5T+aShRYD/KPlcOmZzHhLnk7RTCOtsqEzLrTDcOb7BP+xbS8CyzO9tb/ch7S
 y7VSXIL5zAGeqIXJ3pQ/NeeG4FSxdmk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-mANkXZGIMmKkzw6VvpauBQ-1; Mon,
 04 May 2026 07:38:20 -0400
X-MC-Unique: mANkXZGIMmKkzw6VvpauBQ-1
X-Mimecast-MFC-AGG-ID: mANkXZGIMmKkzw6VvpauBQ_1777894700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6881195606C
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAAEE1800480; Mon,  4 May 2026 11:38:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:20 +0400
Subject: [PATCH v2 32/46] hw/tpm: free PPI buffer on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-32-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+gbtJ/99XwN9Q6M5HxsUiEi2wFIXez1EC/KRfHjlUrQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtYTmF8+gyP72Dd5S8PuxtBhXsxpTe6eXQ3
 SnGgW4VnyGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5fAjD/4/BstuHa1Wyv3+WBmBEPEga/Y/nAduf1UrVa4DU6CYB0w4lbNIf3RVmoYX+2bz3uFgvfi
 Gbc5jTMlP6bqujYi64wQ8nZfn4IAfyW0nVHTTFLfajRHChuU14NhAHqghX09UAYK6P2FfI3iyx6
 xlEflvCZJXdcZNde4X+q4FT+S9PGa4MtcWJn6PlBrwcSvGHRhEOWv0GsrJogx9aYUk6/9fKWqZh
 LPNgfy91uu3Al8KcR3YdpWp+66qzDjQJtgXbTIQO3XTiKBCkORa7ADijXjcp3lqDQ6lkiDdwneP
 iUn4znghYJKkaU8Uo8f1YEoGkF6tPqhKpn0bKhvsRza+sCBqK99lxZohBobyzUeXBzeKBdMhWS+
 zipbUKnI96bDoark9hu0WhMXNEDB2APIn2WoH4ht/r+v6ANHVuxp2Rw+ADbtofiVaK4PBZJfXRE
 f6ZRb6H0vPVQrHmdZBJcddFbUizkEYbran8FsmOBNIYIn232P+q1RL7cda/pYwdDMn3cQocRyT3
 H1QZlmTggT1C672gm2bT05kvn3VvdBdK1Vjg+QPqtBuR64imZmCf5j92glexxMZ+aKyId9L6YMp
 lRy2NQywR2x9ycxKcnfgcd9GZPAdpyysv+bqn+hpVgilztKM2VHioXKJ/nSCRfVHqPj0DhH4F8d
 XQjGPfmYAo9GAFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


