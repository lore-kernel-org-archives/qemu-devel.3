Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C42AFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRtU-0006DM-LC; Mon, 27 Apr 2026 15:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtF-0005Nr-MM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRtD-00087C-Lq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jswsE+qpixbv6iOMTTcNCxgSkRm1F5eNCKVbDRXPEJ8=;
 b=YYQd2AwAmx21tOQ3TjtUDUoD4Mk2su053npf8Vw/hkvE++3bwHjSWVAWlBnk2HDghDL9iv
 fVjSmG73Zr9Qvou8qCkZUMmDEvZMEaUsXj73qQjdSX5uSyaTtQIfkEmHyRuyr/kp0uJ9v8
 b9a3Ti6gfhkK6l5XZ4hUTNsghsQcfL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-lz-EHQIzMRC18mRq1xyT0w-1; Mon,
 27 Apr 2026 15:45:03 -0400
X-MC-Unique: lz-EHQIzMRC18mRq1xyT0w-1
X-Mimecast-MFC-AGG-ID: lz-EHQIzMRC18mRq1xyT0w_1777319102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFE8719560B7; Mon, 27 Apr 2026 19:45:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B2D1180045E; Mon, 27 Apr 2026 19:45:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:25 +0400
Subject: [PATCH 26/41] accel/kvm: free device path on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-26-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kb8aCpIeuANYOHpQ9UF6rV+rRvi+Joa1R7pBjpmZggY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVXPLyYwKimOxS6oHWzamgH/Fh9RyoF6TkM
 V5JZpGSwF2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5d70EACNGoq43OB3CaDM+7/7tFMzAAPCltI8juSVy+j+3BQDmaiciMy8bMR3VtcqDRoH55QM7xI
 IqP0HNxUcWeJh2XLTOBJ5hYzF/nir0jZ6tgSfu1c4sy11+ubmdXSkNzCQJs8VUQcZJp5zbFBkZU
 h9wDDUuWH+UpbZJ6Sm7vh5ZdOlNKEYQoCtAb6oBaa27BeQdEcYqtXFQYI+Pq0ts8xMrR0bJP12o
 PGMgtKvnEaFp9oR4tzjePuSx8m8kyG+591qp7sdFwzYUdawCKzTlp9J6tXqp8u0xmHjXWzUuTDl
 ngjv8zO0wc8g8qUu9qLSMEfPA+8xv4jIPjTHKJL6sqn8WUtdLcNKdwivbLIGeNLOKXykNT6Fa6C
 1zo3UYF4Q9rN+9d0OHJgdRk8dn8uPoAPv/efVD5eZWXSK1tWxLH0bqhSjy4Rf5QD0+3N8e0a1d4
 IalaY4y2lxfv5e/o8xyO/b7ctnx27/liTCmbgkuGULj8jItFCXahZt+Po6mS7Z14I6iAJUGdwxd
 Wguq+pOIjKJu5Kza1R8xjFXXgpUTSUCtBBlY6lVTq4CDlxx9w4s5t4k49hTurX4w7KEIRt8gX8c
 uxJ1w9Jo9SuXddTwQsMwzb5Yn5EYY0/tc++BnB/2qNWPzZp6LoLE46Vr96YTfex1wsMMubbuVfJ
 fKPAsHDnqtqFmqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

kvm_set_device allocates device via g_strdup, but no
instance_finalize existed for the KVM accelerator type.

Fixes: aef158b093b9 ("Add class property to configure KVM device node to use")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1..96f90ebb240 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4342,10 +4342,18 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     kvm_arch_accel_class_init(oc);
 }
 
+static void kvm_accel_finalize(Object *obj)
+{
+    KVMState *s = KVM_STATE(obj);
+
+    g_free(s->device);
+}
+
 static const TypeInfo kvm_accel_type = {
     .name = TYPE_KVM_ACCEL,
     .parent = TYPE_ACCEL,
     .instance_init = kvm_accel_instance_init,
+    .instance_finalize = kvm_accel_finalize,
     .class_init = kvm_accel_class_init,
     .instance_size = sizeof(KVMState),
 };

-- 
2.53.0


