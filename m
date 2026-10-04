Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9748CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQC-0001Dx-Cc; Sun, 04 Oct 2026 06:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPu-0000FP-SI
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPt-0003N5-BP
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeSvZx8zWpy+MrTr8E1B101TUJC1EIpel8LQjGQ+ydk=;
 b=HTfgPxaqbckPoqUplsZgG1oyi8KGBU9rH47XXNlqgBJ2G2csN2ZTclj7UfmqTk8H9F+16V
 mXppBHyJMSD5hAViWs4aca7TK1umxsEpojOl2jgfFV5TXBx4txiXrNRIkXnrynUMQe16hZ
 d6OLDzT9fxevjW7i14zZo/ximCNIS6Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-R34bvMxbPoO7ysIhj6iwpw-1; Sun,
 04 Oct 2026 06:25:58 -0400
X-MC-Unique: R34bvMxbPoO7ysIhj6iwpw-1
X-Mimecast-MFC-AGG-ID: R34bvMxbPoO7ysIhj6iwpw_1791109556
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC98918089B6; Sun,  4 Oct 2026 10:25:56 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91D351956041; Sun,  4 Oct 2026 10:25:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:53 +0400
Subject: [PATCH 39/63] hw/char/terminal3270: fix output buffer size for
 IAC-escaped header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-39-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Collin L. Walling" <walling@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mKAiuVCtk8I7UF3o1S0fYJhdDboHueMpLmEiyMv+9Qc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikk94UuU18sAtWYErtTwC1lQ+vHYuMue8RZd
 TD/WijnqzmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5YoWEACTPUiYn6lAgpVZdBpLUTkzfESx3V372d+nh5P81q+r2jutyFphxxqZjn6qVLcmaFpWxik
 Oxa1zTtHLDJRB+/FwutLECbna6qcp7frC+MwID5Tjq2EnbOfOEQ3TzCJX8DaRRnwczezjynj/fs
 TGHcuqs247SWavtXdoqoGx/owlbcREyTaD8RF26WqX6zMjDkYntrbUeDhLC9+xSBG687ZfBNSRC
 8zZ9zooAjTX/0SOzJ+wewDl3EVOVDAJJaZzFP0TcCMTcaVA45o/FS8rHTmRYMtviH9y5su8VmAn
 jAAAKn4etfGMJ4FOSFtV656JzfI+hj9gXO7JET5fnUEm04s6jSELP7fFwH0gMrIpYHjVmfcjklX
 vGj+k+KGbhjSqHuDPRv2rvZ8JjcxsCo3v9eirUmHHbMqmmQ4gNDKK2Ize3GHTP8NIuTyhIZTOT9
 lJbfXIrdyyroI+bF+UTARH/AKhQSw9/Yq3ygFSoqG99WR3d5Lw1fmbZpSlYevbsjihYm2Ev+3yv
 Sw5VheO+pA8V6k0lY7VsUDUsxPogHen7cODW2X/Ynd0JTL23Qr/EdTPsFV+5F923nz/aStNFVDE
 EcsspoLnZP8nuCKSFk9aozlYpWZwV6fwMR7rgIwHRSfJ1ootZ3MjB0+OQQ25KYxJ4FlDD0c/Ulu
 7HJi+W7iCiGZKNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The cmd byte prepended to outv can itself be IAC (0xFF), which
insert_IAC_escape_char doubles. Worst case is 2 (escaped cmd) +
2048 (escaped 1024 data bytes) + 2 (IAC+IAC_EOR trailer) = 2052. The old
size of 2051 could cause a 1-byte buffer overflow.

Fixes: 2dc95b4cac5e ("s390x/3270: 3270 data stream handling")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/terminal3270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 989b6f6ee1e0..8247a07a54e6 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -23,10 +23,10 @@
 /* Enough spaces for different window sizes. */
 #define INPUT_BUFFER_SIZE  1000
 /*
- * 1 for header, 1024*2 for datastream, 2 for tail
+ * 1*2 for header, 1024*2 for datastream, 2 for tail
  * Reserve enough spaces for telnet IAC escape.
  */
-#define OUTPUT_BUFFER_SIZE 2051
+#define OUTPUT_BUFFER_SIZE 2052
 
 struct Terminal3270 {
     EmulatedCcw3270Device cdev;

-- 
2.56.0.rc0.29.g47ce80527c56


