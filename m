Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F233E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 10:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUKH-0000BA-VB; Sat, 28 Dec 2024 05:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUKG-0000Aa-NB
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:45:44 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUKF-0008Pg-1Y
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:45:44 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5189105c5f5so4105735e0c.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735382742; x=1735987542;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5azlLYHnLDjP1jnyhLJZwgNVop4nhsKTUbAaAFN2Frk=;
 b=Og8TQ0vfU9EB0ch6pti7uJ3vevWLllVEbiNOtzoA/UzkWMR82gP1WqiM3aMEIT8Qn8
 84unTOkh3WBrr0Pi2ud0lAIFXyFcZ4uVtJgknhIK8cPGcSetcnZ0PI4XzNkfW0o6yEvX
 owuVwxXnATA/9mpdYZRiuDe9geextYX9s7cDQWtdsNImaLEmzSv8s55ddB2I7HqhTKAV
 fo4NdXkX6ywLsBjHGZTt57FiHk6dvZrFXe+Nu5OnODcrNQrl0JiaCMlOf4sU9KeG8H6R
 q2+llErTJbwG2CAqK34/7msQKuM2Wt/kjW0cmkwxEEDIK8X4KyM/xNLflCRLIkc72Cme
 d0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735382742; x=1735987542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5azlLYHnLDjP1jnyhLJZwgNVop4nhsKTUbAaAFN2Frk=;
 b=B5ix+KuokMH/kLE2LMsr4+DgcitegMxwJapT47VLJOmS+xDyq9HWpTtJuVTdwLdq6P
 tF1MAol41dsIS7JlF5P0YD9LdUEfefQo89EjQjvqLSAnbGc77gJLrKJCYMPB1nUUZI95
 w6hegyTNx2cf9LnWaHJwVUThKludvHrnPLjHoagx941n+I483vH++0JrFR2+nY4Z459s
 bQCgim7VrpN7yggjblHqZTqcmD8DlSlbK7hshBkKAWNitl9CGpKkaIpg14Hbz/qI0Mav
 96r8jSpymPB2E0hqs1I7GOxwsqzrGlGpzm+gBzSXpiECn9C8REyG9wuUOk4hdFfZLVBT
 r6UQ==
X-Gm-Message-State: AOJu0YxQWBaUG86XvmbVy2yyGMqm+FV+moaT7vfQLQG7oB4+8Isgyh+W
 HS7NNl7k0VP4Wiiw+BBx5huWIwXU8PnFcGJbNnXt5vTyIAgiFe7uWnucBUBHFC9mq3wtzS80L52
 kPONnmvDfouvMniFqnhasKbXcCHfz2+qtpbPe
X-Gm-Gg: ASbGncuLk3b9epRuAM27H17pkqppeKRivlQQrlvRcNW7kJugwrXADkrVlpwSGpBcxyu
 EANKvm4xziywojfn2mBIjnXCjMFQc0Ua1mlciOA==
X-Google-Smtp-Source: AGHT+IFJBmaLRhdxETrJVHol9qHXGnJ7pOObKeD0EtPe0EQ6n0ArUMfSeBo5eFiiEfjAYaBoJT3+FmccsDppyRU2AVE=
X-Received: by 2002:a05:6122:4884:b0:518:89d9:dd99 with SMTP id
 71dfb90a1353d-51b75c2a515mr25220060e0c.3.1735382742071; Sat, 28 Dec 2024
 02:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20241227202435.48055-1-philmd@linaro.org>
 <20241227202435.48055-2-philmd@linaro.org>
In-Reply-To: <20241227202435.48055-2-philmd@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 11:45:31 +0100
Message-ID: <CAAibmn2EJbAEtW8dZz8ZtcN+D4tEq23zSooVZOdqQfG6P4PbOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc: Remove TCG dependency on ARM_GICV3
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e4149b062a52471d"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000e4149b062a52471d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 at 21:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> The TYPE_ARM_GICV3 model doesn't have any particular
> dependency on TCG, remove it. Rename the Kconfig selector
> ARM_GICV3_TCG -> ARM_GICV3.
>
> Fixes: a8a5546798c ("hw/intc/arm_gicv3: Introduce CONFIG_ARM_GIC_TCG
> Kconfig selector")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  hw/intc/Kconfig     | 6 +++---
>  hw/intc/meson.build | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index dd405bdb5d2..7547528f2c2 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -23,13 +23,13 @@ config APIC
>
>  config ARM_GIC
>      bool
> -    select ARM_GICV3_TCG if TCG
> +    select ARM_GICV3 if TCG
>      select ARM_GIC_KVM if KVM
>      select MSI_NONBROKEN
>
> -config ARM_GICV3_TCG
> +config ARM_GICV3
>      bool
> -    depends on ARM_GIC && TCG
> +    depends on ARM_GIC
>
>  config ARM_GIC_KVM
>      bool
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 510fdfb6886..602da304b02 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -6,7 +6,7 @@ system_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
>    'arm_gicv3_common.c',
>    'arm_gicv3_its_common.c',
>  ))
> -system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
> +system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
>    'arm_gicv3.c',
>    'arm_gicv3_dist.c',
>    'arm_gicv3_its.c',
> @@ -39,7 +39,7 @@ endif
>
>  specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c',
> 'apic_common.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GIC', if_true:
> files('arm_gicv3_cpuif_common.c'))
> -specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true:
> files('arm_gicv3_cpuif.c'))
> +specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true:
> files('arm_gicv3_cpuif.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true:
> files('arm_gic_kvm.c'))
>  specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true:
> files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>  specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
> --
> 2.47.1
>
>

