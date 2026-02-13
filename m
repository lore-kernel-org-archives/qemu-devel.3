Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BEEEF48D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmre-0004NQ-M9; Fri, 13 Feb 2026 01:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqmrZ-0004Mr-BK
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqmrV-000130-AD
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 01:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770964867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICkz2I2+7nS58wlFL1VxbYknJR0IOdnxsbWhFfX640k=;
 b=heKcpAuKLu0rqj/x+LYvkrwtZaG/jL+K5BXtc6+rX3RGW0oHVY12bc6/OfFBBrtK4QBGxU
 RsSKkzwo63b1svpgGR9wCImebE066yZpnufMl5zfH3eau6eJTi23WDuWuow3J9kzz0RPDM
 vpLnKxN8tYlcxP+pb9kVUN824lR3hjI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-owLskUrBO2mD7OIX1leHWQ-1; Fri, 13 Feb 2026 01:41:06 -0500
X-MC-Unique: owLskUrBO2mD7OIX1leHWQ-1
X-Mimecast-MFC-AGG-ID: owLskUrBO2mD7OIX1leHWQ_1770964865
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88fcbe2e351so89370636d6.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 22:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770964865; cv=none;
 d=google.com; s=arc-20240605;
 b=dZ/DsE8CP4PucRmwKY9ZwVShlMkTZ2BUFsCons7R68ig8HfVjeyWGbRfCDOmhp3sbR
 w9f0Filml4zqXkMLSv33S2Nljy5O4DSIdiRM3w3FMNIHim3cODIEccx/8GuPp+Y/W0ij
 sXTQeW9r574KNr1MBg0j4uZuQEYhssKtJSp/Tf+I1b3Gm8CXamzv5eaMeh9HwMqmyAQv
 08+emgzbEHNlzWUqKCFHxUjyBHaGffYKFxcuGe/fLXQFnw+nXAOVPDfhq+AeVjw9ZJK3
 9cXcRgISDWt6DgkRfQ2RmNMX0qhIXu97i53aKjEa4YOGztEsn8YI0uejJiBNq/ifyb9P
 rclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ICkz2I2+7nS58wlFL1VxbYknJR0IOdnxsbWhFfX640k=;
 fh=WyDWYkqeA2Xdad0b478+7jKRhK1+GzKZQr8SMT8E00k=;
 b=R7Cvsg57Jso8asjLRfSYWNBhIwS8sWnvRWsqNYsYuBBqy9kW8aSGIxg+zKnGCwG7LJ
 wE5KZQLQKK0y7WPwl/JoH+YG4PDG96mHv7qQpcPuAyjK6BHDj+4owDJTTLNPk8h2aUTE
 wRSohIri+t6jVoESaE40JOWwZTQy7ZTKQ2DK0rI8b2rSH+31FpfwOt1QKsI0hWmwtIuP
 g3edosk+C/sefAdz7bOreytEFNM2BwRzuiUvuHHIEs+HUdh6vR4/G3zujlgCux8pv3F0
 dUEql/U2UfsbDqB8CQkilfwyHClpQSlOppkSzPIDZyIKWZXkmjrw7WHzhTrf1nRFljWD
 cVAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770964865; x=1771569665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICkz2I2+7nS58wlFL1VxbYknJR0IOdnxsbWhFfX640k=;
 b=txp9Gc8igeuVX69ukBKKQ8RHvckEoQiIce7Y3NMzby3nweK0LJEWhsttqPtHcM01rB
 OKLNoTzqo1bBfkDtU4dmA4OMX4EGZD5xAwFCY4O8+BKlQ0nvpKwUJPNMIWGF+l4zt4Oy
 eK+p+H/1/uy65iZ/e+pnqKiqWApI/ay8OI1BxOieKPEv6kNEjrmlkGYJTd5oQBneCyt8
 m1Lpl15oBUA1kTl0LQJzUPC1SwTd5tTS320gCIYEebDu3M23JvivgE+lmE2w2LNkSVGt
 W/IbzdPYDhVWULeoRORJrP+8jwlsy3wV63QKmveoVchHzV5pzLlZ4F1Yjmk9I7Y+t8cr
 RDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770964865; x=1771569665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICkz2I2+7nS58wlFL1VxbYknJR0IOdnxsbWhFfX640k=;
 b=eviclNbPRuagi+ejDbxD1OCjdwpyr9qm0ykdiGkMMkFQ/1Lax5Jq7EMbFcxUvWsa5A
 DIqdhjvSu9vyy2YQmGroYHgjUX6U9G4h4hncVySNrg6gOqJEa63Fwq3RDGt2+RROdUQQ
 DlngDq8bL5ek9AuPvCsVITuFvPRLcVpJ4KImpeKkALv48/welvsS63rSb5OPmboedChf
 bqkscsulD+ENB5Lo39yWnfwGqa+uFR0clzVkiZQrbwxjVE6g9ca5tZCTfqS4ZQ+SzpJz
 XO8Wfxwv94Wg/ANmIly6o3/VAHN7sN5Q67XYek+XL9+TvOLHhE6ujJPcqdLsbo3Dif+z
 1lOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0IrxX4PZiXjcIzw1gGBcK8eX0lwXz4xfUzRKkVUNlekDITJkiiShOJBUUKNXtrE9N77G2v3BVuOIM@nongnu.org
