Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC1CF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQeh-0007M7-Bo; Thu, 03 Oct 2024 14:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe8-00079f-0x
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swQe5-0004qt-Hm
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:33:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20b8be13cb1so13600295ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727980427; x=1728585227;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0bfeDVPBZSmp2+YS83iZFQ1P4nx4twWjptbvaC9FnRY=;
 b=RDZ5ce8VjPHYufLlh4mqcY6ffZKCCgFt9u0p8/dSSRJmvSW1T/q5D72rGx8dHyk/TD
 1DLjILidlFP6g98DIDM2Pj+JMzl+bCKcAijzMOlrBvyI+UuTYzmtgzPenrrI1kgjdNjM
 SAOCKSiS++6gxcrO8pIznrRRrgflnK6hr4RJA/+LSnz6b0jtYvEFb0WmlHW/Ix7W+0Ze
 1yWcVA3g5nsNOiIu942o3EVlX57SHifHyGZ0FPfk8dzKJAfw3jcqSiM5Y8iCUQjYqP0z
 F9/KNSfruh4wD4j/e8Vv3vx0gfACAAIZOKNHemzbbAhXlEd+IVQcMj0jS2K9xu0iXolw
 psWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727980427; x=1728585227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bfeDVPBZSmp2+YS83iZFQ1P4nx4twWjptbvaC9FnRY=;
 b=YpQbAXv/+oC64IKsJdtEtIC+k6PDeJYVzwuL4nWQDMhNpgd/KpyqqkB8iQPhz9Z1dZ
 HbGFJyotPfzJE0wkWb+BsMdCcN31njJlQFo/bszhTNCjgYlpC5Jml958uwsPqu/jYMbm
 6LCTAwLFUaoDdfe3QlSxuO58lHGqigC6zwfI74+x5L1WuO4m454XGr1CmmWQ9BIOb1D/
 EPhcerrPOqCb5Ctn0BFYpiMQdTaBMQbKt/qCUXSi49HDhZUHO6rpIYRz3TtcuIIG8ZiX
 0lmWlXdRjyFMhLZz9P6b4zwXFmTRaztfHNQ2mANKjTWxlPPj9N05mAJOrz1dOHiNeZsW
 iZaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL5NOcv/FpF/C2+Z9rISTYpBtpFtP3Mip+m190cE9cujugCvbsw7Clmi5m+qU3S3WKbhZZ9B2071Fj@nongnu.org
X-Gm-Message-State: AOJu0YzjwCEvLVf8UbHKvS0+n957+5RsAQ2wzrrlvBAXlOt8nMdENO38
 +M2Jg0/AEF9fNEsuaRYGjiHNSNoc2FODSivwjQ55m2jBW56fKVCQaf12eSV0JNg=
X-Google-Smtp-Source: AGHT+IHsljXce6llMyx2ID95OCmfQhStjlvfsMqpMIFv5FfxqYNYd4gv5PmIgACDWh6rDTL9ddQu4Q==
X-Received: by 2002:a17:903:32c1:b0:20b:58f2:e1a0 with SMTP id
 d9443c01a7336-20bfdfd4340mr1893385ad.18.1727980427259; 
 Thu, 03 Oct 2024 11:33:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefad16asm11796245ad.193.2024.10.03.11.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:33:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v15 00/21] riscv support for control flow integrity extensions
Date: Thu,  3 Oct 2024 11:33:21 -0700
Message-ID: <20241003183342.679249-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

v15 for riscv zicfilp and zicfiss extensions support in qemu.

I've rebased again on https://github.com/alistair23/qemu/blob/riscv-to-apply.next
(tag: pull-riscv-to-apply-20241002)

There is an additional patch in this with comment title
"target/riscv: disallow probe accesses to shadow stack"

cache block operations of clean, flush and inval have store semantics.
These operations on shadow stack must look like regular stores and must
always raise store/AMO access fault. However with current logic,
`probe_access_flags` will succeed because it will be seen as a load.
In order to prevent that `get_physical_address` must receive `probe`
parameter. Depending on that parameter, `get_physical_address` can return
TRANSLATE_PMP_FAIL.

In v15, this is created as a new commit so that we can review and discuss
it out and placed this next to below commit.
"target/riscv: mmu changes for zicfiss shadow stack protection"

