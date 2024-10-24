Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E780CE8E6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 18:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t42To-00011v-Pr; Thu, 24 Oct 2024 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t42Tn-00011m-QJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 14:22:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t42Tm-0006A1-5O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 14:22:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so688043a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729794155; x=1730398955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFd5ebvDG/RNpGNuI9HDNFOyjX2CUQerktNggMQGNNI=;
 b=ntJvwwcQIjxQ3EFHgQ49g4BlRAjMrwLW8MvDGpsTQu5JABXkVQSA/BOwt5CbofgCac
 WvQaR0N+l4BegMETf94lsW5s+uFfdJ4uaMbbdFedm3d2x37sxnh0aGS7aDzYWMdE3x8e
 QCqoiBarWh3J/R7tI6pFLSPXdInwS+CWlpkHI3sYjZAUIjSHavFFFQwwQW4d+/yHzLJp
 Wphroi3AIb4QNh8fxKlugtMPBPQQk75b1TWlB1GixYGfzG3adk4YrfaWqcRa/6+iP5JN
 F9O9kJS7KLMt3KqldBcGeBt3yydVnXHLje5HbTpY6iTlCjdCDarKEvwX3pW8HO21oeP9
 q+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729794155; x=1730398955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFd5ebvDG/RNpGNuI9HDNFOyjX2CUQerktNggMQGNNI=;
 b=mQ5VOzxv79YjWTBsYOxvI5kfrhLDdc3ZTjPRojEPU6RLfCnZ6tw/xWYP1t/YYaKh8v
 nHr0w3f7E6np3zXw7j/aLjFPv/+SEYrw34v284k8MH++sMAY0+nvvtv+cENO5ophgGiM
 +FAPkCpkDw56FckCUNRafhSxSEZjNwduCqP+SYr4eaTB28L3DDxGjW+vhza29a+E+cIP
 LObZr6nVMwFIr255KJ1l6gwPPSpe/6UeYokIvvqHcazqvYfmJeDz1p4QHr2giHOqpVDQ
 tbe4EFTA1ZP22cDIsbqojUdFd/yOrA8FNwjKoMN7TuJhWTMkhjeVHMPuIC+D/uDLTrDZ
 u1QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYiaYjhZKRH6oS4O0nct8yxOob7BpRGRszk3HE/vA0qWGi31IzDMzDU1C5aqjAk9GJulkNsI1HggS2@nongnu.org
X-Gm-Message-State: AOJu0Yzm616snKDmx7hC+CsVj+G6XBZ6jUxFPiPVuq83kyByTC5G9Zgn
 ZtjC3jUJeMYOzGjr5yXgpQY+Zka1evP3myF3vZYvdnDJm5QqdWI1GXxrejOKbKI=
X-Google-Smtp-Source: AGHT+IGcu6Nvoibi6uYuJ0pWpdr3nGLxku2JqH58IHICZVFyYXpliul4Sh54rOO3IxD3f3gtDYzSDg==
X-Received: by 2002:a05:6a20:751a:b0:1d9:96ed:dc81 with SMTP id
 adf61e73a8af0-1d996edde03mr647748637.26.1729794154844; 
 Thu, 24 Oct 2024 11:22:34 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab48f46sm8961613a12.41.2024.10.24.11.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 11:22:34 -0700 (PDT)
Message-ID: <81879c74-f2e6-4672-85d0-b72bd4d0620e@linaro.org>
Date: Thu, 24 Oct 2024 15:22:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] Add micromips to P5600
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "arikalo@gmail.com" <arikalo@gmail.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <AM9PR09MB4851B248008D8045D466EA0B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB4851B248008D8045D466EA0B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Aleksandar,

On 18/10/24 10:20, Aleksandar Rakic wrote:
> Add micromips to P5600.
> 
> Cherry-picked d7bf2c2f7f2e03b55c6e9c57eec5c3e6207005a0
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Matthew Fortune <matthew.fortune@imgtec.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/cpu-defs.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Please Cc maintainers:

$ ./scripts/get_maintainer.pl -f target/mips/cpu-defs.c.inc
"Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:MIPS TCG CPUs)
Aurelien Jarno <aurelien@aurel32.net> (reviewer:MIPS TCG CPUs)
Jiaxun Yang <jiaxun.yang@flygoat.com> (reviewer:MIPS TCG CPUs)
Aleksandar Rikalo <arikalo@gmail.com> (reviewer:MIPS TCG CPUs)

> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index fbf787d8ce..9428ece220 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -462,7 +462,7 @@ const mips_def_t mips_defs[] =
>           .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>           .SEGBITS = 32,
>           .PABITS = 40,
> -        .insn_flags = CPU_MIPS32R5,
> +        .insn_flags = CPU_MIPS32R5 | ASE_MICROMIPS,

This doesn't make any sense, if the core has microMIPS then bits 14-15
of CP0_Config3 can't be zeroes (meaning "Only MIPS32 is implemented,
microMIPS not implemented").

Besides, looking at "MIPS32® P5600 Multiprocessing System Software
User’s Manual, Revision 01.60" -> 'Table 2.6 Field Descriptions for
Config3 Register', CP0_Config3_ISA is 0b00, described as:

   Indicates the instruction set availability.
   This bit is always 0 to indicate MIPS32.

What are you trying to achieve, which tests are you running?

>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {


