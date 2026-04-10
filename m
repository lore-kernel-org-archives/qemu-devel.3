Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8B7F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRQ-0005Kj-Up; Fri, 10 Apr 2026 15:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRO-0005DH-B5
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRN-00021G-2L
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kt7NH/XIYgIrwD2NGiKfd1jgayk8UZ2mCDKH0ZQ4964=;
 b=U99smANz2zV6qRFdJAcZgFYqus5d+IcE27FRyqhAwEC1kEKTseSsGCk0GmL6Zh9DI2krv0
 t6y8j4zb516MfUDCm+67lL7E29fUKag/e3Ubd2ayyGcSjGi2Q362pIF8Nkv0kITlLxav10
 uoojwT++ukZWHb1Hdn5miKOhDc+OaNE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-CnQEuzT5OMOjgpUZDJYUlQ-1; Fri,
 10 Apr 2026 15:22:51 -0400
X-MC-Unique: CnQEuzT5OMOjgpUZDJYUlQ-1
X-Mimecast-MFC-AGG-ID: CnQEuzT5OMOjgpUZDJYUlQ_1775848970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BFC818002E5
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:22:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2343B19560AB; Fri, 10 Apr 2026 19:22:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:01 +0400
Subject: [PATCH v2 39/67] system: make qemu_del_vm_change_state_handler
 accept NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-39-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=655;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kz8yJp42ZZuqZiIEby41N4itmZG4iK/xogowe6wEggE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VeI5hTtnIKbBv0tD+I9tJ16kpnpeTvzUP6
 W012n/f32WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5fsxD/916LAxro0D86D7hueh/q1CjewFsigAQQdoyv+DFnd9f9PLhTSARRwuBklZ0gv2kf46l09
 n0YJoNp6697UWNg1oFlWXopteA50QipRk0HH4VBO582lNhFPPswsDGx58pwkz1X/5DCuvUmzG/G
 O9Rk8Pq4UKhLPKMGlgPZY7pINcoN5dPqXxBYBoh9cwDemos5dg3vdnBB8UFQLDGVXhXfSLWyX/y
 kbTjrS+asgxI4CdUMk4TqpGy6GaS+ajt8GpPSkwKoT0zahrsWsPWHcjO1HQh2GgmH576lm9k37K
 VGW4fhn6PbKOmYQ5no97xzyXiEY0gx5FOtI5vzYGzKgmtN1ApCAMJjBYPLqXSDEJZUAtd35TD2m
 amnf/lHOKNEQQoHzf4k/Tr26kPvb31LiCVkeywilR9zri9txFS5GzL26KTPUkPditXVx8OqwdBp
 z6O9HegyG+e94OEmy/jn+DiQEarpPVMJNetwoZ0xjrwylAeK6H0mWKnxaLU+4SHrggZy4MqtU5K
 a6FhxcVEwMYRLw/g+FaShmp8MaZLuu/s8gMUUrWPsj+jlRguaVx4i2/bNSDpMUNSGr/aVtdu7l4
 0PKDltSARti/do0edIS7/sZWsSRC7IiyUthrpKRDYaQilNa2d8quT+TZk0ys9PQ5Cnx8sWw/nMh
 RKhZDiZ0VL+4LwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For convenience.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/runstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index 2d4e95a2166..770253b467b 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -349,6 +349,9 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
 
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
 {
+    if (!e) {
+        return;
+    }
     QTAILQ_REMOVE(&vm_change_state_head, e, entries);
     g_free(e);
 }

-- 
2.53.0


