Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA32C982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8PjN-0007EX-DN; Sun, 20 Sep 2026 18:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PjL-0007EF-He
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:09:51 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8PjJ-0002VK-Tn
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:09:51 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc515bef69dso1519761a12.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789942188; x=1790546988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=byIHC8VIw8D4F+l0gvKZRLM+i4Nv8AD3ptfnOWOvZsk=;
 b=HmpTHoLB6fzi918wuZuZbqBB2j11xnxGspziT72Cs0S09GjInap7waAYITwTMjDadY
 HSBSl+zPl9bGzvX2bNo7fmotlLIn3zgeI5tzJhLqe6ZBS0UVwqXLXbOfHqwZ52xKZfxq
 gcSNy3s223ojVFe3K+qNO/oSqrHIZAlQdRneXE4l1sNQqzSA/JvoUSlPungBKT56isxf
 RCpXO8AqRw1jpBngbxlAyzBkd3D/JBIim7tNtthsQzPs0dZvrGzuoqKKFDxSbZUw80u9
 PgUJPzS0PfHReaPSvjhCH7mRtq7a26DpmoLYHf3dE6ESfdUDrAkc5E5CIGNbFLCHjy3F
 iXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789942188; x=1790546988;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=byIHC8VIw8D4F+l0gvKZRLM+i4Nv8AD3ptfnOWOvZsk=;
 b=EG9TznFP68UIZlGvXLIkANxAWXAdm7zUVZ7Sqhd7pQFWEHKVBEfs1ZqeIwvGCIs/vi
 nxXCGnu/cOlTzTQdhRHngsBnEWim2gUeZiPyStj0STUJLiE0Y07AiFmVrWUl9NHgN6jz
 dhfZbogOJbKJ8IhN3Gngnjb0TrKyXV8DH0uC2q0DFN+w4LpYOpqChCFPFt3S/3VjgJZ8
 4PVtobxyagxPvcFzmOrhmsR9LXEluSkVPDGLXCbnjS3cvG9oXkqONfzu47LPtapsnFcV
 mDSJQhx6I1HvtLPkb73xxNYDghDXDT17Ak+eV8ib9zY3Q5YioAKiQVaAPLR4L/mZvTBa
 oUrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXJy3yK6CBPtA2ZRuS1b6qoWB2I2gyRVAyYb9tXFRWH1/340vagbYJ7EIlTBKLzU5cZTNFhD9eIpHv@nongnu.org
X-Gm-Message-State: AFuF++l9iUlyiynxN67PP1eywVVgDxDB/KNnOZ/n7ayyHnY9kXZ3Kk4x
 37akepy40cdSG61A0E0rLCdICY77VjBmB/E76jk7jDlkItg/8TlRh4vMu3ZEF5xU4Qw=
X-Gm-Gg: AYBFou3e3ItKVSSwsYIzaIefjwAEU86Xz6OFGzOtmagrTD96g941u9IUi8GGBR4HjPE
 BZXmls0UAcgyREDK4VT8wcGsH33CiJTVI2U3JozsKwtK+27mxqVKiG5rdlVIzi/o8wSFJt+/Hlu
 xD+YBP9CLpSI/VQ8MwilNSwclPcm0d9Qbc6Z6NUCVd91615hiskSs9mQ4Kj+K51grBUh/v/neGa
 Vj0jw5xACC9prsEqPE5jQOohcXHq5ucN3lZZ0ivu6s/9AzYvDYPemiREOzL9B+gsM3QEfUePKaX
 Ruu2UMJk95i1zVFt1/4i/MFl27FnzWo4oJVHnPwttQ3Q/b3iiuWt3dtjZQfsK4Dgsk6NtUNqC4/
 pdah3glinyphIt8xkJpTQpCf/jw0+JdQ2Y/2Pr339kNbd/w+iISKGs5K0dVvBjW89vkeRjDxVct
 R6SNhmobA6Y8qRBSnpgPpSLLcriySxsL4soQtAmjElYV3apFvnXDpo8DdGLWyaSuMfca8Xp7WWG
 mCUrPAlXzelDIecJ5DDOjBcYiQWjEA4z6NVf2y5FKBfEbXq865SBmDc2IpS1TrD59SGkyI=
X-Received: by 2002:a17:90b:3a8e:b0:39e:14db:437b with SMTP id
 98e67ed59e1d1-39e54afe89fmr13531218a91.7.1789942188054; 
 Sun, 20 Sep 2026 15:09:48 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c33186490sm12281331eec.18.2026.09.20.15.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:09:47 -0700 (PDT)
Message-ID: <0b7b6ab1-5d55-42fe-8591-f67f8143c7ac@linaro.org>
Date: Sun, 20 Sep 2026 12:09:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] bsd-user: Fix crazy bug with mmap
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-6-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-6-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/26 19:20, Warner Losh wrote:
> +++ b/bsd-user/mmap.c
> @@ -215,10 +215,13 @@ static int mmap_frag(abi_ulong real_start,
>   
>       prot_new = prot | prot1;
>       if (fd != -1) {
> -        /* msync() won't work here, so we return an error if write is
> -           possible while it is a shared mapping */
> -        if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
> -            (prot & PROT_WRITE))
> +        /*
> +         * msync() won't work here, so we return an error if write is
> +         * possible while it is a shared mapping
> +         */
> +        if (!(flags & MAP_ANON)
> +            && (flags & MAP_TYPE) == MAP_SHARED
> +            && (prot & PROT_WRITE))
>               return -1;
>   
>           /* adjust protection to be able to read */

Need braces, even if they were missing beforehand.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

