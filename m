Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D5CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQE-0001O3-3U; Sun, 04 Oct 2026 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPx-0000IG-MS
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPw-0003NW-9E
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w81XpDpwd0v3sQ3ybcLH8Gi4fe9BVrOl9nH8BV2J58Q=;
 b=AVtuSNsZOZ2F/O4ZRtLYZRR8lML8iSOOrPi9j1c2NUYdRBF+plxIcz60u8FCUM2P2kPedg
 lRb0cDyHQusAB2bhcXfi7b5PPxBWpUCR+3Uabx7ChvXqyM+1q9+wM7k3iMHwDdmXLCgxnr
 8pMlkHhHWY75FILammNH4n6FPjWhwD4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-GoU7kaODNr6RstwO-mWXDA-1; Sun,
 04 Oct 2026 06:26:02 -0400
X-MC-Unique: GoU7kaODNr6RstwO-mWXDA-1
X-Mimecast-MFC-AGG-ID: GoU7kaODNr6RstwO-mWXDA_1791109560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB5C61954B08; Sun,  4 Oct 2026 10:26:00 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 849841800348; Sun,  4 Oct 2026 10:25:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:54 +0400
Subject: [PATCH 40/63] hw/char/terminal3270: consume processed input data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-40-ccbef537cbeb@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j5wbfaIVok2Tn4UC8uPzrtNjQbCY9vRDypl6tqMC1iw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkJrFT9tVpH2HAeBST2H/gKMoZV+jp8hXqA
 Al41YQ0MMKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5RkuD/9Ib7ct+l/UnRpdw97wvDaD4veQcN6M7Lg494WtRYXxikD6u2HTV50AMaON9RBXuqfl+YO
 tI4P4WAtkCfOB4YtIm5GvDH3i3QLvUZXKYLOtHc1WImdGx8LSfbbyd8ExV1k30Fst46fHtHoIHw
 hxKGrgqk9RsYKR3Oi0iy9gbsf5kYZ5Zhihr4iXrQwOrFVGrWTG97sDSMk3sPmoArQLZljGeAoit
 hp/CTWXcdbGkW8wB4lFkcao7TnpP3nuCLypXfpuESfZqQk371HK2Wd6/ULx0iWyhZotKZoPsufY
 k30RKuOQRomdJq8CuSjyyEp6wtBNb2mhDElUwcKI+GwXaEQNYx/HPv/CT5f3eU/XX/PoK9Nn+H5
 HZ3DNRfHm3Lhq57CO7RvHpMQKIX57XBvyzPitQEfVMqavpSeM0JW5sKhF+um0O86BhnPL+YB8xG
 DJdoE2Kg0IHeAoCJ70FSDS6T/W9wZNfGRHrE/u6v/KA41zmO+l2a97+3pruzsfrr1tASJDIs8oF
 ctshJ3kQrlzuq5WMv8HQmjfU8bg/sKI55VwTr40EXCxcT8qtmTJflFw2aT0ivmC2f+eu0vskU/n
 ncmNQs4ndRhXrA/jMSdQi8uJIQQUW14EtfvLvLaONnrGWJqJshiCq2IE4EGcY12soZrZnuKcan/
 ynR6RqM+F0epE7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

read_payload_3270() decremented in_len after consuming bytes but
never shifted the remaining data to the front of the buffer.
Subsequent reads and appends in terminal_read (at &t->inv[t->in_len])
would reference wrong positions, re-processing stale bytes.

Add a memmove to compact the buffer after consuming a payload.

Fixes: 2dc95b4cac5e ("s390x/3270: 3270 data stream handling")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/terminal3270.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 8247a07a54e6..506c7a77eac1 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -205,6 +205,9 @@ static int read_payload_3270(EmulatedCcw3270Device *dev)
         return ret;
     }
     t->in_len -= len;
+    if (t->in_len > 0) {
+        memmove(t->inv, &t->inv[len], t->in_len);
+    }
 
     return len;
 }

-- 
2.56.0.rc0.29.g47ce80527c56


