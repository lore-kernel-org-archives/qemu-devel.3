Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA6BCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXM-0005Pp-M1; Tue, 13 Oct 2026 09:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVp-0003Qe-4S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVm-00052R-PK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GakcDIN1vDjnjStZvIB6wzcwTf19886ZSc9MyUuRl7M=;
 b=GV8D6kAAPZ5JhPMZPX6niWFcAkJaSHj3Qtq2hKV/A0hK3X/0lPITwPVnSZ5LWsk8N3R5qA
 zVFmFtO2uKyQRoCgx96byGymyoqbVb4ikYBcE70rFac2/weBN8AViyQVZ2OOa5WFWxihFK
 k4XoALCdbEybthA6GvHzJXpQOP2t5Ic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-9NVNR1pvNnCuHOeCuwGBhQ-1; Tue,
 13 Oct 2026 13:25:36 +0000
X-MC-Unique: 9NVNR1pvNnCuHOeCuwGBhQ-1
X-Mimecast-MFC-AGG-ID: 9NVNR1pvNnCuHOeCuwGBhQ_1791897936
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA5851955DBB; Tue, 13 Oct 2026 13:25:35 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0E3230000E7; Tue, 13 Oct 2026 13:25:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:34 +0400
Subject: [GIT PULL 37/40] chardev/char-ringbuf: reject zero size with
 is_power_of_2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-37-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BaakAeAGsQc65lqY2kg498UbQWo58GR5g8X8LumIWKk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEixaccmtjindmaJGuWNCxTKiF9d7EM0/+c
 jRX0uH1cT+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5cv/EACESJQ6+C0jiuCHX1HZk81iVK/7luEaJ/NHepj3jtNd1CHkq6kKQZgR7tv/8X8e+YSQI3r
 6EjUbdtPdEu/O0PYSrowmSXaWpI0+sybHmB4Q0+7U3601HrHJGSfwmVROyS7oZ5E4PJDb0AXPvQ
 gl7Xo5WpzBsiwwmVFrZiPo7WTpT4vErfsTXjHeqBTAQGzqNICWC8i3bUJr53E+R9C4HM3CzHYUp
 iTNCpGbkqZ4MOnOS9ZzX8GzNybOy8P3kkNC+jcrZpegTHRAGY4b2DwOWKKv+bRyeYgEAeakN6Qy
 MMHWx1c4Oi4V6SWymHG4s9SuyCxyJpqoJA9KfUpZxTG5bWleUIqDO+uOvYFcTyAbvziMnBbjqPZ
 91LtwKeQ32VE6yRQvv52aJOOcbTGBJF/Vui5JSuHzBl6+hHabfYaWVahIzNy6J1SJjVMojWo2F3
 nOSn0Zwl7lgXGBhTyplxvQqnSAo2y5XCbx0zE+eoqYowaaCsbdy9G2zyub1hOxa+q1eUBPEdSIO
 6ZkAmtpngDSOCSRNXohAcN6rHJ2+Kb5oUAbeJZGeTALZ6DVDNx6QQOmA87l/t55SNEeoPb/Vfi6
 64RmmYe6VJ2svzEnOI8feApy3IvLdakO0VUvQYpsHY/6lbfbriSF5QnCxJtC37LhnoPbucZDF//
 r7WZaZo6UfLBTpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The power-of-two validation did not reject size=0, since
(0 & (0-1)) == 0. With a zero size, the ring buffer mask wraps
to SIZE_MAX, causing out-of-bounds memory access. Use
is_power_of_2() which handles zero correctly.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: bf51f62869f4 ("char: move ringbuf/memory to its own file")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-20-ccbef537cbeb@redhat.com>
---
 chardev/char-ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 8f998d26a49f..a80519f8d65d 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qemu/base64.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qom/object.h"
@@ -102,7 +103,7 @@ static bool ringbuf_chr_open(Chardev *chr,
     d->size = opts->has_size ? opts->size : 65536;
 
     /* The size must be power of 2 */
-    if (d->size & (d->size - 1)) {
+    if (!is_power_of_2(d->size)) {
         error_setg(errp, "size of ringbuf chardev must be power of two");
         return false;
     }

-- 
2.56.0.116.g6de20f6092dc


