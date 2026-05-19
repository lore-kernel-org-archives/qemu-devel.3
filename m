Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1123CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBjD-0002oc-IC; Tue, 19 May 2026 00:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBjB-0002lh-SE
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:06:45 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBj9-0003fL-KV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:06:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so542079866b.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163602; cv=none;
 d=google.com; s=arc-20240605;
 b=MS6oQd/WsjZn4GNT21ZPCZthuVxfVBYEdKMJtVmKyIEDSJQSAi9oZH0pSw+VYCr2hz
 R6qtk3aVUaEbZaJwyOPW2n4kf56QCCW/TdaOgRlAe2wQH68qNKXxtYd0navdwpl7fVbg
 O2VWDM3yatkjAJgPop30CjXC8QwBB9ulYgN6Cwl4NZ93OCuVvXLPF6uC2jMc1pAybRB4
 z3RRmNoIaiET0l5A559BaJAkADFy/K4IWLLjZ3SllR9OF/ViTf1XDQNhbi+LCERx/B/q
 d4JIamBxhcJF4qeXS6CDpL+OpiDh9IwOxi0DN4QvR+xv9A2dvKUkeuNjJSdyY0essHwb
 OU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7JpQCosnPKFIZKxRGUT0J9cCQP1htWgYa8qfIogLVkQ=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=PYK3+nnFiyexov7Wl57IWXTB/dj4VcnczfgaBYHN0n/ZqRvCx9Ft+dF4w+U3Pv4mwo
 HQyjhM89SrzLpGZIt5gx34WCUElS5yNPlyLuH34ATdnR19VvSzZ2Q/lGzF7SAUEsAfHK
 +dbo21gscvn9Mqpr+0BpV9/UhVuoUbx65XtQtSMBTWD2RlCFvcqFW9dqfHJUS4E798nH
 m++Yre8Urxjl/HZkRVAOQu+Q8msvsVgWLDWv8GwvJhE5Iu9E2SIb9PsHFLkkP2xWnFHT
 FTpVctoNSG45N8N8bM9YyciXWH+fvdv9Jp1vNdk0moDNGRtocgJuMOG2czxiZvhOe7r0
 B13A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163602; x=1779768402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JpQCosnPKFIZKxRGUT0J9cCQP1htWgYa8qfIogLVkQ=;
 b=mueTYFiDuy35DChsE6G/c1x8hs7xKdl12TwlK/2twMn9MQ6eO3f5M3VV3fKnYoA86+
 5QEK7rSWjnTZd4YzFrItYd5MbNgjOBsWBapHxYc6FYZnL4IbJYobAF7XrNWVzqOAt4sI
 zSQWWI9Wt+kowB97+hv71CUiB/mg25f7GZV/kyuVPrOGQqVOG1+AjOX5fwjB69wGlu9O
 PGFozRzZLxumJc/DhkAyW+Vdl4s9XVEjWfpdDzBsdXR/am6ac+IZrrPQB1/rcFYaPKw2
 vVE++RuJKcjckJh5MzTLrj30ipTYV6/NDta70H0YWmiaxwtwdC++iezT3vFo3BWomFKc
 I7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163602; x=1779768402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JpQCosnPKFIZKxRGUT0J9cCQP1htWgYa8qfIogLVkQ=;
 b=i04FZAa7eTCpv/bC7qOknlh4+swPXUXWkBs/OlwLD4EK62uNfHOeQEp0u32khBuljG
 GUA5+5x6C4kePXtjIR9dJZhO/HRhbov0bbC7pBhZ+gqnuMAAL82nFG/lC2vqnoWcXNyp
 MRI9OKsPZUYbqwqSogFkRzBGAXlITUiiylNBPRETiWbVMEfAS+AIp0JqJPxh5keJYPyS
 SUSEsVRl68KtrZrCR4rUeBPjuXXsPJeGIFiqhVdD5X5HuJg5Wyo904lHkHPCRDXVMH6f
 Fw70zwvYqmOQKWqP0johrT3tZz8G3h2vFHtoHf2e3a1nFYUix/Bp1lDGbptQMDApv/7m
 Qssw==
