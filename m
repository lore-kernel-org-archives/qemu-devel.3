Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45719EDA682
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRNh-0004Nj-OY; Tue, 03 Mar 2026 10:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRN8-0004Au-EC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:09:22 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRN2-0003pw-L3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:09:16 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso7040600d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:09:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550551; cv=none;
 d=google.com; s=arc-20240605;
 b=cdylQ0W29uaIZ8yK7YsK0XEys6v/R0HOTJGzf0iZ8OnQQyTTQFwY/axhFh/Kjrsb2T
 MA5pYrBP35uy54dE90uZPNiSFaCaEF4i96/vmW/sJZLrjIXE6NuBKhu0Xl2DmUde0svQ
 aFM1aKsuJFHHX8uqRtZ59AYXeAAkviTr//8br5biwBKxX7bFw2HTFH9sIoKWZVeIn71C
 nghcEGrTAgXK0JUKOaCDBIUDqcpFavul3To9LEVT7hqpvzTToBqcRFRdRpwMBjQFmhPw
 FoemWmopfkUUqoAaex5iNvfDbm8QhJ5f6i/NXrUv02i/w3RKVkV5RCN0C0F0WxPNBYUc
 mTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EVsl4KNaXtWkiKOuqqaGL0YvyFVVA2j+IlJDQ709Ows=;
 fh=vCqJZVYp5Apf2tbFXjVivCGx9SqaPt93VAgOonZAg3A=;
 b=dk1KEz2Va3E6YP2nLCd+eMz+aRtD2hiGOf0g/HflwrYAGe7M5x+HGDvYqKufWDU3Dm
 ic9G7iDdtfoucqUxiIg2jUzYylMFoJxx16ZILEkbnQxWloNiUepzbpPjoe2rnglwRtF2
 WM9a5Id4t+vA2uy6g+phaFgNTtXN3yOWcUqukYd5IeL0Ya7uc1EcSzGFx6z0EYzszHko
 wRQgIZGsae/v8R/yECKs9cJ0XvItAwu7QpFxjPpC7o4mtp0Dpb2NLk/hWBLGlimFjR96
 WD8H/cmOBw/zEnwdLxrCqpu5WGhCs1a+2U+tFIl8bzem1LfjiOHP7UgtIvmtaQ+4AQuG
 uDjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772550551; x=1773155351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EVsl4KNaXtWkiKOuqqaGL0YvyFVVA2j+IlJDQ709Ows=;
 b=tuhbx1gsBAv7gHvAwRQdlu5b/e02tODwDolsacE7Zpwu7znEO2rXMpLjN0v/CfyAnl
 5HAuYIT+i/G+7XingOJDYtit1LUNsSXM28sPbMVUlXkYTrtP3Ok2idQwcsyJuWKEYuon
 M72KxemxNk6ddXDKQh2nwXQAzfTeCmkB7V55LsE5UffocZTjjzxWk2VZ/Pn2ZSxuADnj
 N+o0bhKvpA2x2CV7bZxwxNTeFa/pII+ytMPg05zq69YE2rqhNPlQkgCcQMrjaVOtVj+o
 /t5YSGKUbYyNnq1wL2DBuU85MNHC5AqdV5avgJuHLhKhs3LB/K7pjll0OvJ3aXobytg+
 SdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550551; x=1773155351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVsl4KNaXtWkiKOuqqaGL0YvyFVVA2j+IlJDQ709Ows=;
 b=bDAtADW84Jv1DrQ+DhsMmnZYBNIJSkcDyjvE7BdTYh4X7Goi7yBl/Obv7XusZPNE5b
 hAPJ4ArsLA6qvDEu65+phzrYIb+uhF9/Vus/T6LcRMPFLJUEKU7zDW4pBbmZjwrc0QaS
 mdhPTV3EWWWoMVEnFUjBYOaYpSFDVG2EQ1yCBVa3P4/mK7L1XSVGtx17xXNh7X/k+4s9
 TpqqJ9B95u0tOv0aR5N4p1n74LKqQ1TcrqvP16fo2RxBJimZIatmcGyn8hc9yQefG582
 WsWWsSH2luiO7ycdLIUc3k0XMn/XB9Hj84sF2jk9FP/6QUMYBV13hZ2A/6REsjpdRS/m
 ueYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHZ/ykp9JVkiXpCQkX22XKOtHS0xVSFejPDDf7Yzr634ChLlU6sKjhdnzKIJCSITlHLpr5sQb3CUtX@nongnu.org
