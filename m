Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE7CC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjaK-000649-Sg; Thu, 14 Mar 2024 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjaJ-00063u-6i
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:49:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkjaG-0001xB-Bf
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:49:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-413f9499bd3so778845e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710416953; x=1711021753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/YVmSJeVOYcC0qiAcSlO0e3RXyiIWtuuHIXp9cLFg8w=;
 b=oclLUJl/kxRiC7jFhe206qzvuSzMFwyk6/M2ayez8/4JhdvgFJ4Dq5IRrGIDk/SnUw
 G5takiYD1eWGPo6f/zH+vOrcIqF8+mOB8CF6eSj/FXmdswmd9s0pUiISpGud8b01Psu3
 vAhEfu2YbApfHDCEiXEubcP3b6Iwsnj7zV2zEbuhq5Xv762qs0BDLUA63XS3Q9J+l8vm
 fl7Y7vvvBMjtsgSnNbJARaaJuifel1TW3eQ/TNxBVp3vZMdc4OVSx67e5R+4iVvk3vKE
 mYWW4JJtgoiNcjziwh3udB7vQYLXVTFGRos8i5t/4Ca2VRs9ofac7rvP2aC9xJfKa/0X
 UBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710416953; x=1711021753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/YVmSJeVOYcC0qiAcSlO0e3RXyiIWtuuHIXp9cLFg8w=;
 b=NCSYkvMtvY3dDwNOkPgTG7k7Aao9VglQfchcpdT4jIckvkPYvRQ7omsFggw43fkRzO
 l8RIt+3YrisZNLh5WNUFFkwkRAOIc00/yctt5lHsGXjxKIVTfE/QTtDEgSubC5U+KhMe
 S9/2xvVPqhi8Np6xIyaKl7LFdO2pD1Cfjg4tMBO8ByldcHX4USqr7M/xO23cpsUCY5K8
 rj5n0weykAWRnjqEaR/QVg3hFzMLf4SdTqfuZg24KT57Oyo1e/qhig4MhgD4O+gRjb/S
 PUSeV9KUaTKNcP1YmMXIFk4TqblPPvipHhjjI/Tqe7IKSdMjoT76leEJpFjEIMAOnHrl
 TEWw==
X-Gm-Message-State: AOJu0Yxa9aj/xqXKMsIzvNW+vFQucySwEfjor+0lPSYNiOFJcFx2XXcG
 tYOxRamhLTGsMZhtBshdsDwaMftevrbOe+Az0iuvx1lXJMdvYwq8E3BQvfs5Hj4=
X-Google-Smtp-Source: AGHT+IE4w3ZKrTFPMCHno9eqBo+GKSzF4d1gxCud2TFrf2pkiLVVT1Blxct8+5PQ06nXXeyoPH2+OA==
X-Received: by 2002:a05:600c:35d4:b0:413:2308:7d94 with SMTP id
 r20-20020a05600c35d400b0041323087d94mr1372021wmq.20.1710416952716; 
 Thu, 14 Mar 2024 04:49:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv9-20020a05600c548900b00413eedd36a4sm3085455wmb.39.2024.03.14.04.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:49:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D47E5F75D;
 Thu, 14 Mar 2024 11:49:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH v2] contrib/plugins: control flow plugin (WIP!)
Date: Thu, 14 Mar 2024 11:49:07 +0000
Message-Id: <20240314114907.88890-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a simple control flow tracking plugin that uses the latest
inline and conditional operations to detect and track control flow
changes. It is currently an exercise at seeing how useful the changes
are.

Based-on: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240311153432.1395190-1-alex.bennee@linaro.org>

---
v2
  - only need a single call back
  - drop need for INSN_WIDTH
  - still don't understand the early exits

I'm still seeing weirdness in the generated code, for example the
plugin reports "early exits" which doesn't make sense for a ret which
terminates a block:

  addr: 0x403c88 hexchar: ret  (1/1)
    early exits 1280
    branches 1280
      to 0x403d00 (639)
      to 0x403d24 (639)

If I look in the debug I see:

2560 matches for "403c88" in buffer: debug.log
   7934:vcpu_tb_branched_exec: pc=403c84, npc=403c8c, lpc=403c5c, epbc=403c88
   7935:vcpu_tb_branched_exec: pc=403d00, npc=403d24, lpc=403c88, epbc=403d20
   7938:vcpu_tb_branched_exec: pc=403c84, npc=403c8c, lpc=403c5c, epbc=403c88
   7939:vcpu_tb_branched_exec: pc=403d24, npc=403d48, lpc=403c88, epbc=403d44
   7943:vcpu_tb_branched_exec: pc=403c84, npc=403c8c, lpc=403c5c, epbc=403c88

showing last pc values that don't sync up with epbc (end of block +
insn_width). AFAICT this exit is only translated once. This makes me
wonder if we are correctly setting values. Looking at the translator
debug (-d plugin,in_asm,op,op_opt,out_asm -dfilter
0x403c00..0x403d00):

----------------
IN: hexchar
0x00403c84:  a8c27bfd  ldp      x29, x30, [sp], #0x20
0x00403c88:  d65f03c0  ret

OP:
 ld_i32 loc0,env,$0xfffffffffffffff0
 brcond_i32 loc0,$0x0,lt,$L0

^ is the start of block check

 st8_i32 $0x0,env,$0xfffffffffffffff4
 ld_i32 tmp2,env,$0xffffffffffffdb08
 mul_i32 tmp2,tmp2,$0x18
 ext_i32_i64 tmp3,tmp2
 mov_i64 tmp5,$0x5612c297b8a0
 add_i64 tmp5,tmp5,tmp3
 mov_i64 tmp4,$0x403c88
 st_i64 tmp4,tmp5,$0x0

^ is this a store to the scoreboard?

 ld_i32 tmp2,env,$0xffffffffffffdb08
 mul_i32 tmp2,tmp2,$0x18
 ext_i32_i64 tmp3,tmp2
 mov_i64 tmp5,$0x5612c297b8a8
 add_i64 tmp5,tmp5,tmp3
 mov_i64 tmp4,$0x403c8c
 st_i64 tmp4,tmp5,$0x0

^ and I guess this? Should we be honouring the order we add TB
instrumentation or is it driven by the different types of operation?

 mov_i64 tmp8,$0x403c84
 ld_i32 tmp2,env,$0xffffffffffffdb08
 mul_i32 tmp7,tmp2,$0x18
 ext_i32_i64 tmp3,tmp7
 mov_i64 tmp5,$0x5612c297b8a8
 add_i64 tmp5,tmp5,tmp3
 ld_i64 tmp4,tmp5,$0x0
 brcond_i64 tmp4,$0x403c84,eq,$L1

