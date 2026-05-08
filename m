Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ADECD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHIt-0002i3-IX; Fri, 08 May 2026 05:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLHIs-0002hp-2R
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:15:26 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLHIp-0005Tv-OB
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:15:25 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso1899600d50.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778231722; cv=none;
 d=google.com; s=arc-20240605;
 b=h0+SsngxUp2jJYkrEC6V6UF+UUICQfCOvlk3NfNlrQNsV1z37FzOjF4+lp4dJWUWzB
 Z+d0O2/fGBLdWpzher6kpxlkBxTA+DeiL0DvFtlEa+cnuEEWduo4A+rq7TRvbpYGvbYt
 ihtp98m3S7YtrMUXO1uEV6nWCUsOMbbgdAy91MkysDuMZsHtdu4P8QJnVHTVMxhpOmDh
 vGGphie8tbk9p66r0QunCa9R20ZYowzOZ0/pQ2k20/7Cj+folDavHCxL9RqT31RXNvfE
 jaVMS8/6jduqJbDfsHFHTynsIzHHYvdj9aNVite3pI2oPKlbjidroiVamWjcx4ZSs3xq
 QD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9TVSPzzJxY28adKUaoMwpTrf5uwiHzDfYhfCU2aCZgw=;
 fh=BoBtLkC3p7/E0Wmh4xQxVreGMsoivKcLJ0e1UEyP10k=;
 b=FawKRthJ8yfdfM7N/rHkzaG3rYX24ojQnhHT3I6jUlGOJGZQTDdx8s4uMh2EIvKE6d
 mtS4qxl/tjbHGaElqJmqM8khwbknEnmhKV85Xiq/RuWLEJcIbFYRwz9UtaEeLvzmj5VI
 oOBGVC0UEyvDxRXCFja5XemHuSq5R+7kbLgSHnVfDI6F3qa1nHheO6TVK4S2OPK8bYOM
 KJD9iDmegOSuPpRWccJO/xRQqDidDCGetxRFwQWA6JhsRNmeknoSu9R9rvlyqgAMkE6J
 endsjMybjKfwCL1PDr/90cNVLiBwjTZvFNZt4F9DPdlU1KwpXpuXkFBCH1geNN6IfBwG
 Dn2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778231722; x=1778836522; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9TVSPzzJxY28adKUaoMwpTrf5uwiHzDfYhfCU2aCZgw=;
 b=lUJsBN23vo404pr5lQzyDoHLljOcUezhALbtwwpnGxCPk+WYTFW3DqgTWWKrL30ihs
 OIwYdqlYY4mdCl2jc+RWvRqcaM9OUOroxc2NRdm7XLEsbS4R097icDywfYEwO1cHg50s
 fIaX9dSjaXxYuJHwRcnpFnRHlnpOCpZhsiV8Tg7XHpf5BPHddcjsHxCoU5Y2vP4bbCEo
 Q3SJmwXlXJpvDHbVkBW14BqJEP3CfXr085BOV/cOlDnvAt0GCcvZWTDJ24YAydH2mRcl
 5U2SAhoJODxkjY3ca5OIbnIMvWEnKEwjxnF1bac/kAV0NzMmLJGd4+XFOwjbr+Nlo/Bf
 mvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778231722; x=1778836522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TVSPzzJxY28adKUaoMwpTrf5uwiHzDfYhfCU2aCZgw=;
 b=dp0qIPqj5LgegSfvjNROgKP6i6NhRxwTmfIVz8EAzeVp7TCLpE2osQnMD5YHFe8x59
 KQrTcy0e/X9TqaE+BMS7k3DcHYA5ZAlFEyxTUx5Gu6tLkxTLoWkVvRQBTpUsk2mt2rYa
 LrGGm/hnyMr6bcVFORlCg/1FiNbYolocjuLtUhHJ5+ACeWTPXg6cUEZ/Jf4s0pPqRJ73
 3LG7HNV7V6H9Kuhy3apnnJPbiX9RhUcmsrNm0kIxB+tPdJ8EoaQik4+DkHdp1rrVe4/L
 nXssAxNbkK/XRIeUw2nzpUK+3sEadJLMC7vcgt2oB8XEuuOuip6FHPXtCKlmcFxnqKxR
 j1cw==