X-Gm-Message-State: AOJu0YwdQe5Wl/Wub5Jhqgrz7QB1pBT61NkqzQGPSro4TDIIoF2fWKHn
 HaV7YGGv/l4o0yfFu9o2cMs7vrv4dYLvDOH3Ej3hXsQ0TIPsxAPqDLf3ZYhsgjk6K3nOTn64UAb
 yAAxRRK4hauOkBO4azdqd43JE+gU58A8ToOSK14Yt0Q==
X-Gm-Gg: ATEYQzxh7bc+6xp6KeCpHAcCj31hSs5yibJy18ucRctWpBD6ZgH7FCFIZlzmi20UBFH
 LVtH13g3UmqvAo6vV9APqZegOLLCev4Qc2bAv1881rSmPEYso8ffXDhtirV3q/tHe3qlcxUCyAh
 1ZBa3GNiaR/hzffg9j11zVgttALQ8cN4+hDIoLmoyo+UHuWB1eiNqQCuu6ETa8zBjUSVuYvhfKV
 KY7cumu24P71zDMyu1FLdVbvKZiuf+Byb/X6kcZYc6paqmkOePhCrBU83cwtdiBmnlHAmM2HfKa
 WcT1gpz9yI+q/eXHF8/gSmGhHO0UzOjLNAoWZZXtQZDXqXhcAy76WaqEje3fvWfcJAQ=
X-Received: by 2002:a05:690e:1383:b0:64c:9c1c:5f6e with SMTP id
 956f58d0204a3-64cedb4a00fmr1920478d50.5.1772550551233; Tue, 03 Mar 2026
 07:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20260303143928.1747116-1-eric.auger@redhat.com>
 <20260303143928.1747116-3-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 15:08:59 +0000
X-Gm-Features: AaiRm509veks7jfVF4zfG7cRsBuRkgXkq4k39mF1vLk9aEJBBXtjiziT_3Hbcgk
Message-ID: <CAFEAcA9i3PmcX8xLEPd+254Ry7ojPKetDGzYtSNp46WZqSNP7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
 for cpreg arrays
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 3 Mar 2026 at 14:39, Eric Auger <eric.auger@redhat.com> wrote:
>
> This removes the need for explicitly allocating cpreg_vmstate arrays.
> On post save we simply point to cpreg arrays and set the length
> accordingly.
>
> Remove VMSTATE_VARRAY_INT32 for cpreg_vmstate_array_len as now
> the array is dynamically allocated.
>
> Also add a trace point on post_load to trace potential mismatch
> between the number of incoming cpregs versus current ones.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>
> ---
>
> v1 -> v2:
> - also modifies the allocation of cpureg_vmstate_* in
>   target/arm/whpx/whpx-all.c
> - added Peter's suggested comment on cpu_pre_save()
> - free the the vmstate arrays on post_load
> - add assert on pre_load
> - fix comment aboy length check in machine.c



> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index bbaae344492..aa617dd64db 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "trace.h"
>  #include "qemu/error-report.h"
>  #include "system/kvm.h"
>  #include "system/tcg.h"
> @@ -984,11 +985,14 @@ static int cpu_pre_save(void *opaque)
>          }
>      }
>
> +    /*
> +     * On outbound migration, send the data in our cpreg_{values,indexes}
> +     * arrays. The migration code will not allocate anything, but just
> +     * reads the data pointed to by the VMSTATE_VARRAY_INT32_ALLOC() fields.
> +     */
> +    cpu->cpreg_vmstate_indexes = cpu->cpreg_indexes;
> +    cpu->cpreg_vmstate_values = cpu->cpreg_values;
>      cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
> -    memcpy(cpu->cpreg_vmstate_indexes, cpu->cpreg_indexes,
> -           cpu->cpreg_array_len * sizeof(uint64_t));
> -    memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
> -           cpu->cpreg_array_len * sizeof(uint64_t));
>
>      return 0;
>  }
> @@ -1034,6 +1038,9 @@ static int cpu_pre_load(void *opaque)
>          pmu_op_start(env);
>      }
>
> +    g_assert(!cpu->cpreg_vmstate_indexes);
> +    g_assert(!cpu->cpreg_vmstate_values);
> +
>      return 0;
>  }

You missed clearing the pointers in post_save -- I think these
asserts will fire if you do a vmsave and then follow it with
a vmload in the same VM.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