^ this is the conditional check of tmp4 (what was expected vs current pc)

 call plugin(0x7f84c99bf5c0),$0x11,$0,tmp2,tmp8
 set_label $L1

 ---- 0000000000403c84 0000000000000000 0000000000000000
 ld_i32 tmp2,env,$0xffffffffffffdb08
 mul_i32 tmp2,tmp2,$0x18
 ext_i32_i64 tmp3,tmp2
 mov_i64 tmp5,$0x5612c297b8b0
 add_i64 tmp5,tmp5,tmp3
 mov_i64 tmp4,$0x403c84
 st_i64 tmp4,tmp5,$0x0
 mov_i64 loc9,sp
 shl_i64 loc10,loc9,$0x8
 sar_i64 loc10,loc10,$0x8
 and_i64 loc10,loc10,loc9
 qemu_ld_a64_i128 loc12,loc13,loc10,noat+un+leo,0
 mov_i64 x29,loc12
 mov_i64 lr,loc13
 add_i64 loc9,loc9,$0x20
 mov_i64 sp,loc9

 ---- 0000000000403c88 0000000000000000 0000000000000000
 ld_i32 tmp2,env,$0xffffffffffffdb08
 mul_i32 tmp2,tmp2,$0x18
 ext_i32_i64 tmp3,tmp2
 mov_i64 tmp5,$0x5612c297b8b0
 add_i64 tmp5,tmp5,tmp3
 mov_i64 tmp4,$0x403c88
 st_i64 tmp4,tmp5,$0x0
 shl_i64 pc,lr,$0x8
 sar_i64 pc,pc,$0x8
 and_i64 pc,pc,lr
 call lookup_tb_ptr,$0x6,$1,tmp3,env
 goto_ptr tmp3
 set_label $L0
 exit_tb $0x7f84b80d34c3

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff0      pref=0xffff
 brcond_i32 tmp0,$0x0,lt,$L0              dead: 0
 st8_i32 $0x0,env,$0xfffffffffffffff4     dead: 0
 ld_i32 tmp2,env,$0xffffffffffffdb08      pref=0xffff
 mul_i32 tmp2,tmp2,$0x18                  dead: 1  pref=0xffff
 ext_i32_i64 tmp3,tmp2                    dead: 1  pref=0xffff
 add_i64 tmp5,tmp3,$0x5612c297b8a0        dead: 1 2  pref=0xffff
 st_i64 $0x403c88,tmp5,$0x0               dead: 0 1
 ld_i32 tmp2,env,$0xffffffffffffdb08      pref=0xffff
 mul_i32 tmp2,tmp2,$0x18                  dead: 1  pref=0xffff
 ext_i32_i64 tmp3,tmp2                    dead: 1  pref=0xffff
 add_i64 tmp5,tmp3,$0x5612c297b8a8        dead: 1  pref=0xffff
 st_i64 $0x403c8c,tmp5,$0x0               dead: 0 1
 ld_i32 tmp2,env,$0xffffffffffffdb08      dead: 1  pref=0x80
 mul_i32 tmp7,tmp2,$0x18                  dead: 2  pref=0xffff
 ext_i32_i64 tmp3,tmp7                    dead: 1  pref=0xffff
 add_i64 tmp5,tmp3,$0x5612c297b8a8        dead: 1 2  pref=0xffff
 ld_i64 tmp4,tmp5,$0x0                    dead: 1  pref=0xffff
 brcond_i64 tmp4,$0x403c84,eq,$L1         dead: 0
 call plugin(0x7f84c99bf5c0),$0x11,$0,tmp2,$0x403c84  dead: 0 1
 set_label $L1

 ---- 0000000000403c84 0000000000000000 0000000000000000
 ld_i32 tmp2,env,$0xffffffffffffdb08      pref=0xffff
 mul_i32 tmp2,tmp2,$0x18                  dead: 1  pref=0xffff
 ext_i32_i64 tmp3,tmp2                    dead: 1  pref=0xffff
 add_i64 tmp5,tmp3,$0x5612c297b8b0        dead: 1  pref=0xffff
 st_i64 $0x403c84,tmp5,$0x0               dead: 0 1
 shl_i64 tmp10,sp,$0x8                    pref=0xffff
 sar_i64 tmp10,tmp10,$0x8                 dead: 1  pref=0xffff
 and_i64 tmp10,tmp10,sp                   dead: 1  pref=0xffff
 qemu_ld_a64_i128 tmp12,tmp13,tmp10,noat+un+leo,0  dead: 2  pref=0xffff,0xffff
 mov_i64 x29,tmp12                        sync: 0  dead: 0 1  pref=0xffff
 mov_i64 lr,tmp13                         sync: 0  dead: 1  pref=0xffff
 add_i64 tmp9,sp,$0x20                    dead: 1 2  pref=0xffff
 mov_i64 sp,tmp9                          sync: 0  dead: 0 1  pref=0xffff

 ---- 0000000000403c88 0000000000000000 0000000000000000
 ld_i32 tmp2,env,$0xffffffffffffdb08      pref=0xffff
 mul_i32 tmp2,tmp2,$0x18                  dead: 1 2  pref=0xffff
 ext_i32_i64 tmp3,tmp2                    dead: 1  pref=0xffff
 add_i64 tmp5,tmp3,$0x5612c297b8b0        dead: 1 2  pref=0xffff
 st_i64 $0x403c88,tmp5,$0x0               dead: 0 1
 shl_i64 pc,lr,$0x8                       pref=0xffff
 sar_i64 pc,pc,$0x8                       dead: 1 2  pref=0xffff
 and_i64 pc,pc,lr                         sync: 0  dead: 0 1 2  pref=0xffff
 call lookup_tb_ptr,$0x6,$1,tmp3,env      dead: 1  pref=none
 goto_ptr tmp3                            dead: 0
 set_label $L0
 exit_tb $0x7f84b80d34c3