X-Gm-Message-State: AOJu0Yw1I4qu7l+LRPmpRbZHSkJY/tiBJc1faYCGmgKUDFEpoMyYsktF
 thqcpmZF2nBO4Sbrp/TtdtfNqv1NFAHZmYTCEf50n0L5yEKuPgIedXA5dqhyWSiHYZdXSU5CtXp
 65LpnHwzgN8yqFXe4/JM2OaJu+6rnsXYInk90VtT83zna3bHm/5UFo4B+7eAE/Xy5P5BktmgdhX
 LWdHT5BRpOlU6ZVpMEGDTO9b6BRvBKjys=
X-Gm-Gg: AZuq6aLZLdoHtW8PPxjnYJfEU1b5OTLXHoL/lIphCVZsxMEYTT4H7Qjgr3JYppNHUPP
 K2h6jEMGt8Pxn5Z35kLvqhsTCe167zIPAVmFUdjhrvHG2ZotujXn54sn1sICu11NkbM8I7C88Er
 igdu9WHsi4aLnJw8wEDSqt6WDsGWJRilX37PyjuS0ArGWhc2WLHMIrLsUICsLh1jyiLXGb/AS9J
 Co4kgU8HBflxddrNtddh0WPIkciPpK6khZGnPI=
X-Received: by 2002:a05:6214:c28:b0:88a:2ed6:252 with SMTP id
 6a1803df08f44-897360dc89dmr10364046d6.5.1770964865416; 
 Thu, 12 Feb 2026 22:41:05 -0800 (PST)
X-Received: by 2002:a05:6214:c28:b0:88a:2ed6:252 with SMTP id
 6a1803df08f44-897360dc89dmr10363876d6.5.1770964865006; Thu, 12 Feb 2026
 22:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-4-anisinha@redhat.com>
 <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
