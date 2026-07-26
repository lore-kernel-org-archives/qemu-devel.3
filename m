Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4F0C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5ja-0000GZ-Qd; Sun, 26 Jul 2026 16:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5j5-0000AK-Ea
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5j3-0004Rv-8F
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgwF7jkNJLhj6j+139aaPY14IWX2xoRAqge3G7njsEU=;
 b=h19dBEail9vSgwe7Pq4oQaQ+hx5+oEnykJ7nCXHio2FenbETqRySouA/FoMf94kcIMxkSx
 uc5xsKTw85G11vPtzI1V8pvS0Rlv+AHSXzQkdJF9xF+buKyKiVf+WKEQWZM8RoYhqm56He
 ZiQwxcCjGqsq/ezfxRmntsNCVxyoB/8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-4NpKxJpOMJKlDubQtrOMeg-1; Sun,
 26 Jul 2026 16:45:27 -0400
X-MC-Unique: 4NpKxJpOMJKlDubQtrOMeg-1
X-Mimecast-MFC-AGG-ID: 4NpKxJpOMJKlDubQtrOMeg_1785098725
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB091800590; Sun, 26 Jul 2026 20:45:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEE531956047; Sun, 26 Jul 2026 20:45:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:10 +0400
Subject: [PATCH v2 11/12] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=654;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8V4SbETfqA20e58q6VCGWaqhSb6JTXgkzFqcys/62CY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXqtL4DYX9fMBDVrhGbWRZ/5vbN92kSAgN+
 0aizcq2HCSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5Y+tD/9qjL26Hwgig0DMmnbLIrFIqE27KE226meUw/u9RE0E3MUY18KW3AcEYHjr6JwdPCQx9oL
 TkTOszT0vzToFQHDuoPcQZ7zm4YERQxTOtNFEmqbN6LOMSOWG8KhcexF2uga1FsAAQA8daRiDxD
 eLmnhu4k0JPgSZWsqyLeL+PL4TCLXTDulglfPg4SN44JBsTysPvnKwFbhQFjeMx6OzEbVw+ipb3
 sumjSr2mkyEc5UpMu0hS0JUvwLvarPtH6cByPFWnYYBs1yAzkRu1m86r9I9s67tt6VoDGQdBBPn
 cXqNQiJKfgAUGPuLY6QmugdGhCu4xKR78l0q7zRuCOuNwrjAkXZUESKPlSlAOHhvpCBvzp7ADg7
 BpPHvf2gnVKdaAUggS57RD6eCtb2D5QMjsA3dfHvuGVaIJsi9PZov1L+GPbiPR6Dlh+pxdvqnfe
 MhzchAgRmakbAH6ipHQTy7axxsvHY0LHVnQMW2gDQBzDNpXFaQ6yTCJeMuoua9XvCR1EyDGtRtQ
 JhLJmfQ3dqV5MMhRDfgoYe8scj0IkgK2luKnkZ3vo441ydpBzfH6rrxfJH7zbLZVrOdd0gE/+Ll
 wytmCWs74YesvP9HH5uqVTmL6ADR5upoh9OlTKLwZEPBqKEDx6xG5jx5za/B4XH1Tdz/8cD8mCG
 UAdVFiWx3U0E41g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If err != NULL, free it.

Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index dbad525d2a28..503014f76ba5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1056,6 +1056,7 @@ static void multifd_recv_terminate_threads(Error *err)
     trace_multifd_recv_terminate_threads(err != NULL);
 
     if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
+        error_free(err);
         return;
     }
 

-- 
2.55.0


