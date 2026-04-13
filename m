Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8C8F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCFz7-0000AP-9Q; Mon, 13 Apr 2026 08:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCFyw-000078-0x
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:01:34 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCFys-0005lc-Fr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:01:32 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651bc8f864fso712795d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776081689; cv=none;
 d=google.com; s=arc-20240605;
 b=EuOw0jhLJEHHL1zyWi6atHgKtNfv3KoG69HYRx2fYNKIJb82jfub1aKEldQMFo2z8a
 GxslLYFBY8VVxp+Ucgd9Oi+KjZl6jDmvJn0js5AihVnx2i3EZpqb95T/hxpL+1jgGQ9i
 qB36t8KDbjtrJPddpaSIHLcXNKb067s9FtDn+nN7bC3MAV7hXgwnInzyp/O/qIaO+Hpw
 HEhULeSrIMU/Pr/WowR/mrURcEdmgxDk8Qzd2s9rDhNrzC+vPThDZ+bxlKPTiMtIounV
 LWdE39deRJRQv47tNUGTPTMzB2G8pQBMgHKTI7jmhaKMBJaMS25rbHCYwduC5dN1L+IP
 /GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
 fh=4CeLI+GdcZXeyr0Pf2AGol/gPKPkqBOXdXINghNu4gQ=;
 b=Az+q1YsF4Vza0d9nyMxzkKE1o8EJ92yaIOLd1vMEsyJzsnlFhbeE88ZtEqfOaJP3Oa
 KFrQ7ucMAgnNGh9QqG1kBpZYm4ujS1+Z63lckBZ3ABvx5gIxT2xRbd10OGS5v4z/QyCt
 IYCYuIRuTxbRMAOa3/EZlt6UAvcLaHk25n6bVC395tyLWYJlzeIWX9FbeEqHht2pxcPz
 X4I+Gf232O/1E3b1ewebR2BD5zo+ek7NPPgMhxzkZ40shP+BiyhUqvLsvw0PAzH+n48B
 v25HVPC8wmLNR+apPAAuFmGur12R874HNu7h2aGj+C4ghSAt79zYfYxSnRBawHm+ApLj
 O3Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776081689; x=1776686489; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
 b=V019sk8m/+Y1B5u/LFoHozA1MwQXOIN8rgKjOFPjoMiFPBHaTY9ndtLMQh5zKTavoC
 iTtTRe+Cjm0jRPiadeEWWWY4rg11HtjuWAedjiyrqJ4TNMhSeE4YfvcHqcFsCnPBwfLI
 H59c8h9t3IByyE4C4GGGkEqy6buOTLr0MZ1JkN4TsdW0by9H7+J24wtXRi6wWp19sIK2
 yqgunnu1nOx5iRSY5sBbLKYUujNEF5zccIdgIr/geq7OxH0bk8HdXQiNlJKCF75QpOXQ
 ILVWAPthvJh9w+/ljwn7ZftKvyjp5OFP8zauRf3lImXCbGV2pWlvTNLA8NY/7uXZ9bo3
 O4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776081689; x=1776686489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg4fpig85e9+P7TZRqwVS3sXGmsWpc/MTnaSigaxjmI=;
 b=hku9o7kTh70iyzFhnBSjk3F7N6mp/EqULgCWf09oSeAscBLEKrPyzKk4lUDNf5gtyy
 /IfamTr3OKAz6sIBYMNm/RMJz20x373nXOvjgznL5GQXgIvhjK7zU4Tv0yDTrTnUv/Lw
 X5yLWZW/yDQL5vSIK+YnRA552hi4UZ+2Rjl5eXqebJbQT+gCfU78fFT3LiPOE2qlJKvH
 pwUt0vNIgxVdQpxoM/i21UBnAzBVoOFcQHt309XSujkCl3YJhOSsehwSa8Qhp9b+icyc
 xqShHO8oFomqOFHJN8FViO9oMk2cIzmIVSKsMigdd8B2/nsx3gv/WhfLVeqWF6GZMiW4
 RDAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EOws9Dx4+ybKP+VTKDFzZqFbJ6Xtc872hRM7VBGKk5uSHkqMrrJB+GsQL1BZxj/r8uyE/iR0kS3vi@nongnu.org
