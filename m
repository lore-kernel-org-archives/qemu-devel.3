Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23541C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdtJ-00025A-TA; Thu, 29 Feb 2024 05:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfdtI-000251-Fl
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfdtG-0002II-Au
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709203427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i63b46w1LySKhhFANiCq+HAyYOnafoHBsZu2zDiOK9s=;
 b=VUnJvNRewrrfkv4su76oPcYeIjnPXsqCn2AHLVGjkKW4+UjfBJHN1lZZ1z7vExULpAq7tv
 811V50sws2hksLmchtDpeO25acMpZITLj+N4NJgYnKsrIY0WgCqG9g/s8xmfueCJOSTA57
 s/fhlqA/tHoNCAUyorLgYjgjRYodBBQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-VLOgZqEGP4urXiIRRklBGQ-1; Thu,
 29 Feb 2024 05:43:43 -0500
X-MC-Unique: VLOgZqEGP4urXiIRRklBGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C1BD29AC00F;
 Thu, 29 Feb 2024 10:43:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD941BDB1;
 Thu, 29 Feb 2024 10:43:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Antoine Damhet <antoine.damhet@shadow.tech>,
 Charles Frey <charles.frey@shadow.tech>
Subject: [PATCH] chardev/char-socket: Fix TLS io channels sending too much
 data to the backend
Date: Thu, 29 Feb 2024 11:43:37 +0100
Message-ID: <20240229104339.42574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
Buglink: https://issues.redhat.com/browse/RHEL-24614
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Sorry if you've got this mail twice - I forgot to CC: qemu-devel when
 I sent it out the first time ... *facepalm*

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


