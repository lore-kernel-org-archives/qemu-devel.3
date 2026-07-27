Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F00C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsy-0007eW-B1; Mon, 27 Jul 2026 07:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJso-0007SP-IP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsn-0003m1-6z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PySdd9kmhQ4/OexigL6IUaVOmr/wGNdJk0mxf1caIFk=;
 b=GNe9g+jbSn4L4fUDGlWcmD5tEiYsyvY/ZxN0AjVdX+eU/W+PniBi+zdtVrN8iJEYG1FG80
 Fv/JmLYDMlw5MV11pZYAQM7zACeevQIHiPZfk44tcRBZTsNaLoV9lJN+5+mSFgzZD/eV6k
 5MsvGdrCspf8XkzSqR7d4nOfRzvAsT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-9WC51eO6PPqMvNj21mdIkA-1; Mon,
 27 Jul 2026 07:52:31 -0400
X-MC-Unique: 9WC51eO6PPqMvNj21mdIkA-1
X-Mimecast-MFC-AGG-ID: 9WC51eO6PPqMvNj21mdIkA_1785153150
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 029071955EAC; Mon, 27 Jul 2026 11:52:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC36E1955F78; Mon, 27 Jul 2026 11:52:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:19 +0400
Subject: [GIT PULL 10/23] hw/display/virtio-gpu: Initialize blob mapping
 for ATTACH_BACKING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-10-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AphGHdMyaQx0iYaan/tu3RkN+OsCovS+ivR+la/MPzo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/93tOty/X0PWqOdzkFMnZVkWdNxKiji+lP
 RDY/XAAlyOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5bRKD/wNUzuANEjBi2nA4dsznnKCz8DgdSGOJrgGoxgSkzuHRQ8vhuPZ/vIp1GYF0vwEY1VbMeo
 IRSfLZ+CiH6NoCvGuogXLLHUaL7rNF/dsVGtVYm8P48wAl0lNFcy8xW8i/B5GuIOiy2LP7CUnld
 8nzFbO83Ln1zXQalQlsERm5wRccne2YUWxosg3nOlC5vxf/jUxmwdWVHFAgWvp5y4wlKBmOJ5Jd
 xN1fqIRcefYHkuz9+0aigmtbHI8cYtm0HAb6T7yT4czdkW3QCvas2OM6UkKftwDyRA4mOWCqocp
 34Osjsda5lK6rO9GwN2PRpewZu2+b//RmZuVWxttjD80TurQdShDKc5i4tX7nI9+zFpyD5X8LV5
 aM9aNsSeuxSV80saCrcYy9jZOcSx+498vm0vOzMiLcfLqN8OGSrzESgqyZeC7wZ+D7LW1t2T55K
 Lx0MobfV0vu6O3s6v7JmlT88s2sDmiaUWbpzh3bAzOymtl204IE+5TSILTQ1NA42zQAgbbjrp6+
 Jn20xi4bHQmHZhZ8wN262ob/nJ1ieH9QefEWbCstbvldUPB/2BGCH0EnvMWw2mtoQE7mEOkg8Eg
 9mhp6fvrVZ40kXfkiLqv0fBOdmFKX5lMULRBWvQxCGzmjSkAJ4LgHzEtwDSCmLFGZquhAhsx2UM
 5Dy3zdNIQ/tmg+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It is necessary for blob cursor and scanout.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index add60926f366..4d46a4eb10fa 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -992,6 +992,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (!res->image) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void

-- 
2.55.0


