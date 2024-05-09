Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC74BC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 00:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4rfR-0003j0-I9; Wed, 08 May 2024 20:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4rfP-0003if-V0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 20:29:47 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4rfN-00060H-VT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 20:29:47 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c98820fc92so170925b6e.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 17:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715214583; x=1715819383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TcxPz/j7uQmgiv8dY8Bjvqko1FYFFlvbV7izjEyHil8=;
 b=VmreaRGAAUNKYeMsZ+6JTNHEZg923x+BTmi7fAbFhn1u4iLJu6Otad0Ikffy2OtiAS
 06e+2DT6CP79mc/Uu2zJcpYUCH32EPdVKsxyZ3RlMc12ziz9py27WeR8V1JiuDwY8krv
 z5QDExHMa0U2fFg0fOPh1BRstl7KJB4VjOm5xO2rSnt3t+F318LeRPWCLE5R+GbHZjf5
 yQl58qSg+t1kxyzuAsbZRLIr+azbs2JiYN6SrJc78yoZfCLgZVhXhdi0NNqUYfkBHnDs
 x2GWQ/9BNSlxYxjAbz499UhotWAV5CGNhkbzL24CONkeCC7eZQtJUhGhzHyGexWszL1F
 K29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715214583; x=1715819383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TcxPz/j7uQmgiv8dY8Bjvqko1FYFFlvbV7izjEyHil8=;
 b=YkasmmJc785bhncE0KQzjY0tpCiOh0irUPmKOYPKGNwTeWgd1QHaMMTCDgfCpBCfxc
 oiQql/61ffcpXIUkWOS3Zo7Uj1EtKvYGIZz1sBpuR1UZEz+i02vWB14ltmrUrto4H7bh
 xhUTS9MMltZEunxIb2WL1Um8sNLlz86M2EQXIqiUMoNGo6kdZxzijULnvzG6mT9ItUq/
 937ujFN+NmhF0ysk/jv7aAUX/uyw9rxdmz6hG1M9OyQjIo1hYUnOQsKXpGQ9sFItbwjA
 1z5GxzQQpjiPRG5+rlxt4ORpk1ILFeOTjRpXlnVGF0WxHQ8isK0cNPJhvwfl9pQ7Xjhc
 Pz6Q==
X-Gm-Message-State: AOJu0YyW84Orn6nOcWJGqg/lN8DVoxraVotKwR2kYUMSFTHDEtvGqEHL
 iRv8Qa82bjr87HnaXOUDhRDjJJxj8Zbw/A6AOkxCi27gECtXEZ4dOjQjrg==
X-Google-Smtp-Source: AGHT+IHAldNvvtuyRh2ermQJBnqwjuMnJDcz3TL9m/NcPWRkmQSNcJmR7RGRX3nxrAzjPrCxvwchYQ==
X-Received: by 2002:a05:6808:1707:b0:3c8:42ea:ec52 with SMTP id
 5614622812f47-3c98d911c70mr518546b6e.16.1715214583244; 
 Wed, 08 May 2024 17:29:43 -0700 (PDT)
Received: from mintleaf.lan ([136.49.150.227])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c98fd13eb7sm45315b6e.47.2024.05.08.17.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 17:29:42 -0700 (PDT)
From: David Hubbard <dmamfmgm@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 Cord Amfmgm <dmamfmgm@gmail.com>
Subject: [PATCH 1/2] hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
Date: Wed,  8 May 2024 19:29:16 -0500
Message-Id: <20240509002916.138802-1-dmamfmgm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cord Amfmgm <dmamfmgm@gmail.com>

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

Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
---
 hw/usb/hcd-ohci.c   | 5 +++++
 hw/usb/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index fc8fc91a1d..acd6016980 100644
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
index ed7dc210d3..fd7b90d70c 100644
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


