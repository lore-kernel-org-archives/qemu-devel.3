Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A25CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6r7L-0007Ym-3q; Thu, 09 Oct 2025 09:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6r7E-0007Wv-33
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:55:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6r6w-0006IS-JB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:55:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e52279279so6916925e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760018109; x=1760622909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ybct9pJQYEuLIPqCEkL1aRZyibnRP606l8XHiiAj60s=;
 b=y8iCBIdku/LR6VfGFXfsZzik2c4u7vG6YEvpPGc4D3e3j0oQIsCUodlaN+t/Y8NlAW
 0u9eNLMBuFA3799CDHkAAz3IcoEimZ3QBles3/wPmva48prw/QKScfmJgMW83mANGhkU
 GBv8MbOWT3PxaP3T0X371ohb4pOk1wDzTKVIgLv2VtMh9PlrmbbiVKptciPnp9wkTso7
 m3UBx9DfMxu0jCHBzpZG4NtHQUoZUoyS9WNYraxdoklQ0G1X7H6Jx9wG/ynUkorxoL7L
 46IXhSIxagoA1zM/a3nXcBGx3wSZyHWQRr5ymM0tf7ggtLKGoEYqE0FBZ92Tl9XLSaWW
 KyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760018109; x=1760622909;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybct9pJQYEuLIPqCEkL1aRZyibnRP606l8XHiiAj60s=;
 b=L8EAYk006H9Ri0nKA0jjJnuqEnMmuB7Atl/iQNym4CSPTFfX1iBGDftyEpDTAG97qP
 A74Sz3Umf9UXmz8v/sKid1e4e9lUno544a/ic/vWiExTsDYVGWMOWwUqhy9//mox+3me
 IJ7mBQrn9esIig3GIk0BO6tRCR+YOuAqti2XEpQBMgP592abTEkM/WAZVHwVMV06PVAR
 JqFsRVhRISvNuRYNyY3UpgjH6N8HC7ag8Ank4us/XLe+6wKqylsl6PtcYgnuM/ZhAaoD
 bbBycq122UAKFTp6OLyaQFTCvc5gU6bcd4KTlrsq9u6X/OuFa6zJWoBzVr+L0dTbpFkW
 2tzA==
X-Gm-Message-State: AOJu0Yyi/l83n7V4f/b00GvSCE56dhTZyW6xR/h2j0E/13tVHi7kTEDr
 mamXWOod+nOBmXINIjTNoZy/Jlo13+scyesMx9sxzQIrvufB/VXEOfWNGlAgMO+tITc=
X-Gm-Gg: ASbGncv7UspgK3D+DzhCbvJazZwwc/54y/anISAD9YtePk8o6yP/d4rx/U/M8JX8ZNZ
 S6kc7NNUHOPSTHpi5wUmtwlED6bv+E/ixQLFykrOFXMNKKC/oQAjIyhOLEFr6kyVA5W6Zs6UJz1
 SCFpKl73aO8Tk1KXX9Am8zuuwqu5cf0yCr51+pYI8fvh6JpUK77uy+DWwwb/o3NJfZVAbZ3mCGd
 JtLGLEtgELa5+c0FqAYo67nxA4OrY7cx5pJJsNMDOcB2u1DYT6R9M9CpYap3ZYan5yncaGZQj01
 zp2/WA8rE56hpXWzLx9TlKxrJAVvxTtPAeaPbGS/pdUblE6ksaC3VVdHvQCyWWJa/1V3Ko05Qkz
 WD1j1ORaOPr7reFf6e2QFIBQl8I8HtjxonW7raPjgtzZxjX6QoQ91k+hczzLm5aJzRk2iDjy0lm
 S/SvqrnoXWX0U7Kfu/Yw==
X-Google-Smtp-Source: AGHT+IE0aI8itZkEvXiwcAl2OgjsIgbBbCaFS6J+BJd0Ki4Hf4PbQbPrwXzV5vmNJN2kaP/5zrQkBg==
X-Received: by 2002:a05:600c:8719:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46fa9a9efc4mr58998465e9.13.1760018108851; 
 Thu, 09 Oct 2025 06:55:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c07992sm106419715e9.5.2025.10.09.06.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 06:55:08 -0700 (PDT)
Message-ID: <97a43b68-7f68-4f8f-a647-0967b604267d@linaro.org>
Date: Thu, 9 Oct 2025 15:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix layout of struct target_msq_id_ds
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <mvma520fd3i.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <mvma520fd3i.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Andreas,

On 9/10/25 14:56, Andreas Schwab wrote:
> The msg_lspid and msg_lrpid members are of type pid_t, which is a 32-bit
> integer.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0956a7b310..3dcdb3ef42 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4185,8 +4185,8 @@ struct target_msqid_ds
>       abi_ulong __msg_cbytes;
>       abi_ulong msg_qnum;
>       abi_ulong msg_qbytes;
> -    abi_ulong msg_lspid;
> -    abi_ulong msg_lrpid;
> +    unsigned int msg_lspid;
> +    unsigned int msg_lrpid;

Why not use the explicit 'uint32_t' type?

>       abi_ulong __unused4;
>       abi_ulong __unused5;
>   };
> @@ -4206,8 +4206,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
>       host_md->__msg_cbytes = tswapal(target_md->__msg_cbytes);
>       host_md->msg_qnum = tswapal(target_md->msg_qnum);
>       host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
> -    host_md->msg_lspid = tswapal(target_md->msg_lspid);
> -    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
> +    host_md->msg_lspid = tswap32(target_md->msg_lspid);
> +    host_md->msg_lrpid = tswap32(target_md->msg_lrpid);
>       unlock_user_struct(target_md, target_addr, 0);
>       return 0;
>   }
> @@ -4227,8 +4227,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
>       target_md->__msg_cbytes = tswapal(host_md->__msg_cbytes);
>       target_md->msg_qnum = tswapal(host_md->msg_qnum);
>       target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
> -    target_md->msg_lspid = tswapal(host_md->msg_lspid);
> -    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
> +    target_md->msg_lspid = tswap32(host_md->msg_lspid);
> +    target_md->msg_lrpid = tswap32(host_md->msg_lrpid);
>       unlock_user_struct(target_md, target_addr, 1);
>       return 0;
>   }


