Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D3D6407A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9UTj-00063t-8N; Fri, 08 Nov 2024 14:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9UTh-00063k-8w
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:17:05 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9UTf-0002yF-GB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:17:05 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb57f97d75so23032561fa.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731093421; x=1731698221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLkvLi6d/hz4FITtyuiiowJydG/I4Z7ZrZc2CNtKris=;
 b=X3AA3aVCG8sqhaXXjbUoE0ntSFLaKfC43GBMjqyqQA/kbXdLapcSC06o5daZsFukh+
 oMl2NL7VcI2050l3vIzlt1NkiDR8DxpYWVGfHbsgf9jzSYpD+ILzc90EegRLOTaflGUA
 d9+3N5nGHJLlyXLKpsLtlOWowHAgg+OZgrMpv0X5r1HTHWtJYVL0TT9QI7RFJ5/u5Yj7
 UNbUW4VlEXW/lNW0HZvCc84nef5RDONSk+PVHZ7xYCdWIPwuW5XLlj3ohbbH6X58VBvu
 vLsZ7veJTusUNT3bIRYMh0T5DSKcU+hCqPSicRffg3Y5BQMtEN0ipeFSpOJk10waS7Xd
 zXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731093421; x=1731698221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLkvLi6d/hz4FITtyuiiowJydG/I4Z7ZrZc2CNtKris=;
 b=WZop5TsywOTPnjrFW2nNsKTWvawGN2Q6SBVAZKfhcctLQ4iGEfsDzBCKnWdy0r6bSI
 8QsW74oECc0IrG6aDNm7DhC1xoZxiNoNiZsFLmHSY/Z+SWNuuGliDZypUi+IdnTKaG5z
 nDO47r9nZ04vycZ+Gg20voDJMhCYOvijTMBK8h0k56nCXqIsWPrTW4qftoKSoHEtMrSX
 4NuYQ8AwkYrbTYh/w0o+Kjovz2yz9yhfzHIJQvt6h6f3Y+EtI+8U6UUXKUyU4zpY26Jv
 ClcNBpNaTIvF24W+n/k7B6OMVZf7EDobMAWChEdcE6mJ/SboPPJ9g9M6dCxvV8ylBuEW
 JhzA==
X-Gm-Message-State: AOJu0YySYiSe22APO//7u3R+aev/iiJr8v7kEAF+p1/WTs6PY1pW/ox9
 IXpVAiFGmZS8Jqxms9UgCbHECSP0MLHl3Qa+VrpeEfJgUUGGH3tyycUr9BC8pU6PiLTKfSzz3Xt
 KRLryG5Pq1cMV6iXYrFLfCBssh/AcEhTnvsjhIQ==
X-Google-Smtp-Source: AGHT+IECrx16xd2YQa7y6IM1uItbaNKgcj/dplvq9tRh9ldwQsOu80L/qa9zd4NO6+KuXZH6NFqqHeIbanZfifIsnJ8=
X-Received: by 2002:a2e:a541:0:b0:2fa:c8d1:224 with SMTP id
 38308e7fff4ca-2ff20152518mr23065761fa.2.1731093421108; Fri, 08 Nov 2024
 11:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20241105224727.53059-1-philmd@linaro.org>
 <20241105224727.53059-11-philmd@linaro.org>
In-Reply-To: <20241105224727.53059-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 19:16:50 +0000
Message-ID: <CAFEAcA-6e-o480iPeesKPnvcBtjVwWsL=zYOuNNddPNZu7Uc6g@mail.gmail.com>
Subject: Re: [PULL 10/29] hw/core: Check smp cache topology support for machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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
> Add cache_supported flags in SMPCompatProps to allow machines to
> configure various caches support.
>
> And check the compatibility of the cache properties with the
> machine support in machine_parse_smp_cache().

Hi; Coverity points out an issue in this code (CID 1565391):

>  bool machine_parse_smp_cache(MachineState *ms,
>                               const SmpCachePropertiesList *caches,
>                               Error **errp)
>  {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      const SmpCachePropertiesList *node;
>      DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
>
> @@ -283,6 +305,25 @@ bool machine_parse_smp_cache(MachineState *ms,
>          set_bit(node->value->cache, caches_bitmap);
>      }
>
> +    for (int i =3D 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
> +        const SmpCacheProperties *props =3D &ms->smp_cache.props[i];
> +
> +        /*
> +         * Reject non "default" topology level if the cache isn't
> +         * supported by the machine.
> +         */
> +        if (props->topology !=3D CPU_TOPOLOGY_LEVEL_DEFAULT &&
> +            !mc->smp_props.cache_supported[props->cache]) {
> +            error_setg(errp,
> +                       "%s cache topology not supported by this machine"=
,
> +                       CacheLevelAndType_str(node->value->cache));

This error message looks at "node", but "node" was the iteration
variable in the first loop in this function, so generally at
this point it will be NULL because that is the loop termination
condition.

The code looks like it ought to be reporting an error relating
to the 'props' variable, not 'node' ?

> +            return false;
> +        }
> +
> +        if (!machine_check_topo_support(ms, props->topology, errp)) {
> +            return false;
> +        }
> +    }
>      return true;
>  }

thanks
-- PMM