--000000000000e4149b062a52471d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 27 Dec 2024=
 at 21:24, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.=
org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">The TYPE_ARM_GICV3 model doesn&#39;t have any particu=
lar<br>
dependency on TCG, remove it. Rename the Kconfig selector<br>
ARM_GICV3_TCG -&gt; ARM_GICV3.<br>
<br>
Fixes: a8a5546798c (&quot;hw/intc/arm_gicv3: Introduce CONFIG_ARM_GIC_TCG K=
config selector&quot;)<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
</blockquote><div><br></div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a hre=
f=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>&gt;<br>Tested-by: Ph=
il Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.=
eu</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">---<br>
=C2=A0hw/intc/Kconfig=C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
=C2=A0hw/intc/meson.build | 4 ++--<br>
=C2=A02 files changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
index dd405bdb5d2..7547528f2c2 100644<br>
--- a/hw/intc/Kconfig<br>
+++ b/hw/intc/Kconfig<br>
@@ -23,13 +23,13 @@ config APIC<br>
<br>
=C2=A0config ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
-=C2=A0 =C2=A0 select ARM_GICV3_TCG if TCG<br>
+=C2=A0 =C2=A0 select ARM_GICV3 if TCG<br>
=C2=A0 =C2=A0 =C2=A0select ARM_GIC_KVM if KVM<br>
=C2=A0 =C2=A0 =C2=A0select MSI_NONBROKEN<br>
<br>
-config ARM_GICV3_TCG<br>
+config ARM_GICV3<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
-=C2=A0 =C2=A0 depends on ARM_GIC &amp;&amp; TCG<br>
+=C2=A0 =C2=A0 depends on ARM_GIC<br>
<br>
=C2=A0config ARM_GIC_KVM<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
diff --git a/hw/intc/meson.build b/hw/intc/meson.build<br>
index 510fdfb6886..602da304b02 100644<br>
--- a/hw/intc/meson.build<br>
+++ b/hw/intc/meson.build<br>
@@ -6,7 +6,7 @@ system_ss.add(when: &#39;CONFIG_ARM_GIC&#39;, if_true: file=
s(<br>
=C2=A0 =C2=A0&#39;arm_gicv3_common.c&#39;,<br>
=C2=A0 =C2=A0&#39;arm_gicv3_its_common.c&#39;,<br>
=C2=A0))<br>
-system_ss.add(when: &#39;CONFIG_ARM_GICV3_TCG&#39;, if_true: files(<br>
+system_ss.add(when: &#39;CONFIG_ARM_GICV3&#39;, if_true: files(<br>
=C2=A0 =C2=A0&#39;arm_gicv3.c&#39;,<br>
=C2=A0 =C2=A0&#39;arm_gicv3_dist.c&#39;,<br>
=C2=A0 =C2=A0&#39;arm_gicv3_its.c&#39;,<br>
@@ -39,7 +39,7 @@ endif<br>
<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_APIC&#39;, if_true: files(&#39;apic=
.c&#39;, &#39;apic_common.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_ARM_GIC&#39;, if_true: files(&#39;a=
rm_gicv3_cpuif_common.c&#39;))<br>
-specific_ss.add(when: &#39;CONFIG_ARM_GICV3_TCG&#39;, if_true: files(&#39;=
arm_gicv3_cpuif.c&#39;))<br>
+specific_ss.add(when: &#39;CONFIG_ARM_GICV3&#39;, if_true: files(&#39;arm_=
gicv3_cpuif.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_ARM_GIC_KVM&#39;, if_true: files(&#=
39;arm_gic_kvm.c&#39;))<br>
=C2=A0specific_ss.add(when: [&#39;CONFIG_ARM_GIC_KVM&#39;, &#39;TARGET_AARC=
H64&#39;], if_true: files(&#39;arm_gicv3_kvm.c&#39;, &#39;arm_gicv3_its_kvm=
.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_ARM_V7M&#39;, if_true: files(&#39;a=
rmv7m_nvic.c&#39;))<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--000000000000e4149b062a52471d--

