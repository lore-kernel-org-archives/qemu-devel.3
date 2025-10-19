Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A0ECCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 10:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAQEP-0002Qs-KD; Sun, 19 Oct 2025 06:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vAQEM-0002QO-1h
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 06:01:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vAQEK-0004BK-9f
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 06:01:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b5526b7c54eso2227877a12.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760868093; x=1761472893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HyjU7/9cHhxNTXSkm9cndu2yQ2Y1BQpOutCcsIwj1+o=;
 b=R/zhqb54iDwcrONxcuGteAMXt5nNtHvMjAGqX5PCnr7++ijyt2DN59FhgiloXBsrpy
 iVSX0UDVMrXptBgjz6ffMI8/VqHjlLBSdGPiHKZznOMP+LDbSOZMm84FnSSDjaoqCjFS
 MkIEGMw85xkxygWtEIecLOOYEINlu6jKNcQgwQ2+sj98tlmSRLDaN6fNB6UwpKV5GsK9
 F+qdT8TllPL/q3WZTXT98MjYQIsS6X7QVNkw2oZnus2h1t49K/JFpp6tMJy0O46F5SM5
 2vukHI7hBpaf4gwQ+ccvQ36W6MXVEg7AstSCBIUDXfkzum5PXfNACiFouN/6aR22n7dy
 4blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760868093; x=1761472893;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HyjU7/9cHhxNTXSkm9cndu2yQ2Y1BQpOutCcsIwj1+o=;
 b=eqCvazHh5LHAV19uA4w1i2DlXiC8z89WuedRUsqiMKNGjOJ0cwwCuLqsEC+q7O9c4c
 vklXERTTXo8tRVgGnPcpb4w3xWifxTHpLLnDHL6G3HoHF37NoUMW/VuClgkzlt21EBzb
 J1p6DYzap3TfQBLIiGpZTS6BhDx6UuhGFSQ7Oy5iuC8K0iqjc6TcQmwkFK37bIzahQcs
 wrxGLYKzaUaZp71WJdHsBa/1dY6WY3OafT1zMQJ0AVMy2Po9NEqIHYUTv6pHu1XkuHjt
 mVgK72G7ansXPaNOM1SeA3NnuCNzQevxkYeXRw7aqk1FfjkqavtcohlbzYJNPcDy2MYF
 fY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ZpPztLSDjwIBX+n4u/e2/rG6GGOznhUVscM0u1wvL757B+FqnBuBHVGQp5W56Tpyr4a8ikgroUJ6@nongnu.org
X-Gm-Message-State: AOJu0Yy6gaXjT1YrfWsE9fpZBimidsjXj96bpFdtMRqvsAKJRT3kwau4
 74WYZ0MuaCpYpKx5ykQgp3vBhBfrV1Q/U+IGvp0D2HK4eQAhWiey1J4qNMihnrxA3Xw=
X-Gm-Gg: ASbGncuBfU5ugEJbI1CkNBKEr7s5wuCSQv/nTvvwtPVHP816pJQwX2BfOGf170XxQ2n
 RdFKbFtoBa2MGvVXbm8sRmx8lXWubrDYyhn7x6s6JPP6wYA7esK+Imm3e8JC/4pe3MAU4tFdI1t
 bpBEbFOhB//8mDIbKeHaqdSWdMkcy1cekgUjw50CpMmnNpuDJTQmXIhPVhMqeRuNLQHxUyy2Y3T
 I2O+G12HjwZdwwzBSOxbZ+sRehWFA6qVUusid4XvMdCC1EVfUcKgeP5RbFHRka4nt56yW1D0QXa
 Z4JXk8mxhtRcJ8L44yaunUw49teJ6AmjBHNCemocpy69thZKt6KvZojH5KbmhkbORqmMhvOTBHv
 u6By5iEYZNn+j/JYDVWfVIbjAk575n8GWMaMCuSv/Sq0dDxQ0H5OLcgcRWWZOJkNqfFIZU5/xcG
 VBg5hWYzYLbun6M50=
X-Google-Smtp-Source: AGHT+IFoT3oKvPWPF9ubm9p0zYN6K3Pv5NEFGnqIzrpEhrOo5uZueFH3CoXmA/BDSnFyD618t4Yr0g==
X-Received: by 2002:a17:902:f642:b0:269:9a8f:a4ab with SMTP id
 d9443c01a7336-290cb94ca6fmr108251425ad.60.1760868093523; 
 Sun, 19 Oct 2025 03:01:33 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5c0bsm48360615ad.69.2025.10.19.03.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 03:01:32 -0700 (PDT)
Message-ID: <b3cbe49d-e863-456d-a254-b7514e3bb33a@ventanamicro.com>
Date: Sun, 19 Oct 2025 07:01:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix a uninitialized variable warning
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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



On 10/19/25 5:19 AM, Akihiko Odaki wrote:
> riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
> no vector extension is available, causing a compiler warning. Avoid
> the warning by calling g_assert_not_reached() in the case.

For the compiler point of view the variable will be left uninitialized.
In reality we'll always set it to at least '32' in validate_v(). This
is how the function is being called:

     if (cpu->cfg.ext_zve32x) {
         riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
     }

This means that inside the function we guarantee that min_vlen will be
at least set to 32 because cfg->ext_zve32x will always be true:

     if (riscv_has_ext(env, RVV)) {
         min_vlen = 128;
     } else if (cfg->ext_zve64x) {
         min_vlen = 64;
     } else if (cfg->ext_zve32x) {
         min_vlen = 32;
     }


To make the compiler happy and the code a bit clearer I suggest initializing
min_vlen = 32 and folding the "if (cpu->cfg.ext_zve32x)" check inside
validate_v() for an early exit. Something like this:


@@ -417,15 +417,19 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
  static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                   Error **errp)
  {
-    uint32_t min_vlen;
-    uint32_t vlen = cfg->vlenb << 3;
+    uint32_t min_vlen, vlen;
+
+    if (cfg->ext_zve32x) {
+        return;
+    }
+
+    min_vlen = 32;
+    vlen = cfg->vlenb << 3;
  
      if (riscv_has_ext(env, RVV)) {
          min_vlen = 128;
      } else if (cfg->ext_zve64x) {
          min_vlen = 64;
-    } else if (cfg->ext_zve32x) {
-        min_vlen = 32;
      }
  
      if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
@@ -676,12 +680,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
          return;
      }
  
-    if (cpu->cfg.ext_zve32x) {
-        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
+    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
      }


Note: I wonder why we're allowing settings of VLEN and so on when we do
not have RVV set. Seems like a bug ...


Thanks,

Daniel




> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   target/riscv/tcg/tcg-cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1150bd14697c..acbfac5d9e2c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -426,6 +426,8 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>           min_vlen = 64;
>       } else if (cfg->ext_zve32x) {
>           min_vlen = 32;
> +    } else {
> +        g_assert_not_reached();
>       }
>   
>       if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
> 
> ---
> base-commit: c85ba2d7a4056595166689890285105579db446a
> change-id: 20251019-vlen-30a57c03bd93
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 