X-Gm-Message-State: AOJu0YxJIzRHNeYIwO12/zUkFIx8BCE3TZo5j1tqK0yjTED0vJQPaC44
 IO5YRW8PdgyK2h2qjNnhMeRJggxu9TmHZyL5TB8Zh3zWIgDF8ZgDRg4GI1ow5lxJNSWdmc6p5yS
 kbvAJZMX2WQ0ErPvaPJxcLoRqI7W05Z4=
X-Gm-Gg: Acq92OFH94WseJhq+WA0L4AQpRLlQyiOIoXDSJQPhmOusIurWnoE+A/L/uksPPLcDcx
 M0VMEpjOyoDFppah9MOBljs5ql5PyUfiWnuRJckipaStpOv0BCRA34w8eyH2aADV7kMkutEWakI
 wlW04yz0k9xvQ9PQIlcLv4LVxBeyMTYS+TTV6flXE2Dn6KlRcQmiHQfNrq41DWDxmK1uq8WkIkU
 4yVBbnhOLcXl5fSAxguQF5EriF5T7HP7yPf/+xlTafJL6CY8cY8ipVqkiWtIntLn5N2fIZ5bQOe
 nCOmOBkxKcMeneKf9K3CmNe3kkf6MvFIn3cCTg==
X-Received: by 2002:a17:906:5193:20b0:bd4:7cec:1066 with SMTP id
 a640c23a62f3a-bd517acd5e6mr703962066b.44.1779163601927; Mon, 18 May 2026
 21:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-15-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-15-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:06:15 +1000
