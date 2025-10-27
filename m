Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AB2CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMtI-000441-Mr; Mon, 27 Oct 2025 09:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMtF-00043b-8Z
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:04:01 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMt3-0002Bi-2A
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:04:00 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-785bf425f96so64571417b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761570221; x=1762175021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kt6wRvWCapuP6eQwiwMm5FISru2nltH3tI61ZZlU1BI=;
 b=pH0dL6aE+XuHH8H94xnDrGCb9gfNA7XgymXnc/d32BwZI3ld+6zLkCV/t8BFP4Pmgj
 jqUP2OvMnDEl9kBhNcgO2RqtbJcYwbGJhQl8pO5LIj446D38WYPoygLF7bUzHF8oUBhz
 NlmtktWcs+2yeqI4medplwF8jcociIT89ROvO3qijKm3+KinEcyqJof+fyJ7PfA5f2zA
 3zyMIaRtgC6jGqtAs6X7FEvyl32OFQ7Yiiwls4xZjs3/mKq6CU0N6HnZzfB/c6IqCn/9
 goAE+/7CJVT9RoSo/yVPioVeF+E0SFww+Px9ZCEZ8kieKLYG5r4MpyBZqLtsPuT9gL+O
 Az6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570221; x=1762175021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kt6wRvWCapuP6eQwiwMm5FISru2nltH3tI61ZZlU1BI=;
 b=Fdut6SDMeBINKlMWbIeIgFodvM8C8pYn6E9JepIOR1R4Q8r51nRmhgJU/oONKgfCE7
 4ayuIS2o5ufPWLK1kU1hKrhJDLqz24rIymr/05KXHuXfNpx8HvwFT+xR/Ad/f6aVhjKa
 symO+w22/+vkxZoVQd+YvSoIwSpYB6UFjW1hvMmVc+QXZjeNZ0dhqohi76YyICYzLib2
 RgWMXmuKu9pMlQQMwEhfghDkyPvIdYUXNfV7sypeSFltqbJHTCs7vkTyQY62ui55YgYJ
 h891hqWAS06UqvLYOK+Ze/7FBRjc9mzi8b+wizYDYepkhaCb/osnDPGVtWLpUzdu70E9
 OctQ==
X-Gm-Message-State: AOJu0YzYwu4nsyNOKAGmYdO0KuuL+GXppNafggracDMrLUkXOVzbt8W9
 MhyRPIAfiF17SRbl7POKkfNP+IiVShXrY3IanXFIkKQzYt+n7KwtECDuhVJbRtCREZ61/2hixu6
 1cDy1d0qPYYHZU9dtyLp+FTYiBH8xfoj1iGB/e2i2lg==
X-Gm-Gg: ASbGncs2U8Q1WPGl08R7KirFHvRoFrnCzFGShUg+MNjjkGKRvnynsFex9gGVKZYq3lO
 MXalJ4FPXkU5v6FjIkmUBCtfPTG/oizwogJ17NJm4cXy2bt7VRfSVariSiVXNsTeSJ+0zA9++Y2
 G+wwGLSNyrV+0JCbHuPvRpPj+N2dht/lxcec2f8qnsyc6bfaWPKoeyuKaCGuAYth1IgE6UEHyHI
 6bxD8uJLritKuXYE+ITwVDZpRFkbtbTE7DlShXiRy86CebvG47o+qm2sQgoOGxEhP168y9w
X-Google-Smtp-Source: AGHT+IFT5xvhwytZDNj2emxXFogPeUvZY0lX3aixdWNDQ5JSytTQhO8nIaHfG4uZAQxZhYDqa/aYutQUVelKmasxdto=
X-Received: by 2002:a05:690c:9c08:b0:780:f3f3:b56c with SMTP id
 00721157ae682-785dd541c53mr99816647b3.9.1761570220830; Mon, 27 Oct 2025
 06:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
 <20251023121653.3686015-29-harshpb@linux.ibm.com>
