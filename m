Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8D1C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 23:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9CN7-0001WP-3C; Mon, 20 May 2024 19:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9CN5-0001WF-Pe
 for qemu-devel@nongnu.org; Mon, 20 May 2024 19:24:47 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9CN3-0007vA-UJ
 for qemu-devel@nongnu.org; Mon, 20 May 2024 19:24:47 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24544cfbc69so1424547fac.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716247484; x=1716852284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sb5gskDTc9Zd2NG0KxNpeYakIpCxke5KbIAJR8+R1pk=;
 b=geZSBPkRXYskfeX3RRaAzXnoBCMzTYxKp1rFIeaT8UophAD7RyH5OF8DvhA9/mopeH
 rOa4ng9MmH1zzRTsDWz1OmEFvsoOoMcjmQkiOw042j47ggb51VH7yi8fLBi26No4Ef1w
 v2Ug63H9DSK7w+X5URqjJx4Algz8yN0rNYhldjbb96YhxjxFbLKirZqWbXW5QouxWPmu
 n9Wj4bWwYiHyp9rPuL185NQzgkYLpLeWI9gJIF5FbOQGTabyOlya5adxQQfe0y3dymgI
 7CDD1ggndRY9rzEJ9LTsHmVvfgEW/K3zjNIALyaCIlDPbPXfv0DECQBMCEZdej0njgn6
 tKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716247484; x=1716852284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sb5gskDTc9Zd2NG0KxNpeYakIpCxke5KbIAJR8+R1pk=;
 b=IfkAp6ZpfJ5w3PmT6+/f8Qpm0OT0/790KT8VKSEyXZgaNdc0NMxiqpBlFrWxYvVRwm
 NcuxWc+Q5j/HcX7RA2POUhADkG9fW4YLKWHUdnj0XwkDAWUE1xZ6hKFXstrunPVoM8us
 Ls9hlkXq2T5BtUHJk909l0z+hL4ir2PL8b6JHBKPExvKQkg31zRRtcf5An/6iTNKRZyN
 aletyngMH6UvOyR7KHdDBLpvZMWMxa2t970mYb2OzyULeVQARlRRiwsSayUX/BYZvOlU
 1eTXihPgBls0hG69Jagoc6PsyMt6yiJ4TGp7sG/Yp/cjr8spOHNxH1HbT70jwiL8+X3x
 JHxQ==
X-Gm-Message-State: AOJu0Yz8e1+gOlJQ7PGWTykVtX35U9DhmxHcyYfi1yraEimOKHKHasWN
 3vCgntdPGpdIkGYpfcBhrR3p+G32oauxgYo/xrgbp7ILzgOb8JuQly8/zA==
X-Google-Smtp-Source: AGHT+IEJZCYC6NB5WcBiHT9tSEVmbK5CWaYKgYd6gmvYosYG4FInY3PxuVSvtHXHCPjrXuwCdW5ULw==
X-Received: by 2002:a05:6871:4408:b0:239:52f9:7f15 with SMTP id
 586e51a60fabf-24172bb6e18mr37660172fac.26.1716247484134; 
 Mon, 20 May 2024 16:24:44 -0700 (PDT)
Received: from mintleaf.lan ([136.49.150.227])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f142e3fdf2sm941544a34.52.2024.05.20.16.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 16:24:43 -0700 (PDT)
From: David Hubbard <dmamfmgm@gmail.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>,
 Cord Amfmgm <dmamfmgm@gmail.com>
Subject: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
Date: Mon, 20 May 2024 18:24:34 -0500
Message-Id: <20240520232434.317879-1-dmamfmgm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

From: Cord Amfmgm <dmamfmgm@gmail.com>

This changes the way the ohci emulation handles a Transfer Descriptor with
"Current Buffer Pointer" set to "Buffer End" + 1.

The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than td.be
to signal the buffer has zero length. Currently qemu only accepts zero-length
Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardware
accepts both cases.

The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
and earlier matched the spec. (I haven't taken the time to bisect exactly
where the logic was changed.)

With a tiny OS[1] that boots and executes a test, the issue can be seen:

* OS that sends USB requests to a USB mass storage device
  but sends td.cbp = td.be + 1
* qemu 4.2
* qemu HEAD (4e66a0854)
* Actual OHCI controller (hardware)