X-Gm-Features: AVHnY4IxFIfQucsta7CX5JBrHSiVprSJAQ3s6EY7A5d9cpILn9-Hw5G1qnW1rtg
Message-ID: <CAKmqyKNoOwFv-v4Ba7j0nLyhYe6MxGL8tfo-8yennd8g=PChQQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] target/riscv/cpu: remove riscv_cpu_* arrays
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> There is no more uses left for these arrays. isa_edata_arr[] is doing
> everything we need, making our lives a little easier when adding new
> extensions.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 159 ---------------------------------------------
>  target/riscv/cpu.h |  10 ---
>  2 files changed, 169 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6dd05597e8..67452bb964 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1248,165 +1248,6 @@ const char *riscv_get_misa_ext_description(uint32=
_t bit)
>      return val;
>  }
>
> -#define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
> -    {.name =3D _name, .offset =3D CPU_CFG_OFFSET(_prop), \
> -     .enabled =3D _defval}
> -
> -const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
> -    /* Defaults for standard extensions */
> -    MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> -    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
> -    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
> -    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> -    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
> -    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> -    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> -    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
> -    MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> -    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
> -    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> -    MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
> -    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> -    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> -    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
> -    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
> -    MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> -    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
> -    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
> -    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
> -    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
> -    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> -    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> -    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
> -    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
> -    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
> -    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
> -    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
> -    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
> -    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
> -    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
> -    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
> -    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
> -    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
> -    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
> -    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
> -    MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
> -    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
> -    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
> -    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
> -
> -    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> -    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
> -    MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> -    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
> -    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
> -    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
> -    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
> -    MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> -    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
> -    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
> -    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
> -    MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
> -    MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> -    MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
> -    MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> -    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
> -    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
> -
> -    MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> -    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> -    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
> -
> -    MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
> -    MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> -    MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
> -    MULTI_EXT_CFG_BOOL("zbkb", ext_zbkb, false),
> -    MULTI_EXT_CFG_BOOL("zbkc", ext_zbkc, false),
> -    MULTI_EXT_CFG_BOOL("zbkx", ext_zbkx, false),
> -    MULTI_EXT_CFG_BOOL("zbs", ext_zbs, true),
> -    MULTI_EXT_CFG_BOOL("zk", ext_zk, false),
> -    MULTI_EXT_CFG_BOOL("zkn", ext_zkn, false),
> -    MULTI_EXT_CFG_BOOL("zknd", ext_zknd, false),
> -    MULTI_EXT_CFG_BOOL("zkne", ext_zkne, false),
> -    MULTI_EXT_CFG_BOOL("zknh", ext_zknh, false),
> -    MULTI_EXT_CFG_BOOL("zkr", ext_zkr, false),
> -    MULTI_EXT_CFG_BOOL("zks", ext_zks, false),
> -    MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
> -    MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
> -    MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
> -    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
> -
> -    MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
> -    MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
> -    MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
> -    MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
> -
> -    MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
> -    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
> -    MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
> -
> -    MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
> -
> -    MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
> -    MULTI_EXT_CFG_BOOL("zcb", ext_zcb, false),
> -    MULTI_EXT_CFG_BOOL("zcd", ext_zcd, false),
> -    MULTI_EXT_CFG_BOOL("zce", ext_zce, false),
> -    MULTI_EXT_CFG_BOOL("zcf", ext_zcf, false),
> -    MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
> -    MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
> -    MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> -    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
> -
> -    /* Vector cryptography extensions */
> -    MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> -    MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
> -    MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
> -    MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
> -    MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> -    MULTI_EXT_CFG_BOOL("zvknhb", ext_zvknhb, false),
> -    MULTI_EXT_CFG_BOOL("zvksed", ext_zvksed, false),
> -    MULTI_EXT_CFG_BOOL("zvksh", ext_zvksh, false),
> -    MULTI_EXT_CFG_BOOL("zvkt", ext_zvkt, false),
> -    MULTI_EXT_CFG_BOOL("zvkn", ext_zvkn, false),
> -    MULTI_EXT_CFG_BOOL("zvknc", ext_zvknc, false),
> -    MULTI_EXT_CFG_BOOL("zvkng", ext_zvkng, false),
> -    MULTI_EXT_CFG_BOOL("zvks", ext_zvks, false),
> -    MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
> -    MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
> -
> -    { },
> -};
> -
> -const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =3D {
> -    MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
> -    MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
> -    MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
> -    MULTI_EXT_CFG_BOOL("xtheadcmo", ext_xtheadcmo, false),
> -    MULTI_EXT_CFG_BOOL("xtheadcondmov", ext_xtheadcondmov, false),
> -    MULTI_EXT_CFG_BOOL("xtheadfmemidx", ext_xtheadfmemidx, false),
> -    MULTI_EXT_CFG_BOOL("xtheadfmv", ext_xtheadfmv, false),
> -    MULTI_EXT_CFG_BOOL("xtheadmac", ext_xtheadmac, false),
> -    MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
> -    MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
> -    MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
> -    MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> -    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
> -    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
> -    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
> -    MULTI_EXT_CFG_BOOL("xlrbr", ext_xlrbr, false),
> -
> -    { },
> -};
> -
> -/* These are experimental so mark with 'x-' */
> -const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> -    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
> -
> -    { },
> -};
> -
>  static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
>                               Error **errp)
>  {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 46bc29d307..3a91fe5f91 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -983,16 +983,6 @@ bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_=
offset);
>  void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
>  bool riscv_cpu_is_vendor(Object *cpu_obj);
>
> -typedef struct RISCVCPUMultiExtConfig {
> -    const char *name;
> -    uint32_t offset;
> -    bool enabled;
> -} RISCVCPUMultiExtConfig;
> -
> -extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
> -extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
> -extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
> -
>  typedef struct isa_ext_data {
>      const char *name;
>      const char *prop_name;
> --
> 2.43.0
>
>

