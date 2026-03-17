Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E45F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEA-0005mP-6J; Tue, 17 Mar 2026 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCK-0001d3-Fp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCH-0006oD-EM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/qj383L7ITRR5UHJaz+Vjb08FlmpMy3/lXEF3fgdaA=;
 b=MV8URKhQKzDQ6CcX5adciF8bP183z4eGvE02OAlHwE6iUVrZUCKVPzDSDpKnaieh68tj+P
 M+oWVS56gR+uyKvtuVBMyp3YpBAdfh6HxcJoM8LMQbmxJR12UyTSyiYOze5GvrE1CR6iZn
 /9DI4BvNcJE+tnAufDgyPgg1IBHG2Ec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Dq4KYt6cMiStJkoRB0hI5w-1; Tue,
 17 Mar 2026 04:54:39 -0400
X-MC-Unique: Dq4KYt6cMiStJkoRB0hI5w-1
X-Mimecast-MFC-AGG-ID: Dq4KYt6cMiStJkoRB0hI5w_1773737678
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6833E18005B8
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:38 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5180A1800576
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:55 +0400
Subject: [PATCH 41/60] system: make qemu_del_vm_change_state_handler accept
 NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-41-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=599;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AHQP1IHteOcc8yrqt84V01z2iY57/v3Mf6vjZMrcSlQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcnIPNp5VacNg6ApLEgxT68T3BC8GVTfvkg
 VY+mbwC+U6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5ZAdD/4qyNyClRaDSt7HXcwnwJTRBmkyL9kbzvddAzsDHzPw/cl9RodFZT+O71vtnl5HrrT1FTk
 HnPlsR0no0AFraFBvvKvFyQYXekbks2EgL0LeFNtqnWZgOmsAfEnBQPyScTbDaLt3m1oDjdpZTM
 gJmMj1ZMsBm8uecmq3MKqVln8l9BLTy3AeLk2llCp0aaLxw8ughQMQhLCxvL42fDt4FhPMPqKwD
 EInci88FYBqeOQkZsl0s0OkKRa6z4SmgxdB8aOriTEvBeR8tdPpOUsjVKHec33xGYwtWHkarUCs
 vzRJzfHBuc36Yy06BiBzzm+i725K6sPOikO8JDcegzSpNtNs5U27ga1w9HOi4K3p5YIusjj1mCK
 TGkGT4UTk3mxWWRxi+/Uko52oeXNQ8wka9ugroLtwl6i/DyXSZdt7YGIwrK/EZyi10SBhViCJX0
 gVU9uTZToGY7I2uZDDRPrVZReHlACsV1YDxwxLaz0pXL0L9K78i/EGS6HES7lmeroUY+EAZ6JGB
 LcEzUlb0bXOEWi6J9+QNh7ClkH8e9Ggp0Lf9ZZpCqwghwf7DOf2WrgdzSgnx/Gv//47/dpDJC75
 D1G5rvqPSNRSS7k0y91RGzzwgFK1Tlv9M7Jl9TKvS2zFVVwfafNg9iyy0nuv21nAcRsnq8IEOm7
 eKDeP2Q7lf8aFnw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

For convenience.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/runstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index 77cb14ae028..7d8bdf62dd6 100644
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


