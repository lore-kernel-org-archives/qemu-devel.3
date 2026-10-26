Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A233606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=QP5mcLZH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDi-0002YE-Mj; Mon, 26 Oct 2026 09:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDg-0002NZ-1d; Mon, 26 Oct 2026 09:58:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDe-0000Um-BH; Mon, 26 Oct 2026 09:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=AZnz7zC4Z2cKzTNX3Aj2mGwO+cF0OwQXQWuHpb5iioc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QP5mcLZHS842I45lz8XXXzxy0Ov0UY3gXbqVT3M+x8Y43v2Dq/aiNmymxGM8rJlik
 z/3cDmZ+KcsHkRzDeFg9r4PL2R/hR98XTIjG5Z5dUql18F2jjVzxqqFPgyfAKcJaW3
 hmMP6DbH3WhAXTNO7s2u+HtT9somLMiirhjGSamkLbIegdUShtCBoeq0lmMxdxMnqA
 Mj6CA0+RJax9PuK2XetlpO/uQ3TkpMGxZgWXSypwtSAJNAf0175lbuUTE8zA0uZNzf
 vgLToBXQfLo7JnfnC5wNxp/o3EsLVdqJsbPlbExscPWCCw1j7YtOwfmxlfb7Nw7jOB
 SMQgsblA5xHdg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 270301E12A5;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24B2C44B8F6;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 09244934D1; Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 88/98] usb-host: validate interface number before
 indexing altsetting
Date: Mon, 26 Oct 2026 16:55:15 +0300
Message-ID: <20261026135529.1019772-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

usb_host_ep_update() indexes USBDevice.altsetting with the interface
number supplied by the active configuration descriptor. A descriptor
with bInterfaceNumber >= USB_MAX_INTERFACES reads past that array while
the host device is opened. Skip such interfaces before the lookup.

Record the descriptor's interface number on its endpoints as well. The
loop index identifies the descriptor's position in the configuration,
which need not equal bInterfaceNumber.

Fixes: 0dbe4768b95e ("usb-host: use correct altsetting in usb_host_ep_update")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3975
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261005054626.131577-2-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e1b7f5e2a6715c4f7e9f5a4356101dc45b24b64f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b9f3ad3f66d..21c95427418 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -893,6 +893,11 @@ static void usb_host_ep_update(USBHostDevice *s)
          * then correct the alternate setting value if necessary.
          */
         intf = &conf->interface[i].altsetting[0];
+        if (intf->bInterfaceNumber >= USB_MAX_INTERFACES) {
+            trace_usb_host_parse_error(s->bus_num, s->addr,
+                                       "invalid interface number");
+            continue;
+        }
         alt = udev->altsetting[intf->bInterfaceNumber];
 
         if (alt != 0) {
@@ -928,7 +933,7 @@ static void usb_host_ep_update(USBHostDevice *s)
             usb_ep_set_max_packet_size(udev, pid, ep,
                                        endp->wMaxPacketSize);
             usb_ep_set_type(udev, pid, ep, type);
-            usb_ep_set_ifnum(udev, pid, ep, i);
+            usb_ep_set_ifnum(udev, pid, ep, intf->bInterfaceNumber);
             usb_ep_set_halted(udev, pid, ep, 0);
 #ifdef HAVE_STREAMS
             if (type == LIBUSB_TRANSFER_TYPE_BULK &&
-- 
2.47.3


