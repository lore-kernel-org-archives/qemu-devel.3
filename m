Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F8C54744
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj6BL-0003hd-RD; Tue, 27 Aug 2024 20:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj6BH-0003W5-Je
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 20:05:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj6B9-0005rq-Im
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 20:04:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7141b04e7b5so3794616b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724803489; x=1725408289;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nmfdDVi5FgIB7hY3jVkLfha/wn22ZY86E6OoRoOxpTY=;
 b=OM2K50jcCf84+zlfDJfaG8X/anS12Y6DKKrqWdFPnbpsIBmNilHoi8bFVkXb5m5o9r
 Mb4WSNHBL7dboPu/8z5C4s8hEX6V4Qh57xwR43YDNRixA7xolL5QQtqR5dcKLQ715Rv8
 bj8jdy39mDvXZK1vN4gilj1UuG/p4IyWvRjj/sMVkjcEnLPSuLjbu3ktTAFyyngKh6X4
 3hJooFOlsK+/P72wcIwhLJTGFhgNL5NlpEHnXx7e0zbB2HOMF3vcvHv4elpYbfFUAolZ
 ptKFFVErEFUyqF1Tydwa/PduuoM7JZhQ732imBMURO2n4jSFzfer+1LRJiRafWFoaDOu
 D5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803489; x=1725408289;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nmfdDVi5FgIB7hY3jVkLfha/wn22ZY86E6OoRoOxpTY=;
 b=ScBTHwOEt55x/r5CUVbVHiSd3UWL4N4hS3vIfPV9yH7B53lWLrzq5PVDHflEKizURI
 xOrl34raGXSjtdsD8hGhiNv2wYnvXd7GBtfv46OCuSlDeOUEmmc2lDzKFAlyV7Gcww5y
 c8lu+Shl2Ao5lFLXrF93ORwT7FU3dlY3VLSg7TXbIcg0u5LvhJRZFGNb6E0l+Kjv64Jq
 4ih48WnhFHwn/TW3UOv4pTZFxekK3sGvUIy4koZMbQqo0SF3LIY01OXrp3RTs4zYzKxV
 NiJC8/AIcpo0CK2B/Zot1CYAvLWd4jj6pbe+woF2tY5tutCBNmJh7I7TSE9xdiGonBbe
 wtKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGO8ijP16MKaEDAZNvEarb0OPsGcwTWRWWUbjimaZsIS0CTx24edGRAy8q/nojcgD6KZd/DwWwsN01@nongnu.org
X-Gm-Message-State: AOJu0YxP+5i9zbmqCAkK/LRu9jz/3cm4fw6VHBoHX4/7Fu9MDNeTzyxu
 0gqPqs4hB5iq3F8polseXIvAI8lp8+Cl+LSMzsjwuULcCLeFNH30aOjwnhd/3Ro=
X-Google-Smtp-Source: AGHT+IESTHxlU/FgwhPqlp5/aI+8Ieyv9QkNqzfosZ6fD3GeQYucSb+UfBh1XRO+uBwPuKB+p/x8vA==
X-Received: by 2002:a05:6a21:e8a:b0:1c6:ed16:30e4 with SMTP id
 adf61e73a8af0-1cc89d29e87mr16033693637.7.1724803488617; 
 Tue, 27 Aug 2024 17:04:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434231362sm9414143b3a.11.2024.08.27.17.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 17:04:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:04:46 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v10 00/21] riscv support for control flow integrity
 extensions
Message-ID: <Zs5pnnEiEcXpp2YT@debug.ba.rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
 <CAKmqyKPukMM7Q2o01c2Vmmqqhc2+f49FS=wM1oxRQ5mQaq2jAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPukMM7Q2o01c2Vmmqqhc2+f49FS=wM1oxRQ5mQaq2jAw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 28, 2024 at 10:02:42AM +1000, Alistair Francis wrote:
>On Wed, Aug 28, 2024 at 9:21 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> v10 for riscv zicfilp and zicfiss extensions support in qemu.
>
>Please specify the exact version of the spec you used

https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

