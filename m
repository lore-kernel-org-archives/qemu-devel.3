Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C12EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 14:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp5pL-0001Ef-UJ; Sun, 08 Feb 2026 09:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5oj-000146-Mp
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5oh-0003RK-5e
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770561074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQoTHTzvToYijZQuW5fGpIXU4ZHdk5Iq8EPMJdaOoGI=;
 b=S9Icn7c56u1cUe/h9FufxYyXD09QNTfIikdfhTQ2JTfyKdZiKD44UX9NEtqtRMOdbqt7Ym
 sn1vuXXTTwdOo7TREM0lc0tSMtCpq17AFKwsO0veDmI+C0A2fpnVvJkwgPQQTo66sxjCmL
 U3enY+wcHmCm3S6RB7sQuVTA+EspNIA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-jfcqMBDSOEuPDl3TfofNwg-1; Sun, 08 Feb 2026 09:31:12 -0500
X-MC-Unique: jfcqMBDSOEuPDl3TfofNwg-1
X-Mimecast-MFC-AGG-ID: jfcqMBDSOEuPDl3TfofNwg_1770561072
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89700915423so1321746d6.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 06:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770561072; cv=none;
 d=google.com; s=arc-20240605;
 b=Mu6UjGMlhCXnalWQYVUAtHEWJo7Xzzw0NdEXx99qh/F1heA6JzeWZiBskueRWMR/ya
 G/U3KSNPVXYijHmMvOz/omAZfkHNVRqQihcaTOjhwX589teIhTjL9nX292ljI6dw6jh7
 mKdd9fAGAi4Vy5o6/m9tDw8JRVcdWOqLWbbMCE0WTcBrbr2i8lRs6pIdeQMOqHsjtKtm
 oe39iNlCku8c8jQxQ6LP0Bc031u2xbsrcLAHnje/OX3AYrvOC/AeP/S+dTYMV3+jL2z3
 zO/9ohtpASMhrVRJcipIBM3vOuC9yA20DkpNBzR81A1UZRL5yfldfrScxV80A7OoF7CU
 g6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XQoTHTzvToYijZQuW5fGpIXU4ZHdk5Iq8EPMJdaOoGI=;
 fh=piu+6brl6TU2Li4gyn2/J+c1VgYQxD8PmuPy7Yh/+R4=;
 b=WLN8MkoWgdC2It74mcxv+kfszRhRXK6QCGfb67Ga0LzJp9XVBBM70Z270h8+1lRc7v
 DOb3jSv8TbuyzFG4GAPvgggPI6oyjFcyNcu/guK8kzMHVKJ3nibr2VD5bfePftU2Nhvb
 7EhaJdLJ3KrHyIgREyQ2UdeuVZcN8Jyizpvpr8+ggqDG5yIGJHgntWU6pEQLMcAQbFVm
 nyZojdwC/Kfkdf5F/HiH9pZJOYuiz2Tw9SvpBfPkmtD/EsXLPD26bGPBUo+4sSvBMX2/
 QLrFxbBXlKvtCh2jWOwxSbuEt6oqJ3GNVGVbbY7ou13JWmylQUUHBroGJnY9xBtPKmVi
 ndFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770561072; x=1771165872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQoTHTzvToYijZQuW5fGpIXU4ZHdk5Iq8EPMJdaOoGI=;
 b=qH4j48+8SsBuPDZpL5TCdmzlc8V6t6mokAG/WTVAugk65r/UHsx+lHmmc73iGdHzvn
 qrkwc0yE2kAEfhHQGQJQLxM7qCimh8aR0G7tudDpZN/vYIaGd4WojjTLSS1Thafoz+E0
 6tZomtBeZZak8xgD+j/Hs8+DzIF/HVQGeE0ZhmGlK+ZrngcmhxZWgEy2HvoEEz5qb5mI
 zbYpqHVKrqgEIX1r4SbQhnfSwJLJ4AfJg0ryTQzyCSd7kLATkBh/6d68Tc/k6fit4M69
 1OW3G+bY0U3tEI7Ho/OsHy5P9shSI8a0GNdJdn0k9yMFp5BHsvfjB7IfvJ+vHoN5AXL+
 57+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770561072; x=1771165872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQoTHTzvToYijZQuW5fGpIXU4ZHdk5Iq8EPMJdaOoGI=;
 b=swp3hd2JJlxi8nDuWQ1Vqk61jfV4F/cuuK4c6z43ecJ/HPNUIemOzI2rJYEPziWmy9
 SJO/flwra2/W5PHY8pDSi/ANVyzgf7Hsnqx8oV29rATyts6Vg2ywG75PSKOozJj/QA1Z
 2jjBtVnYfGIJAawRwJtKwhGuNUubuKtOajiT2l9FJMIK/n+f/tGUiCjtSyMwN0hgjdjT
 APZDPzsMz2NNkLBxTmFAhSXbN8sDbfT+YhBMw4sGso4n8usyRT+EZFm6WJkvQXXWtmR+
 pPzgb5eGVrOQpYKC2xzWH4CT6gtcqw5fR43nKVGiAOKAOvGckHh/y5MKsho+N/ywXoFA
 Ubcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiOqehVMJiTWzlZFWkstLQtCaBwqyVdlmzO7DM/l5Wqvr8UJ4A/TG5fbEG320Y87VXj/i913JGbeBt@nongnu.org
