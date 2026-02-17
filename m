Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B17E9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 22:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsTy0-0001ef-E5; Tue, 17 Feb 2026 17:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vsTxw-0001ct-32
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:54:48 -0500
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vsTxu-0003IT-Ez
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:54:47 -0500
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-797d3864d89so22707537b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 14:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771368884; cv=none;
 d=google.com; s=arc-20240605;
 b=ls8zmlWblt+qY/B6nhHih1x4RnFqcixS4eM7rO4NxOpAn5GgtjxuYjlZJG50yJonJX
 0kwphH3d24E+sK2rBCv+g2mW4wNPf9TdN5J6YFXxhrsaSPy9Pp8m8ynnKogZouq7T58O
 n1KTwrCaTHq23Ohcl9+Im+AvLI7qDnP2DdY6BLbJtDd/K5bxAssnC1NJe5O9yOE7RHuI
 91bh+36lshHx5WRhfqPjXekEWwJvTg8q1GdYqgPs3o1wTFZNJzU1NsFprFRzeJQYt9X6
 S37R+U2E7IM53u5daeKFnvlCUfhtEhlWfrPcfVhNGsfknKiUwD1L1/uiPfMhkRwFRUKI
 +t8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YEnutw2sVh1ItS1+q6chAGpS6HxrnYqJ0Cfzm2eb4wY=;
 fh=mj0YjNTLQ2HKm3ZQoYxwoSDXHNgWbXit4jyFqp+SmHw=;
 b=W6QuoWiCN7hGxzwD2oFQW8HbDloY4oECNm94bFpj/K0QOPNIKD/91sq+swj0tj3vOl
 lxIn86dewEX5pc+K3ZgnjKeVYnDZIWhiR931OgYonsuJXglN87pDIwPUsWC1v7fceY5Y
 BeyqaqcpY+tOFgcJxKy4uFup0G+To5X0NKq1NH/QfX/TvqcoDNCanBFy40V8Q/l/8bnk
 o+bNyy9qwCUj57xBA5uRsjMFEWpaEJD/9vv4RsMy9GLDNwNI4CdBWcO9glYgASWxSmvs
 reM9gQoJ55CLHdvPN1+/8JoV4J0st2IARkzAKv5mDolsFMny1loU2SjvXfdo2noN+b9Y
 m6bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771368884; x=1771973684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEnutw2sVh1ItS1+q6chAGpS6HxrnYqJ0Cfzm2eb4wY=;
 b=A4IBhyBI9es2tiR6sgRotWDgMemhLfroRJIWLrzjI8Y9D1l8xDcOgmY5RCLKyBEP9v
 +XMZ5CH4sPu6ONY5Bha/NyOyrfdmJhz3ueUIxEL3IFvFsFLsgSnGjt3F7zOdkBs2sBRv
 8S86WYcjagF5teu2upD8aoetRbP6RzgzSJ7yWqmRwE9NGc+LD4vhaqY7wDIEYxak4LBS
 AXbZ1mPVni2ZP+qQxxfZ/HGKZbiAaQXELzel0Z01l1Emxe3sb8FMH+7qS9rtOHVyO4G0
 Exf/cYsB//ZxO4Y8ZgNoKU9C4Zg3CNGYLaH49ntPLWi2ZPT84xwqBbv10fpaWsMWEk4N
 N99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771368884; x=1771973684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YEnutw2sVh1ItS1+q6chAGpS6HxrnYqJ0Cfzm2eb4wY=;
 b=qVzrwMQSbyYewMQie2/is5DzPCG1YJ++U+MPiWhA/tyPw196nDYAZHaglCr8UXOmR4
 LxA5RDHh8LISLYGPTfmleqdoEjO3H83OjK8u3GJ8hKYZ0Dr6UYxOfZK86YzxNSCbOzmX
 MosiZ7zBZIf/dD0YTzP0KcYBY0z67BXSpPEpas7gsrVM8eFj7v57GRuNkswvitkJdNUp
 /WIkif842P/qSOikAqRwf7HyvJQRlyL4FmeZXzzUeC/1r74XGKCDUyytssxWHDmnII9H
 I4mrl5KT9CeVNc25WcBaNkhLYNv5xjmicaBOveFCIfm34osYooAz5x0sGBCYbgWqOcsk
 ii7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+bs2BDmiyOFhlGvGfC1bDC5fxFwaRahC3quqviqFCtLQ1RVDlW/ZmEXFjN9uoS7PWvC7vw92nmCl@nongnu.org
