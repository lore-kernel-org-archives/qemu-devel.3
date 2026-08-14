Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3827C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wurkH-0000r1-Cu; Fri, 14 Aug 2026 09:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wurkF-0000qQ-LX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:14:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wurkD-0001qb-Tw
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:14:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1204479b3a.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786713284; x=1787318084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KiJrrFmkL3w89WslWTqOoKAyRosvdq0KSC6jmp6i7yg=;
 b=SRGwD3a4b/v0ipyLrOD1KeoCuxbm/aaJsBOM10Sj2ULqfGxeTxPQtCZ4jTyIL2OwJY
 Lk5bB2WfazQR6famvOYdyozv65pqYCK90M1ykZ9NfWUPlNNGDEzTz5LPSmBuIRTRZ7eB
 SVaCeLQGG/fh6TRHLMs/dMYZwgRpynp0fVHckBNfkOSRnPWRoOtV7BrKx19hq60i5r3V
 REUpJd//g2PXgCDm5s/Jsaa87BQBVOT0u8RPgpxZ1aLZ9iRugTM9fggVxB97zZcbimUa
 NPDCzK13/DTxl3zPtaHu48xgFW8uqtwNRnDaFyAMLk9hfdyp5NpyDgqfJ3V0ouqad1Ef
 Gvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786713284; x=1787318084;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KiJrrFmkL3w89WslWTqOoKAyRosvdq0KSC6jmp6i7yg=;
 b=EHFz1qDX9X8ByROJzKqMt4IGVm9Ag6V/ShktiqE2PKwDy9bbWOiYatLztW1LRKY28H
 XGTh96rnbfuJdUt9jR6chryy6WyYSCLr/keCvdd17CYwjzsSY7Ypvef/+v0w23N0ZdxL
 /QExu4huycCTKGASFlb234UdMMjH9F4OcdoZHqfa140eSGqp8zXWdEWDa2tsr7SQqnL5
 rJRmuQ5dGq/AvqwLDLeZHBnE+JW7LG8hmYQm9To5l0KO7tPudAM8kuSuYhgT32SaVm/A
 772apgSAcSbcBDP0QDRdXEPhzshOIVNSK2xB1d7aH6WrCS8CBb3U3BABNkduKsPD+Vgj
 XM+A==
X-Gm-Message-State: AOJu0YzAa96tnchfygzMDyykjxfhsbA2mk++dnJS4QMXqP6030mWiA8j
 rYniv1CuJthkI/jdRjL2tnl7NH64uBivHcmS6WBto7UAymisslmf8ug1
X-Gm-Gg: AR+sD13wm6digF83gfAAsstoWQ1pJ3uKM/WXJG17j4ltDsg2X0rOfIQZmq7xo2BTbUL
 kHqqGcbnYyC7ZtxiEqtXQQthwhw5wa+d0gAN2zCKDqIQYB6ND76GaKrqEKlx78kBs6u8XRaJjf2
 Jnfu8V0A6N68pP5YFQsI3hcA0LmrEjoqhTv+bj1OVJc/jd127eUgdA+xMngFc4zDIR7zkRtmCHU
 hb+cZOA32TMhtnAEppdrtfKQnMGVoSes74w4qeVzYvgHJD1VQ8Uto8BSfjLYcJgM44t7rUEP/yQ
 dhQBYroe+O19YQYvmI7LqGqV5jC5DhtvoC9pPsjESlzPp8hhqSu1TQpvmqaOOrR/G4j61CTjaEK
 r4kYaUzcEWc1YtTuPkXkj0G1cjvkhINe1YYVXtu/nZqxLmdTjSL9x9oC799c0SR4wTZ+iwLzcTl
 1VFLps3Jv/7hr3BSSL933lfivYdNBfOLUkxAF3hXrnNp8eipLfR8n5yh1gHmk=
X-Received: by 2002:a05:6a00:1a87:b0:848:44ae:47c4 with SMTP id
 d2e1a72fcca58-84fde20e8a4mr5445646b3a.20.1786713284228; 
 Fri, 14 Aug 2026 06:14:44 -0700 (PDT)
Received: from [192.168.1.35] ([112.133.246.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc08f3aba73sm591336a12.14.2026.08.14.06.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:14:43 -0700 (PDT)
Message-ID: <8163c2b0-0994-4cee-bf6f-9384f1e9e155@gmail.com>
Date: Fri, 14 Aug 2026 18:44:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: prevent abrupt abortion on unassigned value
 write to tdata
To: qemu-riscv@nongnu.org
References: <20260729230028.1797355-1-314abh@gmail.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, chao.liu@processmission.com,
 zhiwei_liu@linux.alibaba.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, alistair.francis@wdc.com, palmer@dabbelt.com
From: abh <314abh@gmail.com>
Autocrypt: addr=314abh@gmail.com; keydata=
 xjMEaaCh3xYJKwYBBAHaRw8BAQdAVM1RsDD2FeoNQaZK2QC/kzkYIIfu2q/KFJAYfDCpNIjN
 FmFiaCA8MzE0YWJoQGdtYWlsLmNvbT7ClgQTFgoAPhYhBG9m91dTkOrKD5lID3UzAekWp6jS
 BQJpoKHfAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHUzAekWp6jSz6sB
 AIyMERKwB5XgphDIZtbjD9g2FiJpQZqqPDhTeQOEZ/AaAP9YDNmDmxEYizl29eYioMxhA+37
 xFTSw6WSY07BomlyDM44BGmgod8SCisGAQQBl1UBBQEBB0AzQxaqj7K6RZqXl4xOIleDubFp
 TQsXvEMWiRnJobgjMwMBCAfCfgQYFgoAJhYhBG9m91dTkOrKD5lID3UzAekWp6jSBQJpoKHf
 AhsMBQkFo5qAAAoJEHUzAekWp6jSrWoBAMgbTZK/HqjOv6Vqwl4uy02pZkeymtrbjARfNUJF
 K/7DAQCooyWGaQ6m0RM3RC+fjSCVa8qyuppeq2wSa84UBhmXDg==
Organization: The Public Safety Devil Hunters
In-Reply-To: <20260729230028.1797355-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/30/26 4:30 AM, Abhigyan Kumar wrote:
> tdata_csr_write is approachable by guest programs. In case of unassigned
> values written to a tdata CSR in debug mode, the switch-case falls
> through straight to default causing an immediate abort. The risc-v spec
> says:
> 
>      All tdata registers follow write-any-read-legal semantics. If a debugger
>      writes an unsupported configuration, the register will read back a value
>      that is supported (which may simply be a disabled trigger). This means
>      that a debugger must always read back values it writes to tdata
>      registers, unless it already knows what is supported.
> 
> This fix correctly ensures that the WARL behaviour of tdata CSRs.
> 
> Fixes: a42bd001 ("target/riscv: debug: Determine the trigger type from
> tdata1.type")
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---
>   target/riscv/tcg/debug.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 3c0fe7010..ae493235d 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -913,7 +913,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>                         trigger_type);
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d is unassigned\n",
> +                trigger_type);
>       }
>   }
>   

Greetings. It has been over two weeks since I submitted this patch. It's 
my humble request to know the status of the review/acceptance for my 
patch. Please inform me about any required amends.

Thank you for your patience and attention.

