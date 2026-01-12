Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1629CF45B2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLTc-00048r-R2; Mon, 12 Jan 2026 12:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLNi-0008Gj-T7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:07:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLNf-0006ve-U4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBoo6m7IMy23LR40vfG7pQLwbyN+6AetktVkWLeu73Y=;
 b=PP78VhDAKmmDqmT7KieV3FpGXzzXuznmV9FxZq6JhJsPZq9dANAWVMdNMnbv6GIN0INiTb
 p1CuHnWml2dkNLoJx3JJMUq2bma2/cS6Rh6gixOxc/tZqg7BkS+SGXHFyV2g085AE7RY/C
 wz23F08BXwcHhdFxHnoi5jLpwGyNo4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tpUV4xebPQGXV6Jqxwv6Ww-1; Mon, 12 Jan 2026 12:06:59 -0500
X-MC-Unique: tpUV4xebPQGXV6Jqxwv6Ww-1
X-Mimecast-MFC-AGG-ID: tpUV4xebPQGXV6Jqxwv6Ww_1768237618
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43009df5ab3so4203942f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237618; x=1768842418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBoo6m7IMy23LR40vfG7pQLwbyN+6AetktVkWLeu73Y=;
 b=FlQcrxEDbwDf6744UwN4QjvU3+zLtmxVqt9/j02/dfndD57E7cxfPM7W34Sy/ltDnE
 K6fMLhfeOvokPtE4nxz45Ve4kgglYmK2+sS4w7uMqMNHxCG0MtJNX5su+h6EKR+PuCv4
 MGJ7dv3dfy0BeA0HMiQDlQoRIv6MfD4xN6YaTCBnibnvH38DPJsfDZIvCE32J3ou5txe
 iyHyCYQh0KbpDW6cO6yRWx0wP3UncssFIlIGnPGMyFfHZLJrjJbjbHElve5dYlCzM+aw
 teKhnkhraaUNtoDLxYxL3+pOieQb5vl+oaRaWNqhoG39MYnslH6Csgvvpcqd1M3YgQ4+
 V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237618; x=1768842418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qBoo6m7IMy23LR40vfG7pQLwbyN+6AetktVkWLeu73Y=;
 b=oMsyCyYIIA1/8WTb3+qufcRyUR+0D1CVRTO9UtDitY8VVH7j9VBVPh4FlgmkACekbL
 aeMYU2ChoJPZyUoxtMgDH3PPUpw0hpkofbQ0Qq/x237I36ZzNooHk+dn+e8fxDBv/JQD
 lohcVThJ2vE4JJ833t+pJvvyfB6Y9AMNcGsQoKjPNR6GgCH4KmuUAKuRZhc4xTZIBpRx
 cD2bn/ffoaGG81m1PVAPs7LAJyX3CMPveq3NEanmkazVeOeSgPf6SrOrP8iRZ7qku2gz
 AhwYdJ6pIoyT9R/1oZrohx2f1kudffw/O3K9o4A/UXyp5rlL1c2pbRNNlbLYakhyE66K
 401w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMWHbkEt2ll0tHm7Bp52TFvQpkwU30j3YbtD+nVe6yneykgoiUZ2xTn3Q84XbrbKzQ2S/pz3wWCRlf@nongnu.org
X-Gm-Message-State: AOJu0YxJPoT59m6sTDji30o9n+CEPykLchHrTy8GpYpHEDAFMR/9Rogn
 e1v3FEtOz1xejkG0bsloJJ1lzabhh42DR0V9Lz8MDd74nu9A4X3sx1/byEaPz/WkchahYNk8SNz
 hGlRF4dfoEl+AOc9+31ekkLbxAwFvQTGnSNoiN2UAeh4xl6v0cjWpVm7vSki0vj3uQxUiyeT8/+
 HXdM+3gk3IlXTHfuYTBxcLn7bTXlmFRts=
X-Gm-Gg: AY/fxX7A7yhkqbgAM3uD+WF9KsgKHCo29/N1JS39rXpixzjx2PxPyFnxTAr7H9Wcj7D
 PO7lFNI5dITQEUjBru+ZFaIVo4xCNvZr20X9Ofpl3dTP8yyRFC7o4vuaZNKnJfZAOABV64EhrSr
 0emRlGDaxqTp2Yja/gItNeVdOJqPA3Bm0Q0emYJLvNri2oG3Hp9EuzNB/UZXl+J/mN4+9trUES7
 ifA0QJaPdBTqzqkfpdmuPHaVKyntCNgBPr1wDKlZkRcSHLyzCKWOiZn3AN/G0eJyM5q0Q==
X-Received: by 2002:a05:6000:22c1:b0:431:74:cca with SMTP id
 ffacd0b85a97d-432c3760fa1mr22065002f8f.44.1768237618306; 
 Mon, 12 Jan 2026 09:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm9OyhUvJ/5tUgFBnEaYolWB7ojG8NUI0rgwv93Koj3Oy8wKMKoCPOddM8tV8UWQEAtNcjHKPPtW9NB6jl3xM=
X-Received: by 2002:a05:6000:22c1:b0:431:74:cca with SMTP id
 ffacd0b85a97d-432c3760fa1mr22064963f8f.44.1768237617853; Mon, 12 Jan 2026
 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-10-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-10-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:06:46 +0100
X-Gm-Features: AZwV_QhRbtEXIYgzH3mUULZBtcxNLpl5sTrXkpatJBwfOPGAYrsyvIbiYt31Gpw
Message-ID: <CABgObfbptgbn7qD4ZzQAmznupU9Z_dwgnPgXadDU0akt1d4Qpw@mail.gmail.com>
Subject: Re: [PATCH v2 09/32] kvm/i386: implement architecture support for kvm
 file descriptor change
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>  int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
>  {
> -    abort();
> +    Error *local_err =3D NULL;
> +    int ret;
> +
> +    /*
> +     * Initialize confidential context, if required
> +     *
> +     * If no memory encryption is requested (ms->cgs =3D=3D NULL) this i=
s
> +     * a no-op.
> +     *
> +     */
> +    if (ms->cgs) {
> +        ret =3D confidential_guest_kvm_init(ms->cgs, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
> +    }

Most of the code here is in common with guest startup; please extract
it out of kvm_arch_init() and into a separate function.

There shouldn't be many ordering dependencies, if any. For functions
like kvm_get_supported_msrs() you can add a "static bool first" to
ensure they aren't rerun.

Paolo