X-Gm-Message-State: AOJu0YxU1NNnEVFCxpJwqysgauJ8f9aw64qhs1vRMDol92D+QoUmEatc
 lxtxg9rvpyMl2yCKYwqdErB1D98TbzO1nKz7GUUeBqCNeSBqMLw5Q7ubOOcnw7qLISrR1GpCmZ6
 WKrqW82hx4A78pY+cRIV7f8LYaEPxkTXXu2RBI6+aAg==
X-Gm-Gg: Acq92OGyXk6kpWClr0Y7OuQFPvYb+BbpPrcKAlTdi2mYs2X1Uk1KMBkMVT5q5Hr4rsV
 Ooqnjj4g64DsASel2gfIaXVyxccp9WeLZcAPBIMEDZi3stbFcXiupvz8y0dI/8W6yre0KpQlnWC
 D+IP518YzZvLnkFkQjr0OjbmmU57YixMU1jTVDgij/UKlCz9ZLOREB318wTLCpcr5coJJ58dgzM
 Rs1R76LoFrWaYeVsbZEELZSTo9X+Z7w04fa2QdzWbdtUv/gja0E1B2x4UolWe6585wOU5lA3tUR
 5Dwci0Tym1fcxAKeKNoyJkQ0ECnWn4Q5Xknnq1LThFH7yDwZxEcZBwfiadwxEN1npvw=
X-Received: by 2002:a05:690e:2145:b0:65c:5bfd:b205 with SMTP id
 956f58d0204a3-65c79a03985mr9731450d50.62.1778231722143; Fri, 08 May 2026
 02:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
 <20260429183310.12455-7-harshpb@linux.ibm.com>
In-Reply-To: <20260429183310.12455-7-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 10:15:10 +0100
X-Gm-Features: AVHnY4IqP83m8U1sw8CWfQG-dsc09pn6fCE9_okDMy9YpFZ7hZS6zV_Krpl0Byo
Message-ID: <CAFEAcA8L3CXj1gc3dXehhZWd5rPyuF6bykNR5Oy=u0ZWyR2sLg@mail.gmail.com>
Subject: Re: [PULL 06/13] pnv/mpipl: Set thread entry size to be allocated by
 firmware
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>, 
 Hari Bathini <hbathini@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 29 Apr 2026 at 19:35, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> From: Aditya Gupta <adityag@linux.ibm.com>
>
> Set the "Thread Register State Entry Size" that is required by firmware
> (OPAL), to know size of memory to allocate to capture CPU state, in the
> event of a crash
>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-7-adityag@linux.ibm.com
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Hi; Coverity points out an issue with this change (CID 1658041):

>  static void pnv_reset(MachineState *machine, ResetType type)
>  {
> +    PnvMachineState *pnv = PNV_MACHINE(machine);
>      void *fdt;
>
>      qemu_devices_reset(type);
>
> +    if (!pnv->mpipl_state.is_next_boot_mpipl) {
> +        /*
> +         * Set the "Thread Register State Entry Size", so that firmware can
> +         * allocate enough memory to capture CPU state in the event of a
> +         * crash
> +         */
> +
> +        MpiplProcDumpArea proc_area;

Here we don't initialize the struct...

> +
> +        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
> +        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
> +
> +        /* These are to be allocated & assigned by the firmware */
> +        proc_area.alloc_addr = 0;
> +        proc_area.alloc_size = 0;
> +
> +        /* These get assigned after crash, when QEMU preserves the registers */
> +        proc_area.dest_addr = 0;
> +        proc_area.act_size = 0;

...and here we don't fill in all the fields; we don't set
the reserved, reserved2 or reserved3 fields to anything.
This means that we will write data to the guest which is
potentially random host data from the stack.

I think I'd suggest fixing this by initializing the struct in
one go, like this:

    MpiplProcDumpArea proc_area = {
       .version = PROC_DUMP_AREA_VERSION_P9,
       .thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState)),
       [set alloc_addr = 0 etc here if you like, or rely on
        the "fields not listed are zero-inited"]
    };

(In fact because we use -ftrivial-auto-var-init=zero the compiler
will zero init this for us anyway, but we can make Coverity
happy anyway.)

> +
> +        cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
> +                sizeof(proc_area));
> +    }
> +
>      fdt = machine->fdt;
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>  }

thanks
-- PMM

