Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29123CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxYf-0003Qj-Lw; Tue, 09 Jun 2026 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYe-0003Gr-A5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYc-0007MR-G7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/g5jfTi2AD+hzkWtUUyAkv+WqHTfhObwkFPbXFeULU=;
 b=cNXOwWog1rimx+Mh8e3HdYrHw6TyH/vkFabDPPCQAc1XxynTCwj+hE067JCEmyyPJxmzjh
 w/4Yb1rKHC+tbMaZlYgwHU9R8OxYUEuRbYigh0QiXkTmfasGhAZ7DhofnNVTyqzLa69jb7
 HVUmj9m/P+xSpJf+QYkodMPUxmLJ/mc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-XZzmiqJyM9GLFtVcWaNnVQ-1; Tue,
 09 Jun 2026 10:35:54 -0400
X-MC-Unique: XZzmiqJyM9GLFtVcWaNnVQ-1
X-Mimecast-MFC-AGG-ID: XZzmiqJyM9GLFtVcWaNnVQ_1781015753
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C20D1977017; Tue,  9 Jun 2026 14:35:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B1D53008DF2; Tue,  9 Jun 2026 14:35:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:32 +0400
Subject: [PATCH 13/17] hw/input/virtio-input-hid: use
 qemu_input_handler_set_led() for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-13-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FxrGAwrXr2ksjrfGyAaKoh9XtsL3mW3yFUW3RWHGSfA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR5xNLAV3G/z0OsXLwl9gitrg5VhzPPLryUj
 Q6ePmMG3FiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeQAKCRDa6OEJdZac
 5R4rEACjmcSjjVR1HuzkSepegQFoTtdDws0jRDhfjeAXY2H5A+wRzXCMSF6wxPeOBuMynKUkMxg
 iq7n/yx3bRpFduJOVaxsbo4UGehW/ez/2rEcvvJCiBvrsTBFKKNdbfGnFOKiS3Wqzz4p8nqjo2Y
 tIhTw6CWpy/GBFPS1waizM4r+dD/m1AcJFinxlsa30jjyPrgl9WK5T7Jn5BcP3Z+TcSV71iLVeD
 4Xtzd3t7HAEmtaqWLSTuM3cpo2gsgGkIbrjG5Nex0xJlT2PTqCEDoMjQD9k53IqCVJ5Xzm2U0lq
 uCcPDwmWORG03hW4sH9MrvTuLXwcr1+flvoSvp7UD5WU/vDoSLnjjV3epyJl72Nwufj1+s3i+TS
 UOk/6+yVATXuQtMUeDC3AYb5CDDfAu4O3hnjKDMekNkZZ1OYqiazMzKyo1HLU58jSMhspzI+9gz
 a2C5AEbJhGxj3IHDGB5Ic+eIXEbPodHLFWW9gcard1UKFfyQPRaSvd5Nh01vMIyiAAIQCHACiJP
 l26Pd9zJd8hQi73QJxxY8Z3bVBV2NZ0PADr4X73/uoTsPd7vGHIaMGIYcR2ZL94nVdSQE4wKhKa
 /KdDjdlio7EGnQhK9+LqGR+45me4IUQWMjcmpey479ZbO8AHqTIV/OgEIZnTW0Qk/LGo7pQhnsR
 iZym3cpUH75f16A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 73423ac0c73..d3062809a13 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -12,6 +12,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
+#include "ui/input.h"
 
 #include "ui/console.h"
 
@@ -208,7 +209,7 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
         } else {
             vhid->ledstate &= ~ledbit;
         }
-        kbd_put_ledstate(vhid->ledstate);
+        qemu_input_handler_set_led(vhid->hs, vhid->ledstate);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,

-- 
2.54.0