X-Gm-Message-State: AOJu0YzdldFQwQvCEp82lvCtkEBVCt7I0KS75pNuzaQvldVr9wdiU4mv
 S/a8eN/GA5vnc2l4maRvZzFzqmuW29yQKUzdJOYyVK1SVexI20QTV5g4SJ69G7UhWrL/3KXYSIu
 wYH85r6YHnQDlyb7oFiVK08yeSJsaH9t0IJ7BqkSgQhb/Dgy/sh9SPsRS5lrmowe/DNFd0yA3Tc
 v6UZCk3hISh8UC8RY3ngFAYBH8IDZzFTc=
X-Gm-Gg: AZuq6aKJlafMDu5foHOXD7EfNAd4N3YuWpq9DShtGfyyDnzT7Ms7EkrXJGTvRiRFCWr
 KRemcTEebi3Bjh9KrHf4OsfPwBIy55Qxoxh3bdwaKYpBwh8Nk/PlE85fkNxxlwELyaAKgHpBezg
 jykIiP5iTwqWHlBu+JlIOZd5gG59h6cIJ7uk5nZXIL5RCN+FKcjmLne21O58cYZ10UVFpBxa8HK
 AnbImCuaE/Jk3srOPPyppAg+0gZ
X-Received: by 2002:ad4:5cad:0:b0:880:498e:a63e with SMTP id
 6a1803df08f44-8953c7d788amr129445166d6.2.1770561071979; 
 Sun, 08 Feb 2026 06:31:11 -0800 (PST)
X-Received: by 2002:ad4:5cad:0:b0:880:498e:a63e with SMTP id
 6a1803df08f44-8953c7d788amr129444606d6.2.1770561071579; Sun, 08 Feb 2026
 06:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-31-anisinha@redhat.com>
In-Reply-To: <20260127051612.219475-31-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 8 Feb 2026 20:01:00 +0530
X-Gm-Features: AZwV_QgvFXZYlH2YxUDbMJicu4ndc9UHhhFkw7si3R-9xZcChwKCX8qrXj6wdDM
Message-ID: <CAK3XEhMr2pPe_QcE+C29_+Ew3kHfgqEEVEWB0RGLL41NfV_Q=w@mail.gmail.com>
Subject: Re: [PATCH v3 30/33] kvm/i386/apic: set local apic after vcpu file
 descriptors changed
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 27, 2026 at 10:48=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> Once the vcpu file descriptors changed after confidential guest reset, th=
e
> local apic needs to be reinitialized. This change adds a callback from th=
e
> vcpu fd change notifiers to reinitialize local apic for kvm x86.

This change is not necessary as kvm_apic_reset() does the same thing
as a part of the reset process. Will drop this patch in next spin up.

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/kvm/apic.c              | 13 +++++++++++++
>  include/hw/i386/apic_internal.h |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
> index 82355f0463..f6f8ac2764 100644
> --- a/hw/i386/kvm/apic.c
> +++ b/hw/i386/kvm/apic.c
> @@ -229,6 +229,16 @@ static void kvm_apic_reset(APICCommonState *s)
>      run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
>  }
>
> +static int apic_vcpufd_change_handler(NotifierWithReturn *n,
> +                                      void *data, Error** errp) {
> +    APICCommonState *s =3D container_of(n, APICCommonState,
> +                                      vcpufd_change_notifier);
> +
> +    run_on_cpu(CPU(s->cpu), kvm_apic_put, RUN_ON_CPU_HOST_PTR(s));
> +
> +    return 0;
> +}
> +
>  static void kvm_apic_realize(DeviceState *dev, Error **errp)
>  {
>      APICCommonState *s =3D APIC_COMMON(dev);
> @@ -238,6 +248,9 @@ static void kvm_apic_realize(DeviceState *dev, Error =
**errp)
>
>      assert(kvm_has_gsi_routing());
>      msi_nonbroken =3D true;
> +
> +    s->vcpufd_change_notifier.notify =3D apic_vcpufd_change_handler;
> +    kvm_vcpufd_add_change_notifier(&s->vcpufd_change_notifier);
>  }
>
>  static void kvm_apic_unrealize(DeviceState *dev)
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
> index 4a62fdceb4..ffe5815e7f 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -189,6 +189,7 @@ struct APICCommonState {
>      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
>      bool legacy_instance_id;
>      uint32_t extended_log_dest;
> +    NotifierWithReturn vcpufd_change_notifier;
>  };
>
>  typedef struct VAPICState {
> --
> 2.42.0
>


