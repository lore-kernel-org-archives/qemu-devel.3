Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D64CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2QqQ-00041U-S1; Sat, 27 Sep 2025 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QqJ-000415-Kx; Sat, 27 Sep 2025 05:03:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qps-0006nr-IR; Sat, 27 Sep 2025 05:03:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19760158556;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EBF8A291573;
 Sat, 27 Sep 2025 12:03:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Hubbard <dmamfmgm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 01/16] hw/usb/hcd-ohci: Fix #1510,
 #303: pid not IN or OUT
Date: Sat, 27 Sep 2025 12:02:45 +0300
Message-ID: <20250927090304.2901324-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: David Hubbard <dmamfmgm@gmail.com>

This changes the ohci validation to not assert if invalid data is fed to the
ohci controller. The poc in https://bugs.launchpad.net/qemu/+bug/1907042 and
migrated to bug #303 does the following to feed it a SETUP pid (valid)
at an EndPt of 1 (invalid - all SETUP pids must be addressed to EndPt 0):

        uint32_t MaxPacket = 64;
        uint32_t TDFormat = 0;
        uint32_t Skip = 0;
        uint32_t Speed = 0;
        uint32_t Direction = 0;  /* #define OHCI_TD_DIR_SETUP 0 */
        uint32_t EndPt = 1;
        uint32_t FuncAddress = 0;
        ed->attr = (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14)
                   | (Speed << 13) | (Direction << 11) | (EndPt << 7)
                   | FuncAddress;
        ed->tailp = /*TDQTailPntr= */ 0;
        ed->headp = ((/*TDQHeadPntr= */ &td[0]) & 0xfffffff0)
                   | (/* ToggleCarry= */ 0 << 1);
        ed->next_ed = (/* NextED= */ 0 & 0xfffffff0)

qemu-fuzz also caught the same issue in #1510. They are both fixed by this
patch.

With a tiny OS[1] that boots and executes the poc the repro shows the issue:

* OS that sends USB requests to a USB mass storage device
  but sends a SETUP with EndPt = 1
* qemu 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.19)
* qemu HEAD (4e66a0854)
* Actual OHCI controller (hardware)

Command line:
qemu-system-x86_64 -m 20 \
 -device pci-ohci,id=ohci \
 -drive if=none,format=raw,id=d,file=testmbr.raw \
 -device usb-storage,bus=ohci.0,drive=d \
 --trace "usb_*" --trace "ohci_*" -D qemu.log

Results are:

 qemu 6.2.0 | qemu HEAD | actual HW
------------+-----------+----------------
 assertion  | assertion | sets stall bit

The assertion message is:

> qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.
> Aborted (core dumped)

Tip: if the flags "-serial pty -serial stdio" are added to the command line
the poc outputs its USB requests like this:

> Free mem 2M ohci port0 conn FS
> setup { 80 6 0 1 0 0 8 0 }
> ED info=80000 { mps=8 en=0 d=0 } tail=c20920
>   td0 c20880 nxt=c20960 f2000000 setup cbp=c20900 be=c20907       cbp=0 be=c20907
>   td1 c20960 nxt=c20980 f3140000    in cbp=c20908 be=c2090f       cbp=0 be=c2090f
>   td2 c20980 nxt=c20920 f3080000   out cbp=0 be=0                 cbp=0 be=0
>    rx { 12 1 0 2 0 0 0 8 }
> setup { 0 5 1 0 0 0 0 0 } tx {}
> ED info=80000 { mps=8 en=0 d=0 } tail=c20880
>   td0 c20920 nxt=c20960 f2000000 setup cbp=c20900 be=c20907       cbp=0 be=c20907
>   td1 c20960 nxt=c20880 f3100000    in cbp=0 be=0                 cbp=0 be=0
> setup { 80 6 0 1 0 0 12 0 }
> ED info=80081 { mps=8 en=0 d=1 } tail=c20960
>   td0 c20880 nxt=c209c0 f2000000 setup cbp=c20920 be=c20927
>   td1 c209c0 nxt=c209e0 f3140000    in cbp=c20928 be=c20939
>   td2 c209e0 nxt=c20960 f3080000   out cbp=0 be=0qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.
> Aborted (core dumped)

[1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk.ru,
and kraxel@redhat.com:

* testBadSetup.img.xz
* sha256: 045b43f4396de02b149518358bf8025d5ba11091e86458875339fc649e6e5ac6

Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: authorship and signed-off-by tag names fixed up as
 per on-list agreement]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3c3c233677d4f2fe5f35c5d6d6e9b53df48054f4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c3ab762f54..0ec786dd6a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -904,6 +904,11 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
     case OHCI_TD_DIR_SETUP:
         str = "setup";
         pid = USB_TOKEN_SETUP;
+        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to ep 0 */
+            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
+            ohci_die(ohci);
+            return 1;
+        }
         break;
     default:
         trace_usb_ohci_td_bad_direction(dir);
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index b65269892c..743308c75d 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -28,6 +28,7 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
 usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
+usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pid %s: ed.flags 0x%x td.flags 0x%x"
 usb_ohci_port_attach(int index) "port #%d"
 usb_ohci_port_detach(int index) "port #%d"
 usb_ohci_port_wakeup(int index) "port #%d"
-- 
2.47.3


