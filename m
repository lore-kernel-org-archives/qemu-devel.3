Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A100C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OV4-00065C-Mu; Mon, 28 Apr 2025 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9OV1-00064U-4p; Mon, 28 Apr 2025 09:26:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u9OUx-00084Y-BS; Mon, 28 Apr 2025 09:26:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F85755D22E;
 Mon, 28 Apr 2025 15:26:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id EhQpp6yVtnre; Mon, 28 Apr 2025 15:26:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E484955D22A; Mon, 28 Apr 2025 15:26:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E2E12745682;
 Mon, 28 Apr 2025 15:26:07 +0200 (CEST)
Date: Mon, 28 Apr 2025 15:26:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
Message-ID: <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 28 Apr 2025, BALATON Zoltan wrote:
> On Mon, 28 Apr 2025, BALATON Zoltan wrote:
>> On Thu, 24 Apr 2025, BALATON Zoltan wrote:
>>>> The test case I've used came out of a discussion about very slow
>>>> access to VRAM of a graphics card passed through with vfio the reason
>>>> for which is still not clear but it was already known that dcbz is
>>>> often used by MacOS and AmigaOS for clearing memory and to avoid
>>>> reading values about to be overwritten which is faster on real CPU but
>>>> was found to be slower on QEMU. The optimised copy routines were
>>>> posted here:
>>>> https://www.amigans.net/modules/newbb/viewtopic.php?post_id=149123#forumpost149123
>>>> and the rest of it I've written to make it a test case is here:
>>>> http://zero.eik.bme.hu/~balaton/qemu/vramcopy.tar.xz
>>>> Replace the body of has_altivec() with just "return false". Sorry for
>>>> only giving pieces but the code posted above has a copyright that does
>>>> not allow me to include it in the test. This is not measuring VRAM
>>>> access now just memory copy but shows the effect of dcbz. I've got
>>>> these results with this patch:
>>>> 
>>>> Linux user master:                  Linux user patch:
>>>> byte loop: 2.2 sec                  byte loop: 2.2 sec
>>>> memcpy: 2.19 sec                    memcpy: 2.19 sec
>>>> copyToVRAMNoAltivec: 1.7 sec        copyToVRAMNoAltivec: 1.71 sec
>>>> copyToVRAMAltivec: 2.13 sec         copyToVRAMAltivec: 2.12 sec
>>>> copyFromVRAMNoAltivec: 5.11 sec     copyFromVRAMNoAltivec: 2.79 sec
>>>> copyFromVRAMAltivec: 5.87 sec       copyFromVRAMAltivec: 3.26 sec
>>>> 
>>>> Linux system master:                Linux system patch:
>>>> byte loop: 5.86 sec                 byte loop: 5.9 sec
>>>> memcpy: 5.45 sec                    memcpy: 5.47 sec
>>>> copyToVRAMNoAltivec: 2.51 sec       copyToVRAMNoAltivec: 2.53 sec
>>>> copyToVRAMAltivec: 3.84 sec         copyToVRAMAltivec: 3.85 sec
>>>> copyFromVRAMNoAltivec: 6.11 sec     copyFromVRAMNoAltivec: 3.92 sec
>>>> copyFromVRAMAltivec: 7.22 sec       copyFromVRAMAltivec: 5.51 sec
>> 
>> I did some more benchmarking to identify what slows it down. I noticed that 
>> memset uses dcbz too so I added a test for that. I've also added a 
>> parameter to allow testing actual VRAM and now that I have a card working 
>> with vfio-pci passthrough I could also test that. The updated 
>> vramcopy.tar.xz is at the same URL as above. These tests were run with the 
>> amigaone machine under Linux booted as described here:
>> https://www.qemu.org/docs/master/system/ppc/amigang.html
>> 
>> I compiled the benchmark twice, once as in the tar and once replacing dcbz 
>> in the copyFromVRAM* routines with dcba (which is noop on QEMU). First two 
>> results are with both src and dst in RAM, second two tests are with dst in 
>> VRAM (mapped from phys address 0x80800000 where the card's framebuffer is 
>> mapped). The left column shows results with emulated ati-vga as in the 
>> amigang.html docs. The right column is with real ATI X550 card (old and 
>> slow but works with this old PPC Linux) passed through with vfio-pci.
>> 
>> with ati-vga                            with vfio-pci
>> 
>> src 0xb79c8008 dst 0xb78c7008	      |	src 0xb7c92008 dst 0xb7b91008
>> byte loop: 21.16 sec			byte loop: 21.16 sec
>> memset: 3.85 sec		      |	memset: 3.87 sec
>> memcpy: 5.07 sec			memcpy: 5.07 sec
>> copyToVRAMNoAltivec: 2.52 sec	      |	copyToVRAMNoAltivec: 2.53 sec
>> copyToVRAMAltivec: 2.42 sec	      |	copyToVRAMAltivec: 2.37 sec
>> copyFromVRAMNoAltivec: 6.39 sec	      |	copyFromVRAMNoAltivec: 6.38 
>> sec
>> copyFromVRAMAltivec: 7.02 sec	      |	copyFromVRAMAltivec: 7 sec
>> 
>> using dcba instead of dcbz	      |	using dcba instead of dcbz
>> src 0xb7b69008 dst 0xb7a68008	      |	src 0xb7c44008 dst 0xb7b43008
>> byte loop: 21.14 sec			byte loop: 21.14 sec
>> memset: 3.85 sec		      |	memset: 3.88 sec
>> memcpy: 5.06 sec		      |	memcpy: 5.07 sec
>> copyToVRAMNoAltivec: 2.53 sec	      |	copyToVRAMNoAltivec: 2.52 sec
>> copyToVRAMAltivec: 2.3 sec		copyToVRAMAltivec: 2.3 sec
>> copyFromVRAMNoAltivec: 2.59 sec		copyFromVRAMNoAltivec: 2.59 
>> sec
>> copyFromVRAMAltivec: 2.95 sec		copyFromVRAMAltivec: 2.95 sec
>> 
>> dst in emulated ati-vga		      |	dst in real card vfio vram
>> mapping 0x80800000			mapping 0x80800000
>> src 0xb78e0008 dst 0xb77de000	      |	src 0xb7ec5008 dst 0xb7dc3000
>> byte loop: 21.2 sec		      |	byte loop: 563.98 sec
>> memset: 3.89 sec		      |	memset: 39.25 sec
>> memcpy: 5.07 sec		      |	memcpy: 140.49 sec
>> copyToVRAMNoAltivec: 2.53 sec	      |	copyToVRAMNoAltivec: 72.03 sec
>> copyToVRAMAltivec: 12.22 sec	      |	copyToVRAMAltivec: 78.12 sec
>> copyFromVRAMNoAltivec: 6.43 sec	      |	copyFromVRAMNoAltivec: 728.52 
>> sec
>> copyFromVRAMAltivec: 35.33 sec	      |	copyFromVRAMAltivec: 754.95 
>> sec
>> 
>> dst in emulated ati-vga using dcba    |	dst in real card vfio vram 
>> using dcba
>> mapping 0x80800000			mapping 0x80800000
>> src 0xb7ba7008 dst 0xb7aa5000	      |	src 0xb77f4008 dst 0xb76f2000
>> byte loop: 21.15 sec		      |	byte loop: 577.42 sec
>> memset: 3.85 sec		      |	memset: 39.52 sec
>> memcpy: 5.06 sec		      |	memcpy: 142.8 sec
>> copyToVRAMNoAltivec: 2.53 sec	      |	copyToVRAMNoAltivec: 71.71 sec
>> copyToVRAMAltivec: 12.2 sec	      |	copyToVRAMAltivec: 78.09 sec
>> copyFromVRAMNoAltivec: 2.6 sec	      |	copyFromVRAMNoAltivec: 727.23 
>> sec
>> copyFromVRAMAltivec: 35.03 sec	      |	copyFromVRAMAltivec: 753.15 
>> sec
>> 
>> The results show that dcbz has some effect but an even bigger slow down is 
>> caused by using AltiVec which is supposed to do wider access to reduce the 
>> overhead but maybe it's not translated to host vector instructions 
>> correctly. The host in the above test was Intel i7-9700K. So to solve this 
>> maybe AltiVec should be improved more than dcbz but I don't know what and 
>> how.
>
> Looking at what AltiVec ops are used there aren't many. lvx and stvx should 
> translate to 128 bit ops so those are probably ok, there are some lvsl lvsr 
> ops which may be ok too and the only other one left is vperm which seems very 
> much unoptimised, so my guess is likely that vperm causes the slow down here 
> (I could try profiling to confirm if needed). Is there a way to improve that?