OUT: [size=288]
  -- guest addr 0x0000000000403c84 + tb prologue
0x7f84b80d3580:  8b 5d f0                 movl     -0x10(%rbp), %ebx
0x7f84b80d3583:  85 db                    testl    %ebx, %ebx
0x7f84b80d3585:  0f 8c fe 00 00 00        jl       0x7f84b80d3689
0x7f84b80d358b:  c6 45 f4 00              movb     $0, -0xc(%rbp)
0x7f84b80d358f:  8b 9d 08 db ff ff        movl     -0x24f8(%rbp), %ebx
0x7f84b80d3595:  6b db 18                 imull    $0x18, %ebx, %ebx
0x7f84b80d3598:  48 63 db                 movslq   %ebx, %rbx
0x7f84b80d359b:  49 bc a0 b8 97 c2 12 56  movabsq  $0x5612c297b8a0, %r12
0x7f84b80d35a3:  00 00
0x7f84b80d35a5:  49 03 dc                 addq     %r12, %rbx
0x7f84b80d35a8:  48 c7 03 88 3c 40 00     movq     $0x403c88, (%rbx)
0x7f84b80d35af:  8b 9d 08 db ff ff        movl     -0x24f8(%rbp), %ebx
0x7f84b80d35b5:  6b db 18                 imull    $0x18, %ebx, %ebx
0x7f84b80d35b8:  48 63 db                 movslq   %ebx, %rbx
0x7f84b80d35bb:  49 bc a8 b8 97 c2 12 56  movabsq  $0x5612c297b8a8, %r12
0x7f84b80d35c3:  00 00
0x7f84b80d35c5:  49 03 dc                 addq     %r12, %rbx
0x7f84b80d35c8:  48 c7 03 8c 3c 40 00     movq     $0x403c8c, (%rbx)
0x7f84b80d35cf:  8b bd 08 db ff ff        movl     -0x24f8(%rbp), %edi
0x7f84b80d35d5:  8b df                    movl     %edi, %ebx
0x7f84b80d35d7:  6b db 18                 imull    $0x18, %ebx, %ebx
0x7f84b80d35da:  48 63 db                 movslq   %ebx, %rbx
0x7f84b80d35dd:  49 03 dc                 addq     %r12, %rbx
0x7f84b80d35e0:  48 8b 1b                 movq     (%rbx), %rbx
0x7f84b80d35e3:  48 81 fb 84 3c 40 00     cmpq     $0x403c84, %rbx
0x7f84b80d35ea:  0f 84 0a 00 00 00        je       0x7f84b80d35fa
0x7f84b80d35f0:  be 84 3c 40 00           movl     $0x403c84, %esi
0x7f84b80d35f5:  e8 c6 bf 8e 11           callq    0x7f84c99bf5c0
0x7f84b80d35fa:  8b 9d 08 db ff ff        movl     -0x24f8(%rbp), %ebx
0x7f84b80d3600:  6b db 18                 imull    $0x18, %ebx, %ebx
0x7f84b80d3603:  48 63 db                 movslq   %ebx, %rbx
0x7f84b80d3606:  49 bc b0 b8 97 c2 12 56  movabsq  $0x5612c297b8b0, %r12
0x7f84b80d360e:  00 00
0x7f84b80d3610:  49 03 dc                 addq     %r12, %rbx
0x7f84b80d3613:  48 c7 03 84 3c 40 00     movq     $0x403c84, (%rbx)
0x7f84b80d361a:  48 8b 9d 38 01 00 00     movq     0x138(%rbp), %rbx
0x7f84b80d3621:  4c 8b eb                 movq     %rbx, %r13
0x7f84b80d3624:  49 c1 e5 08              shlq     $8, %r13
0x7f84b80d3628:  49 c1 fd 08              sarq     $8, %r13
0x7f84b80d362c:  4c 23 eb                 andq     %rbx, %r13
0x7f84b80d362f:  4d 8d 75 00              leaq     (%r13), %r14
0x7f84b80d3633:  4d 8b 2e                 movq     (%r14), %r13
0x7f84b80d3636:  4d 8b 76 08              movq     8(%r14), %r14
0x7f84b80d363a:  4c 89 ad 28 01 00 00     movq     %r13, 0x128(%rbp)
0x7f84b80d3641:  4c 89 b5 30 01 00 00     movq     %r14, 0x130(%rbp)
0x7f84b80d3648:  48 83 c3 20              addq     $0x20, %rbx
0x7f84b80d364c:  48 89 9d 38 01 00 00     movq     %rbx, 0x138(%rbp)
  -- guest addr 0x0000000000403c88
