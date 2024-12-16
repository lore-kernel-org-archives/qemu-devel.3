Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8671DE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBQJ-0007d8-Sm; Mon, 16 Dec 2024 08:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNBQI-0007cj-7j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:46:10 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNBQD-0004XA-6Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:46:09 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21644aca3a0so48014575ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 05:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734356763; x=1734961563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jOT6azWu/4vWqd7yj69cOEmNnKiVJ8UI17bnozyII7U=;
 b=JtYM61KTpSvAv640HFfmAaD3jwSC1KAxIJ1lo3qVlBSMuEug8IGz6fpvJ9RZsYMumJ
 ShaEVlhzcvB0vTuBML+YNpKMWvA03BwhRG0ZDvZTYCXhRviPtc6dRenDcPNsSPXms9Yw
 U6Q7EB/0kwiS/+KlpHHmNE3yz4ha3APQICCFt4P0HbUoXSU7goT71OT1QmmBQsKW9MUA
 ovKq3St9vZCb8GtIHv59d3+ExAUVMkkJVXiOQlJ/ONXu7KO7siLR87Y31AQJ/mEyAq72
 /0JfcvIDBcvclbm2cHofq8Wpz4c8/Yu/h7IegOUr+7CRo14LhL6gfBc9OWun2RlGLxKF
 2cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734356763; x=1734961563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOT6azWu/4vWqd7yj69cOEmNnKiVJ8UI17bnozyII7U=;
 b=Jxeh1+QJEdarH9mzFihAQwUy5CMQmltpxX2UYNPMjjSmKhwUV4aKEFHrqujFaJVqRz
 +WeS+NmSPN5jkfU4icGGtJHjGDcK7FBQQBXepbcgi76WoarFkM6N4ZlbSotlRbS+QnCv
 vyzgW1Wr6A4yUgL86u2CXxrsfsS5JVyJGwCU6MGsapqPV40KG9IeU5J3VTVISdiLB5FP
 G357+mdXwaerXV8dK/wwp2WGb/bbRqI35Nlk+3Yyrkw+O4GGRfSZC8jp0IlR5eChORNp
 P3A9RYcayoc3puWymH5JMhbzuviIDFz2NiOJyaTitzFTjvax1aNx2UxH868AQTPHdZM6
 DrHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYHVP9+neEzQXgKCPfQ0pmZx0o6ozpeVTdtbW7RswRWTpWCWDfpfc0GSh3sKX/tsBsnx9msDKOJTYm@nongnu.org
X-Gm-Message-State: AOJu0Yztpc9bXqg7951Gb1ocu0smMiGOvI2Dlgo3UxCXU9ieRUJO2Uf8
 d6kBtGIpRl02AmBQJx6Nnq/b1bcw8b606eSWybm0lE2Ow+ng2V37srwwuCSG5rg=
X-Gm-Gg: ASbGncuyvJyKJUXDuDDz+6rNSyDgcc3vCOxpEWo7FWTBHyu+Jfm/rpGiYpzoGwA6AWM
 JHP9A0ggabYXW0+Hi6y9Cdsm3pzkcA74+P3Z8/wS05Q+DNCRGN0FKTZduqg3UBz+Ub0P0k/DG26
 hprvjrJXqsx7uAOplNM5a8vercnGWtYztFlQZaiKIKO61NDH6/gF14nNQKini3CvKldGOTMX5X5
 crYami4YLY6EZ4QH3UMX4pVe+t0fmBfBr6siE0Wcrp8uQL/c2jbRDq8zuF1oXGH2UHhFg==
X-Google-Smtp-Source: AGHT+IFd+ipCzlJ4dkSeS1MbRJiztxS6HuM3+vk/M8Aa7Ty4uvLkMHjYfbcdme44gMKB2D8q/X1sGw==
X-Received: by 2002:a17:902:f64b:b0:216:55a1:35a with SMTP id
 d9443c01a7336-218929ee63cmr187299665ad.30.1734356763069; 
 Mon, 16 Dec 2024 05:46:03 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5c4c8sm42823925ad.176.2024.12.16.05.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 05:46:02 -0800 (PST)
Message-ID: <b25e776f-43f1-4d8d-a103-64ddfce75412@ventanamicro.com>
Date: Mon, 16 Dec 2024 10:46:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Add Smrnmi support
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241122032217.3816540-1-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241122032217.3816540-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Frank,

Sorry for the delay.

It seems like this series is breaking the "make check-functional" test:

$ make check-functional
(...)
  9/10 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv32-riscv32_tuxrun TIMEOUT         90.03s   killed by signal 15 SIGTERM
10/10 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-riscv64_tuxrun TIMEOUT        120.08s   killed by signal 15 SIGTERM