I have tried profiling the dst in real card vfio vram with dcbz case (with 
100 iterations instead of 10000 in above tests) but I'm not sure I 
understand the results. vperm and dcbz show up but not too high. Can 
somebody explain what is happening here and where the overhead likely 
comes from? Here is the profile result I got:

Samples: 104K of event 'cycles:Pu', Event count (approx.): 122371086557
   Children      Self  Command          Shared Object            Symbol
-   99.44%     0.95%  qemu-system-ppc  qemu-system-ppc          [.] cpu_exec_loop
    - 98.49% cpu_exec_loop
       - 98.48% cpu_tb_exec
          - 90.95% 0x7f4e705d8f15
               helper_ldub_mmu
               do_ld_mmio_beN
             - cpu_io_recompile
                - 45.79% cpu_loop_exit_noexc
                   - cpu_loop_exit
                     __longjmp_chk
                     cpu_exec_setjmp
                   - cpu_exec_loop
                      - 45.78% cpu_tb_exec
                           42.35% 0x7f4e6f3f0000
                         - 0.72% 0x7f4e99f37037
                              helper_VPERM
                         - 0.68% 0x7f4e99f3716d
                              helper_VPERM
                - 45.16% rr_cpu_thread_fn
                   - 45.16% tcg_cpu_exec
                      - 45.15% cpu_exec
                         - 45.15% cpu_exec_setjmp
                            - cpu_exec_loop
                               - 45.14% cpu_tb_exec
                                    42.08% 0x7f4e6f3f0000
                                  - 0.72% 0x7f4e99f37037
                                       helper_VPERM
                                  - 0.67% 0x7f4e99f3716d
                                       helper_VPERM
          + 2.40% 0x7f4e74e85bae
          + 2.15% 0x7f4e7060a2dc
          + 0.99% 0x7f4e73d93781