X-Gm-Message-State: AOJu0YwrZqcHhlUPoMW585Qz2UB3i3CorPtUUxY6g+Zw7RkOCUGlf/FT
 Eg5Z1tJzwXjYD+0SI8kU9mED2okTaDsdCd+ioU8LOOmHhmVxqheg0ecjNpiRVtMh+AGgz4BKgoZ
 wxbTKLxOYbgQ4A2CHgN/IK+qZNzkNWkiIRirFLsJ7zQ==
X-Gm-Gg: AeBDietvS4fEuU2O+LZekePIKkgNY7H0c9unkt5S/LuxvBjKAzDFQu13dR1x/QaMIWB
 kZx9QA0mnjZZo6uQAvocdDqTbnAbXspRwqKx/JEtunTv/onOn3jaDWIFYheSBFdncF8p3RDLwsz
 1o5WjNgElNjFY+2gdu9tChRdvRJUSsGbl+nDiirA/iJ5xY7acsAXv0sX3DrL3DiPk7+K4lKB3P1
 9cWaYZ0gfVm8nx8B1VMKZnq4DiM0hu7aoof+7OAHtog3YfkZsSH7y997ygR6UtCdJPoOymYINeH
 lXJtFQOUI1Mx6DGOB/Ko6sqUHUjdp4U/BGVOum+aL3woroBwvO8tSWVSaQHjhMVsx7CYS4/AeWW
 Trw==
X-Received: by 2002:a53:c946:0:b0:64e:d95a:c89e with SMTP id
 956f58d0204a3-65198b72cb0mr10328423d50.41.1776081688070; Mon, 13 Apr 2026
 05:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
In-Reply-To: <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:01:14 +0100
X-Gm-Features: AQROBzB6Oyv06TxOpxsHTGPZS_Pb6Ys_6ks3UaFd50xNIqUWB6VUhjVDXJYsvBQ
Message-ID: <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Misbah Anjum N <misanjum@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 13 Apr 2026 at 12:37, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
>
>
> On 13/04/26 4:51 pm, Ani Sinha wrote:
> > During refactoring of kvm_irqchip_create(), the refactored code was returning
> > early from do_kvm_irqchip_create() function if the required capabilities were
> > not present in KVM. This was not translating to an early return from
> > kvm_irqchip_create() as was the case before refactoring. This is because,
> > do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> > of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> > EOPNOTSUPP error when required capabilities are absent and then the caller
> > can check the return code and return early.
> >
> > Converted some calls to exit() to assertion checks in order to make it cleaner.
> >
> > Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> > Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> > Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> > Suggested-by: Fabiano Rosas <farosas@suse.de>
> > Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
> >   1 file changed, 16 insertions(+), 13 deletions(-)
> >
> > changelog:
> > v2: converted some exit() calls to assertions.
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 774499d34f..c78bf6a56f 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
> >       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> >   }
> >
> > -static void do_kvm_irqchip_create(KVMState *s)
> > +static int do_kvm_irqchip_create(KVMState *s)
> >   {
> >       int ret;
> >       if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> > @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState *s)
> >               exit(1);
> >           }
> >       } else {
> > -        return;
> > +        /*
> > +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
> > +         * present. Bail.
> > +         */
> > +        return -EOPNOTSUPP;
> >       }
> >
> > -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> > -        fprintf(stderr, "kvm: irqfd not implemented\n");
> > -        exit(1);
> > -    }
> > +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>
> again changing behaviour ?
> previously it was doing exit(1) on returning non-zero.
> Now, it will assert on returning zero ?
> May be split the patch to keep the exit -> assert changes separate ?

I think for 11.0 it's probably best to do the minimum necessary
change to fix the logic error introduced by 98884e0cc1. For
that I think the v1 of this patch is OK.

There do seem to be some cleanup opportunities that we
have here, but we can do those in 11.1.

-- PMM