X-Gm-Message-State: AOJu0YxLc/uai6nTbMBYkfZgvGVopd27ihF54sbn0n8VmkhvBQxBbk54
 nlz3oA7OXoI0el2jcHn/CRsWmqKs/ibrNY8qQgu5fKhvhYLKyOVIPdGk57zqolgGAXkDrrBy5Al
 gOaR14lNFue3aLtmIidBdp2hnrHVrcrw=
X-Gm-Gg: AZuq6aI9BzuoGDtyjBKzfEJrFDdcJhwQ+XP4ij9PfioPwlaT7Lo6VltqDRe3Alr13oC
 gKEJ1lFEXjAJX6KsEuahyDfzVSLdiRVgNfw5+dnAdkabRS0t96gPoA/hXbNmQSyFn+LQo4pJgez
 HKU17uaWEjp/PWRGllIMyCZxpfbcasWkxltL1W1o3aAVA5zw0ORySNsouXLQq7i3/ECyvFMnNJE
 urAFj5t3WGjAV8k9Cj/aVBZa7tlv3keRnG5LJtiKi6I3T7DdtT1fU4kNJqLLsuMVmocx9jKpTS9
 ljhHLt4=
X-Received: by 2002:a05:690e:16a0:b0:64a:f3fa:af58 with SMTP id
 956f58d0204a3-64c21a43cf9mr10256618d50.17.1771368883742; Tue, 17 Feb 2026
 14:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <68c6ced9-dcbc-4981-b2be-65cdf7e2de9c@linaro.org>
In-Reply-To: <68c6ced9-dcbc-4981-b2be-65cdf7e2de9c@linaro.org>
From: Yodel Eldar <yodel.eldar@gmail.com>
Date: Tue, 17 Feb 2026 16:54:33 -0600
X-Gm-Features: AZwV_Qgec_5EStm_fKnsLn5KXDi-r8pnO5StwC7c_mCiLXqCbX3xZNXP5fdYaEA
Message-ID: <CAHhgW4UzC4vxPrpGz37GbAdgO+G+dL_OB+LpR4iXRbvsDHXbFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Yodel Eldar <yodel.eldar@yodel.dev>, 
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1141;
 envelope-from=yodel.eldar@gmail.com; helo=mail-yw1-x1141.google.com
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

Hi, Philippe

On Tue, Feb 17, 2026 at 11:01=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Akihiko,
>
> On 17/2/26 07:34, Akihiko Odaki wrote:
> > alpha_cpu_realizefn() did not properly call cpu_reset(), which

...skipping...

> >
>
> We ought to rework the CPU reset paths, it is too confuse.
> Peter / Alex / myself have been there. I started some work in the
> area, fixing few inconsistencies, but it isn't a priority so never
> got over it.
>
> We really shouldn't manually call cpu_reset() in DeviceRealize
> handlers, thus not add more calls, rather remove. I appreciate this
> is a temporary kludge until we sort the cpu reset logic.
>
> At a glance, since this is an icount issue, instead of adding
> cpu_reset() all over, I wonder about this surgical kludge instead
> (untested):
>
> -- >8 --
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ad94f96b252..0577c25e3e8 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1071,2 +1071,3 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp=
)
>       tcg_iommu_init_notifier_list(cpu);
> +    cpu->cc->tcg_ops->cpu_exec_reset(cpu);
>   #endif /* !CONFIG_USER_ONLY */
> ---
>

I'm getting a regression in mips64el malta with the above; not sure why:

    meson test --setup qemu:thorough -t 1 \
        --num-processes 1 func-mips64el-malta

ERRORs out.

I like the idea of reworking the CPU reset paths; please Cc me on
related work you submit so that I may test it out (though, I'll keep an
eye out for it anyway even if you forget :))

Thanks,
Yodel

P.S. I actually sent this email out from my other address over an hour ago,
but just now realized that my SMTP relay had blocked it due to too many
recipients (I guess that number's 10 then), hence the switch to this accoun=
t.

