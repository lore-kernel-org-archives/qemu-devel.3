Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5AACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcc0-0007l0-K1; Tue, 13 Oct 2026 09:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGcbv-0007kB-IO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:32:08 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGcbq-0005jm-Rr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:32:05 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ab37e44643so17819197b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 06:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791898317; cv=none;
 d=google.com; s=arc-20260327;
 b=iODZpYRzJAMGG3YGJ923XFcU9meQh/pHG1FbEBIsiVWXksH3tCMdt9LQz0D/oxmVAb
 HPr3O+ZrK9JCcM96kCsQ1awC22EO27WyXLGJ0wYHPXdg4UvWcFighLsTExOlO747XuKA
 Az81baXezhmWQgHP+/jQk9IQHAl/YoDxgs22DATkeP5Z6EPPWmlZ4wEgBeq7V4gRo8FS
 b4JEbIWxMhpgLjN8dm9YKsZnbJF/Ro3NTOtOgz6GJan4IpaOD/YGZJ1g9+S+oui8MtBK
 JhzB7r84KYPo+fRq0v5EnfwvXmCvHx11zU19M4eQDrfQ4swfS3WbW4/S+X7Wal3VqnqN
 JElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y7HBLwS7yJ8wmCRvvf7HPtdLby4aL5gss8oRmv4MR7c=;
 fh=WdaknPyNCYJcC8HEIuHQlaRyU/3At76OIQk3DvKUd4o=;
 b=YsPnSRHnfJet7rBuNwztpWKIQ0I3JW0iqiyR+EPR55GNB4uoYu/TtQxYvttvTWYOaO
 is+McMlUxOz/sDdN/Bnlscbo6S687CGdb0tr7XmEhpYiMCndgUXioPNOzSxhNOU9Lvsu
 mJGJ+40wlHXkmW8AbVIALehh5OFZZy5nZ6u6Axfm+/qDClCwkt0zIvmWkwq0Cz9db8FU
 TnTBM+A6SzkaQ6nip1qCfFrv4Kn9X0KdqB7KL/c66vppUOPALguQHapQJByqIb4g1gC3
 5cLdMwI6nfIQYzf1eh2WuWdyYJITW643NHloluEWa35pSzht3NRDGsrmxWo6aosriJTB
 dA3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791898317; x=1792503117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y7HBLwS7yJ8wmCRvvf7HPtdLby4aL5gss8oRmv4MR7c=;
 b=UmLt/b0elpi1gVrrokZuay1nGIXIKmzl4taEVB3vRMt43anBH3N7GHaeLFWkyCNxaA
 n3lAVdBF0DyccuG82MbNrO+kh/aHZSl9SaV0CAwDHLScbWqT44EvS4/AC9+gDK8ds61F
 1MKeGpcS3f+5Trutxem7dv9Xcb+dYfSKQ6R9jc74gbM5BSqzg+ubGGQD9haJMzxz5Vzn
 UfHJkvINOQ4sO35EC7Ihg3wj5Z6SsdhZdcQtVXkZsdd8n5bdF/MkHa+gZ6m9Sb8c/RtY
 uksRP9aDXjgEEHzU0hjOar6FVaVvBNI8UoDdRjPeab2fvdKWDYpQWKVnuk1cmNu2AU2a
 qLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791898317; x=1792503117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y7HBLwS7yJ8wmCRvvf7HPtdLby4aL5gss8oRmv4MR7c=;
 b=WuT/hgnbvzEjPx9LG7AnWhA0xw3UCEZatNu0QHqzeDVuUvs0OB+jBuMZ+3x3NK7CXh
 udx0ll4mc8LpGzAvCcCzo8lgORhxsRN91Nln9wTRRo5TqaxetVHReclfvKfZ1hwEC+tG
 B6jitEdaI+Oiq3q7Y/fc9OmnzVvhyAj22GIiUzULskZdL8kvqgeEYiGlF20aPhp1li4g
 Dd/7BFffdd96/o5hEaRgbpTbtxe8T04GfX5NcaIPHUIRI91xP0yUjJYFgJ2dWYUg9w9l
 R9TUOqilzh8MbaaD7saCgVOMf3fiq9TUA7Cc/puKCrtphQIQOw3Gmut/Y8eQzO+C8UXx
 qw7g==
X-Gm-Message-State: AFq9FYKgD8y/P0zMIYbboOUvioOurJkKxbdtwRLOHR68h1hrMJ5/6wdE
 JAEr1NUVyZBS5nlB4uY4UoCB7ROZJ/zzPFoNh7Lsm7IxCIzg+4SCwXTrmbBuS2awGEpy91/OW0v
 LDJECj54stdS3O6hKNd+oR16g98o3G0r7LfHkHa0=
X-Gm-Gg: AYBFou2+5EJbbmzcDWuR1k7/+YNTZrqwP1RhqFAbsvJQf4H/VJXgLb4tjbZRp6tK4Ch
 RBE2eGFMJLbM+AwM55Cr6AOXHrdXoAPR+wrJYpHmx1Bc50+QCmop2yto4idPrxT9L8soDCX0YLR
 TYJnNOdL93UchwsGfeDTLU/iM1N5I7Y4T8b3U3yJB1GK1SD3h4LDZTXyIdn76MBotTBIyI75mY2
 xthsCB0fcLIjD1KnzxIysmNzYGO2pwZTA4bmYGd0KQPhtaHzV49zYGaIdTu5aWBEVB0LJx/cWzh
 bneWN6gGO0iSLd/dGkpc2IN5JT4kbpI6N6VVICiGvLzySQYiuUwUUCeSN74Lvg+tzRECJOEolor
 7mlCgMHoJ7/JheXuoxnpPqQ==
X-Received: by 2002:a05:690c:397:b0:8a9:9a2e:e33c with SMTP id
 00721157ae682-8b07ede3f88mr40575587b3.91.1791898317475; Tue, 13 Oct 2026
 06:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-7-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-7-2b21e63974f3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:31:41 +0400
X-Gm-Features: AclHuK8Cnf-G9Va6AZGNY6r1ZZXLnnIksw884eaM6pr2qLn7dtcGAT47uSrfCjk
Message-ID: <CAJ+F1C+NLd2Nzmg1eLnH1La2yA1vw8dm7nEb2k93tcUCK4LzrA@mail.gmail.com>
Subject: Re: [PATCH 7/9] igvm: release found memory region on success
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Sun, Sep 6, 2026 at 12:55=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Not only in error paths must the mrs.mr be released.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

ping

>  backends/igvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 7b7bdc72b75b..784a56504e77 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -236,9 +236,9 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_=
t addr, uint64_t size,
>              return NULL;
>          }
>
> +        memory_region_unref(mrs.mr);
>          gpa_region_size =3D int128_make64(size);
>          if (int128_lt(mrs.size, gpa_region_size)) {
> -            memory_region_unref(mrs.mr);
>              error_setg(
>                  errp,
>                  "Processing of IGVM file failed: Could not prepare memor=
y "
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