0x7f84b80d3653:  8b 9d 08 db ff ff        movl     -0x24f8(%rbp), %ebx
0x7f84b80d3659:  6b db 18                 imull    $0x18, %ebx, %ebx
0x7f84b80d365c:  48 63 db                 movslq   %ebx, %rbx
0x7f84b80d365f:  49 03 dc                 addq     %r12, %rbx
0x7f84b80d3662:  48 c7 03 88 3c 40 00     movq     $0x403c88, (%rbx)
0x7f84b80d3669:  49 8b de                 movq     %r14, %rbx
0x7f84b80d366c:  48 c1 e3 08              shlq     $8, %rbx
0x7f84b80d3670:  48 c1 fb 08              sarq     $8, %rbx
0x7f84b80d3674:  49 23 de                 andq     %r14, %rbx
0x7f84b80d3677:  48 89 9d 40 01 00 00     movq     %rbx, 0x140(%rbp)
0x7f84b80d367e:  48 8b fd                 movq     %rbp, %rdi
0x7f84b80d3681:  ff 15 11 00 00 00        callq    *0x11(%rip)
0x7f84b80d3687:  ff e0                    jmpq     *%rax
0x7f84b80d3689:  48 8d 05 33 fe ff ff     leaq     -0x1cd(%rip), %rax
0x7f84b80d3690:  e9 83 c9 f2 ff           jmp      0x7f84b8000018
  -- tb slow paths + alignment
0x7f84b80d3695:  90                       nop
0x7f84b80d3696:  90                       nop
0x7f84b80d3697:  90                       nop
  data: [size=8]
