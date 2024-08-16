Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7A9C531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sez19-0007Zw-2m; Fri, 16 Aug 2024 11:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sez16-0007Xd-RO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:37:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sez15-000254-4U
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:37:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso154506a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723822645; x=1724427445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJxYM7gZybbqeya6mc35PVsWezbMh8hgRpJUUaoEGbY=;
 b=QbYhHWwd3D3qvUmKrA02iKxXbfJPAht2p+SfrgElcJwYQzSYbwk9wAnUWNOjwOpwHm
 xmoAHZXqj8F6A2oq5b5lAnavTun8BHOZywgHAiG+fjaoXpK1ledbkZPnrx4bYPcPZMlh
 OyEXTWYS2yhSydl8nbsiuKsZBgVWWP3xld29FZ0VkJtBLA8d8KId+zqCvWL/lXrE0/VC
 8+yDkEWTZHHelBo62bGvSdN1w5lr/wNDBBkyulihRkK/8nkxzg62dNu8/d5VXCe7QOcA
 ojmTPKu1F8MnOXnDN6aKaLOnW8BpNM3TVEFjnLfp2LtiAkLZKKw0tjgH323tf1fsnKPk
 Tg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723822645; x=1724427445;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJxYM7gZybbqeya6mc35PVsWezbMh8hgRpJUUaoEGbY=;
 b=s/3r2YP1C6OZKy2QIzS9ItDSouOOayOj+072LagamGY/mmZdlg7MfSBG6TBuuHk5q/
 sRoRY/nS5VjhOB8Lq2mNsUNI4qmVskwyKmywMd/7SpGorUAZoXfAREaoaOgqq03kKdiw
 NpdXxC4+1iH+q8MKetGFYEezOrlUts4QMVjhERCY2c3jixiqaZj+YBpwZB6f5EbOvQ9l
 owKKU975nxpgB7CQlLWj6jGHxSQqgtcUttRk8+5lmokgAyBh16TL4byGj5qDhQmk4pXM
 +YvbfIYhZRK/Rm3HGiEqWgxzyR3yL+66wNrzJQ7gp5ooIS/z5d1ksu509Zgw+T2spACJ
 GPKA==
X-Gm-Message-State: AOJu0YzdlUiwEofnm6AzxpKnFgXUV6Nak1brzWM4XhSxkcPP0SMUMnQ1
 9AvD7dd8lbNMQrr1xnvHf/+Q3/bZK1Edc/Jv9g7eaDVkJik/nozrj3NH7yrYs28=
X-Google-Smtp-Source: AGHT+IFtjq9RSkr+32FMzqM57nSykzhAhSTf0L0+dWPTvtNHrT17gYOg1RBdzeJXxNOvBeZa9c8FTg==
X-Received: by 2002:a05:6402:1e89:b0:5a1:4ca9:c667 with SMTP id
 4fb4d7f45d1cf-5becb5edc13mr3127372a12.11.1723822644367; 
 Fri, 16 Aug 2024 08:37:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc0817a8sm2381867a12.84.2024.08.16.08.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:37:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0C555F92F;
 Fri, 16 Aug 2024 16:37:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-arm@nongnu.org>,  <mst@redhat.com>,
 <maz@kernel.org>,  <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>,  <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>,  <richard.henderson@linaro.org>,
 <imammedo@redhat.com>,  <andrew.jones@linux.dev>,  <david@redhat.com>,
 <philmd@linaro.org>,  <eric.auger@redhat.com>,  <will@kernel.org>,
 <ardb@kernel.org>,  <oliver.upton@linux.dev>,  <pbonzini@redhat.com>,
 <gshan@redhat.com>,  <rafael@kernel.org>,  <borntraeger@linux.ibm.com>,
 <npiggin@gmail.com>,  <harshpb@linux.ibm.com>,  <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>,  <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>,  <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>,  <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>,  <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>,  <jiakernel2@gmail.com>,
 <maobibo@loongson.cn>,  <lixianglai@loongson.cn>,  <shahuang@redhat.com>,
 <zhao1.liu@intel.com>,  <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
In-Reply-To: <20240613233639.202896-25-salil.mehta@huawei.com> (Salil Mehta's
 message of "Fri, 14 Jun 2024 00:36:34 +0100")
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
Date: Fri, 16 Aug 2024 16:37:22 +0100
Message-ID: <87v800wkb1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Salil Mehta <salil.mehta@huawei.com> writes:

> vCPU Hot-unplug will result in QOM CPU object unrealization which will do=
 away
> with all the vCPU thread creations, allocations, registrations that happe=
ned
> as part of the realization process. This change introduces the ARM CPU un=
realize
> function taking care of exactly that.
>
> Note, initialized KVM vCPUs are not destroyed in host KVM but their Qemu =
context
> is parked at the QEMU KVM layer.
>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> [VP: Identified CPU stall issue & suggested probable fix]
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  target/arm/cpu.c       | 101 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h       |  14 ++++++
>  target/arm/gdbstub.c   |   6 +++
>  target/arm/helper.c    |  25 ++++++++++
>  target/arm/internals.h |   3 ++
>  target/arm/kvm.c       |   5 ++
>  6 files changed, 154 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index c92162fa97..a3dc669309 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -157,6 +157,16 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, AR=
MELChangeHookFn *hook,
>      QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
>  }
>=20=20
> +void arm_unregister_pre_el_change_hooks(ARMCPU *cpu)
> +{
> +    ARMELChangeHook *entry, *next;
> +
> +    QLIST_FOREACH_SAFE(entry, &cpu->pre_el_change_hooks, node, next) {
> +        QLIST_REMOVE(entry, node);
> +        g_free(entry);
> +    }
> +}
> +
>  void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
>                                   void *opaque)
>  {
> @@ -168,6 +178,16 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELC=
hangeHookFn *hook,
>      QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
>  }
>=20=20
> +void arm_unregister_el_change_hooks(ARMCPU *cpu)
> +{
> +    ARMELChangeHook *entry, *next;
> +
> +    QLIST_FOREACH_SAFE(entry, &cpu->el_change_hooks, node, next) {
> +        QLIST_REMOVE(entry, node);
> +        g_free(entry);
> +    }
> +}
> +
>  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
>  {
>      /* Reset a single ARMCPRegInfo register */
> @@ -2552,6 +2572,85 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      acc->parent_realize(dev, errp);
>  }
>=20=20
> +static void arm_cpu_unrealizefn(DeviceState *dev)
> +{
> +    ARMCPUClass *acc =3D ARM_CPU_GET_CLASS(dev);
> +    ARMCPU *cpu =3D ARM_CPU(dev);
> +    CPUARMState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(dev);
> +    bool has_secure;
> +
> +    has_secure =3D cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURI=
TY);
> +
> +    /* rock 'n' un-roll, whatever happened in the arm_cpu_realizefn clea=
nly */
> +    cpu_address_space_destroy(cs, ARMASIdx_NS);

On current master this will fail:

../../target/arm/cpu.c: In function =E2=80=98arm_cpu_unrealizefn=E2=80=99:
../../target/arm/cpu.c:2626:5: error: implicit declaration of function =E2=
=80=98cpu_address_space_destroy=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
 2626 |     cpu_address_space_destroy(cs, ARMASIdx_NS);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
../../target/arm/cpu.c:2626:5: error: nested extern declaration of =E2=80=
=98cpu_address_space_destroy=E2=80=99 [-Werror=3Dnested-externs]
cc1: all warnings being treated as errors

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

