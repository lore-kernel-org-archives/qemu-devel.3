Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65767C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 16:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDn6g-0003nU-E0; Sat, 10 May 2025 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDn6d-0003fj-QW
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:31:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDn6b-00031z-KY
 for qemu-devel@nongnu.org; Sat, 10 May 2025 12:31:19 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a89c31ae7so4131097a91.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746894676; x=1747499476; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ux5CyybD4AtZrBHiUjvyRq8UgUAxb0lw5+WLsxkdLg=;
 b=CD5mX7HwJYuCt2pGvE2pxdGIlaBMGpzMGzvJfHbCIUdasxxAd53kLT/eBPkeL5yo89
 JUqKUIoNvm03k3yU7fwwOKz5ZguQFQ+BjKQxi86OLJf699GwQqvWyIEs5NGD0X5AtawC
 aJl8sSA6DWRkVlybU6Gq6iDVVow6dEoJUucGPzTuLKigZgAweJllxqJewsHm7sJHt8Ug
 LiWVND3HzZlJJ6X1I95tsZbocdCcBpHU7okUA2SVKuRqSMhDsy8hb8iXscX4VuQ2wl4W
 JNEvaXMTuznhYVTnBZH799mTHxFm29Iu6vy72LTLKRqeFvDWKM8phCecjXPGi336wSev
 2Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746894676; x=1747499476;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ux5CyybD4AtZrBHiUjvyRq8UgUAxb0lw5+WLsxkdLg=;
 b=Y7q3Rg6jeF9F+tJgNH8PJYTEUhNXX7hokbhuFaE8x6dBEbg9YRcR4U+pYqWGL65b0W
 AKwKkGFsCMZK9AZwbXZGYYTn+REts7i/Fto6JxlROLs00IDntfKiIfN6DtyxIqKtfR7+
 e+eOG0cKTv8wzG5/KP4wsTySCKoJnb+kHTRyzjcvJ2a4EwEzOLNmaaI5VCQUd3NCj3TC
 P/LCDeX0acY/flo4EqKoRyOsCVsw4krjpbpbmr9te0R79S0wINI6SlD8AUfexAlF7Rcl
 sgXkuddmaRB49LGpWO3lXyYYzuY5w5Oo26V7XIAeX2+bmBzKP0bALrW99d6QTJIMw2US
 +Aww==
X-Gm-Message-State: AOJu0Yy5YBNpDwavsR2JBOjfLEdCUDD1heYBVw2nd9HP2UphZRNYDJ/y
 Xc8gwDiuz5KhCdNLyTKuOChzdxMhD+o7phktcdHgOVgb2wHa7o3mh2VAZA==
X-Gm-Gg: ASbGncuOE/RbVKGkWwPxGI3z7ih5tyaYVZ9CLfXOv17Tt21KFupkFyqSHzyYjMHpXsA
 KpX7OxXq0vwmAoOTmMauBYZXvEoB8k1j94YKkhJXcmNrSU/xA7iFwgpawmyEXVpUrVAgdMZi5EN
 u3WFpEn1CgAngGDPFfFsFAjGDhybP4MLuz9o7VBHkP3M+mOMqUxxsHGuT9FcwmMq2rCTWgJ8xLs
 WRssBxORTyoyUJUMNFvPo3h++qt65zRqAbHWCKJRSGjXvs6vPmJ/NirLkQ7uyNKXBx0we52NFAZ
 pO5WZxea9DjIbWqEGfuf9mpaC1xFM0FSLj2pv1VGeJyIJdBvc6x6o3ku5iS+dv6Q
X-Google-Smtp-Source: AGHT+IFq0CF2RxUR9rKaAhg6lH4v6R3NIhTsIFUvteDkxc2mzNDR3dsOcM3aYWD60AP4s8wbt2TLSg==
X-Received: by 2002:a17:90b:3c48:b0:2ff:64c3:3bd4 with SMTP id
 98e67ed59e1d1-30c3d65cc56mr11580268a91.31.1746894664911; 
 Sat, 10 May 2025 09:31:04 -0700 (PDT)
