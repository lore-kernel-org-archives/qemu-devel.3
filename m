Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CB8E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNARI-0003AX-Gq; Mon, 16 Dec 2024 07:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNARE-0003A0-4y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:43:04 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNARB-0003hW-Sq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:43:03 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-728e729562fso3289253b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734352979; x=1734957779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lR4Ob4HFuuI/u6v7+ms/UJZ50Y5JwrnsLbwnfQFpsv8=;
 b=lSfFD8rwjvL7TEJh0wPCp0M/NisP91AT16n26z3Pe8a9EFEXZBeVvQ2YKsuMLezJSL
 5qbQlOHKtdcKtpZukzVupZy0oP0V4K7SSpbiJK+jir4VKa2NBnEORPwlU7zVUeM3Gza/
 7ichGZ/6gEv+vP2ZFWEYiF/8OhecLMO/cDd3uZocw/rQtg6u+ngJcDun97lF6jbKrrwU
 O486KkLNqTNPWxgn4FKlp05l0QxLFuaNUCCAouQm8NT39ijMlUr2f5i2h+zCHHEOX7mE
 shMVtv0U4UuKqApb71udG7EYzwy7r1i5d3ObdC1RYhbsdRh7M6458TRLTLVe0LokucT9
 Jm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734352979; x=1734957779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lR4Ob4HFuuI/u6v7+ms/UJZ50Y5JwrnsLbwnfQFpsv8=;
 b=s0DpEieUq9hbVg2B5riKnUQdnEHQ/7n4Y+SQWdoQlDa9V3f/yA5S8Zp0D6cwa0k2IX
 5JTCR3aSxoUU72FwRy7q3J4rLf/25oavB0NqhR9k+t1qCUvpJnfvJQc/fJ5up8YX4MQx
 B1sFoPITazmEh6RfB2GLA/xpIUt3Q6uEnpeeMGCD3yEKXaGV1OG1YmI2Idk1221I+TL1
 uRIFY96NfOtC6PYZ/91xUU7IDRQRW/pnDVTntG6R3+TbvOHcCnEC6BMzA7M59AcTop4r
 BVqI35066IX73hDknOitySD2jMc6gqEezh28qwPvaUqA1+UElb/HjAFtvcE7FB/BQT45
 9COg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEQW1eS5cTBGTZygS48i9lWL6QHgF5gRpxIRP6MKr4F9XUU7/fkvBmvZgYQrnfnDzkS1EkjCRdz6Mo@nongnu.org
X-Gm-Message-State: AOJu0Ywg8M+cD/4JOvrBtzMz7nBCOusiPYTsirbjvpyKYuFAaHjfW1fL
 Lsta79GQ37a8Nio0spxr6wnrRcmbXKDbnnSy+L8sJVuxFed6XDswlPJGoAqIv/s=
X-Gm-Gg: ASbGncuqhoS41NRORR2BpdTqvpz0eWwU9jOrfqDSTipUVno8ZBK+Coiz3tFLU3/qZnw
 UO8MvDRAuuWS3hvNZ0sgK/0maxqoKrkEWpWq3BIG/8YBYd0xjIXqyxJBFOvIca8zkpbCnPXXVKs
 auY4Rd+BWRsz5piniLPRKOCPtqdmzESwP1kd/vPtnD3fgRt2o7KrrGA7ATVIOco/xGBHCA7jAt4
 kncSASqtmSo3Z7gLgc4EMrdTJTzJa3/BnP283icZQbUDvJATlCMCarJVFyUMRwHsHpB3Q==
X-Google-Smtp-Source: AGHT+IEp8ARYlECFjvF/Cy/qp8j6wnlVsWXmdu4lEa+3QZz5QNRk/tg5Wa1XlxGANptA8139z6aJog==
X-Received: by 2002:a05:6a20:a10d:b0:1e0:dc7b:4ee9 with SMTP id
 adf61e73a8af0-1e1dfd1f3f3mr17698100637.8.1734352979468; 
 Mon, 16 Dec 2024 04:42:59 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac51dbsm4659594b3a.13.2024.12.16.04.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 04:42:59 -0800 (PST)