>
>Alistair
>
>>
>> Links for previous versions
>> [1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
>> [2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
>> [3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
>> [4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
>> [5] - v5
>> +https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
>> [6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.html
>> [7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivosinc.com/
>> [8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivosinc.com/T/
>> [9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosinc.com/
>>
>> ---
>> v10:
>>    - Exposed *envcfg CSR and priv to qemu-user as well and removed special
>>      state management for *envcfg related feature enabling for qemu-user
>>    - Exposing zicfilp and zicfiss as different patch
>> v9:
>>    - fix switch case fallthrough for sw_check excp in patch 4
>> v8:
>>    - fixed up `gen_cmpxchg` to store extra word2 during compile to raise storeAMO always
>> v7:
>>    - Updated decode_save_opc to take extra argument of excp_uw2 and
>>      updated callsites
>>    - added a helper for promoting load faults to store faults
>>    - Removed stale comments and edited existed comments
>> v6:
>>    - Added support extra store word 2 for tcg compile and extraction during unwind
>>    - Using extra word, AMO instructions and shadow stack instructions can raise store fault
>>    - some alignment and cosmetic changes
>>    - added vmstate migration support for elp and ssp cpu state
>> v5:
>>    - Simplified elp tracking and lpad implementation as per suggestion by richard
>>    - Simplified shadow stack mmu checks as per suggestion by richard
>>    - Converged zicfiss compressed and non-comressed instructions to same translation
>>    - Removed trace hooks. Don't need for upstream.
>>
>> v4:
>>    - elp state in cpu is true/false instead of enum and elp cleared
>>      unconditionally on trap entry. elp in *status cleared unconditionally on
>>      trap return.
>>    - Moved logic for branch tracking in instruction translation from tb_start.
>>    - fixed zicfiss dependency on 'A'
>>    - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
>>    - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
>>    - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
>>    - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
>>    - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
>>    - removed vDSO related changes for now.
>> v3:
>>    - Removed prctl specific patches because they need to be upstream
>>      in kernel first.
>>    - As suggested by Richard, added TB flag if fcfi enabled
>>    - Re-worked translation for landing pad and shadow stack instructions
>>      to not require helper.
>>    - tcg helpers only for cfi violation cases so that trace hooks can be
>>      placed.
>>    - Style changes.
>>    - fixes assert condition in accel/tcg
>>
>> v2:
>>    - added missed file (in v1) for shadow stack instructions implementation.
>>
>> Deepak Gupta (21):
>>   target/riscv: expose *envcfg csr and priv to qemu-user as well
>>   linux-user/riscv: set priv for qemu-user and defaults for *envcfg
>>   target/riscv: Add zicfilp extension
>>   target/riscv: Introduce elp state and enabling controls for zicfilp
>>   target/riscv: save and restore elp state on priv transitions
>>   target/riscv: additional code information for sw check
>>   target/riscv: tracking indirect branches (fcfi) for zicfilp
>>   target/riscv: zicfilp `lpad` impl and branch tracking
>>   disas/riscv: enable `lpad` disassembly
>>   target/riscv: Expose zicfilp extension as a cpu property
>>   target/riscv: Add zicfiss extension
>>   target/riscv: introduce ssp and enabling controls for zicfiss
>>   target/riscv: tb flag for shadow stack  instructions
>>   target/riscv: mmu changes for zicfiss shadow stack protection
>>   target/riscv: AMO operations always raise store/AMO fault
>>   target/riscv: update `decode_save_opc` to store extra word2
>>   target/riscv: implement zicfiss instructions
>>   target/riscv: compressed encodings for sspush and sspopchk
>>   disas/riscv: enable disassembly for zicfiss instructions
>>   disas/riscv: enable disassembly for compressed sspush/sspopchk
>>   target/riscv: Expose zicfiss extension as a cpu property
>>
>>  disas/riscv.c                                 |  77 ++++++++-
>>  disas/riscv.h                                 |   4 +
>>  linux-user/riscv/cpu_loop.c                   |   4 +
>>  target/riscv/cpu.c                            |  10 ++
>>  target/riscv/cpu.h                            |  31 +++-
>>  target/riscv/cpu_bits.h                       |  17 ++
>>  target/riscv/cpu_cfg.h                        |   2 +
>>  target/riscv/cpu_helper.c                     | 155 +++++++++++++++++-
>>  target/riscv/cpu_user.h                       |   1 +
>>  target/riscv/csr.c                            |  84 ++++++++++
>>  target/riscv/insn16.decode                    |   4 +
>>  target/riscv/insn32.decode                    |  26 ++-
>>  .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
>>  target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
>>  target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
>>  target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
>>  target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
>>  target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
>>  target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
>>  target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
>>  target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
>>  target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
>>  target/riscv/internals.h                      |   3 +
>>  target/riscv/machine.c                        |  38 +++++
>>  target/riscv/op_helper.c                      |  18 ++
>>  target/riscv/pmp.c                            |   5 +
>>  target/riscv/pmp.h                            |   3 +-
>>  target/riscv/tcg/tcg-cpu.c                    |  25 +++
>>  target/riscv/translate.c                      |  45 ++++-
>>  30 files changed, 726 insertions(+), 53 deletions(-)
>>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>>
>> --
>> 2.44.0
>>
>>