Command line:
qemu-system-x86_64 -m 20 \
 -device pci-ohci,id=ohci \
 -drive if=none,format=raw,id=d,file=testmbr.raw \
 -device usb-storage,bus=ohci.0,drive=d \
 --trace "usb_*" --trace "ohci_*" -D qemu.log

Results are:

 qemu 4.2   | qemu HEAD  | actual HW
------------+------------+------------
 works fine | ohci_die() | works fine

Tip: if the flags "-serial pty -serial stdio" are added to the command line
the test will output USB requests like this:

Testing qemu HEAD:

> Free mem 2M ohci port2 conn FS
> setup { 80 6 0 1 0 0 8 0 }
> ED info=80000 { mps=8 en=0 d=0 } tail=c20920
>   td0 c20880 nxt=c20960 f2000000 setup cbp=c20900 be=c20907
>   td1 c20960 nxt=c20980 f3140000    in cbp=c20908 be=c2090f
>   td2 c20980 nxt=c20920 f3080000   out cbp=c20910 be=c2090f ohci20 host err
> usb stopped

And in qemu.log:

usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=0x00c20910 > next_offset=0x00c2090f

Testing qemu 4.2:

> Free mem 2M ohci port2 conn FS
> setup { 80 6 0 1 0 0 8 0 }
> ED info=80000 { mps=8 en=0 d=0 } tail=620920
>   td0 620880 nxt=620960 f2000000 setup cbp=620900 be=620907       cbp=0 be=620907
>   td1 620960 nxt=620980 f3140000    in cbp=620908 be=62090f       cbp=0 be=62090f
>   td2 620980 nxt=620920 f3080000   out cbp=620910 be=62090f       cbp=0 be=62090f
>    rx { 12 1 0 2 0 0 0 8 }
> setup { 0 5 1 0 0 0 0 0 } tx {}
> ED info=80000 { mps=8 en=0 d=0 } tail=620880
>   td0 620920 nxt=620960 f2000000 setup cbp=620900 be=620907       cbp=0 be=620907
>   td1 620960 nxt=620880 f3100000    in cbp=620908 be=620907       cbp=0 be=620907
> setup { 80 6 0 1 0 0 12 0 }
> ED info=80001 { mps=8 en=0 d=1 } tail=620960
>   td0 620880 nxt=6209c0 f2000000 setup cbp=620920 be=620927       cbp=0 be=620927
>   td1 6209c0 nxt=6209e0 f3140000    in cbp=620928 be=620939       cbp=0 be=620939
>   td2 6209e0 nxt=620960 f3080000   out cbp=62093a be=620939       cbp=0 be=620939
>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> setup { 80 6 0 2 0 0 0 1 }
> ED info=80001 { mps=8 en=0 d=1 } tail=620880
>   td0 620960 nxt=6209a0 f2000000 setup cbp=620a20 be=620a27       cbp=0 be=620a27
>   td1 6209a0 nxt=6209c0 f3140004    in cbp=620a28 be=620b27       cbp=620a48 be=620b27
>   td2 6209c0 nxt=620880 f3080000   out cbp=620b28 be=620b27       cbp=0 be=620b27
>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2 40 0 0 }
> setup { 0 9 1 0 0 0 0 0 } tx {}
> ED info=80001 { mps=8 en=0 d=1 } tail=620900
>   td0 620880 nxt=620940 f2000000 setup cbp=620a00 be=620a07       cbp=0 be=620a07
>   td1 620940 nxt=620900 f3100000    in cbp=620a08 be=620a07       cbp=0 be=620a07

[1] The OS disk image has been emailed to philmd@linaro.org, mjt@tls.msk.ru,
and kraxel@redhat.com:

* testCbpOffBy1.img.xz
* sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed

Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
---
 hw/usb/hcd-ohci.c   | 4 ++--
 hw/usb/trace-events | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index acd6016980..86caf5e43b 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
             len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
         } else {
-            if (td.cbp > td.be) {
-                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
+            if (td.cbp > td.be + 1) {
+                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
                 ohci_die(ohci);
                 return 1;
             }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index fd7b90d70c..fe282e7876 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -29,6 +29,7 @@ usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
 usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
 usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pid %s: ed.flags 0x%x td.flags 0x%x"
+usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp = 0x%x > be = 0x%x"
 usb_ohci_port_attach(int index) "port #%d"
 usb_ohci_port_detach(int index) "port #%d"
 usb_ohci_port_wakeup(int index) "port #%d"
-- 
2.34.1


