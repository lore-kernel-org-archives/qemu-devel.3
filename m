Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0819BFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtT-00063C-KM; Mon, 27 Apr 2026 15:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtL-0005aA-VR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtJ-0008IW-OD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDtpaZFoApAnKThlAbsCdyTdSRS0TaBslbFfhxXNOYc=;
 b=EryZjkP2JD1+dQy3gDDbGEtPNcPtcaB9g0qCI9jMrxMKv/+lIKhG+qmDZcXTgqABejFcUf
 j9ldWCBGiS/d6Yu0NdNheKNal2vAkqFY4AsOjsSaVAdg+fVrpfydDrZNxq76PG9JPrkRqj
 BWi4+MxpOCdUuN4+6JlA6Q0fzUZ/OnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-iMw9gmEtNXW4_wLa3d5IVg-1; Mon,
 27 Apr 2026 15:45:09 -0400
X-MC-Unique: iMw9gmEtNXW4_wLa3d5IVg-1
X-Mimecast-MFC-AGG-ID: iMw9gmEtNXW4_wLa3d5IVg_1777319108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A64A918002C0; Mon, 27 Apr 2026 19:45:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 439D11800349; Mon, 27 Apr 2026 19:45:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:26 +0400
Subject: [PATCH 27/41] system/qtest: free log path on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-27-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oUcgYvxDMbjcVVL4+rKdZP5X8MfYcAB3srIVB+yU/jg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVdvi9M0Yk1HEjYko3i4AiOzhd0AUA6WlFM
 PcBHOgYyqiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5aKdD/41g/ze5sZI/CUX4VbJs9QyTFQhupKv7Hg0GMP9/C9C6bNjX7eYHBykzA4vuXuQ0Ifqo5j
 zIZRqkL4CK+Jzooni7ymGLUHLnfIFROx6xxls9y/D1PMKcXPAYJAtC5Vwyr+/TyJjgPc9gY8H02
 I1Djrsp1J1S3o6bLOq1nmzVwwXGbOEDPnacq098H9AnVaZ4dbEEL+2U2k6BI98m8dtvOpgxGNoJ
 eDy8Jv+xYC780qYw+tc/bl84ixLQ3X9UzExqqPkzL+bXyH2oqxkVGGBSekCcnBw6q7myabueT4S
 PX+9mclenH+AmGiuSIyP+XH8umCA3kHsiUVcMQwTHg7VigmsNe4x9lRAG57CUy6+SUoL5ZA3fj5
 zgLOuEC8YSglSfVcU7JylutW8HLcH9z+zb9dD+ILpu2+Bp6PgJHzqBtbxm3XF+4MkZJ2BFR92h/
 yuxUyT8ih5DBzarcACvX6Vpp27AIkd5yRGV7gZWRj/YXZ/DmlS9XK56Yj/1p2ROPw1wcGF2asbD
 pXv0nANtJBfOPpEsE8K0xZrqrtkYmDiWs2i5ZuZvNuM/6U7Jc+1tvwkbpkLgt8GlbqwviFENqxu
 FQMAqKS/u+dNR+43WxGq2nqk2TGVSRsWZVjQAE6fYPBKE/4y5RjPholQgRuco8G5f2SVGAf9RsX
 siRLzLfwkBsWNfQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qtest_set_log allocates log via g_strdup, but no instance_finalize
existed for the qtest type.

Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qtest.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index cf90cd53adb..e9e5773341f 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -1020,10 +1020,18 @@ static void qtest_class_init(ObjectClass *oc, const void *data)
                                   qtest_get_log, qtest_set_log);
 }
 
+static void qtest_finalize(Object *obj)
+{
+    QTest *q = QTEST(obj);
+
+    g_free(q->log);
+}
+
 static const TypeInfo qtest_info = {
     .name = TYPE_QTEST,
     .parent = TYPE_OBJECT,
     .class_init = qtest_class_init,
+    .instance_finalize = qtest_finalize,
     .instance_size = sizeof(QTest),
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },

-- 
2.53.0


