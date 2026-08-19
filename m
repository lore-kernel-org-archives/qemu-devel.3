Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F5BC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwo1V-00036B-K0; Wed, 19 Aug 2026 17:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwo1T-00035o-TU
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 17:40:35 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwo1S-0006NP-7G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 17:40:35 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-836cde02992so20986197b3.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787175633; cv=none;
 d=google.com; s=arc-20260327;
 b=TwqOm/cnPDUTIiVxSWlssff5nG5QAoIOQtGIAnKkjktjaElv1J4i0qZSvdz2FMDnax
 AgDVeJNsBPn4+gdcbs6ZN63CUOzq2GIWmGef+/YzdiB6noZSXZBcUpWKnE/51CovdZo4
 HAFDYzO3CG9u6urIy/Zkg2J54nTkLtxHsT3QAtb3GD3TSI+YvjC5aGR45fJXa/oX0xiI
 k/8Tgy3i9Ll7DQ1W2w3pJm2pRXSzssJjgyNaHXP+Z/OeVnrt2BwagtxQZIb66lH0xoYk
 +jHz0MDKUFgJAJakzUYNCObR8ssuKkYmd+YaunGuApcGtD0ZkZ7dWQYwLYr4tLH9+e3r
 wgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NVZGIHVHY9chGR1zqG2Nxdcreppw/R5t6obXfGi4NcM=;
 fh=RynG/mh6ztmyNhHf+Vf0XiFWhmNfp0mSdDXdPqU/75o=;
 b=AdJCb1XDj9cex+l1Q3NRr33ET62FNDVKAuA+fLTiBtdeVj97drxqMTVv+AR8EMNtVm
 oeDQkDK1+bLMge9cQhcBMO4DHqEXGjfSCskg43Lyi3olJBMFsCbCjLtL23cW9sRrtr6Q
 R4d2nyTPih6GGbutmgMCuXUrXetRem4REDkZLUvB+om9itCgMt6A+LHAnOuZlJ6E2YH5
 IqXi5oMYGiSwm5YCmTao4LHwcl2Q/VMwbZ/ncN+hdEWKjisSlQNSM+2m4vamePBJ1pmJ
 mIKcKUf9V7r6D6Ke9BJX6nx8JFDaCdagvQ0v7DvIAVCO8kHbAii/8+DeViyLV2+BBirX
 tHSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787175633; x=1787780433; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NVZGIHVHY9chGR1zqG2Nxdcreppw/R5t6obXfGi4NcM=;
 b=FsarPCYBQ1SrtXAk0TUkjWRaid/InLh3yy931Bix9jai4CgeuGv+xqys7GGZ4SC9OJ
 4pcxt8fVppGIurVP96hLY4h2DKzhVfluEDhVgAP1v9LuLlJnyWlXJy4KHHBY1zWg9nAw
 IDBl6bXd4BwaBudF/WPTL/6NBFlHbpDGUkkHe4jcqY5qjNsZUVDsYXHw2/TA1acQqwtV
 zaGmmYqqVPwJj8f4ovxVTpR/ViuzHpTSPFJeFJeLU91qVjPwkNNuGe6wF1zb0SdZhamR
 IiDqaMEePRDOyW5y1j82t+oLyIaqfa4j9whD0nRrltG1qYY6MdBH52+WJLPwCR1c7QC7
 ieNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787175633; x=1787780433;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVZGIHVHY9chGR1zqG2Nxdcreppw/R5t6obXfGi4NcM=;
 b=NDVkWLeyezApQiuPYvXmbuMXfpkjm5bnvZEUCujPvHygx3HEaj4R8ED/ogaQM22tzQ
 s3qhaPquSgtp1m0c5d92Z7HZYUVOQGplS7CC+zwvbug87Lshv3mMcBZKU/1ffX5bSTiU
 /J6gJHbgKOwEx20FWlk5nDDZl7MNgzswr2IzXD/FVdHtw6jkhCUgdGW9WYKE/co2qbyb
 ImnIDoO9td0nQZxdwbeBY3JcZkfpAChdcHCLu+FcljEKC1leVlS8SXZZBNgpJLAwaU5g
 l7DgDukr61fmfLWvgRBLXKKCop3IQg95ZJCj/XBdbWOQwbZRNywdwadZgxLL83T+OY3+
 m9cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUUIatvdRh7ifqgImlUAb5/Di5LdTFWFs0OMv8Z49A++77KtYiq6SZaMcCxW6z2LQVNe8MQ2qwyIEa@nongnu.org
