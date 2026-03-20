Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378AA108B8F7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3YKO-0000O6-TQ; Fri, 20 Mar 2026 07:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3YK3-0000NY-UF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3YK0-0000KL-6O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774007237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muv40qP67JJsCRSxR5C9KfSi4xOJ2xQiuCPI3KypT+w=;
 b=gmENdg+0NPuG4f3N1oUs+7ZNrBgC4kJuD+KQXVeDBvYvJzt3/5ZLgU3G6qIYj5W/EP0wAm
 hLfJFUGSJIYVDvwYuN7VfJQqcOqmHFyF8XfJO7R1fTXuwDt+0qphIUZV/akb0vW5bHvxZG
 YuWmgUzI2YNjYA3nJ4iPDFdW/hASFpA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-tdrln-5ENWqpBE046tFUTQ-1; Fri, 20 Mar 2026 07:47:15 -0400
X-MC-Unique: tdrln-5ENWqpBE046tFUTQ-1
X-Mimecast-MFC-AGG-ID: tdrln-5ENWqpBE046tFUTQ_1774007235
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c4a339b6bso175048006d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774007235; cv=none;
 d=google.com; s=arc-20240605;
 b=bVeI1K+40FmJlFPnP+n4l6p0duKlNz4P/oZV4+TqRoI92IrCHsDnb1PISU/WR0wd6c
 b/WQWkE24IVJbiEsZ0oHhLritlUTG82qGwpTYo/89photYPR9dBApNzZ3Wh9mKtL52AB
 EiCwwab5XuNi80DI6fR8WKigK4r0r+uKUu4zL0hMZtCEhlfXRGhTvB/nTloXLv5Ayykl
 i6XGHhnN/shcg4FWaK8Vrj2VxurPjrRCFa/YERfs3C/KJrW4BQmp2JO1s5ImUW+JspYl
 9SAT2mG5jr67NsMkz4suOCo31ANWJlW/JjgOJ72kfvrz09aOf8UoxID+81+/AWXNkOht
 6RhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=muv40qP67JJsCRSxR5C9KfSi4xOJ2xQiuCPI3KypT+w=;
 fh=cOPXiLCTVAYpBUbQS6NaQFU8Q0I0efwJyFRhAa/O0mc=;
 b=DEZpXSQUiGs6ECN5gdBKg+tRGf6rrx25G/HjNfVb3hgBVtJh/wg8k4Zg5PkMl/Ue/J
 Yc96MvAt4yYD6UPmjYb3UjRpOdKhMTunX3+qs4bFbqRiTMFbbOzNqA9rTwqoas9PRFnN
 83T4aFM61roTGfdDsVbFG09fMA7GG7TvSG5BDRCTS1sXEqOyHRW5GKbuHpfn64U5ju+m
 2cQAPigCK2Gk8tgoJ5TQZp3AbsW3BqAbRlJhjBR+49hkzJOcks2raUGxBxuT882Y184V
 +Xlcpu62eGL8P15Nktg3tpMfRlXymze072R5AinY3k5T+9FWW74+WLldV6XOR5/N+NQm
 7Lfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774007235; x=1774612035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muv40qP67JJsCRSxR5C9KfSi4xOJ2xQiuCPI3KypT+w=;
 b=QbTnDNCf7crAKaOVH20YY6YeHiGaOJoUX2/zqoFhRubCHKxLhI+pRaGZMagDzS2IEE
 2BqEVrP220D9uT+VD53UOy745GHXJd5v9/50JUB3ZBJ1quRn6YQ+l8qpeMVk0DqmSJWt
 N47RjfixqjRv0SHySpij9ESuHiciZB0HQ+faQGIZ25j3csF659IVwRsgC75A7YpSvr4V
 gJ8Osox9aQf25lZDLlGMOS6hCxjB5Cc9pH3bSIqXk7CLUU6VBoAg8yJ71EGAHHX0Hbd5
 rE5ZZjAcg34JVxBrzguvZBp4c36lUwxQaAKfGPAVjG/o6aLWm1lDhkoWGlmliTMoOAdL
 X2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774007235; x=1774612035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=muv40qP67JJsCRSxR5C9KfSi4xOJ2xQiuCPI3KypT+w=;
 b=rdtAY9LVh7Ho+57UyiWFhRdTw977MuJU63j6AnJx2qlxGjH467W33qXLb3I36f2jns
 ynGf+MRxDAV/f+nWmY03KzgIM0q0O6OtiFVOv/uuL/Sn6uZE67Pjgy4wLMTxFU2LHEy6
 gocmw63uImKlaZJYtEePMcgtJWUwdsR48IUyi2mcRtyr0hLG8NNNj5bnYUzhBU4yufZm
 6UWPD3UleGLT/hXDY5cjQ2alY+NEhVCWZOf+c10fbZEdTwzLe/pyvJRop8n0QayqW1Wz
 gtMpLqU4sNdU9SwHAX/PN1d+b1f8NYMPt3+ykIESJhn6nHDyZafvknUav5Fzzt3B83mM
 W2oQ==
