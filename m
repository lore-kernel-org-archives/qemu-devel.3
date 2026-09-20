Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D2C982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Q67-0002UO-7h; Sun, 20 Sep 2026 18:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Q61-0002U4-Nz
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:33:17 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Q5u-0006G0-Go
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:33:15 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db22383fe8so14554345ad.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789943586; x=1790548386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RwRDhWqnh663GSA5FiiDAEqm+JEW+GaOOIhiFuKAS6E=;
 b=Xfj8E3LAYbaIVTQr2Wd2xYJI80cltvBychDsMYR4L1HnunXUrXgxAggZGo6up5/gZn
 xoBpjZRR4LoqbGCKiKebjdcZaPPYI8dg0NW0DEDkDepea3FjeYjIetazc2ZLPWNh1QVB
 IK1zfnHM1CguSTHkoUKPBbUv4v6sUtVDrZVKB1rVLNX3ZXt4sCHzIzZDNEnQlBz36v2z
 NX03X4W/Zy+bgpdJpb+3iw+7pN96lsQ8VSdXPVjBqrBgIZKCAakqXpOTTHq1wndeFvRV
 KwBmIUus6xtk+TqZ3fx1Do9lDD9fE/tOgt3rUJ634z9YAzHB+z6osWwuHSHrI0q3PHQ3
 45Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789943586; x=1790548386;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RwRDhWqnh663GSA5FiiDAEqm+JEW+GaOOIhiFuKAS6E=;
 b=jnN89iDcLYb+9DcELd812S9eBVOQAjg7Qx6Q5NkruFKJW/XjzSXmrj6zxlrD+RL2sL
 1fq0m/keD2ZrlbRrCqXzCh8l9cTBmc3H+iPW0KDcbLAN12Sq9RknQc4vj5xdLW2rgS3H
 /Dfxa/IxtI+f0JnoicN68JH3sA3sQEnU/X5Rd0Y7x6HSdvlt6YMj4ScxZvDHd9+tRaM0
 b7va3iL3CCU+TtvJhmbZQpU0Zd/MBBYO7XRJDXrAdVzbs7+qzWnsYmcaOEFkm0T5GizW
 GVY6T2+GaRAf6ZBnkzp5wrui8xOIxtCMefckpBOAQmC8ktpGZrQxk1NotlUvPhlo46gC
 PN+w==
X-Forwarded-Encrypted: i=1;
 AKwUvByQfxX8AoAbsJczonV+NOrZMPmH+CiGoL/nadl/IzpQseC1xPH9/XNG+vHaP1FwMmb6k3wXheCywfuB@nongnu.org
X-Gm-Message-State: AFuF++kD+gCkNluRsWwZy9Vhg1C8Jvo3Q21VUtcxQypEhOk1478Nb3mN
 qPiMo66hfvOfECesb/Cv3xIvaUHH2dAZHJSEBu24n9QoL4J7ZpIW9A9AZTrggVMjnQc=
X-Gm-Gg: AYBFou2BV0HeJeBSKiwd0vqNRICAghR4OL7RQTkUf0r/MO9N9iRQYbLhwIg0O5Kbpb/
 NevRAUGUvB5ZtHgh0KtyhmzRaEcDUhv8k8KmRCeZ835R86EJReuhZGSYQDpkngjv/uFlNWxS0bX
 wbFpfKjcNXofQm9bL1PTQcxvObi4GY7F2smEfhFamdCOYAfMpr9hmWB3WJM8ANW9P8GyR4KBmel
 bGZl2HUrLuEfxeKCiQ3YJj+iUywtkBDF0z8DzqH9sznsoTElU6cyd0ncjXkStLg+XQi1h6+6Uex
 +iPMpbaiMHOHwbumnHQQ/078OOcPiF7TUTgP+5xb6+X7wuxeerQZKI8Xl1pwfJYMLFdwK8Cn2ic
 I6uzlelqJww+nthYF7YPXsILUcLRF6tLgB5ySkAdlytbWAAiOAdauYsmCriEk7m/bCGPvLqA2s3
 Cw9kXGCiEuaN7H9CrNPudzx45ZiI2J3MjHkLXr1VODAE7zydDRykjn2Fe2wrNCvM9Iv2rqRL18P
 EkOKPOpiOe1a5T88erwUk5/QQTh7epCzrgWKjymce4FYGHNlBENS+dHVWv5
X-Received: by 2002:a17:902:d2cc:b0:2dd:ad73:c982 with SMTP id
 d9443c01a7336-2ddb1ba0faamr135446235ad.26.1789943586415; 
 Sun, 20 Sep 2026 15:33:06 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:e836:65a9:3e76:872e?
 ([2603:800c:7900:ed00:e836:65a9:3e76:872e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3318763bsm13176287eec.19.2026.09.20.15.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:33:05 -0700 (PDT)
Message-ID: <8b9b62d0-2cc7-4438-ad60-4cfbb4088bc8@linaro.org>
Date: Sun, 20 Sep 2026 12:33:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] bsd-user: Fix non-PIE binaries
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Maksym Sobolyev <sobomax@sippysoft.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-13-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-13-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 295dad4643..eaa8676f5a 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -561,12 +561,14 @@ load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
>               elf_prot |= PROT_EXEC;
>           }
>   
> +        int flags = MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
> +        if (rbase == 0) {
> +            flags |= MAP_EXCL;
> +        }
>           error = target_mmap(TARGET_ELF_PAGESTART(rbase + elf_ppnt->p_vaddr),
>                               (elf_ppnt->p_filesz +
>                                TARGET_ELF_PAGEOFFSET(elf_ppnt->p_vaddr)),
> -                            elf_prot,
> -                            (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
> -                            fd,
> +                            elf_prot, flags, fd,
This is wrong, or at least very not ideal.

What's missing no the freebsd side is a probe for the entire address 
space for the guest program.

>     /*
>      * Reserve address space for all of this.
>      *
>      * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we get
>      * exactly the address range that is required.  Without reserved_va,
>      * the guest address space is not isolated.  We have attempted to avoid
>      * conflict with the host program itself via probe_guest_base, but using
>      * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
>      *
>      * Otherwise this is ET_DYN, and we are searching for a location
>      * that can hold the memory space required.  If the image is
>      * pre-linked, LOAD_ADDR will be non-zero, and the kernel should
>      * honor that address if it happens to be free.
>      *
>      * In both cases, we will overwrite pages in this range with mappings
>      * from the executable.
>      */
>     reserve_size = range.hi - range.lo + 1;
>     align_size = reserve_size;
> 
>     if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
>         align_size += align - 1;
>     }
> 
>     load_addr = target_mmap(load_addr, align_size, PROT_NONE,
>                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>                             (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
>                             -1, 0);

which handles ET_DYN properly, which is missing from the freebsd side 
entirely.  Afterward, elf sections are mapped onto this reserved range.

I'll note that FreeBSD should be able to do better than Linux wrt the 
alignment handling here, since you have MAP_ALIGNED().  So long as 
guest_base is suitably aligned, anyway.


r~

r~

