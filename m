Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36308C27C78
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWN-00081h-Hk; Sat, 22 Jun 2024 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWG-0007vq-Ve
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:07:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWB-0000LL-8l
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36226e98370so1740883f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058013; x=1719662813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jve18Aw+DXElxImmNe3vbSqsQnw0nVV2aO+SXUToPbM=;
 b=sbw789IcYF3R8wzS31wP0RDIyyGSMcepyBcofqor9WEGE4HRaU/AdUGhmjKEmO8wqr
 H514et12k7O8li8jc6BG1EoIdEjjGW8bI+ymPzz/9PQodvo3iAyYR0SB8rHuhZhxkXIH
 Soj8bCoAU5G3QOT4RBeUkMoqIi9oE7tqdp5WctEErH7VVh6w17eG644Z3YfvqCk7dHKz
 mwQ2pl7s7r75eWL5maVjWJGsnnvVkzzprLeEzG+S5+V1CKa2SjIt1XXzELtPhi6p27ke
 9qRkFSbo2gydnPG+DlieBglW+/hOu7xgP1lfVC0qcQEjKfrZXFWZEleL9GqKa+OmFDeC
 /pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058013; x=1719662813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jve18Aw+DXElxImmNe3vbSqsQnw0nVV2aO+SXUToPbM=;
 b=vAYrOCJ/Kz7wDhfK7w0l37qBoE1z81r/d11FjtVNDRsqbt3gIQcQfNwbRmtHgkf4KO
 OSO1Em4r71PD0d0yAYF2UJowNiruwL8uAObwljCKFB3YQQ76NM2/7VWRSdhpgjDmHG8w
 46hmF3Kyz2xSMv1F6OYUhrhv0yc8/7wJjuruILJRgyyBfDW2cslv2dtmfEhF+io3CjBe
 6qaHSWV3MJMC5569HNbMbo8P8UWiATztS36kUdMLeoG0BFdGOWzlgNr6oE9ZC3QWA2gW
 DKcibJOX9jHteuCnRdHpTZnvvbxfFD9q2Q+Nn9PVUI8YaWgsomV4BY0cpB2I+mRBrKXM
 1xMw==
X-Gm-Message-State: AOJu0YwjQpF6PDTE7mD8MfMMhkkDv5PkdNU4n7574rPniHecDILT6gt6
 /o3EBAc1ucAOlzbFst25pg64fRAgcOJqnsYkPuOvgZ4pCq64AbhaLthb6zd94ELFs1X08WjgEZl
 ZA30=
X-Google-Smtp-Source: AGHT+IGS+laLieagrKLQYNNUzqTRRlO/ERjiD26KXil9cLAvRRkTpBocgWsMqKrZV6psScvYJeBbng==
X-Received: by 2002:adf:fc11:0:b0:35f:2364:f1d9 with SMTP id
 ffacd0b85a97d-363199906fbmr7478812f8f.61.1719058013115; 
 Sat, 22 Jun 2024 05:06:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] hw/usb/hcd-ohci: Fix ohci_service_td: accept zero-length
 TDs where CBP=BE+1
Date: Sat, 22 Jun 2024 13:06:42 +0100
Message-Id: <20240622120643.3797539-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This changes the way the ohci emulation handles a Transfer Descriptor
with "Buffer End" set to "Current Buffer Pointer" - 1, specifically
in the case of a zero-length packet.

The OHCI spec 4.3.1.2 Table 4-2 specifies td.cbp to be zero for a
zero-length packet.  Peter Maydell tracked down commit 1328fe0c32
(hw: usb: hcd-ohci: check len and frame_number variables) where qemu
started checking this according to the spec.

What this patch does is loosen the qemu ohci implementation to allow a
zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and with a
non-zero td.cbp value.

The spec is unclear whether this is valid or not -- it is not the
clearly documented way to send a zero length TD (which is CBP=BE=0),
but it isn't specifically forbidden. Actual hw seems to be ok with it.

Does any OS rely on this behavior? There have been no reports to
qemu-devel of this problem.

This is attempting to have qemu behave like actual hardware,
but this is just a minor change.

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
 -----------+------------+-----------
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

Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ohci.c   | 4 ++--
 hw/usb/trace-events | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index acd60169802..71b54914d32 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
             len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
         } else {
-            if (td.cbp > td.be) {
-                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
+            if (td.cbp - 1 > td.be) {  /* rely on td.cbp != 0 */
+                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
                 ohci_die(ohci);
                 return 1;
             }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 46732717a95..dd04f14add1 100644
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