+   99.32%     0.37%  qemu-system-ppc  qemu-system-ppc          [.] cpu_tb_exec
+   98.73%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_exec_setjmp
-   94.11%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_io_recompile
    - 94.11% cpu_io_recompile
       - 89.79% rr_cpu_thread_fn
          - 89.78% tcg_cpu_exec
             - 89.78% cpu_exec
                  cpu_exec_setjmp
                - cpu_exec_loop
                   - 89.78% cpu_tb_exec
                      - 88.40% 0x7f4e705d8f15
                           helper_ldub_mmu
                           do_ld_mmio_beN
                         - cpu_io_recompile
                            - 44.47% cpu_loop_exit_noexc
                               - cpu_loop_exit
                                 __longjmp_chk
                                 cpu_exec_setjmp
                               - cpu_exec_loop
                                  - 44.46% cpu_tb_exec
                                       41.22% 0x7f4e6f3f0000
                                     - 0.70% 0x7f4e99f37037
                                          helper_VPERM
                                     - 0.67% 0x7f4e99f3716d
                                          helper_VPERM
                            - 43.94% rr_cpu_thread_fn
                               - 43.93% tcg_cpu_exec
                                  - cpu_exec
                                     - 43.93% cpu_exec_setjmp
                                        - cpu_exec_loop
                                           - 43.90% cpu_tb_exec
                                                40.95% 0x7f4e6f3f0000
                                              - 0.71% 0x7f4e99f37037
                                                   helper_VPERM
                                              - 0.66% 0x7f4e99f3716d
                                                   helper_VPERM
                        1.23% 0x7f4e6f3f0000
       + 4.32% cpu_loop_exit_noexc
