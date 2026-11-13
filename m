Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15629606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dUYni0iS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoka-0002bS-Vw; Fri, 13 Nov 2026 05:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRoka-0002bE-09
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokY-0001fa-Hn
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94ghMMNgKCq0dSzqKSO7w1E9ij6ckVKROfbELIzA4BA=;
 b=dUYni0iS4gxxT+clVR/RqXbrt5Dkktsx2fQr3TB3Xh6Kh2oNgbTGdytd1Zh//DBsmsnwTl
 sWJhYQ4Y8q8b/AD3oT5qNlZox1uHm4DsR58VoKePbEcSz6VBWIq2ebstsLMmsFsRUP3tRf
 /wf10ayaZGXU6+p7fuPMrL9KjuqKAYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Kz8uF5O5NiqXH9Ma2dv19Q-1; Fri,
 13 Nov 2026 05:43:12 -0500
X-MC-Unique: Kz8uF5O5NiqXH9Ma2dv19Q-1
X-Mimecast-MFC-AGG-ID: Kz8uF5O5NiqXH9Ma2dv19Q_1794566591
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 610F01955F26; Fri, 13 Nov 2026 10:43:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FC47195B3F4; Fri, 13 Nov 2026 10:43:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:17 +0400
Subject: [PATCH v2 5/8] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-5-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VyoPwlm/5oBxY+B34+pziF0lwz87H7XXBjqB+aW/iPY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umoLZ/ztPhGoreuUX4TkROSCQYLrZ9gk94jZ
 gabTCmzLOWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbpqAAKCRDa6OEJdZac
 5VBxD/sHMGBDPxxXTA61KD/4hnkFsuV1b93G/JU5XEmwqi3MRYRjVrLdd0eO7nU8U3UH4BkuCxV
 h0tnviUaZTCf7CvnBFxx3SQLtMUfrk59D9sKva/WRQkEwJHN56MUkMsf/kOmARnoK2LmClLw/t1
 guj0reNNaWkFuENcFog86FRbS72eGlpR/jDOSUKp2iiJ1MdbvsTHXxMLU7SYSHoVCi4E+eMhLw9
 26WITIvnURRP2ocJea33dDvNQq08TF9VxilPUYSO8a9xtATdtkCIFJaDdMVUUsh0PFqBQ0aQUAV
 H5JEGsh8hddVSXCs/bYfr8JzIZjd6/58wR6+TZVtWtTpGAmlE7QRAAk9orMpyFiC1Xg+gyktT0A
 bpdJkbZ3l+25Pb6ERCBj2VPGc+JJoCTeuK8wpr2gWVJnWGsEJWEPc/YvJs3H/+Oe33KolQmGxjU
 UliMFCJRAAx8oMC0mZMj952gR2NHdq/1u86JRlp8y+wZXL5gSsSXSoS9PXzgSVVmmWyn3qqxSap
 oFmjjY13xHoYVXmE5WXODYlxe3tGLh7urUpHJIIBItHTCcgxJy9NW97LO212SqPPd/dmG/26Jpp
 Zr/5vLyJczFfP9rtdKTPut9KBeRFyRdXhUT1WiY5s1unK/RWwnU/4DfVnjVjyZNtgBdcpPUiRot
 px4LvRUSC7SmCpg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Reported-by: Dmitry R <rdmitry0911@gmail.com>
Tested-by: Dmitry R <rdmitry0911@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 78df9abd3d0b..6473ccfe882c 100644
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