0x7f84b80d3698:  .quad  0x00005612c1d01c70
---
 contrib/plugins/cflow.c  | 353 +++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 2 files changed, 354 insertions(+)
 create mode 100644 contrib/plugins/cflow.c

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
new file mode 100644
index 0000000000..cbd6b16070
--- /dev/null
+++ b/contrib/plugins/cflow.c
@@ -0,0 +1,353 @@
+/*
+ * Control Flow plugin
+ *
+ * This plugin will track changes to control flow and detect where
+ * instructions fault.
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <glib.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* Temp hack, works for Aarch64 */
+#define INSN_WIDTH 4
+
+typedef enum {
+    SORT_HOTDEST,  /* hottest branch */
+    SORT_EARLY,    /* most early exits */
+    SORT_POPDEST,  /* most destinations */
+} ReportType;
+
+ReportType report = SORT_HOTDEST;
+int topn = 10;
+
+typedef struct {
+    uint64_t daddr;
+    uint64_t dcount;
+} DestData;
+
+/* A node is an address where we can go to multiple places */
+typedef struct {
+    GMutex lock;
+    /* address of the branch point */
+    uint64_t addr;
+    /* array of DestData */
+    GArray *dests;
+    /* early exit/fault count */
+    uint64_t early_exit;
+    /* jump destination count */
+    uint64_t dest_count;
+    /* instruction data */
+    char *insn_disas;
+    /* symbol? */
+    const char *symbol;
+    /* times translated as last in block? */
+    int last_count;
+    /* times translated in the middle of block? */
+    int mid_count;
+} NodeData;
+
+/* We use this to track the current execution state */
+typedef struct {
+    /* address of end of block */
+    uint64_t end_block;
+    /* next pc after end of block */
+    uint64_t pc_after_block;
+    /* address of last executed PC */
+    uint64_t last_pc;
+} VCPUScoreBoard;
+
+/* descriptors for accessing the above scoreboard */
+static qemu_plugin_u64 end_block;
+static qemu_plugin_u64 pc_after_block;
+static qemu_plugin_u64 last_pc;
+
+
+static GMutex node_lock;
+static GHashTable *nodes;
+struct qemu_plugin_scoreboard *state;
+
+/* SORT_HOTDEST */
+static gint hottest(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->dest_count > nb->dest_count ? -1 :
+        na->dest_count == nb->dest_count ? 0 : 1;
+}
+
+static gint early(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->early_exit > nb->early_exit ? -1 :
+        na->early_exit == nb->early_exit ? 0 : 1;
+}
+
+static gint popular(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->dests->len > nb->dests->len ? -1 :
+        na->dests->len == nb->dests->len ? 0 : 1;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) result = g_string_new("collected ");
+    GList *data;
+    GCompareFunc sort = &hottest;
+    int n = 0;
+
+    g_mutex_lock(&node_lock);
+    g_string_append_printf(result, "%d control flow nodes in the hash table\n",
+                           g_hash_table_size(nodes));
+
+    data = g_hash_table_get_values(nodes);
+
+    switch (report) {
+    case SORT_HOTDEST:
+        sort = &hottest;
+        break;
+    case SORT_EARLY:
+        sort = &early;
+        break;
+    case SORT_POPDEST:
+        sort = &popular;
+        break;
+    }
+
+    data = g_list_sort(data, sort);
+
+    for (GList *l = data;
+         l != NULL && n < topn;
+         l = l->next, n++) {
+        NodeData *n = l->data;
+        g_string_append_printf(result, "  addr: 0x%"PRIx64 " %s: %s (%d/%d)\n",
+                               n->addr, n->symbol, n->insn_disas,
+                               n->mid_count, n->last_count);
+        if (n->early_exit) {
+            g_string_append_printf(result, "    early exits %"PRId64"\n",
+                                   n->early_exit);
+        }
+        g_string_append_printf(result, "    branches %"PRId64"\n",
+                               n->dest_count);
+        for (int j = 0; j < n->dests->len; j++ ) {
+            DestData *dd = &g_array_index(n->dests, DestData, j);
+            g_string_append_printf(result, "      to 0x%"PRIx64" (%"PRId64")\n",
+                                   dd->daddr, dd->dcount);
+        }
+    }
+
+    qemu_plugin_outs(result->str);
+
+    g_mutex_unlock(&node_lock);
+}
+
+static void plugin_init(void)
+{
+    g_mutex_init(&node_lock);
+    nodes = g_hash_table_new(NULL, g_direct_equal);
+    state = qemu_plugin_scoreboard_new(sizeof(VCPUScoreBoard));
+
+    /* score board declarations */
+    end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, end_block);
+    pc_after_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, pc_after_block);
+    last_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, last_pc);
+}
+
+static NodeData *create_node(uint64_t addr)
+{
+    NodeData *node = g_new0(NodeData, 1);
+    g_mutex_init(&node->lock);
+    node->addr = addr;
+    node->dests = g_array_new(true, true, sizeof(DestData));
+    return node;
+}
+
+static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
+{
+    NodeData *node = NULL;
+
+    g_mutex_lock(&node_lock);
+    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
+    if (!node && create_if_not_found) {
+        node = create_node(addr);
+        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
+    }
+    g_mutex_unlock(&node_lock);
+    return node;
+}
+
+/*
+ * Called when we detect a non-linear execution (pc !=
+ * pc_after_block). This could be due to a fault causing some sort of
+ * exit exception (if last_pc != block_end) or just a taken branch.
+ */
+static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
+{
+    uint64_t lpc = qemu_plugin_u64_get(last_pc, cpu_index);
+    uint64_t ebpc = qemu_plugin_u64_get(end_block, cpu_index);
+    uint64_t npc = qemu_plugin_u64_get(pc_after_block, cpu_index);
+    uint64_t pc = GPOINTER_TO_UINT(udata);
+
+    /* return early for address 0 */
+    if (!lpc) {
+        return;
+    }
+
+    NodeData *node = fetch_node(lpc, true);
+    DestData *data = NULL;
+    bool early_exit = (lpc != ebpc);
+    GArray *dests;
+
+    /* the condition should never hit */
+    g_assert(pc != npc);
+
+    g_mutex_lock(&node->lock);
+
+    if (early_exit) {
+        fprintf(stderr, "%s: pc=%"PRIx64", epbc=%"PRIx64"
+                " npc=%"PRIx64", lpc=%"PRIx64", \n",
+                __func__, pc, ebpc, npc, lpc);
+        node->early_exit++;
+        if (!node->mid_count) {
+            /* count now as we've only just allocated */
+            node->mid_count++;
+        }
+    }
+
+    dests = node->dests;
+    for (int i = 0; i < dests->len; i++) {
+        if (g_array_index(dests, DestData, i).daddr == pc) {
+            data = &g_array_index(dests, DestData, i);
+        }
+    }
+
+    /* we've never seen this before, allocate a new entry */
+    if (!data) {
+        DestData new_entry = { .daddr = pc };
+        g_array_append_val(dests, new_entry);
+        data = &g_array_index(dests, DestData, dests->len);
+    }
+
+    data->dcount++;
+    node->dest_count++;
+
+    g_mutex_unlock(&node->lock);
+}
+
+/*
+ * At the start of each block we need to resolve two things:
+ *
+ *  - is last_pc == block_end, if not we had an early exit
+ *  - is start of block last_pc + insn width, if not we jumped
+ *
+ * Once those are dealt with we can instrument the rest of the
+ * instructions for their execution.
+ *
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    size_t insns = qemu_plugin_tb_n_insns(tb);
+    struct qemu_plugin_insn *last_insn = qemu_plugin_tb_get_insn(tb, insns - 1);
+
+    /*
+     * check if we are executing linearly after the last block. We can
+     * handle both early block exits and normal branches in the
+     * callback if we hit it.
+     */
+    gpointer udata = GUINT_TO_POINTER(pc);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
+
+    /*
+     * Now we can set start/end for this block so the next block can
+     * check where we are at.
+     */
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      end_block, qemu_plugin_insn_vaddr(last_insn));
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      pc_after_block,
+                                                      qemu_plugin_insn_vaddr(last_insn) +
+                                                      qemu_plugin_insn_size(last_insn));
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        uint64_t ipc = qemu_plugin_insn_vaddr(insn);
+        /*
+         * If this is a potential branch point check if we could grab
+         * the disassembly for it. If it is the last instruction
+         * always create an entry.
+         */
+        NodeData *node = fetch_node(ipc, last_insn);
+        if (node) {
+            g_mutex_lock(&node->lock);
+            if (!node->insn_disas) {
+                node->insn_disas = qemu_plugin_insn_disas(insn);
+            }
+            if (!node->symbol) {
+                node->symbol = qemu_plugin_insn_symbol(insn);
+            }
+            if (last_insn == insn) {
+                node->last_count++;
+            } else {
+                node->mid_count++;
+            }
+            g_mutex_unlock(&node->lock);
+        }
+
+        /* Store the PC of what we are about to execute */
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            last_pc, ipc);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "sort") == 0) {
+            if (g_strcmp0(tokens[1], "hottest") == 0) {
+                report = SORT_HOTDEST;
+            } else if (g_strcmp0(tokens[1], "early") == 0) {
+                report = SORT_EARLY;
+            } else if (g_strcmp0(tokens[1], "popular") == 0) {
+                report = SORT_POPDEST;
+            } else {
+                fprintf(stderr, "failed to parse: %s\n", tokens[1]);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 0b64d2c1e3..78dc7407a5 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -27,6 +27,7 @@ endif
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+NAMES += cflow
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.2