Ok:                 8
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            2

The reason for the timeouts is that the tests are trying to boot Linux with
'rv64' and 'max' CPUs, and the timeout occurs when trying to boot using
the 'max' CPU, i.e. it is using a CPU with ext_smrnmi enabled.

 From the cover letter it seems like we need a special OpenSBI to use the
extension, but apparently not having a customizable OpenSBI will make the
extension misbehave.

My suggestion here is, in patch 5, remove ext_smrnmi from the 'max' CPU.
We can re-enable it when our OpenSBI image has the proper support for it.
Like this:

$ git diff
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3480767b35..f3fb1c432b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1429,6 +1429,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
      if (env->misa_mxl != MXL_RV32) {
          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
      }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
  }
  
This will make 'make check-functional' work again. Thanks,


Daniel



On 11/22/24 12:22 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> This patchset added support for Smrnmi Extension in RISC-V.
> 
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
> 
> =============================================================
>    * mnscratch (0x740)
>    * mnepc     (0x741)
>    * mncause   (0x742)
>    * mnstatus  (0x744)
> =============================================================
>    * mnret: To return from RNMI interrupt/exception handler.
> =============================================================
> 
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
> 
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
> 
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.
> 
> If anyone wants to test the patches, we can use the customized OpenSBI[1],
> and the customized QEMU[2].
> 
> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> In the customized QEMU, we use the Smrnmi patches and the patch from
> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> the RNMI signal with the qmp command.
> 
> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> [2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v8
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
> 
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
> rnmi-interrupt-vector={Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=off
> 
> Use qmp command to inject the RNMI.
> 
> Assert RNMI:
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=true
> 
> De-assert RNMI:
> (QEMU) gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi number=0 value=false
> 
> Changelog:
> 
> v9
>    * Add Zicfilp support for Smrnmi.
>    * Change the existence checks for 'rnmi-interrupt-vector' and
>      'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpvec'.
>    * Add warn_once messages for cases where the user sets
>      'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
>      enabling Smrnmi.
> 
> v8
>    * Set virt to false when trapping to M-mode by RNMI.
>    (Thanks to Clément for the suggestions.)
> 
> v7
>    * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
>      checking codes.
>    (Thanks to Clément for the suggestions.)
>    * Add the missing REQUIRE_SMRNMI() check and remove the redundant
>      check in 'helper_mnret'.
>    * Rebase to riscv-to-apply.next.
>    (Thanks to Alistair for the suggestions.)
> 
> v6
>    * Delete the redundant code in 'riscv_cpu_do_interrupt'.
>    (Thank Alvin for the suggestion.)
>    * Split the shared code in 'helper_mret' and 'helper_mnret' into a
>      helper function 'check_ret_from_m_mode'.
>    (Thank Alistair for the suggestion.)
> 
> v5
>    * Move the patch that adds the Smrnmi extension to the last patch.
>    (Thank Alistair for the suggestion.)
>    * Implement an M-mode software PoC for this with implemented handlers.
>    (Thank Andrew Jones for the suggestion.)
>    * Add a commit message to all patches of the series.
>    (Thank Andrew Jones for the suggestion.)
> 
> v4
>    * Fix some coding style issues.
>    (Thank Daniel for the suggestions.)
> 
> v3
>    * Update to the newest version of Smrnmi extension specification.
> 
> v2
>    * split up the series into more commits for convenience of review.
>    * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
> 
> Frank Chang (1):
>    target/riscv: Add Zicfilp support for Smrnmi
> 
> Tommy Wu (5):
>    target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
>    target/riscv: Add Smrnmi CSRs
>    target/riscv: Handle Smrnmi interrupt and exception
>    target/riscv: Add Smrnmi mnret instruction
>    target/riscv: Add Smrnmi cpu extension
> 
>   hw/riscv/riscv_hart.c                         | 40 ++++++++
>   include/hw/riscv/riscv_hart.h                 |  4 +
>   target/riscv/cpu.c                            | 18 ++++
>   target/riscv/cpu.h                            | 10 ++
>   target/riscv/cpu_bits.h                       | 24 +++++
>   target/riscv/cpu_cfg.h                        |  1 +
>   target/riscv/cpu_helper.c                     | 96 +++++++++++++++++--
>   target/riscv/csr.c                            | 82 ++++++++++++++++
>   target/riscv/helper.h                         |  1 +
>   target/riscv/insn32.decode                    |  3 +
>   .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
>   target/riscv/op_helper.c                      | 54 ++++++++++-
>   12 files changed, 342 insertions(+), 11 deletions(-)
> 
> --
> 2.34.1
> 
> 


