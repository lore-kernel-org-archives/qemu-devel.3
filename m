Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1804DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10F-0004gq-TZ; Fri, 31 May 2024 08:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD100-0004Wu-4x
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:44 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zr-0003Wv-SB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:43 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ea9afcb22aso2656481fa.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157074; x=1717761874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NWDApggyMUwqlr/49GITBZT6GHohqUhXi/8+w7dnERs=;
 b=ENtDf8TqJUJQUVQ/5LZ65GGqF/TBLM2EONWCPLf/Fzbg23JYYbtRiXXvZue5yt08zj
 YN/wqeyn16pzAcrhTYqpKkAxnF4eqDUBcv3qzuPqCVS8Up+l5jEhdLC61LNyE4mOvn7m
 5iHO5AGrXM9Y0ARkqKjgXTMXYhWwA38PcxdJsVmLVbV+c5hNi1D2UVcdsmwiqvkSfgxc
 fkyJQJPPMIu+AgnZEp+1KDz+XWJFnsi6GLEu9DQSzYBTb7gy1hi4tHJ/0DgHm9WEqWJ4
 L+0842g0lnchhJJFGBav8A2SVpxoepUXoKH3PRVWuEWzQFxcU0K+tDqEBjd17ZBf8Mo9
 1r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157074; x=1717761874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWDApggyMUwqlr/49GITBZT6GHohqUhXi/8+w7dnERs=;
 b=eKAvoK8F9Ba2kyCtnD2iV/H7x1nwj0l/elq3o2HKshSeDlUO0tklUfwq2EVKNbR/v5
 Pml/9n9tG78jvdgiGiV2i1v/PCmP1QSTOfV+SIh2znwgwBk8YDy39FVwE/y7MIsUjdYR
 kuAthDz2c64n8Lqlt+CUNEttREkV5BWQ5Qa1MOO4zgfg3awMPFs34cuFifC3SmDX6iuk
 bj0Y9JVUnRAnLYZbV9Fimnmzad/mrGg8vmhUUbpIKIvhQFq9RfMRfSWlGnNXRa1kWrz4
 VI1arq9IatIhapVjEI7g+VJX7n92OjgeN009aYZfIHhpGuNVuw2arb6ZNFZlUxKQFDon
 UUnw==
X-Gm-Message-State: AOJu0YwTfv3AdlWw1mT5lwMG36DYqSjCexPzrczokfmlr3M4IIKHeruY
 griZQ8tlG4cQbuFmt3Znd5cn7GfvLBaBCPwGFomAAr9Ct2xDKpBAxcCI4LAA+8cLeuudL5mdP1L
 K
X-Google-Smtp-Source: AGHT+IF4bZu2Gf6zkUHon/3KK8cjzp5YVCSTyCXv14jnGa7wKJKzF+jTcPKo4vgTaVMVIOOkkuH4fg==
X-Received: by 2002:a05:651c:1687:b0:2ea:938f:a232 with SMTP id
 38308e7fff4ca-2ea951a9e43mr11151361fa.42.1717157073943; 
 Fri, 31 May 2024 05:04:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
Date: Fri, 31 May 2024 13:04:01 +0100
Message-Id: <20240531120401.394550-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 hw/usb/hcd-ohci.c   | 5 +++++
 hw/usb/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index fc8fc91a1d1..acd60169802 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
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
index ed7dc210d3f..fd7b90d70c0 100644
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
2.34.1