If this looks good, eventually I'll squash both the commits.

zicfilp and zicfiss spec pdf
----------------------------
https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

github sources to spec
https://github.com/riscv/riscv-cfi


Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
[5] - v5
+https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
[6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.html
[7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivosinc.com/
[8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivosinc.com/T/
[9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosinc.com/
[10]- v10 https://lore.kernel.org/all/20240827231906.553327-1-debug@rivosinc.com/
[11]- v11 https://lore.kernel.org/all/20240828174739.714313-1-debug@rivosinc.com/
[12]- v12 https://lore.kernel.org/all/20240829233425.1005029-1-debug@rivosinc.com/
[13]- v14 https://lore.kernel.org/all/20240912235320.3768582-1-debug@rivosinc.com/

---
v15:
   - Extended `get_physical_address` to take `probe` parameter. This is to ensure
     that cbo.clean/flush/inval accesses to shadow stack always lead to store/AMO
     access fault

v14:
   - Rebased on https://github.com/alistair23/qemu/blob/riscv-to-apply.next
v13:
   - Fixed bug(s) reported by richard that
         - shadow stack doesn't exist in M-mode
         - shadow stack is not available in M + U only config
   - updated commit messages with removal of `ufcfien` and `ubcfien` mentions
v12
   - Moved ssamoswap to trans_rvzicfiss.
   - Fixed bcfi_enabled in disascontext to rely only on tb flag
   - added comment on why PMP_TRANSLATE_FAIL for stores on shadow stack page

v11:
   - default *envcfg and priv for qemu-user are handled in `riscv_cpu_reset_hold`
v10:
   - Exposed *envcfg CSR and priv to qemu-user as well and removed special
     state management for *envcfg related feature enabling for qemu-user
   - Exposing zicfilp and zicfiss as different patch
v9:
   - fix switch case fallthrough for sw_check excp in patch 4
v8:
   - fixed up `gen_cmpxchg` to store extra word2 during compile to raise storeAMO always
v7:
   - Updated decode_save_opc to take extra argument of excp_uw2 and
     updated callsites
   - added a helper for promoting load faults to store faults
   - Removed stale comments and edited existed comments
v6:
   - Added support extra store word 2 for tcg compile and extraction during unwind
   - Using extra word, AMO instructions and shadow stack instructions can raise store fault
   - some alignment and cosmetic changes
   - added vmstate migration support for elp and ssp cpu state
v5:
   - Simplified elp tracking and lpad implementation as per suggestion by richard
   - Simplified shadow stack mmu checks as per suggestion by richard
   - Converged zicfiss compressed and non-comressed instructions to same translation
   - Removed trace hooks. Don't need for upstream.

v4:
   - elp state in cpu is true/false instead of enum and elp cleared
     unconditionally on trap entry. elp in *status cleared unconditionally on
     trap return.
   - Moved logic for branch tracking in instruction translation from tb_start.
   - fixed zicfiss dependency on 'A'
   - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
   - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
   - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
   - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
   - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
   - removed vDSO related changes for now.
v3:
   - Removed prctl specific patches because they need to be upstream
     in kernel first.
   - As suggested by Richard, added TB flag if fcfi enabled
   - Re-worked translation for landing pad and shadow stack instructions
     to not require helper.
   - tcg helpers only for cfi violation cases so that trace hooks can be
     placed.
   - Style changes.
   - fixes assert condition in accel/tcg

v2:
   - added missed file (in v1) for shadow stack instructions implementation.

Deepak Gupta (21):
  target/riscv: expose *envcfg csr and priv to qemu-user as well
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enable `lpad` disassembly
  target/riscv: Expose zicfilp extension as a cpu property
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: disallow probe accesses to shadow stack
  target/riscv: AMO operations always raise store/AMO fault
  target/riscv: update `decode_save_opc` to store extra word2
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: Expose zicfiss extension as a cpu property

 disas/riscv.c                                 |  77 +++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  14 ++
 target/riscv/cpu.h                            |  31 ++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 184 ++++++++++++++++--
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 ++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rva.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  61 +++++-
 target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 +++++++++++
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 ++++
 target/riscv/op_helper.c                      |  17 ++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  29 +++
 target/riscv/translate.c                      |  44 ++++-
 29 files changed, 749 insertions(+), 61 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.45.0


