Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF431C54746
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj6MD-0000MJ-Fn; Tue, 27 Aug 2024 20:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj6M6-0000Ka-Q7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 20:16:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj6M4-0007Gr-FU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 20:16:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20227ba378eso55508775ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724804166; x=1725408966;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SbKurov/bfQdlfwss06QhJgoXFG6l9nTsHf44bvMfmY=;
 b=Q03nYiRKanfjLmtZT3Pk+Y9dzn2kh8bpDeCA91UZTTYUskdA/T6wfb5m6IV84XrQnn
 vW/sVDNe44HIWxEltX7gpNq6p3IRLlBYgGGu3SiBaBvgbcto3Zm1OJ/R2GX1uoMjonvc
 IvupyIG0L6bVHlPBli3Kw8+C6F8VNwI2b7DSax9V+uVYCaZXEUCubAeFRdpa0rb6FtHS
 VbBYvhMszSiGBqSmdZaLzlUoGmchS3eUcK7rzjv2IUhRlUW5gT2Yq+uiLG+d6PLEpiby
 gsQ6Nxy7hg4nEcoPpt2OqqAFp0+Z5t/BC+DinQJhyRPqOGwHRf43ddKf2KSUEfpKxpD1
 jZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724804166; x=1725408966;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SbKurov/bfQdlfwss06QhJgoXFG6l9nTsHf44bvMfmY=;
 b=f/+U8M0HlhjivABwg1EyAt0IYuoDyzNBqLj/HvuJwIbLVOjOHlKaqj9b3dVie4/6Lp
 E4XIOQDS2WWxKTPBHqyEcYo+1aaaYftl+xqI4jtPIxwrp+PwQ6KUt6wulIEtKqCdTFpe
 3oUCefop3qrEyaIuAQsdDcUoTsyRn0op6T5yaFylR63Wk62Cl/ti3lzvwitt18kY/uoJ
 dmVhlOXeSosss3XDO0NHTSJXFZwFCogI2h870wx9zrgPgsbLdVItFV0XuCez1eIgYqXO
 Euf6yALzgybNu0H/glK/hriCsy/JszWtJUAOLCEasxYdS4qMP80vYStXyrFKNZlvGJvy
 DDRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBJCJIDjuAJnVKROUU3DrOqkeLHOCkX07HtnzxtQx+Xhjyqol3GbEKfkD38uSkb+VlATv/+IFHvEFA@nongnu.org
X-Gm-Message-State: AOJu0YzBXuygaAOYf8pQE798Ke//IfKRPDL3kDz8dA9G+8no3ytpb5c9
 Hcce2dEFnx0UU4EcbO/WdfrhyEWYQouPl6pSZ4q7rmcXfUYDDFkx9JpyYdypJH0=
X-Google-Smtp-Source: AGHT+IEJAycTpXc+XgVBrKng8Rv5Ugz7za452POvaOc5Y0UB9Y2MREB+ROHBnbeMDoDrYyXlkkepVQ==
X-Received: by 2002:a17:903:32d2:b0:202:20bf:461c with SMTP id
 d9443c01a7336-2039e4a96demr186707435ad.31.1724804166052; 
 Tue, 27 Aug 2024 17:16:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855df793sm88798285ad.155.2024.08.27.17.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 17:16:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:16:03 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v10 02/21] linux-user/riscv: set priv for qemu-user and
 defaults for *envcfg
Message-ID: <Zs5sQ1FYN1JwfolP@debug.ba.rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-3-debug@rivosinc.com>
 <CAKmqyKO2gaVNsSCuvSjTSOjKBOEBJOQC91BK0VDRscJbM-hx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO2gaVNsSCuvSjTSOjKBOEBJOQC91BK0VDRscJbM-hx7A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
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

On Wed, Aug 28, 2024 at 10:10:44AM +1000, Alistair Francis wrote:
>On Wed, Aug 28, 2024 at 9:20 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> set priv to be PRV_U for qemu-user on riscv. And set default value for
>> *envcfg CSR.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
>You can probably just squash this with the previous patch
>

It's just that they are in different directories. One is target/riscv and another
linux-user/riscv. That's why I kept them separate.

>> ---
>>  linux-user/riscv/cpu_loop.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
>> index 52c49c2e42..7a68e8717b 100644
>> --- a/linux-user/riscv/cpu_loop.c
>> +++ b/linux-user/riscv/cpu_loop.c
>> @@ -32,6 +32,10 @@ void cpu_loop(CPURISCVState *env)
>>      int trapnr;
>>      target_ulong ret;
>>
>> +    env->priv = PRV_U;
>> +    env->senvcfg = 0;
>> +    env->menvcfg = 0;
>
>I don't think this is the right place.
>
>This should be handled by a CPU reset, which is still called for linux
>user mode.

It is the right place for setting priv to PRV_U?
or you want me to place it elsewhere ?


Sure
for reset values of *envcfg, I can rely on `riscv_cpu_reset_hold`

>
>Alistair
>
>> +
>>      for (;;) {
>>          cpu_exec_start(cs);
>>          trapnr = cpu_exec(cs);
>> --
>> 2.44.0
>>
>>