In-Reply-To: <20251023121653.3686015-29-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:03:29 +0000
X-Gm-Features: AWmQ_blUxUCMkT6DyOyolBmluMavJuuiopB7ixurY3yA66a5NKfhxZsf1BDmPlQ
Message-ID: <CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com>
Subject: Re: [PULL 28/32] hw/ppc: Implement saving CPU state in Fadump
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 23 Oct 2025 at 13:23, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> From: Aditya Gupta <adityag@linux.ibm.com>
>
> Kernel expects CPU states/register states in the format mentioned in
> "Register Save Area" in PAPR.
>
> The platform (in our case, QEMU) saves each CPU register in the form of
> an array of "register entries", the start and end of this array is
> signified by "CPUSTRT" and "CPUEND" register entries respectively.
>
> The CPUSTRT and CPUEND register entry also has 4-byte logical CPU ID,
> thus storing the CPU ID corresponding to the array of register entries.
>
> Each register, and CPUSTRT, CPUEND has a predefined identifier.
> Implement calculating identifier for a given register in
> 'fadump_str_to_u64', which has been taken from the linux kernel
>
> Similarly GPRs also have predefined identifiers, and a corresponding
> 64-bit resiter value (split into two 32-bit cells). Implement
> calculation of GPR identifiers with 'fadump_gpr_id_to_u64'
>
> PAPR has restrictions on particular order of few registers, and is
> free to be in any order for other registers.
> Some registers mentioned in PAPR have not been exported as they are not
> implemented in QEMU / don't make sense in QEMU.
>
> Implement saving of CPU state according to the PAPR document

Hi; Coverity points out what looks like a memory leak in this
code (CID 1642024):

> +static void *get_cpu_state_data(uint64_t *cpu_state_len)
> +{
> +    FadumpRegSaveAreaHeader reg_save_hdr;
> +    FadumpRegEntry *reg_entries;
> +    FadumpRegEntry *curr_reg_entry;
> +    CPUState *cpu;
> +
> +    uint32_t num_reg_entries;
> +    uint32_t reg_entries_size;
> +    uint32_t num_cpus = 0;
> +
> +    void *cpu_state_buffer = NULL;
> +    uint64_t offset = 0;
> +
> +    CPU_FOREACH(cpu) {
> +        ++num_cpus;
> +    }
> +
> +    reg_save_hdr.version = cpu_to_be32(0);
> +    reg_save_hdr.magic_number =
> +        cpu_to_be64(fadump_str_to_u64("REGSAVE"));
> +
> +    /* Reg save area header is immediately followed by num cpus */
> +    reg_save_hdr.num_cpu_offset =
> +        cpu_to_be32(sizeof(FadumpRegSaveAreaHeader));
> +
> +    num_reg_entries = num_cpus * FADUMP_PER_CPU_REG_ENTRIES;
> +    reg_entries_size = num_reg_entries * sizeof(FadumpRegEntry);
> +
> +    reg_entries = g_new(FadumpRegEntry, num_reg_entries);

Here we allocate memory into reg_entries...

> +
> +    /* Pointer to current CPU's registers */
> +    curr_reg_entry = reg_entries;
> +
> +    /* Populate register entries for all CPUs */
> +    CPU_FOREACH(cpu) {
> +        cpu_synchronize_state(cpu);
> +        curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
> +    }

...then we populate reg_entries with data...

> +
> +    *cpu_state_len = 0;
> +    *cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
> +    *cpu_state_len += 0xc;                      /* padding as in PAPR */
> +    *cpu_state_len += sizeof(__be32);           /* num_cpus */
> +    *cpu_state_len += reg_entries_size;         /* reg entries */
> +
> +    cpu_state_buffer = g_malloc(*cpu_state_len);
> +
> +    memcpy(cpu_state_buffer + offset,
> +            &reg_save_hdr, sizeof(reg_save_hdr));
> +    offset += sizeof(reg_save_hdr);
> +
> +    /* Write num_cpus */
> +    num_cpus = cpu_to_be32(num_cpus);
> +    memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
> +    offset += sizeof(__be32);
> +
> +    /* Write the register entries */
> +    memcpy(cpu_state_buffer + offset, reg_entries, reg_entries_size);
> +    offset += reg_entries_size;

...and then we eventually copy the reg_entries data into
the cpu_state_buffer. But then we never free reg_entries.

g_autofree would fix this.

> +
> +    return cpu_state_buffer;
> +}

thanks
-- PMM