Message-ID: <6a1f1b88-0c88-408d-b6e8-a26b5db592e4@ventanamicro.com>
Date: Mon, 16 Dec 2024 09:42:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/7] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-8-baturo.alexey@gmail.com>
 <69de5c69-1583-4a0f-9db6-c61e721adbe1@ventanamicro.com>
 <CAFukJ-Dwfg33GuXs9oqe0D5KqGBtBydn9AQ6p96iD6vSi_akHQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFukJ-Dwfg33GuXs9oqe0D5KqGBtBydn9AQ6p96iD6vSi_akHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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



On 12/16/24 9:13 AM, Alexey Baturo wrote:
> Hi Daniel,
> 
> Indeed this series doesn't include the *Supm* extension, but it's mandatory for RVA23U64.
> As for the *Supm* itself, if I get it right, I don't think it should be always-on, unless the proper profile is selected.
> I think we might need to add extra flags like *ext_supm* and *ext_sspm*. Then, to avoid adding extra checks to the existing code, I think we could enable *Ssnpm* or *Smnpm* or both somewhere during the initialization if *Supm* is set. And do the same for *Sspm*.
>  From what I see right now in the code, there's no mention of RVA23, so maybe we could just add some fields for the missing extensions and support them later, when RVA23 support is implemented.
> Personally, I'd like to do this in a separate patch after these ones are merged.


The thing is that RVA23 depends on Supm. It would be strange to drop the
RVA23 patches (which I already have) and then implement Supm after.

If Supm must be implemented as its own flag, instead of being derived from
the state of other extensions, that's fine. We have existing code to handle
both scenarios. And when RVA23S64 is selected we will enable Supm automatically.
This is how the existing profiles work w.r.t their extensions and dependencies:
selecting a profile will enable a bunch of stuff under the hood.

If you want to do Supm later on after this work is merged, this is also fine.
As soon as you send Supm to the ML I can send the RVA23 patches and make them
dependent on Supm.


Thanks,

Daniel



> 
> What do you think?
> 
> Thanks
> 
> чт, 12 дек. 2024 г. в 12:48, Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>:
> 
> 
> 
>     On 12/5/24 8:23 AM, baturo.alexey@gmail.com <mailto:baturo.alexey@gmail.com> wrote:
>      > From: Alexey Baturo <baturo.alexey@gmail.com <mailto:baturo.alexey@gmail.com>>
>      >
>      > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com <mailto:baturo.alexey@gmail.com>>
>      >
>      > Reviewed-by: Alistair Francis <alistair.francis@wdc.com <mailto:alistair.francis@wdc.com>>
>      > ---
>      >   target/riscv/cpu.c | 6 ++++++
>      >   1 file changed, 6 insertions(+)
>      >
>      > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>      > index 4e80dcd2e6..fd3ea9ce76 100644
>      > --- a/target/riscv/cpu.c
>      > +++ b/target/riscv/cpu.c
>      > @@ -186,11 +186,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      >       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      >       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      >       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      > +    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      > +    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>      >       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      >       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      >       ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      >       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      >       ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>      > +    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> 
>     I just realized that we're not adding "ext_supm":
> 
>     "Supm Pointer masking, with the execution environment providing a means
>     to select PMLEN=0 and PMLEN=7 at minimum."
> 
>     IIUC this is always enabled in the code so this would be a flag that would
>     be always enabled, i.e. it would be a ISA_EXT_DATA_ENTRY that defaults to
>     "has_priv_1_13". "sscounterenw" is an example of this kind of extension.
> 
>     If that's really the case I believe you can add "supm" in this patch or maybe
>     a new patch right after. We need to advertise support for "supm" for RVA23
>     anyway.
> 
> 
>     Thanks,
> 
>     Daniel
> 
> 
>      >       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      >       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      >       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      > @@ -1490,9 +1493,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      >       MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
>      >       MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      >       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>      > +    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>      >
>      >       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      >       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      > +    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
>      > +    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
>      >       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
>      >       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>      >       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
> 


