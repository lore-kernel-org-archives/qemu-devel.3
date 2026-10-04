Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE4CCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOq-0005SU-9X; Sun, 04 Oct 2026 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOc-0004st-3q
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOa-0002vb-Lk
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VA02h5P8dqV28nunu1WZCvyIRqDMAd+Alc7RoCmtg6w=;
 b=hIkIOBTVEC6wrDN5vPnq/FpYXak5mFY6aEiMG5xjXdN5Lb//kTcxOro6CJabPgACunNenL
 PkNhzWtxRi2TkGKhzbSchqzha1b3rcVmzTBE9ruExyDFfhhmI2HGwxamqfh/8vtxD99RJv
 9WUyQTA2nhHyxvCAEev4jom165+5UxQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-5JX8gZQGNU6Z_ezvuIOhxQ-1; Sun,
 04 Oct 2026 06:24:35 -0400
X-MC-Unique: 5JX8gZQGNU6Z_ezvuIOhxQ-1
X-Mimecast-MFC-AGG-ID: 5JX8gZQGNU6Z_ezvuIOhxQ_1791109474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DE251955DC6; Sun,  4 Oct 2026 10:24:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D396E180034F; Sun,  4 Oct 2026 10:24:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:30 +0400
Subject: [PATCH 16/63] ui/input: fix integer overflow in qemu_input_scale_axis
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-16-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aG5bRWWxhBS1Ay/J7cWSrPJHdaeVr+fmWPcyntkPUjM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiki+uks94XNaEgB24Jvo23kAbtvFV2zWX4Xv
 5WbeRZRlQ+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5Z1zEACBjFHg/wGCv0j7Hid5xlvw0Vh0R3jXFle2Ue6KPIqlly5i5R3rGPyYlaCvPdUIP3ASisg
 OQgJX9uqq6GvKZ7LikVd37JEeB7muPI7H4Hk4P6U1pCysJpaaMtkphRGlzT+HbvkPNtsI0LDQw2
 8UmJbdwZNYe806G/QdAPWeXNP0NQfmTt69lBLkVq109kDBP4M6PDQKKBC/eesNcOWcdLZM504Yx
 jZa2y1dUqUHfMmoh1Eu+zaGS/AJbgcadodlXERpiSoRlRgzu42TnB7BITmOMAJ24hD7c/8fGnVf
 A7MsUQITnUBsKU82sBYT3w+ggdM+BugJ1VFrzK7N8wSVS3gaqJ12JFQvkHKp2MHukG+nXE7tg1E
 5BmcDwwP0rRZpPSPdxSSa/gN6ZMjN3WyMcZDi62LrNeTybM2SvzB41KBpQDN8hk73njMLug1FLK
 ViNHCHiGRXcen7dDxh61zr0BEw1UpHlHDZge1FmZYv0iaC5nAF+Hk7oGgTQ9NbAlz6Yg40GeI4g
 rhLfoarYm1AtWfsRXfve5Y5dSwBSM2mU0sG7rOB02FjptTn75jIOu5w6oXYhf+3nEtlV0iQAIWY
 3N4mU+TpiY4IRo++xVafOyFCNMipV+XKb5A9XfNH6hrsMUPRohkwPyXQj5KNBZmEKJ0BP0pAMMG
 j0jdP57j1bUYWzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

The multiplication of (value - min_in) * range_out can overflow
int64_t when both operands are large. Use muldiv64() to compute
the scaled result without overflow. Note that muldiv64() takes
uint32_t for its multiplier and divisor, which is sufficient
here since all function parameters are int (32-bit on all
supported host architectures).

Reported-by: Pavee Hui <phui@google.com>
Fixes: 43579403a3d6 ("input: mouse: add helpers functions to core")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/input.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/input.c b/ui/input.c
index b82622c8645d..f40a9883701e 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -5,6 +5,7 @@
 #include "trace.h"
 #include "ui/input.h"
 #include "ui/console.h"
+#include "qemu/host-utils.h"
 #include "system/replay.h"
 #include "system/runstate.h"
 
@@ -492,11 +493,16 @@ int qemu_input_scale_axis(int value,
 {
     int64_t range_in = (int64_t)max_in - min_in;
     int64_t range_out = (int64_t)max_out - min_out;
+    int64_t diff = (int64_t)value - min_in;
+    bool neg;
+    int64_t scaled;
 
     if (range_in < 1) {
         return min_out + range_out / 2;
     }
-    return ((int64_t)value - min_in) * range_out / range_in + min_out;
+    neg = (diff < 0) != (range_out < 0);
+    scaled = muldiv64(llabs(diff), llabs(range_out), llabs(range_in));
+    return (neg ? -scaled : scaled) + min_out;
 }
 
 void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)

-- 
2.56.0.rc0.29.g47ce80527c56