X-Gm-Message-State: AOJu0YxP6DxTzSrd70Y9suHHxPt11E9T5NLT52Hn6IiXGH27EnMRhcym
 pZosASWoiNmN/MXFc127JQ0ba74s7f4EjUxcsQBCjXDa5MJpTOb09yqh6BWAyfjxnJKk4mvrfzx
 fpR74bSK0O4ajAWPk+zFBd8o9ifE+BfYLqUuSeZZrIQgUAUaSkhD4S3FxTCOY7ZITYaO31bxxBo
 M7Inr1rL3t+ciBPFAWyvqhRugonSzmOJg=
X-Gm-Gg: ATEYQzyzE3phJIjk8DfqmPSclGogq/S41csm5XoghYn1SsTFhZ1gv+aZ4aR4NvZrv7+
 0euQoYhfHEoAoR0YHOm6O0wQE6GEsvBYajqj5rYdCzK4ykFkagP79/lr8vPFrV6IknvLtnOpH5e
 +NatvKwbsPpd9uvJhxGRKvyuxxRQzNdwb368YnfWUWSgOOG9ZOsaShpIhgWp3WVTZPA8kYzWYvW
 0b56+mzAFODS3LF2sAr+kgtcT/4a85o6ylcI2fLhobiY5xc7uvzk9wg46cX7wpEgqHyPevq
X-Received: by 2002:a05:6214:cab:b0:89a:45c:bb65 with SMTP id
 6a1803df08f44-89c773e1b57mr105258806d6.12.1774007234659; 
 Fri, 20 Mar 2026 04:47:14 -0700 (PDT)
X-Received: by 2002:a05:6214:cab:b0:89a:45c:bb65 with SMTP id
 6a1803df08f44-89c773e1b57mr105258426d6.12.1774007234193; Fri, 20 Mar 2026
 04:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260320104953.67351-1-souravpoddar93042@gmail.com>
In-Reply-To: <20260320104953.67351-1-souravpoddar93042@gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 20 Mar 2026 17:17:03 +0530
X-Gm-Features: AaiRm516rjfW6TpBEGlo7HKKPLUSIdVQ4EXj_NPhVKnQoy5xd0GRQ3gfM-7km2s
Message-ID: <CAK3XEhMg317QPAE+wJswyr0hvJ4kKKm7cXUh8MM8StXPguZNbw@mail.gmail.com>
Subject: Re: [PATCH] hw/hyperv: fix SynIC not initialized for CPUs after the
 first
To: Sourav Poddar <souravpoddar93042@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 4:20=E2=80=AFPM Sourav Poddar
<souravpoddar93042@gmail.com> wrote:
>
> hyperv_is_synic_enabled() is a global flag that returns true after the
> first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
> hyperv_x86_synic_add(), leaving them without a synic object. This causes
> get_synic() to return NULL, making hyperv_sint_route_new() fail and
> triggering an assertion crash in hyperv_testdev.
>
> Fix by introducing hyperv_is_synic_present() which checks per-CPU
> whether a synic object is already attached instead of using the global
> flag.

You may want to rebase this on top of
fhttps://mail.gnu.org/archive/html/qemu-devel/2026-03/msg05998.html
and then fix hyperv_enable_synic()

>
> Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its no=
t enabled")
> Reported-by: Xudong Hao
> Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
> ---
>  hw/hyperv/hyperv.c         | 5 +++++
>  include/hw/hyperv/hyperv.h | 1 +
>  target/i386/kvm/kvm.c      | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 27e323a819..ff53cbc699 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
>      return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
>  }
>
> +bool hyperv_is_synic_present(CPUState *cs)
> +{
> +    return get_synic(cs) !=3D NULL;
> +}
> +
>  static void synic_update(SynICState *synic, bool sctl_enable,
>                           hwaddr msg_page_addr, hwaddr event_page_addr)
>  {
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index 63a8b65278..23091301d0 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
>  void hyperv_synic_update(CPUState *cs, bool enable,
>                           hwaddr msg_page_addr, hwaddr event_page_addr);
>  bool hyperv_is_synic_enabled(void);
> +bool hyperv_is_synic_present(CPUState *cs);
>
>  /*
>   * Process HVCALL_RESET_DEBUG_SESSION hypercall.
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a29f757c16..f5faf32606 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1754,7 +1754,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>              return ret;
>          }
>
> -        if (!hyperv_is_synic_enabled()) {
> +        if (!hyperv_is_synic_present(CPU(cpu))) {
>              ret =3D hyperv_x86_synic_add(cpu);
>              if (ret < 0) {
>                  error_report("failed to create HyperV SynIC: %s",
> --
> 2.53.0
>


