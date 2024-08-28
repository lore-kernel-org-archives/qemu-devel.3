Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A626C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHyj-0000oX-MW; Wed, 28 Aug 2024 08:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjHyh-0000fL-CU
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjHyf-0003wr-79
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724848844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uc9V6Z9gsEBagLDtoMdvf9aNrKWRZsqunldE/a+zhwg=;
 b=KTM+kYXQDKtbWjC9AbRav/qxGmDP/vQl7Yr0JkfZUenTlY2JCe/6PwDIoOactGBfjjL8hl
 W7xkFjfi50Fo5TpDyOJojKuz3x2VMAI4RM6LRX186e7dzrubWDlYQBJblOXIwjSInNxZYK
 2UHat+3mGltWsQOg6WJenJ//rTbC8W8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-HLyzrCXZNxKTEMMn9Ayayw-1; Wed, 28 Aug 2024 08:40:40 -0400
X-MC-Unique: HLyzrCXZNxKTEMMn9Ayayw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7cd849a6077so5750326a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 05:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724848840; x=1725453640;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uc9V6Z9gsEBagLDtoMdvf9aNrKWRZsqunldE/a+zhwg=;
 b=OpsCu4fSat9S3w/l58y2bgw1B++Ba+K/8yLH7ky2sbIU9hYfugEHwJMvEkkoV+deh6
 liL/R/A88oXtLKPgvR4CgEr1wPQs2ag0DYsAg+s7/kzkMhI5wz8lidOjK2wZq86zxRov
 f26G9RdG/S1lejiw71rZaGUhNGo31WAAI4flaIoPt9BrtJFhHljnl0VSfWk1Bmeawboy
 WCpmBCUfEi/Cs6wk0eULG/gdOqT7QHWM8dhGOikgTCqGGxHzWyc2fgn2e6eUiEvTJw1k
 Xb/WLdZ3PQPiA1Y6uUucu10y90qoBqdWZLIuJERhvyewfLn6vdJhxoRA3vy1uzY8LNYR
 sK5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUauqFR6j+4qonT9bFxcb854qK96FRq+AZZrRzpn8C+ricCiyVAKLKprbUwJHmw0zCwsdR81OPR6X54@nongnu.org
X-Gm-Message-State: AOJu0YyyyoHnHYW4xFePe3TPcG2Rtx6gIKvptPW2YwJkmdPQ3sqFuXVA
 URuqr255529wRbcJyG+2lrSLZiWYIMNqQIcjomZTZfPip28iP+QVehuZ1muwcW4Ep6KDt2kZXty
 4ho0qcpLmoZpg/DEWxMm6LdB+sfYIJzIaEbyevWsKeXf9VhvKhPvS
X-Received: by 2002:a05:6a20:cf90:b0:1c6:fb2a:4696 with SMTP id
 adf61e73a8af0-1cc89d6bac4mr16366394637.19.1724848839913; 
 Wed, 28 Aug 2024 05:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2OkywfwyMS5jMSJTc/hbRwLB1qeRez6eb9hJnBZAq/ieouxWUiQeqH6pzUCsYQoGaTa9WeQ==
X-Received: by 2002:a05:6a20:cf90:b0:1c6:fb2a:4696 with SMTP id
 adf61e73a8af0-1cc89d6bac4mr16366374637.19.1724848839471; 
 Wed, 28 Aug 2024 05:40:39 -0700 (PDT)
