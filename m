Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6211DC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbtN-0003Cb-SE; Mon, 27 May 2024 11:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBbtK-0003As-Vd
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:04:03 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBbtJ-00065J-7Y
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:04:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45cso3266804a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716822238; x=1717427038; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YCuHIYfqAavMgHQwiGsJIWdUWH2f+2IjOiWSwxCV8Aw=;
 b=G3qJ8eTC+tAXfg4bjccLcpM6JcI9Fyk+PlFc2IdQ/fzWPrUnhriXhzUt9OTcTyrfwj
 bp8HCzwEj+PefVzR76Kyf8/CkxNU+gKlE579/+zCG4rlxUQ8mShJoFe4sH4zbwtNI+vF
 p71FzrA0T6QsSp6q5bAOtihi3dyqrkNf+9aIuVk4keaCUOKgIY3AE+axNJYVYbXsAe6v
 BXvP556igsFwWkQMeTV609+JLlKVXkutYAbBL7vTrWi2IemsfrM4oAUn99cOhnxMXJ0j
 gTIXSsPsUEEXKxa7amjZK6NMMQ3q4pksB5o4J5CRmrdSItDIPyrKdU/3Otoc2KyrmYgl
 FYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716822238; x=1717427038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCuHIYfqAavMgHQwiGsJIWdUWH2f+2IjOiWSwxCV8Aw=;
 b=AbmbNm2HGfAqqtBUquqEEV0s/9YX5f3tXQECPl23XMI2rrGyyv6EBNDphMyLbWsHiO
 fOCKkCRsmjMDM8rjW8ZwKXN4Qah6EXo+rUpx+jvZRmb9s/xkMicd3aMWFnOT3NeVeFbZ
 k1gN0reBL3YFXMM6o4INtNOjcXiK0K0vI8fQFCdI1J1Wo4sLKLtuZh8fgtSvtVo9Homu
 qhmeIz0es8Jw3izgDWdbxbnf4hwFeR5xJu5CeO6MiLk/Wisc+nlfSXt6zO9DOfEG423a
 IduWJoAs5UCivYDmzKMTo7wpCict67ctF1CHgqpqkIAVhyx71GaucSCFHpKU7HxajWIp
 bNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPJutcwzlzjDe+nr1Tj8pNRiEoDueIGYrK/aaWPrzUBKunBennKsnCBYKElziuGjpt2kIOxdSzfqRmphJ6OGkqoH8hqHk=
X-Gm-Message-State: AOJu0YwLrFH+6z+OwVnYbV0Vqf6S6JBHxfaeOIns1DgnmJ2jRyQcnsdp
 DzB84tooKH3nMgqonNy2FY7brGILBE1QuFyw+pyTsEPMNp8KPaju30IYOFMDBqw=
X-Google-Smtp-Source: AGHT+IETF0PIYzYrnU+nl5n56qB76Pxgp8hIbKqtjQ54CnXW4WpkbPEpeRdY/e12exxGZB1fi+JaHw==
X-Received: by 2002:a50:9b12:0:b0:572:67d9:3400 with SMTP id
 4fb4d7f45d1cf-578519ba232mr6170275a12.39.1716822238307; 
 Mon, 27 May 2024 08:03:58 -0700 (PDT)
Received: from localhost ([176.74.158.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785241214dsm5942760a12.55.2024.05.27.08.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:03:57 -0700 (PDT)
Date: Mon, 27 May 2024 17:03:56 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: alistair.francis@wdc.com, alistair23@gmail.com, 
 apatel@ventanamicro.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v7] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific SBI
Message-ID: <20240527-3510206a25da720148c06a43@orel>
References: <20240503-1417868a079951810dadb71c@orel>
 <20240527134811.342027-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527134811.342027-1-alexei.filippov@syntacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, May 27, 2024 at 04:48:11PM GMT, Alexei Filippov wrote:
> kvm_riscv_handle_sbi() may return not supported return code to not
> trigger qemu abort with vendor-specific sbi.
> 
> Add new error path to provide proper error in case of
> qemu_chr_fe_read_all() may not return sizeof(ch), because exactly zero
> just means we failed to read input, which can happen, so
> telling the SBI caller we failed to read, but telling the caller of this
> function that we successfully emulated the SBI call, is correct. However,
> anything else, other than sizeof(ch), means something unexpected happened,
> so we should return an error.
> 
> Added SBI related return code's defines.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Fixes: 4eb47125 ("target/riscv: Handle KVM_EXIT_RISCV_SBI exit")
> ---
> Changes since v6:
> 		- Add appropriate commit message.
> 		- Fix error handling according to Andrew Jones suggestion.
>  target/riscv/kvm/kvm-cpu.c         | 11 +++++++----
>  target/riscv/sbi_ecall_interface.h | 12 ++++++++++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f9dbc18a76..a84bcda9d9 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1173,16 +1173,19 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>          ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
>          if (ret == sizeof(ch)) {
>              run->riscv_sbi.ret[0] = ch;
> +            ret = 0;

ret is already zero here, so this assignment isn't necessary.

>          } else {
> -            run->riscv_sbi.ret[0] = -1;
> +            if (ret == 0) {
> +                run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
> +            }
> +            ret = -1;
>          }
> -        ret = 0;
>          break;

v6 was closer to being correct than this. It should be

@@ -1515,21 +1516,24 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
         ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
         if (ret == sizeof(ch)) {
             run->riscv_sbi.ret[0] = ch;
-        } else {
+        } else if (ret == 0) {
             run->riscv_sbi.ret[0] = -1;
+        } else {
+            ret = -1;
         }
-        ret = 0;
         break;


>      default:
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> +                      "%s: Unhandled SBI exit with extension-id %lu\n",
>                        __func__, run->riscv_sbi.extension_id);
> -        ret = -1;
> +        run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
>          break;
>      }
>      return ret;
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> index 43899d08f6..a2e21d9b8c 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -69,4 +69,16 @@
>  #define SBI_EXT_VENDOR_END              0x09FFFFFF
>  /* clang-format on */
>  
> +/* SBI return error codes */
> +#define SBI_SUCCESS                  0
> +#define SBI_ERR_FAILURE             -1
> +#define SBI_ERR_NOT_SUPPORTED       -2
> +#define SBI_ERR_INVALID_PARAM       -3
> +#define SBI_ERR_DENIED              -4
> +#define SBI_ERR_INVALID_ADDRESS     -5
> +#define SBI_ERR_ALREADY_AVAILABLE   -6
> +#define SBI_ERR_ALREADY_STARTED     -7
> +#define SBI_ERR_ALREADY_STOPPED     -8
> +#define SBI_ERR_NO_SHMEM            -9
> +
>  #endif
> -- 
> 2.34.1
>

Thanks,
drew

