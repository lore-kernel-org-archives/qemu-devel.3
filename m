Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF25C54E41
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 09:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgiDl-0001To-5q; Sun, 03 Mar 2024 04:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDf-0001SP-7o; Sun, 03 Mar 2024 04:33:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rgiDd-0006WN-FS; Sun, 03 Mar 2024 04:33:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41441527D0;
 Sun,  3 Mar 2024 12:33:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B5E1F8E8CC;
 Sun,  3 Mar 2024 12:33:04 +0300 (MSK)
Received: (nullmailer pid 1357016 invoked by uid 1000);
 Sun, 03 Mar 2024 09:33:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Antoine Damhet <antoine.damhet@blade-group.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 82/82] chardev/char-socket: Fix TLS io channels sending
 too much data to the backend
Date: Sun,  3 Mar 2024 12:33:00 +0300
Message-Id: <20240303093304.1356981-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240303104213@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

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

Fixes: ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
Buglink: https://issues.redhat.com/browse/RHEL-24614
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-ID: <20240229104339.42574-1-thuth@redhat.com>
Reviewed-by: Antoine Damhet <antoine.damhet@blade-group.com>
Tested-by: Antoine Damhet <antoine.damhet@blade-group.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 462945cd22d2bcd233401ed3aa167d83a8e35b05)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 73947da188..034840593d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -492,9 +492,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
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
2.39.2