In-Reply-To: <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 13 Feb 2026 12:10:54 +0530
X-Gm-Features: AZwV_QgS-VFjUN-UUl7-AJRwkqo51x6a2ZSyWL2dFGaXTsCrDvl31C-6zzZ4xEM
Message-ID: <CAK3XEhOh1m2Mu1LKMYQjHfF9Yiu8Dj2uWoeF8wNq3wK7v06AiQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kraxel@redhat.com, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 12, 2026 at 10:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Ani,
>
> On 12/2/26 07:24, Ani Sinha wrote:
> > When a confidential virtual machine is reset, a new guest context in th=
e
> > accelerator must be generated post reset. Therefore, the old accelerato=
r guest
> > file handle must be closed and a new one created. To this end, a per-ac=
celerator
> > callback, "reset_vmfd" is introduced that would get called when a confi=
dential
> > guest is reset. Subsequent patches will introduce specific implementati=
on of
> > this callback for KVM accelerator.
> >
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   include/accel/accel-ops.h |  1 +
> >   system/runstate.c         | 37 ++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
> > index 23a8c246e1..998a95ca69 100644
> > --- a/include/accel/accel-ops.h
> > +++ b/include/accel/accel-ops.h
> > @@ -23,6 +23,7 @@ struct AccelClass {
> >       AccelOpsClass *ops;
> >
> >       int (*init_machine)(AccelState *as, MachineState *ms);
> > +    int (*reset_vmfd)(MachineState *ms);
>
> So far 'vmfd' is a KVM concept. Can we use a more generic name?
>
> Please add a @docstring description for this handler.
>
> >       bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
> >       void (*cpu_common_unrealize)(CPUState *cpu);
> >       /* get_stats: Append statistics to @buf */
> > diff --git a/system/runstate.c b/system/runstate.c
> > index 5d58260ed5..0a74e3ade5 100644
> > --- a/system/runstate.c
> > +++ b/system/runstate.c
> > @@ -42,6 +42,7 @@
> >   #include "qapi/qapi-commands-run-state.h"
> >   #include "qapi/qapi-events-run-state.h"
> >   #include "qemu/accel.h"
> > +#include "accel/accel-ops.h"
> >   #include "qemu/error-report.h"
> >   #include "qemu/job.h"
> >   #include "qemu/log.h"
> > @@ -509,6 +510,9 @@ void qemu_system_reset(ShutdownCause reason)
> >   {
> >       MachineClass *mc;
> >       ResetType type;
> > +    AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
> > +    bool vmfd_reset =3D false;
> > +    int ret;
> >
> >       mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : NUL=
L;
> >
> > @@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
> >       default:
> >           type =3D RESET_TYPE_COLD;
> >       }
> > +
> > +    /*
> > +     * different accelerators implement how to close the old file hand=
le of
> > +     * the accelerator descriptor and create a new one here. Resetting
> > +     * file handle is necessary to create a new confidential VM contex=
t post
> > +     * VM reset.
> > +     */
> > +    if (!cpus_are_resettable() &&
> > +        (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
> > +         reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
> > +        if (ac->reset_vmfd) {
> > +            ret =3D ac->reset_vmfd(current_machine);
> > +            if (ret < 0) {
> > +                error_report("unable to reset vmfd: %s(%d)",
> > +                             strerror(-ret), ret);
> > +                vm_stop(RUN_STATE_INTERNAL_ERROR);
> > +            }
> > +            vmfd_reset =3D true;
>
> If we need a such flag, please rename it generically.
>
> > +        } else {
> > +            error_report("accelerator does not support reset");
> > +        }
> > +    }
> > +
> >       if (mc && mc->reset) {
> >           mc->reset(current_machine, type);
> >       } else {
> > @@ -543,7 +570,15 @@ void qemu_system_reset(ShutdownCause reason)
> >        * it does _more_  than cpu_synchronize_all_post_reset().
> >        */
> >       if (cpus_are_resettable()) {
> > -        cpu_synchronize_all_post_reset();
> > +        if (vmfd_reset) {
> > +            /*
> > +             * If vmfd has changed, then vcpufds have also changed.
> > +             * Need to sync full cpu state for non confidential guests=
.
> > +             */
> > +            cpu_synchronize_all_post_init();
>
> Calling post_init() in reset() is dubious. It might work with KVM by
> chance (because only KVM implements .reset_vmfd), but by design I
> don't expect it to work on other accelerators. If you really think
> this is the only solution, then you'll need to document cpu_sync*
> methods very carefully.
>
> > +        } else {
> > +            cpu_synchronize_all_post_reset();
> > +        }
> >       }
> >
> >       vm_set_suspended(false);
>
> Isn't the confidential_guest_kvm_reset() API more appropriate here?

This above hunk I did, calling post_init() to do a full
put_registers() etc is required only for non-coco case in KVM after
CPU reset when we are enabling vm file descriptor change. In the coco
case, the call is a noop as the guest state is protected.
This part I am not very familiar with and used my best judgement. To
address your concern that other accelerators might implement
reset_vmfd() but does not like to call
cpu_synchronize_all_post_init(), we can wrap it inside another
accelerator callback like ac->cpu_synchronize_all_post_vmfd_change()
or some such.

Paolo has some context as I was debugging this area with his help. I
am curious also for his inputs on this.


