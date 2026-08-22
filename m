Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF11DC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 14:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxmdk-0001LC-2H; Sat, 22 Aug 2026 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxmdi-0001Kx-1t
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 10:24:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxmdg-00033H-EI
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 10:24:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so1943242a91.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787408641; x=1788013441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lby8ULLeHf/yp8wMKVCD0jxyp1p5T6iyFoKFRkDDI68=;
 b=FZ1T4VbJqJMmC09TASwrMHh9yDm6o01ilGdkRzjXIWhXc97CXtZ9pFgzDLYHeTg/S6
 ZewwYuk82VfM6Sm0N7j29A65fyaWSitE68jZDYuOynl39T79IbqmcMNrzUNSr4YHUbe1
 GqeJT44HMd5OJKbv42LHI+xmd0iH31ky4JtJWBC/KNVlTcn3MdlE7z9hllX0pnwZQloX
 J6RZRBYYrBO8K0KCLThQIZTPE0DGoT4f1n49OoDmUDvCTnRHeH1MzQxufbRiZoOIwmVa
 u/9hwCpfGadBgioKZxI8QscZ1j59U3RN4oG+J/+22bV0vh0vfo3ILz0wFHNPbrsRMqYW
 nbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787408641; x=1788013441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lby8ULLeHf/yp8wMKVCD0jxyp1p5T6iyFoKFRkDDI68=;
 b=NyBEhOtqo88BvDjQZyiQX3PDzZanQ0nZ16FmnPRF+TYfLD7HKHlYRpoAd348z8l1gF
 vkaOLVYM4NNQk8Ix85Jopfyc2+IB4K7L1sRtoJJrUeOl35KwVfcyyCid9riNYkMD3EVk
 p/k7SzIiCvvFEbH3YuelU7CukLwy0f859H8ocYb9cgoq+xWvAk2p0xx2i0xSfoUPiwK7
 FdvN6DXEbPM1h5tbWbbdgdeb34wmRUlElmBzr8N7ryRsKAn2Z9tHn5OLLrBkEpDzArBM
 HqJh1yhafmKjtnGRsPElu2epXbQSdZc4ZziYKP3mlQFXeVxXFT9vBqlTi4Qyjp1keu2g
 ef6g==
X-Gm-Message-State: AFuF++k0JWO4GrV4Diq5t5AMkJtM5FOaIeJNPPjwGdqOrVYiNBZA5nuY
 IJdyog1d2w5k5YdyTZotIzcoVznwwomQ0z3bDU6eMcEhn8xK1KTQiBCik+9dqb3Ohtcd1pjBrPl
 d/w/n
X-Gm-Gg: AR+sD11T68ksvy/r5spaWaP6qewK/uA3UVw/9kW2XSb635Br+9Mmy07KNzoNx1vZaIv
 +JkXHTIrgYerkfaDswfWM3RRY9ZPch4yQHVOGAYv8p/rBjM3ZDlinfhpdlEnkW72f752o6Hs+Ak
 ZESQdqTpEHiz9/Qky4D86tOZR2msmtrRZbiNejHoIaMvQ0XQfiMyMsGWQeE6Rz8E84FdSo5Q0xm
 qfgCYWbcBgkt92Yg3MdydUt21g92vpSiI6vcnwS2t2CModzha+P+4kT7SJoF+YWKIGGCQ4I9OMn
 /p9BztDM5XQJ7U1VIccr6tDmsYU3CtkqbF2aEoYJstP9VYWWfuaVd7ASd6Shbw/8AqgFKUweCgS
 EX+rbkmjjZ2HFSt3U8SGgGvnelMngE2YG5XWmeszz4zwoTHH0Cq7uh3WhYk8WybWlIqkXQ9Pvmx
 DVIXLnpd3GwRWzHU0o1d8iWjUmXwqLuJUoCKE2kC6YlZBPqljFUMIgu1bCKBRzLuxRzed5p6Lvr
 ZzaR2NkucFO0QgIW81XBSTulJsaQbkmLk+9jKSJxs355YZKoJPZSHUxAQtV
X-Received: by 2002:a17:90b:4ed0:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-395dee539f3mr11468422a91.3.1787408641094; 
 Sat, 22 Aug 2026 07:24:01 -0700 (PDT)
Received: from ?IPV6:2607:fb90:3393:a89e:ee09:10ec:6f8e:caba?
 ([2607:fb90:3393:a89e:ee09:10ec:6f8e:caba])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4968623sm2828442a91.4.2026.08.22.07.24.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2026 07:24:00 -0700 (PDT)
Message-ID: <230c2fe0-94f8-46e7-a574-9d036ced67b8@linaro.org>
Date: Sat, 22 Aug 2026 07:23:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
To: qemu-devel@nongnu.org
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 8/21/26 16:51, Pierrick Bouvier wrote:
> With the single-binary, we start mixing types for different targets,
> that may or may not be available for current one.
> 
> Previously, we implemented an approach based on interfaces, but it
> proved to be too limited. It requires duplication between
> machines/cpus/devices, and does not handle specific cases where a type
> should be available based on a target configuration (Kconfig).
> 
> To solve this, we add a new field, available_if, to TypeInfo.
> It is an array containing a list of requirements for type to be
> available.
> 
> For now, we have only targets as requirements, but later we'll add
> specific target config entries also.
> 
> We also add a TARGET_REQS macro, to declare a list of requirements. For
> sanity sake, we don't use a complex variadic macro prefixing each
> parameter. It requires a lot of macro boilerplate in C, and prevent
> readers to jump easily to definition for each parameter.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info.h | 11 +++++++++++
>   include/qom/object.h       |  5 +++++
>   qom/object.c               | 10 ++++++++++
>   rust/qom/src/qom.rs        |  1 +
>   stubs/meson.build          |  1 +
>   stubs/target-info.c        | 11 +++++++++++
>   target-info.c              | 13 +++++++++++++
>   7 files changed, 52 insertions(+)
>   create mode 100644 stubs/target-info.c
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 6c5b714288e..6379e65bbcf 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
>    */
>   bool target_big_endian(void);
>   
> +typedef enum TargetReq {
> +    /* 0 is reserved for end of array */
> +    TARGET_REQ_BASE_ARM = 1,
> +    TARGET_REQ_AARCH64,
> +    TARGET_REQ_ARM,
> +} TargetReq;
> +

Is there a reason you're inventing Yet Another Enum, especially when target_base_arm etc 
are based on SysEmuTarget, which itself is used to create bitmasks of targets?


r~

