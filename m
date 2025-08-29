Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C35ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNm7-0005qK-OE; Sat, 30 Aug 2025 11:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us8AE-000716-IJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 19:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us8AC-00037l-6W
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 19:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756508741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8Gj6u+1Z5wWJiY80gUAAmNwK1Ecd1e8/1mbSVIaQ34=;
 b=NI3lGCPM2t3ta/J/mn80GxNmiIDmrCFxIOprh3h8lvReBaI1jOHMWSm4YDR7bod0wMEmmV
 Oz7CE8pVX2fSHbixDOWUQuYmleF2RMNqHhGNZXMlhGDT7KAYAQKrk+rjssuvuuABWiUcq8
 U7aU6A0oJXIFdedqh5NauI0aVyGM2rs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-8NxjAR8kN46F61aYqAhvMQ-1; Fri, 29 Aug 2025 19:05:39 -0400
X-MC-Unique: 8NxjAR8kN46F61aYqAhvMQ-1
X-Mimecast-MFC-AGG-ID: 8NxjAR8kN46F61aYqAhvMQ_1756508738
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7c4c738cso9021295e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 16:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756508738; x=1757113538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8Gj6u+1Z5wWJiY80gUAAmNwK1Ecd1e8/1mbSVIaQ34=;
 b=neMeYp0CSyzu4XAOjrjjlMlYhJvO8+hlWmRiCg+ATsVRttSHRkVfhkMIQZeanZOXHz
 9faYyh7csaPFPsqUkjHPtC90+qUZkRSZN8NR3zqJmvD8t9+UO6C4b/5vppKpEMGjIe6H
 HRwzyOrvyf/Q3JdT93Qr7yvzdxdsPd02v0sVfxb5+FE71gSdElQ6q+Gsewa2lyoflqNG
 p5USDlVDOglfLBr/VqW6zV3P477d/x7ckYOj73M79CVBHJANfaeNMQCSqNQbyFDJdHgY
 k99/nzqTa2jjOWneDSO4wbMeSD7xCwR6tA7zgMsgIhNgUJwF/1YSjlB2f91m2tsUjGKP
 v/cw==
X-Gm-Message-State: AOJu0Yzcgu9ld4OHYNmEy88lauJ2Uy5eDiO5TQxE5iTs6EWNA4YggQ3F
 +okxusDSL/49t8TwJ8MlrHR4kLwntuAxO+CCmDVo4OgLeiwr6FcuIaWhNfsH0Wwy/byaMNEM7yc
 ehwLdnkLowG8DF+/AQ+vxZMyhpgB3RhK6jOZpqUW/cxbBnRdHpbYkLZduCCZdBo61K5Nx4mEcso
 XmEnpSX8pubyP4XhGcqyHOUtu4ttzY6LY=
X-Gm-Gg: ASbGnctSB0Nnf/2tZF/SZzo7mVrww92aDTedj9/fZ9QCq3wHDeQ74JTSQfOHIsSse1/
 oUNDKuhnOVRzqa89Bqv7egFYDd/1L+qqeSbdJRGJxOC1CQU4ATid7vvJUUdQpWnvMQZZPloNbY4
 ZDkqUEnspXuedYFcYkGQtRSzthVvR/AfwFMb97GdRUR+PWIB802ghD+/NmY1jKJFcPswxxJTO8z
 ELGeDNgYv7GboICPUGhx4Zh
X-Received: by 2002:a05:600c:4e44:b0:45b:80e4:4e1a with SMTP id
 5b1f17b1804b1-45b855fe92bmr1435445e9.26.1756508738343; 
 Fri, 29 Aug 2025 16:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0lvddpu22SiW+zancsM2D7PFxpDflnwYA+VjcKvjbebB4qRKrKm4PnyWGHqBth4cP8dzh9JwNQ6J/vYwASKI=
X-Received: by 2002:a05:600c:4e44:b0:45b:80e4:4e1a with SMTP id
 5b1f17b1804b1-45b855fe92bmr1435345e9.26.1756508737951; Fri, 29 Aug 2025
 16:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-10-pbonzini@redhat.com>
 <743782b5-1e3b-4b63-afe2-4ad1da333bde@linaro.org>
In-Reply-To: <743782b5-1e3b-4b63-afe2-4ad1da333bde@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Aug 2025 01:05:26 +0200
X-Gm-Features: Ac12FXziBEbSp4doToMPMSU9vWu_NcaGvEsAHPIDrYTfFpF-biLMcaHynincEv0
Message-ID: <CABgObfYG=Aaz2ujr4xeuKgUqM35tF_2nS-W+v6bjYQJ4xMsvRg@mail.gmail.com>
Subject: Re: [PATCH 14/18] cpus: properly kick CPUs out of inner execution loop
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, imammedo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 29, 2025 at 11:57=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/30/25 01:31, Paolo Bonzini wrote:
> > @@ -624,8 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
> >       }
> >
> >       cs->exception_index =3D EXCP_YIELD;
> > -    qatomic_set(&cs->exit_request, true);
> > -    cpu_loop_exit(cs);
> > +    cpu_exit(cs);
> >
> >       return H_SUCCESS;
> >   }
>
> cpu_loop_exit does a longjmp; cpu_exit does not.
>
> This may be a bug fix, but it's hard to tell.
> If it is a bug fix, it should be separated.

The longjmp is overkill but works. Not doing the longjmp also works
because gen_sc() finishes the TB and then you go all the way (check
interrupt_request -> check exit_request -> write exception_index ->
cpu_exec_end) out of tcg_cpu_exec().

I like cpu_loop_exit() to signify that I am in the middle of the TB.
That said, I'm always conflicted between renaming badly-named
functions and keeping historical names. qemu_wait_io_event() is also
horrible.

> > +++ b/system/cpu-timers.c
> > @@ -246,14 +246,14 @@ void qemu_timer_notify_cb(void *opaque, QEMUClock=
Type type)
> >
> >      if (qemu_in_vcpu_thread()) {
> >          /*
> > -         * A CPU is currently running; kick it back out to the
> > +         * A CPU is currently running; kick it back out of the
> >           * tcg_cpu_exec() loop so it will recalculate its
> >           * icount deadline immediately.
> >           */
> > -        qemu_cpu_kick(current_cpu);
> > +        cpu_exit(current_cpu);
>
> where the comment still says kick and we're replacing kick with exit.
>
> I guess the root of this problem is that "kick" isn't a precise term, we =
ought to name it
> something else, and we should paint the bike shed green.

Yes, I agree. "send it out of" can work too in this case, I'll chanbge it.

Paolo