+   91.90%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_exec
+   91.90%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] tcg_cpu_exec
+   91.88%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] rr_cpu_thread_fn
+   91.12%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] helper_ldub_mmu
+   91.12%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] do_ld_mmio_beN
-   91.10%     0.00%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e705d8f15
      0x7f4e705d8f15
      helper_ldub_mmu
      do_ld_mmio_beN
    - cpu_io_recompile
       - 45.93% cpu_loop_exit_noexc
          - cpu_loop_exit
            __longjmp_chk
            cpu_exec_setjmp
          - cpu_exec_loop
             - 45.92% cpu_tb_exec
                  42.35% 0x7f4e6f3f0000
                - 0.72% 0x7f4e99f37037
                     helper_VPERM
                - 0.68% 0x7f4e99f3716d
                     helper_VPERM
       - 45.18% rr_cpu_thread_fn
          - 45.17% tcg_cpu_exec
             - 45.17% cpu_exec
                - 45.17% cpu_exec_setjmp
                   - cpu_exec_loop
                      - 45.14% cpu_tb_exec
                           42.08% 0x7f4e6f3f0000
                         - 0.72% 0x7f4e99f37037
                              helper_VPERM
                         - 0.67% 0x7f4e99f3716d
                              helper_VPERM
+   88.80%     0.00%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e6f3f0000
+   53.56%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_loop_exit
+   53.56%     0.00%  qemu-system-ppc  libc.so.6                [.] __longjmp_chk
+   48.82%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_loop_exit_noexc
+    7.41%     7.41%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ef5c69
+    6.89%     6.89%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99f3c0a2
+    6.37%     6.37%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ef5d47
+    6.33%     6.33%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ef5b9b
+    6.21%     6.21%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ef5cdc
+    5.78%     5.78%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99f3c0a8
+    5.60%     5.60%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99f3bdd1
+    5.55%     5.55%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99f3bdd7
+    5.43%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] cpu_loop_exit_restore
+    5.32%     5.32%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ea5beb
+    5.30%     5.30%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ea5be5
+    4.82%     4.82%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ea5bd5
+    4.78%     4.78%  qemu-system-ppc  [JIT] tid 4074           [.] 0x00007f4e99ea5bdd
+    4.68%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] helper_raise_exception_err
-    3.99%     3.97%  qemu-system-ppc  qemu-system-ppc          [.] helper_VPERM
      3.72% do_ld_mmio_beN
         cpu_io_recompile
         rr_cpu_thread_fn
         tcg_cpu_exec
         cpu_exec
         cpu_exec_setjmp
         cpu_exec_loop
         cpu_tb_exec
         0x7f4e705d8f15
         helper_ldub_mmu
         do_ld_mmio_beN
       - cpu_io_recompile
          - 1.90% cpu_loop_exit_noexc
               cpu_loop_exit
               __longjmp_chk
               cpu_exec_setjmp
               cpu_exec_loop
             - cpu_tb_exec
                - 0.69% 0x7f4e99f37037
                     helper_VPERM
                - 0.66% 0x7f4e99f3716d
                     helper_VPERM
          - 1.82% rr_cpu_thread_fn
               tcg_cpu_exec
               cpu_exec
               cpu_exec_setjmp
               cpu_exec_loop
             - cpu_tb_exec
                - 0.70% 0x7f4e99f37037
                     helper_VPERM
                - 0.65% 0x7f4e99f3716d
                     helper_VPERM
+    3.65%     0.00%  qemu-system-ppc  qemu-system-ppc          [.] helper_raise_exception
+    3.51%     0.82%  qemu-system-ppc  qemu-system-ppc          [.] helper_lookup_tb_ptr
[...]
-    1.71%     1.52%  qemu-system-ppc  qemu-system-ppc          [.] probe_access
      1.30% do_ld_mmio_beN
         cpu_io_recompile
         rr_cpu_thread_fn
         tcg_cpu_exec
         cpu_exec
         cpu_exec_setjmp
         cpu_exec_loop
         cpu_tb_exec
         0x7f4e705d8f15
         helper_ldub_mmu
         do_ld_mmio_beN
       - cpu_io_recompile
          - 0.66% cpu_loop_exit_noexc
               cpu_loop_exit
               __longjmp_chk
               cpu_exec_setjmp
               cpu_exec_loop
               cpu_tb_exec
          - 0.64% rr_cpu_thread_fn
               tcg_cpu_exec
               cpu_exec
               cpu_exec_setjmp
               cpu_exec_loop
               cpu_tb_exec
-    1.64%     0.05%  qemu-system-ppc  qemu-system-ppc          [.] helper_dcbz
    - 1.58% helper_dcbz
         probe_access

Regards,
BALATON Zoltan

