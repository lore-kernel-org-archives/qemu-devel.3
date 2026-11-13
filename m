Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAD606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQYG9gFe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsJZ-0007wu-32; Fri, 13 Nov 2026 09:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIY-0007jS-0I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIW-000683-G5
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgvwiP5fIyLqF4qIpSn05PFMtBlSOZ6QJ6DzVOJoeCM=;
 b=eQYG9gFe6jTAbl1tgVwqWbd0ecpJSBdSJ6JkdUc8Os5TrS8MOYVoemjm2Ug0v1MZbwvEwF
 QES7H07M28k9AztqpAzHGkl1WS2HhapDQFwYkFy7yrwPoFm39ZGs1Cd/bIl4VLEqc+Lq8e
 4sVrG2uHScmPmUfnMHOojoyOVTNJa7E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-iVe3PGt8OcSXIFW6Bb479Q-1; Fri,
 13 Nov 2026 09:30:28 -0500
X-MC-Unique: iVe3PGt8OcSXIFW6Bb479Q-1
X-Mimecast-MFC-AGG-ID: iVe3PGt8OcSXIFW6Bb479Q_1794580227
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 428791956096; Fri, 13 Nov 2026 14:30:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7254F30000E8; Fri, 13 Nov 2026 14:30:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 18:29:57 +0400
Subject: [PATCH v3 5/8] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v3-5-98e4fa3e77eb@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
In-Reply-To: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QYjsDVa5y8RuFLFZAy/pBcW2gYH8SJLIdm6TG/ebNUw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9x7mzJX0MVLVlJnbF+bAoaSpAR1mIkNRxLq5v
 D672LnCUwuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavce5gAKCRDa6OEJdZac
 5e9bD/9pvY/GPVB0C+W14ZxuORYFUz47FrFNnbl5mTWJoendmBEfbdBZAfrPIr8/4TAw0H/VsD8
 9VwvRKkvnsqLaheLbYi6kjaCrzFOMncyqiUtLk6COzJ8vq1vPgqzD9BHaFgF0qKcYQP/xivIXPB
 oT4cxvuTmppyvw4haFGZ4CBgsXZlK0jZy5ieIP8DLRnSOUNmRjgXV1rnzf7TjLinaB3KjX+nKue
 q2Kxv5hQvKv2Lz3KhXy1xZOsc8euaLdlBRuY2b9DrPMk9G4PaD2ClUIyjgxF5rjqnLoqVNQpoVj
 O2zLlDEphCs5cS3pR6PG0eIdRloHDor8eG79o3oWZuS9NjBSntchIvQ6/jPb2rMf/pqAFz+kB23
 tYpKH7ndUwWVmE6FQ0HPvdFJDXclHIWcE5VHW+StcdnD6cw9YMq4JqJqDj2WnWEhIK+lk5SNYBL
 1Fd3Cdydt/L/1cb78H5/LVdrxrKe/rZ816c++hEaioOAFcchBX6muTdjBzuGhXByVcnDLGhZifv
 htpqAKPBaxKERNAQ8jfoBZho3JJ3VRNWyM1+xqlhreWUOtKsiGdFumE0OFS45my80N3z1gdTnIk
 fnjnz6MHbO9sEjj+luwcni4rX+U4L7bdVDJJUKOYHijO0gsiAkjJTuHv0kNO/pJIK3YDh2jBYji
 DgfzqZpCtrdxNMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A GL display client that stays attached across a device stop can unblock
the console after vhost_gpu_fd has been reset to -1: the UpdateDMABUF
reply or the one-second gl unblock timer reach
vhost_user_gpu_gl_flushed(), which installs the display socket handler
on fd -1. With the io_uring fd monitor, the failed poll of fd -1 is
reported as readiness, so the handler runs and is re-armed forever.

Only set the handler when the device has a display socket.

Fixes: 3cddb8b9e0b5 ("display/ui: add a callback to indicate GL state is flushed")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4847
Reported-by: Dmitry R <rdmitry@taktcycles.com>
Tested-by: Dmitry R <rdmitry@taktcycles.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 46e7fc136583..5874f3a50b28 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -449,6 +449,11 @@ end:
 static void
 vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)
 {
+    /* the display socket doesn't exist before DRIVER_OK */
+    if (g->vhost_gpu_fd == -1) {
+        return;
+    }
+
     qemu_set_fd_handler(g->vhost_gpu_fd,
                         blocked ? NULL : vhost_user_gpu_chr_read, NULL, g);
 }

-- 
2.56.0.116.g6de20f6092dc


