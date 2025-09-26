Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0533CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27tN-0002aH-IH; Fri, 26 Sep 2025 08:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27sz-0002GE-FB; Fri, 26 Sep 2025 08:49:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27sl-000791-Ic; Fri, 26 Sep 2025 08:49:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A00A0157F5C;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C539290F1A;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 20/38] hw/usb/network: Remove hardcoded 0x40 prefix in
 STRING_ETHADDR response
Date: Fri, 26 Sep 2025 15:45:20 +0300
Message-ID: <20250926124540.2221746-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stéphane Graber <stgraber@stgraber.org>

USB NICs have a "40:" prefix hardcoded for all MAC addresses when we
return the guest the MAC address if it queries the STRING_ETHADDR USB
string property.  This doesn't match what we use for the
OID_802_3_PERMANENT_ADDRESS or OID_802_3_CURRENT_ADDRESS OIDs for
NDIS, or the MAC address we actually use in the QEMU networking code
to send/receive packets for this device, or the NIC info string we
print for users.  In all those other places we directly use
s->conf.macaddr.a, which is the full thing the user asks for.

This overrides user-provided configuration and leads to an inconsistent
experience.

I couldn't find any documented reason (comment or git commits) for
this behavior.  It seems like everyone is just expecting the MAC
address to be fully passed through to the guest, but it isn't.

This may have been a debugging hack that accidentally made it through
to the accepted patch: it has been in the code since it was originally
added back in 2008.

This is also particularly problematic as the "40:" prefix isn't a
reserved prefix for MAC addresses (IEEE OUI).  There are a number of
valid allocations out there which use this prefix, meaning that QEMU
may be causing MAC address conflicts.

Cc: qemu-stable@nongnu.org
Fixes: 6c9f886ceae5b ("Add CDC-Ethernet usb NIC (original patch from Thomas Sailer)"
Signed-off-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[PMM: beef up commit message based on mailing list discussion]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit aaf042299acf83919862c7d7dd5fc36acf4e0671)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index a87a0ffb95..e01a0389d4 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
-             0x40,
+             s->conf.macaddr.a[0],
              s->conf.macaddr.a[1],
              s->conf.macaddr.a[2],
              s->conf.macaddr.a[3],
-- 
2.47.3