Received: from [101.5.20.31] ([101.5.20.31]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39e6101dsm3704543a91.36.2025.05.10.09.31.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 09:31:04 -0700 (PDT)
Message-ID: <5c101fd9-9a18-4f61-a77f-3b338c787d09@gmail.com>
Date: Sun, 11 May 2025 00:31:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/net/e1000: fix stack-buffer-overflow in e1000_receive_iov
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch fixes a stack-buffer-overflow bug in e1000_receive_iov().
When receiving a broken eth iov (only 1 iov and len < ETH_HLEN, 4 in
the crash sample), origin logic will continue by copy iov to min_buf.
The subsequent program will perform error vlan packet checking on 
the buffer content that was originally supposed to be empty. 

If the e1000x_vlan_enabled check passes, it will proceed to move 
the iov by offset 4, which can result in an stack buffer overflow 
within `while (iov->iov_len <= iov_ofs)` loop.

I'm wondering that in which scene will use min_buf copy on the branch
`if (iov->iov_len < MAXIMUM_ETHERNET_HDR_LEN) {`. As far as I know,
all packet length must larger than ETH_HLEN.
 
Unfortunately, this crash occurred from my developing fuzzing platform,
which has no reproducer. But the execution trace can be recovered 
from the backtrace. By the way, this crash occurred over 200 times during
fuzzing progress.

==2325767==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7f16f6518ab8 at pc 0x5581dd9342cf bp 0x7ffc10d12d70 sp 0x7ffc10d12d68
READ of size 8 at 0x7f16f6518ab8 thread T0
    #0 0x5581dd9342ce in e1000_receive_iov /root/qemu/build-fuzz/../hw/net/e1000.c:925:25
    #1 0x5581de01d65c in qemu_deliver_packet_iov /root/qemu/build-fuzz/../net/net.c:829:15
    #2 0x5581de0200bf in qemu_net_queue_deliver /root/qemu/build-fuzz/../net/queue.c:164:11
    #3 0x5581de01fe0e in qemu_net_queue_receive /root/qemu/build-fuzz/../net/queue.c:193:12
    #4 0x5581de0151b5 in qemu_receive_packet /root/qemu/build-fuzz/../net/net.c:754:12
    #5 0x5581dd932b48 in e1000_send_packet /root/qemu/build-fuzz/../hw/net/e1000.c:565:9
    #6 0x5581dd93244d in xmit_seg /root/qemu/build-fuzz/../hw/net/e1000.c:628:9
    #7 0x5581dd930d13 in process_tx_desc /root/qemu/build-fuzz/../hw/net/e1000.c:720:9
    #8 0x5581dd92f294 in start_xmit /root/qemu/build-fuzz/../hw/net/e1000.c:780:9
    #9 0x5581dd92e776 in set_tctl /root/qemu/build-fuzz/../hw/net/e1000.c:1106:5
    #10 0x5581dd92bcba in e1000_mmio_write /root/qemu/build-fuzz/../hw/net/e1000.c:1277:13
    #11 0x5581de5ca6d5 in memory_region_write_accessor /root/qemu/build-fuzz/../system/memory.c:497:5
    #12 0x5581de5ca399 in access_with_adjusted_size /root/qemu/build-fuzz/../system/memory.c:573:18
    #13 0x5581de5c9881 in memory_region_dispatch_write /root/qemu/build-fuzz/../system/memory.c:1553:16
    #14 0x5581de60b291 in flatview_write_continue_step /root/qemu/build-fuzz/../system/physmem.c:2929:18
    #15 0x5581de60afa0 in flatview_write_continue /root/qemu/build-fuzz/../system/physmem.c:2959:19
    #16 0x5581de5fb077 in flatview_write /root/qemu/build-fuzz/../system/physmem.c:2990:12
    #17 0x5581de5fae34 in address_space_write /root/qemu/build-fuzz/../system/physmem.c:3110:18
    #18 0x5581deb29506 in __wrap_qtest_writeq /root/qemu/build-fuzz/../tests/qtest/fuzz/qtest_wrappers.c:187:9
    #19 0x5581deb5c1fb in op_write /root/qemu/build-fuzz/../tests/qtest/fuzz/generic_fuzz.c:492:13
    #20 0x5581deb5aa54 in generic_fuzz /root/qemu/build-fuzz/../tests/qtest/fuzz/generic_fuzz.c:668:13
    #21 0x5581deb26494 in LLVMFuzzerTestOneInput /root/qemu/build-fuzz/../tests/qtest/fuzz/fuzz.c:159:5
    #22 0x5581dd3392e6 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:614:13
    #23 0x5581dd338a55 in fuzzer::Fuzzer::RunOne(unsigned char const*, unsigned long, bool, fuzzer::InputInfo*, bool, bool*) /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:516:7
    #24 0x5581dd33a3a5 in fuzzer::Fuzzer::MutateAndTestOne() /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:760:19
    #25 0x5581dd33b095 in fuzzer::Fuzzer::Loop(std::__Fuzzer::vector<fuzzer::SizedFile, std::__Fuzzer::allocator<fuzzer::SizedFile>>&) /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:905:5
    #26 0x5581dd3299cb in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:915:6
    #27 0x5581dd354ec2 in main /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
    #28 0x7f16f8bcdd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #29 0x7f16f8bcde3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #30 0x5581dd31bc34 in _start (/root/qemu/build-fuzz/qemu-fuzz-x86_64+0xbc0c34)

Address 0x7f16f6518ab8 is located in stack of thread T0 at offset 56 in frame
    #0 0x5581de01fe3f in qemu_net_queue_deliver /root/qemu/build-fuzz/../net/queue.c:156

  This frame has 1 object(s):
    [32, 48) 'iov' (line 158) <== Memory access at offset 56 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow /root/qemu/build-fuzz/../hw/net/e1000.c:925:25 in e1000_receive_iov
Shadow bytes around the buggy address:
  0x7f16f6518800: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518880: f1 f1 f1 f1 00 f3 f3 f3 f1 f1 f1 f1 00 00 f3 f3
  0x7f16f6518900: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518980: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518a00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
=>0x7f16f6518a80: f1 f1 f1 f1 00 00 f3[f3]f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518b00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518b80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518c00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518c80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x7f16f6518d00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==2325767==ABORTING
MS: 5 PersAutoDict-PersAutoDict-CopyPart-ChangeBinInt-CustomCrossOver- DE: "\367\000\000\000"-"\367\000\000\000"-; base unit: 73073e74323b544b02c32575b90178286fdc5cf2
artifact_prefix='./'; Test unit written to ./crash-321d2d6e2808c22fc962819fcb073f126c51f179
Fuzzing e1000-82544gc exited with code 1

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
---
 hw/net/e1000.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 3d0b227703..81d0a786da 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -899,6 +899,11 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
         return 0;
     }
 
+    if (iov->iov_len < ETH_HLEN && iovcnt == 1) {
+        /* Broken packet if overall length < ETH_HLEN */
+        return -1;
+    }
+
     if (iov->iov_len < MAXIMUM_ETHERNET_HDR_LEN) {
         /* This is very unlikely, but may happen. */
         iov_to_buf(iov, iovcnt, 0, min_buf, MAXIMUM_ETHERNET_HDR_LEN);
@@ -922,7 +927,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
             memmove(filter_buf + 4, filter_buf, 12);
         } else {
             iov_from_buf(iov, iovcnt, 4, filter_buf, 12);
-            while (iov->iov_len <= iov_ofs) {
+            while (iov->iov_len <= iov_ofs) {   // If size < iov_ofs, will cause stack ovf
                 iov_ofs -= iov->iov_len;
                 iov++;
             }
-- 
2.34.1