Received: from smtpclient.apple ([115.96.157.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385566490sm98202755ad.38.2024.08.28.05.40.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2024 05:40:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v5 1/2] kvm: replace fprintf with error_report()/printf()
 in kvm_init()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87ikvkriw3.fsf@pond.sub.org>
Date: Wed, 28 Aug 2024 18:10:24 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E66A6507-F348-49F9-8887-1CE24A5827EF@redhat.com>
References: <20240828075630.7754-1-anisinha@redhat.com>
 <20240828075630.7754-2-anisinha@redhat.com> <87ikvkriw3.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 28 Aug 2024, at 4:53=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> error_report() is more appropriate for error situations. Replace =
fprintf with
>> error_report() and error_printf() as appropriate. Cosmetic. No =
functional
>> change.
>=20
> Uh, I missed this last time around: the change is more than just
> cosmetics!  The error messages change, e.g. from
>=20
>    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
>    qemu-system-x86_64: --accel kvm: Could not access KVM kernel =
module: Permission denied
>    qemu-system-x86_64: --accel kvm: failed to initialize kvm: =
Permission denied
>=20
> to
>=20
>    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
>    Could not access KVM kernel module: Permission denied
>    qemu-system-x86_64: --accel kvm: failed to initialize kvm: =
Permission denied

You got this backwards. This is what I have:

Before:
$ ./qemu-system-x86_64 --accel kvm
Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: --accel kvm: failed to initialize kvm: No such file =
or directory

Now:
$ ./qemu-system-x86_64 --accel kvm
qemu-system-x86_64: --accel kvm: Could not access KVM kernel module: No =
such file or directory
qemu-system-x86_64: --accel kvm: failed to initialize kvm: No such file =
or directory


>=20
> Note: the second message is from kvm_init()'s caller.  Reporting the
> same error twice is wrong, but not this patch's problem.
>=20
> Moreover, the patch tweaks an error message at [*].
>=20
> Suggest something like
>=20
>  Replace fprintf() with error_report() and error_printf() where
>  appropriate.  Error messages improve, e.g. from
>=20
>      Could not access KVM kernel module: Permission denied
>=20
>  to
>=20
>      qemu-system-x86_64: --accel kvm: Could not access KVM kernel =
module: Permission denied

Yes this seems correct.

>=20
>> CC: qemu-trivial@nongnu.org
>> CC: zhao1.liu@intel.com
>> CC: armbru@redhat.com
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>> 1 file changed, 18 insertions(+), 22 deletions(-)
>>=20
>> changelog:
>> v2: fix a bug.
>> v3: replace one instance of error_report() with error_printf(). added =
tags.
>> v4: changes suggested by Markus.
>> v5: more changes from Markus's comments on v4.
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 75d11a07b2..fcc157f0e6 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>>     QLIST_INIT(&s->kvm_parked_vcpus);
>>     s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>>     if (s->fd =3D=3D -1) {
>> -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
>> +        error_report("Could not access KVM kernel module: %m");
>>         ret =3D -errno;
>>         goto err;
>>     }
>> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>>         if (ret >=3D 0) {
>>             ret =3D -EINVAL;
>>         }
>> -        fprintf(stderr, "kvm version too old\n");
>> +        error_report("kvm version too old");
>>         goto err;
>>     }
>>=20
>>     if (ret > KVM_API_VERSION) {
>>         ret =3D -EINVAL;
>> -        fprintf(stderr, "kvm version not supported\n");
>> +        error_report("kvm version not supported");
>>         goto err;
>>     }
>>=20
>> @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>>     } while (ret =3D=3D -EINTR);
>>=20
>>     if (ret < 0) {
>> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", =
-ret,
>> -                strerror(-ret));
>> +        error_report("ioctl(KVM_CREATE_VM) failed: %s", =
strerror(-ret));
>=20
> [*] This is where you change an error message.
>=20
>>=20
>> #ifdef TARGET_S390X
>>         if (ret =3D=3D -EINVAL) {
>> -            fprintf(stderr,
>> -                    "Host kernel setup problem detected. Please =
verify:\n");
>> -            fprintf(stderr, "- for kernels supporting the =
switch_amode or"
>> -                    " user_mode parameters, whether\n");
>> -            fprintf(stderr,
>> -                    "  user space is running in primary address =
space\n");
>> -            fprintf(stderr,
>> -                    "- for kernels supporting the vm.allocate_pgste =
sysctl, "
>> -                    "whether it is enabled\n");
>> +            error_printf("Host kernel setup problem detected."
>> +                         " Please verify:\n");
>> +            error_printf("- for kernels supporting the"
>> +                        " switch_amode or user_mode parameters, =
whether");
>> +            error_printf(" user space is running in primary address =
space\n");
>> +            error_printf("- for kernels supporting the =
vm.allocate_pgste"
>> +                         " sysctl, whether it is enabled\n");
>>         }
>> #elif defined(TARGET_PPC)
>>         if (ret =3D=3D -EINVAL) {
>> -            fprintf(stderr,
>> -                    "PPC KVM module is not loaded. Try modprobe =
kvm_%s.\n",
>> -                    (type =3D=3D 2) ? "pr" : "hv");
>> +            error_printf("PPC KVM module is not loaded. Try modprobe =
kvm_%s.\n",
>> +                         (type =3D=3D 2) ? "pr" : "hv");
>>         }
>> #endif
>>         goto err;
>> @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
>>                         nc->name, nc->num, soft_vcpus_limit);
>>=20
>>             if (nc->num > hard_vcpus_limit) {
>> -                fprintf(stderr, "Number of %s cpus requested (%d) =
exceeds "
>> -                        "the maximum cpus supported by KVM (%d)\n",
>> -                        nc->name, nc->num, hard_vcpus_limit);
>> +                error_report("Number of %s cpus requested (%d) =
exceeds "
>> +                             "the maximum cpus supported by KVM =
(%d)",
>> +                             nc->name, nc->num, hard_vcpus_limit);
>>                 exit(1);
>>             }
>>         }
>> @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>>     }
>>     if (missing_cap) {
>>         ret =3D -EINVAL;
>> -        fprintf(stderr, "kvm does not support %s\n%s",
>> -                missing_cap->name, upgrade_note);
>> +        error_report("kvm does not support %s", missing_cap->name);
>> +        error_printf("%s", upgrade_note);
>>         goto err;
>>     }
>=20
> With the commit message corrected:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>



