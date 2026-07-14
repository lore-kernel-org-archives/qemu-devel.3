Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D53C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgCK-0006Tf-Kk; Tue, 14 Jul 2026 12:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wjgC9-0006Sj-Bs; Tue, 14 Jul 2026 12:41:22 -0400
Received: from nx82.node01.secure-mailgate.com ([89.22.108.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wjgC6-00080C-Ug; Tue, 14 Jul 2026 12:41:20 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wjgBu-00Bs5A-JG; Tue, 14 Jul 2026 18:41:07 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1784047266;
 bh=el0HoUB5x5fZILT2EUUWHcPTTYSg6ng3QIg9CRt+0WI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M5H8b1K+Mnzce8Hb6soJOXPOUl5b0C08p2C3+YLI4K6JtXwTmv4nXWYyT1kcBRM0G
 UX2H7xl9BP2YiuiYbs5JmoXzr6EYx4f5iB3sTYR2QQvciQIo6HyML+OO1KnEDs4anR
 uVM14C4tokqYCb/gM9b2qqhzZEk1KBd2W9Spb+XY=
Received: from Zeuss.fritz.box (p549f1d24.dip0.t-ipconnect.de [84.159.29.36])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 8FE752810E3;
 Tue, 14 Jul 2026 18:41:05 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Christian Quante <christian@quante.one>
Subject: [PATCH v2 1/2] hw/block/fdc: select the drive named by the READ ID
 command
Date: Tue, 14 Jul 2026 18:40:30 +0200
Message-ID: <20260714164031.60551-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714164031.60551-1-christian@quante.one>
References: <20260710113134.43012-1-christian@quante.one>
 <20260714164031.60551-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178404726616.1135152.14979516106346683945@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXboTTBINOwKDrNecZWuotAz3Jg0L9EKvVH
 P9SfKrMnYyu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4abgStKNbq5MLit/CaXNOGRS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMPx4XSOO6RFTrifNgKO3ZgdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEG9vh2CZ3C
 vkagHub+zVCHrxrAiQ9LrFKjKskiGXdOYidSx60qOlSfAsFXHIT+f9iB8EoVG9/3Z8UcmvWRxLLu
 Bqp2buWYGcRodxdIVEW2AixoUHGIFFY3hj94I7h01JLP6kWnNRRD1T6UtCJeW76YJof7DcZmGi54
 ckZ0KYZXkqE5i2r4cTdYbzmYgOLfvgNbTLI4mApQSb82F3IxlQZQ+bY/D8Yr0PSDgwbKOzCk9Ffi
 4UODV2TyeYkbZU3FioK8fmzXe6c5BASMPikUWdbUhVWt8bxl36fNuifGuwxKzi7t21KsUCuSAQsw
 QXHoMm9jBR1NQG583+Fa9XW4zMjPgfDmFXUguYY94jIgHLgmH2EQOJ++KnKyzbSfl29jHFoCcxw3
 qqhc+N6cuEg4XWh5FkxXt7K4WBN1lG+uDWMHDrdVlECoDgYG1JhQT0Ay4EWe+ObKl8isRHtISLVB
 jVI+vLl9w5vNH79mizAmLIPehq9d9a22HJX+W8SGifcrifwfyqMiX/jC/uHfVZ6iinMPeOclUyJb
 BSyvxj0oIoSG6NIitpmm5DgtgPK3Gxw13gOsWAD+iZ3xFUlgubiDvmaVC7kuwAHEwa3cpSwIhCK1
 j7m1k8uf5ICnR0qXy5nDNa7Z/gsb2NT27hFnZpKNG2cIAzuhTfMFyWVdny3UWcHl6zVm4zuNRcgR
 KiGg7nXFaZTx/KidTSB2vQn7N4r+hy5cpH2MQyMBT9gmv20pPZrWDObuDt1go+O18KT9hQ3dDK7R
 xkc6wjwuhxkPlEk4fhqurX/Prin5M0w7xf6UuY/7STn4pTpxobFuL+e0fy34oD/dxiNbsjereLkW
 gsURV114dItupJuNxKcL+2pZZcYhMTXxq/veyQSNzud/gCoulLjGMS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.82; envelope-from=christian@quante.one;
 helo=nx82.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Every other command handler begins by latching the drive from the command
byte:

    SET_CUR_DRV(fdctrl, fdctrl->fifo[1] & FD_DOR_SELMASK);

fdctrl_handle_readid() does not, so it works on whichever drive happened to
be selected last.  A guest that issues READ ID for a drive other than the
one currently selected gets an answer about the wrong one.

It has gone unnoticed because a driver normally writes the DOR to spin up
the motor first, and that write selects the drive as a side effect.  The
controller does not require it, though, and the command carries the drive
number for a reason.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Christian Quante <christian@quante.one>
---
 hw/block/fdc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2c1681b7d0..9b2409cfa4 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1936,7 +1936,10 @@ static void fdctrl_handle_save(FDCtrl *fdctrl, int direction)
 
 static void fdctrl_handle_readid(FDCtrl *fdctrl, int direction)
 {
-    FDrive *cur_drv = get_cur_drv(fdctrl);
+    FDrive *cur_drv;
+
+    SET_CUR_DRV(fdctrl, fdctrl->fifo[1] & FD_DOR_SELMASK);
+    cur_drv = get_cur_drv(fdctrl);
 
     cur_drv->head = (fdctrl->fifo[1] >> 2) & 1;
     timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-- 
2.53.0


