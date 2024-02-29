Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A77C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjiR-00054y-13; Thu, 29 Feb 2024 11:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjiP-00054M-0A
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:57:01 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjiN-0006pT-2f
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:57:00 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so13746571fa.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709225817; x=1709830617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cF/w8l1gfNWDsqyxGTnLtbgrYR4tq0E41Cdtc2y9MLI=;
 b=wOKaqi+ciThyiNH7jijVfpH7TqF4fMxO7x70xQWrNO+om+oAHMikR6zWr8Om/WIU9p
 FjyOC55akN9UiDgl6+ppGv5w9AYd0+FllRglDmY0rO33XgWQr9tONS5lUS9YG5U+sNav
 Yr5CVd9MwIQMB/Npa60he/ZaKmuFonaYnirjo78TDTRsDVhtlZrIEyyMlOwpGpk/1z/b
 cV0i2pZpaqmZ8Iv2E7hZBWbrn+t6jv+iqUAalDNPE9JO5VfjrkWLMnF4HXypt5ytY5a6
 yqPwgOZ9wAFNfmghhaVXCMGKJuKdZqBPVZ2E3/9f5AfXlxEjHHnyg98N3AciGovusRL8
 Hfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709225817; x=1709830617;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cF/w8l1gfNWDsqyxGTnLtbgrYR4tq0E41Cdtc2y9MLI=;
 b=K/LlnStRSCa+5INGAo/MUFq1PkqG8PpsUGZ/xKXx3dT5HgCopQz+WbIT7o/a1IuV2Q
 B6AaD8SJMWqpAWg9ErMH44UYnnomrptNs363mN7pTBr7RbP14e660vXcSd+/Dzc005iL
 V+pNKZKsKzAP+cAUfa/JHAcjpmdGvgnKq7MBEfhbL0c1GjALcZm7IG4pkMdePMl9hjaL
 a8PiJDvtoVqedOh5N2hPtk5CccB0dl4kSNaNkzDGIslJaEvdLN76STUPeTX53KVDJDag
 k67ak+KlEQsR8VLrERQx9ewLQN+6LJVtYMCCPyNxnPOzFQuJyUDpaDuHfarzjodoJ+Jb
 vUUQ==
X-Gm-Message-State: AOJu0Yz+/6bFupLvkegFP5iLY0ssl0/hfM6U24IQjT3ei32z/wuX6aaH
 cf/hmzfAcaT600R9mMWcZABMr+Qxefa0TQ+SnSLaza+w3s/l0/8xj3/iPi9xBus=
X-Google-Smtp-Source: AGHT+IGPJqMg+IqO16jycHNJX0GXsUkw+GZlBILoW6Kp/SIaAifrxBQwDhHqwtGVIMPTRslPcYI0OQ==
X-Received: by 2002:a2e:8743:0:b0:2d2:29c2:e7ea with SMTP id
 q3-20020a2e8743000000b002d229c2e7eamr1747989ljj.24.1709225816601; 
 Thu, 29 Feb 2024 08:56:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bn26-20020a056000061a00b0033e032bc26bsm2272084wrb.82.2024.02.29.08.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 08:56:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF9C15F7D9;
 Thu, 29 Feb 2024 16:56:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 05/18] mcdstub: memory helper functions added
In-Reply-To: <20231220162555.19545-6-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:42 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-6-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 16:56:55 +0000
Message-ID: <87r0gv6wfc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  include/exec/cpu-common.h |  3 +++
>  include/exec/memory.h     |  9 +++++++++
>  system/memory.c           | 11 +++++++++++
>  system/physmem.c          | 26 ++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41115d8919..dd989b5ab2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -182,6 +182,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t st=
art, size_t length);
>  int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                          void *ptr, size_t len, bool is_write);
>=20=20
> +int cpu_memory_get_physical_address(CPUState *cpu, vaddr *addr, size_t *=
len);
> +
> +
>  /* vl.c */
>  void list_cpus(void);
>=20=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 831f7c996d..174de807d5 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3142,6 +3142,15 @@ bool ram_block_discard_is_disabled(void);
>   */
>  bool ram_block_discard_is_required(void);
>=20=20
> +/*
> + * mcd_find_address_space() - Find the address spaces with the correspon=
ding
> + * name.
> + *
> + * Currently only used by the mcd debugger.
> + * @as_name: Name to look for.
> + */
> +AddressSpace *mcd_find_address_space(const char *as_name);
> +

Don't hard code this for mcd - maybe address_space_find_byname()?

>  #endif
>=20=20
>  #endif
> diff --git a/system/memory.c b/system/memory.c
> index 798b6c0a17..9a8fa79e0c 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3562,6 +3562,17 @@ void mtree_info(bool flatview, bool dispatch_tree,=
 bool owner, bool disabled)
>      }
>  }
>=20=20
> +AddressSpace *mcd_find_address_space(const char *as_name)
> +{
> +    AddressSpace *as;
> +    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> +        if (strcmp(as->name, as_name) =3D=3D 0) {
> +            return as;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  void memory_region_init_ram(MemoryRegion *mr,
>                              Object *owner,
>                              const char *name,
> diff --git a/system/physmem.c b/system/physmem.c
> index a63853a7bc..70733c67c7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3422,6 +3422,32 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>      return 0;
>  }
>=20=20
> +int cpu_memory_get_physical_address(CPUState *cpu, vaddr *addr, size_t *=
len)
> +{
> +    hwaddr phys_addr;
> +    vaddr l, page;
> +
> +    cpu_synchronize_state(cpu);
> +    MemTxAttrs attrs;
> +
> +    page =3D *addr & TARGET_PAGE_MASK;
> +    phys_addr =3D cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
> +    /* if no physical page mapped, return an error */
> +    if (phys_addr =3D=3D -1) {
> +        return -1;
> +    }
> +    l =3D (page + TARGET_PAGE_SIZE) - *addr;
> +    if (l > *len) {
> +        l =3D *len;
> +    }
> +    phys_addr +=3D (*addr & ~TARGET_PAGE_MASK);
> +
> +    /* set output values */
> +    *addr =3D phys_addr;
> +    *len =3D l;
> +    return 0;
> +}

I think there is some scope to re-factor some code that is shared with
cpu_memory_rw_debug. In fact rather than using this to feed
mcd_read_write_memory() maybe you really just want a
cpu_physical_memory_rw_debug()?

Although as you are going from vaddr anyway where does
cpu_memory_rw_debug() fail for you?

> +
>  /*
>   * Allows code that needs to deal with migration bitmaps etc to still be=
 built
>   * target independent.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

