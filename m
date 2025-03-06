Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7983CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIVl-0000iC-DG; Thu, 06 Mar 2025 16:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIVc-0000gE-5q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:12:01 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIVX-0001uA-UF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:11:59 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c3c9f7b1a6so115885385a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741295509; x=1741900309; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kv67r4qCpZI2QUALaAbbDFRDkZKRfPDWFVOEoemS944=;
 b=LIH7moaU0NXXibMVh2C0gnHh2wFB8TPd43qiKVFm4ojjy8Z6T3QvRSk5NAUjZTXueM
 F0vxlZojjzYaLzB8zpN8hGxEi8SPxUL7wqMWSlzLjlXHBHWka2fDTw4NFNLjEaEb90Sx
 003CyeGCzapFw+T+TeVFOajhTXJfgMEgq6GeWO6JdIQ7nYYi9UtIim7SN7As5BzlmM+/
 UcqqQHb8k3Uf5cqPuqDYC7xinZtsSyBSylsbEDDX6e9ae4X6QD2kcn2jMb11hBEYgxbW
 sp/6UhEMpOclDYPTiXIfrbrxzM6QcDfyDEQSVYd951chxQ8az71UKFapBGmRGQTRGlFd
 5W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741295509; x=1741900309;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kv67r4qCpZI2QUALaAbbDFRDkZKRfPDWFVOEoemS944=;
 b=ClX/TqbeydT1gDBayZ3j4Tub5NdFq5n6nfwM//5Bcu4EXBPZlxWLu4hqrRY5xeqNY3
 vivBpBsgvfux7xQK8EQwoY/322m+l4uiH9FgPcO5D83BZ3gkVO+/IZOAnAh7bUMrR0sG
 l2rTwqWYHKW8Pe36sKUU6qhVIn8J9SE3Y3Ah/tFjIKQiKJYYlr/RPctMMx+1lv31W3a2
 a4M6x7mifsUKVCksGkuVnLJXmcYjemqrWnYVjGpLv3PJMSfPVj5xWTkRQuLXlVHygBGn
 b41A0mKMF9oYtKMfgfwOvSAU0KfyavIBelp+FUTX9SjpxzmFAmIlMDyp/f0+gpX/4Ihb
 fryg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7gAsGsmSgQR2KW6AqwBHhlJ03TJjUfOoQT73gnNA+NNPFlDG/+r/VBqUkGm7TvfsNtRUseysk2VVG@nongnu.org
X-Gm-Message-State: AOJu0YyOQZqwziFO6SklSw7HtDiU7YUGhKKp+I2vKfE2MxBwBdeIjxvm
 sKzGPOTqoSycOKiSzhyaG5VpD1BllbT6VAUt9Xfy0iC/uJEhToKP
X-Gm-Gg: ASbGnctymHYcCmWnUaNZn4dP9eCu6Wg3IXqAIL0G+T3SdW943YA11dbWIWmynro4IEP
 atQx5Hm9PDwH1bWcTU2l8plrvXwQyMKgqIw90IsSxMxvZ8jsvCUPKeKm9KUImMT6g3NVKpSwkeQ
 psyHBnE1/2vsGlCgqbs/QY0yXLbNoSxPjXR6mYLcBhGMdWhHjIJL81EXdhF7qMycUcaMSHqBZGL
 WrIHdGkemufpClHA+JwDZ4YQiMBwmph5Fyrgc3xJIj5gQs0i4mhGGS5/kgYOHssqicqK7+wRH51
 ootu81Z8ZFq0zS14TpdDGveIdSRR5QVSSR3cA1wyhvKL7LgW2DMdb8741YYIn5g=
X-Google-Smtp-Source: AGHT+IH5DxxHZeyNTdKmbLJmZuT8KnrNJExE9IkHw1T1rGom4qlizWTehS2Ns3MaUnZBFB/P2D80kg==
X-Received: by 2002:a05:620a:4389:b0:7b6:d7be:2e4 with SMTP id
 af79cd13be357-7c3e3a3375bmr678531585a.26.1741295509534; 
 Thu, 06 Mar 2025 13:11:49 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e54ffa16sm136676585a.67.2025.03.06.13.11.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:11:49 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 06/38] target/hexagon: Add privilege check,
 use tag_ignore()
Date: Thu, 6 Mar 2025 15:11:47 -0600
Message-ID: <022f01db8edc$600bb190$202314b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgG+Xu//tO0E8ZA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 06/38] target/hexagon: Add privilege check, use
> tag_ignore()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h       |  2 ++
>  target/hexagon/gen_tcg_funcs.py | 32 +++++++++++++++++++-------------
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h index
> ff596e2a94..6582bb4f16 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -37,6 +37,8 @@ enum hex_cause {
>      HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
>      HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
>      HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
> +    HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
> +    HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
>  };
> 
>  #define PACKET_WORDS_MAX         4
> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py index c2ba91ddc0..65bfa046b8 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -21,7 +21,7 @@
>  import re
>  import string
>  import hex_common
> -
> +from textwrap import dedent
> 
>  ##
>  ## Generate the TCG code to call the helper @@ -50,6 +50,18 @@ def
> gen_tcg_func(f, tag, regs, imms):
> 
>      f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
> 
> +    if "A_PRIV" in hex_common.attribdict[tag]:
> +        f.write(dedent("""\
> +#ifdef CONFIG_USER_ONLY
> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_SINSN);
> #else

Indent this?  Are you worried the line will be too long for checkpatch?

> +"""))
> +    if "A_GUEST" in hex_common.attribdict[tag]:
> +        f.write(dedent("""\
> +#ifdef CONFIG_USER_ONLY
> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_GINSN);
> #else

Ditto

> +"""))
>      if hex_common.need_ea(tag):
>          f.write("    TCGv EA G_GNUC_UNUSED = tcg_temp_new();\n")
> 
> @@ -97,6 +109,11 @@ def gen_tcg_func(f, tag, regs, imms):
>          if reg.is_written():
>              reg.log_write(f, tag)
> 
> +    if (
> +        "A_PRIV" in hex_common.attribdict[tag]
> +        or "A_GUEST" in hex_common.attribdict[tag]
> +    ):
> +        f.write("#endif   /* CONFIG_USER_ONLY */\n")
>      f.write("}\n\n")

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


