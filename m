Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BFECC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXS-0006Dd-FH; Tue, 13 Oct 2026 09:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVT-00031H-VK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVS-0004ph-Ka
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78kDaFiVn1gcJ8I/VaVZFqNdFhbm6uHajSBxfTnYn5A=;
 b=UzRcIDliWzCxnXnvn79ggXDBBGSjyRqwYSQM6PdAmvSyIPMZWMMZCLx2KsMzY4VbS27RPv
 RAD3Xv/o8rjJoDKfXOeDRm6TJ+olQxpJZEviNUyk98oBbvxjgvaGvh0y7hdBjbZ93UqQB7
 oZTe0tZMYaoAOJLo5I9N8FNQll4QeQw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-U4Rx27zkN9qwGsthvpHoxQ-1; Tue,
 13 Oct 2026 13:25:23 +0000
X-MC-Unique: U4Rx27zkN9qwGsthvpHoxQ-1
X-Mimecast-MFC-AGG-ID: U4Rx27zkN9qwGsthvpHoxQ_1791897922
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19F1819772EF; Tue, 13 Oct 2026 13:25:22 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24858180034C; Tue, 13 Oct 2026 13:25:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:30 +0400
Subject: [GIT PULL 33/40] ui/input: fix integer overflow in
 qemu_input_scale_axis
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-33-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JGN/xRElCdl6P98XBa+ZTVFMvsbnJKfhU1pbKKQi6JQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEKZAxf9MuXtc+DpVRrB8TeVl0B93kk7JOo
 vEwZ92PN06JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5RSPD/4lHB/gtnG8sAXqKgxdhJsS5nfBBTI96rpAUN8PqmOhokFHg5WoVc0RKbyThNXsNGL6vVi
 ewQM5+nXB2U44zK0vyRbu2lUuZK6y5dBkTsziLtoQJsb80ZphUK7IYGOXvuK1dTCZ0AafPTxt3V
 HHozv/BIDMvBQctJb438sFNcJugkpBtXx6C6Hlm5leNR5F4jc+Qu94eyORIsX9/S+ZA7JeWXf26
 8RvQsHK0cTUPKbBhn7TteofObLLusyHk5T/9D6nZdwaLIw0HNjY2fB0L3eTx3YbyT/5gcKrxfDT
 EVVedzma9uiFNUC9zQKH21mEZAfSE1RSVo/8q2dAaeaJ6312DICJJUBHlzzurhEmRZs5jqjH0s4
 86TKWL0l5ds40yYEOap+gsJovyUSaK2+k/qcB7p+do5aERPO2vgk0quDVQdfR/ewJvYmPsq1CDA
 1y81JDMAZjPQ5NokAAKMEQITrGyX5V1v+8YO1GDGRiQx6/K3vOXWlKukkJbgJh2+TpyAcv/d/t4
 uauY1HFAIiSeRrY8NZdBUEFyPNjrM6b5V0YmpYhMRXomzJAdm0IfPiCktfCcZh7SXcq/0Ohe+5s
 5yGwvIcSWio7TvQQsp855AFYn5vASJWkQh8zJ12rl1/VKTPFLagE9TmCUvR+nG+xSzjR+Pep31w
 Ql4JThOSEBkCVGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The multiplication of (value - min_in) * range_out can overflow
int64_t when both operands are large. Use muldiv64() to compute
the scaled result without overflow. Note that muldiv64() takes
uint32_t for its multiplier and divisor, which is sufficient
here since all function parameters are int (32-bit on all
supported host architectures).

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 43579403a3d6 ("input: mouse: add helpers functions to core")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-16-ccbef537cbeb@redhat.com>
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
2.56.0.116.g6de20f6092dc


