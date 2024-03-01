Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04583C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxyC-0003KF-9q; Fri, 01 Mar 2024 03:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxyA-0003J3-5E
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy8-0006wl-5R
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5R45Lc/B9oh0/zhXjUTXJbEhi/IWIqIJongcvYiTcK8=;
 b=c5A4dwpCT9BTwdE/3FpVwJdtE4j06uS8cZcJbWg6KyiBtytVLep3P+AH1ku6m4Qgklb6if
 8Ac55BOig4RAfseTcU64TzwnDvoAJN08HiiznAJly6AnYyBBpcGIncVfFlQ1Y1EY3+BybQ
 eOF4WIBmD2SJUseFrcR5W9LGWKFg6IQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-VLf0SUjdPQ-_BdHSaiv-EA-1; Fri, 01 Mar 2024 03:10:08 -0500
X-MC-Unique: VLf0SUjdPQ-_BdHSaiv-EA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31A2A868034;
 Fri,  1 Mar 2024 08:10:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 672E4201F362;
 Fri,  1 Mar 2024 08:10:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Antoine Damhet <antoine.damhet@blade-group.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/6] chardev/char-socket: Fix TLS io channels sending too much
 data to the backend
Date: Fri,  1 Mar 2024 09:09:53 +0100
Message-ID: <20240301080953.66448-7-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
References: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Commit ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
changed the behavior of the TLS io channels to schedule a second reading
attempt if there is still incoming data pending. This caused a regression
with backends like the sclpconsole that check in their read function that
the sender does not try to write more bytes to it than the device can
currently handle.

The problem can be reproduced like this:

 1) In one terminal, do this:

  mkdir qemu-pki
  cd qemu-pki
  openssl genrsa 2048 > ca-key.pem
  openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem
  # enter some dummy value for the cert
  openssl genrsa 2048 > server-key.pem
  openssl req -new -x509 -nodes -days 365000 -key server-key.pem \
    -out server-cert.pem
  # enter some other dummy values for the cert

  gnutls-serv --echo --x509cafile ca-cert.pem --x509keyfile server-key.pem \
              --x509certfile server-cert.pem -p 8338

 2) In another terminal, do this:

  wget https://download.fedoraproject.org/pub/fedora-secondary/releases/39/Cloud/s390x/images/Fedora-Cloud-Base-39-1.5.s390x.qcow2

  qemu-system-s390x -nographic -nodefaults \
    -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2 \
    -object tls-creds-x509,id=tls0,endpoint=client,verify-peer=false,dir=$PWD/qemu-pki \
    -chardev socket,id=tls_chardev,host=localhost,port=8338,tls-creds=tls0 \
    -device sclpconsole,chardev=tls_chardev,id=tls_serial

QEMU then aborts after a second or two with:

  qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
   `size <= SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
 Aborted (core dumped)

It looks like the second read does not trigger the chr_can_read() function
to be called before the second read, which should normally always be done
before sending bytes to a character device to see how much it can handle,
so the s->max_size in tcp_chr_read() still contains the old value from the
previous read. Let's make sure that we use the up-to-date value by calling
tcp_chr_read_poll() again here.

Cc: qemu-stable@nongnu.org
Fixes: ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
Buglink: https://issues.redhat.com/browse/RHEL-24614
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240229104339.42574-1-thuth@redhat.com>
Reviewed-by: Antoine Damhet <antoine.damhet@blade-group.com>
Tested-by: Antoine Damhet <antoine.damhet@blade-group.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 chardev/char-socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 67e3334423..8a0406cc1e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
         s->max_size <= 0) {
         return TRUE;
     }
-    len = sizeof(buf);
-    if (len > s->max_size) {
-        len = s->max_size;
+    len = tcp_chr_read_poll(opaque);
+    if (len > sizeof(buf)) {
+        len = sizeof(buf);
     }
     size = tcp_chr_recv(chr, (void *)buf, len);
     if (size == 0 || (size == -1 && errno != EAGAIN)) {
-- 
2.44.0