X-Gm-Message-State: AFuF++nt0heLyNsdeHwCWhYgoPRaD5oh8JkA0202jOiNRGyTMBy2+LAE
 ToyVyNycJ58twsU+Inv5F8IZdsBmzOhKsJQQjR/hEvgzpZR6v6WHKTs8X6pG0y5f0SOiY371S9S
 KnCNiV9FEqho3zcokg4KGmEpSAU+AE81z0Kl5V6z0OA==
X-Gm-Gg: AR+sD11ljLnqHt9jEWSAySfncxn7I/6r7YvJGFb0oUZ6PZbPq88WxnqHv/IxRQas1EX
 uYLBz8B6eNfndWXihrIOJxNqWOJhNZxq1yFHOTMO+fbL5ESEaz4B6t+9nxBzw7Zkq/TXynQf3z+
 wl5jsnyHhl0duOVFhGKwFKXajTEi8vBfc+cLYdsplpSd7Dm8MqcYuGccGXFMdz4xZut1v9xC9iN
 649dZ+voNl2cG4YRbMFnxQ8k8INEIVsLLOiuoKIgT8IXbvkPKsD3BPI9c0g9Bj1tiEU2X3PcgM2
 HROFUvov7sRmSK8mt2B8Zmhw7MvpV+v3WDG0ZaK2w/XKPXBKX7GV2RD0GwhmlE3p72h4gz2dtih
 s+GJX3tjSxWOS8Nnm4XtRFDQrsI9y82iHg4SFtqk=
X-Received: by 2002:a05:690c:4b82:b0:820:1251:d2c2 with SMTP id
 00721157ae682-844e250fe23mr30942807b3.28.1787175632764; Wed, 19 Aug 2026
 14:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
In-Reply-To: <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Aug 2026 22:40:21 +0100
X-Gm-Features: AcwNN1VZzrghe4g4FF9eAZkIAC11VMYm1kyn-5715IuzotZNaZMavujrtS9KpK8
Message-ID: <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 19 Aug 2026 at 21:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/19/26 07:56, Philippe Mathieu-Daud=C3=A9 wrote:
> > Refactor the target-specific halt-to-execution transition
> > logic (disable WFE/WFI timers, clear the halt_reason flag)
> > into a separate arm_cpu_transition_halt_to_exec() function.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >   target/arm/cpu.c | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 77aa78f00e2..8e9b584559d 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -870,18 +870,26 @@ static bool arm_cpu_internal_is_big_endian(CPUSta=
te *cs)
> >   }
> >
> >   #ifdef CONFIG_TCG
> > +static void arm_cpu_transition_halt_to_exec(CPUState *cs)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +
> > +    assert(cpu_has_work(cs));
>
> In reply to patch 11 you suggest removing this.
> I wonder why you added it in the first place.

Does the accel loop enforce that we hold the BQL when
arm_cpu_exec_halt() is called? If not then the assertion
is racy, because something might get in and e.g. lower
an IRQ line so that cpu_has_work() is no longer true
(which would be fine -- it just means we made the decision
to wake up and that won vs the incoming interrupt).

On the one hand, if we don't have the BQL in has_work and
exec_halt then we should be a lot more careful about how
we code them (e.g. use of the right kind of atomics, and
there's no way the call to do_interrupt_all() in the x86
exec_halt can be safe without the BQL, surely).

On the other hand, if we do have the BQL in exec_halt
then why is the x86 implementation explicitly taking
the BQL when it calls apic_poll_irq()?

-- PMM

