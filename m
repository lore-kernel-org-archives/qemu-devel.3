Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D01DCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEHL-0005ro-OH; Tue, 21 Oct 2025 11:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEHK-0005rK-5T
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:28:02 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEHI-000436-5u
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:28:01 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63e255e9a20so4081630d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060478; x=1761665278; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L43iFA6FCfUUf1K+8zhEfbHuhMh3iTL3XpwYLLEoK/E=;
 b=dyzmcDhmfl4P7B9wTIhU8O1Affb2LR/H9xX0gwC9gBv2VGnIfX+cWPdFssLQvOZLq1
 WtPz4tyT93ePYlWPpW109EmrizCgRFmdf/8Z+1E9oTg2EkGVc1Z6Us36wwqxcwBfC3So
 nE+FVB1ORLoujppUFbfhEpCmJqc06dSlTa1RYhPY20gSRuVs7MiUVla+0OPDPA9maNtf
 XBGwHxhAW+vVAbijeswY+PTCn9UYr4qIi+cPyzPdp2R5VSRo+nUNTPePk3FvL5MkDU1V
 3OHODwfC3cFFkgQqHOe44VQNoOp90T+tGcNprQnZXRYx3hfHzpSSgajodmK3y/FIwvwS
 MnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060478; x=1761665278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L43iFA6FCfUUf1K+8zhEfbHuhMh3iTL3XpwYLLEoK/E=;
 b=nPVq8q0hTpqOgTufRbi0obQSvqkN8+/geNfvoIYVn9qJ6NLAxsfGSZ2kPSHkuzliBw
 5yn7d+bBzpE9pOWUzl6zZY90LoEfTrrfq7mycJr2TnnbbZrGmS2SKITuqJ7macY7TmG+
 TrrNS2gleJxtjkskPVBjuP0y2VV9dwv1ZJgxwhZcTBaTbkZbuv7VZqOUZUGQanBuTBfk
 bKZEyb+KS8wdbllsdHxfqr87YNpgkRXUt2DMscRwBEFZO2VjDOdbYV84IhTtlxHnGdB6
 4qGlF4fzhDouDCKK9RjkCE0czvfv6F1Kp2hyPlXOOhOrUe0Idu1tUNfYxBMgKPKNozYq
 I1cQ==
X-Gm-Message-State: AOJu0Yy6go4+pHe1VzIS11jUCnGoGhGfaR+G1DePHjRjnORokmSCdPQO
 gCT89B3zwDl3Jug/5HjUPwt5Bcz+ElgS1FoIkOJjzr6fzseCUdeUEU5mmHjzjyUd2Sa/a/QU8tn
 2Ccz5ZEcXA8snAiphK86SsLbKP3T6NCuKmYfljT6PerSjhxJhPOuY
X-Gm-Gg: ASbGnctE1cZxfnSOpmWbh2dmJYWCihoPx+ERDgy8lT1XQHA5hMOvLELUMfdq1PefUan
 kD0TFVJufw840FxGb/60CZXCioRAuXqYpl2J0jg1fL/SpOXVBkbYVOwoHj66i4ktAHBBIcIp6xS
 2llVWKFnt3OHd8U3xrbCbFQH1/cY+/WSz91Ur1BVNd1bGYHI3NjxzNcRQyNxw2Dmx/5HkBYMT5N
 q87uGgTzl7A0rmSzMBVhwbXPHr37a55NLdmp6pRVXUvSzPaXou6hnQATNcreARPAjq/oEhE
X-Google-Smtp-Source: AGHT+IHXEvlVagaBtex2xOBTyaa5RDaQHRvY6tHDX0avh6T/TMdrwa0WHXDIfDEtaY4AEOLPb3UmQJxtD+/sPh91AW8=
X-Received: by 2002:a05:690e:1443:b0:63e:1ef8:ca3 with SMTP id
 956f58d0204a3-63e1ef81ademr12006718d50.50.1761060478152; Tue, 21 Oct 2025
 08:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-29-pbonzini@redhat.com>
In-Reply-To: <20251009075026.505715-29-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:27:46 +0100
X-Gm-Features: AS18NWBtbUhvSUWEWnKLO5gCiy6It_W1zAhd7iJ8T-5Te_EDTwhsjvYOoCwj4Lk
Message-ID: <CAFEAcA-NPDB7TMFeGJqaYJUZG13Lkxfc7o8yUbJfighH_xp8Dg@mail.gmail.com>
Subject: Re: [PULL 28/35] target/i386/mshv: Implement mshv_vcpu_run()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 9 Oct 2025 at 08:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>
> Add the main vCPU execution loop for MSHV using the MSHV_RUN_VP ioctl.
>
> The execution loop handles guest entry and VM exits. There are handlers for
> memory r/w, PIO and MMIO to which the exit events are dispatched.
>
> In case of MMIO the i386 instruction decoder/emulator is invoked to
> perform the operation in user space.

Hi; Coverity complains about this code (CID 1641395):

> +static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
> +{
> +    uint8_t access_type = info->header.intercept_access_type;
> +    uint16_t port = info->port_number;
> +    bool repop = info->access_info.rep_prefix == 1;
> +    size_t repeat = repop ? info->rcx : 1;
> +    size_t insn_len = info->header.instruction_length;
> +    bool direction_flag;
> +    uint32_t reg_names[3];
> +    uint64_t reg_values[3];
> +    int ret;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
> +    ret = fetch_guest_state(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to fetch guest state");
> +        return -1;
> +    }
> +
> +    direction_flag = (env->eflags & DESC_E_MASK) != 0;
> +
> +    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
> +        ret = handle_pio_str_write(cpu, info, repeat, port, direction_flag);
> +        if (ret < 0) {
> +            error_report("Failed to handle pio str write");
> +            return -1;
> +        }
> +        reg_names[0] = HV_X64_REGISTER_RSI;
> +        reg_values[0] = info->rsi;
> +    } else {
> +        ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);

We set ret to the return value here, but there's no error check.
Should there be one here?

Coverity complains because we assign to 'ret' here but
then never read it again before we overwrite it with
the call to set_x64_registers().

> +        reg_names[0] = HV_X64_REGISTER_RDI;
> +        reg_values[0] = info->rdi;
> +    }
> +
> +    reg_names[1] = HV_X64_REGISTER_RIP;
> +    reg_values[1] = info->header.rip + insn_len;
> +    reg_names[2] = HV_X64_REGISTER_RAX;
> +    reg_values[2] = info->rax;
> +
> +    ret = set_x64_registers(cpu, reg_names, reg_values);
> +    if (ret < 0) {
> +        error_report("Failed to set x64 registers");
> +        return -1;
> +    }
> +
> +    cpu->accel->dirty = false;
> +
> +    return 0;
> +}


thanks
-- PMM

