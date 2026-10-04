Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA042CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQF-0001ec-VD; Sun, 04 Oct 2026 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ2-0000Ro-PU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ1-0003Nz-3o
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1Hzj75ZS0FKYExK+NyQIhyVjcHUUSfTC1NQBIoAR3c=;
 b=Ru/Tr2uaRQOgqWiByOZHgomh2zR2zs5lLaeSjE6PAa73bbv/mz9R7QImircTh9yDBrKbNM
 5vHYyUeog6CS+WErGsNNhbnDtCVr+awniLDAoT58YuY2Ds/zJmd6xgTcsY8uibeZsUHP3z
 a0zZ7153pfTy90vtpWxFToAfRZ5Noeo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-H9--NaYSME6KIxkmJ24j3Q-1; Sun,
 04 Oct 2026 06:26:05 -0400
X-MC-Unique: H9--NaYSME6KIxkmJ24j3Q-1
X-Mimecast-MFC-AGG-ID: H9--NaYSME6KIxkmJ24j3Q_1791109564
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D329195FCD5; Sun,  4 Oct 2026 10:26:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EAA35BC; Sun,  4 Oct 2026 10:26:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:55 +0400
Subject: [PATCH 41/63] hw/char/terminal3270: fix pre-handshake outbound
 data check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-41-ccbef537cbeb@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MHlK9FjIwX6bLxntMnNVMkHIRG9kCbM2K0nP7Ihc3D0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkq0DTNEnDn4K+zJw89pk4EGhHuKLXxPf74
 kjScD7Ip4yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5eSED/9aZ9UTXN/JW0wN8t6dRBUjyHotYXgY3F0hWtSWWyeZ/7hVCVXP8+RNrGW/GdQH6Hwd7nz
 nX9VzPkljJhcEkl7y80nCAqcK407/Xk2tP4wvsvCFjICtXOUeEdqAhjCUbeuLcFsecogimzxWII
 YCY++SJ4s5LPwvfcCzXTYQXSWav48LcWvLDmJsQngZPoZuV6ikgHI/+6h2EFPALw4NJxeFq7FgA
 LK7wF1s4SUkeHFn1V49Ue+/oWvgoW5kzVclijFEHSoSnfpYvfhy88iCJkkd9i9Mu41uTRzoFSzm
 1K5j7g+rS5BdsEPLaN1G8qpoGGvViMe9PZjNthDdIxUL5yP82BA9iBOICykL80z55EiOlIrIqfT
 2SnKk+4pFq7q4dXK/dY2QyHhae2PsqiWIJk0wmkCw+pNgdoUmyx/mDREoen6yOKjt3z28dlwkR/
 dy0Vn43g8bD3DJ9TqWk874by/Op+5kJnqmugjyag2m9eW1B80JTQ1OpFLDWu65Gc52ZzqB9JdYQ
 KITWuWU/7nJ/vPXO3a0TX17DyMwVhPWR3kDeWjvwLsN5KUzURha4mvd8T2iVGbO7aqJa0OwpzTh
 OyIr33KR7Ui+/k613KfzHH8sci73oHEAMYU8DQ9zbB2g/UKGSEHspaRfH8mGO0zM/UB002gdwW+
 W99tdiOibPyjgfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

write_payload_3270() tried to allow telnet option negotiation through
before the handshake by inspecting outv[0] and outv[1]. However, at this
point the buffer has not been filled for the current call, so it
inspected stale data from a previous write.

Telnet negotiation is handled at the chardev layer, not through the
CCW device path, so unconditionally blocking outbound data before the
handshake is correct.

Fixes: e65a27209ca8 ("s390x/3270: Detect for continued presence of a 3270 client")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/terminal3270.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 506c7a77eac1..ad7f5d947291 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -249,13 +249,7 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd)
     int out_len = 0;
 
     if (!t->handshake_done) {
-        if (!(t->outv[0] == IAC && t->outv[1] != IAC)) {
-            /*
-             * Before having finished 3270 negotiation,
-             * sending outbound data except protocol options is prohibited.
-             */
-            return 0;
-        }
+        return 0;
     }
     if (!qemu_chr_fe_backend_connected(&t->chr)) {
         /* We just say we consumed all data if there's no backend. */

-- 
2.56.0.rc0.29.g47ce80527c56


