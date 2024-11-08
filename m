Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6EDD6407A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UNp-0000kh-ON; Fri, 08 Nov 2024 14:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9UNn-0000kI-6f
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:59 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9UNk-0002TO-UW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:10:58 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so3604257a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731093054; x=1731697854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dR3SDW0OY04sCEG+HjS6jImjgxhdQrsKkV1oU1OuXFY=;
 b=mzbhmsAYAGFCPt4pIJz5y090sbThzuYMcdolOsDHlpixgZFgcdSZvcU2eRborNt4De
 mvwOskrJgWqYesIjUHxJuMc9FrUAfIYegn0aSZfAc5LlJxBeqeZsjc7n7DgsFMGia7AT
 ZAz3FqHescKdjfM0h4nukzr/3je5esceggIReXf0LH6KHg86Rdr8dO4ldygsoMtqtt+4
 WA1FhQUd4SWOSEsQrrU6jt8nX8+twW5r98G1Zi6/E5Uv46FhZBPmCym46qZ4mHh03/ef
 bp7vxY2mvD+kT15HccLMsGRcRe9DH9ktb4mRKy14QOXWhgKUeI+ne4kvW6Cq8YGRsEsg
 bFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093054; x=1731697854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dR3SDW0OY04sCEG+HjS6jImjgxhdQrsKkV1oU1OuXFY=;
 b=g5YBf/iSwAj2fGWbo1MDvJRi45P2of7FSwEaEaScoYTGVnyHfmWUu8BDMAjZT4Ijj0
 AXlWVbEhzHUAAUYROBtK1alHH/MFeDkq/eXDP0YBpzucNLawJSzfhn1Ew60Saz/081B5
 5h9Vn/IcGdstU2+N+rjzzDG3DTvbOkxmg67PmATnMxAp6cyHMwTfYln03AODOwuF157E
 eBYQLtgaFImSTx9VW/2KAX0YVRiNHTHbeSO5NbuWC7jLrYCfDnTDETWxTkdySghI+3iF
 k5ChhlMzCByku1nZE7TPU/Rlr4nrLKNKtjk6x1gMOJ5b4nmCX4H4PYfAmfX+x2GVDGxc
 PqSA==
X-Gm-Message-State: AOJu0YyiBfV61/e/9ZLCNJn/WGPOb7sy6CZOPP3juDrdBV1MNT6wY1/I
 KwH9O0d+xz/9+nipfgN3uelgVYiOiH1/XSIn2jxmtQJ5o/KKKRm4qIJbgzclwy6r2In85ubRP/R
 ISWzXTIDNxdj7Jt4MPotmXv9gdpAoITkoguH1bw==
X-Google-Smtp-Source: AGHT+IG0n5f7Ygjh5Qi+Ygyh6S5Pt7WYhDDazblR4bxQLsB4LJq/RYUejjg2FkZw1RmwVPaZK5uvm502ic8v9wVrqAY=
X-Received: by 2002:a05:6402:2690:b0:5c9:39d8:58b3 with SMTP id
 4fb4d7f45d1cf-5cf0a447552mr3043126a12.23.1731093053600; Fri, 08 Nov 2024
 11:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20241105224727.53059-1-philmd@linaro.org>
 <20241105224727.53059-10-philmd@linaro.org>
In-Reply-To: <20241105224727.53059-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 19:10:42 +0000
Message-ID: <CAFEAcA_+ZSZF1VYFcPRq1AD+i4=nT2RsdVhhaj7wiL4xD=R_-A@mail.gmail.com>
Subject: Re: [PULL 09/29] qapi/qom: Define cache enumeration and properties
 for machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 5 Nov 2024 at 22:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> From: Zhao Liu <zhao1.liu@intel.com>
>
> The x86 and ARM need to allow user to configure cache properties
> (current only topology):
>  * For x86, the default cache topology model (of max/host CPU) does not
>    always match the Host's real physical cache topology. Performance can
>    increase when the configured virtual topology is closer to the
>    physical topology than a default topology would be.
>  * For ARM, QEMU can't get the cache topology information from the CPU
>    registers, then user configuration is necessary. Additionally, the
>    cache information is also needed for MPAM emulation (for TCG) to
>    build the right PPTT.
>

Hi; Coverity points out an issue with this change (CID 1565389):

> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 5d8d7edcbd3..c6d90cd6d41 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -261,6 +261,31 @@ void machine_parse_smp_config(MachineState *ms,
>      }
>  }
>
> +bool machine_parse_smp_cache(MachineState *ms,
> +                             const SmpCachePropertiesList *caches,
> +                             Error **errp)
> +{
> +    const SmpCachePropertiesList *node;
> +    DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);

DECLARE_BITMAP() defines the caches_bitmap bitmap, but it
does not initialize it...

> +
> +    for (node =3D caches; node; node =3D node->next) {
> +        /* Prohibit users from repeating settings. */
> +        if (test_bit(node->value->cache, caches_bitmap)) {

...so here we are reading the variable when it is uninitialized.

If you want to zero-initialize the bitmap you can use
   bitmap_zero(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);

> +            error_setg(errp,
> +                       "Invalid cache properties: %s. "
> +                       "The cache properties are duplicated",
> +                       CacheLevelAndType_str(node->value->cache));
> +            return false;
> +        }
> +
> +        machine_set_cache_topo_level(ms, node->value->cache,
> +                                     node->value->topology);
> +        set_bit(node->value->cache, caches_bitmap);
> +    }
> +
> +    return true;
> +}

thanks
-- PMM

