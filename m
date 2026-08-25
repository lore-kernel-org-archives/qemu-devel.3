Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5AC61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoJ9-0006lH-QI; Tue, 25 Aug 2026 06:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJ3-0006Xw-FG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJ2-0005mH-5C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3jdVHOIZg28x5tTLfcSDchrSqvF3pRSYXnZWucboy8=;
 b=Y7bTqmF/VepSXyusW6Dj4Ec05Dno2wP66g2b86fayYfjyIjCMBLKFZFuL5cqlPM8KVKwPn
 /d7/kaMcp/X8yP9DVoIoXznMfj/Dl74/GA+MsgkiB7vvg2eA3nSpigd0XzZsoQApZP2PGK
 obec5lJgHx/yC3mHekFEL7Ci17uEMSs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-kEOA9o1XM4y96zvWJdIOgw-1; Tue,
 25 Aug 2026 06:22:56 -0400
X-MC-Unique: kEOA9o1XM4y96zvWJdIOgw-1
X-Mimecast-MFC-AGG-ID: kEOA9o1XM4y96zvWJdIOgw_1787653375
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8999A187E5C2; Tue, 25 Aug 2026 10:22:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 824D430002EE; Tue, 25 Aug 2026 10:22:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:41 +0400
Subject: [PATCH 04/18] ui/console: disable GL scanout when dmabuf is the
 active one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-4-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fVbPh6f+y71tIi92bbLnTHXtgYVyIThG/fKNesPGhOU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyXdtrhiW4XBGLz6cbvMMzA8tuxLmMytHQJ8
 Cw3BW9j/q6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1slwAKCRDa6OEJdZac
 5UgJD/9Q1fiWFu6X3vEcVgbwPI9Plm1RCeBoKdP8zP8p8TI2ki3rohKZlkAeIcClipNce36v1sS
 0IrY3yy1T1kgF5YPyVUzFXuCqSH1H3DuWFL6yIFIRboGsntijWN9ljJYwDmclORZgVngzIb8wls
 tBc/+0+q//DFgaWzMFvmOd9A9G30a6GvBUG055TPAANBN7wkDiqMDHLgvFqHKg7tSB6Vd9jE+4U
 DIAfzyM0/hU+wG5xcFoByynL2ywrkwQw2t/4DGCK28EFXLsHVKIACIBFpi46mYHYm5jSVrBvDkg
 XbhOzNRjIA34Kn/DqXgprBev0tBr3Uk5zBTuMJwWvTUteTpA9dsCOXsduWIsTMJ9ugFsQZPTiYy
 eXphQB/sFsKczH/JI30tWA9h/9r7H9SyXp4Fl/veb9/b7ASSEyRzXv+Np0+jcemDKPZ9kAhAMCV
 peG7RIBd8uzwvn3ohUzPYSSIoR64nnh6YU255fcDaZXciqUl7JPP8aKS8qwXlpVFiktwBBsNzqS
 uJP6yZ0B0e8mILGraD2Kk1n2M20hBaV99TK3E82cHe+MIrznt4nBJOsxsqY0K4PFfOjc2f4I8Xt
 HnPi0+5fVjiiULag1UW+LcbXuO9wZfoRLmKhoHFmZkgD7pSIWGcNws9IAOh+GV6vz3+Rb3PC+cL
 Kl5m4Dff46sFyjg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Disable the GL scanout when the actively-displayed dmabuf is released,
so the console does not retain a stale reference.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index a8a2a247d8f4..14f148118e37 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1049,6 +1049,9 @@ void qemu_console_gl_release_dmabuf(QemuConsole *con,
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
     }
+    if (con->scanout.kind == SCANOUT_DMABUF && dmabuf == con->scanout.dmabuf) {
+        qemu_console_gl_scanout_disable(con);
+    }
 }
 
 void qemu_console_gl_update(QemuConsole *con,

-- 
2.55.0.543.g5ebe2ebe4ea8


